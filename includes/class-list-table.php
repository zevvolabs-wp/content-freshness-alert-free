<?php
/**
 * List Table Class
 *
 * @package ContentFreshnessAlert
 */

// Prevent direct file access
if (!defined('ABSPATH')) {
    exit;
}

/**
 * Handles list table column integration for posts and pages
 */
class CFA_List_Table {

    /**
     * Constructor
     */
    public function __construct() {
        // Posts
        add_filter('manage_posts_columns', array($this, 'add_column'));
        add_action('manage_posts_custom_column', array($this, 'render_column'), 10, 2);
        add_filter('manage_edit-post_sortable_columns', array($this, 'make_sortable'));
        
        // Pages
        add_filter('manage_pages_columns', array($this, 'add_column'));
        add_action('manage_pages_custom_column', array($this, 'render_column'), 10, 2);
        add_filter('manage_edit-page_sortable_columns', array($this, 'make_sortable'));
        
        // Admin styles
        add_action('admin_enqueue_scripts', array($this, 'enqueue_styles'));
    }

    /**
     * Add Content Age column to list table
     *
     * @param array $columns Existing columns
     * @return array Modified columns
     */
    public function add_column($columns) {
        $new_columns = array();
        
        foreach ($columns as $key => $value) {
            $new_columns[$key] = $value;
            if ($key === 'date') {
                $new_columns['content_age'] = __('Content Age', 'content-freshness-alert');
            }
        }
        
        return $new_columns;
    }

    /**
     * Render Content Age column content
     *
     * @param string $column Column name
     * @param int $post_id Post ID
     */
    public function render_column($column, $post_id) {
        if ($column !== 'content_age') {
            return;
        }
        
        $post = get_post($post_id);
        if (!$post || $post->post_status !== 'publish') {
            echo '<span class="cfa-age-draft">—</span>';
            return;
        }
        
        // Try to get cached age data first
        $age_days = get_post_meta($post_id, '_cfa_age_days', true);
        $category = get_post_meta($post_id, '_cfa_age_category', true);
        
        // If no cached data, calculate on the fly
        if ($age_days === '' || $category === '') {
            $age_days = CFA_Age_Calculator::calculate_age($post_id);
            $category = CFA_Age_Calculator::get_age_category($age_days);
            
            // Cache for future use
            update_post_meta($post_id, '_cfa_age_days', $age_days);
            update_post_meta($post_id, '_cfa_age_category', $category);
        }
        
        $display = CFA_Age_Calculator::format_age_display($age_days);
        $modified_date = get_the_modified_date('', $post_id);
        
        printf(
            '<span class="cfa-age-%s" title="%s">%s</span>',
            esc_attr($category),
            esc_attr(sprintf(__('Last modified: %s', 'content-freshness-alert'), $modified_date)),
            esc_html($display)
        );
    }

    /**
     * Make Content Age column sortable
     *
     * @param array $columns Sortable columns
     * @return array Modified sortable columns
     */
    public function make_sortable($columns) {
        $columns['content_age'] = 'modified'; // Sort by post_modified
        return $columns;
    }

    /**
     * Enqueue admin styles
     *
     * @param string $hook Current admin page hook
     */
    public function enqueue_styles($hook) {
        // Only on dashboard and list table pages
        if ($hook === 'index.php' || $hook === 'edit.php') {
            wp_enqueue_style(
                'cfa-admin-styles',
                CFA_PLUGIN_URL . 'assets/css/admin-styles.css',
                array(),
                CFA_VERSION
            );
        }
    }
}
