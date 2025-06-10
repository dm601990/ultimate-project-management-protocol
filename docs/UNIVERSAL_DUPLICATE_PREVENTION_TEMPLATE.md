# 🌍 Universal Duplicate Prevention Template

## 🎯 Purpose
A **copy-paste template** for applying systematic duplicate prevention to ANY project.

## 📋 SETUP CHECKLIST FOR NEW PROJECTS

### **Step 1: Copy Core Files**
```bash
# Copy these files to your new project:
├── docs/SYSTEMATIC_DUPLICATE_PREVENTION_PROTOCOL.md
├── scripts/validate-before-create.sh
├── project-config.yml (customize for your project)
└── docs/PROJECT_STRUCTURE_GUIDE.md (create project-specific)
```

### **Step 2: Customize project-config.yml**
```yaml
# Template - customize for your project
project:
  name: "Your Project Name"
  type: "web-app"        # web-app, mobile-app, api, library, etc.
  language: "typescript" # typescript, javascript, python, etc.
  framework: "nextjs"    # nextjs, react, vue, express, etc.
  description: "Brief project description"

# Define YOUR canonical structure
source_structure:
  main_dir: "src"                    # or "lib", "app", etc.
  components_dir: "src/components"   # where components go
  pages_dir: "src/pages"            # or "src/routes", "src/views"
  api_dir: "src/api"                # API endpoints
  utils_dir: "src/lib"              # utilities
  tests_dir: "__tests__"            # or "test", "spec"
  docs_dir: "docs"                  # documentation
  assets_dir: "public"              # static assets

# Define forbidden duplicate locations
duplicate_prevention:
  forbidden_locations:
    - "components"          # if src/components exists
    - "lib"                # if src/lib exists
    - "utils"              # if src/utils exists
  
  canonical_mappings:
    components: "src/components"
    utilities: "src/lib"
    documentation: "docs"
    tests: "__tests__"
```

### **Step 3: Create PROJECT_STRUCTURE_GUIDE.md**
```markdown
# Project Structure Guide

## 📁 Canonical Directory Structure
```
your-project/
├── src/                    # Main source code (CANONICAL)
│   ├── components/         # React components (CANONICAL)
│   ├── lib/               # Utilities (CANONICAL)
│   └── [other dirs]       # Project-specific
├── docs/                  # Documentation (CANONICAL)
├── __tests__/             # Tests (CANONICAL)
└── [config files]        # Root configs
```

## 🚫 Forbidden Locations
- `/components` (use src/components)
- `/lib` (use src/lib)
- `/docs` inside subdirectories

## ✅ File Placement Rules
1. Components → src/components/
2. Utilities → src/lib/
3. Documentation → docs/
4. Tests → __tests__/
```

### **Step 4: Make Scripts Executable**
```bash
chmod +x scripts/validate-before-create.sh
```

## 🤖 AI ASSISTANT INTEGRATION

### **Prompt Template for AI Assistants**
```
MANDATORY PROJECT SETUP PROTOCOL:

Before ANY task, you MUST:

1. **Read Project Configuration:**
   - Check project-config.yml for canonical structure
   - Read docs/PROJECT_STRUCTURE_GUIDE.md
   - Review docs/SYSTEMATIC_DUPLICATE_PREVENTION_PROTOCOL.md

2. **Analyze Current Structure:**
   - Use codebase-retrieval: "Analyze project structure and conventions"
   - Use view: project_root (type: directory)
   - Run: ./scripts/validate-before-create.sh [search_term]

3. **Before Creating ANY File:**
   - Search for existing similar functionality
   - Validate placement against canonical structure
   - Check for naming conflicts
   - Confirm no duplicate directories exist

4. **Follow These Rules:**
   - NEVER create duplicate directory structures
   - ALWAYS use canonical locations from project-config.yml
   - ALWAYS search before creating
   - ALWAYS follow established patterns

FAILURE TO FOLLOW THIS PROTOCOL WILL RESULT IN DUPLICATE FILES AND POOR PROJECT ORGANIZATION.
```

## 🔧 FRAMEWORK-SPECIFIC TEMPLATES

### **Next.js Projects**
```yaml
source_structure:
  main_dir: "src"
  components_dir: "src/components"
  pages_dir: "src/app"              # App Router
  api_dir: "src/app/api"
  utils_dir: "src/lib"
  tests_dir: "__tests__"
  styles_dir: "src/styles"
  assets_dir: "public"
```

### **React Projects**
```yaml
source_structure:
  main_dir: "src"
  components_dir: "src/components"
  pages_dir: "src/pages"
  utils_dir: "src/utils"
  tests_dir: "src/__tests__"
  assets_dir: "public"
```

### **Node.js API Projects**
```yaml
source_structure:
  main_dir: "src"
  routes_dir: "src/routes"
  controllers_dir: "src/controllers"
  models_dir: "src/models"
  utils_dir: "src/lib"
  tests_dir: "__tests__"
  config_dir: "src/config"
```

### **Python Projects**
```yaml
source_structure:
  main_dir: "src"
  modules_dir: "src/modules"
  utils_dir: "src/utils"
  tests_dir: "tests"
  config_dir: "config"
```

## 🚀 QUICK START SCRIPT

### **setup-duplicate-prevention.sh**
```bash
#!/bin/bash
# Quick setup for new projects

echo "🛡️ Setting up duplicate prevention..."

# Create directory structure
mkdir -p docs scripts

# Copy template files (customize paths as needed)
cp path/to/template/docs/SYSTEMATIC_DUPLICATE_PREVENTION_PROTOCOL.md docs/
cp path/to/template/scripts/validate-before-create.sh scripts/

# Create project-specific files
cat > project-config.yml << EOF
project:
  name: "$(basename $(pwd))"
  type: "web-app"
  language: "typescript"
  framework: "generic"

source_structure:
  main_dir: "src"
  components_dir: "src/components"
  utils_dir: "src/lib"
  tests_dir: "__tests__"
  docs_dir: "docs"
EOF

# Make scripts executable
chmod +x scripts/validate-before-create.sh

echo "✅ Duplicate prevention setup complete!"
echo "📝 Next steps:"
echo "   1. Customize project-config.yml"
echo "   2. Create docs/PROJECT_STRUCTURE_GUIDE.md"
echo "   3. Run ./scripts/validate-before-create.sh to test"
```

## 📊 SUCCESS METRICS

### **How to Measure Success:**
- ✅ Zero duplicate directories
- ✅ Consistent file placement
- ✅ Clear project structure
- ✅ Easy navigation
- ✅ No confusion about file locations

### **Red Flags to Watch For:**
- ❌ Multiple directories with same name
- ❌ Files in unexpected locations
- ❌ Inconsistent naming patterns
- ❌ Duplicate functionality
- ❌ Missing documentation

## 🎯 IMPLEMENTATION GUARANTEE

**This template provides:**
1. **Systematic approach** to prevent duplicates
2. **Reusable across any project type**
3. **AI assistant integration**
4. **Automated validation tools**
5. **Clear documentation patterns**

**Result: Clean, organized, maintainable projects with zero duplicate files.**
