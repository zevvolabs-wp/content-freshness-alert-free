# Manual Testing Guide (No WP-CLI Required)

## 🚀 Quick Setup (5 minutes)

### 1. Create Fresh WordPress Site
1. **Start MAMP** (if not already running)
2. **Open phpMyAdmin**: `http://localhost:8888/phpMyAdmin`
3. **Create Database**: 
   - Click "New" in left sidebar
   - Database name: `wordpress_test`
   - Collation: `utf8mb4_unicode_ci`
   - Click "Create"

### 2. Download WordPress
1. **Go to**: `https://wordpress.org/download/`
2. **Download**: Latest WordPress ZIP
3. **Extract** to: `/Applications/MAMP/htdocs/content-freshness-test/`
4. **Rename** `wordpress` folder to `content-freshness-test`

### 3. Install WordPress
1. **Go to**: `http://localhost:8888/content-freshness-test/`
2. **Select Language**: English
3. **Click**: "Let's go!"
4. **Database Settings**:
   - Database Name: `wordpress_test`
   - Username: `root`
   - Password: `root`
   - Database Host: `localhost`
   - Table Prefix: `wp_`
5. **Click**: "Submit"
6. **Click**: "Run the installation"
7. **Site Settings**:
   - Site Title: `Content Freshness Test`
   - Username: `admin`
   - Password: `admin`
   - Email: `test@example.com`
8. **Click**: "Install WordPress"
9. **Click**: "Log In"

## 📦 Install the Plugin

### Method 1: Upload ZIP (Recommended)
1. **Go to**: `http://localhost:8888/content-freshness-test/wp-admin`
2. **Login**: admin/admin
3. **Navigate**: `Plugins > Add New`
4. **Click**: "Upload Plugin"
5. **Choose File**: Select `content-freshness-alert.zip`
6. **Click**: "Install Now"
7. **Click**: "Activate Plugin"

### Method 2: Direct File Copy
1. **Copy plugin folder** from:
   `/Applications/MAMP/htdocs/check_address/wp-content/plugins/content-freshness-alert`
2. **To**:
   `/Applications/MAMP/htdocs/content-freshness-test/wp-content/plugins/`
3. **Go to**: `Plugins > Installed Plugins`
4. **Find**: "Content Freshness Alert"
5. **Click**: "Activate"

## 📝 Create Test Content

### 1. Create Posts with Old Dates
**Go to**: `Posts > Add New`

**Create these posts one by one:**

#### Very Fresh Posts (0-30 days)
1. **Title**: "Recent Blog Post"
   - **Content**: "This is a recent post"
   - **Publish Date**: Today
   - **Status**: Published
   - **Click**: "Publish"

2. **Title**: "Weekly Update"
   - **Content**: "Weekly update content"
   - **Publish Date**: 7 days ago
   - **Status**: Published
   - **Click**: "Publish"

#### Aging Posts (31-365 days)
3. **Title**: "Monthly Newsletter"
   - **Content**: "Monthly newsletter content"
   - **Publish Date**: 60 days ago
   - **Status**: Published
   - **Click**: "Publish"

4. **Title**: "Quarterly Report"
   - **Content**: "Quarterly report content"
   - **Publish Date**: 180 days ago
   - **Status**: Published
   - **Click**: "Publish"

5. **Title**: "Annual Review"
   - **Content**: "Annual review content"
   - **Publish Date**: 300 days ago
   - **Status**: Published
   - **Click**: "Publish"

#### Stale Posts (366-730 days)
6. **Title**: "Old Tutorial"
   - **Content**: "Old tutorial content"
   - **Publish Date**: 400 days ago
   - **Status**: Published
   - **Click**: "Publish"

7. **Title**: "Outdated Guide"
   - **Content**: "Outdated guide content"
   - **Publish Date**: 600 days ago
   - **Status**: Published
   - **Click**: "Publish"

#### Very Stale Posts (731+ days)
8. **Title**: "Ancient Article"
   - **Content**: "Ancient article content"
   - **Publish Date**: 800 days ago
   - **Status**: Published
   - **Click**: "Publish"

9. **Title**: "Very Old Post"
   - **Content**: "Very old post content"
   - **Publish Date**: 1000 days ago
   - **Status**: Published
   - **Click**: "Publish"

### 2. Create Pages with Old Dates
**Go to**: `Pages > Add New`

1. **Title**: "About Page"
   - **Content**: "About page content"
   - **Publish Date**: 400 days ago
   - **Status**: Published
   - **Click**: "Publish"

2. **Title**: "Contact Page"
   - **Content**: "Contact page content"
   - **Publish Date**: 800 days ago
   - **Status**: Published
   - **Click**: "Publish"

## 🧪 Test the Plugin

### 1. Dashboard Widget Test
1. **Go to**: `Dashboard` (wp-admin)
2. **Look for**: "📅 Content Freshness Alert" widget in sidebar
3. **Verify**:
   - [ ] Widget appears immediately
   - [ ] Shows 10 oldest posts (or fewer if <10 exist)
   - [ ] Post titles are clickable
   - [ ] Ages display correctly
   - [ ] Colors match age categories:
     - 🟢 Green for fresh (0-180 days)
     - 🟡 Yellow for aging (181-365 days)
     - 🟠 Orange for stale (366-730 days)
     - 🔴 Red for very stale (731+ days)

### 2. Posts List Test
1. **Go to**: `Posts > All Posts`
2. **Look for**: "Content Age" column after "Date" column
3. **Verify**:
   - [ ] Column appears after activation
   - [ ] Ages display correctly for all posts
   - [ ] Colors match age categories
   - [ ] Column is sortable (click header)
   - [ ] Sorting works ascending/descending
   - [ ] Column visible in Screen Options

### 3. Pages List Test
1. **Go to**: `Pages > All Pages`
2. **Look for**: "Content Age" column after "Date" column
3. **Verify**:
   - [ ] Column appears after activation
   - [ ] Ages display correctly for all pages
   - [ ] Colors match age categories
   - [ ] Column is sortable
   - [ ] Sorting works correctly

### 4. Age Calculation Test
1. **Create New Post**:
   - Go to `Posts > Add New`
   - Title: "Brand New Post"
   - Content: "This is a brand new post"
   - Publish
   - [ ] Verify it shows as "Today" in widget and list

2. **Edit Existing Post**:
   - Go to `Posts > All Posts`
   - Edit "Very Old Post"
   - Make a small change and save
   - [ ] Verify age resets to "Today"

3. **Delete Post**:
   - Delete "Ancient Article"
   - [ ] Verify it disappears from dashboard widget

## 🔍 Expected Results

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

## 🚨 Troubleshooting

### Common Issues

1. **Widget Not Appearing**:
   - Check user capabilities (need `edit_posts`)
   - Verify plugin is activated
   - Refresh the page

2. **Column Not Showing**:
   - Refresh the page
   - Check Screen Options (may be hidden)
   - Verify plugin is activated

3. **Wrong Age Calculations**:
   - Check post modification dates
   - Verify timezone settings
   - Wait for cron job to run

4. **Colors Not Displaying**:
   - Check if CSS file is loaded
   - Verify browser developer tools
   - Check for CSS conflicts

### Debug Mode
1. **Edit wp-config.php**:
   ```php
   define('WP_DEBUG', true);
   define('WP_DEBUG_LOG', true);
   define('WP_DEBUG_DISPLAY', false);
   ```

2. **Check debug.log**:
   - File location: `/Applications/MAMP/htdocs/content-freshness-test/wp-content/debug.log`
   - Look for PHP errors

### Performance Check
1. **Install Query Monitor**:
   - Go to `Plugins > Add New`
   - Search for "Query Monitor"
   - Install and activate

2. **Check Performance**:
   - [ ] Dashboard loads in <2 seconds
   - [ ] Posts list loads in <3 seconds
   - [ ] No JavaScript errors in console

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

## 📞 Support

If you encounter any issues:
1. Check the debug.log file
2. Verify all steps were followed correctly
3. Test with a fresh WordPress installation
4. Check browser console for JavaScript errors

The plugin should work perfectly if all steps are followed correctly!
