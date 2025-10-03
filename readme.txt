=== Content Freshness Alert ===
Contributors: zevvolabs
Tags: content, freshness, age, monitoring, seo, dashboard, posts, pages
Requires at least: 5.8
Tested up to: 6.4
Requires PHP: 7.4
Stable tag: 1.0.0
License: GPLv2 or later
License URI: https://www.gnu.org/licenses/gpl-2.0.html

Monitor content age and receive alerts for outdated posts needing updates. Dashboard widget shows oldest content with color-coded indicators.

== Description ==

Content Freshness Alert helps you identify outdated content that may be hurting your SEO rankings and user trust. The plugin provides visual indicators of content age through a dashboard widget and list table columns.

**Key Features:**

* **Dashboard Widget** - Shows 10 oldest posts/pages with color-coded age indicators
* **Content Age Column** - Adds "Content Age" column to Posts and Pages list tables
* **Color-Coded Indicators** - Green (fresh), Yellow (aging), Orange (stale), Red (very stale)
* **Zero Configuration** - Works immediately after activation
* **Sortable Columns** - Sort posts by content age
* **Daily Updates** - Automatic age calculation via WordPress cron
* **Performance Optimized** - Cached data for fast loading

**Age Categories:**

* **Fresh** (0-180 days) - Recently updated content
* **Aging** (181-365 days) - Content that may need review
* **Stale** (366-730 days) - Content that needs updating
* **Very Stale** (731+ days) - Urgent update required

**Perfect for:**

* Bloggers managing 50-500 posts
* Content marketers tracking content freshness for SEO
* Small business owners maintaining website quality
* Anyone who wants to identify outdated content quickly

The plugin is lightweight, secure, and follows WordPress coding standards. No external dependencies or API calls required.

== Installation ==

1. Upload the plugin files to the `/wp-content/plugins/content-freshness-alert` directory, or install the plugin through the WordPress plugins screen directly.
2. Activate the plugin through the 'Plugins' screen in WordPress.
3. The dashboard widget will appear immediately showing your oldest content.
4. The "Content Age" column will be added to your Posts and Pages list tables.

That's it! No configuration required.

== Frequently Asked Questions ==

= Does this plugin require any configuration? =

No! The plugin works immediately after activation. The dashboard widget appears and the Content Age column is added to your posts and pages lists automatically.

= How does the plugin calculate content age? =

The plugin uses the `post_modified` date from WordPress. When you edit and save a post, the age resets to 0 days.

= What age categories are used? =

* Fresh: 0-180 days (6 months)
* Aging: 181-365 days (12 months)
* Stale: 366-730 days (24 months)
* Very Stale: 731+ days (2+ years)

= Does the plugin slow down my website? =

No. The plugin uses WordPress cron for background processing and caches data to ensure optimal performance.

= Can I customize the age thresholds? =

Not in version 1.0.0. Custom thresholds may be available in future versions.

= Does the plugin work with custom post types? =

Version 1.0.0 only supports Posts and Pages. Custom post type support may be added in future versions.

= Is the plugin translation ready? =

Yes! The plugin includes a POT file and is ready for translation into any language.

== Screenshots ==

1. Dashboard widget showing oldest content with color-coded indicators
2. Posts list table with Content Age column
3. Pages list table with Content Age column
4. Color-coded age indicators in action

== Changelog ==

= 1.0.0 =
* Initial release
* Dashboard widget showing 10 oldest posts/pages
* Content Age column in Posts and Pages list tables
* Color-coded age indicators (Green, Yellow, Orange, Red)
* Daily cron job for age calculation
* Zero configuration required
* Full WordPress.org compliance

== Upgrade Notice ==

= 1.0.0 =
Initial release of Content Freshness Alert. No upgrade needed.

== Support ==

For support, feature requests, or bug reports, please visit the [plugin support forum](https://wordpress.org/support/plugin/content-freshness-alert/).

== Privacy Policy ==

This plugin does not collect, store, or transmit any personal data. It only processes your existing WordPress content to calculate and display age information. No external API calls are made and no data is sent to third parties.
