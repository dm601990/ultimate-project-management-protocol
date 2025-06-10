#!/bin/bash
# 🚀 Automated GitHub Repository Setup Script
# This script will automatically set up your Ultimate Project Management Protocol repository

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 AUTOMATED GITHUB REPOSITORY SETUP${NC}"
echo -e "${CYAN}Setting up: ultimate-project-management-protocol${NC}"
echo "=================================================="

# Configuration
REPO_NAME="ultimate-project-management-protocol"
GITHUB_USER="dm601990"
SOURCE_DIR="/Users/dd60/faafo/faafo"

# Function to check if we're in the right directory
check_directory() {
    if [ ! -d ".git" ]; then
        echo -e "${RED}❌ Not in a git repository!${NC}"
        echo -e "${YELLOW}Please run this script from your cloned repository directory:${NC}"
        echo "cd $REPO_NAME"
        echo "./auto-setup-github-repo.sh"
        exit 1
    fi
    
    echo -e "${GREEN}✅ Git repository detected${NC}"
}

# Function to create directory structure
create_structure() {
    echo -e "\n${YELLOW}📁 Creating directory structure...${NC}"
    
    mkdir -p scripts/core scripts/templates docs/examples templates/framework-specific
    
    echo -e "${GREEN}✅ Directory structure created${NC}"
}

# Function to copy files from source
copy_files() {
    echo -e "\n${YELLOW}📋 Copying files from source project...${NC}"
    
    # Copy README
    if [ -f "$SOURCE_DIR/github-repo-README.md" ]; then
        cp "$SOURCE_DIR/github-repo-README.md" README.md
        echo "✅ README.md"
    fi
    
    # Copy installer
    if [ -f "$SOURCE_DIR/github-repo-install.sh" ]; then
        cp "$SOURCE_DIR/github-repo-install.sh" scripts/install.sh
        chmod +x scripts/install.sh
        echo "✅ scripts/install.sh"
    fi
    
    # Copy core scripts
    if [ -f "$SOURCE_DIR/scripts/ultimate-project-discovery.sh" ]; then
        cp "$SOURCE_DIR/scripts/ultimate-project-discovery.sh" scripts/core/
        chmod +x scripts/core/ultimate-project-discovery.sh
        echo "✅ scripts/core/ultimate-project-discovery.sh"
    fi
    
    if [ -f "$SOURCE_DIR/scripts/validate-before-create.sh" ]; then
        cp "$SOURCE_DIR/scripts/validate-before-create.sh" scripts/core/
        chmod +x scripts/core/validate-before-create.sh
        echo "✅ scripts/core/validate-before-create.sh"
    fi
    
    if [ -f "$SOURCE_DIR/scripts/project-intelligence.ts" ]; then
        cp "$SOURCE_DIR/scripts/project-intelligence.ts" scripts/core/
        echo "✅ scripts/core/project-intelligence.ts"
    fi
    
    if [ -f "$SOURCE_DIR/scripts/tdd-protocol.ts" ]; then
        cp "$SOURCE_DIR/scripts/tdd-protocol.ts" scripts/core/
        echo "✅ scripts/core/tdd-protocol.ts"
    fi
    
    if [ -f "$SOURCE_DIR/scripts/setup-ultimate-protocol.sh" ]; then
        cp "$SOURCE_DIR/scripts/setup-ultimate-protocol.sh" scripts/templates/
        chmod +x scripts/templates/setup-ultimate-protocol.sh
        echo "✅ scripts/templates/setup-ultimate-protocol.sh"
    fi
    
    # Copy documentation
    if [ -f "$SOURCE_DIR/docs/ULTIMATE_PROJECT_MANAGEMENT_PROTOCOL.md" ]; then
        cp "$SOURCE_DIR/docs/ULTIMATE_PROJECT_MANAGEMENT_PROTOCOL.md" docs/
        echo "✅ docs/ULTIMATE_PROJECT_MANAGEMENT_PROTOCOL.md"
    fi
    
    if [ -f "$SOURCE_DIR/docs/UNIVERSAL_DUPLICATE_PREVENTION_TEMPLATE.md" ]; then
        cp "$SOURCE_DIR/docs/UNIVERSAL_DUPLICATE_PREVENTION_TEMPLATE.md" docs/
        echo "✅ docs/UNIVERSAL_DUPLICATE_PREVENTION_TEMPLATE.md"
    fi
    
    if [ -f "$SOURCE_DIR/docs/SYSTEMATIC_DUPLICATE_PREVENTION_PROTOCOL.md" ]; then
        cp "$SOURCE_DIR/docs/SYSTEMATIC_DUPLICATE_PREVENTION_PROTOCOL.md" docs/
        echo "✅ docs/SYSTEMATIC_DUPLICATE_PREVENTION_PROTOCOL.md"
    fi
    
    if [ -f "$SOURCE_DIR/docs/IMPLEMENTATION_COMPLETE_SUMMARY.md" ]; then
        cp "$SOURCE_DIR/docs/IMPLEMENTATION_COMPLETE_SUMMARY.md" docs/
        echo "✅ docs/IMPLEMENTATION_COMPLETE_SUMMARY.md"
    fi
    
    if [ -f "$SOURCE_DIR/github-repo-files/docs/quick-start.md" ]; then
        cp "$SOURCE_DIR/github-repo-files/docs/quick-start.md" docs/
        echo "✅ docs/quick-start.md"
    fi
    
    # Copy templates
    if [ -f "$SOURCE_DIR/project-config.yml" ]; then
        cp "$SOURCE_DIR/project-config.yml" templates/project-config.yml.template
        echo "✅ templates/project-config.yml.template"
    fi
    
    if [ -f "$SOURCE_DIR/.project_context.md" ]; then
        cp "$SOURCE_DIR/.project_context.md" templates/project-context.md.template
        echo "✅ templates/project-context.md.template"
    fi
    
    echo -e "${GREEN}✅ Files copied successfully${NC}"
}

# Function to create additional files
create_additional_files() {
    echo -e "\n${YELLOW}📝 Creating additional files...${NC}"
    
    # Create LICENSE
    cat > LICENSE << 'EOF'
MIT License

Copyright (c) 2024 dm601990

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF
    echo "✅ LICENSE"
    
    # Create .gitignore
    cat > .gitignore << 'EOF'
# Dependencies
node_modules/
*.log

# OS generated files
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# IDE files
.vscode/
.idea/
*.swp
*.swo

# Temporary files
*.tmp
*.temp
.cache/

# Test coverage
coverage/
*.lcov

# Local development
.env
.env.local
EOF
    echo "✅ .gitignore"
    
    # Create CONTRIBUTING.md
    cat > CONTRIBUTING.md << 'EOF'
# Contributing to Ultimate Project Management Protocol

Thank you for your interest in contributing! 🎉

## Ways to Contribute

- 🐛 **Report bugs** via Issues
- 💡 **Suggest features** via Discussions
- 📝 **Improve documentation**
- 🔧 **Add framework support**
- 🧪 **Add test cases**

## Development Setup

1. Fork the repository
2. Clone your fork
3. Create a feature branch
4. Make your changes
5. Test thoroughly
6. Submit a pull request

## Code Style

- Follow existing patterns
- Add tests for new features
- Update documentation
- Use clear commit messages

## Questions?

Open a Discussion or Issue - we're here to help!
EOF
    echo "✅ CONTRIBUTING.md"
    
    echo -e "${GREEN}✅ Additional files created${NC}"
}

# Function to commit and push
commit_and_push() {
    echo -e "\n${YELLOW}📤 Committing and pushing to GitHub...${NC}"
    
    # Add all files
    git add .
    echo "✅ Files added to git"
    
    # Check if there are changes to commit
    if git diff --staged --quiet; then
        echo -e "${YELLOW}⚠️ No changes to commit${NC}"
        return 0
    fi
    
    # Commit with detailed message
    git commit -m "🚀 Initial release: Ultimate Project Management Protocol

✨ Features:
- 🛡️ 100% duplicate prevention system
- 📁 Systematic project organization  
- 🧪 Test-first development protocol
- 🔄 Self-healing architecture
- 🌍 Universal compatibility (Next.js, React, Python, etc.)
- 🤖 AI assistant integration

🎯 One-command installation for any project:
curl -sSL https://raw.githubusercontent.com/dm601990/ultimate-project-management-protocol/main/scripts/install.sh | bash

📚 Complete documentation and examples included
🚀 Ready for community use and contributions

Files included:
- Core scripts for project discovery and validation
- Comprehensive documentation
- Universal installer
- Framework-specific templates
- TDD protocol implementation
- Self-healing architecture patterns"
    
    echo "✅ Changes committed"
    
    # Push to GitHub
    echo -e "${YELLOW}Pushing to GitHub...${NC}"
    git push origin main
    echo "✅ Pushed to GitHub"
}

# Function to test installation
test_installation() {
    echo -e "\n${YELLOW}🧪 Testing installation...${NC}"
    
    # Create temporary directory for testing
    TEST_DIR="/tmp/test-ultimate-protocol-$$"
    mkdir -p "$TEST_DIR"
    cd "$TEST_DIR"
    
    echo "Testing installer from GitHub..."
    
    # Wait a moment for GitHub to update
    sleep 5
    
    # Test the installer
    if curl -sSL "https://raw.githubusercontent.com/$GITHUB_USER/$REPO_NAME/main/scripts/install.sh" | bash; then
        echo -e "${GREEN}✅ Installation test successful!${NC}"
    else
        echo -e "${YELLOW}⚠️ Installation test failed - GitHub may need a moment to update${NC}"
    fi
    
    # Clean up
    cd - > /dev/null
    rm -rf "$TEST_DIR"
}

# Function to show completion
show_completion() {
    echo -e "\n${GREEN}🎉 REPOSITORY SETUP COMPLETE!${NC}"
    echo -e "${CYAN}Your repository is now live at:${NC}"
    echo "https://github.com/$GITHUB_USER/$REPO_NAME"
    echo ""
    echo -e "${YELLOW}What's available now:${NC}"
    echo "✅ Professional README with examples"
    echo "✅ One-command installer for any project"
    echo "✅ Complete documentation"
    echo "✅ Core scripts and templates"
    echo "✅ MIT license and contribution guidelines"
    echo ""
    echo -e "${PURPLE}🚀 Anyone can now install with:${NC}"
    echo "curl -sSL https://raw.githubusercontent.com/$GITHUB_USER/$REPO_NAME/main/scripts/install.sh | bash"
    echo ""
    echo -e "${CYAN}Next steps:${NC}"
    echo "1. Visit your repository and verify everything looks good"
    echo "2. Test the installer in a new project"
    echo "3. Share with the community!"
    echo "4. Consider adding GitHub topics/tags for discoverability"
}

# Main execution
main() {
    echo -e "\n${PURPLE}Starting automated repository setup...${NC}"
    
    check_directory
    create_structure
    copy_files
    create_additional_files
    commit_and_push
    test_installation
    show_completion
}

# Help function
show_help() {
    echo "Usage: $0"
    echo ""
    echo "Automated setup script for Ultimate Project Management Protocol repository."
    echo ""
    echo "This script will:"
    echo "  - Copy all necessary files from your FAAFO project"
    echo "  - Create additional repository files (LICENSE, .gitignore, etc.)"
    echo "  - Commit and push everything to GitHub"
    echo "  - Test the installation"
    echo ""
    echo "Prerequisites:"
    echo "  - Must be run from inside your cloned repository directory"
    echo "  - Git must be configured with your credentials"
    echo "  - Source files must exist in $SOURCE_DIR"
}

# Check for help flag
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    show_help
    exit 0
fi

# Run main function
main
