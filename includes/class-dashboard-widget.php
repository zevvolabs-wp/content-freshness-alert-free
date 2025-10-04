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
        
        // Show help text and instructions
        $this->render_help_section();
        
        if (empty($posts)) {
            echo '<div class="cfa-empty-state">';
            echo '<p>' . esc_html__('No posts found. Publish content to start monitoring.', 'content-freshness-alert') . '</p>';
            echo '<p><a href="' . esc_url(admin_url('post-new.php')) . '" class="button button-primary">' . esc_html__('Create Your First Post', 'content-freshness-alert') . '</a></p>';
            echo '</div>';
            return;
        }
        
        // Show quick stats
        $this->render_quick_stats($posts);
        
        echo '<ul class="cfa-post-list">';
        
        foreach ($posts as $post) {
            $this->render_post_item($post);
        }
        
        echo '</ul>';
        
        // Show action buttons
        $this->render_action_buttons();
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
    
    /**
     * Render help section with instructions
     */
    private function render_help_section() {
        echo '<div class="cfa-help-section">';
        echo '<p class="cfa-help-text">';
        echo '<strong>' . esc_html__('What is this?', 'content-freshness-alert') . '</strong><br>';
        echo esc_html__('This widget shows your oldest content that may need updating. Click any post to edit it.', 'content-freshness-alert');
        echo '</p>';
        
        echo '<div class="cfa-legend">';
        echo '<span class="cfa-legend-item"><span class="cfa-age-fresh">●</span> ' . esc_html__('Fresh (0-6 months)', 'content-freshness-alert') . '</span> ';
        echo '<span class="cfa-legend-item"><span class="cfa-age-aging">●</span> ' . esc_html__('Aging (6-12 months)', 'content-freshness-alert') . '</span><br>';
        echo '<span class="cfa-legend-item"><span class="cfa-age-stale">●</span> ' . esc_html__('Stale (1-2 years)', 'content-freshness-alert') . '</span> ';
        echo '<span class="cfa-legend-item"><span class="cfa-age-very-stale">●</span> ' . esc_html__('Very Stale (2+ years)', 'content-freshness-alert') . '</span>';
        echo '</div>';
        echo '</div>';
    }
    
    /**
     * Render quick stats summary
     *
     * @param array $posts Array of post objects
     */
    private function render_quick_stats($posts) {
        $stats = array(
            'fresh' => 0,
            'aging' => 0,
            'stale' => 0,
            'very-stale' => 0
        );
        
        foreach ($posts as $post) {
            $age_days = CFA_Age_Calculator::calculate_age($post->ID);
            $category = CFA_Age_Calculator::get_age_category($age_days);
            $stats[$category]++;
        }
        
        echo '<div class="cfa-stats">';
        
        // Show total posts displayed
        echo '<div class="cfa-stats-item">';
        echo '<span class="cfa-stats-number">' . count($posts) . '</span>';
        echo '<span class="cfa-stats-label">' . esc_html__('Posts Shown', 'content-freshness-alert') . '</span>';
        echo '</div>';
        
        // Show urgent updates needed (very stale)
        if ($stats['very-stale'] > 0) {
            echo '<div class="cfa-stats-item cfa-stats-warning">';
            echo '<span class="cfa-stats-number">' . $stats['very-stale'] . '</span>';
            echo '<span class="cfa-stats-label">' . esc_html__('Need Urgent Update', 'content-freshness-alert') . '</span>';
            echo '</div>';
        }
        
        // Show aging content
        if ($stats['aging'] > 0) {
            echo '<div class="cfa-stats-item cfa-stats-info">';
            echo '<span class="cfa-stats-number">' . $stats['aging'] . '</span>';
            echo '<span class="cfa-stats-label">' . esc_html__('Aging Content', 'content-freshness-alert') . '</span>';
            echo '</div>';
        }
        
        echo '</div>';
    }
    
    /**
     * Render action buttons
     */
    private function render_action_buttons() {
        echo '<div class="cfa-action-buttons">';
        echo '<a href="' . esc_url(admin_url('edit.php')) . '" class="button button-secondary">' . esc_html__('View All Posts', 'content-freshness-alert') . '</a> ';
        echo '<a href="' . esc_url(admin_url('edit.php?post_type=page')) . '" class="button button-secondary">' . esc_html__('View All Pages', 'content-freshness-alert') . '</a>';
        echo '</div>';
    }
}
