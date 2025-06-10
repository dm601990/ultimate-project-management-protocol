#!/bin/bash
# 🚀 Ultimate Project Management Protocol - One-Command Installer
# Install the complete protocol in any project with a single command

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Configuration
REPO_URL="https://raw.githubusercontent.com/dm601990/ultimate-project-management-protocol/main"
PROJECT_NAME=$(basename "$(pwd)")

echo -e "${BLUE}🚀 ULTIMATE PROJECT MANAGEMENT PROTOCOL INSTALLER${NC}"
echo -e "${CYAN}Installing for project: ${PROJECT_NAME}${NC}"
echo "=================================================="

# Function to download file with error handling
download_file() {
    local url=$1
    local output=$2
    local description=$3
    
    echo -e "${YELLOW}📥 Downloading ${description}...${NC}"
    
    if curl -sSL "$url" -o "$output"; then
        echo -e "${GREEN}✅ ${description} downloaded${NC}"
        return 0
    else
        echo -e "${RED}❌ Failed to download ${description}${NC}"
        return 1
    fi
}

# Function to create directory structure
create_directories() {
    echo -e "\n${YELLOW}📁 Creating directory structure...${NC}"
    
    mkdir -p scripts docs
    
    echo -e "${GREEN}✅ Directories created${NC}"
}

# Function to download core scripts
download_core_scripts() {
    echo -e "\n${YELLOW}📋 Downloading core scripts...${NC}"
    
    # Core discovery and validation scripts
    download_file "$REPO_URL/scripts/core/ultimate-project-discovery.sh" "scripts/ultimate-project-discovery.sh" "Project Discovery Script"
    download_file "$REPO_URL/scripts/core/validate-before-create.sh" "scripts/validate-before-create.sh" "Validation Script"
    download_file "$REPO_URL/scripts/core/project-intelligence.ts" "scripts/project-intelligence.ts" "Project Intelligence"
    download_file "$REPO_URL/scripts/core/tdd-protocol.ts" "scripts/tdd-protocol.ts" "TDD Protocol"
    
    # Make scripts executable
    chmod +x scripts/*.sh 2>/dev/null || true
    
    echo -e "${GREEN}✅ Core scripts downloaded${NC}"
}

# Function to download documentation
download_documentation() {
    echo -e "\n${YELLOW}📚 Downloading documentation...${NC}"
    
    download_file "$REPO_URL/docs/ULTIMATE_PROJECT_MANAGEMENT_PROTOCOL.md" "docs/ULTIMATE_PROJECT_MANAGEMENT_PROTOCOL.md" "Main Protocol Documentation"
    download_file "$REPO_URL/docs/UNIVERSAL_DUPLICATE_PREVENTION_TEMPLATE.md" "docs/UNIVERSAL_DUPLICATE_PREVENTION_TEMPLATE.md" "Universal Template"
    download_file "$REPO_URL/docs/SYSTEMATIC_DUPLICATE_PREVENTION_PROTOCOL.md" "docs/SYSTEMATIC_DUPLICATE_PREVENTION_PROTOCOL.md" "Systematic Protocol"
    
    echo -e "${GREEN}✅ Documentation downloaded${NC}"
}

# Function to detect project type
detect_project_type() {
    local project_type="unknown"
    local framework="unknown"
    local language="unknown"
    
    # Detect language and framework
    if [ -f "package.json" ]; then
        language="javascript"
        if grep -q "typescript" package.json 2>/dev/null; then
            language="typescript"
        fi
        
        if grep -q "next" package.json 2>/dev/null; then
            framework="nextjs"
        elif grep -q "react" package.json 2>/dev/null; then
            framework="react"
        elif grep -q "vue" package.json 2>/dev/null; then
            framework="vue"
        elif grep -q "angular" package.json 2>/dev/null; then
            framework="angular"
        fi
        project_type="web-app"
    elif [ -f "requirements.txt" ] || [ -f "pyproject.toml" ]; then
        language="python"
        if grep -q "django" requirements.txt 2>/dev/null; then
            framework="django"
        elif grep -q "flask" requirements.txt 2>/dev/null; then
            framework="flask"
        elif grep -q "fastapi" requirements.txt 2>/dev/null; then
            framework="fastapi"
        fi
        project_type="web-app"
    elif [ -f "Cargo.toml" ]; then
        language="rust"
        project_type="application"
    elif [ -f "go.mod" ]; then
        language="go"
        project_type="application"
    fi
    
    echo "$project_type,$framework,$language"
}

# Function to create project configuration
create_project_config() {
    echo -e "\n${YELLOW}⚙️ Creating project configuration...${NC}"
    
    local project_info=$(detect_project_type)
    local project_type=$(echo $project_info | cut -d',' -f1)
    local framework=$(echo $project_info | cut -d',' -f2)
    local language=$(echo $project_info | cut -d',' -f3)
    
    # Create project-config.yml
    cat > project-config.yml << EOF
# Ultimate Project Management Protocol Configuration
# Auto-generated for: $PROJECT_NAME

project:
  name: "$PROJECT_NAME"
  type: "$project_type"
  language: "$language"
  framework: "$framework"
  description: "Auto-detected project configuration"

# CANONICAL DIRECTORY STRUCTURE (SINGLE SOURCE OF TRUTH)
source_structure:
  main_dir: "src"
  components_dir: "src/components"
  utils_dir: "src/lib"
  tests_dir: "__tests__"
  docs_dir: "docs"
  scripts_dir: "scripts"

# DUPLICATE PREVENTION RULES
duplicate_prevention:
  forbidden_locations:
    - "components"          # Use src/components instead
    - "lib"                # Use src/lib instead
    - "utils"              # Use src/utils instead
    - "docs/nested"        # Use root docs/ instead
  
  canonical_mappings:
    components: "src/components"
    utilities: "src/lib"
    documentation: "docs"
    tests: "__tests__"
    scripts: "scripts"

# NAMING CONVENTIONS
naming_conventions:
  files:
    components: "PascalCase"
    utilities: "camelCase"
    tests: "kebab-case.test"
    documentation: "UPPER_CASE"
  
  code:
    functions: "camelCase"
    classes: "PascalCase"
    constants: "UPPER_SNAKE_CASE"
    variables: "camelCase"

# TESTING FRAMEWORK
testing:
  framework: "auto-detect"
  test_pattern: "*.test.*"
  test_location: "__tests__"
  coverage_threshold: 80

# ARCHITECTURE PATTERNS
architecture:
  error_handling: "self-healing"
  validation: "input-output"
  logging: "structured"
  monitoring: "enabled"
EOF
    
    echo -e "${GREEN}✅ Project configuration created${NC}"
    echo -e "${CYAN}   Project Type: $project_type${NC}"
    echo -e "${CYAN}   Framework: $framework${NC}"
    echo -e "${CYAN}   Language: $language${NC}"
}

# Function to create project context
create_project_context() {
    echo -e "\n${YELLOW}📝 Creating project context...${NC}"
    
    local project_info=$(detect_project_type)
    local project_type=$(echo $project_info | cut -d',' -f1)
    local framework=$(echo $project_info | cut -d',' -f2)
    local language=$(echo $project_info | cut -d',' -f3)
    
    cat > .project_context.md << EOF
# 🎯 $PROJECT_NAME - Project Context & Intelligence

## 📊 Project Intelligence Summary
- **Type**: $project_type
- **Framework**: $framework
- **Language**: $language
- **Setup Date**: $(date)
- **Protocol Version**: Latest

## 📁 File Organization Patterns (CANONICAL STRUCTURE)

### **Source Code Structure**
\`\`\`
$PROJECT_NAME/
├── src/                           # CANONICAL: Main source code
│   ├── components/                # CANONICAL: React components
│   └── lib/                       # CANONICAL: Utilities
├── docs/                          # CANONICAL: Documentation
├── __tests__/                     # CANONICAL: All test files
├── scripts/                       # Utility scripts
└── [config files]                # Root configuration
\`\`\`

## 📝 Naming Conventions

### **Files & Directories**
- **Components**: PascalCase (\`ComponentName.tsx\`)
- **Utilities**: camelCase (\`utilityName.ts\`)
- **Tests**: \`ComponentName.test.tsx\`
- **Documentation**: UPPER_CASE (\`README.md\`)

### **Code Conventions**
- **Functions**: camelCase
- **Classes**: PascalCase
- **Constants**: UPPER_SNAKE_CASE
- **Variables**: camelCase

## 🧰 Existing Core Utilities (DO NOT DUPLICATE)

### **[Add your utilities here as you create them]**
- \`src/lib/utils.ts\` - Common utilities
- \`src/lib/validation.ts\` - Input validation

## 🧪 Testing Framework & Patterns

### **Testing Structure**
- **Framework**: Auto-detected
- **Location**: \`__tests__/\` directory (CANONICAL)
- **Pattern**: Mirror source structure in tests
- **Naming**: \`ComponentName.test.tsx\`

## 🎯 Development Workflow

### **TDD Protocol (MANDATORY)**
1. **Write failing test first**
2. **Implement minimal code to pass**
3. **Refactor with error handling**
4. **Add self-healing mechanisms**
5. **Validate integration**

### **File Creation Checklist**
- [ ] Search for existing similar functionality
- [ ] Verify naming follows project conventions
- [ ] Place in canonical directory structure
- [ ] Write tests first (TDD)
- [ ] Add error handling and validation
- [ ] Update this context document if new patterns emerge

---

**Last Updated**: Auto-generated by Ultimate Project Management Protocol
**Next Review**: Update when adding new architectural patterns
EOF
    
    echo -e "${GREEN}✅ Project context created${NC}"
}

# Function to run initial discovery
run_initial_discovery() {
    echo -e "\n${YELLOW}🔍 Running initial project discovery...${NC}"
    
    if [ -f "scripts/ultimate-project-discovery.sh" ]; then
        ./scripts/ultimate-project-discovery.sh
    else
        echo -e "${YELLOW}⚠️ Discovery script not found, skipping initial discovery${NC}"
    fi
}

# Function to show completion message
show_completion() {
    echo -e "\n${GREEN}🎉 INSTALLATION COMPLETE!${NC}"
    echo -e "${CYAN}Your project now has:${NC}"
    echo "  ✅ Ultimate project discovery system"
    echo "  ✅ Duplicate prevention protocols"
    echo "  ✅ Project intelligence documentation"
    echo "  ✅ TDD-ready structure"
    echo "  ✅ Self-healing architecture foundation"
    echo ""
    echo -e "${YELLOW}Next steps:${NC}"
    echo "  1. Review .project_context.md"
    echo "  2. Customize project-config.yml if needed"
    echo "  3. Start developing with TDD protocol"
    echo "  4. Use ./scripts/validate-before-create.sh before creating files"
    echo ""
    echo -e "${PURPLE}🚀 Ready for zero-error development!${NC}"
    echo ""
    echo -e "${CYAN}📚 Documentation:${NC}"
    echo "  - Protocol Guide: docs/ULTIMATE_PROJECT_MANAGEMENT_PROTOCOL.md"
    echo "  - GitHub Repo: https://github.com/dm601990/ultimate-project-management-protocol"
}

# Function to handle errors
handle_error() {
    echo -e "\n${RED}❌ Installation failed!${NC}"
    echo -e "${YELLOW}💡 Troubleshooting:${NC}"
    echo "  1. Check internet connection"
    echo "  2. Verify you have write permissions"
    echo "  3. Try manual installation: https://github.com/dm601990/ultimate-project-management-protocol"
    echo "  4. Report issues: https://github.com/dm601990/ultimate-project-management-protocol/issues"
    exit 1
}

# Main installation function
main() {
    # Set error handler
    trap handle_error ERR
    
    echo -e "\n${PURPLE}Starting Ultimate Project Management Protocol installation...${NC}"
    
    create_directories
    download_core_scripts
    download_documentation
    create_project_config
    create_project_context
    run_initial_discovery
    show_completion
}

# Help function
show_help() {
    echo "Usage: $0 [options]"
    echo ""
    echo "Universal installer for Ultimate Project Management Protocol."
    echo ""
    echo "Options:"
    echo "  -h, --help     Show this help message"
    echo "  --no-discovery Skip initial project discovery"
    echo "  --minimal      Install only core scripts (no docs)"
    echo ""
    echo "Examples:"
    echo "  $0                    # Full installation"
    echo "  $0 --minimal          # Minimal installation"
    echo "  $0 --no-discovery     # Skip initial discovery"
}

# Parse command line arguments
SKIP_DISCOVERY=false
MINIMAL_INSTALL=false

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        --no-discovery)
            SKIP_DISCOVERY=true
            shift
            ;;
        --minimal)
            MINIMAL_INSTALL=true
            shift
            ;;
        *)
            echo "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
done

# Run main installation
main
