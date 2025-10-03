#!/bin/bash

# Bulk Test Data Generator for Content Freshness Alert Plugin (WP-CLI version)
# This script generates a large number of test posts with varying ages

echo "🚀 Generating Bulk Test Data for Content Freshness Alert Plugin..."

# Set WordPress directory
WP_DIR="/Applications/MAMP/htdocs/content-freshness-test"
cd "$WP_DIR"

# Check if WP-CLI is available
if ! command -v wp &> /dev/null; then
    echo "❌ WP-CLI not found. Installing WP-CLI..."
    curl -O https://raw.githubusercontent.com/wp-cli/wp-cli/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    sudo mv wp-cli.phar /usr/local/bin/wp
    echo "✅ WP-CLI installed successfully"
fi

# Generate test posts with different age ranges
echo "📝 Creating test posts with varying ages..."

# Very Fresh Posts (0-30 days)
echo "🟢 Creating very fresh posts (0-30 days)..."
for i in {1..25}; do
    days_ago=$((RANDOM % 31))
    wp post create --post_title="Recent Blog Post $i" --post_content="This is a recent blog post created for testing the Content Freshness Alert plugin. This post is $days_ago days old." --post_status=publish --post_date="$(date -d "$days_ago days ago" '+%Y-%m-%d %H:%M:%S')"
done

# Fresh Posts (31-180 days)
echo "🟡 Creating fresh posts (31-180 days)..."
for i in {1..30}; do
    days_ago=$((31 + RANDOM % 150))
    wp post create --post_title="Monthly Newsletter $i" --post_content="This is a monthly newsletter post created for testing the Content Freshness Alert plugin. This post is $days_ago days old." --post_status=publish --post_date="$(date -d "$days_ago days ago" '+%Y-%m-%d %H:%M:%S')"
done

# Aging Posts (181-365 days)
echo "🟠 Creating aging posts (181-365 days)..."
for i in {1..25}; do
    days_ago=$((181 + RANDOM % 185))
    wp post create --post_title="Quarterly Report $i" --post_content="This is a quarterly report post created for testing the Content Freshness Alert plugin. This post is $days_ago days old." --post_status=publish --post_date="$(date -d "$days_ago days ago" '+%Y-%m-%d %H:%M:%S')"
done

# Stale Posts (366-730 days)
echo "🔴 Creating stale posts (366-730 days)..."
for i in {1..15}; do
    days_ago=$((366 + RANDOM % 365))
    wp post create --post_title="Old Tutorial $i" --post_content="This is an old tutorial post created for testing the Content Freshness Alert plugin. This post is $days_ago days old." --post_status=publish --post_date="$(date -d "$days_ago days ago" '+%Y-%m-%d %H:%M:%S')"
done

# Very Stale Posts (731+ days)
echo "🔴 Creating very stale posts (731+ days)..."
for i in {1..5}; do
    days_ago=$((731 + RANDOM % 1000))
    wp post create --post_title="Ancient Article $i" --post_content="This is an ancient article post created for testing the Content Freshness Alert plugin. This post is $days_ago days old." --post_status=publish --post_date="$(date -d "$days_ago days ago" '+%Y-%m-%d %H:%M:%S')"
done

# Create pages with old dates
echo "📄 Creating test pages with old dates..."
for i in {1..10}; do
    days_ago=$((100 + RANDOM % 500))
    wp post create --post_title="Test Page $i" --post_content="This is a test page created for testing the Content Freshness Alert plugin. This page is $days_ago days old." --post_status=publish --post_type=page --post_date="$(date -d "$days_ago days ago" '+%Y-%m-%d %H:%M:%S')"
done

# Run cron job to calculate ages
echo "⏰ Running cron job to calculate ages..."
wp cron event run cfa_daily_age_update

# Display summary
echo ""
echo "✅ Bulk test data generation complete!"
echo ""
echo "📊 Summary:"
echo "- 100 test posts created with varying ages"
echo "- 10 test pages created with varying ages"
echo "- Age categories:"
echo "  🟢 Very Fresh (0-30 days): 25 posts"
echo "  🟡 Fresh (31-180 days): 30 posts"
echo "  🟠 Aging (181-365 days): 25 posts"
echo "  🔴 Stale (366-730 days): 15 posts"
echo "  🔴 Very Stale (731+ days): 5 posts"
echo ""
echo "🧪 Next Steps for Testing:"
echo "1. Go to WordPress Dashboard and check the '📅 Content Freshness Alert' widget"
echo "2. Go to Posts > All Posts and check the 'Content Age' column"
echo "3. Go to Pages > All Pages and check the 'Content Age' column"
echo "4. Test sorting by clicking the 'Content Age' column header"
echo "5. Verify color coding matches the age categories"
echo ""
echo "🌐 WordPress Admin: http://localhost:8888/content-freshness-test/wp-admin"
echo "👤 Username: admin"
echo "🔑 Password: admin"
echo ""
echo "🎯 Ready for comprehensive testing!"
