# 🛡️ Systematic Duplicate Prevention Protocol

## 🎯 Purpose
A comprehensive, reusable protocol to prevent duplicate files and maintain clean project organization across ALL projects.

## 📋 MANDATORY PRE-TASK CHECKLIST

### **Phase 1: Project Discovery (ALWAYS FIRST)**

#### **1.1 Read Project Documentation**
```bash
# REQUIRED: Always check these files first
- README.md (project overview)
- docs/PROJECT_STRUCTURE_GUIDE.md (structure rules)
- docs/PROJECT_CONVENTIONS.md (naming conventions)
- project-config.yml (project configuration)
```

#### **1.2 Map Directory Structure**
```bash
# Use codebase-retrieval to understand project organization
codebase-retrieval: "Analyze complete project structure, file organization patterns, naming conventions, and architectural decisions"

# Then use view tool to examine directory structure
view: project_root_directory (type: directory)
```

#### **1.3 Identify Duplicate Patterns**
```bash
# Search for duplicate directories
find . -name "components" -type d
find . -name "docs" -type d
find . -name "lib" -type d
find . -name "utils" -type d

# Search for similar functionality
grep -r "function_name" --include="*.ts" --include="*.tsx" .
```

### **Phase 2: Pre-Creation Validation (BEFORE ANY FILE CREATION)**

#### **2.1 Search for Existing Files**
```bash
# Search by filename
find . -name "*filename*" -type f

# Search by functionality
codebase-retrieval: "Find all files that implement [specific functionality]"

# Search by pattern
grep -r "similar_pattern" --include="*.ts" --include="*.tsx" .
```

#### **2.2 Validate Placement Location**
```bash
# Check project conventions
1. Read docs/PROJECT_STRUCTURE_GUIDE.md
2. Verify against project-config.yml
3. Check existing similar files' locations
4. Confirm with tsconfig.json path mappings
```

#### **2.3 Check for Naming Conflicts**
```bash
# Search for similar names
find . -iname "*similar_name*"
grep -r "SimilarClassName" --include="*.ts" --include="*.tsx" .
```

## 🔍 SYSTEMATIC SEARCH COMMANDS

### **File Location Discovery**
```bash
# Find all instances of a file type
find . -name "*.tsx" | grep -i "component_name"

# Find by directory pattern
find . -type d -name "*pattern*"

# Find by content
grep -r "specific_content" --include="*.ts" --include="*.tsx" .
```

### **Functionality Duplication Check**
```bash
# Search for similar functions
grep -r "function.*similar_name" --include="*.ts" .

# Search for similar components
grep -r "export.*Component" --include="*.tsx" .

# Search for similar API endpoints
find . -path "*/api/*" -name "*.ts"
```

### **Configuration Conflicts**
```bash
# Check for duplicate configs
find . -name "*.config.*" -type f
find . -name "package.json" -type f
find . -name "tsconfig.json" -type f
```

## 📁 PROJECT STRUCTURE VALIDATION

### **Standard Structure Check**
```yaml
# Expected structure (customize per project)
project_root/
├── src/                    # Main source (CANONICAL)
│   ├── app/               # Next.js pages
│   ├── components/        # React components (CANONICAL)
│   ├── lib/              # Utilities
│   └── types/            # Type definitions
├── docs/                  # Documentation (CANONICAL)
├── __tests__/            # Tests
├── public/               # Static assets
└── [config files]       # Root configs
```

### **Forbidden Locations**
```bash
# NEVER create files in these locations:
❌ /components (if src/components exists)
❌ /docs (if root docs/ exists)
❌ /lib (if src/lib exists)
❌ Duplicate directory structures
❌ Random nested docs folders
```

## 🤖 AUTOMATION COMMANDS

### **Pre-Task Validation Script**
```bash
#!/bin/bash
# validate-before-create.sh

echo "🔍 Checking for duplicates..."

# 1. Check for duplicate directories
echo "📁 Duplicate directories:"
find . -name "components" -type d | head -10
find . -name "docs" -type d | head -10

# 2. Check for similar files
echo "📄 Similar files for: $1"
find . -iname "*$1*" -type f | head -10

# 3. Validate against project structure
echo "📋 Project structure validation:"
if [ -f "docs/PROJECT_STRUCTURE_GUIDE.md" ]; then
    echo "✅ Structure guide found"
else
    echo "❌ No structure guide - CREATE ONE FIRST"
fi
```

### **Smart File Placement**
```bash
# Use this logic for file placement:
1. Check project-config.yml for canonical locations
2. Follow existing patterns in the codebase
3. Respect tsconfig.json path mappings
4. Place in most specific appropriate directory
5. Avoid creating new top-level directories
```

## 🧠 MEMORY & CONTEXT MANAGEMENT

### **Information I Retain Between Conversations:**
- ✅ User preferences and patterns
- ✅ Project-specific conventions (if documented)
- ❌ Specific file locations (must re-discover each time)
- ❌ Current project state (must re-analyze)

### **What You Should Create:**
1. **Project Conventions Document** (this file)
2. **Project Structure Guide** (canonical locations)
3. **Project Configuration File** (project-config.yml)

### **Before Every Task:**
```bash
# I will ALWAYS run these commands:
1. codebase-retrieval: "Project structure and conventions"
2. view: project_root (type: directory)
3. Check for existing similar functionality
4. Validate placement against conventions
5. Search for potential duplicates
```

## ✅ BEST PRACTICES CHECKLIST

### **Before Creating ANY File:**
- [ ] Read project documentation
- [ ] Map current directory structure
- [ ] Search for existing similar files
- [ ] Validate placement location
- [ ] Check naming conventions
- [ ] Verify no functionality duplication
- [ ] Confirm against project conventions

### **File Creation Rules:**
- [ ] Use canonical directory structure
- [ ] Follow established naming patterns
- [ ] Place in most specific appropriate location
- [ ] Avoid creating duplicate functionality
- [ ] Update documentation if adding new patterns

### **Post-Creation Validation:**
- [ ] Verify file is in correct location
- [ ] Check imports work correctly
- [ ] Confirm no conflicts with existing files
- [ ] Update relevant documentation
- [ ] Clean up any temporary/duplicate files

## 🚨 RED FLAGS (STOP AND INVESTIGATE)

### **Immediate Stop Signals:**
- Multiple directories with same name
- Similar file names in different locations
- Duplicate functionality patterns
- Missing project documentation
- Unclear directory structure
- Conflicting naming conventions

### **Investigation Required:**
- Why do multiple directories exist?
- Which is the canonical location?
- Can duplicates be consolidated?
- What are the project conventions?
- Should new structure be created?

## 🔄 CONTINUOUS IMPROVEMENT

### **After Each Task:**
1. Document any new patterns discovered
2. Update project conventions if needed
3. Note any structural improvements needed
4. Identify potential consolidation opportunities

### **Regular Maintenance:**
1. Audit for duplicate files/directories
2. Consolidate redundant structures
3. Update documentation
4. Validate against best practices

## 🎯 ANSWERS TO YOUR SPECIFIC QUESTIONS

### **1. Project Analysis Protocol**
**MANDATORY STEPS at beginning of ANY task:**

```bash
# Step 1: Read project documentation
codebase-retrieval: "Analyze complete project structure, file organization patterns, naming conventions, and architectural decisions"

# Step 2: Map directory structure
view: project_root (type: directory)

# Step 3: Check for duplicates
./scripts/validate-before-create.sh

# Step 4: Understand conventions
- Read docs/PROJECT_STRUCTURE_GUIDE.md
- Read docs/PROJECT_CONVENTIONS.md
- Check project-config.yml
- Examine tsconfig.json path mappings
```

### **2. Duplicate Prevention Strategy**
**SYSTEMATIC SEARCH COMMANDS:**

```bash
# Before creating ANY file/directory:
find . -name "target_name" -type d          # Check directories
find . -iname "*target_name*" -type f       # Check files
grep -r "functionality" --include="*.ts" .  # Check functionality
codebase-retrieval: "Find existing [functionality]"  # AI search
```

### **3. Memory and Context Management**

**What I Remember Between Conversations:**
- ✅ User preferences (from memory system)
- ✅ Project-specific patterns (if documented)
- ❌ Current file locations (must re-discover)
- ❌ Recent changes (must re-analyze)

**Recommended Approach:**
1. **Create project-config.yml** (I read this first)
2. **Maintain docs/PROJECT_CONVENTIONS.md** (I check this)
3. **Use consistent documentation** (I follow patterns)

### **4. Best Practices Documentation**
**This document IS the reusable checklist!**

**Apply to ANY project:**
1. Copy this protocol to new project
2. Customize project-config.yml
3. Create PROJECT_STRUCTURE_GUIDE.md
4. Run validation script before any changes

### **5. Automation Approach**
**I will AUTOMATICALLY follow this process:**

```bash
# EVERY TASK - NO EXCEPTIONS:
1. codebase-retrieval: "Project structure analysis"
2. view: project_root (type: directory)
3. Search for existing similar functionality
4. Validate against project conventions
5. Check for potential duplicates
6. Only then proceed with implementation
```

## 🚀 IMPLEMENTATION GUARANTEE

**I COMMIT TO:**
1. **Always run project analysis first**
2. **Never create files without checking for duplicates**
3. **Follow established project patterns**
4. **Ask clarifying questions if structure is unclear**
5. **Document any new patterns discovered**

**YOU CAN EXPECT:**
- No duplicate files/directories
- Consistent project organization
- Proper file placement
- Clean, maintainable structure
- Self-documenting decisions

This protocol ensures reliable, repeatable duplicate prevention across ALL projects without requiring constant reminders.
