# Step-by-Step Testing Guide

## 🚀 Setting Up Fresh WordPress Site

### Option 1: Local Development (Recommended)
```bash
# Using MAMP (since you're already using it)
# 1. Create new database in phpMyAdmin: wordpress_test
# 2. Download WordPress
cd /Applications/MAMP/htdocs/
wget https://wordpress.org/latest.zip
unzip latest.zip
mv wordpress content-freshness-test
cd content-freshness-test

# 3. Create wp-config.php
cp wp-config-sample.php wp-config.php
# Edit wp-config.php with database credentials
```

### Option 2: WordPress CLI (Faster)
```bash
# Install WordPress CLI if not already installed
curl -O https://raw.githubusercontent.com/wp-cli/wp-cli/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

# Create fresh WordPress installation
cd /Applications/MAMP/htdocs/
wp core download --path=content-freshness-test
cd content-freshness-test

# Create database and config
wp config create --dbname=wordpress_test --dbuser=root --dbpass=root
wp db create
wp core install --url=http://localhost:8888/content-freshness-test --title="Content Freshness Test" --admin_user=admin --admin_password=admin --admin_email=test@example.com
```

## 📦 Installing the Plugin

### Method 1: Upload ZIP File
1. **Access WordPress Admin**:
   - Go to `http://localhost:8888/content-freshness-test/wp-admin`
   - Login with: admin/admin

2. **Upload Plugin**:
   - Go to `Plugins > Add New`
   - Click `Upload Plugin`
   - Choose `content-freshness-alert.zip`
   - Click `Install Now`
   - Click `Activate Plugin`

### Method 2: Direct File Copy
```bash
# Copy plugin files directly
cp -r /Applications/MAMP/htdocs/check_address/wp-content/plugins/content-freshness-alert /Applications/MAMP/htdocs/content-freshness-test/wp-content/plugins/

# Activate via WP-CLI
wp plugin activate content-freshness-alert
```

## 📝 Creating Test Content with Old Dates

### Method 1: WordPress Admin Interface
1. **Create Posts with Backdated Dates**:
   - Go to `Posts > Add New`
   - Create posts with these titles and dates:

   **Very Fresh Posts (0-30 days)**:
   - Title: "Recent Blog Post"
   - Publish date: Today
   - Status: Published

   - Title: "Weekly Update"
   - Publish date: 7 days ago
   - Status: Published

   **Aging Posts (31-365 days)**:
   - Title: "Monthly Newsletter"
   - Publish date: 60 days ago
   - Status: Published

   - Title: "Quarterly Report"
   - Publish date: 180 days ago
   - Status: Published

   - Title: "Annual Review"
   - Publish date: 300 days ago
   - Status: Published

   **Stale Posts (366-730 days)**:
   - Title: "Old Tutorial"
   - Publish date: 400 days ago
   - Status: Published

   - Title: "Outdated Guide"
   - Publish date: 600 days ago
   - Status: Published

   **Very Stale Posts (731+ days)**:
   - Title: "Ancient Article"
   - Publish date: 800 days ago
   - Status: Published

   - Title: "Very Old Post"
   - Publish date: 1000 days ago
   - Status: Published

### Method 2: WP-CLI (Faster)
```bash
# Create posts with specific dates
wp post create --post_title="Recent Blog Post" --post_content="This is a recent post" --post_status=publish --post_date="2025-10-03 10:00:00"
wp post create --post_title="Weekly Update" --post_content="Weekly update content" --post_status=publish --post_date="2025-09-26 10:00:00"
wp post create --post_title="Monthly Newsletter" --post_content="Monthly newsletter content" --post_status=publish --post_date="2025-08-03 10:00:00"
wp post create --post_title="Quarterly Report" --post_content="Quarterly report content" --post_status=publish --post_date="2025-04-03 10:00:00"
wp post create --post_title="Annual Review" --post_content="Annual review content" --post_status=publish --post_date="2024-12-03 10:00:00"
wp post create --post_title="Old Tutorial" --post_content="Old tutorial content" --post_status=publish --post_date="2024-08-03 10:00:00"
wp post create --post_title="Outdated Guide" --post_content="Outdated guide content" --post_status=publish --post_date="2024-02-03 10:00:00"
wp post create --post_title="Ancient Article" --post_content="Ancient article content" --post_status=publish --post_date="2023-06-03 10:00:00"
wp post create --post_title="Very Old Post" --post_content="Very old post content" --post_status=publish --post_date="2023-01-03 10:00:00"

# Create pages with old dates
wp post create --post_title="About Page" --post_content="About page content" --post_status=publish --post_type=page --post_date="2024-01-03 10:00:00"
wp post create --post_title="Contact Page" --post_content="Contact page content" --post_status=publish --post_type=page --post_date="2023-06-03 10:00:00"
```

### Method 3: Database Direct (Advanced)
```sql
-- Connect to MySQL and run these queries
USE wordpress_test;

-- Insert posts with old dates
INSERT INTO wp_posts (post_title, post_content, post_status, post_type, post_date, post_date_gmt, post_modified, post_modified_gmt) VALUES
('Recent Blog Post', 'This is a recent post', 'publish', 'post', '2025-10-03 10:00:00', '2025-10-03 10:00:00', '2025-10-03 10:00:00', '2025-10-03 10:00:00'),
('Weekly Update', 'Weekly update content', 'publish', 'post', '2025-09-26 10:00:00', '2025-09-26 10:00:00', '2025-09-26 10:00:00', '2025-09-26 10:00:00'),
('Monthly Newsletter', 'Monthly newsletter content', 'publish', 'post', '2025-08-03 10:00:00', '2025-08-03 10:00:00', '2025-08-03 10:00:00', '2025-08-03 10:00:00'),
('Quarterly Report', 'Quarterly report content', 'publish', 'post', '2025-04-03 10:00:00', '2025-04-03 10:00:00', '2025-04-03 10:00:00', '2025-04-03 10:00:00'),
('Annual Review', 'Annual review content', 'publish', 'post', '2024-12-03 10:00:00', '2024-12-03 10:00:00', '2024-12-03 10:00:00', '2024-12-03 10:00:00'),
('Old Tutorial', 'Old tutorial content', 'publish', 'post', '2024-08-03 10:00:00', '2024-08-03 10:00:00', '2024-08-03 10:00:00', '2024-08-03 10:00:00'),
('Outdated Guide', 'Outdated guide content', 'publish', 'post', '2024-02-03 10:00:00', '2024-02-03 10:00:00', '2024-02-03 10:00:00', '2024-02-03 10:00:00'),
('Ancient Article', 'Ancient article content', 'publish', 'post', '2023-06-03 10:00:00', '2023-06-03 10:00:00', '2023-06-03 10:00:00', '2023-06-03 10:00:00'),
('Very Old Post', 'Very old post content', 'publish', 'post', '2023-01-03 10:00:00', '2023-01-03 10:00:00', '2023-01-03 10:00:00', '2023-01-03 10:00:00');
```

## 🧪 Testing the Plugin

### 1. Dashboard Widget Testing
1. **Go to Dashboard**:
   - Navigate to `http://localhost:8888/content-freshness-test/wp-admin`
   - Look for "📅 Content Freshness Alert" widget in sidebar

2. **Verify Widget Content**:
   - [ ] Widget appears immediately after activation
   - [ ] Shows 10 oldest posts (or fewer if <10 exist)
   - [ ] Post titles are clickable (open in editor)
   - [ ] Ages display correctly formatted
   - [ ] Colors match age categories:
     - 🟢 Green for fresh (0-180 days)
     - 🟡 Yellow for aging (181-365 days)
     - 🟠 Orange for stale (366-730 days)
     - 🔴 Red for very stale (731+ days)

### 2. Posts List Table Testing
1. **Go to Posts List**:
   - Navigate to `Posts > All Posts`
   - Look for "Content Age" column after "Date" column

2. **Verify Column Content**:
   - [ ] Column appears after activation
   - [ ] Ages display correctly for all posts
   - [ ] Colors match age categories
   - [ ] Column is sortable (click header)
   - [ ] Sorting works ascending/descending
   - [ ] Column visible in Screen Options
   - [ ] Can be hidden via Screen Options

### 3. Pages List Table Testing
1. **Go to Pages List**:
   - Navigate to `Pages > All Pages`
   - Look for "Content Age" column after "Date" column

2. **Verify Column Content**:
   - [ ] Column appears after activation
   - [ ] Ages display correctly for all pages
   - [ ] Colors match age categories
   - [ ] Column is sortable
   - [ ] Sorting works correctly

### 4. Age Calculation Testing
1. **Create New Post**:
   - Go to `Posts > Add New`
   - Create a post with title "Brand New Post"
   - Publish the post
   - [ ] Verify it shows as "Today" in widget and list

2. **Edit Existing Post**:
   - Go to `Posts > All Posts`
   - Edit "Very Old Post"
   - Make a small change and save
   - [ ] Verify age resets to "Today"

3. **Delete Post**:
   - Delete "Ancient Article"
   - [ ] Verify it disappears from dashboard widget

### 5. Cron Job Testing
1. **Check Cron Schedule**:
   ```bash
   wp cron event list
   ```
   - [ ] Verify `cfa_daily_age_update` is scheduled

2. **Test Cron Execution**:
   ```bash
   wp cron test
   wp cron event run cfa_daily_age_update
   ```
   - [ ] Verify cron runs without errors
   - [ ] Check post meta is updated

3. **Verify Post Meta**:
   ```bash
   wp post meta list [post_id]
   ```
   - [ ] Verify `_cfa_age_days` and `_cfa_age_category` meta exists

## 🔍 Debugging and Troubleshooting

### Enable Debug Mode
```php
// Add to wp-config.php
define('WP_DEBUG', true);
define('WP_DEBUG_LOG', true);
define('WP_DEBUG_DISPLAY', false);
```

### Check Debug Log
```bash
# Check for errors
tail -f /Applications/MAMP/htdocs/content-freshness-test/wp-content/debug.log
```

### Common Issues and Solutions

1. **Widget Not Appearing**:
   - Check user capabilities (need `edit_posts`)
   - Verify plugin is activated
   - Check for PHP errors in debug.log

2. **Column Not Showing**:
   - Refresh the page
   - Check Screen Options (may be hidden)
   - Verify plugin is activated

3. **Wrong Age Calculations**:
   - Check post modification dates
   - Verify timezone settings
   - Run cron job manually

4. **Colors Not Displaying**:
   - Check if CSS file is loaded
   - Verify browser developer tools
   - Check for CSS conflicts

## 📊 Expected Results

### Dashboard Widget Should Show:
```
📅 Content Freshness Alert
🔴 Very Old Post (1,000 days old)
🔴 Ancient Article (800 days old)
🟠 Outdated Guide (600 days old)
🟠 Old Tutorial (400 days old)
🟡 Annual Review (300 days old)
🟡 Quarterly Report (180 days old)
🟢 Monthly Newsletter (60 days old)
🟢 Weekly Update (7 days old)
🟢 Recent Blog Post (Today)
```

### Posts List Should Show:
| Title | Date | Content Age |
|-------|------|-------------|
| Very Old Post | Jan 3, 2023 | 🔴 1,000 days ago |
| Ancient Article | Jun 3, 2023 | 🔴 800 days ago |
| Outdated Guide | Feb 3, 2024 | 🟠 600 days ago |
| Old Tutorial | Aug 3, 2024 | 🟠 400 days ago |
| Annual Review | Dec 3, 2024 | 🟡 300 days ago |
| Quarterly Report | Apr 3, 2025 | 🟡 180 days ago |
| Monthly Newsletter | Aug 3, 2025 | 🟢 60 days ago |
| Weekly Update | Sep 26, 2025 | 🟢 7 days ago |
| Recent Blog Post | Oct 3, 2025 | 🟢 Today |

## 🎯 Performance Testing

### Load Testing
1. **Create Many Posts**:
   ```bash
   # Create 100 posts with varying dates
   for i in {1..100}; do
     wp post create --post_title="Test Post $i" --post_content="Test content $i" --post_status=publish --post_date="2024-01-01 10:00:00"
   done
   ```

2. **Measure Performance**:
   - [ ] Dashboard loads in <2 seconds
   - [ ] Posts list loads in <3 seconds
   - [ ] No JavaScript errors in console
   - [ ] Memory usage remains stable

### Query Monitoring
1. **Install Query Monitor**:
   - Go to `Plugins > Add New`
   - Search for "Query Monitor"
   - Install and activate

2. **Check Queries**:
   - [ ] Dashboard shows <5 queries per page
   - [ ] No slow queries
   - [ ] No duplicate queries

## ✅ Final Verification

### Complete Test Checklist
- [ ] Plugin activates without errors
- [ ] Dashboard widget appears and functions
- [ ] List table columns display properly
- [ ] Age calculations are accurate
- [ ] Color coding works as expected
- [ ] Performance remains optimal
- [ ] No security vulnerabilities
- [ ] Full WordPress.org compliance

### Ready for Submission
Once all tests pass, the plugin is ready for WordPress.org submission!
