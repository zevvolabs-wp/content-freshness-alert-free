# Final Testing Guide

## Pre-Submission Testing Checklist

### Environment Setup
- [ ] Fresh WordPress 6.4+ installation
- [ ] Default theme (Twenty Twenty-Four)
- [ ] PHP 7.4 or 8.0+
- [ ] WP_DEBUG enabled in wp-config.php
- [ ] Query Monitor plugin installed (for performance testing)

### Installation Testing
1. **Upload Plugin**:
   - [ ] Upload `content-freshness-alert.zip` via WordPress admin
   - [ ] Activate plugin through Plugins screen
   - [ ] Verify no PHP errors in debug.log

2. **Initial Activation**:
   - [ ] Dashboard widget appears immediately
   - [ ] "Content Age" column appears on Posts list
   - [ ] "Content Age" column appears on Pages list
   - [ ] Cron job scheduled (check: `wp cron event list`)

### Content Creation for Testing
Create test posts with varying ages:

1. **Recent Posts** (0-30 days):
   - [ ] Create 3 posts with current date
   - [ ] Verify they show as "Today" or "X days ago"
   - [ ] Verify green color coding

2. **Aging Posts** (31-365 days):
   - [ ] Create 3 posts with backdated modification dates
   - [ ] Use dates: 60 days ago, 180 days ago, 300 days ago
   - [ ] Verify yellow color coding

3. **Stale Posts** (366-730 days):
   - [ ] Create 2 posts with dates: 400 days ago, 600 days ago
   - [ ] Verify orange color coding

4. **Very Stale Posts** (731+ days):
   - [ ] Create 2 posts with dates: 800 days ago, 1000 days ago
   - [ ] Verify red color coding

### Dashboard Widget Testing
- [ ] Widget displays on dashboard
- [ ] Shows exactly 10 oldest posts (or fewer if <10 exist)
- [ ] Post titles are clickable and open in editor
- [ ] Ages display correctly formatted
- [ ] Colors match age categories
- [ ] Widget is collapsible
- [ ] Widget respects admin color scheme

### List Table Testing
**Posts List (wp-admin/edit.php)**:
- [ ] "Content Age" column appears after "Date" column
- [ ] Ages display correctly for all posts
- [ ] Colors match age categories
- [ ] Column is sortable (click header)
- [ ] Sorting works ascending/descending
- [ ] Column visible in Screen Options
- [ ] Can be hidden via Screen Options

**Pages List (wp-admin/edit.php?post_type=page)**:
- [ ] "Content Age" column appears after "Date" column
- [ ] Ages display correctly for all pages
- [ ] Colors match age categories
- [ ] Column is sortable
- [ ] Sorting works correctly

### Age Calculation Testing
- [ ] Create new post → shows "Today"
- [ ] Edit existing post → age updates immediately
- [ ] Delete post → removes from widget
- [ ] Verify ages calculated from `post_modified` date
- [ ] Test edge cases: future dates, invalid dates

### Performance Testing
- [ ] Dashboard loads in <2 seconds (with 100 posts)
- [ ] Posts list loads in <3 seconds (with 1,000 posts)
- [ ] No slowdown after plugin activation
- [ ] Query Monitor shows <5 queries per page
- [ ] No JavaScript errors in console
- [ ] Memory usage remains stable

### Cron Job Testing
- [ ] Verify cron job scheduled: `wp cron event list`
- [ ] Test cron execution: `wp cron test`
- [ ] Verify post meta updated after cron run
- [ ] Check dashboard widget reflects new data

### Compatibility Testing
**WordPress Versions**:
- [ ] WordPress 5.8 (minimum requirement)
- [ ] WordPress 6.4 (latest stable)

**PHP Versions**:
- [ ] PHP 7.4 (minimum requirement)
- [ ] PHP 8.0
- [ ] PHP 8.1
- [ ] PHP 8.2

**Popular Plugins**:
- [ ] Yoast SEO
- [ ] WooCommerce
- [ ] Elementor
- [ ] Contact Form 7
- [ ] Jetpack

### Browser Testing
- [ ] Chrome (latest)
- [ ] Firefox (latest)
- [ ] Safari (if available)
- [ ] Edge (latest)
- [ ] Mobile responsive (Chrome DevTools)

### Deactivation/Uninstall Testing
- [ ] Deactivate plugin → cron job removed
- [ ] Reactivate plugin → cron job re-scheduled
- [ ] Delete plugin → uninstall.php runs
- [ ] Post meta remains (intentional)
- [ ] No orphaned cron jobs

### Security Testing
- [ ] No PHP errors with WP_DEBUG enabled
- [ ] No JavaScript console errors
- [ ] All output properly escaped
- [ ] No direct database access
- [ ] No file operations outside uploads

### Translation Testing
- [ ] POT file included and valid
- [ ] All user-facing strings translatable
- [ ] Text domain correctly declared
- [ ] Translation functions used properly

## Expected Results

### Successful Test Outcomes
- ✅ Plugin activates without errors
- ✅ Dashboard widget appears and functions correctly
- ✅ List table columns display properly
- ✅ Age calculations are accurate
- ✅ Color coding works as expected
- ✅ Performance remains optimal
- ✅ No security vulnerabilities
- ✅ Full WordPress.org compliance

### Common Issues to Watch For
- ❌ PHP errors in debug.log
- ❌ JavaScript console errors
- ❌ Slow page load times
- ❌ Incorrect age calculations
- ❌ Missing color coding
- ❌ Cron job not scheduled
- ❌ Post meta not created

## Testing Environment

### Recommended Setup
```
WordPress: 6.4+
PHP: 8.0+
MySQL: 8.0+
Theme: Twenty Twenty-Four
Plugins: Query Monitor, WP-CLI
```

### Test Data Requirements
- Minimum 15 posts with varying ages
- Minimum 5 pages with varying ages
- Mix of published and draft posts
- Different post authors
- Various post categories

## Post-Testing Actions

After successful testing:
1. Document any issues found
2. Fix any critical problems
3. Re-test after fixes
4. Update version number if needed
5. Prepare final submission package
6. Submit to WordPress.org

## Notes

- All tests must pass before submission
- Document any non-critical issues
- Keep testing environment clean
- Use consistent test data
- Verify all features work as specified
