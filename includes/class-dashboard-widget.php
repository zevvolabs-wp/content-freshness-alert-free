<?php
/**
 * Dashboard Widget Class
 *
 * @package ContentFreshnessAlert
 */

// Prevent direct file access
if (!defined('ABSPATH')) {
    exit;
}

/**
 * Handles dashboard widget registration and rendering
 */
class CFA_Dashboard_Widget {

    /**
     * Constructor
     */
    public function __construct() {
        add_action('wp_dashboard_setup', array($this, 'register_widget'));
    }

    /**
     * Register the dashboard widget
     */
    public function register_widget() {
        if (current_user_can('edit_posts')) {
            wp_add_dashboard_widget(
                'cfa_oldest_content',
                __('📅 Content Freshness Alert', 'content-freshness-alert'),
                array($this, 'render_widget'),
                null,
                null,
                'side', // Sidebar placement
                'high'  // Top of sidebar
            );
        }
    }

    /**
     * Render the dashboard widget
     */
    public function render_widget() {
        $posts = $this->get_oldest_posts();
        
        if (empty($posts)) {
            echo '<p>' . esc_html__('No posts found. Publish content to start monitoring.', 'content-freshness-alert') . '</p>';
            return;
        }
        
        echo '<ul class="cfa-post-list">';
        
        foreach ($posts as $post) {
            $this->render_post_item($post);
        }
        
        echo '</ul>';
    }

    /**
     * Get the 25 oldest published posts
     *
     * @return array Array of post objects
     */
    private function get_oldest_posts() {
        $cache_key = 'cfa_dashboard_widget_data';
        $posts = get_transient($cache_key);
        
        if (false === $posts) {
            $args = array(
                'post_type'      => array('post', 'page'),
                'post_status'    => 'publish',
                'posts_per_page' => 25,
                'orderby'        => 'modified',
                'order'          => 'ASC',
                'no_found_rows'  => true, // Performance optimization
                'update_post_meta_cache'  => false,
                'update_post_term_cache'  => false,
            );
            
            $query = new WP_Query($args);
            $posts = $query->posts;
            
            set_transient($cache_key, $posts, HOUR_IN_SECONDS);
        }
        
        return $posts;
    }

    /**
     * Render a single post item in the widget
     *
     * @param WP_Post $post Post object
     */
    private function render_post_item($post) {
        $age_days = CFA_Age_Calculator::calculate_age($post->ID);
        $category = CFA_Age_Calculator::get_age_category($age_days);
        $display = CFA_Age_Calculator::format_age_display($age_days);
        
        // Truncate title if too long
        $title = $post->post_title;
        if (strlen($title) > 50) {
            $title = substr($title, 0, 50) . '...';
        }
        
        $edit_link = get_edit_post_link($post->ID);
        $modified_date = get_the_modified_date('', $post->ID);
        
        printf(
            '<li class="cfa-age-%s">',
            esc_attr($category)
        );
        
        if ($edit_link) {
            printf(
                '<a href="%s" title="%s">%s</a>',
                esc_url($edit_link),
                esc_attr(sprintf(__('Last modified: %s', 'content-freshness-alert'), $modified_date)),
                esc_html($title)
            );
        } else {
            printf(
                '<span title="%s">%s</span>',
                esc_attr(sprintf(__('Last modified: %s', 'content-freshness-alert'), $modified_date)),
                esc_html($title)
            );
        }
        
        printf(
            ' <span class="cfa-age-text">(%s)</span>',
            esc_html($display)
        );
        
        echo '</li>';
    }
}
