<?php

/**
 *   @author          Black Cat Development
 *   @copyright       2013 - 2018 Black Cat Development
 *   @link            https://blackcat-cms.org
 *   @license         http://www.gnu.org/licenses/gpl.html
 *   @category        CAT_Core
 *   @package         CAT_Core
 **/

namespace CAT;

class Installer
{
    /**
     * for testing only!
     **/
    protected $no_engine = false;
    protected $prereqs = array(
        'phpversion'  => '7.2',
        'phpsettings' => array(
            'register_globals' => 0,
    		'safe_mode'        => 0,
        ),
    );
    protected $suggested = array(
        'phpversion' => '7.2',
    );
    protected $installdata = array(
        'config.txt',
        'db.txt',
        'import.sql',
        'site.zip',
        'tables.sql',
    );
    protected $steps = array(
        'simple'   => array('path','database','admin_account','summary','installation'),
        'advanced' => array('path','database','admin_account','modules','summary','installation'),
    );
    protected $step_info = array(
        'path'          => 'Installation folder',
        'database'      => 'Database connection settings',
        'admin_account' => 'Create your super user (global administrator) account',
        'proxy'         => 'Optional proxy settings',
        'modules'       => 'Choose which modules to install',
        'summary'       => 'See a summary before you start the installation',
        'installation'  => 'Installation progress',
    );
    protected $data = array(
        'ssl_available'    => false,
        'db_port'          => '3306',
        'db_prefix'        => 'bc2_',
    );
    protected $tpldir   = __dir__.'/../templates';
    protected $langdir  = __dir__.'/../languages';
    protected $logdir   = __dir__.'/../logs';
    protected $datadir  = __dir__.'/../data';
    protected $lang     = 'de';
    protected $mode     = 'simple';
    protected $step     = 0;
    protected $current  = '';
    protected $errors   = array();
    protected $warnings = array();
    protected $catalog  = array();
    protected $answers  = array();

    protected $logh     = null;

    public function __construct()
    {
        // Installer URL
        $host   = $_SERVER['HTTP_HOST'];
        $uri    = rtrim(dirname($_SERVER['SCRIPT_NAME']), '/\\');
        $scheme = (isset($_SERVER['HTTPS']) ? 'https' : 'http');
        define('BASE_URL',$scheme.'://'.$host.$uri);

        // Engine path suggestion
        if(!isset($this->data['path'])) {
            $this->data['path']     = dirname(realpath($_SERVER['DOCUMENT_ROOT']));
            $this->data['sitepath'] = realpath($_SERVER['DOCUMENT_ROOT']);
        }

        $this->data['error_path_exists'] = false;

        $this->preInstCheck();
        if(count($this->errors)>0 || (count($this->warnings)>0 && !isset($_REQUEST['proceed']))) {
            $this->printPage($this->tpldir.'/precheck.phtml');
            exit;
        }

        // answer file
        if(file_exists(__dir__.'/../data/answer.php')) {
            require __dir__.'/../data/answer.php';
            $this->answers = $defaults;
        }
    }

    /**
     * used to poll for installation progress
     **/
    public function checkProgress()
    {
        if(!headers_sent()) {
            header('Content-type: application/json');
        }

        $workdir = str_replace('\\','/',realpath(__DIR__));

        if(!file_exists($this->logdir.'/.progress')) {
            if(file_exists($this->logdir.'/.error')) {
                $fh = fopen($this->logdir.'/.error','r');
                $data = fread($fh, filesize($this->logdir.'/.error'));
                fclose($fh);
                echo json_encode(array(
                    'message' => $data,
                    'running' => false,
                    'success' => false
                ),true);
                exit;
            }
            if(file_exists($this->logdir.'/.done')) {
                echo json_encode(array(
                    'message' => $this->t('Congratulations! You\'ve managed to install BlackCat CMS!'),
                    'running' => false,
                    'success' => true
                ),true);
                exit;
            }
            echo json_encode(array(
                'message' => $this->t('Unknown installation status. Found no status files.'),
                'running' => false,
                'success' => false
            ),true);
            exit;
        } else {
            $fh = fopen($this->logdir.'/.progress','r');
            $data = fread($fh, filesize($this->logdir.'/.progress'));
            fclose($fh);
            echo json_encode(array(
                'message' => $data,
                'running' => true
            ),true);
        }
        exit;
    }

    /**
     * do installation
     **/
    public function install($data) {

        // combine data with defaults
        $data    = array_merge($this->data,$data);
        $workdir = str_replace('\\','/',realpath(__DIR__));

        // modules
        $modules = array();
        // always install
        foreach($this->catalog['modules'] as $i => $m) {
            if(isset($m['required']) && $m['required'] == 'Y') {
                $modules[] = $m;
            }
        }
        // selected
        foreach($_REQUEST as $key => $item) {
            if(substr_compare($key,'modlist_',0,8)==0) {
                foreach($this->catalog['modules'] as $i => $m) {
                    if($m['name']==$item) {
                        $modules[] = $m;
                    }
                }
            }
        }

        // remove old logs
// !!!!! TODO: rename instead of unlink !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        @unlink($this->logdir.'/.progress');
        @unlink($this->logdir.'/.done');
        @unlink($this->logdir.'/.error');
        @unlink($this->logdir.'/.composer');

        // start logging
        $this->log('Installation started');

        if(!headers_sent()) {
            header('Content-type: application/json');
        }

        // ----- check database connection -----
        try {
            $dsn = "mysql:host=".$data['db_hostname'].":".$data['db_port'].";dbname=".$data['db_name'].";";
            $this->log('trying to connect to '.$dsn);
            $dbh = new \PDO($dsn, $data['db_username'], $data['db_password']);
        } catch ( \PDOException $e) {
            echo json_encode(array(
                'message' => $this->t('Database connection failed:') . ' ' . $e->getMessage(),
                'success' => false
            ));
            exit;
        } finally {
            // ----- disconnect from browser session -----
            ob_end_clean();
            header("Connection: close");
            ignore_user_abort(true); // just to be safe
            ob_start();
            header('Content-type: application/json');
            echo json_encode(array(
                'message' => $this->t('Installation in progress... '),
                'success' => true
            ));
            $size = ob_get_length();
            header("Content-Length: $size");
            ob_end_flush(); // Strange behaviour, will not work
            flush();        // Unless both are called !
        }
        $this->log('...done');

        $za = new \ZipArchive;

        // ----- install engine and dependencies -----
        if(!file_exists($data['path'])) {
            mkdir($data['path'],0770);
        }
        copy($workdir.'/composer.json',$data['path'].'/composer.json');
#$data['run_composer']='N';
        // ----- install dependencies -----
        if(isset($data['run_composer']) && $data['run_composer']=='N') {
            $this->log('Composer auto-run is disabled');
        } else {
            $this->log('Running Composer - this may take a while!');
            error_reporting(E_ALL);
            ini_set('display_errors', 1);
            // https://getcomposer.org/doc/articles/troubleshooting.md#memory-limit-errors
            ini_set('memory_limit', '-1');
            // 600 seconds = 10 minutes
            set_time_limit(600);
            ini_set('max_execution_time', 600);
            //set_time_limit(-1);
            // needs COMPOSER_HOME environment variable set
            putenv('COMPOSER_HOME='.__DIR__.'/vendor/bin/composer');
            // Improve performance when the xdebug extension is enabled
            putenv('COMPOSER_DISABLE_XDEBUG_WARN=1');
            try {
                require_once 'phar://' . str_replace('\\', '/', __DIR__) . '/composer.phar/src/bootstrap.php';
                chdir($data['path']);

                $params = array(
                    'command' => 'install',
                    #'--no-dev' => true,
                    #'--optimize-autoloader' => true,
                    '--no-autoloader' => true,
                    '--no-suggest' => true,
                    '--no-interaction' => true,
                    '--no-progress' => true,
                    '--verbose' => true,
                );
                $input = new \Symfony\Component\Console\Input\ArrayInput($params);
                $output = new \Symfony\Component\Console\Output\StreamOutput(fopen($this->logdir.'/.composer', 'a', false));
                $application = new \Composer\Console\Application();
                $application->setAutoExit(false);
                $code = $application->run($input, $output);
                $this->log("composer install exit code: $code");

                // 0: OK
                // 1: Generic/unknown error code
                // 2: Dependency solving error code
                if(0 !== intval($code)) {
                    $this->fatal('Error running composer (command: install): '.($code==1?'Generic/unknown error':'Dependency solving error'));
                }

            } catch (Exception $ex) {
                $this->log($ex->getMessage());
            }

            $this->log('Checking vendor dir ['.$data['path'].'/cat_engine/CAT/vendor]');

            // check result - vendor folder filled?
            if(!file_exists($data['path'].'/cat_engine/CAT/vendor')) {
                $this->fatal('Missing vendor directory');
            } else {
                $this->log('vendor dir exists');

                // move from "wrong" vendor dir
                @mkdir($data['path'].'/cat_engine/CAT/vendor/composer',0770);
                @copy($data['path'].'/vendor/composer/installed.json',$data['path'].'/cat_engine/CAT/vendor/composer/installed.json');
                chdir($data['path'].'/cat_engine/CAT');

                $params = array(
                    'command' => 'dumpautoload',
                    '--optimize' => true,
                    '--verbose' => true,
                    '--working-dir' => $data['path'].'/cat_engine/CAT',
                    '--no-plugins' => true,
                );
                $input = new \Symfony\Component\Console\Input\ArrayInput($params);
                $output = new \Symfony\Component\Console\Output\StreamOutput(fopen($this->logdir.'/.composer', 'a', false));
                $application = new \Composer\Console\Application();
                $application->setAutoExit(false);
                $code = $application->run($input, $output);
                $this->log("composer dumpautoload exit code: $code");

                // 0: OK
                // 1: Generic/unknown error code
                // 2: Dependency solving error code
                if(0 !== intval($code)) {
                    $this->fatal('Error running composer (command: dumpautoload): '.($code==1?'Generic/unknown error':'Dependency solving error'));
                }
            }

            $this->log('Checking autoload.php');
            if(!file_exists($data['path'].'/cat_engine/CAT/vendor/autoload.php')) {
                $this->fatal('Error running composer, missing autoload.php!');
            } else {
                $this->log('autoload.php exists');
                putenv('COMPOSER_HOME=' . $data['path'] . '/vendor/bin/composer');
            }
        }

        // ----- download modules -----
        $this->log('register autoloader');
        $this->registerAutoloader($data['path'].'/cat_engine',$data['path'].'/cat_engine/modules');
        $this->log('...done');

        $this->log('require base classes');
        require_once $data['path'].'/cat_engine/CAT/Base.php';
        require_once $data['path'].'/cat_engine/CAT/Helper/GitHub.php';

        $tempdir = $data['path'].'/cat_engine/temp';
        if(!file_exists($tempdir)) {
            $this->log('creating temp folder');
            @mkdir($tempdir,0770);
        } else {
            $this->log('temp folder already exists');
        }

        foreach($modules as $item) {
            $zipfile = $tempdir.'/'.$item['github']['organization'].'_'.$item['github']['repository'].'.zip';
            if(!file_exists($zipfile)) {
                $this->log('trying to download module '.$item['name']);
                if($item['github']['master']=='Y') {
                    $this->log(sprintf("trying to download master.zip for [%s] organisation [%s] repository [%s]",$item['name'],$item['github']['organization'],$item['github']['repository']));
                    \CAT\Helper\GitHub::downloadMaster($item['github']['organization'],$item['github']['repository'],$tempdir);
                }
            } else {
                $this->log('zip file is already there: '.$zipfile);
            }
        }

        // ----- creating database -----

        // ----- install tables -----
        $this->log('Creating tables... ');
        $errors = $this->importSQL(__DIR__.'/../data/tables.sql',$dbh,$data['db_prefix']);
        if(is_array($errors) && count($errors)>0) {
            $this->fatal('Error installing tables: '."\n".implode('<br />'.$errors));
        }
        $this->log('...done');

        // ----- install data -----
        $this->log('Importing data... ');
        $errors = $this->importSQL(__DIR__.'/../data/import.sql',$dbh,$data['db_prefix']);
        if(is_array($errors) && count($errors)>0) {
            $this->fatal('Error importing data: '."\n".implode('<br />'.$errors));
        }
        $this->log('...done');

        // ----- generate default session name -----
        $prefix = rand();
        $default_session_name = strtoupper(md5(uniqid($prefix,true)));
        $dbh->query(sprintf(
            'INSERT IGNORE INTO `%ssettings_global` (`name`,`value`) VALUES ("session_name","%s")',
            $data['db_prefix'], $default_session_name
        ));

        // ----- admin account -----
        $this->log('Adding admin account... ');
        $_hashOpt        = array(
            'algo'    => \PASSWORD_BCRYPT,
            'cost'    => 10
        );
        $hash = password_hash($data['admin_password'], $_hashOpt['algo'], array('cost'=>$_hashOpt['cost']));
        $sql = sprintf(
               "INSERT INTO `%srbac_users` (`user_id`, `active`, `username`, `password`, `display_name`, `email`, `language`, `tfa_enabled`, `protected`, `wysiwyg`) VALUES "
    	     . "(1, 1, '".$data['admin_username']."', '".$hash."', 'Administrator', '".$data['admin_email']."', 'DE', 'N', 'Y', NULL);",
             $data['db_prefix']
        );
        $dbh->query($sql);
        $this->log('...done');

        // ----- unzip site -----
        $sitepath = $data['sitepath'];
        if(isset($data['sitename']) && strlen($data['sitename'])) {
            $sitepath .= '/'.$data['sitename'];
        }
        $sitepath = str_replace('\\','/',$sitepath);

        try {
            $this->log('Extracting site to folder ['.$sitepath.']');
            if ($za->open($workdir.'/../data/site.zip') === TRUE) {
                if($za->extractTo($sitepath) === TRUE) {
                    $this->log('...done');
                    $za->close();
                } else {
                    $this->log('Error extracting site: '.$za->errorInfo(true));
                    $za->close();
                    $this->fatal('Error extracting site');
                }
            }
        } catch ( Exception $e ) {
            $this->log('Error extracting site: '.$za->errorInfo(true));
            $this->fatal('Error extracting site');
        }

        // ----- add site to DB -----
        $this->log('Adding site to database... ');
        $sql = sprintf(
            "INSERT IGNORE INTO `%ssites` (`site_owner`, `site_basedir`, `site_folder`) VALUES (1, '".str_replace('\\','/',dirname($sitepath))."', '".$data['sitename']."');",
            $data['db_prefix']
        );
$this->log("$sql\n");
        $stmt = $dbh->query($sql);
        $this->log('...done');

        define('CAT_SITE_ID',1);

        // ----- install modules -----
        $this->log('Installing modules...');
        require_once $data['path'].'/cat_engine/CAT/Helper/Addons.php';
        if(!file_exists($data['path'].'/cat_engine/modules')) {
            @mkdir($data['path'].'/cat_engine/modules',0770);
        }
        if(!file_exists($data['path'].'/cat_engine/templates')) {
            @mkdir($data['path'].'/cat_engine/templates',0770);
        }
        foreach($modules as $item) {
$this->log(">>>>> ITEM: ".$item['name']);
if(in_array($item['name'], array('Dashboard','Socialmedia Link Manager','Visitor Statistics','Menu Manager'))) {
    $this->log('skipping '.$item['name']);
    continue;
}
            $this->log('trying to install module from zip '.$tempdir.'/'.$item['github']['organization'].'_'.$item['github']['repository'].'.zip');
            $result = \CAT\Helper\Addons::handleInstall(
                'zip',
                $tempdir.'/'.$item['github']['organization'].'_'.$item['github']['repository'].'.zip'
            );
$this->log('result ['.$result.']');
        }

        // ----- create config.php -----
        if(($handle = @fopen($workdir.'/../data/config.txt', 'r')) !== false) {
            $cfg = fread($handle, filesize($workdir.'/../data/config.txt'));
            fclose($handle);
            $out = fopen($sitepath.'/config.php','w');
            $cfg = str_ireplace(
                array('%%url%%','%%site_url%%','%%engine%%'),
                array('','',$data['path']),
                $cfg
            );
            fwrite($out,$cfg);
            fclose($out);
        }

        // ----- create database config file -----
        if(($handle = @fopen($workdir.'/../data/db.txt', 'r')) !== false) {
            $cfg = fread($handle, filesize($workdir.'/../data/db.txt'));
            fclose($handle);
            $filename = $this->createGUID().'bc.php';
            $out = fopen($data['path'].'/cat_engine/CAT/Helper/DB/'.$filename,'w');
            $cfg = str_ireplace(
                array('%%db_host%%','%%db_port%%','%%db_user%%','%%db_password%%','%%db_name%%','%%db_prefix%%'),
                array($data['db_hostname'],$data['db_port'],$data['db_username'],$data['db_password'],$data['db_name'],$data['db_prefix']),
                $cfg
            );
            fwrite($out,$cfg);
            fclose($out);
        }

        if(!empty($this->logh) && is_resource($this->logh)) {
            fclose($this->logh);
        }

        rename($this->logdir.'/.progress',$this->logdir.'/.done');
        $fh = fopen($this->logdir.'/.done','a');
        $this->log("finished: ".date('c'));
        fclose($fh);

    }

    public function show()
    {
        if(
            ( count($this->errors)>0 || (count($this->warnings)>0 )
            && !isset($_REQUEST['proceed']))
        ) {
            $page = $this->tpldir.'/welcome_'.$this->getLang().'.phtml';
            $this->data['ssl_available'] = $this->sslCheck();
        } else {
            $this->getModules();

            if(array_key_exists('checkprogress',$_REQUEST)) {
                $this->checkprogress();
                exit;
            }

            if(array_key_exists('install',$_REQUEST)) {
                $this->install($_REQUEST);
                exit;
            }

            if(array_key_exists('simple',$_REQUEST) || array_key_exists('advanced',$_REQUEST)) {
                $this->mode = (isset($_REQUEST['simple']) ? 'simple' : 'advanced');
                $this->current = $this->steps[$this->mode][0];
                $this->step = 0;
                $page = $this->tpldir.'/steps.phtml';
            } else {
                $page = $this->tpldir.'/welcome_'.$this->getLang().'.phtml';
            }
        }
        $this->printPage($page);
    }

    public function printPage($page)
    {
$data = array_merge($this->data,$this->answers);
$data = array_merge($data,$_REQUEST);

        // check if target dirs are empty
        if(is_dir($data['path'])) {
            if(!$this->isEmpty($data['path'])) {
                $this->data['error_path_exists'] = true;
            }
        }
        include $this->tpldir.'/header.phtml';
        include $page;
        include $this->tpldir.'/footer.phtml';
    }

    /**
     * 'translate' $message; requires language file located in 'languages' sub folder
     **/
    public function t($message,$replacements=array()) {
        if(!isset($LANG)) {
            if(file_exists($this->langdir.'/'.$this->lang.'.php')) {
                require $this->langdir.'/'.$this->lang.'.php';
            }
        }
        if(isset($LANG[$message])) {
            return str_ireplace(
                array_keys($replacements),
                array_values($replacements),
                $LANG[$message]
            );
        }
        return str_ireplace(
            array_keys($replacements),
            array_values($replacements),
            $message
        );
    }

    /**
     * Copy files recursive from source to destination
     *
     * @param string $source_directory
     * @param string $destination_directory
     * @throws \Exception
     * @return boolean
     */
    public function copyRecursive(
        string $source_directory,
        string $destination_directory
    ) {
        $this->log('copyRecursive ['.$source_directory.'] to ['.$destination_directory.']');
        if (is_dir($source_directory)) {
            $directory_handle = dir($source_directory);
        } else {
            return false;
        }
        if (!is_object($directory_handle)) {
            $this->log('unable to create directory handle for source dir!');
            return false;
        }

        while (false !== ($file = $directory_handle->read())) {
            if (($file == '.') || ($file == '..')) {
                continue;
            }
            $source = $source_directory.DIRECTORY_SEPARATOR.$file;
            $target = $destination_directory.DIRECTORY_SEPARATOR.$file;
            if (is_dir($source)) {
                // create directory in the target
                if (!file_exists($target) && (true !== @mkdir($target, 0755, true))) {
                    // get the reason why mkdir() fails
                    $error = error_get_last();
                    $this->log("Can't create directory $target, error message: {$error['message']}");
                }
                // set the datetime
                if (false === @touch($target, filemtime($source))) {
                    $this->log("Can't set the modification date/time for $target");
                }
                // recursive call
                $this->copyRecursive(
                    $source,
                    $target
                );
            } else {
                $target_path = pathinfo($target,PATHINFO_DIRNAME);
                if (!file_exists($target_path) && (true !== @mkdir($target_path, 0755, true))) {
                    // get the reason why mkdir() fails
                    $error = error_get_last();
                    $this->log("Can't create directory $target_path, error message: {$error['message']}");
                }
                // copy file to the target
                if (true !== @copy($source, $target)) {
                    $this->log("Can't copy file $source");
                }
                // set the datetime
                if (false === @touch($target, filemtime($source))) {
                    $this->log("Can't set the modification date/time for $file");
                }
            }
        }
        $directory_handle->close();
        return true;
    }

    protected function createGUID()
    {
        $prefix=rand();
        $s=strtoupper(md5(uniqid($prefix,true)));
        $guidText =
            substr($s,0,8) . '-' .
            substr($s,8,4) . '-' .
            substr($s,12,4). '-' .
            substr($s,16,4). '-' .
            substr($s,20);
        return $guidText;
    }   // end function createGUID()

    // find php.exe
    protected function execFinder(?array $extraDirs=array())
    {
        $dirs = array_merge(
            explode(PATH_SEPARATOR, getenv('PATH') ?: getenv('Path')),
            $extraDirs
        );
        $default_suffixes = ['.exe', '.bat', '.cmd', '.com'];
        $suffixes = [''];
        if ('\\' === \DIRECTORY_SEPARATOR) {
            $pathExt = getenv('PATHEXT');
            $suffixes = array_merge($pathExt ? explode(PATH_SEPARATOR, $pathExt) : $default_suffixes, $suffixes);
        }
        foreach ($suffixes as $suffix) {
            foreach ($dirs as $dir) {
                if (@is_file($file = $dir.\DIRECTORY_SEPARATOR.'php'.$suffix) && ('\\' === \DIRECTORY_SEPARATOR || @is_executable($file))) {
                    return $file;
                }
            }
        }
    }

    /**
     * get language(s) from browser
     */
    protected function getLang($strict_mode=true)
    {
        $browser_langs = array();
        $lang_variable = $_SERVER['HTTP_ACCEPT_LANGUAGE'];

        if (empty($lang_variable)) {
            return 'de';
        }

        $accepted_languages = preg_split('/,\s*/', $lang_variable);
        $current_q          = 0;

        foreach ($accepted_languages as $accepted_language) {
            // match valid language entries
            $res = preg_match('/^([a-z]{1,8}(?:-[a-z]{1,8})*)(?:;\s*q=(0(?:\.[0-9]{1,3})?|1(?:\.0{1,3})?))?$/i', $accepted_language, $matches);
            // invalid syntax
            if (!$res) {
                continue;
            }
            // get language code
            $lang_code = explode('-', $matches[1]);
            if (isset($matches[ 2 ])) {
                $lang_quality = (float)$matches[2];
            } else {
                $lang_quality = 1.0;
            }

            while (count($lang_code)) {
                $browser_langs[] = array(
                    'lang' => strtoupper(join('-', $lang_code)),
                    'qual' => $lang_quality
                );
                // don't use abbreviations in strict mode
                if ($strict_mode) {
                    break;
                }
                array_pop($lang_code);
            }
        }

        // order array by quality
        $langs = $this->sortarray($browser_langs, 'qual', 'desc', true);
        foreach ($langs as $lang) {
            $lang['lang'] = strtolower(str_replace('-', '_', $lang['lang']));
            if(file_exists($this->langdir.'/'.strtolower($lang['lang']).'.php')) {
                return $lang['lang'];
            }
        }

        return $this->lang;
    } // end function getLang()

    /**
     *
     * @access public
     * @return
     **/
    public function getModules()
    {
        $datafile = $this->datadir.'/catalog.json';
        if(file_exists($datafile)) {
            $string = file_get_contents($datafile);
            $this->catalog = json_decode($string, true);
            foreach($this->catalog['modules'] as $i => $m) {
                if (isset($m['description'][$this->lang]['title'])) {
                    $this->catalog['modules'][$i]['description'] = $m['description'][$this->lang]['title'];
                } elseif (isset($m['description']['en']['title'])) {
                    $this->catalog['modules'][$i]['description'] = $m['description']['en']['title'];
                } else {
                    $this->catalog['modules'][$i]['description'] = 'n/a';
                }
            }
        } else {
            $this->catalog = array();
        }
    }   // end function getModules()

    /**
     * split sql file and execute statements
     **/
    protected function importSQL($file,$database,$db_prefix) {
        $errors = array();
        $import = file_get_contents($file);

    #    $import = preg_replace( "%/\*(.*)\*/%Us", ''          , $import );
    #    $import = preg_replace( "%^--(.*)\n%mU" , ''          , $import );
    #    $import = preg_replace( "%^$\n%mU"      , ''          , $import );
        $import = str_ireplace( "%prefix%"      , $db_prefix  , $import );
        $import = preg_replace( "%\r?\n%"       , ''          , $import );
        $import = str_replace ( '\\\\r\\\\n'    , "\n"        , $import );
        $import = str_replace ( '\\\\n'         , "\n"        , $import );

        // split into chunks
        $sql = preg_split(
            '~(insert\s+(?:ignore\s+)into\s+|replace\s+into\s+|create\s+table|truncate\s+table|\/\*\!)~i',
            $import,
            -1,
            PREG_SPLIT_DELIM_CAPTURE|PREG_SPLIT_NO_EMPTY
        );

        if(!count($sql) || !count($sql)%2)
            return false;

        // index 1,3,5... is the matched delim, index 2,4,6... the remaining string
        $stmts = array();
        for($i=0;$i<count($sql);$i++)
            $stmts[] = $sql[$i] . $sql[++$i];

        foreach ($stmts as $imp){
            if ($imp != '' && $imp != ' ') {
            $fh = fopen(__DIR__.'/sql.log','a');
            fwrite($fh,$imp);
            fwrite($fh,"\n----- result: ". implode(" | ",$database->errorInfo())."-----\n");
            fwrite($fh,"\n----------------------------------------------------------------\n");
            fclose($fh);
                $ret = $database->exec($imp);
            }
        }
        return ( count($errors) ? false : true );
    }   // end function importSQL()

    protected function isEmpty($dir)
    {
        $handle = opendir($dir);
        while (false !== ($entry = readdir($handle))) {
            if ($entry != "." && $entry != "..") {
                closedir($handle);
                return false;
            }
        }
        closedir($handle);
        return true;
    }

    protected function fatal(string $msg)
    {
        $this->log('>>>>> ERROR <<<<< '.$msg);
        if(!empty($this->logh)) {
            fclose($this->logh);
        }
        $this->logh = fopen($this->logdir.'/.error','w');
        $this->log($msg);
        exit;
    }

    /**
     *
     * @access protected
     * @return
     **/
    protected function log(string $msg)
    {
        if(!is_resource($this->logh)) {
            $this->logh = fopen($this->logdir.'/.progress','w');
        }
        fwrite($this->logh, strftime('%F %T')." | $msg\n");
    }   // end function log()
    

    /**
     * the pre-installation checks
     **/
    protected function preInstCheck()
    {
        // PHP Version
        if(!version_compare(PHP_VERSION,$this->prereqs['phpversion'],'>=')) {
            $this->errors[] = array(
                'check'    => 'PHP-Version',
                'required' => $this->prereqs['phpversion'],
                'actual'   => PHP_VERSION
            );
        }
        if(!version_compare(PHP_VERSION,$this->suggested['phpversion'],">=")) {
            $this->warnings[] = array(
                'check'      => 'PHP-Version',
                'suggestion' => ( isset($suggestion_text['phpversion'][$lang]) ? $suggestion_text['phpversion'][$lang] : 'en'),
                'actual'     => PHP_VERSION
            );
        }
        // PHP Settings
        foreach($this->prereqs['phpsettings'] as $key => $value) {
            $actual_setting = ($temp=ini_get($key)) ? $temp : 0;
            if($actual_setting !== $value) {
                $this->errors[] = array(
                    'check'    => 'PHP-Settings -&gt; '.$key,
                    'required' => $value,
                    'actual'   => $actual_setting,
                );
            }
        }
        // Check if AddDefaultCharset is set
        $sapi  = php_sapi_name();
        if(strpos($sapi,'apache') !== false || strpos($sapi,'nsapi') !== false ) {
        	flush();
        	$apache_rheaders = apache_response_headers();
        	foreach($apache_rheaders as $h) {
        		if(strpos($h,'html; charset') !== false && (!strpos(strtolower($h),'utf-8')) ) {
        			preg_match( '/charset\s*=\s*([a-zA-Z0-9- _]+)/', $h, $match );
        			$apache_charset = $match[1];
        			$this->errors[] = array(
                        'check'    => 'Apache-Settings',
                        'required' => 'unset',
                        'actual'   => $apache_charset,
                    );
        		}
        	}
        }
        // check installer
        $seen = array();
        foreach($this->installdata as $file) {
            if(file_exists(__dir__.'/../data/'.$file)) {
                $seen[] = $file;
            }
        }
        if(count($seen)!=count($this->installdata)) {
            $this->errors[] = array(
                'check'    => $this->t('Installation data'),
                'required' => implode("<br />",$this->installdata),
                'actual'   => implode("<br />",$seen)
            );
        }

    }   // end function preInstCheck()

    /**
     *
     * @access protected
     * @return
     **/
    protected function registerAutoloader(string $engine_path,string $mod_folder)
    {
        define('CAT_ENGINE_PATH',$engine_path);
        define('CAT_PATH',$engine_path);
        define('CAT_MODULES_FOLDER','modules');
        define('CAT_TEMP_FOLDER',$engine_path.'/temp');
        define('CAT_TEMPLATES_FOLDER','templates');
        define('CAT_LANGUAGES_FOLDER','languages');

        $this->log('require '.CAT_ENGINE_PATH . '/CAT/vendor/autoload.php');

        if(!file_exists(CAT_ENGINE_PATH . '/CAT/vendor/autoload.php')) {
            $this->fatal('file ['.CAT_ENGINE_PATH . '/CAT/vendor/autoload.php] not found!');
        }

        // Composer autoloader
        try {
            require_once CAT_ENGINE_PATH . '/CAT/vendor/autoload.php';
            $this->log('...done');
        } catch ( \Exception $e ) {
            $this->fatal($e->getMessage());
        }

        //******************************************************************************
        // register autoloader
        //******************************************************************************
        spl_autoload_register(function ($class) {
            $this->log("spl_autoload_register class: $class");
            if (substr_compare($class, 'wblib', 0, 4)==0) { // wblib2 components
                $file = str_replace(
                    '\\',
                    '/',
                    \CAT\Helper\Directory::sanitizePath(
                        CAT_ENGINE_PATH.'/modules/lib_wblib/'.str_replace(
                            array('\\','_'),
                            array('/','/'),
                            $class
                        ).'.php'
                    )
                );
                $this->log("WBLIB FILE: $file");
                if (file_exists($file)) {
                    @require $file;
                }
            } else {
                $file = CAT_ENGINE_PATH.'/'.$class.'.php';
                if (class_exists('\CAT\Helper\Directory', false) && $class!='\CAT\Helper\Directory') {
                    $file = \CAT\Helper\Directory::sanitizePath($file);
                }
                $this->log("CAT FILE: $file");
                if (file_exists($file)) {
                    require_once $file;
                } else {
$this->log('no such file : '.$file);
                    // it may be a module class
                    if(substr_compare($class,'CAT\Addon',0,9) == 0) {
                        $temp = explode('\\',$class);
                        $dir  = $temp[2];
                        $file = CAT_ENGINE_PATH.'/modules/'.$dir.'/inc/'.pathinfo($file,PATHINFO_FILENAME).'.php';
                        if (class_exists('\CAT\Helper\Directory', false) && $class!='\CAT\Helper\Directory') {
                            $file = \CAT\Helper\Directory::sanitizePath($file);
                        }
                        if (file_exists($file)) {
                            require_once $file;
                        }
                    }
                }

            // next in stack
            }
        });
    }   // end function registerAutoloader()
    

    /**
     * sort array
     **/
    protected function sortarray($array, $index, $order='asc', $natsort=false, $case_sensitive=false)
    {
        if (is_array($array) && count($array)>0) {
            foreach (array_keys($array) as $key) {
                $temp[$key]=$array[$key][$index];
            }
            if (!$natsort) {
                ($order=='asc')? asort($temp) : arsort($temp);
            } else {
                ($case_sensitive)? natsort($temp) : natcasesort($temp);
                if ($order!='asc') {
                    $temp=array_reverse($temp, true);
                }
            }

            foreach (array_keys($temp) as $key) {
                (is_numeric($key))? $sorted[]=$array[$key] : $sorted[$key]=$array[$key];
            }
            return $sorted;
        }
        return $array;
    }   // end function sortarray()

    /**
     * check if ssl is available
     **/
    protected function sslCheck()
    {
        $ssl_port = '443'; // default
        if(
            isset($_SERVER['OPENSSL_CONF'])
            || isset($_SERVER['SSL_PROTOCOL'])
            || preg_match('~SSL~',$_SERVER['SERVER_SOFTWARE']))
        {
            try {
                $context = stream_context_create();
                stream_context_set_option($context, "ssl", "verify_peer", false);
                $SSL_Check = @stream_socket_client( 'ssl://'.$_SERVER['SERVER_NAME'].':'.$ssl_port, $errno, $errstr, ini_get("default_socket_timeout"), STREAM_CLIENT_CONNECT , $context);
                if (!$SSL_Check) {
                    return false;
                } else {
                    fclose($SSL_Check);
                    return true;
                }
            } catch( Exception $e ) {
                return false;
            }
        }
    }   // end function sslCheck()

}
