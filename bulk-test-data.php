<?php
/**
 * Bulk Test Data Generator for Content Freshness Alert Plugin
 * 
 * This script generates a large number of test posts with varying ages
 * to thoroughly test the plugin functionality.
 * 
 * Usage: Run this file in your WordPress admin or via WP-CLI
 */

// Prevent direct access
if (!defined('ABSPATH')) {
    // If running from command line, load WordPress
    require_once('/Applications/MAMP/htdocs/content-freshness-test/wp-config.php');
}

// Configuration
$config = array(
    'total_posts' => 100,  // Total number of posts to create
    'posts_per_batch' => 10, // Posts to create per batch
    'delay_between_batches' => 1, // Seconds to wait between batches
);

// Post categories with different age ranges
$post_categories = array(
    'very_fresh' => array(
        'range' => array(0, 30),
        'count' => 25,
        'titles' => array(
            'Breaking News Update',
            'Latest Industry Trends',
            'Recent Market Analysis',
            'Today\'s Technology News',
            'Current Events Summary',
            'Fresh Content Update',
            'New Product Launch',
            'Recent Blog Post',
            'Weekly Newsletter',
            'Daily Update'
        )
    ),
    'fresh' => array(
        'range' => array(31, 180),
        'count' => 30,
        'titles' => array(
            'Monthly Business Review',
            'Quarterly Performance Report',
            'Industry Analysis Report',
            'Market Research Findings',
            'Business Strategy Update',
            'Product Development News',
            'Company Milestone',
            'Team Achievement',
            'Project Update',
            'Client Success Story'
        )
    ),
    'aging' => array(
        'range' => array(181, 365),
        'count' => 25,
        'titles' => array(
            'Annual Business Review',
            'Year-End Summary',
            'Strategic Planning Document',
            'Market Analysis Report',
            'Business Growth Update',
            'Industry Trends Analysis',
            'Company Performance Review',
            'Financial Year Summary',
            'Operational Update',
            'Business Development News'
        )
    ),
    'stale' => array(
        'range' => array(366, 730),
        'count' => 15,
        'titles' => array(
            'Legacy Business Process',
            'Outdated Marketing Strategy',
            'Old Product Documentation',
            'Historical Company Data',
            'Previous Year Analysis',
            'Legacy System Information',
            'Old Business Model',
            'Previous Strategy Document',
            'Historical Performance Data',
            'Legacy Process Documentation'
        )
    ),
    'very_stale' => array(
        'range' => array(731, 2000),
        'count' => 5,
        'titles' => array(
            'Ancient Business Archive',
            'Very Old Company Document',
            'Historical Business Record',
            'Legacy Archive Material',
            'Outdated Business Information'
        )
    )
);

// Sample content templates
$content_templates = array(
    'This is a comprehensive analysis of current market trends and their impact on business operations.',
    'Our team has been working diligently to implement new strategies and improve overall performance.',
    'This document outlines key findings from our recent research and development initiatives.',
    'We are pleased to share updates on our ongoing projects and future plans.',
    'This report provides detailed insights into our business operations and growth strategies.',
    'Our latest initiatives focus on innovation, efficiency, and customer satisfaction.',
    'This analysis covers important aspects of our business model and market positioning.',
    'We continue to explore new opportunities and expand our market presence.',
    'This update highlights recent achievements and upcoming milestones.',
    'Our commitment to excellence drives our continued success and growth.'
);

/**
 * Generate random date within range
 */
function generate_random_date($days_ago_min, $days_ago_max) {
    $days_ago = rand($days_ago_min, $days_ago_max);
    $timestamp = time() - ($days_ago * 24 * 60 * 60);
    return date('Y-m-d H:i:s', $timestamp);
}

/**
 * Create a single test post
 */
function create_test_post($title, $content, $days_ago) {
    $post_date = generate_random_date($days_ago, $days_ago);
    
    $post_data = array(
        'post_title' => $title,
        'post_content' => $content,
        'post_status' => 'publish',
        'post_type' => 'post',
        'post_date' => $post_date,
        'post_modified' => $post_date,
        'post_author' => 1,
        'meta_input' => array(
            '_cfa_generated' => true,
            '_cfa_days_ago' => $days_ago
        )
    );
    
    $post_id = wp_insert_post($post_data);
    
    if ($post_id) {
        // Add some random categories
        $categories = array('Business', 'Technology', 'Marketing', 'Strategy', 'Analysis');
        $random_categories = array_rand($categories, rand(1, 3));
        if (!is_array($random_categories)) {
            $random_categories = array($random_categories);
        }
        
        $category_ids = array();
        foreach ($random_categories as $index) {
            $category_ids[] = $categories[$index];
        }
        
        wp_set_post_categories($post_id, $category_ids);
        
        return $post_id;
    }
    
    return false;
}

/**
 * Generate bulk test data
 */
function generate_bulk_test_data($config, $post_categories, $content_templates) {
    echo "<h2>🚀 Generating Bulk Test Data for Content Freshness Alert Plugin</h2>\n";
    echo "<p>This will create {$config['total_posts']} test posts with varying ages...</p>\n";
    
    $total_created = 0;
    $batch_count = 0;
    
    foreach ($post_categories as $category => $data) {
        echo "<h3>📝 Creating {$data['count']} posts in '{$category}' category...</h3>\n";
        
        for ($i = 0; $i < $data['count']; $i++) {
            $batch_count++;
            
            // Select random title and content
            $title = $data['titles'][array_rand($data['titles'])] . ' ' . ($i + 1);
            $content = $content_templates[array_rand($content_templates)];
            
            // Generate random days ago within range
            $days_ago = rand($data['range'][0], $data['range'][1]);
            
            // Create post
            $post_id = create_test_post($title, $content, $days_ago);
            
            if ($post_id) {
                $total_created++;
                echo "✅ Created: {$title} ({$days_ago} days ago) - ID: {$post_id}<br>\n";
            } else {
                echo "❌ Failed to create: {$title}<br>\n";
            }
            
            // Process in batches to avoid timeouts
            if ($batch_count % $config['posts_per_batch'] === 0) {
                echo "<p>⏳ Processed {$batch_count} posts, waiting {$config['delay_between_batches']} seconds...</p>\n";
                sleep($config['delay_between_batches']);
                flush(); // Force output
            }
        }
    }
    
    echo "<h3>🎉 Bulk Data Generation Complete!</h3>\n";
    echo "<p>✅ Created {$total_created} test posts successfully</p>\n";
    echo "<p>📊 Distribution:</p>\n";
    echo "<ul>\n";
    foreach ($post_categories as $category => $data) {
        echo "<li><strong>{$category}</strong>: {$data['count']} posts ({$data['range'][0]}-{$data['range'][1]} days old)</li>\n";
    }
    echo "</ul>\n";
    
    echo "<h3>🧪 Next Steps for Testing:</h3>\n";
    echo "<ol>\n";
    echo "<li>Go to <strong>Dashboard</strong> and check the '📅 Content Freshness Alert' widget</li>\n";
    echo "<li>Go to <strong>Posts > All Posts</strong> and check the 'Content Age' column</li>\n";
    echo "<li>Go to <strong>Pages > All Pages</strong> and check the 'Content Age' column</li>\n";
    echo "<li>Test sorting by clicking the 'Content Age' column header</li>\n";
    echo "<li>Verify color coding: 🟢 Green (fresh), 🟡 Yellow (aging), 🟠 Orange (stale), 🔴 Red (very stale)</li>\n";
    echo "</ol>\n";
    
    echo "<h3>🔧 Cleanup (Optional):</h3>\n";
    echo "<p>To remove all generated test posts, run:</p>\n";
    echo "<code>DELETE FROM wp_posts WHERE ID IN (SELECT post_id FROM wp_postmeta WHERE meta_key = '_cfa_generated' AND meta_value = '1');</code>\n";
    
    return $total_created;
}

// Run the generator
if (isset($_GET['run']) && $_GET['run'] === 'true') {
    generate_bulk_test_data($config, $post_categories, $content_templates);
} else {
    echo "<h1>📊 Bulk Test Data Generator</h1>\n";
    echo "<p>This tool will generate {$config['total_posts']} test posts with varying ages to test the Content Freshness Alert plugin.</p>\n";
    echo "<p><strong>⚠️ Warning:</strong> This will create many posts in your WordPress database.</p>\n";
    echo "<p><a href='?run=true' style='background: #0073aa; color: white; padding: 10px 20px; text-decoration: none; border-radius: 3px;'>🚀 Generate Test Data</a></p>\n";
    echo "<p><a href='../wp-admin/' style='color: #0073aa;'>← Back to WordPress Admin</a></p>\n";
}
?>
