<?php
/**
 * File : unit-config.php
 * Desc : this file contains unit application settings
 */

// Environment Settings
define('ENV_DEV', 'DEV');
define('ENV_RE7', 'RE7');
define('ENV_PROD', 'PROD');

define('UNT_ENV', ENV_DEV);

// Logger Settings
define('LOG_LEVEL_DEBUG', 100);
define('LOG_LEVEL_INFO', 200);
define('LOG_LEVEL_WARNING', 300);
define('LOG_LEVEL_ERROR', 400);

// logs are inside the theme folder
define('UNT_LOG_PATH', '/var/logs/unt.log');
define('UNT_LOG_LEVEL', LOG_LEVEL_DEBUG);

// Direct install extention on local
define('FS_METHOD', 'direct');

// DEV Env Settings
if (UNT_ENV == ENV_DEV) {
    /**
     * Pour les développeurs : le mode déboguage de WordPress.
     *
     * En passant la valeur suivante à "true", vous activez l’affichage des
     * notifications d’erreurs pendant vos essais.
     * Il est fortemment recommandé que les développeurs d’extensions et
     * de thèmes se servent de WP_DEBUG dans leur environnement de
     * développement.
     *
     * Pour plus d’information sur les autres constantes qui peuvent être utilisées
     * pour le déboguage, rendez-vous sur le Codex.
     *
     * @link https://codex.wordpress.org/Debugging_in_WordPress
     */
    // define('WP_DEBUG', true);
    // define('WP_DEBUG_LOG', true);
}
/*
define('FORCE_SSL_ADMIN', true);
// in some setups HTTP_X_FORWARDED_PROTO might contain
// a comma-separated list e.g. http,https
// so check for https existence
if (strpos($_SERVER['HTTP_X_FORWARDED_PROTO'], 'https') !== false)
$_SERVER['HTTPS']='on';
*/
