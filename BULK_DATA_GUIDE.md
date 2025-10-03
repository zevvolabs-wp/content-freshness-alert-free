# Bulk Test Data Guide

## 🚀 Generate Large Amount of Test Data

This guide helps you create a large number of test posts with varying ages to thoroughly test the Content Freshness Alert plugin.

## 📊 Test Data Distribution

We'll create **100 test posts** with the following age distribution:

- **🟢 Very Fresh (0-30 days)**: 25 posts
- **🟡 Fresh (31-180 days)**: 30 posts  
- **🟠 Aging (181-365 days)**: 25 posts
- **🔴 Stale (366-730 days)**: 15 posts
- **🔴 Very Stale (731+ days)**: 5 posts

Plus **10 test pages** with varying ages.

## 🛠️ Method 1: WordPress Admin Interface (Recommended)

### Step 1: Access the Bulk Data Generator
1. **Go to**: `http://localhost:8888/content-freshness-test/wp-content/plugins/content-freshness-alert/bulk-test-data.php`
2. **Click**: "🚀 Generate Test Data"
3. **Wait**: The script will create all posts automatically

### Step 2: Verify Generation
- Check that 100 posts were created
- Verify posts have different ages
- Confirm the plugin widget shows the data

## 🛠️ Method 2: WP-CLI Script (If Available)

### Step 1: Run the Script
```bash
cd /Applications/MAMP/htdocs/check_address/wp-content/plugins/content-freshness-alert
./bulk-data-wpcli.sh
```

### Step 2: Monitor Progress
- Watch the script create posts in batches
- Verify all categories are created
- Check for any errors

## 🛠️ Method 3: Manual Creation (Time-Consuming)

### Step 1: Create Very Fresh Posts (0-30 days)
**Go to**: `Posts > Add New`

Create 25 posts with these titles and dates:
- "Recent Blog Post 1" (Today)
- "Recent Blog Post 2" (1 day ago)
- "Recent Blog Post 3" (2 days ago)
- ... (continue to 30 days ago)

### Step 2: Create Fresh Posts (31-180 days)
Create 30 posts with these titles and dates:
- "Monthly Newsletter 1" (31 days ago)
- "Monthly Newsletter 2" (45 days ago)
- "Monthly Newsletter 3" (60 days ago)
- ... (continue to 180 days ago)

### Step 3: Create Aging Posts (181-365 days)
Create 25 posts with these titles and dates:
- "Quarterly Report 1" (181 days ago)
- "Quarterly Report 2" (200 days ago)
- "Quarterly Report 3" (250 days ago)
- ... (continue to 365 days ago)

### Step 4: Create Stale Posts (366-730 days)
Create 15 posts with these titles and dates:
- "Old Tutorial 1" (366 days ago)
- "Old Tutorial 2" (400 days ago)
- "Old Tutorial 3" (500 days ago)
- ... (continue to 730 days ago)

### Step 5: Create Very Stale Posts (731+ days)
Create 5 posts with these titles and dates:
- "Ancient Article 1" (731 days ago)
- "Ancient Article 2" (800 days ago)
- "Ancient Article 3" (1000 days ago)
- "Ancient Article 4" (1200 days ago)
- "Ancient Article 5" (1500 days ago)

### Step 6: Create Test Pages
**Go to**: `Pages > Add New`

Create 10 pages with varying ages:
- "Test Page 1" (100 days ago)
- "Test Page 2" (200 days ago)
- "Test Page 3" (300 days ago)
- ... (continue with different ages)

## 🧪 Testing the Plugin with Bulk Data

### 1. Dashboard Widget Test
1. **Go to**: `Dashboard`
2. **Look for**: "📅 Content Freshness Alert" widget
3. **Verify**: Shows 10 oldest posts (should be the very stale ones)
4. **Check**: Color coding is correct

### 2. Posts List Test
1. **Go to**: `Posts > All Posts`
2. **Look for**: "Content Age" column
3. **Verify**: All 100 posts show age indicators
4. **Test**: Sort by clicking "Content Age" column header
5. **Check**: Color coding matches age categories

### 3. Pages List Test
1. **Go to**: `Pages > All Pages`
2. **Look for**: "Content Age" column
3. **Verify**: All 10 pages show age indicators
4. **Test**: Sort by clicking "Content Age" column header

### 4. Performance Test
1. **Measure**: Page load times with 100+ posts
2. **Check**: No JavaScript errors in console
3. **Verify**: Dashboard loads quickly
4. **Test**: Posts list pagination works

## 🎨 Expected Color Coding

- **🟢 Green**: Very Fresh (0-30 days) and Fresh (31-180 days)
- **🟡 Yellow**: Aging (181-365 days)
- **🟠 Orange**: Stale (366-730 days)
- **🔴 Red**: Very Stale (731+ days)

## 📊 Expected Results

### Dashboard Widget Should Show:
```
📅 Content Freshness Alert
🔴 Ancient Article 5 (1,500 days old)
🔴 Ancient Article 4 (1,200 days old)
🔴 Ancient Article 3 (1,000 days old)
🔴 Ancient Article 2 (800 days old)
🔴 Ancient Article 1 (731 days old)
🟠 Old Tutorial 15 (730 days old)
🟠 Old Tutorial 14 (700 days old)
🟠 Old Tutorial 13 (650 days old)
🟠 Old Tutorial 12 (600 days old)
🟠 Old Tutorial 11 (550 days old)
```

### Posts List Should Show:
- 100 posts total
- "Content Age" column visible
- Sortable by age
- Color coding applied correctly
- Pagination working (10 posts per page)

## 🚨 Troubleshooting

### Script Fails to Run
- Check file permissions: `chmod +x bulk-data-wpcli.sh`
- Verify WordPress is installed correctly
- Check MAMP is running

### Posts Not Created
- Check WordPress database connection
- Verify user has proper permissions
- Check for PHP errors in debug.log

### Plugin Not Working
- Verify plugin is activated
- Check for JavaScript errors in console
- Refresh the page
- Check Screen Options (columns may be hidden)

### Performance Issues
- Reduce number of posts if needed
- Check server resources
- Optimize database if necessary

## 🧹 Cleanup (Optional)

### Remove All Test Posts
```sql
-- Run this in phpMyAdmin
DELETE FROM wp_posts 
WHERE post_type = 'post' 
AND post_title LIKE '%Recent Blog Post%'
OR post_title LIKE '%Monthly Newsletter%'
OR post_title LIKE '%Quarterly Report%'
OR post_title LIKE '%Old Tutorial%'
OR post_title LIKE '%Ancient Article%';
```

### Remove Test Pages
```sql
-- Run this in phpMyAdmin
DELETE FROM wp_posts 
WHERE post_type = 'page' 
AND post_title LIKE '%Test Page%';
```

## ✅ Success Criteria

- [ ] 100 test posts created successfully
- [ ] 10 test pages created successfully
- [ ] Dashboard widget shows oldest posts
- [ ] Posts list shows "Content Age" column
- [ ] Pages list shows "Content Age" column
- [ ] Color coding works correctly
- [ ] Sorting works properly
- [ ] Performance remains acceptable
- [ ] No errors in debug.log

## 🎯 Ready for Comprehensive Testing!

With 100+ test posts, you can now thoroughly test:
- Plugin performance with large datasets
- Age calculation accuracy
- Color coding consistency
- Sorting functionality
- Dashboard widget performance
- List table performance
- Memory usage
- Database query efficiency

This bulk data will help ensure the plugin works perfectly before WordPress.org submission!
