<?php
/**
 * Uninstall script for Content Freshness Alert
 *
 * This file is executed when the plugin is deleted via WordPress admin.
 * It cleans up all plugin data including post meta and cron jobs.
 *
 * @package ContentFreshnessAlert
 */

// If uninstall not called from WordPress, exit
if (!defined('WP_UNINSTALL_PLUGIN')) {
    exit;
}

// Clear scheduled cron events
wp_clear_scheduled_hook('cfa_daily_age_update');

// Clear transients
delete_transient('cfa_dashboard_widget_data');

// Remove post meta for all posts
global $wpdb;

$wpdb->query(
    $wpdb->prepare(
        "DELETE FROM {$wpdb->postmeta} WHERE meta_key IN (%s, %s)",
        '_cfa_age_days',
        '_cfa_age_category'
    )
);

// Note: We intentionally do NOT delete the plugin files themselves
// WordPress handles that automatically during plugin deletion
