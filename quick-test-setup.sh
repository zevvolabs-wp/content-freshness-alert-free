#!/bin/bash

# Quick Test Setup Script for Content Freshness Alert Plugin
# This script sets up a fresh WordPress installation and tests the plugin

echo "🚀 Setting up Content Freshness Alert Plugin Test Environment..."

# Set variables
WP_DIR="/Applications/MAMP/htdocs/content-freshness-test"
PLUGIN_DIR="/Applications/MAMP/htdocs/check_address/wp-content/plugins/content-freshness-alert"
DB_NAME="check_address"
DB_USER="root"
DB_PASS="root"
SITE_URL="http://localhost:8888/content-freshness-test"

# Check if MAMP is running
if ! pgrep -f "MAMP" > /dev/null; then
    echo "❌ MAMP is not running. Please start MAMP first."
    exit 1
fi

# Create WordPress directory
echo "📁 Creating WordPress directory..."
mkdir -p "$WP_DIR"
cd "$WP_DIR"

# Download WordPress if not exists
if [ ! -f "wp-config.php" ]; then
    echo "⬇️ Downloading WordPress..."
    wp core download --force
    
    # Create wp-config.php
    echo "⚙️ Creating wp-config.php..."
    wp config create --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASS" --force
    
    # Create database
    echo "🗄️ Creating database..."
    wp db create --force
    
    # Install WordPress
    echo "🏗️ Installing WordPress..."
    wp core install --url="$SITE_URL" --title="Content Freshness Test" --admin_user=admin --admin_password=admin --admin_email=test@example.com
else
    echo "✅ WordPress already installed"
fi

# Copy plugin files
echo "📦 Installing plugin..."
cp -r "$PLUGIN_DIR" "$WP_DIR/wp-content/plugins/"

# Activate plugin
echo "🔌 Activating plugin..."
wp plugin activate content-freshness-alert

# Create test content with old dates
echo "📝 Creating test content..."

# Very Fresh Posts (0-30 days)
wp post create --post_title="Recent Blog Post" --post_content="This is a recent post" --post_status=publish --post_date="2025-10-03 10:00:00"
wp post create --post_title="Weekly Update" --post_content="Weekly update content" --post_status=publish --post_date="2025-09-26 10:00:00"

# Aging Posts (31-365 days)
wp post create --post_title="Monthly Newsletter" --post_content="Monthly newsletter content" --post_status=publish --post_date="2025-08-03 10:00:00"
wp post create --post_title="Quarterly Report" --post_content="Quarterly report content" --post_status=publish --post_date="2025-04-03 10:00:00"
wp post create --post_title="Annual Review" --post_content="Annual review content" --post_status=publish --post_date="2024-12-03 10:00:00"

# Stale Posts (366-730 days)
wp post create --post_title="Old Tutorial" --post_content="Old tutorial content" --post_status=publish --post_date="2024-08-03 10:00:00"
wp post create --post_title="Outdated Guide" --post_content="Outdated guide content" --post_status=publish --post_date="2024-02-03 10:00:00"

# Very Stale Posts (731+ days)
wp post create --post_title="Ancient Article" --post_content="Ancient article content" --post_status=publish --post_date="2023-06-03 10:00:00"
wp post create --post_title="Very Old Post" --post_content="Very old post content" --post_status=publish --post_date="2023-01-03 10:00:00"

# Create pages with old dates
wp post create --post_title="About Page" --post_content="About page content" --post_status=publish --post_type=page --post_date="2024-01-03 10:00:00"
wp post create --post_title="Contact Page" --post_content="Contact page content" --post_status=publish --post_type=page --post_date="2023-06-03 10:00:00"

# Run cron job to calculate ages
echo "⏰ Running cron job..."
wp cron event run cfa_daily_age_update

# Check plugin status
echo "🔍 Checking plugin status..."
wp plugin list --status=active | grep content-freshness-alert

# Check cron schedule
echo "📅 Checking cron schedule..."
wp cron event list | grep cfa_daily_age_update

# Display test results
echo ""
echo "✅ Test environment setup complete!"
echo ""
echo "🌐 WordPress Admin: $SITE_URL/wp-admin"
echo "👤 Username: admin"
echo "🔑 Password: admin"
echo ""
echo "📋 Test Checklist:"
echo "1. Go to WordPress Admin Dashboard"
echo "2. Look for '📅 Content Freshness Alert' widget in sidebar"
echo "3. Go to Posts > All Posts and check 'Content Age' column"
echo "4. Go to Pages > All Pages and check 'Content Age' column"
echo "5. Verify color coding: 🟢 Green (fresh), 🟡 Yellow (aging), 🟠 Orange (stale), 🔴 Red (very stale)"
echo ""
echo "🧪 Expected Results:"
echo "- Dashboard widget shows 10 oldest posts"
echo "- Posts list shows Content Age column with color coding"
echo "- Pages list shows Content Age column with color coding"
echo "- Ages calculated correctly from post modification dates"
echo ""
echo "🔧 Troubleshooting:"
echo "- Check debug.log for errors: tail -f $WP_DIR/wp-content/debug.log"
echo "- Verify plugin is active: wp plugin list"
echo "- Check cron job: wp cron event list"
echo ""
echo "🎯 Ready for testing!"
