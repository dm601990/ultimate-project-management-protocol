#!/bin/bash
# 🎯 Ultimate Project Discovery Script
# Enhanced discovery combining systematic analysis with zero-error methodology

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${BLUE}🎯 ULTIMATE PROJECT DISCOVERY & ANALYSIS${NC}"
echo "=============================================="

# Function to analyze file types
analyze_file_types() {
    echo -e "\n${YELLOW}📁 Project Structure Analysis${NC}"
    
    echo -e "\n${CYAN}TypeScript/JavaScript Files:${NC}"
    find . -type f \( -name "*.ts" -o -name "*.tsx" -o -name "*.js" -o -name "*.jsx" \) | grep -v node_modules | head -20
    
    echo -e "\n${CYAN}Python Files:${NC}"
    find . -type f -name "*.py" | grep -v node_modules | head -10
    
    echo -e "\n${CYAN}Configuration Files:${NC}"
    find . -type f -name "*.json" | grep -E "(config|settings|package)" | grep -v node_modules
    
    echo -e "\n${CYAN}Documentation Files:${NC}"
    find . -name "README*" -o -name "*.md" | head -15
}

# Function to detect configurations
detect_configurations() {
    echo -e "\n${YELLOW}⚙️ Configuration Detection${NC}"
    
    echo -e "\n${CYAN}Root Configuration Files:${NC}"
    ls -la | grep -E "(config|env|settings|\.json|\.yml|\.yaml|\.toml)"
    
    echo -e "\n${CYAN}Package Managers:${NC}"
    [ -f "package.json" ] && echo "✅ Node.js (package.json found)" || echo "❌ No package.json"
    [ -f "requirements.txt" ] && echo "✅ Python pip (requirements.txt found)" || echo "❌ No requirements.txt"
    [ -f "pyproject.toml" ] && echo "✅ Python poetry (pyproject.toml found)" || echo "❌ No pyproject.toml"
    [ -f "Cargo.toml" ] && echo "✅ Rust (Cargo.toml found)" || echo "❌ No Cargo.toml"
    [ -f "go.mod" ] && echo "✅ Go (go.mod found)" || echo "❌ No go.mod"
}

# Function to analyze patterns
analyze_patterns() {
    echo -e "\n${YELLOW}🎨 Pattern Analysis${NC}"
    
    echo -e "\n${CYAN}Testing Patterns:${NC}"
    find . -name "test*" -o -name "*test*" -o -name "spec*" -o -name "*spec*" | grep -v node_modules | head -15
    
    echo -e "\n${CYAN}Source Structure:${NC}"
    [ -d "src/" ] && echo "✅ src/ directory found" && ls -la src/ | head -10
    [ -d "lib/" ] && echo "✅ lib/ directory found" && ls -la lib/ | head -5
    [ -d "app/" ] && echo "✅ app/ directory found" && ls -la app/ | head -5
    
    echo -e "\n${CYAN}Component Patterns:${NC}"
    find . -name "*component*" -o -name "*Component*" | grep -v node_modules | head -10
}

# Function to detect framework
detect_framework() {
    echo -e "\n${YELLOW}🔧 Framework Detection${NC}"
    
    if [ -f "package.json" ]; then
        echo -e "\n${CYAN}Dependencies Analysis:${NC}"
        grep -E "(next|react|vue|angular|express|fastify)" package.json || echo "No major framework detected"
        
        echo -e "\n${CYAN}Dev Dependencies:${NC}"
        grep -E "(jest|vitest|cypress|playwright|testing-library)" package.json || echo "No testing framework detected"
    fi
    
    if [ -f "requirements.txt" ]; then
        echo -e "\n${CYAN}Python Dependencies:${NC}"
        grep -E "(django|flask|fastapi|pytest|unittest)" requirements.txt || echo "No major Python framework detected"
    fi
}

# Function to check for duplicates
check_duplicates() {
    echo -e "\n${YELLOW}🛡️ Duplicate Structure Detection${NC}"
    
    echo -e "\n${CYAN}Component Directories:${NC}"
    find . -name "components" -type d | grep -v node_modules
    
    echo -e "\n${CYAN}Documentation Directories:${NC}"
    find . -name "docs" -type d | grep -v node_modules
    
    echo -e "\n${CYAN}Library/Utility Directories:${NC}"
    find . -name "lib" -type d | grep -v node_modules
    find . -name "utils" -type d | grep -v node_modules
    
    echo -e "\n${CYAN}Test Directories:${NC}"
    find . -name "test" -o -name "tests" -o -name "__tests__" | grep -v node_modules
}

# Function to analyze naming conventions
analyze_naming_conventions() {
    echo -e "\n${YELLOW}📝 Naming Convention Analysis${NC}"
    
    echo -e "\n${CYAN}File Naming Patterns:${NC}"
    echo "TypeScript/JavaScript files:"
    find . -name "*.ts" -o -name "*.tsx" -o -name "*.js" -o -name "*.jsx" | grep -v node_modules | head -10 | xargs basename -a
    
    echo -e "\n${CYAN}Component Naming Patterns:${NC}"
    find . -name "*Component*" -o -name "*component*" | grep -v node_modules | head -5 | xargs basename -a
    
    echo -e "\n${CYAN}Test File Patterns:${NC}"
    find . -name "*.test.*" -o -name "*.spec.*" | grep -v node_modules | head -5 | xargs basename -a
}

# Function to search for specific functionality
search_functionality() {
    local search_term=$1
    
    if [ -n "$search_term" ]; then
        echo -e "\n${YELLOW}🔎 Functionality Search: ${search_term}${NC}"
        
        echo -e "\n${CYAN}In Code Files:${NC}"
        grep -r "$search_term" --include="*.ts" --include="*.tsx" --include="*.js" --include="*.jsx" --include="*.py" . | grep -v node_modules | head -5
        
        echo -e "\n${CYAN}In File Names:${NC}"
        find . -iname "*$search_term*" -type f | grep -v node_modules | head -5
        
        echo -e "\n${CYAN}In Directory Names:${NC}"
        find . -iname "*$search_term*" -type d | grep -v node_modules | head -5
    fi
}

# Function to generate project intelligence
generate_project_intelligence() {
    echo -e "\n${YELLOW}🧠 Generating Project Intelligence${NC}"
    
    # Detect project type
    local project_type="unknown"
    [ -f "package.json" ] && project_type="node"
    [ -f "requirements.txt" ] && project_type="python"
    [ -f "Cargo.toml" ] && project_type="rust"
    [ -f "go.mod" ] && project_type="go"
    
    # Detect framework
    local framework="unknown"
    if [ -f "package.json" ]; then
        grep -q "next" package.json && framework="nextjs"
        grep -q "react" package.json && framework="react"
        grep -q "vue" package.json && framework="vue"
        grep -q "angular" package.json && framework="angular"
    fi
    
    echo -e "${GREEN}Project Type: ${project_type}${NC}"
    echo -e "${GREEN}Framework: ${framework}${NC}"
    echo -e "${GREEN}Has Tests: $([ -d "__tests__" ] || [ -d "test" ] || [ -d "tests" ] && echo "Yes" || echo "No")${NC}"
    echo -e "${GREEN}Has Documentation: $([ -d "docs" ] && echo "Yes" || echo "No")${NC}"
}

# Main execution
main() {
    analyze_file_types
    detect_configurations
    analyze_patterns
    detect_framework
    check_duplicates
    analyze_naming_conventions
    generate_project_intelligence
    
    # If search term provided, search for functionality
    if [ $# -gt 0 ]; then
        search_functionality "$1"
    fi
    
    echo -e "\n${GREEN}✅ Ultimate project discovery complete${NC}"
    echo -e "${PURPLE}💡 Next Steps:${NC}"
    echo "   1. Review findings above"
    echo "   2. Create/update .project_context.md"
    echo "   3. Follow TDD protocol for any new features"
    echo "   4. Use duplicate prevention before creating files"
    echo ""
}

# Help function
show_help() {
    echo "Usage: $0 [search_term]"
    echo ""
    echo "Ultimate project discovery and analysis tool."
    echo ""
    echo "Arguments:"
    echo "  search_term    Optional: Search for existing functionality"
    echo ""
    echo "Examples:"
    echo "  $0                    # Full project analysis"
    echo "  $0 authentication    # Search for auth-related code"
    echo "  $0 LoginForm         # Search for LoginForm functionality"
}

# Check for help flag
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    show_help
    exit 0
fi

# Run main function
main "$@"
