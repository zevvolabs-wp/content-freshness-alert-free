<?php
/**
 * Plugin Name:       Content Freshness Alert
 * Plugin URI:        https://wordpress.org/plugins/content-freshness-alert/
 * Description:       Monitor content age and receive alerts for outdated posts needing updates. Dashboard widget shows oldest content with color-coded indicators.
 * Version:           1.0.0
 * Requires at least: 5.8
 * Requires PHP:      7.4
 * Author:            zevvolabs
 * Author URI:        https://profiles.wordpress.org/zevvolabs/
 * License:           GPL v2 or later
 * License URI:       https://www.gnu.org/licenses/gpl-2.0.html
 * Text Domain:       content-freshness-alert
 * Domain Path:       /languages
 * Donate link:       https://ko-fi.com/zevvolabs
 *
 * @package ContentFreshnessAlert
 */

// Prevent direct file access
if (!defined('ABSPATH')) {
    exit;
}

// Define constants
$plugin_data = get_file_data(__FILE__, array('Version' => 'Version'));
define('CFA_VERSION', $plugin_data['Version']);
define('CFA_PLUGIN_DIR', plugin_dir_path(__FILE__));
define('CFA_PLUGIN_URL', plugin_dir_url(__FILE__));
define('CFA_THRESHOLD_FRESH', 180);      // 6 months
define('CFA_THRESHOLD_AGING', 365);      // 12 months  
define('CFA_THRESHOLD_STALE', 730);      // 24 months

// Include class files
require_once CFA_PLUGIN_DIR . 'includes/class-age-calculator.php';
require_once CFA_PLUGIN_DIR . 'includes/class-dashboard-widget.php';
require_once CFA_PLUGIN_DIR . 'includes/class-list-table.php';

// Initialize plugin
add_action('plugins_loaded', 'cfa_init');

function cfa_init() {
    load_plugin_textdomain(
        'content-freshness-alert',
        false,
        dirname(plugin_basename(__FILE__)) . '/languages'
    );
}

// Initialize classes
new CFA_Age_Calculator();
new CFA_Dashboard_Widget();
new CFA_List_Table();

// Activation hook
register_activation_hook(__FILE__, 'cfa_activate');

function cfa_activate() {
    if (!wp_next_scheduled('cfa_daily_age_update')) {
        wp_schedule_event(time(), 'daily', 'cfa_daily_age_update');
    }
    
    // Run immediately for instant value
    if (class_exists('CFA_Age_Calculator')) {
        $calculator = new CFA_Age_Calculator();
        $calculator->update_all_ages();
    }
}

// Deactivation hook
register_deactivation_hook(__FILE__, 'cfa_deactivate');

function cfa_deactivate() {
    wp_clear_scheduled_hook('cfa_daily_age_update');
}
