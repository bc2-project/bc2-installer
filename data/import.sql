/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Exportiere Daten aus Tabelle blackcat.%prefix%addons: ~15 rows (ungefähr)
/*!40000 ALTER TABLE `%prefix%addons` DISABLE KEYS */;
INSERT IGNORE INTO `%prefix%addons` (`addon_id`, `type`, `directory`, `name`, `installed`, `upgraded`, `removable`, `bundled`) VALUES
	(1, 'core', 'cat_engine', 'BlackCat CMS Engine', '%time%', '%time%', 'N', 'Y'),
	(2, 'language', 'DE', 'Deutsch', '%time%', '%time%', 'Y', 'Y'),
	(3, 'language', 'EN', 'English', '%time%', '%time%', 'Y', 'Y'),;
/*!40000 ALTER TABLE `%prefix%addons` ENABLE KEYS */;

-- Exportiere Daten aus Tabelle blackcat.%prefix%backend_areas: ~14 rows (ungefähr)
/*!40000 ALTER TABLE `%prefix%backend_areas` DISABLE KEYS */;
INSERT IGNORE INTO `%prefix%backend_areas` (`id`, `name`, `position`, `parent`, `level`, `controller`) VALUES
	(1, 'dashboard', 1, 0, 1, NULL),
	(3, 'media', 3, 0, 1, ''),
	(4, 'settings', 4, 24, 2, ''),
	(5, 'addons', 4, 0, 1, ''),
	(6, 'admintools', 4, 0, 1, ''),
	(7, 'users', 2, 24, 2, ''),
	(8, 'groups', 7, 10, 3, ''),
	(9, 'roles', 8, 10, 3, ''),
	(10, 'permissions', 3, 24, 2, ''),
	(24, 'administration', 5, 0, 1, ''),
	(25, 'pages', 1, 0, 1, NULL),
	(26, 'sites', 1, 24, 1, NULL),
	(28, 'socialmedia', 5, 24, 1, NULL),
	(29, 'menus', 6, 24, 1, NULL);
/*!40000 ALTER TABLE `%prefix%backend_areas` ENABLE KEYS */;

-- Exportiere Daten aus Tabelle blackcat.%prefix%charsets: ~41 rows (ungefähr)
/*!40000 ALTER TABLE `%prefix%charsets` DISABLE KEYS */;
INSERT IGNORE INTO `%prefix%charsets` (`name`, `labels`) VALUES
	('UTF-8', 'unicode-1-1-utf-8, utf-8, utf8'),
	('IBM866', '866, cp866, csibm866, ibm866'),
	('ISO-8859-2', 'csisolatin2, iso-8859-2, iso-ir-101, iso8859-2, iso88592, iso_8859-2, iso_8859-2:1987, l2, latin2'),
	('ISO-8859-3', 'csisolatin3, iso-8859-3, iso-ir-109, iso8859-3, iso88593, iso_8859-3, iso_8859-3:1988, l3, latin3'),
	('ISO-8859-4', 'csisolatin4, iso-8859-4, iso-ir-110, iso8859-4, iso88594, iso_8859-4, iso_8859-4:1988, l4, latin4'),
	('ISO-8859-5', 'csisolatincyrillic, cyrillic, iso-8859-5, iso-ir-144, iso8859-5, iso88595, iso_8859-5, iso_8859-5:1988'),
	('ISO-8859-6', 'arabic, asmo-708, csiso88596e, csiso88596i, csisolatinarabic, ecma-114, iso-8859-6, iso-8859-6-e, iso-8859-6-i, iso-ir-127, iso8859-6, iso88596, iso_8859-6, iso_8859-6:1987'),
	('ISO-8859-7', 'csisolatingreek, ecma-118, elot_928, greek, greek8, iso-8859-7, iso-ir-126, iso8859-7, iso88597, iso_8859-7, iso_8859-7:1987, sun_eu_greek'),
	('ISO-8859-8', 'csiso88598e, csisolatinhebrew, hebrew, iso-8859-8, iso-8859-8-e, iso-ir-138, iso8859-8, iso88598, iso_8859-8, iso_8859-8:1988, visual'),
	('ISO-8859-8-I', 'csiso88598i, iso-8859-8-i, logical'),
	('ISO-8859-10', 'csisolatin6, iso-8859-10, iso-ir-157, iso8859-10, iso885910, l6, latin6'),
	('ISO-8859-13', 'iso-8859-13, iso8859-13, iso885913'),
	('ISO-8859-14', 'iso-8859-14, iso8859-14, iso885914'),
	('ISO-8859-15', 'csisolatin9, iso-8859-15, iso8859-15, iso885915, iso_8859-15, l9'),
	('ISO-8859-16', 'iso-8859-16'),
	('KOI8-R', 'cskoi8r, koi, koi8, koi8-r, koi8_r'),
	('KOI8-U', 'koi8-ru, koi8-u'),
	('macintosh', 'csmacintosh, mac, macintosh, x-mac-roman'),
	('windows-874', 'dos-874, iso-8859-11, iso8859-11, iso885911, tis-620, windows-874'),
	('windows-1250', 'cp1250, windows-1250, x-cp1250'),
	('windows-1251', 'cp1251, windows-1251, x-cp1251'),
	('windows-1252', 'ansi_x3.4-1968, ascii, cp1252, cp819, csisolatin1, ibm819, iso-8859-1, iso-ir-100, iso8859-1, iso88591, iso_8859-1, iso_8859-1:1987, l1, latin1, us-ascii, windows-1252, x-cp1252'),
	('windows-1253', 'cp1253, windows-1253, x-cp1253'),
	('windows-1254', 'cp1254, csisolatin5, iso-8859-9, iso-ir-148, iso8859-9, iso88599, iso_8859-9, iso_8859-9:1989, l5, latin5, windows-1254, x-cp1254'),
	('windows-1255', 'cp1255, windows-1255, x-cp1255'),
	('windows-1256', 'cp1256, windows-1256, x-cp1256'),
	('windows-1257', 'cp1257, windows-1257, x-cp1257'),
	('windows-1258', 'cp1258, windows-1258, x-cp1258'),
	('x-mac-cyrillic', 'x-mac-cyrillic, x-mac-ukrainian'),
	('GBK', 'chinese, csgb2312, csiso58gb231280, gb2312, gb_2312, gb_2312-80, gbk, iso-ir-58, x-gbk'),
	('gb18030', 'gb18030'),
	('Big5', 'big5, big5-hkscs, cn-big5, csbig5, x-x-big5'),
	('EUC-JP', 'cseucpkdfmtjapanese, euc-jp, x-euc-jp'),
	('ISO-2022-JP', 'csiso2022jp, iso-2022-jp'),
	('Shift_JIS', 'csshiftjis, ms932, ms_kanji, shift-jis, shift_jis, sjis, windows-31j, x-sjis'),
	('EUC-KR', 'cseuckr, csksc56011987, euc-kr, iso-ir-149, korean, ks_c_5601-1987, ks_c_5601-1989, ksc5601, ksc_5601, windows-949'),
	('replacement', 'csiso2022kr, hz-gb-2312, iso-2022-cn, iso-2022-cn-ext, iso-2022-kr'),
	('UTF-16BE', 'utf-16be'),
	('UTF-16LE', 'utf-16, utf-16le'),
	('x-user-defined', 'x-user-defined'),
	('ISO-8859-1', 'ISO-8859-1');
/*!40000 ALTER TABLE `%prefix%charsets` ENABLE KEYS */;

-- Exportiere Daten aus Tabelle blackcat.%prefix%forms: ~6 rows (ungefähr)
/*!40000 ALTER TABLE `%prefix%forms` DISABLE KEYS */;
INSERT IGNORE INTO `%prefix%forms` (`form_id`, `form_name`, `action`, `defined_by`) VALUES
	(1, 'be_page_add', '/page/add', 1),
	(2, 'be_page_settings', '/page/settings', 1),
	(3, 'be_language_link', '/page/edit', 1),
	(4, 'menu_edit', '/tools/coreMenuAdmin/edit', 36),
	(5, 'be_site', '/site/add', 1),
	(6, 'be_addon_create', '/addons/create', 1);
/*!40000 ALTER TABLE `%prefix%forms` ENABLE KEYS */;

-- Exportiere Daten aus Tabelle blackcat.%prefix%forms_fielddefinitions: ~45 rows (ungefähr)
/*!40000 ALTER TABLE `%prefix%forms_fielddefinitions` DISABLE KEYS */;
INSERT IGNORE INTO `%prefix%forms_fielddefinitions` (`field_id`, `name`, `mapto`, `label`, `helptext`, `pattern`, `defined_by`) VALUES
	(1, 'page_title', NULL, NULL, 'The title should be a nice &quot;human readable&quot; text having 30 up to 55 characters.', '.{1,55}', 1),
	(2, 'page_parent', 'parent', NULL, 'The position of the page in the page tree.', NULL, 1),
	(3, 'page_language', NULL, NULL, 'The (main) language of the page contents.', NULL, 1),
	(4, 'page_type', NULL, NULL, 'The page type.', NULL, 1),
	(5, 'page_visibility', 'visibility', 'Visibility', 'Who can view the page', NULL, 1),
	(6, 'page_menu', NULL, 'Menu appearance', 'Select the menu the page belongs to. The menu select depends on the chosen template.', NULL, 1),
	(7, 'page_template', NULL, 'Template', 'You may override the system settings for the template here', NULL, 1),
	(8, 'template_variant', NULL, NULL, 'You may override the system settings for the template variant here', NULL, 1),
	(9, 'menu_title', NULL, 'Menu title', 'The menu title is used for the navigation menu. Hint: Use short but descriptive titles.', '.{1,55}', 1),
	(10, 'page_description', 'description', 'Description', 'The description should be a nice &quot;human readable&quot; text having 70 up to 156 characters.', '.{0,156}', 1),
	(11, 'page_id', NULL, 'Page ID', NULL, NULL, 1),
	(31, 'page_before_after', NULL, NULL, NULL, NULL, 1),
	(32, 'default_radio', NULL, NULL, NULL, NULL, 1),
	(33, 'site_name', NULL, 'Site name', 'The site name may help you to distinguish your sites', NULL, 1),
	(34, 'site_folder', NULL, 'Subfolder', 'The name of the subfolder inside Basedir', NULL, 1),
	(35, 'site_basedir', NULL, 'Basedir', 'The basedir of the site', NULL, 1),
	(36, 'site_owner', NULL, 'Owner', 'The owner of a site will have admin privileges by default', NULL, 1),
	(37, 'addon_name', NULL, NULL, NULL, NULL, 1),
	(38, 'addon_type', NULL, NULL, NULL, NULL, 1),
	(39, 'addon_directory', NULL, NULL, NULL, NULL, 1),
	(40, 'addon_description', NULL, NULL, NULL, NULL, 1),
	(41, 'addon_author', NULL, NULL, NULL, NULL, 1),
	(42, 'addon_jquery', NULL, 'Use jQuery', NULL, NULL, 1),
	(43, 'addon_jqueryui', NULL, 'Use jQuery UI', NULL, NULL, 1),
	(44, 'addon_bootstrap', NULL, 'Use Bootstrap', NULL, NULL, 1);
/*!40000 ALTER TABLE `%prefix%forms_fielddefinitions` ENABLE KEYS */;

-- Exportiere Daten aus Tabelle blackcat.%prefix%forms_fieldtypes: ~8 rows (ungefähr)
/*!40000 ALTER TABLE `%prefix%forms_fieldtypes` DISABLE KEYS */;
INSERT IGNORE INTO `%prefix%forms_fieldtypes` (`type_id`, `fieldtype`) VALUES
	(1, 'text'),
	(2, 'select'),
	(3, 'textarea'),
	(4, 'radio'),
	(5, 'checkbox'),
	(6, 'email'),
	(7, 'button'),
	(8, 'hidden');
/*!40000 ALTER TABLE `%prefix%forms_fieldtypes` ENABLE KEYS */;

-- Exportiere Daten aus Tabelle blackcat.%prefix%forms_has_fields: ~49 rows (ungefähr)
/*!40000 ALTER TABLE `%prefix%forms_has_fields` DISABLE KEYS */;
INSERT IGNORE INTO `%prefix%forms_has_fields` (`form_id`, `field_id`, `type_id`, `fieldset`, `position`, `value`, `data`, `disabled`, `required`, `fieldhandler`, `params`) VALUES
	(1, 1, 1, 'common', 1, NULL, NULL, NULL, '1', NULL, NULL),
	(1, 2, 2, 'common', 2, '0', NULL, NULL, NULL, '\\CAT\\Helper\\Page::getPagesAsList', 'true'),
	(1, 3, 2, 'common', 5, NULL, NULL, NULL, NULL, '\\CAT\\Base::getLanguages', 'true'),
	(1, 4, 4, 'common', 6, NULL, NULL, NULL, NULL, '\\CAT\\Helper\\Page::getPageTypes', ''),
	(2, 2, 2, 'general', 1, NULL, NULL, NULL, NULL, '\\CAT\\Helper\\Page::getPagesAsList', 'true'),
	(2, 5, 2, 'general', 2, NULL, NULL, NULL, NULL, '\\CAT\\Helper\\Page::getVisibilities', NULL),
	(2, 6, 2, 'general', 3, NULL, NULL, NULL, NULL, NULL, NULL),
	(2, 7, 2, 'general', 4, NULL, NULL, NULL, NULL, '\\CAT\\Helper\\Addons::getAddons', 'template'),
	(2, 8, 2, 'general', 5, NULL, NULL, NULL, NULL, NULL, NULL),
	(2, 1, 1, 'META / SEO', 1, NULL, NULL, NULL, '1', NULL, NULL),
	(2, 9, 1, 'META / SEO', 2, NULL, NULL, NULL, '1', NULL, NULL),
	(2, 10, 1, 'META / SEO', 3, NULL, NULL, NULL, NULL, NULL, NULL),
	(2, 3, 2, 'META / SEO', 4, NULL, NULL, NULL, NULL, '\\CAT\\Base::getLanguages', 'true'),
	(2, 11, 8, 'general', 0, NULL, NULL, NULL, NULL, NULL, NULL),
	(3, 3, 2, 'common', 1, NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 12, 3, 'Menu depth settings', 1, NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 13, 3, 'Menu depth settings', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 14, 3, 'Menu depth settings', 3, NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 15, 1, 'List item', 4, NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 16, 1, 'List item', 3, NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 17, 1, 'Link', 3, NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 18, 1, 'List item', 1, NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 19, 1, 'List item', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 20, 1, 'List item', 5, NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 21, 1, 'List', 1, NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 22, 1, 'List', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 23, 1, 'List', 3, NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 24, 1, 'List', 4, NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 25, 1, 'List', 5, NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 26, 1, 'Link', 1, NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 28, 1, 'Link', 5, NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 29, 1, 'Link', 4, NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 27, 1, 'Link', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(1, 32, 4, 'common', 3, NULL, 'before,after', NULL, NULL, NULL, NULL),
	(1, 31, 1, 'common', 4, NULL, NULL, NULL, NULL, NULL, NULL),
	(5, 33, 1, 'Create site', 1, NULL, NULL, NULL, '1', NULL, NULL),
	(5, 35, 1, 'Create site', 2, NULL, NULL, NULL, '1', NULL, NULL),
	(5, 34, 1, 'Create site', 3, NULL, NULL, NULL, '1', NULL, NULL),
	(5, 36, 2, 'Create site', 4, NULL, NULL, NULL, '1', NULL, NULL),
	(6, 37, 1, 'common', 1, NULL, NULL, NULL, '1', NULL, NULL),
	(6, 38, 2, 'common', 4, NULL, NULL, NULL, '1', NULL, NULL),
	(6, 39, 1, 'common', 3, NULL, NULL, NULL, '1', NULL, NULL),
	(6, 40, 1, 'common', 5, NULL, NULL, NULL, '1', NULL, NULL),
	(6, 41, 1, 'common', 2, NULL, NULL, NULL, '1', NULL, NULL),
	(6, 42, 5, 'common', 6, NULL, NULL, NULL, NULL, NULL, NULL),
	(6, 43, 5, 'common', 7, NULL, NULL, NULL, NULL, NULL, NULL),
	(6, 44, 5, 'common', 8, NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 45, 2, 'Common', 2, NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 46, 2, 'Common', 1, NULL, NULL, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `%prefix%forms_has_fields` ENABLE KEYS */;

-- Exportiere Daten aus Tabelle blackcat.%prefix%item_states: ~2 rows (ungefähr)
/*!40000 ALTER TABLE `%prefix%item_states` DISABLE KEYS */;
INSERT IGNORE INTO `%prefix%item_states` (`state_id`, `state_name`) VALUES
	(1, 'default'),
	(2, 'deleted');
/*!40000 ALTER TABLE `%prefix%item_states` ENABLE KEYS */;

-- Exportiere Daten aus Tabelle blackcat.%prefix%menus: ~8 rows (ungefähr)
/*!40000 ALTER TABLE `%prefix%menus` DISABLE KEYS */;
INSERT IGNORE INTO `%prefix%menus` (`menu_id`, `type_id`, `core`, `protected`, `info`) VALUES
	(1, 1, 'Y', 'Y', 'Backend Top-Menu'),
	(2, 2, 'Y', 'Y', 'Backend Breadcrumb'),
	(3, 1, 'Y', 'Y', 'Default full menu'),
	(4, 2, 'Y', 'Y', 'Default breadcrumb menu'),
	(5, 3, 'Y', 'Y', 'Default siblings menu');
/*!40000 ALTER TABLE `%prefix%menus` ENABLE KEYS */;

-- Exportiere Daten aus Tabelle blackcat.%prefix%menutypes: ~4 rows (ungefähr)
/*!40000 ALTER TABLE `%prefix%menutypes` DISABLE KEYS */;
INSERT IGNORE INTO `%prefix%menutypes` (`type_id`, `type_name`, `description`) VALUES
	(1, 'fullmenu', 'Shows all pages that are visible for the current user'),
	(2, 'breadcrumb', 'Shows "path" to current page'),
	(3, 'siblings', 'Shows all pages that are visible for the current user and on the same level as the current page'),
	(4, 'language', 'Shows links to current page in other languages');
/*!40000 ALTER TABLE `%prefix%menutypes` ENABLE KEYS */;

-- Exportiere Daten aus Tabelle blackcat.%prefix%menutype_options: ~26 rows (ungefähr)
/*!40000 ALTER TABLE `%prefix%menutype_options` DISABLE KEYS */;
INSERT IGNORE INTO `%prefix%menutype_options` (`option_id`, `option_name`) VALUES
	(1, 'ul_first'),
	(2, 'ul_last'),
	(3, 'ul_child'),
	(4, 'ul_current'),
	(5, 'ul_default'),
	(6, 'ul_trail'),
	(7, 'ul_level_classes'),
	(8, 'li_first'),
	(9, 'li_last'),
	(10, 'li_child'),
	(11, 'li_current'),
	(12, 'li_default'),
	(13, 'li_trail'),
	(14, 'li_level_classes'),
	(15, 'a_first'),
	(16, 'a_last'),
	(17, 'a_child'),
	(18, 'a_current'),
	(19, 'a_default'),
	(20, 'a_trail'),
	(21, 'a_level_classes'),
	(22, 'template_dir'),
	(23, 'template_type'),
	(24, 'template_variant'),
	(25, 'min_depth'),
	(26, 'max_depth');
/*!40000 ALTER TABLE `%prefix%menutype_options` ENABLE KEYS */;

-- Exportiere Daten aus Tabelle blackcat.%prefix%menutype_settings: ~9 rows (ungefähr)
/*!40000 ALTER TABLE `%prefix%menutype_settings` DISABLE KEYS */;
INSERT IGNORE INTO `%prefix%menutype_settings` (`type_id`, `option_id`, `default_value`, `value`) VALUES
	(1, 21, '>1:dropdown-item', NULL),
	(1, 14, '>1:dropdown-submenu', NULL),
	(1, 3, 'dropdown-menu', NULL),
	(1, 7, '1:navbar-nav mr-auto|>=2:dropdown-menu', NULL),
	(2, 24, 'no_defaults', NULL),
	(3, 24, 'no_defaults', NULL),
	(3, 23, 'default', NULL),
	(3, 24, 'flat', NULL),
	(3, 21, '>=1:nav-link', NULL);
/*!40000 ALTER TABLE `%prefix%menutype_settings` ENABLE KEYS */;

-- Exportiere Daten aus Tabelle blackcat.%prefix%menu_on_site: ~3 rows (ungefähr)
/*!40000 ALTER TABLE `%prefix%menu_on_site` DISABLE KEYS */;
INSERT IGNORE INTO `%prefix%menu_on_site` (`menu_id`, `site_id`) VALUES
	(1, 1),
	(7, 1),
	(8, 1);
/*!40000 ALTER TABLE `%prefix%menu_on_site` ENABLE KEYS */;

-- Exportiere Daten aus Tabelle blackcat.%prefix%menu_options: ~7 rows (ungefähr)
/*!40000 ALTER TABLE `%prefix%menu_options` DISABLE KEYS */;
INSERT IGNORE INTO `%prefix%menu_options` (`menu_id`, `option_id`, `site_id`, `value`) VALUES
	(1, 14, 0, '>1:dropdown-item'),
	(1, 7, 0, '>1:dropdown-submenu'),
	(2, 7, 0, '1:breadcrumb'),
	(5, 1, 1, 'dropdown-toggle'),
	(5, 1, 1, '1:nav nav-pills ddmenu|2:dropdown-menu|>2:dropdown-menu sub-menu'),
	(7, 1, 1, '1:br'),
	(8, 1, 1, 'no_defaults');
/*!40000 ALTER TABLE `%prefix%menu_options` ENABLE KEYS */;

-- Exportiere Daten aus Tabelle blackcat.%prefix%mimetypes: ~81 rows (ungefähr)
/*!40000 ALTER TABLE `%prefix%mimetypes` DISABLE KEYS */;
INSERT IGNORE INTO `%prefix%mimetypes` (`mime_id`, `mime_type`, `mime_suffixes`, `mime_label`, `mime_icon`, `mime_allowed_for`) VALUES
	(1, 'application/gzip', '|gzip|', 'GZIP compressed files', 'mime-compressed.png', NULL),
	(2, 'application/octet-stream', '|bin|dms|lha|lzh|exe|class|ani|pgp|so|dll|dmg|', 'Binary', 'mime-octet.png', NULL),
	(3, 'application/pdf', '|pdf|', 'PDF files', 'mime-pdf.png', NULL),
	(4, 'application/xhtml+xml', '', NULL, NULL, NULL),
	(5, 'application/xml', '|xml|xsl|', NULL, NULL, NULL),
	(6, 'application/x-bcpio', '', NULL, NULL, NULL),
	(7, 'application/x-compress', '', NULL, NULL, NULL),
	(8, 'application/x-cpio', '', NULL, NULL, NULL),
	(9, 'application/x-gtar', '', NULL, NULL, NULL),
	(10, 'application/x-httpd-php', '', NULL, NULL, NULL),
	(11, 'application/x-javascript', '|js|', 'JavaScript (x-javascript)', NULL, NULL),
	(12, 'application/x-tar', '', NULL, NULL, NULL),
	(13, 'application/x-www-form-urlencoded', '', NULL, NULL, NULL),
	(14, 'application/zip', '|zip|', 'ZIP compressed files (zip)', 'mime-compressed.png', NULL),
	(15, 'audio/basic', '', NULL, NULL, NULL),
	(16, 'audio/echospeech', '', NULL, NULL, NULL),
	(17, 'audio/tsplayer', '', NULL, NULL, NULL),
	(18, 'audio/voxware', '', NULL, NULL, NULL),
	(19, 'audio/x-aiff', '|aif|aiff|', NULL, NULL, NULL),
	(20, 'audio/x-dspeeh', '', NULL, NULL, NULL),
	(21, 'audio/x-midi', '', NULL, NULL, NULL),
	(22, 'audio/x-mpeg', '', 'MPEG Audio Stream, Layer III (MP3)', 'mime-audio.png', NULL),
	(23, 'audio/x-pn-realaudio', '', NULL, NULL, NULL),
	(24, 'audio/x-pn-realaudio-plugin', '', NULL, NULL, NULL),
	(25, 'audio/x-qt-stream', '', NULL, NULL, NULL),
	(26, 'audio/x-wav', '|wav|', NULL, NULL, NULL),
	(27, 'image/gif', '|gif|', 'GIF Images', 'mime-gif.png', NULL),
	(28, 'image/ief', '|ief|', NULL, NULL, NULL),
	(29, 'image/jpeg', '|jpeg|jpg|jpe|', 'JP(e)G images', 'mime-jpg.png', NULL),
	(30, 'image/png', '|png|', 'PNG images', 'mime-image.png', NULL),
	(31, 'image/tiff', '|tiff|tif|', 'TIFF images', 'mime-tiff.png', NULL),
	(32, 'image/x-freehand', '', NULL, NULL, NULL),
	(33, 'image/x-icon', '', NULL, NULL, NULL),
	(34, 'image/x-portable-anymap', '', NULL, NULL, NULL),
	(35, 'image/x-portable-bitmap', '', NULL, NULL, NULL),
	(36, 'image/x-portable-graymap', '', NULL, NULL, NULL),
	(37, 'image/x-portable-pixmap', '', NULL, NULL, NULL),
	(38, 'image/x-rgb', '', NULL, NULL, NULL),
	(39, 'image/x-windowdump', '', NULL, NULL, NULL),
	(40, 'image/x-xbitmap', '', NULL, NULL, NULL),
	(41, 'image/x-xpixmap', '', NULL, NULL, NULL),
	(42, 'message/external-body', '', NULL, NULL, NULL),
	(43, 'message/http', '', NULL, NULL, NULL),
	(44, 'message/news', '', NULL, NULL, NULL),
	(45, 'message/partial', '', NULL, NULL, NULL),
	(46, 'message/rfc822', '', NULL, NULL, NULL),
	(47, 'model/vrml', '', NULL, NULL, NULL),
	(48, 'multipart/alternative', '', NULL, NULL, NULL),
	(49, 'multipart/byteranges', '', NULL, NULL, NULL),
	(50, 'multipart/digest', '', NULL, NULL, NULL),
	(51, 'multipart/encrypted', '', NULL, NULL, NULL),
	(52, 'multipart/form-data', '', NULL, NULL, NULL),
	(53, 'multipart/mixed', '', NULL, NULL, NULL),
	(54, 'multipart/parallel', '', NULL, NULL, NULL),
	(55, 'multipart/related', '', NULL, NULL, NULL),
	(56, 'multipart/report', '', NULL, NULL, NULL),
	(57, 'multipart/signed', '', NULL, NULL, NULL),
	(58, 'multipart/voice-message', '', NULL, NULL, NULL),
	(59, 'text/css', '|css|', 'CSS files', NULL, NULL),
	(60, 'text/html', '|htm|html|php|', NULL, NULL, NULL),
	(61, 'text/javascript', '|js|', 'JavaScript files', NULL, NULL),
	(62, 'text/plain', '|txt|', NULL, NULL, NULL),
	(63, 'text/richtext', '', NULL, NULL, NULL),
	(64, 'text/rtf', '', NULL, NULL, NULL),
	(65, 'text/xml', '', NULL, NULL, NULL),
	(66, 'video/mpeg', '|mpe|mpeg|mpg|', NULL, NULL, NULL),
	(67, 'video/quicktime', '|mov|', 'Quicktime Movie', NULL, NULL),
	(68, 'video/x-msvideo', '', NULL, NULL, NULL),
	(69, 'video/x-sgi-movie', '', NULL, NULL, NULL),
	(70, 'image/targa', '|tga|', 'TGA (Targa) images', 'mime-tga.png', NULL),
	(71, 'application/x-zip-compressed', '|zip|', 'ZIP compressed files (x-zip-compressed)', 'mime-compressed.png', NULL),
	(72, 'image/*', '|gif|ief|jpeg|jpg|jpe|png|tga|tif|tiff|', 'All kinds of images', 'mime-image.png', NULL),
	(73, 'video/x-flv', '|flv|', 'Flash Video', NULL, NULL),
	(74, 'application/json', '|json|', NULL, NULL, NULL),
	(75, 'application/msword', '|doc|docx|', NULL, NULL, NULL),
	(76, 'application/vnd.ms-excel', '|xls|xlt|xlm|xld|xla|xlc|xlw|xll|', NULL, NULL, NULL),
	(77, 'vnd.ms-powerpoint', '|ppt|pps|', NULL, NULL, NULL),
	(78, 'audio/wav', '|wav|', NULL, NULL, NULL),
	(79, 'video/msvideo', '|avi|', NULL, NULL, NULL),
	(80, 'video/x-ms-wmv', '|wmv|', NULL, NULL, NULL),
	(81, 'image/svg+xml', '|svg|', 'SVG images', NULL, NULL);
/*!40000 ALTER TABLE `%prefix%mimetypes` ENABLE KEYS */;

-- Exportiere Daten aus Tabelle blackcat.%prefix%rbac_groups: ~4 rows (ungefähr)
/*!40000 ALTER TABLE `%prefix%rbac_groups` DISABLE KEYS */;
INSERT IGNORE INTO `%prefix%rbac_groups` (`group_id`, `group_title`, `group_description`, `group_builtin`, `group_wysiwyg`) VALUES
	(1, 'Administrators', 'Administrators', 'Y', ''),
	(2, 'Guests', 'Guests', 'Y', ''),
	(3, 'Redakteure', 'Redakteure', 'N', ''),
	(4, 'SiteAdmins', 'SiteAdmins', 'N', '');
/*!40000 ALTER TABLE `%prefix%rbac_groups` ENABLE KEYS */;

-- Exportiere Daten aus Tabelle blackcat.%prefix%rbac_permissions: ~63 rows (ungefähr)
/*!40000 ALTER TABLE `%prefix%rbac_permissions` DISABLE KEYS */;
INSERT IGNORE INTO `%prefix%rbac_permissions` (`perm_id`, `area`, `group`, `title`, `description`, `position`, `requires`, `implicit`, `defined_by`) VALUES
	(1, 'frontend', 'frontend', 'access_frontend', 'Frontend access', 1, 0, 'N', 1),
	(2, 'backend', 'backend', 'login', 'Access to login page', 2, 0, 'Y', 1),
	(3, 'backend', 'preferences', 'preferences', 'User can edit his profile', 1, 2, 'N', 1),
	(4, 'backend', 'backend', 'access_backend', 'Backend access', 2, 2, 'Y', 1),
	(5, 'backend', 'pages', 'pages', 'Access to pages', 2, 4, 'N', 1),
	(6, 'backend', 'pages', 'pages_list', 'See the page tree', 1, 5, 'N', 1),
	(7, 'backend', 'pages', 'pages_add', 'Create a new page', 1, 6, 'N', 1),
	(8, 'backend', 'pages', 'pages_add_l0', 'Create root pages (level 0)', 1, 7, 'N', 1),
	(9, 'backend', 'pages', 'pages_edit', 'Modify existing pages', 2, 6, 'N', 1),
	(10, 'backend', 'pages', 'pages_delete', 'Delete pages', 3, 6, 'N', 1),
	(11, 'backend', 'pages', 'pages_settings', 'Edit page settings', 4, 6, 'N', 1),
	(12, 'backend', 'pages', 'pages_section_add', 'Add section to page', 1, 9, 'N', 1),
	(13, 'backend', 'pages', 'pages_section_delete', 'Delete section(s) from page', 2, 9, 'N', 1),
	(14, 'backend', 'pages', 'pages_section_recover', 'Recover a deleted section', 4, 9, 'N', 1),
	(15, 'backend', 'pages', 'pages_section_publishing', 'Set publishing date and time', 3, 9, 'N', 1),
	(16, 'backend', 'media', 'media', 'Access to media section', 3, 4, 'Y', 1),
	(17, 'backend', 'media', 'media_list', 'See a list of available media files', 1, 16, 'N', 1),
	(18, 'backend', 'media', 'media_delete', 'Delete files', 7, 17, 'N', 1),
	(19, 'backend', 'media', 'media_rename', 'Rename and/or move media files', 6, 17, 'N', 1),
	(20, 'backend', 'media', 'media_upload', 'Upload media files', 5, 17, 'N', 1),
	(21, 'backend', 'media', 'media_folder_create', 'Create new folder', 1, 17, 'N', 1),
	(22, 'backend', 'media', 'media_folder_protect', 'Add/remove folder protection (.htaccess)', 3, 17, 'N', 1),
	(23, 'backend', 'media', 'media_folder_rename', 'Rename folder', 2, 17, 'N', 1),
	(24, 'backend', 'media', 'media_folder_delete', 'Delete folder', 4, 17, 'N', 1),
	(25, 'backend', 'dashboard', 'dashboard', 'Access to global dashboard', 1, 4, 'Y', 1),
	(26, 'backend', 'dashboard', 'dashboard_widgets', 'Have widgets on the dashboard', 1, 25, 'N', 1),
	(27, 'backend', 'dashboard', 'dashboard_config', 'User can configure his dashboard', 1, 26, 'N', 1),
	(28, 'backend', 'admintools', 'tools_list', 'List available Admin Tools', 4, 4, 'N', 1),
	(29, 'backend', 'permissions', 'permissions', 'Access to permissions', 5, 4, 'N', 1),
	(30, 'backend', 'permissions', 'permissions_list', 'See defined permissions', 1, 29, 'N', 1),
	(31, 'backend', 'permissions', 'permissions_add', 'Add new permissions', 1, 30, 'N', 1),
	(32, 'backend', 'roles', 'roles', 'Access to roles', 6, 4, 'Y', 1),
	(33, 'backend', 'roles', 'roles_list', 'See defined roles', 1, 32, 'N', 1),
	(34, 'backend', 'roles', 'roles_add', 'Create a new role', 1, 33, 'N', 1),
	(35, 'backend', 'roles', 'roles_delete', 'Delete roles', 2, 33, 'N', 1),
	(36, 'backend', 'roles', 'roles_perms', 'Manage role permissions', 3, 33, 'N', 1),
	(37, 'backend', 'groups', 'groups', 'Access to groups', 7, 4, 'Y', 1),
	(38, 'backend', 'groups', 'groups_list', 'See available user groups', 1, 37, 'N', 1),
	(39, 'backend', 'groups', 'groups_add', 'Create a new user group', 2, 38, 'N', 1),
	(40, 'backend', 'groups', 'groups_delete', 'Delete groups', 3, 38, 'N', 1),
	(41, 'backend', 'groups', 'groups_users', 'Manage group members', 4, 38, 'N', 1),
	(42, 'backend', 'groups', 'groups_modify', 'Modify group data', 1, 38, 'N', 1),
	(43, 'backend', 'users', 'users', 'Access to users', 8, 4, 'Y', 1),
	(44, 'backend', 'users', 'users_list', 'See all users', 1, 43, 'N', 1),
	(45, 'backend', 'users', 'users_add', 'Create new users', 1, 44, 'N', 1),
	(46, 'backend', 'users', 'users_delete', 'Delete users', 4, 44, 'N', 1),
	(47, 'backend', 'users', 'users_edit', 'Edit user data', 2, 44, 'N', 1),
	(48, 'backend', 'users', 'users_membership', 'Edit group membership', 3, 44, 'N', 1),
	(49, 'backend', 'media', 'media_update', 'Update database data for media', 8, 17, 'N', 1),
	(50, 'backend', 'menu', 'menu_edit', 'Edit menu settings', 1, 28, 'N', 36),
	(51, 'backend', 'addons', 'addons_list', 'List installed addons', 1, 4, 'Y', 1),
	(52, 'backend', 'addons', 'addons_install', 'Install new addons', 1, 51, 'N', 1),
	(53, 'backend', 'settings', 'settings_list', 'See settings', 1, 4, 'Y', 1),
	(54, 'backend', 'settings', 'settings_edit', 'Edit settings', 1, 53, 'N', 1),
	(55, 'backend', 'socialmedia', 'socialmedia_site_edit', 'Edit social media links on site', 1, 4, 'N', 1),
	(56, 'backend', 'socialmedia', 'socialmedia_add', 'Add social media links globally', 1, 59, 'N', 1),
	(57, 'backend', 'socialmedia', 'socialmedia_delete', 'Delete social media links globally', 1, 59, 'N', 1),
	(58, 'backend', 'socialmedia', 'socialmedia_edit', 'Edit global social media links', 1, 59, 'N', 1),
	(59, 'backend', 'socialmedia', 'socialmedia_list', 'View social media links', 1, 4, 'Y', 1),
	(60, 'backend', 'site', 'sites_list', 'List sites', 1, 4, 'Y', 1),
	(61, 'backend', 'site', 'sites_add', 'Add new sites', 1, 60, 'N', 1),
	(62, 'backend', 'site', 'sites_edit', 'Edit sites', 1, 60, 'N', 1),
	(63, 'backend', 'site', 'sites_delete', 'Delete sites', 1, 60, 'N', 1);
/*!40000 ALTER TABLE `%prefix%rbac_permissions` ENABLE KEYS */;

-- Exportiere Daten aus Tabelle blackcat.%prefix%rbac_rolepermissions: ~69 rows (ungefähr)
/*!40000 ALTER TABLE `%prefix%rbac_rolepermissions` DISABLE KEYS */;
INSERT IGNORE INTO `%prefix%rbac_rolepermissions` (`role_id`, `perm_id`, `AssignmentDate`) VALUES
	(1, 1, 1535557202),
	(2, 1, 1534865706),
	(2, 2, 1534865706),
	(2, 3, 1534865706),
	(2, 4, 1534865706),
	(2, 5, 1534865706),
	(2, 6, 1534865706),
	(2, 7, 1534865706),
	(2, 8, 1534865706),
	(2, 9, 1534865706),
	(2, 10, 1534865706),
	(2, 11, 1534865706),
	(2, 12, 1534865706),
	(2, 13, 1534865706),
	(2, 14, 1534865706),
	(2, 15, 1534865706),
	(2, 16, 1534865706),
	(2, 17, 1534865706),
	(2, 18, 1534865706),
	(2, 19, 1534865706),
	(2, 20, 1534865706),
	(2, 21, 1534865706),
	(2, 22, 1534865706),
	(2, 23, 1534865706),
	(2, 24, 1534865706),
	(2, 25, 1534865706),
	(2, 26, 1534865706),
	(2, 27, 1534865706),
	(2, 28, 1534865706),
	(3, 29, 1534865706),
	(3, 30, 1534865706),
	(3, 31, 1534865706),
	(3, 32, 1534865706),
	(3, 33, 1534865706),
	(3, 34, 1534865706),
	(3, 35, 1534865706),
	(3, 36, 1534865706),
	(4, 2, 1534865781),
	(4, 3, 1534865781),
	(4, 4, 1534865781),
	(4, 5, 1534865781),
	(4, 6, 1534865781),
	(4, 7, 1534865781),
	(4, 8, 1534865781),
	(4, 9, 1534865781),
	(4, 10, 1534865781),
	(4, 11, 1534865781),
	(4, 12, 1534865781),
	(4, 13, 1534865781),
	(4, 14, 1534865781),
	(4, 15, 1534865781),
	(4, 16, 1534865781),
	(4, 17, 1534865781),
	(4, 18, 1534865781),
	(4, 19, 1534865781),
	(4, 20, 1534865781),
	(4, 21, 1534865781),
	(4, 22, 1534865781),
	(4, 23, 1534865781),
	(4, 24, 1534865781),
	(5, 4, NULL),
	(5, 56, 1539964413),
	(5, 57, 1539964413),
	(5, 58, 1539964413),
	(5, 59, 1539964413),
	(5, 60, 1539964413),
	(5, 61, 1539964413),
	(5, 62, 1539964413),
	(5, 63, 1539964413);
/*!40000 ALTER TABLE `%prefix%rbac_rolepermissions` ENABLE KEYS */;

-- Exportiere Daten aus Tabelle blackcat.%prefix%rbac_roles: ~5 rows (ungefähr)
/*!40000 ALTER TABLE `%prefix%rbac_roles` DISABLE KEYS */;
INSERT IGNORE INTO `%prefix%rbac_roles` (`role_id`, `role_title`, `role_description`, `builtin`, `protected`) VALUES
	(1, 'guest', 'Guest users', 'Y', 'Y'),
	(2, 'backend_user', 'Allows for accessing the backend', 'Y', 'Y'),
	(3, 'role_admin', 'Allows for managing (create, edit, delete) roles', 'Y', 'Y'),
	(4, 'page_mgr', 'Allows for managing (create, edit, delete) pages', 'Y', 'N'),
	(5, 'site_admin', 'Allows for managing (create, edit, delete) sites', 'Y', 'N');
/*!40000 ALTER TABLE `%prefix%rbac_roles` ENABLE KEYS */;

-- Exportiere Daten aus Tabelle blackcat.%prefix%rbac_users: ~5 rows (ungefähr)
/*!40000 ALTER TABLE `%prefix%rbac_users` DISABLE KEYS */;
INSERT IGNORE INTO `%prefix%rbac_users` (`user_id`, `active`, `username`, `password`, `last_reset`, `display_name`, `email`, `language`, `home_folder`, `login_when`, `login_ip`, `tfa_enabled`, `tfa_secret`, `protected`, `wysiwyg`) VALUES
	(1, 1, 'admin', '$2y$10$F/BQ0iZaZ4whLzBq.YPFCuE78WVwY1TnX8Q2riYD31r81f2QTrB96', 0, 'Administrator', 'blackbird@webbird.de', 'DE', '', 1541607117, '::1', 'N', '2Dsn5kJa7fCj4JJghY/XXUfd1cUDDHxFZV/lw8wr9PIZgBU+V3', 'Y', NULL),
	(2, 1, 'guest', '', 0, 'Guest', NULL, 'DE', '', 0, '0', 'N', NULL, 'Y', NULL),
	(3, 1, 'siteadmin', '$2y$10$F/BQ0iZaZ4whLzBq.YPFCuE78WVwY1TnX8Q2riYD31r81f2QTrB96', 0, 'Site Administrator', 'blackbird@webbird.de', 'DE', '', 1539965165, '::1', 'N', NULL, 'Y', NULL);
/*!40000 ALTER TABLE `%prefix%rbac_users` ENABLE KEYS */;

-- Exportiere Daten aus Tabelle blackcat.%prefix%rbac_user_settings: ~12 rows (ungefähr)
/*!40000 ALTER TABLE `%prefix%rbac_user_settings` DISABLE KEYS */;
INSERT IGNORE INTO `%prefix%rbac_user_settings` (`site_id`, `name`, `fieldset`, `fieldtype`, `label`, `position`, `default_value`, `is_editable`, `is_required`, `helptext`, `fieldhandler`, `params`) VALUES
	(1, 'active', 'common', 5, NULL, 1, NULL, 'Y', 'Y', NULL, NULL, NULL),
	(1, 'city', 'postal', 1, 'City', 4, NULL, 'Y', 'N', NULL, NULL, NULL),
	(1, 'country', 'postal', 1, 'Country', 5, NULL, 'Y', 'N', NULL, NULL, NULL),
	(1, 'display_name', 'common', 1, NULL, 3, NULL, 'Y', 'Y', NULL, NULL, NULL),
	(1, 'email', 'contact', 6, 'eMail', 1, NULL, 'Y', 'Y', NULL, NULL, NULL),
	(1, 'home_folder', 'common', 1, NULL, 5, NULL, 'Y', 'N', NULL, NULL, NULL),
	(1, 'mobile phone', 'contact', 1, 'Mobile Phone', 3, NULL, 'Y', 'N', NULL, NULL, NULL),
	(1, 'phone', 'contact', 1, 'Phone', 2, NULL, 'Y', 'N', NULL, NULL, NULL),
	(1, 'street', 'postal', 1, 'Street', 2, NULL, 'Y', 'N', NULL, NULL, NULL),
	(1, 'tfa_enabled', 'common', 5, NULL, 4, NULL, 'Y', 'Y', NULL, NULL, NULL),
	(1, 'username', 'common', 1, NULL, 2, NULL, 'Y', 'Y', NULL, NULL, NULL),
	(1, 'zip', 'postal', 1, 'ZIP Code', 3, NULL, 'Y', 'N', NULL, NULL, NULL);
/*!40000 ALTER TABLE `%prefix%rbac_user_settings` ENABLE KEYS */;

-- Exportiere Daten aus Tabelle blackcat.%prefix%settings: ~29 rows (ungefähr)
/*!40000 ALTER TABLE `%prefix%settings` DISABLE KEYS */;
INSERT IGNORE INTO `%prefix%settings` (`setting_id`, `region`, `name`, `default_value`, `is_editable`, `is_global`, `is_site`, `fieldtype`, `label`, `helptext`, `route`, `fieldhandler`, `params`) VALUES
	(76, 'system', 'default_language', 'DE', 'Y', 'Y', 'Y', 2, NULL, NULL, NULL, '\\CAT\\Base::getLanguages', 'true'),
	(77, 'backend', 'default_theme', 'backstrap', 'Y', 'Y', 'Y', 2, NULL, NULL, NULL, '\\CAT\\Helper\\Template::getTemplates', 'backend'),
	(78, 'backend', 'default_theme_variant', NULL, 'Y', 'Y', 'Y', 2, NULL, NULL, NULL, '\\CAT\\Helper\\Template::getVariants', NULL),
	(79, 'system', 'app_name', NULL, 'N', 'Y', 'N', 1, NULL, NULL, NULL, '', NULL),
	(80, 'seo', 'website_title', NULL, 'Y', 'N', 'Y', 1, NULL, NULL, NULL, '', NULL),
	(81, 'system', '%prefix%version', '2.0.0', 'N', 'Y', 'N', 1, NULL, NULL, NULL, '', NULL),
	(82, 'network', 'proxy', NULL, 'Y', 'Y', 'N', 1, NULL, 'If your server is placed behind a proxy (i.e. if you\'re using BC for an Intranet), set the name here.', NULL, '', NULL),
	(83, 'network', 'proxy_port', NULL, 'Y', 'Y', 'N', 1, NULL, NULL, NULL, '', NULL),
	(84, 'system', 'media_directory', 'media', 'Y', 'Y', 'Y', 1, NULL, NULL, NULL, '', NULL),
	(85, 'frontend', 'default_template', 'bs_business', 'Y', 'Y', 'Y', 2, NULL, NULL, NULL, '\\CAT\\Helper\\Template::getTemplates', 'frontend'),
	(86, 'backend', 'wysiwyg_editor', 'ckeditor4', 'Y', 'Y', 'Y', 2, NULL, 'Default WYSIWYG-Editor for use in the backend', NULL, '\\CAT\\Helper\\Addons::getAddons', 'wysiwyg'),
	(87, 'frontend', 'default_template_variant', 'default', 'Y', 'Y', 'Y', 2, NULL, NULL, NULL, '\\CAT\\Helper\\Template::getVariants', 'frontend'),
	(88, 'system', 'default_charset', 'utf-8', 'Y', 'Y', 'Y', 2, NULL, NULL, NULL, '\\CAT\\Base::getEncodings', 'true'),
	(89, 'backend', 'trash_enabled', 'true', 'Y', 'Y', 'Y', 5, NULL, 'If enabled, deleted pages and sections can be recovered.', NULL, NULL, NULL),
	(91, 'frontend', 'favicon', NULL, 'Y', 'N', 'Y', 7, 'Manage Favicon', NULL, '/backend/favicon', '\\CAT\\Backend\\Favicon::index', NULL),
	(92, 'frontend', 'favicon_tilecolor', '#f0f0f0', 'Y', 'Y', 'Y', 1, NULL, NULL, NULL, NULL, NULL),
	(94, 'system', 'cookie_name', 'bc2.0', 'Y', 'Y', 'Y', 1, NULL, NULL, NULL, NULL, NULL),
	(96, 'common', 'date_format', '%d.%m.%Y', 'Y', 'Y', 'Y', 2, NULL, NULL, NULL, NULL, NULL),
	(97, 'common', 'time_format', '%H:%M', 'Y', 'Y', 'Y', 2, NULL, NULL, NULL, NULL, NULL),
	(98, 'system', 'secret', NULL, 'N', 'N', 'Y', 8, NULL, NULL, NULL, NULL, NULL),
	(102, 'system', 'app_id', NULL, 'N', 'N', 'Y', 8, NULL, NULL, NULL, NULL, NULL),
	(103, 'system', 'asset_paths', NULL, 'Y', 'Y', 'Y', 5, NULL, NULL, NULL, NULL, NULL),
	(104, 'system', 'installation_time', NULL, 'N', 'Y', 'N', 1, NULL, NULL, NULL, NULL, NULL),
	(105, 'seo', 'website_brand', NULL, 'Y', 'Y', 'Y', 1, NULL, NULL, NULL, NULL, NULL),
	(106, 'system', 'err_page_404', NULL, 'Y', 'Y', 'Y', 1, NULL, NULL, NULL, NULL, NULL),
	(108, 'frontend', 'socialmedia_links', NULL, 'Y', 'Y', 'Y', 7, 'Social Media Links', NULL, '/backend/socialmedia', '\\CAT\\Backend\\Socialmedia::index', NULL),
	(109, 'frontend', 'track_visitors', 'false', 'Y', 'Y', 'Y', 5, NULL, NULL, NULL, NULL, NULL),
	(110, 'system', 'github_catalog_location', 'https://raw.githubusercontent.com/BlackCatDevelopment/BC2_ExtensionsCatalog/master/catalog.json', 'N', 'Y', 'N', 8, NULL, NULL, NULL, NULL, NULL),
	(111, 'system', 'use_encrypted_sessions', 'true', 'Y', 'Y', 'Y', 5, NULL, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `%prefix%settings` ENABLE KEYS */;

-- Exportiere Daten aus Tabelle blackcat.%prefix%visibility: ~7 rows (ungefähr)
/*!40000 ALTER TABLE `%prefix%visibility` DISABLE KEYS */;
INSERT IGNORE INTO `%prefix%visibility` (`vis_id`, `vis_name`, `vis_info`) VALUES
	(1, 'public', 'visible for all visitors'),
	(2, 'private', 'visible for certain users'),
	(3, 'hidden', 'does not appear in the menu, but can be viewed by '),
	(4, 'none', 'never visible in the frontend'),
	(5, 'deleted', 'the page is marked as deleted'),
	(6, 'registered', 'visible for certain users'),
	(7, 'draft', 'never visible in the frontend (page was just created)');
/*!40000 ALTER TABLE `%prefix%visibility` ENABLE KEYS */;

-- Exportiere Daten aus Tabelle blackcat.cat_dashboard_widgets: ~4 rows (ungefähr)
/*!40000 ALTER TABLE `%prefix%dashboard_widgets` DISABLE KEYS */;
INSERT IGNORE INTO `%prefix%dashboard_widgets` (`widget_id`, `widget_name`, `widget_module`, `widget_controller`, `preferred_column`, `icon`, `allow_in_global`) VALUES
	(1, 'Versioncheck', 'coreDashboard', 'dashboard_widget_versioncheck', 1, 'fa-check-circle', 'Y'),
	(2, 'Forum News', 'coreDashboard', 'dashboard_widget_forennews', 2, 'fa-comments-o', 'Y'),
	(3, 'Logs', 'coreDashboard', 'dashboard_widget_logs', 3, 'fa-align-left', 'Y'),
	(4, 'Statistics', 'coreDashboard', 'dashboard_widget_stats', 1, 'fa-bar-chart', 'Y');
/*!40000 ALTER TABLE `%prefix%dashboard_widgets` ENABLE KEYS */;


/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
