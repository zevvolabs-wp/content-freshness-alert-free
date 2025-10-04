#!/bin/bash

# WordPress Plugin Release Script
# This script creates a clean release package for WordPress.org submission

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
PLUGIN_NAME="content-freshness-alert"
PLUGIN_DIR="."
RELEASE_DIR="release"
VERSION=""

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to show usage
show_usage() {
    echo "Usage: $0 [VERSION]"
    echo ""
    echo "Creates a WordPress plugin release package"
    echo ""
    echo "Arguments:"
    echo "  VERSION    Version number (e.g., 1.0.0). If not provided, will try to extract from git tag"
    echo ""
    echo "Examples:"
    echo "  $0 1.0.0"
    echo "  $0"
    echo ""
}

# Function to extract version from git tag
get_version_from_git() {
    local latest_tag=$(git describe --tags --abbrev=0 2>/dev/null || echo "")
    if [ -z "$latest_tag" ]; then
        print_error "No git tags found. Please provide a version number."
        exit 1
    fi
    
    # Remove 'v' prefix if present
    VERSION=${latest_tag#v}
    print_status "Extracted version from git tag: $VERSION"
}

# Function to validate version format
validate_version() {
    if [[ ! $VERSION =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        print_error "Invalid version format. Use semantic versioning (e.g., 1.0.0)"
        exit 1
    fi
}

# Function to check prerequisites
check_prerequisites() {
    print_status "Checking prerequisites..."
    
    # Check if we're in a git repository
    if [ ! -d ".git" ]; then
        print_error "Not in a git repository"
        exit 1
    fi
    
    # Check if main plugin file exists
    if [ ! -f "${PLUGIN_NAME}.php" ]; then
        print_error "Main plugin file not found: ${PLUGIN_NAME}.php"
        exit 1
    fi
    
    # Check if readme.txt exists
    if [ ! -f "readme.txt" ]; then
        print_error "readme.txt not found"
        exit 1
    fi
    
    print_success "Prerequisites check passed"
}

# Function to clean up previous releases
cleanup_release_dir() {
    print_status "Cleaning up previous release directory..."
    
    if [ -d "$RELEASE_DIR" ]; then
        rm -rf "$RELEASE_DIR"
        print_success "Removed previous release directory"
    fi
    
    mkdir -p "$RELEASE_DIR/$PLUGIN_NAME"
    print_success "Created release directory"
}

# Function to update version in files
update_version() {
    print_status "Updating version to $VERSION..."
    
    # Update main plugin file
    if [ -f "${PLUGIN_NAME}.php" ]; then
        # Update version in plugin header
        sed -i.bak "s/Version: [0-9.]*/Version: $VERSION/" "${PLUGIN_NAME}.php"
        
        # Update version constant if it exists
        if grep -q "define.*CFA_VERSION" "${PLUGIN_NAME}.php"; then
            sed -i.bak "s/define.*CFA_VERSION.*[0-9.]*/define('CFA_VERSION', '$VERSION');/" "${PLUGIN_NAME}.php"
        fi
        
        # Remove backup file
        rm -f "${PLUGIN_NAME}.php.bak"
        
        print_success "Updated version in ${PLUGIN_NAME}.php"
    fi
    
    # Update readme.txt
    if [ -f "readme.txt" ]; then
        sed -i.bak "s/Stable tag: [0-9.]*/Stable tag: $VERSION/" "readme.txt"
        rm -f "readme.txt.bak"
        print_success "Updated version in readme.txt"
    fi
}

# Function to copy essential files
copy_essential_files() {
    print_status "Copying essential files..."
    
    # Essential files and directories
    ESSENTIAL_FILES=(
        "${PLUGIN_NAME}.php"
        "includes/"
        "assets/"
        "languages/"
        "uninstall.php"
        "readme.txt"
    )
    
    for item in "${ESSENTIAL_FILES[@]}"; do
        if [ -e "$item" ]; then
            if [ -d "$item" ]; then
                cp -r "$item" "$RELEASE_DIR/$PLUGIN_NAME/"
                print_success "Copied directory: $item"
            else
                cp "$item" "$RELEASE_DIR/$PLUGIN_NAME/"
                print_success "Copied file: $item"
            fi
        else
            print_warning "File/directory not found: $item"
        fi
    done
}

# Function to create screenshots directory
create_screenshots_dir() {
    print_status "Creating screenshots directory..."
    
    mkdir -p "$RELEASE_DIR/$PLUGIN_NAME/screenshots"
    
    # Copy README if it exists
    if [ -f "screenshots/README.md" ]; then
        cp "screenshots/README.md" "$RELEASE_DIR/$PLUGIN_NAME/screenshots/"
        print_success "Copied screenshots README"
    fi
    
    print_success "Created screenshots directory"
}

# Function to validate release package
validate_release() {
    print_status "Validating release package..."
    
    local release_path="$RELEASE_DIR/$PLUGIN_NAME"
    
    # Check essential files
    local essential_files=(
        "${PLUGIN_NAME}.php"
        "readme.txt"
        "uninstall.php"
    )
    
    for file in "${essential_files[@]}"; do
        if [ ! -f "$release_path/$file" ]; then
            print_error "Missing essential file: $file"
            exit 1
        fi
    done
    
    # Check essential directories
    local essential_dirs=(
        "includes"
        "assets"
        "languages"
    )
    
    for dir in "${essential_dirs[@]}"; do
        if [ ! -d "$release_path/$dir" ]; then
            print_error "Missing essential directory: $dir"
            exit 1
        fi
    done
    
    print_success "Release package validation passed"
}

# Function to create ZIP package
create_zip_package() {
    print_status "Creating ZIP package..."
    
    local zip_name="${PLUGIN_NAME}-${VERSION}.zip"
    local zip_path="$RELEASE_DIR/$zip_name"
    
    cd "$RELEASE_DIR"
    zip -r "$zip_name" "$PLUGIN_NAME/" -q
    cd ..
    
    # Check if ZIP was created successfully
    if [ -f "$zip_path" ]; then
        local zip_size=$(du -h "$zip_path" | cut -f1)
        print_success "Created ZIP package: $zip_name (Size: $zip_size)"
    else
        print_error "Failed to create ZIP package"
        exit 1
    fi
}

# Function to generate checksums
generate_checksums() {
    print_status "Generating checksums..."
    
    local zip_name="${PLUGIN_NAME}-${VERSION}.zip"
    local zip_path="$RELEASE_DIR/$zip_name"
    
    # Generate SHA256 checksum
    sha256sum "$zip_path" > "$zip_path.sha256"
    print_success "Generated SHA256 checksum"
    
    # Generate MD5 checksum
    md5sum "$zip_path" > "$zip_path.md5"
    print_success "Generated MD5 checksum"
}

# Function to display release info
display_release_info() {
    echo ""
    echo "=========================================="
    print_success "RELEASE CREATED SUCCESSFULLY!"
    echo "=========================================="
    echo ""
    echo "Plugin Name: $PLUGIN_NAME"
    echo "Version: $VERSION"
    echo "Release Directory: $RELEASE_DIR/"
    echo "ZIP Package: $RELEASE_DIR/${PLUGIN_NAME}-${VERSION}.zip"
    echo ""
    echo "Files included:"
    ls -la "$RELEASE_DIR/$PLUGIN_NAME/"
    echo ""
    echo "Ready for WordPress.org submission!"
    echo ""
}

# Main execution
main() {
    echo "WordPress Plugin Release Script"
    echo "================================"
    echo ""
    
    # Parse arguments
    if [ $# -eq 0 ]; then
        get_version_from_git
    else
        VERSION="$1"
    fi
    
    # Validate version
    validate_version
    
    # Check prerequisites
    check_prerequisites
    
    # Create release
    cleanup_release_dir
    update_version
    copy_essential_files
    create_screenshots_dir
    validate_release
    create_zip_package
    generate_checksums
    display_release_info
}

# Run main function
main "$@"
