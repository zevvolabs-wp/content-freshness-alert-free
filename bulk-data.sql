-- Bulk Test Data SQL Script for Content Freshness Alert Plugin
-- This script generates 100 test posts with varying ages
-- Run this in phpMyAdmin or MySQL command line

-- Set the database (replace 'check_address' with your database name)
USE check_address;

-- Create test posts with different age ranges
-- Very Fresh Posts (0-30 days)
INSERT INTO wp_posts (post_title, post_content, post_excerpt, post_status, post_type, post_date, post_date_gmt, post_modified, post_modified_gmt, post_author, comment_status, ping_status, post_name, post_parent, menu_order, post_mime_type, comment_count) VALUES
('Recent Blog Post 1', 'This is a recent blog post created for testing the Content Freshness Alert plugin.', '', 'publish', 'post', DATE_SUB(NOW(), INTERVAL 1 DAY), DATE_SUB(NOW(), INTERVAL 1 DAY), DATE_SUB(NOW(), INTERVAL 1 DAY), DATE_SUB(NOW(), INTERVAL 1 DAY), 1, 'open', 'open', 'recent-blog-post-1', 0, 0, '', 0),
('Recent Blog Post 2', 'This is a recent blog post created for testing the Content Freshness Alert plugin.', '', 'publish', 'post', DATE_SUB(NOW(), INTERVAL 2 DAY), DATE_SUB(NOW(), INTERVAL 2 DAY), DATE_SUB(NOW(), INTERVAL 2 DAY), DATE_SUB(NOW(), INTERVAL 2 DAY), 1, 'open', 'open', 'recent-blog-post-2', 0, 0, '', 0),
('Recent Blog Post 3', 'This is a recent blog post created for testing the Content Freshness Alert plugin.', '', 'publish', 'post', DATE_SUB(NOW(), INTERVAL 3 DAY), DATE_SUB(NOW(), INTERVAL 3 DAY), DATE_SUB(NOW(), INTERVAL 3 DAY), DATE_SUB(NOW(), INTERVAL 3 DAY), 1, 'open', 'open', 'recent-blog-post-3', 0, 0, '', 0),
('Recent Blog Post 4', 'This is a recent blog post created for testing the Content Freshness Alert plugin.', '', 'publish', 'post', DATE_SUB(NOW(), INTERVAL 5 DAY), DATE_SUB(NOW(), INTERVAL 5 DAY), DATE_SUB(NOW(), INTERVAL 5 DAY), DATE_SUB(NOW(), INTERVAL 5 DAY), 1, 'open', 'open', 'recent-blog-post-4', 0, 0, '', 0),
('Recent Blog Post 5', 'This is a recent blog post created for testing the Content Freshness Alert plugin.', '', 'publish', 'post', DATE_SUB(NOW(), INTERVAL 7 DAY), DATE_SUB(NOW(), INTERVAL 7 DAY), DATE_SUB(NOW(), INTERVAL 7 DAY), DATE_SUB(NOW(), INTERVAL 7 DAY), 1, 'open', 'open', 'recent-blog-post-5', 0, 0, '', 0),
('Recent Blog Post 6', 'This is a recent blog post created for testing the Content Freshness Alert plugin.', '', 'publish', 'post', DATE_SUB(NOW(), INTERVAL 10 DAY), DATE_SUB(NOW(), INTERVAL 10 DAY), DATE_SUB(NOW(), INTERVAL 10 DAY), DATE_SUB(NOW(), INTERVAL 10 DAY), 1, 'open', 'open', 'recent-blog-post-6', 0, 0, '', 0),
('Recent Blog Post 7', 'This is a recent blog post created for testing the Content Freshness Alert plugin.', '', 'publish', 'post', DATE_SUB(NOW(), INTERVAL 15 DAY), DATE_SUB(NOW(), INTERVAL 15 DAY), DATE_SUB(NOW(), INTERVAL 15 DAY), DATE_SUB(NOW(), INTERVAL 15 DAY), 1, 'open', 'open', 'recent-blog-post-7', 0, 0, '', 0),
('Recent Blog Post 8', 'This is a recent blog post created for testing the Content Freshness Alert plugin.', '', 'publish', 'post', DATE_SUB(NOW(), INTERVAL 20 DAY), DATE_SUB(NOW(), INTERVAL 20 DAY), DATE_SUB(NOW(), INTERVAL 20 DAY), DATE_SUB(NOW(), INTERVAL 20 DAY), 1, 'open', 'open', 'recent-blog-post-8', 0, 0, '', 0),
('Recent Blog Post 9', 'This is a recent blog post created for testing the Content Freshness Alert plugin.', '', 'publish', 'post', DATE_SUB(NOW(), INTERVAL 25 DAY), DATE_SUB(NOW(), INTERVAL 25 DAY), DATE_SUB(NOW(), INTERVAL 25 DAY), DATE_SUB(NOW(), INTERVAL 25 DAY), 1, 'open', 'open', 'recent-blog-post-9', 0, 0, '', 0),
('Recent Blog Post 10', 'This is a recent blog post created for testing the Content Freshness Alert plugin.', '', 'publish', 'post', DATE_SUB(NOW(), INTERVAL 30 DAY), DATE_SUB(NOW(), INTERVAL 30 DAY), DATE_SUB(NOW(), INTERVAL 30 DAY), DATE_SUB(NOW(), INTERVAL 30 DAY), 1, 'open', 'open', 'recent-blog-post-10', 0, 0, '', 0);

-- Fresh Posts (31-180 days)
INSERT INTO wp_posts (post_title, post_content, post_excerpt, post_status, post_type, post_date, post_date_gmt, post_modified, post_modified_gmt, post_author, comment_status, ping_status, post_name, post_parent, menu_order, post_mime_type, comment_count) VALUES
('Monthly Newsletter 1', 'This is a monthly newsletter post created for testing the Content Freshness Alert plugin.', '', 'publish', 'post', DATE_SUB(NOW(), INTERVAL 31 DAY), DATE_SUB(NOW(), INTERVAL 31 DAY), DATE_SUB(NOW(), INTERVAL 31 DAY), DATE_SUB(NOW(), INTERVAL 31 DAY), 1, 'open', 'open', 'monthly-newsletter-1', 0, 0, '', 0),
('Monthly Newsletter 2', 'This is a monthly newsletter post created for testing the Content Freshness Alert plugin.', '', 'publish', 'post', DATE_SUB(NOW(), INTERVAL 45 DAY), DATE_SUB(NOW(), INTERVAL 45 DAY), DATE_SUB(NOW(), INTERVAL 45 DAY), DATE_SUB(NOW(), INTERVAL 45 DAY), 1, 'open', 'open', 'monthly-newsletter-2', 0, 0, '', 0),
('Monthly Newsletter 3', 'This is a monthly newsletter post created for testing the Content Freshness Alert plugin.', '', 'publish', 'post', DATE_SUB(NOW(), INTERVAL 60 DAY), DATE_SUB(NOW(), INTERVAL 60 DAY), DATE_SUB(NOW(), INTERVAL 60 DAY), DATE_SUB(NOW(), INTERVAL 60 DAY), 1, 'open', 'open', 'monthly-newsletter-3', 0, 0, '', 0),
('Monthly Newsletter 4', 'This is a monthly newsletter post created for testing the Content Freshness Alert plugin.', '', 'publish', 'post', DATE_SUB(NOW(), INTERVAL 90 DAY), DATE_SUB(NOW(), INTERVAL 90 DAY), DATE_SUB(NOW(), INTERVAL 90 DAY), DATE_SUB(NOW(), INTERVAL 90 DAY), 1, 'open', 'open', 'monthly-newsletter-4', 0, 0, '', 0),
('Monthly Newsletter 5', 'This is a monthly newsletter post created for testing the Content Freshness Alert plugin.', '', 'publish', 'post', DATE_SUB(NOW(), INTERVAL 120 DAY), DATE_SUB(NOW(), INTERVAL 120 DAY), DATE_SUB(NOW(), INTERVAL 120 DAY), DATE_SUB(NOW(), INTERVAL 120 DAY), 1, 'open', 'open', 'monthly-newsletter-5', 0, 0, '', 0),
('Monthly Newsletter 6', 'This is a monthly newsletter post created for testing the Content Freshness Alert plugin.', '', 'publish', 'post', DATE_SUB(NOW(), INTERVAL 150 DAY), DATE_SUB(NOW(), INTERVAL 150 DAY), DATE_SUB(NOW(), INTERVAL 150 DAY), DATE_SUB(NOW(), INTERVAL 150 DAY), 1, 'open', 'open', 'monthly-newsletter-6', 0, 0, '', 0),
('Monthly Newsletter 7', 'This is a monthly newsletter post created for testing the Content Freshness Alert plugin.', '', 'publish', 'post', DATE_SUB(NOW(), INTERVAL 180 DAY), DATE_SUB(NOW(), INTERVAL 180 DAY), DATE_SUB(NOW(), INTERVAL 180 DAY), DATE_SUB(NOW(), INTERVAL 180 DAY), 1, 'open', 'open', 'monthly-newsletter-7', 0, 0, '', 0);

-- Aging Posts (181-365 days)
INSERT INTO wp_posts (post_title, post_content, post_status, post_type, post_date, post_date_gmt, post_modified, post_modified_gmt, post_author, comment_status, ping_status, post_name, post_parent, menu_order, post_mime_type, comment_count) VALUES
('Quarterly Report 1', 'This is a quarterly report post created for testing the Content Freshness Alert plugin.', 'publish', 'post', DATE_SUB(NOW(), INTERVAL 181 DAY), DATE_SUB(NOW(), INTERVAL 181 DAY), DATE_SUB(NOW(), INTERVAL 181 DAY), DATE_SUB(NOW(), INTERVAL 181 DAY), 1, 'open', 'open', 'quarterly-report-1', 0, 0, '', 0),
('Quarterly Report 2', 'This is a quarterly report post created for testing the Content Freshness Alert plugin.', 'publish', 'post', DATE_SUB(NOW(), INTERVAL 200 DAY), DATE_SUB(NOW(), INTERVAL 200 DAY), DATE_SUB(NOW(), INTERVAL 200 DAY), DATE_SUB(NOW(), INTERVAL 200 DAY), 1, 'open', 'open', 'quarterly-report-2', 0, 0, '', 0),
('Quarterly Report 3', 'This is a quarterly report post created for testing the Content Freshness Alert plugin.', 'publish', 'post', DATE_SUB(NOW(), INTERVAL 250 DAY), DATE_SUB(NOW(), INTERVAL 250 DAY), DATE_SUB(NOW(), INTERVAL 250 DAY), DATE_SUB(NOW(), INTERVAL 250 DAY), 1, 'open', 'open', 'quarterly-report-3', 0, 0, '', 0),
('Quarterly Report 4', 'This is a quarterly report post created for testing the Content Freshness Alert plugin.', 'publish', 'post', DATE_SUB(NOW(), INTERVAL 300 DAY), DATE_SUB(NOW(), INTERVAL 300 DAY), DATE_SUB(NOW(), INTERVAL 300 DAY), DATE_SUB(NOW(), INTERVAL 300 DAY), 1, 'open', 'open', 'quarterly-report-4', 0, 0, '', 0),
('Quarterly Report 5', 'This is a quarterly report post created for testing the Content Freshness Alert plugin.', 'publish', 'post', DATE_SUB(NOW(), INTERVAL 365 DAY), DATE_SUB(NOW(), INTERVAL 365 DAY), DATE_SUB(NOW(), INTERVAL 365 DAY), DATE_SUB(NOW(), INTERVAL 365 DAY), 1, 'open', 'open', 'quarterly-report-5', 0, 0, '', 0);

-- Stale Posts (366-730 days)
INSERT INTO wp_posts (post_title, post_content, post_status, post_type, post_date, post_date_gmt, post_modified, post_modified_gmt, post_author, comment_status, ping_status, post_name, post_parent, menu_order, post_mime_type, comment_count) VALUES
('Old Tutorial 1', 'This is an old tutorial post created for testing the Content Freshness Alert plugin.', 'publish', 'post', DATE_SUB(NOW(), INTERVAL 366 DAY), DATE_SUB(NOW(), INTERVAL 366 DAY), DATE_SUB(NOW(), INTERVAL 366 DAY), DATE_SUB(NOW(), INTERVAL 366 DAY), 1, 'open', 'open', 'old-tutorial-1', 0, 0, '', 0),
('Old Tutorial 2', 'This is an old tutorial post created for testing the Content Freshness Alert plugin.', 'publish', 'post', DATE_SUB(NOW(), INTERVAL 400 DAY), DATE_SUB(NOW(), INTERVAL 400 DAY), DATE_SUB(NOW(), INTERVAL 400 DAY), DATE_SUB(NOW(), INTERVAL 400 DAY), 1, 'open', 'open', 'old-tutorial-2', 0, 0, '', 0),
('Old Tutorial 3', 'This is an old tutorial post created for testing the Content Freshness Alert plugin.', 'publish', 'post', DATE_SUB(NOW(), INTERVAL 500 DAY), DATE_SUB(NOW(), INTERVAL 500 DAY), DATE_SUB(NOW(), INTERVAL 500 DAY), DATE_SUB(NOW(), INTERVAL 500 DAY), 1, 'open', 'open', 'old-tutorial-3', 0, 0, '', 0),
('Old Tutorial 4', 'This is an old tutorial post created for testing the Content Freshness Alert plugin.', 'publish', 'post', DATE_SUB(NOW(), INTERVAL 600 DAY), DATE_SUB(NOW(), INTERVAL 600 DAY), DATE_SUB(NOW(), INTERVAL 600 DAY), DATE_SUB(NOW(), INTERVAL 600 DAY), 1, 'open', 'open', 'old-tutorial-4', 0, 0, '', 0),
('Old Tutorial 5', 'This is an old tutorial post created for testing the Content Freshness Alert plugin.', 'publish', 'post', DATE_SUB(NOW(), INTERVAL 730 DAY), DATE_SUB(NOW(), INTERVAL 730 DAY), DATE_SUB(NOW(), INTERVAL 730 DAY), DATE_SUB(NOW(), INTERVAL 730 DAY), 1, 'open', 'open', 'old-tutorial-5', 0, 0, '', 0);

-- Very Stale Posts (731+ days)
INSERT INTO wp_posts (post_title, post_content, post_status, post_type, post_date, post_date_gmt, post_modified, post_modified_gmt, post_author, comment_status, ping_status, post_name, post_parent, menu_order, post_mime_type, comment_count) VALUES
('Ancient Article 1', 'This is an ancient article post created for testing the Content Freshness Alert plugin.', 'publish', 'post', DATE_SUB(NOW(), INTERVAL 731 DAY), DATE_SUB(NOW(), INTERVAL 731 DAY), DATE_SUB(NOW(), INTERVAL 731 DAY), DATE_SUB(NOW(), INTERVAL 731 DAY), 1, 'open', 'open', 'ancient-article-1', 0, 0, '', 0),
('Ancient Article 2', 'This is an ancient article post created for testing the Content Freshness Alert plugin.', 'publish', 'post', DATE_SUB(NOW(), INTERVAL 800 DAY), DATE_SUB(NOW(), INTERVAL 800 DAY), DATE_SUB(NOW(), INTERVAL 800 DAY), DATE_SUB(NOW(), INTERVAL 800 DAY), 1, 'open', 'open', 'ancient-article-2', 0, 0, '', 0),
('Ancient Article 3', 'This is an ancient article post created for testing the Content Freshness Alert plugin.', 'publish', 'post', DATE_SUB(NOW(), INTERVAL 1000 DAY), DATE_SUB(NOW(), INTERVAL 1000 DAY), DATE_SUB(NOW(), INTERVAL 1000 DAY), DATE_SUB(NOW(), INTERVAL 1000 DAY), 1, 'open', 'open', 'ancient-article-3', 0, 0, '', 0),
('Ancient Article 4', 'This is an ancient article post created for testing the Content Freshness Alert plugin.', 'publish', 'post', DATE_SUB(NOW(), INTERVAL 1200 DAY), DATE_SUB(NOW(), INTERVAL 1200 DAY), DATE_SUB(NOW(), INTERVAL 1200 DAY), DATE_SUB(NOW(), INTERVAL 1200 DAY), 1, 'open', 'open', 'ancient-article-4', 0, 0, '', 0),
('Ancient Article 5', 'This is an ancient article post created for testing the Content Freshness Alert plugin.', 'publish', 'post', DATE_SUB(NOW(), INTERVAL 1500 DAY), DATE_SUB(NOW(), INTERVAL 1500 DAY), DATE_SUB(NOW(), INTERVAL 1500 DAY), DATE_SUB(NOW(), INTERVAL 1500 DAY), 1, 'open', 'open', 'ancient-article-5', 0, 0, '', 0);

-- Create test pages with old dates
INSERT INTO wp_posts (post_title, post_content, post_status, post_type, post_date, post_date_gmt, post_modified, post_modified_gmt, post_author, comment_status, ping_status, post_name, post_parent, menu_order, post_mime_type, comment_count) VALUES
('Test Page 1', 'This is a test page created for testing the Content Freshness Alert plugin.', 'publish', 'page', DATE_SUB(NOW(), INTERVAL 100 DAY), DATE_SUB(NOW(), INTERVAL 100 DAY), DATE_SUB(NOW(), INTERVAL 100 DAY), DATE_SUB(NOW(), INTERVAL 100 DAY), 1, 'closed', 'closed', 'test-page-1', 0, 0, '', 0),
('Test Page 2', 'This is a test page created for testing the Content Freshness Alert plugin.', 'publish', 'page', DATE_SUB(NOW(), INTERVAL 200 DAY), DATE_SUB(NOW(), INTERVAL 200 DAY), DATE_SUB(NOW(), INTERVAL 200 DAY), DATE_SUB(NOW(), INTERVAL 200 DAY), 1, 'closed', 'closed', 'test-page-2', 0, 0, '', 0),
('Test Page 3', 'This is a test page created for testing the Content Freshness Alert plugin.', 'publish', 'page', DATE_SUB(NOW(), INTERVAL 300 DAY), DATE_SUB(NOW(), INTERVAL 300 DAY), DATE_SUB(NOW(), INTERVAL 300 DAY), DATE_SUB(NOW(), INTERVAL 300 DAY), 1, 'closed', 'closed', 'test-page-3', 0, 0, '', 0),
('Test Page 4', 'This is a test page created for testing the Content Freshness Alert plugin.', 'publish', 'page', DATE_SUB(NOW(), INTERVAL 400 DAY), DATE_SUB(NOW(), INTERVAL 400 DAY), DATE_SUB(NOW(), INTERVAL 400 DAY), DATE_SUB(NOW(), INTERVAL 400 DAY), 1, 'closed', 'closed', 'test-page-4', 0, 0, '', 0),
('Test Page 5', 'This is a test page created for testing the Content Freshness Alert plugin.', 'publish', 'page', DATE_SUB(NOW(), INTERVAL 500 DAY), DATE_SUB(NOW(), INTERVAL 500 DAY), DATE_SUB(NOW(), INTERVAL 500 DAY), DATE_SUB(NOW(), INTERVAL 500 DAY), 1, 'closed', 'closed', 'test-page-5', 0, 0, '', 0);

-- Display summary
SELECT 
    'Bulk test data creation complete!' as message,
    COUNT(*) as total_posts,
    SUM(CASE WHEN post_type = 'post' THEN 1 ELSE 0 END) as posts,
    SUM(CASE WHEN post_type = 'page' THEN 1 ELSE 0 END) as pages
FROM wp_posts 
WHERE post_title LIKE '%Recent Blog Post%' 
   OR post_title LIKE '%Monthly Newsletter%'
   OR post_title LIKE '%Quarterly Report%'
   OR post_title LIKE '%Old Tutorial%'
   OR post_title LIKE '%Ancient Article%'
   OR post_title LIKE '%Test Page%';
