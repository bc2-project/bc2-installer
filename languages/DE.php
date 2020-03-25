<?php
global $LANG;
$LANG = array(
    'Admin account' => 'Adminkonto',
    'advanced' => 'Experten',
    'Choose which modules to install' => 'Erweiterungen zur Installation auswählen',
    'Connection' => 'Verbindung',
    'Create your super user (global administrator) account' => 'Globales Administrator-Konto erstellen',
    'Database' => 'Datenbank',
    'Database connection settings' => 'Verbindungs-Einstellungen für die Datenbank',
    'Installation folder' => 'Installationsverzeichnis',
    'Installation progress' => 'Installationsfortschritt',
    'Installation result' => 'Ergebnis der Installation',
    'Mode' => 'Modus',
    'Modules' => 'Erweiterungen',
    'Next' => 'Weiter',
    'No' => 'Nein',
    'Path' => 'Pfad',
    'Result' => 'Ergebnis',
    'See a summary before you start the installation' => 'Zusammenfassung vor dem Start der Installation',
    'simple' => 'Einfacher',
    'Summary' => 'Zusammenfassung',
    'Yes' => 'Ja',
    'You are in' => 'Sie sind im',

    // ----- precheck -----
    'Installation data' => 'Installationsdateien',
    'Actual' => 'Vorhanden',
    'Check' => 'Prüfung',
    'Please note' => 'Bitte beachten',
    'Proceed anyway' => 'Trotzdem fortfahren',
    'Suggestion' => 'Empfehlung',
    'Sorry, but we encountered some issue(s) that will inhibit the installation.' => 'Leider wurde mindestens ein Problem festgestellt, das eine Installation verhindert.',
    'Before you proceed, please take the following suggestions into account.' => 'Bevor Sie fortfahren, lesen Sie bitte die folgenden Empfehlungen.',
    'If you need help, please <a href="">visit our forum</a>.' => 'Wenn Sie Hilfe benötigen, <a href="">besuchen Sie bitte unser Forum</a>.',
    'Please check the results below and fix the issue(s) listed there.' => 'Bitte untenstehende Hinweise prüfen und nach Möglichkeit beheben.',
    'Pre-installation check(s) failed!' => 'Vor-Installations-Prüfungen sind fehlgeschlagen!',

    // ----- step: globals -----
    'Engine / Installation path' => 'Engine- / Installations-Verzeichnis',
    'Example: /abs/path/to/cat_engine' => 'Beispiel: /abs/path/to/cat_engine',
    'First site folder name' => 'Verzeichnisname der ersten Site',
    'First site path' => 'Verzeichnis für die erste Seite',
    'If you leave this blank, the site data will be placed directly into the "First site path" entered above. If you enter a folder name, the installation will place the data into &lt;First site path&gt;/&lt;Folder name&gt;.'
        => 'Wird dieses Feld leer gelassen, wird die Site direkt in das Verzeichnis unter "Verzeichnis für die erste Seite" entpackt. Wird ein Verzeichnisname angegeben, werden die Daten nach &lt;Verzeichnis für die erste Seite&gt;/&lt;Verzeichnisname&gt; entpackt.',
    'Please note: You are not asked to input an URL or Website title here, as BlackCat CMS is able to support several sites with only one installation. You will create your first site after the installation.'
        => 'Hinweis: Hier wird nicht nach einer URL oder einem Webseiten-Titel gefragt, da BlackCat CMS mehrere Sites (=Webauftritte) mit nur einer Installation erstellen kann. Die erste Site wird nach der Installation erstellt.',
    'Require SSL for the Admin Panel' => 'SSL für den Administrationsbereich erzwingen',
    'This is the installation folder of the CMS (=the directory where BlackCat CMS will be <strong>installed</strong>). Please use an absolute path here. This <strong>can</strong> and <strong>should</strong> be outside your public WWW folder.'
        => 'Der absolute Pfad des Verzeichnisses, in dem BlackCat CMS <strong>installiert</strong> wird. <strong>Kann</strong> und <strong>sollte</strong> ausserhalb des öffentlichen WWW Verzeichnisses liegen.',
    'This is the target folder of the first site. Please use an absolute path here. This <strong>must</strong> be <strong>inside</strong> your public WWW folder.'
        => 'Der absolute Pfad des Verzeichnisses, in dem die erste Site erstellt werden soll. Muss <strong>innerhalb</strong> des öffentlichen WWW Verzeichnisses liegen.',
    'The installer has detected that SSL (=https) seems to be available on this host. We recommend to require it for backend access. This means that the login page will switch to https automatically.' => 'Der Installer hat festgestellt, daß auf diesem Server SSL (=https) verfügbar ist. Wir empfehlen, die Nutzung für das Backend zu erzwingen. Das heißt, die Login-Seite wird automatisch auf https umschalten.',

    // ----- step: database settings -----
    'All settings on this page can be changed in the admin backend later!' => 'Alle Einstellungen auf dieser Seite können später im Admin Backend wieder geändert werden!',
    'Admin user' => 'Administratorkonto',
    'An admin user that is allowed to create tables.' => 'Kennung eines Benutzers, der das Recht hat, Tabellen anzulegen.',
    'Database name' => 'Name der Datenbank',
    'eMail address' => 'eMail Adresse',
    'Example: cat' => 'Beispiel: cat',
    'Example: dbuser123' => 'Beispiel: dbuser123',
    "Leave this as-is if you don't know what it is for. If you're using USBWebserver (Portable), set this to 3307." => 'Belassen Sie die Vorgabe, wenn Sie nicht sicher sind. Wenn Sie den USBWebserver (Portable) verwenden, ändern Sie den Wert auf 3307.',
    'Password' => 'Kennwort',
    'Please enter a valid database name.' => 'Bitte einen gültigen Datenbanknamen angeben',
    'Please enter a database user name.' => 'Bitte die Datenbank-Benutzerkennung angeben',
    'Please enter a database password.' => 'Bitte das Datenbank-Kennwort angeben',
    'Table prefix' => 'Tabellen-Präfix',
    'If you need to set a different database port (different from default port 3306) or table prefix (default will be "bc2_"), please <a href="%%url%%?advanced&proceed">restart the installer in Expert mode</a>.'
        => 'Wenn Sie einen vom Standard abweichenden Datenbank-Port (Standard: 3306) oder ein individuelles Tabellenpräfix (Standard: "bc2_") einstellen möchten, <a href="%%url%%?advanced&proceed">starten Sie den Installer bitte im Experten-Modus neu</a>.',
    'The database to be used must already be installed, and you must have a database admin user and password. If you are unsure what these terms mean you should probably contact your hosting provider.'
        => 'Die Datenbank muss bereits existieren, und Sie brauchen eine Benutzerkennung und ein Kennwort für diese Datenbank. Wenn Sie nicht sicher sind, was das bedeutet, sollten Sie sich mit Ihrem Provider in Verbindung setzen.',
    'The IP Address / host name where the database is available.' => 'IP Adresse / Servername, unter der/dem die Datenbank erreichbar ist.',
    'The name of the database where the tables are created.' => 'Der Name der Datenbank, in der die Tabellen erzeugt werden.',
    'The password of the admin user you entered above.' => 'Das Kennwort des Benutzers, den Sie oben angegeben haben.',
    'The prefix will be used to distinguish the BlackCat CMS table names from other tables that may already exist in the database.' => 'Das Präfix wird verwendet, um die BlackCat CMS Tabellen von anderen Tabellen zu trennen, die möglicherweise bereits in der Datenbank existieren.',

    // ----- step: admin account -----
    'Please choose a username for the admin user' => 'Bitte eine Benutzerkennung für das Adminkonto wählen',
    'Please enter a password.' => 'Bitte ein Kennwort angeben.',
    'Please enter a valid eMail address' => 'Bitte eine gültige Mailadresse eintragen',
    'Please repeat the password.' => 'Bitte das Kennwort wiederholen.',
    'Please repeat the password. This will avoid lock-outs if you mistyped your password.' => 'Bitte das Kennwort wiederholen. Das verhindert, daß Sie sich aussperren, falls Sie sich vertippt haben.',
    'Repeat password' => 'Kennwort wiederholen',
    'The eMail address will not be posted anywhere, but you may need it if you forget your login credentials.' => 'Die eMail Adresse wird nirgendwo hin gesendet, wenn Sie aber mal Ihr Kennwort vergessen haben, brauchen Sie sie, um ein neues Kennwort anzufordern.',
    'The password of the admin user you entered above. A good password should be at least 8 characters long and contain upper-/lowercase letters, digits, and special characters.' => 'Das Kennwort für das obige Administratorkonto. Ein gutes Kennwort sollte mindestens 8 Zeichen lang sein und Groß-/Kleinbuchstaben, Ziffern, sowie Sonderzeichen beinhalten.',
    "You may use your eMail address here if you wish. You should avoid to use login names that are easy to guess, like 'admin' or 'root'." => 'Sie können hier auch Ihre eMail Adresse verwenden. Vermeiden Sie möglichst Benutzernamen, die leicht zu erraten sind, wie "admin" oder "root".',

    // ----- step: modules -----
    'More modules and templates (skins) can be added later. Necessary modules cannot be excluded.' => 'Weitere Module und Templates (Skins) können später hinzugefügt werden. Notwendige Module können nicht ausgeschlossen werden.',
    'No modules in list, please make sure you have a catalog.json in the data-folder!' => 'Keine Module in der Liste, bitte sicherstellen, dass im data-Verzeichnis eine catalog.json Datei existiert!',

    // ----- step: summary -----
    'Please check your settings before you start the installation.' => 'Bitte überprüfen Sie Ihre Einstellungen, bevor Sie die Installation starten.',
    // ----- Variables -----
    'admin_username' => 'Name des Administrators',
    'admin_password' => 'Kennwort des Administrators',
    'admin_email' => 'Mailadresse des Administrators',
    'db_hostname' => 'Datenbank-Server',
    'db_port' => 'Port',
    'db_name' => 'Name der Datenbank',
    'db_username' => 'Datenbank-Benutzer',
    'db_password' => 'Datenbank-Kennwort',
    'db_prefix' => 'Prefix für Datenbank-Tabellen',
    'path' => 'Installationspfad',
    'sitename' => 'Name der ersten Seite',
    'sitepath' => 'Verzeichnis der ersten Seite',

    // ----- step: installation -----
    'Error extracting engine: ' => 'Fehler beim Entpacken der Engine: ',
    'Error extracting site: ' => 'Fehler beim Entpacken der Seite: ',
    'Error installing tables: ' => 'Fehler beim Anlegen der Tabellen: ',
    'Error importing data: ' => 'Fehler beim Import der Daten: ',
    'Congratulations! You\'ve managed to install BlackCat CMS!' => 'Herzlichen Glückwunsch! Sie haben BlackCat CMS erfolgreich installiert!',
    'Installation in progress, please wait...' => 'Installation läuft, bitte warten...',
    'Sorry, the installation seems to have failed. Please see the error message(s) below.'
        => 'Entschuldigung, aber die Installation ist offenbar fehlgeschlagen. Bitte prüfen Sie die folgenden Fehlermeldung(en).',
    'The maximum wait time is exceeded. This is *not* necessarily an error.'
        => 'Die maximale Wartezeit wurde überschritten. Das ist *nicht* zwangsläufig ein Fehler.',

);