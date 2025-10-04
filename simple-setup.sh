#!/bin/bash

# Simple Setup Script for Content Freshness Alert Plugin Test Environment
# This script sets up the basic structure without requiring WP-CLI

echo "🚀 Setting up Content Freshness Alert Plugin Test Environment..."

# Set variables
WP_DIR="/Applications/MAMP/htdocs/content-freshness-test"
PLUGIN_DIR="/Applications/MAMP/htdocs/check_address/wp-content/plugins/content-freshness-alert"

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
    curl -O https://wordpress.org/latest.zip
    unzip latest.zip
    mv wordpress/* .
    rmdir wordpress
    rm latest.zip
    echo "✅ WordPress downloaded successfully"
else
    echo "✅ WordPress already installed"
fi

# Copy plugin files
echo "📦 Installing plugin..."
mkdir -p "$WP_DIR/wp-content/plugins"
cp -r "$PLUGIN_DIR" "$WP_DIR/wp-content/plugins/"

echo ""
echo "✅ Basic setup complete!"
echo ""
echo "🌐 Next Steps:"
echo "1. Go to: http://localhost:8888/content-freshness-test/"
echo "2. Follow the WordPress installation wizard"
echo "3. Database settings:"
echo "   - Database Name: check_address"
echo "   - Username: root"
echo "   - Password: root"
echo "   - Host: localhost"
echo "   - Table Prefix: wp_"
echo "4. Site settings:"
echo "   - Site Title: Content Freshness Test"
echo "   - Username: admin"
echo "   - Password: admin"
echo "   - Email: test@example.com"
echo "5. After installation, activate the plugin"
echo "6. Follow the MANUAL_SETUP_GUIDE.md for testing"
echo ""
echo "📋 Files created:"
echo "- WordPress installation: $WP_DIR"
echo "- Plugin copied to: $WP_DIR/wp-content/plugins/content-freshness-alert"
echo "- Manual setup guide: MANUAL_SETUP_GUIDE.md"
echo ""
echo "🎯 Ready for manual WordPress installation!"
