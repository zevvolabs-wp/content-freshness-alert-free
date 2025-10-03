<?php
/**
 * Age Calculator Class
 *
 * @package ContentFreshnessAlert
 */

// Prevent direct file access
if (!defined('ABSPATH')) {
    exit;
}

/**
 * Handles age calculation, categorization, and formatting for posts
 */
class CFA_Age_Calculator {

    /**
     * Constructor
     */
    public function __construct() {
        add_action('cfa_daily_age_update', array($this, 'update_all_ages'));
        add_action('save_post', array($this, 'update_single_post'));
        add_action('delete_post', array($this, 'clear_cache'));
    }

    /**
     * Calculate age in days for a post
     *
     * @param int $post_id Post ID
     * @return int Age in days
     */
    public static function calculate_age($post_id) {
        $post = get_post($post_id);
        
        if (!$post || $post->post_status !== 'publish') {
            return 0;
        }
        
        $modified_time = strtotime($post->post_modified_gmt . ' GMT');
        $current_time = time();
        $diff_seconds = $current_time - $modified_time;
        $age_days = floor($diff_seconds / DAY_IN_SECONDS);
        
        return max(0, $age_days); // Never negative
    }

    /**
     * Get age category based on days
     *
     * @param int $days Age in days
     * @return string Category identifier
     */
    public static function get_age_category($days) {
        if ($days <= CFA_THRESHOLD_FRESH) {
            return 'fresh';
        } elseif ($days <= CFA_THRESHOLD_AGING) {
            return 'aging';
        } elseif ($days <= CFA_THRESHOLD_STALE) {
            return 'stale';
        } else {
            return 'very-stale';
        }
    }

    /**
     * Format age for display
     *
     * @param int $days Age in days
     * @return string Formatted age string
     */
    public static function format_age_display($days) {
        if ($days === 0) {
            return __('Today', 'content-freshness-alert');
        } elseif ($days === 1) {
            return __('1 day ago', 'content-freshness-alert');
        } elseif ($days < 30) {
            return sprintf(
                _n('%d day ago', '%d days ago', $days, 'content-freshness-alert'),
                $days
            );
        } elseif ($days < 365) {
            $months = floor($days / 30);
            return sprintf(
                _n('%d month ago', '%d months ago', $months, 'content-freshness-alert'),
                $months
            );
        } else {
            $years = round($days / 365, 1);
            return sprintf(
                __('%s years ago', 'content-freshness-alert'),
                number_format_i18n($years, 1)
            );
        }
    }

    /**
     * Get color for age category
     *
     * @param string $category Age category
     * @return string CSS color value
     */
    public static function get_category_color($category) {
        $colors = array(
            'fresh' => '#4CAF50',      // Green
            'aging' => '#FFC107',      // Yellow
            'stale' => '#FF9800',      // Orange
            'very-stale' => '#F44336', // Red
        );
        
        return isset($colors[$category]) ? $colors[$category] : '#666666';
    }

    /**
     * Update all posts' age data via cron
     */
    public function update_all_ages() {
        $args = array(
            'post_type'      => array('post', 'page'),
            'post_status'    => 'publish',
            'posts_per_page' => -1,
            'fields'         => 'ids', // Only IDs
            'no_found_rows'  => true,
            'update_post_meta_cache' => false,
            'update_post_term_cache' => false,
        );
        
        $post_ids = get_posts($args);
        
        foreach ($post_ids as $post_id) {
            $age_days = self::calculate_age($post_id);
            $category = self::get_age_category($age_days);
            
            update_post_meta($post_id, '_cfa_age_days', $age_days);
            update_post_meta($post_id, '_cfa_age_category', $category);
        }
        
        // Clear dashboard cache to reflect updates
        delete_transient('cfa_dashboard_widget_data');
    }

    /**
     * Update single post age data on save
     *
     * @param int $post_id Post ID
     */
    public function update_single_post($post_id) {
        if (wp_is_post_revision($post_id)) {
            return;
        }
        
        $post = get_post($post_id);
        if (!$post || $post->post_status !== 'publish') {
            return;
        }
        
        $age_days = self::calculate_age($post_id);
        $category = self::get_age_category($age_days);
        
        update_post_meta($post_id, '_cfa_age_days', $age_days);
        update_post_meta($post_id, '_cfa_age_category', $category);
        
        // Clear dashboard cache
        delete_transient('cfa_dashboard_widget_data');
    }

    /**
     * Clear cache on post deletion
     *
     * @param int $post_id Post ID
     */
    public function clear_cache($post_id) {
        if (wp_is_post_revision($post_id)) {
            return;
        }
        
        delete_transient('cfa_dashboard_widget_data');
    }
}
