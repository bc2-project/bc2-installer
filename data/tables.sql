/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE TABLE IF NOT EXISTS `%prefix%addons` (
  `addon_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `directory` varchar(128) NOT NULL DEFAULT '',
  `type` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(128) NOT NULL DEFAULT '',
  `installed` varchar(255) NOT NULL DEFAULT '',
  `upgraded` varchar(255) NOT NULL DEFAULT '',
  `removable` enum('Y','N') NOT NULL DEFAULT 'Y',
  `bundled` enum('Y','N') NOT NULL DEFAULT 'N',
  PRIMARY KEY (`addon_id`),
  UNIQUE KEY `type_directory` (`directory`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `%prefix%addons_javascripts` (
  `js_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `directory` varchar(128) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `version` varchar(255) NOT NULL DEFAULT '',
  `jquery` char(1) NOT NULL DEFAULT 'N',
  `readme` text DEFAULT NULL,
  PRIMARY KEY (`js_id`),
  UNIQUE KEY `directory_version_jquery` (`directory`,`version`,`jquery`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `%prefix%backend_areas` (
  `id` int(2) unsigned NOT NULL AUTO_INCREMENT,
  `scope_id` int(2) unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  `position` int(1) unsigned NOT NULL,
  `parent` int(2) unsigned NOT NULL DEFAULT 0,
  `level` int(2) unsigned NOT NULL DEFAULT 0,
  `controller` varchar(50) DEFAULT NULL,
  `switch` char(1) DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `FK_%prefix%backend_areas_%prefix%backend_scopes` (`scope_id`),
  CONSTRAINT `FK_%prefix%backend_areas_%prefix%backend_scopes` FOREIGN KEY (`scope_id`) REFERENCES `%prefix%backend_scopes` (`scope_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `%prefix%backend_scopes` (
  `scope_id` int(2) unsigned NOT NULL AUTO_INCREMENT,
  `scope_name` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `page_tree` char(1) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`scope_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='Current scopes: Content, Administration';

CREATE TABLE IF NOT EXISTS `%prefix%charsets` (
  `name` varchar(50) NOT NULL,
  `labels` tinytext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `%prefix%cookieconsent_settings` (
  `site_id` int(11) unsigned NOT NULL,
  `type` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `position` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `theme` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `palette` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  KEY `FK_%prefix%cookieconsent_settings_%prefix%sites` (`site_id`),
  CONSTRAINT `FK_%prefix%cookieconsent_settings_%prefix%sites` FOREIGN KEY (`site_id`) REFERENCES `%prefix%sites` (`site_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `%prefix%dashboards` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL DEFAULT 0,
  `path` varchar(50) NOT NULL,
  `columns` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_user_id_page` (`id`,`user_id`,`path`),
  KEY `FK_%prefix%dashboard_%prefix%rbac_users` (`user_id`),
  CONSTRAINT `FK_%prefix%dashboard_%prefix%rbac_users` FOREIGN KEY (`user_id`) REFERENCES `%prefix%rbac_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `%prefix%dashboard_has_widgets` (
  `dashboard_id` int(11) unsigned NOT NULL,
  `widget_id` int(11) unsigned NOT NULL,
  `column` int(11) unsigned NOT NULL,
  `position` int(11) unsigned NOT NULL,
  `open` enum('Y','N') NOT NULL DEFAULT 'Y',
  UNIQUE KEY `dashboard_id_widget_id` (`dashboard_id`,`widget_id`),
  KEY `FK_%prefix%dashboard_has_widgets_%prefix%dashboard_widgets` (`widget_id`),
  CONSTRAINT `FK_%prefix%dashboard_has_widgets_%prefix%dashboard_config` FOREIGN KEY (`dashboard_id`) REFERENCES `%prefix%dashboards` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_%prefix%dashboard_has_widgets_%prefix%dashboard_widgets` FOREIGN KEY (`widget_id`) REFERENCES `%prefix%dashboard_widgets` (`widget_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `%prefix%dashboard_widgets` (
  `widget_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `widget_name` varchar(255) NOT NULL,
  `widget_module` varchar(255) DEFAULT NULL,
  `widget_controller` varchar(255) NOT NULL,
  `preferred_column` tinyint(3) unsigned NOT NULL,
  `icon` varchar(50) DEFAULT NULL,
  `allow_in_global` enum('Y','N') NOT NULL DEFAULT 'N',
  PRIMARY KEY (`widget_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `%prefix%dashboard_widget_data` (
  `widget_id` int(11) unsigned NOT NULL,
  `dashboard_id` int(11) unsigned NOT NULL,
  `data` mediumtext DEFAULT NULL,
  PRIMARY KEY (`widget_id`),
  UNIQUE KEY `widget_id_dashboard_id` (`widget_id`,`dashboard_id`),
  KEY `FK_%prefix%dashboard_widgets_data_%prefix%dashboards` (`dashboard_id`),
  CONSTRAINT `FK_%prefix%dashboard_widgets_data_%prefix%dashboard_widgets` FOREIGN KEY (`widget_id`) REFERENCES `%prefix%dashboard_widgets` (`widget_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_%prefix%dashboard_widgets_data_%prefix%dashboards` FOREIGN KEY (`dashboard_id`) REFERENCES `%prefix%dashboards` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `%prefix%dashboard_widget_permissions` (
  `widget_id` int(11) unsigned NOT NULL,
  `needed_group` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`widget_id`),
  KEY `FK_%prefix%dashboard_widget_permissions_%prefix%rbac_groups` (`needed_group`),
  CONSTRAINT `FK_%prefix%dashboard_widget_permissions_%prefix%dashboard_widgets` FOREIGN KEY (`widget_id`) REFERENCES `%prefix%dashboard_widgets` (`widget_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_%prefix%dashboard_widget_permissions_%prefix%rbac_groups` FOREIGN KEY (`needed_group`) REFERENCES `%prefix%rbac_groups` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `%prefix%forms` (
  `form_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `form_name` varchar(50) NOT NULL,
  `action` varchar(50) DEFAULT NULL,
  `defined_by` int(11) unsigned NOT NULL,
  PRIMARY KEY (`form_id`),
  KEY `FK_%prefix%forms_%prefix%addons` (`defined_by`),
  CONSTRAINT `FK_%prefix%forms_%prefix%addons` FOREIGN KEY (`defined_by`) REFERENCES `%prefix%addons` (`addon_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `%prefix%forms_fielddefinitions` (
  `field_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `mapto` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `helptext` tinytext DEFAULT NULL,
  `pattern` varchar(50) DEFAULT NULL,
  `defined_by` int(11) unsigned NOT NULL,
  PRIMARY KEY (`field_id`),
  KEY `FK_%prefix%forms_fielddefinitions_%prefix%addons` (`defined_by`),
  CONSTRAINT `FK_%prefix%forms_fielddefinitions_%prefix%addons` FOREIGN KEY (`defined_by`) REFERENCES `%prefix%addons` (`addon_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `%prefix%forms_fieldtypes` (
  `type_id` int(3) unsigned NOT NULL AUTO_INCREMENT,
  `fieldtype` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `%prefix%forms_has_fields` (
  `form_id` int(10) unsigned NOT NULL,
  `field_id` int(11) unsigned NOT NULL,
  `type_id` int(3) unsigned NOT NULL,
  `fieldset` varchar(50) NOT NULL,
  `position` int(3) unsigned NOT NULL DEFAULT 1,
  `value` text DEFAULT NULL,
  `data` text DEFAULT NULL,
  `disabled` char(1) DEFAULT NULL,
  `required` char(1) DEFAULT NULL,
  `fieldhandler` varchar(50) DEFAULT NULL,
  `params` varchar(50) DEFAULT NULL,
  KEY `FK_%prefix%forms_has_fields_%prefix%forms` (`form_id`),
  KEY `FK_%prefix%forms_has_fields_%prefix%forms_fielddefinitions` (`field_id`),
  KEY `FK_%prefix%forms_has_fields_%prefix%forms_fieldtypes` (`type_id`),
  CONSTRAINT `FK_%prefix%forms_has_fields_%prefix%forms` FOREIGN KEY (`form_id`) REFERENCES `%prefix%forms` (`form_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_%prefix%forms_has_fields_%prefix%forms_fielddefinitions` FOREIGN KEY (`field_id`) REFERENCES `%prefix%forms_fielddefinitions` (`field_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_%prefix%forms_has_fields_%prefix%forms_fieldtypes` FOREIGN KEY (`type_id`) REFERENCES `%prefix%forms_fieldtypes` (`type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `%prefix%item_states` (
  `state_id` int(2) unsigned NOT NULL AUTO_INCREMENT,
  `state_name` varchar(30) NOT NULL DEFAULT '0',
  PRIMARY KEY (`state_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `%prefix%media_data` (
  `media_id` int(11) unsigned NOT NULL,
  `attribute` varchar(50) NOT NULL,
  `value` text NOT NULL,
  KEY `FK_%prefix%media_data_%prefix%media` (`media_id`),
  CONSTRAINT `FK_%prefix%media_data_%prefix%media` FOREIGN KEY (`media_id`) REFERENCES `%prefix%media_files` (`media_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `%prefix%media_dirs` (
  `dir_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(11) unsigned NOT NULL,
  `path` text NOT NULL,
  `deleted` char(1) DEFAULT NULL,
  `protected` char(1) DEFAULT NULL,
  PRIMARY KEY (`dir_id`),
  KEY `FK_%prefix%media_dirs_%prefix%sites` (`site_id`),
  CONSTRAINT `FK_%prefix%media_dirs_%prefix%sites` FOREIGN KEY (`site_id`) REFERENCES `%prefix%sites` (`site_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `%prefix%media_files` (
  `media_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(11) unsigned NOT NULL,
  `dir_id` int(11) unsigned NOT NULL,
  `filename` text DEFAULT NULL,
  `checksum` text DEFAULT NULL,
  `deleted` char(1) DEFAULT NULL,
  PRIMARY KEY (`media_id`),
  KEY `FK_%prefix%media_%prefix%sites` (`site_id`),
  KEY `FK_%prefix%media_files_%prefix%media_dirs` (`dir_id`),
  CONSTRAINT `FK_%prefix%media_%prefix%sites` FOREIGN KEY (`site_id`) REFERENCES `%prefix%sites` (`site_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_%prefix%media_files_%prefix%media_dirs` FOREIGN KEY (`dir_id`) REFERENCES `%prefix%media_dirs` (`dir_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `%prefix%menus` (
  `menu_id` int(5) unsigned NOT NULL AUTO_INCREMENT,
  `type_id` int(3) unsigned NOT NULL,
  `menu_name` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `core` char(1) COLLATE utf8mb4_bin NOT NULL DEFAULT 'N',
  `protected` char(1) COLLATE utf8mb4_bin NOT NULL DEFAULT 'N',
  `info` text COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`menu_id`),
  UNIQUE KEY `menu_id_type_id_menu_name` (`menu_id`,`type_id`,`menu_name`),
  KEY `FK_%prefix%menus_%prefix%menu_types` (`type_id`),
  CONSTRAINT `FK_%prefix%menus_%prefix%menu_types` FOREIGN KEY (`type_id`) REFERENCES `%prefix%menutypes` (`type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `%prefix%menutypes` (
  `type_id` int(3) unsigned NOT NULL AUTO_INCREMENT,
  `type_name` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  `description` text COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `%prefix%menutype_options` (
  `option_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `option_name` text COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  PRIMARY KEY (`option_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='Available options for menus';

CREATE TABLE IF NOT EXISTS `%prefix%menutype_settings` (
  `type_id` int(11) unsigned NOT NULL,
  `option_id` int(11) unsigned NOT NULL,
  `default_value` text COLLATE utf8mb4_bin DEFAULT NULL,
  `value` text COLLATE utf8mb4_bin DEFAULT NULL,
  KEY `FK_%prefix%menutype_settings_%prefix%menutypes` (`type_id`),
  KEY `FK_%prefix%menutype_settings_%prefix%menutype_options` (`option_id`),
  CONSTRAINT `FK_%prefix%menutype_settings_%prefix%menutype_options` FOREIGN KEY (`option_id`) REFERENCES `%prefix%menutype_options` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_%prefix%menutype_settings_%prefix%menutypes` FOREIGN KEY (`type_id`) REFERENCES `%prefix%menutypes` (`type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `%prefix%menu_on_site` (
  `menu_id` int(5) unsigned NOT NULL,
  `site_id` int(11) unsigned NOT NULL,
  KEY `FK_%prefix%menu_on_site_%prefix%menus` (`menu_id`),
  KEY `FK_%prefix%menu_on_site_%prefix%sites` (`site_id`),
  CONSTRAINT `FK_%prefix%menu_on_site_%prefix%menus` FOREIGN KEY (`menu_id`) REFERENCES `%prefix%menus` (`menu_id`),
  CONSTRAINT `FK_%prefix%menu_on_site_%prefix%sites` FOREIGN KEY (`site_id`) REFERENCES `%prefix%sites` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `%prefix%menu_options` (
  `menu_id` int(11) unsigned NOT NULL,
  `option_id` int(11) unsigned NOT NULL,
  `site_id` int(11) unsigned NOT NULL,
  `value` text COLLATE utf8mb4_bin NOT NULL,
  UNIQUE KEY `menu_id_option_id_site_id` (`menu_id`,`option_id`,`site_id`),
  KEY `FK_%prefix%menu_options_%prefix%menutype_options` (`option_id`),
  CONSTRAINT `FK_%prefix%menu_options_%prefix%menus` FOREIGN KEY (`menu_id`) REFERENCES `%prefix%menus` (`menu_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_%prefix%menu_options_%prefix%menutype_options` FOREIGN KEY (`option_id`) REFERENCES `%prefix%menutype_options` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `%prefix%mimetypes` (
  `mime_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `mime_type` varchar(50) NOT NULL,
  `mime_suffixes` text DEFAULT NULL,
  `mime_label` varchar(50) DEFAULT NULL,
  `mime_icon` varchar(50) DEFAULT NULL,
  `mime_allowed_for` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`mime_id`),
  KEY `mime_id` (`mime_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `%prefix%module_routes` (
  `page_id` int(11) unsigned NOT NULL,
  `section_id` int(11) unsigned NOT NULL,
  `addon_id` int(11) unsigned NOT NULL,
  `route` text COLLATE utf8mb4_bin NOT NULL,
  `params` text COLLATE utf8mb4_bin DEFAULT NULL,
  KEY `FK_%prefix%module_routes_%prefix%addons` (`addon_id`),
  KEY `FK_%prefix%module_routes_%prefix%pages` (`page_id`),
  KEY `FK_%prefix%module_routes_%prefix%sections` (`section_id`),
  CONSTRAINT `FK_%prefix%module_routes_%prefix%addons` FOREIGN KEY (`addon_id`) REFERENCES `%prefix%addons` (`addon_id`),
  CONSTRAINT `FK_%prefix%module_routes_%prefix%pages` FOREIGN KEY (`page_id`) REFERENCES `%prefix%pages` (`page_id`),
  CONSTRAINT `FK_%prefix%module_routes_%prefix%sections` FOREIGN KEY (`section_id`) REFERENCES `%prefix%sections` (`section_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `%prefix%mod_droplets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `code` longtext NOT NULL,
  `description` text NOT NULL,
  `modified_when` int(11) NOT NULL DEFAULT 0,
  `modified_by` int(11) NOT NULL DEFAULT 0,
  `active` int(11) NOT NULL DEFAULT 1,
  `admin_edit` int(11) NOT NULL DEFAULT 1,
  `admin_view` int(11) NOT NULL DEFAULT 1,
  `show_wysiwyg` int(11) NOT NULL DEFAULT 1,
  `comments` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `%prefix%mod_droplets_extension` (
  `drop_id` int(11) NOT NULL AUTO_INCREMENT,
  `drop_droplet_name` varchar(255) NOT NULL DEFAULT '',
  `drop_page_id` int(11) NOT NULL DEFAULT -1,
  `drop_module_dir` varchar(255) NOT NULL DEFAULT '',
  `drop_type` varchar(20) NOT NULL DEFAULT 'undefined',
  `drop_file` varchar(255) NOT NULL DEFAULT '',
  `drop_timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`drop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `%prefix%mod_droplets_permissions` (
  `id` int(10) unsigned NOT NULL,
  `edit_groups` varchar(50) NOT NULL,
  `view_groups` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `%prefix%mod_droplets_settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attribute` varchar(50) NOT NULL DEFAULT '0',
  `value` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `%prefix%mod_filter` (
  `id` int(11) unsigned NOT NULL,
  `filter_name` varchar(50) NOT NULL,
  `module_name` varchar(50) DEFAULT NULL,
  `filter_description` text DEFAULT NULL,
  `filter_code` text DEFAULT NULL,
  `filter_active` enum('Y','N') NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`id`),
  UNIQUE KEY `filter_name_module_name` (`filter_name`,`module_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Successor of Output Filters';

CREATE TABLE IF NOT EXISTS `%prefix%mod_stats_reload` (
  `page_id` int(11) unsigned NOT NULL,
  `hash` text COLLATE utf8mb4_bin NOT NULL,
  `timestamp` text COLLATE utf8mb4_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `%prefix%mod_wysiwyg` (
  `section_id` int(11) NOT NULL DEFAULT 0,
  `column` int(3) NOT NULL DEFAULT 1,
  `attribute` varchar(255) DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  `text` longtext DEFAULT NULL,
  UNIQUE KEY `section_id_column_attribute` (`section_id`,`column`,`attribute`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `%prefix%mod_wysiwyg_revisions` (
  `section_id` int(11) NOT NULL DEFAULT 0,
  `revision` varchar(50) NOT NULL DEFAULT '0',
  `date` int(11) NOT NULL DEFAULT 0,
  `content` longtext DEFAULT NULL,
  `text` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

CREATE TABLE IF NOT EXISTS `%prefix%mod_wysiwyg_settings` (
  `site_id` int(11) unsigned NOT NULL,
  `group_id` int(11) unsigned NOT NULL,
  `editor_id` int(11) unsigned NOT NULL,
  `option` varchar(50) NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`site_id`,`group_id`,`editor_id`,`option`),
  KEY `FK_%prefix%mod_wysiwyg_settings_%prefix%rbac_groups` (`group_id`),
  KEY `FK_%prefix%mod_wysiwyg_settings_%prefix%addons` (`editor_id`),
  CONSTRAINT `FK_%prefix%mod_wysiwyg_settings_%prefix%addons` FOREIGN KEY (`editor_id`) REFERENCES `%prefix%addons` (`addon_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_%prefix%mod_wysiwyg_settings_%prefix%rbac_groups` FOREIGN KEY (`group_id`) REFERENCES `%prefix%rbac_groups` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_%prefix%mod_wysiwyg_settings_%prefix%sites` FOREIGN KEY (`site_id`) REFERENCES `%prefix%sites` (`site_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `%prefix%pages` (
  `page_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(11) unsigned NOT NULL,
  `page_visibility` int(2) unsigned NOT NULL DEFAULT 7,
  `parent` int(11) unsigned NOT NULL DEFAULT 0,
  `level` int(11) unsigned NOT NULL DEFAULT 0,
  `ordering` int(11) unsigned NOT NULL DEFAULT 10,
  `page_title` varchar(255) NOT NULL DEFAULT '',
  `menu_title` varchar(255) NOT NULL DEFAULT '',
  `description` text DEFAULT NULL,
  `menu` int(11) NOT NULL DEFAULT 1,
  `language` varchar(5) NOT NULL DEFAULT '',
  `searching` int(11) NOT NULL DEFAULT 1,
  `created_by` int(11) unsigned NOT NULL DEFAULT 1,
  `modified_by` int(11) unsigned NOT NULL DEFAULT 0,
  `modified_when` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`page_id`),
  KEY `FK_%prefix%pages_%prefix%visibility` (`page_visibility`),
  KEY `FK_%prefix%pages_%prefix%rbac_users` (`created_by`),
  KEY `FK_%prefix%pages_%prefix%rbac_users_2` (`modified_by`),
  KEY `FK_%prefix%pages_%prefix%sites` (`site_id`),
  CONSTRAINT `FK_%prefix%pages_%prefix%rbac_users` FOREIGN KEY (`created_by`) REFERENCES `%prefix%rbac_users` (`user_id`),
  CONSTRAINT `FK_%prefix%pages_%prefix%rbac_users_2` FOREIGN KEY (`modified_by`) REFERENCES `%prefix%rbac_users` (`user_id`),
  CONSTRAINT `FK_%prefix%pages_%prefix%sites` FOREIGN KEY (`site_id`) REFERENCES `%prefix%sites` (`site_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_%prefix%pages_%prefix%visibility` FOREIGN KEY (`page_visibility`) REFERENCES `%prefix%visibility` (`vis_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `%prefix%pages_headers` (
  `page_id` int(11) unsigned NOT NULL,
  `page_js_files` text DEFAULT NULL,
  `page_css_files` text DEFAULT NULL,
  `page_js` text DEFAULT NULL,
  `use_core` enum('Y','N') DEFAULT NULL,
  `use_ui` enum('Y','N') DEFAULT NULL,
  PRIMARY KEY (`page_id`),
  UNIQUE KEY `page_id` (`page_id`),
  CONSTRAINT `FK_%prefix%pages_headers_%prefix%pages` FOREIGN KEY (`page_id`) REFERENCES `%prefix%pages` (`page_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='header files';

CREATE TABLE IF NOT EXISTS `%prefix%pages_langs` (
  `page_id` int(11) unsigned NOT NULL,
  `lang` char(2) NOT NULL,
  `link_page_id` int(10) NOT NULL,
  UNIQUE KEY `page_id_lang_link_page_id` (`page_id`,`lang`,`link_page_id`),
  CONSTRAINT `FK_%prefix%pages_langs_%prefix%pages` FOREIGN KEY (`page_id`) REFERENCES `%prefix%pages` (`page_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Links pages of different languages together';

CREATE TABLE IF NOT EXISTS `%prefix%pages_routes` (
  `page_id` int(11) unsigned NOT NULL,
  `route` text COLLATE utf8mb4_bin NOT NULL,
  KEY `FK_%prefix%pages_routes_%prefix%pages` (`page_id`),
  CONSTRAINT `FK_%prefix%pages_routes_%prefix%pages` FOREIGN KEY (`page_id`) REFERENCES `%prefix%pages` (`page_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `%prefix%pages_sections` (
  `page_id` int(11) unsigned NOT NULL,
  `section_id` int(11) unsigned NOT NULL,
  `position` int(11) NOT NULL DEFAULT 0,
  `block` varchar(255) NOT NULL DEFAULT '',
  `publ_start` varchar(255) NOT NULL DEFAULT '0',
  `publ_end` varchar(255) NOT NULL DEFAULT '0',
  `publ_by_time_start` varchar(255) NOT NULL DEFAULT '0',
  `publ_by_time_end` varchar(255) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT 'no name',
  `visible` char(1) NOT NULL DEFAULT 'Y',
  `variant` varchar(50) DEFAULT NULL,
  KEY `FK_%prefix%pages_sections_%prefix%pages` (`page_id`),
  KEY `FK_%prefix%pages_sections_%prefix%sections` (`section_id`),
  CONSTRAINT `FK_%prefix%pages_sections_%prefix%pages` FOREIGN KEY (`page_id`) REFERENCES `%prefix%pages` (`page_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_%prefix%pages_sections_%prefix%sections` FOREIGN KEY (`section_id`) REFERENCES `%prefix%sections` (`section_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='maps sections to pages';

CREATE TABLE IF NOT EXISTS `%prefix%pages_settings` (
  `page_id` int(11) unsigned NOT NULL,
  `set_type` enum('internal','meta') NOT NULL DEFAULT 'internal',
  `set_name` varchar(50) NOT NULL,
  `set_value` tinytext NOT NULL,
  PRIMARY KEY (`page_id`),
  UNIQUE KEY `set_type_set_name` (`page_id`,`set_type`,`set_name`),
  CONSTRAINT `FK_%prefix%pages_settings_%prefix%pages` FOREIGN KEY (`page_id`) REFERENCES `%prefix%pages` (`page_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Additional settings for pages';

CREATE TABLE IF NOT EXISTS `%prefix%pages_tags` (
  `page_id` int(11) unsigned NOT NULL,
  `tag_id` int(11) unsigned NOT NULL,
  KEY `FK_%prefix%pages_tags_%prefix%pages` (`page_id`),
  KEY `FK_%prefix%pages_tags_%prefix%tags` (`tag_id`),
  CONSTRAINT `FK_%prefix%pages_tags_%prefix%pages` FOREIGN KEY (`page_id`) REFERENCES `%prefix%pages` (`page_id`),
  CONSTRAINT `FK_%prefix%pages_tags_%prefix%tags` FOREIGN KEY (`tag_id`) REFERENCES `%prefix%tags` (`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='assign tags to pages';

CREATE TABLE IF NOT EXISTS `%prefix%pages_tags_categories` (
  `page_id` int(11) unsigned NOT NULL,
  `%prefix%id` int(11) unsigned NOT NULL,
  KEY `FK_%prefix%pages_tags_categories_%prefix%pages` (`page_id`),
  KEY `FK_%prefix%pages_tags_categories_%prefix%tags_categories` (`%prefix%id`),
  CONSTRAINT `FK_%prefix%pages_tags_categories_%prefix%pages` FOREIGN KEY (`page_id`) REFERENCES `%prefix%pages` (`page_id`),
  CONSTRAINT `FK_%prefix%pages_tags_categories_%prefix%tags_categories` FOREIGN KEY (`%prefix%id`) REFERENCES `%prefix%tags_categories` (`%prefix%id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='assign tag categories to pages';

CREATE TABLE IF NOT EXISTS `%prefix%pages_template` (
  `page_id` int(11) unsigned NOT NULL,
  `tpl_id` int(11) unsigned NOT NULL,
  `variant` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  KEY `FK_%prefix%pages_template_%prefix%pages` (`page_id`),
  KEY `FK_%prefix%pages_template_%prefix%addons` (`tpl_id`),
  CONSTRAINT `FK_%prefix%pages_template_%prefix%addons` FOREIGN KEY (`tpl_id`) REFERENCES `%prefix%addons` (`addon_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_%prefix%pages_template_%prefix%pages` FOREIGN KEY (`page_id`) REFERENCES `%prefix%pages` (`page_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='Maps pages to templates';

CREATE TABLE IF NOT EXISTS `%prefix%pages_visits` (
  `page_id` int(11) unsigned NOT NULL,
  `visits` int(11) unsigned NOT NULL DEFAULT 1,
  `last` tinytext COLLATE utf8mb4_bin NOT NULL,
  UNIQUE KEY `page_id` (`page_id`),
  CONSTRAINT `FK_%prefix%pages_visits_%prefix%pages` FOREIGN KEY (`page_id`) REFERENCES `%prefix%pages` (`page_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `%prefix%protected_routes` (
  `site_id` int(11) unsigned NOT NULL,
  `needed_perm` int(11) unsigned NOT NULL,
  `route` tinytext COLLATE utf8mb4_bin NOT NULL,
  KEY `FK_%prefix%protected_routes_%prefix%sites` (`site_id`),
  KEY `FK_%prefix%protected_routes_%prefix%rbac_permissions` (`needed_perm`),
  CONSTRAINT `FK_%prefix%protected_routes_%prefix%rbac_permissions` FOREIGN KEY (`needed_perm`) REFERENCES `%prefix%rbac_permissions` (`perm_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_%prefix%protected_routes_%prefix%sites` FOREIGN KEY (`site_id`) REFERENCES `%prefix%sites` (`site_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `%prefix%rbac_grouproles` (
  `group_id` int(11) unsigned NOT NULL,
  `role_id` int(11) unsigned NOT NULL,
  `AssignmentDate` int(11) NOT NULL,
  PRIMARY KEY (`group_id`,`role_id`),
  KEY `FK_%prefix%rbac_grouproles_%prefix%rbac_roles` (`role_id`),
  CONSTRAINT `FK_%prefix%rbac_grouproles_%prefix%rbac_groups` FOREIGN KEY (`group_id`) REFERENCES `%prefix%rbac_groups` (`group_id`),
  CONSTRAINT `FK_%prefix%rbac_grouproles_%prefix%rbac_roles` FOREIGN KEY (`role_id`) REFERENCES `%prefix%rbac_roles` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `%prefix%rbac_groups` (
  `group_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `group_title` varchar(255) NOT NULL DEFAULT '',
  `group_description` text NOT NULL,
  `group_builtin` enum('Y','N') NOT NULL DEFAULT 'N',
  `group_wysiwyg` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `%prefix%rbac_pageowner` (
  `page_id` int(11) unsigned NOT NULL,
  `owner_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`page_id`),
  KEY `FK_%prefix%rbac_pageperms_%prefix%rbac_users` (`owner_id`),
  CONSTRAINT `FK_%prefix%rbac_pageowner_%prefix%pages` FOREIGN KEY (`page_id`) REFERENCES `%prefix%pages` (`page_id`),
  CONSTRAINT `FK_%prefix%rbac_pageperms_%prefix%rbac_users` FOREIGN KEY (`owner_id`) REFERENCES `%prefix%rbac_users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `%prefix%rbac_permissions` (
  `perm_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `area` enum('backend','frontend') COLLATE utf8_bin NOT NULL,
  `group` varchar(50) COLLATE utf8_bin NOT NULL,
  `title` char(64) COLLATE utf8_bin NOT NULL,
  `description` text COLLATE utf8_bin NOT NULL,
  `position` int(2) unsigned NOT NULL DEFAULT 1,
  `requires` int(11) DEFAULT NULL,
  `implicit` char(1) COLLATE utf8_bin NOT NULL DEFAULT 'N',
  `defined_by` int(11) unsigned NOT NULL,
  PRIMARY KEY (`perm_id`),
  UNIQUE KEY `perm_id_area_group_title` (`perm_id`,`area`,`group`,`title`),
  KEY `FK_%prefix%rbac_permissions_%prefix%addons` (`defined_by`),
  CONSTRAINT `FK_%prefix%rbac_permissions_%prefix%addons` FOREIGN KEY (`defined_by`) REFERENCES `%prefix%addons` (`addon_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS `%prefix%rbac_rolepermissions` (
  `role_id` int(11) unsigned NOT NULL,
  `perm_id` int(11) unsigned NOT NULL,
  `AssignmentDate` int(11) DEFAULT NULL,
  PRIMARY KEY (`role_id`,`perm_id`),
  KEY `FK_%prefix%rbac_rolepermissions_%prefix%rbac_permissions` (`perm_id`),
  CONSTRAINT `FK_%prefix%rbac_rolepermissions_%prefix%rbac_permissions` FOREIGN KEY (`perm_id`) REFERENCES `%prefix%rbac_permissions` (`perm_id`),
  CONSTRAINT `FK_%prefix%rbac_rolepermissions_%prefix%rbac_roles` FOREIGN KEY (`role_id`) REFERENCES `%prefix%rbac_roles` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS `%prefix%rbac_roles` (
  `role_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `role_title` varchar(128) COLLATE utf8_bin NOT NULL,
  `role_description` text COLLATE utf8_bin NOT NULL,
  `builtin` enum('Y','N') COLLATE utf8_bin NOT NULL DEFAULT 'N',
  `protected` enum('Y','N') COLLATE utf8_bin NOT NULL DEFAULT 'N',
  PRIMARY KEY (`role_id`),
  KEY `Title` (`role_title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS `%prefix%rbac_role_has_modules` (
  `id` int(11) unsigned NOT NULL,
  `role_id` int(11) unsigned NOT NULL,
  `addon_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_%prefix%rbac_role_has_modules_%prefix%rbac_roles` (`role_id`),
  KEY `FK_%prefix%rbac_role_has_modules_%prefix%addons` (`addon_id`),
  CONSTRAINT `FK_%prefix%rbac_role_has_modules_%prefix%addons` FOREIGN KEY (`addon_id`) REFERENCES `%prefix%addons` (`addon_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_%prefix%rbac_role_has_modules_%prefix%rbac_roles` FOREIGN KEY (`role_id`) REFERENCES `%prefix%rbac_roles` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Module access permissions for roles';

CREATE TABLE IF NOT EXISTS `%prefix%rbac_usergroups` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `group_id` int(11) unsigned NOT NULL,
  `primary` enum('Y','N') NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `FK_%prefix%rbac_usergroups_%prefix%rbac_groups` (`group_id`),
  KEY `FK_%prefix%rbac_usergroups_%prefix%rbac_users` (`user_id`),
  CONSTRAINT `FK_%prefix%rbac_usergroups_%prefix%rbac_groups` FOREIGN KEY (`group_id`) REFERENCES `%prefix%rbac_groups` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_%prefix%rbac_usergroups_%prefix%rbac_users` FOREIGN KEY (`user_id`) REFERENCES `%prefix%rbac_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps users to groups';

CREATE TABLE IF NOT EXISTS `%prefix%rbac_userroles` (
  `user_id` int(11) unsigned NOT NULL,
  `role_id` int(11) unsigned NOT NULL,
  `AssignmentDate` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `FK_%prefix%rbac_userroles_%prefix%rbac_roles` (`role_id`),
  CONSTRAINT `FK_%prefix%rbac_userroles_%prefix%rbac_roles` FOREIGN KEY (`role_id`) REFERENCES `%prefix%rbac_roles` (`role_id`),
  CONSTRAINT `FK_%prefix%rbac_userroles_%prefix%rbac_users` FOREIGN KEY (`user_id`) REFERENCES `%prefix%rbac_users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS `%prefix%rbac_users` (
  `user_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL DEFAULT '',
  `password` varchar(255) DEFAULT '',
  `last_reset` int(11) DEFAULT 0,
  `display_name` varchar(255) DEFAULT '',
  `email` text DEFAULT NULL,
  `language` varchar(5) DEFAULT 'DE',
  `home_folder` varchar(255) DEFAULT '',
  `login_when` int(11) DEFAULT 0,
  `login_ip` varchar(15) DEFAULT '',
  `login_token` text DEFAULT '',
  `tfa_secret` varchar(50) DEFAULT NULL,
  `tfa_enabled` char(1) NOT NULL DEFAULT 'N',
  `protected` char(1) NOT NULL DEFAULT 'N',
  `active` char(1) NOT NULL DEFAULT 'Y',
  `locked` char(1) NOT NULL DEFAULT 'N',
  `wysiwyg` int(11) unsigned DEFAULT NULL,
  `default_page` tinytext DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `FK_%prefix%rbac_users_%prefix%addons` (`wysiwyg`),
  CONSTRAINT `FK_%prefix%rbac_users_%prefix%addons` FOREIGN KEY (`wysiwyg`) REFERENCES `%prefix%addons` (`addon_id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `%prefix%rbac_user_extend` (
  `user_id` int(11) unsigned NOT NULL,
  `option` varchar(50) NOT NULL,
  `value` varchar(50) NOT NULL,
  UNIQUE KEY `user_id_option` (`user_id`,`option`),
  CONSTRAINT `FK_%prefix%rbac_user_settings_%prefix%rbac_users` FOREIGN KEY (`user_id`) REFERENCES `%prefix%rbac_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `%prefix%rbac_user_settings` (
  `site_id` int(11) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `fieldset` varchar(255) NOT NULL,
  `fieldtype` int(3) unsigned NOT NULL,
  `label` varchar(50) DEFAULT NULL,
  `position` int(3) unsigned NOT NULL DEFAULT 1,
  `default_value` text DEFAULT NULL,
  `is_editable` enum('Y','N') NOT NULL DEFAULT 'Y',
  `is_required` enum('Y','N') NOT NULL DEFAULT 'N',
  `helptext` tinytext DEFAULT NULL,
  `fieldhandler` varchar(50) DEFAULT NULL,
  `params` varchar(50) DEFAULT NULL,
  UNIQUE KEY `site_id_name` (`site_id`,`name`),
  KEY `FK_%prefix%rbac_user_settings_%prefix%forms_fieldtypes` (`fieldtype`),
  CONSTRAINT `FK_%prefix%rbac_user_settings_%prefix%forms_fieldtypes` FOREIGN KEY (`fieldtype`) REFERENCES `%prefix%forms_fieldtypes` (`type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_%prefix%rbac_user_settings_%prefix%sites` FOREIGN KEY (`site_id`) REFERENCES `%prefix%sites` (`site_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='extends the user form';

CREATE TABLE IF NOT EXISTS `%prefix%sections` (
  `section_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(11) unsigned NOT NULL DEFAULT 0,
  `state_id` int(2) unsigned NOT NULL DEFAULT 1,
  `module_id` int(11) unsigned NOT NULL,
  `modified_when` int(11) NOT NULL DEFAULT 0,
  `modified_by` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`section_id`,`site_id`),
  UNIQUE KEY `section_id_site_id` (`section_id`,`site_id`),
  KEY `FK_%prefix%sections_%prefix%sites` (`site_id`),
  KEY `FK_%prefix%sections_%prefix%item_states` (`state_id`),
  KEY `FK_%prefix%sections_%prefix%addons` (`module_id`),
  CONSTRAINT `FK_%prefix%sections_%prefix%addons` FOREIGN KEY (`module_id`) REFERENCES `%prefix%addons` (`addon_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_%prefix%sections_%prefix%item_states` FOREIGN KEY (`state_id`) REFERENCES `%prefix%item_states` (`state_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_%prefix%sections_%prefix%sites` FOREIGN KEY (`site_id`) REFERENCES `%prefix%sites` (`site_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `%prefix%section_options` (
  `page_id` int(11) unsigned NOT NULL,
  `section_id` int(11) unsigned NOT NULL,
  `option` varchar(50) NOT NULL,
  `value` text NOT NULL,
  UNIQUE KEY `page_id_section_id` (`page_id`,`section_id`,`option`),
  KEY `FK_%prefix%section_options_%prefix%sections` (`section_id`),
  CONSTRAINT `FK_%prefix%section_options_%prefix%pages` FOREIGN KEY (`page_id`) REFERENCES `%prefix%pages` (`page_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_%prefix%section_options_%prefix%sections` FOREIGN KEY (`section_id`) REFERENCES `%prefix%sections` (`section_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `%prefix%sessions` (
  `sess_id` char(128) NOT NULL,
  `sess_lifetime` varchar(50) NOT NULL,
  `sess_time` varchar(50) NOT NULL,
  `sess_data` text NOT NULL,
  PRIMARY KEY (`sess_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `%prefix%settings` (
  `setting_id` int(11) NOT NULL AUTO_INCREMENT,
  `region` varchar(20) NOT NULL DEFAULT 'common',
  `name` varchar(255) NOT NULL,
  `default_value` text DEFAULT NULL,
  `is_editable` enum('Y','N') NOT NULL DEFAULT 'Y',
  `is_global` enum('Y','N') NOT NULL DEFAULT 'Y',
  `is_site` enum('Y','N') NOT NULL DEFAULT 'Y',
  `fieldtype` int(3) unsigned NOT NULL,
  `label` varchar(50) DEFAULT NULL,
  `helptext` tinytext DEFAULT NULL,
  `route` tinytext DEFAULT NULL,
  `fieldhandler` varchar(50) DEFAULT NULL,
  `params` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`setting_id`),
  KEY `FK_%prefix%settings_%prefix%forms_fieldtypes` (`fieldtype`),
  CONSTRAINT `FK_%prefix%settings_%prefix%forms_fieldtypes` FOREIGN KEY (`fieldtype`) REFERENCES `%prefix%forms_fieldtypes` (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `%prefix%settings_global` (
  `name` varchar(50) NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `name_value` (`name`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `%prefix%settings_site` (
  `site_id` int(11) unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  `value` varchar(150) NOT NULL,
  PRIMARY KEY (`site_id`,`name`),
  UNIQUE KEY `site_id_name_value` (`site_id`,`name`,`value`),
  CONSTRAINT `FK_%prefix%settings_site_%prefix%sites` FOREIGN KEY (`site_id`) REFERENCES `%prefix%sites` (`site_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

CREATE TABLE IF NOT EXISTS `%prefix%sites` (
  `site_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_owner` int(11) unsigned NOT NULL DEFAULT 0,
  `site_basedir` mediumtext NOT NULL,
  `site_folder` varchar(50) DEFAULT NULL,
  `site_name` varchar(50) DEFAULT NULL,
  `site_url` mediumtext DEFAULT NULL,
  PRIMARY KEY (`site_id`),
  KEY `FK_%prefix%sites_%prefix%rbac_users` (`site_owner`),
  CONSTRAINT `FK_%prefix%sites_%prefix%rbac_users` FOREIGN KEY (`site_owner`) REFERENCES `%prefix%rbac_users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `%prefix%socialmedia` (
  `id` int(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` text COLLATE utf8mb4_bin NOT NULL,
  `follow_url` text COLLATE utf8mb4_bin DEFAULT NULL,
  `share_url` text COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `%prefix%socialmedia_site` (
  `id` int(3) unsigned NOT NULL,
  `site_id` int(11) unsigned NOT NULL,
  `account` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `follow_url` text COLLATE utf8mb4_bin DEFAULT NULL,
  `share_url` text COLLATE utf8mb4_bin DEFAULT NULL,
  `follow_disabled` char(1) COLLATE utf8mb4_bin DEFAULT 'Y',
  `share_disabled` char(1) COLLATE utf8mb4_bin DEFAULT 'Y',
  UNIQUE KEY `site_id_socialmedia_id` (`site_id`,`id`),
  KEY `FK_%prefix%socialmedia_global_%prefix%socialmedia` (`id`),
  CONSTRAINT `FK_%prefix%socialmedia_global_%prefix%sites` FOREIGN KEY (`site_id`) REFERENCES `%prefix%sites` (`site_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_%prefix%socialmedia_global_%prefix%socialmedia` FOREIGN KEY (`id`) REFERENCES `%prefix%socialmedia` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `%prefix%tags` (
  `tag_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `tag_name` tinytext COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `%prefix%tags_categories` (
  `%prefix%id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `%prefix%name` tinytext COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`%prefix%id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `%prefix%template_options` (
  `tpl_id` int(11) unsigned NOT NULL,
  `page_id` int(11) unsigned NOT NULL,
  `opt_name` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `opt_value` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  UNIQUE KEY `tpl_id_page_id_opt_name` (`tpl_id`,`page_id`,`opt_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='Templates may have options';

CREATE TABLE IF NOT EXISTS `%prefix%visibility` (
  `vis_id` int(2) unsigned NOT NULL AUTO_INCREMENT,
  `vis_name` varchar(50) NOT NULL,
  `vis_info` varchar(100) NOT NULL,
  PRIMARY KEY (`vis_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
