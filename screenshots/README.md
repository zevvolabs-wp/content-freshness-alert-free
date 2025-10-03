# Screenshots for WordPress.org Submission

## Required Screenshots (1200x900px)

### Screenshot 1: Dashboard Widget
**File**: `screenshot-1.png`
**Description**: Dashboard widget showing oldest content with color-coded indicators
**Content**: WordPress admin dashboard with "📅 Content Freshness Alert" widget in sidebar showing 10 oldest posts with green/yellow/orange/red color coding

### Screenshot 2: Posts List Table
**File**: `screenshot-2.png`
**Description**: Posts list table with Content Age column
**Content**: wp-admin/edit.php showing posts list with "Content Age" column displaying age indicators

### Screenshot 3: Pages List Table
**File**: `screenshot-3.png`
**Description**: Pages list table with Content Age column
**Content**: wp-admin/edit.php?post_type=page showing pages list with "Content Age" column

### Screenshot 4: Color-Coded Indicators
**File**: `screenshot-4.png`
**Description**: Close-up view of color-coded age indicators
**Content**: Detailed view showing different age categories with their respective colors (green for fresh, yellow for aging, orange for stale, red for very stale)

## Screenshot Creation Instructions

1. **Setup Test Environment**:
   - Fresh WordPress 6.4+ installation
   - Default theme (Twenty Twenty-Four)
   - Create test posts with varying modification dates
   - Activate Content Freshness Alert plugin

2. **Create Test Content**:
   - Create posts with ages: 1 day, 30 days, 180 days, 365 days, 730+ days
   - Edit some posts to show different modification dates
   - Ensure variety in post titles and content

3. **Capture Screenshots**:
   - Use browser developer tools to set viewport to 1200x900
   - Take screenshots of each required view
   - Ensure good contrast and readability
   - Include WordPress admin interface elements

4. **File Naming**:
   - Use exact naming: screenshot-1.png, screenshot-2.png, etc.
   - Save as PNG format
   - Optimize file size (should be under 500KB each)

## Notes

- Screenshots will be created during testing phase
- Placeholder files will be replaced with actual screenshots
- All screenshots must show real functionality, not mockups
- Ensure WordPress admin interface is clearly visible
- Color coding must be clearly demonstrated
