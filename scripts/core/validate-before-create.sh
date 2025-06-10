#!/bin/bash
# 🛡️ Duplicate Prevention Validation Script
# Run this before creating any new files/directories

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔍 SYSTEMATIC DUPLICATE PREVENTION CHECK${NC}"
echo "=================================================="

# Function to check for duplicates
check_duplicates() {
    local name=$1
    local type=$2
    
    echo -e "\n${YELLOW}📁 Checking for duplicate ${type}s: ${name}${NC}"
    
    if [ "$type" = "directory" ]; then
        find . -name "$name" -type d | grep -v node_modules | grep -v .git
    else
        find . -iname "*$name*" -type f | grep -v node_modules | grep -v .git | head -10
    fi
}

# Function to validate project structure
validate_structure() {
    echo -e "\n${YELLOW}📋 Project Structure Validation${NC}"
    
    # Check for structure guide
    if [ -f "docs/PROJECT_STRUCTURE_GUIDE.md" ]; then
        echo -e "${GREEN}✅ Structure guide found${NC}"
    else
        echo -e "${RED}❌ No structure guide found${NC}"
        echo -e "${YELLOW}   Consider creating docs/PROJECT_STRUCTURE_GUIDE.md${NC}"
    fi
    
    # Check for project config
    if [ -f "project-config.yml" ]; then
        echo -e "${GREEN}✅ Project config found${NC}"
    else
        echo -e "${YELLOW}⚠️  No project-config.yml found${NC}"
    fi
    
    # Check for conventions
    if [ -f "docs/PROJECT_CONVENTIONS.md" ]; then
        echo -e "${GREEN}✅ Project conventions found${NC}"
    else
        echo -e "${YELLOW}⚠️  No project conventions found${NC}"
    fi
}

# Function to check common duplicate patterns
check_common_duplicates() {
    echo -e "\n${YELLOW}🔍 Common Duplicate Patterns${NC}"
    
    echo -e "\n${BLUE}Components directories:${NC}"
    find . -name "components" -type d | grep -v node_modules | grep -v .git
    
    echo -e "\n${BLUE}Docs directories:${NC}"
    find . -name "docs" -type d | grep -v node_modules | grep -v .git
    
    echo -e "\n${BLUE}Lib/Utils directories:${NC}"
    find . -name "lib" -type d | grep -v node_modules | grep -v .git
    find . -name "utils" -type d | grep -v node_modules | grep -v .git
    
    echo -e "\n${BLUE}Config files:${NC}"
    find . -name "*.config.*" -type f | grep -v node_modules | grep -v .git
}

# Function to search for functionality
search_functionality() {
    local search_term=$1
    
    if [ -n "$search_term" ]; then
        echo -e "\n${YELLOW}🔎 Searching for existing functionality: ${search_term}${NC}"
        
        # Search in TypeScript/JavaScript files
        echo -e "\n${BLUE}In code files:${NC}"
        grep -r "$search_term" --include="*.ts" --include="*.tsx" --include="*.js" --include="*.jsx" . | grep -v node_modules | head -5
        
        # Search in file names
        echo -e "\n${BLUE}In file names:${NC}"
        find . -iname "*$search_term*" -type f | grep -v node_modules | grep -v .git | head -5
    fi
}

# Main execution
main() {
    # Validate project structure
    validate_structure
    
    # Check common duplicate patterns
    check_common_duplicates
    
    # If search term provided, search for functionality
    if [ $# -gt 0 ]; then
        search_functionality "$1"
    fi
    
    echo -e "\n${GREEN}✅ Duplicate prevention check complete${NC}"
    echo -e "${YELLOW}💡 Remember to:${NC}"
    echo "   1. Check project documentation first"
    echo "   2. Follow established patterns"
    echo "   3. Use canonical directory locations"
    echo "   4. Avoid creating duplicate functionality"
    echo ""
}

# Help function
show_help() {
    echo "Usage: $0 [search_term]"
    echo ""
    echo "This script checks for duplicate files and directories before creation."
    echo ""
    echo "Arguments:"
    echo "  search_term    Optional: Search for existing functionality"
    echo ""
    echo "Examples:"
    echo "  $0                    # General duplicate check"
    echo "  $0 LoginForm         # Search for LoginForm functionality"
    echo "  $0 assessment        # Search for assessment-related files"
}

# Check for help flag
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    show_help
    exit 0
fi

# Run main function
main "$@"
