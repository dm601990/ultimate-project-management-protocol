#!/usr/bin/env tsx
/**
 * 🧠 Project Intelligence System
 * Automated project analysis and duplicate prevention
 */

import { readFileSync, writeFileSync, existsSync } from 'fs';
import { execSync } from 'child_process';
import { join } from 'path';

interface ProjectMap {
  structure: DirectoryStructure;
  patterns: NamingPatterns;
  conventions: ProjectConventions;
  existingFeatures: string[];
  testFramework: TestingFramework;
  conflicts: ConflictReport[];
}

interface DirectoryStructure {
  canonicalLocations: Record<string, string>;
  forbiddenLocations: string[];
  duplicateStructures: string[];
}

interface NamingPatterns {
  components: string;
  utilities: string;
  tests: string;
  apiRoutes: string;
}

interface ProjectConventions {
  framework: string;
  language: string;
  testingFramework: string;
  stylingFramework: string;
}

interface TestingFramework {
  name: string;
  testPattern: string;
  testLocation: string;
}

interface ConflictReport {
  type: 'duplicate_directory' | 'naming_conflict' | 'functionality_overlap';
  location: string;
  recommendation: string;
}

interface DuplicationCheck {
  isDuplicate: boolean;
  alternatives: string[];
  recommendation: string;
}

interface ValidationResult {
  isValid: boolean;
  issues: string[];
  suggestions: string[];
}

class ProjectIntelligence {
  private projectMap: ProjectMap;
  private projectRoot: string;

  constructor(projectRoot: string = process.cwd()) {
    this.projectRoot = projectRoot;
    this.projectMap = this.analyzeProject();
  }

  /**
   * Comprehensive project analysis
   */
  analyzeProject(): ProjectMap {
    console.log('🧠 Analyzing project structure...');
    
    return {
      structure: this.mapStructure(),
      patterns: this.detectPatterns(),
      conventions: this.extractConventions(),
      existingFeatures: this.catalogFeatures(),
      testFramework: this.detectTestFramework(),
      conflicts: this.detectPotentialConflicts()
    };
  }

  /**
   * Map directory structure and identify canonical locations
   */
  private mapStructure(): DirectoryStructure {
    const canonicalLocations: Record<string, string> = {};
    const forbiddenLocations: string[] = [];
    const duplicateStructures: string[] = [];

    try {
      // Find component directories
      const componentDirs = this.findDirectories('components');
      if (componentDirs.length > 1) {
        duplicateStructures.push(...componentDirs);
        canonicalLocations.components = this.selectCanonicalLocation(componentDirs, 'src/components');
        forbiddenLocations.push(...componentDirs.filter(dir => dir !== canonicalLocations.components));
      }

      // Find docs directories
      const docsDirs = this.findDirectories('docs');
      if (docsDirs.length > 1) {
        duplicateStructures.push(...docsDirs);
        canonicalLocations.docs = this.selectCanonicalLocation(docsDirs, 'docs');
        forbiddenLocations.push(...docsDirs.filter(dir => dir !== canonicalLocations.docs));
      }

      // Find lib/utils directories
      const libDirs = this.findDirectories('lib');
      if (libDirs.length > 1) {
        duplicateStructures.push(...libDirs);
        canonicalLocations.lib = this.selectCanonicalLocation(libDirs, 'src/lib');
        forbiddenLocations.push(...libDirs.filter(dir => dir !== canonicalLocations.lib));
      }

    } catch (error) {
      console.error('Error mapping structure:', error);
    }

    return {
      canonicalLocations,
      forbiddenLocations,
      duplicateStructures
    };
  }

  /**
   * Detect naming patterns from existing files
   */
  private detectPatterns(): NamingPatterns {
    const patterns: NamingPatterns = {
      components: 'PascalCase',
      utilities: 'camelCase',
      tests: '.test.tsx',
      apiRoutes: 'kebab-case'
    };

    try {
      // Analyze component naming
      const componentFiles = this.findFiles('*.tsx', 'components');
      if (componentFiles.length > 0) {
        patterns.components = this.detectNamingPattern(componentFiles);
      }

      // Analyze test naming
      const testFiles = this.findFiles('*.test.*');
      if (testFiles.length > 0) {
        patterns.tests = this.detectTestPattern(testFiles);
      }

    } catch (error) {
      console.error('Error detecting patterns:', error);
    }

    return patterns;
  }

  /**
   * Extract project conventions from configuration files
   */
  private extractConventions(): ProjectConventions {
    const conventions: ProjectConventions = {
      framework: 'unknown',
      language: 'unknown',
      testingFramework: 'unknown',
      stylingFramework: 'unknown'
    };

    try {
      // Check package.json for framework detection
      if (existsSync(join(this.projectRoot, 'package.json'))) {
        const packageJson = JSON.parse(readFileSync(join(this.projectRoot, 'package.json'), 'utf8'));
        
        if (packageJson.dependencies?.next) conventions.framework = 'nextjs';
        else if (packageJson.dependencies?.react) conventions.framework = 'react';
        else if (packageJson.dependencies?.vue) conventions.framework = 'vue';

        if (packageJson.devDependencies?.jest) conventions.testingFramework = 'jest';
        if (packageJson.dependencies?.['tailwindcss']) conventions.stylingFramework = 'tailwind';
      }

      // Check for TypeScript
      if (existsSync(join(this.projectRoot, 'tsconfig.json'))) {
        conventions.language = 'typescript';
      }

    } catch (error) {
      console.error('Error extracting conventions:', error);
    }

    return conventions;
  }

  /**
   * Catalog existing features to prevent duplication
   */
  private catalogFeatures(): string[] {
    const features: string[] = [];

    try {
      // Find component files
      const componentFiles = this.findFiles('*.tsx', 'components');
      features.push(...componentFiles.map(file => this.extractFeatureName(file)));

      // Find utility files
      const utilFiles = this.findFiles('*.ts', 'lib');
      features.push(...utilFiles.map(file => this.extractFeatureName(file)));

      // Find API routes
      const apiFiles = this.findFiles('*.ts', 'api');
      features.push(...apiFiles.map(file => this.extractFeatureName(file)));

    } catch (error) {
      console.error('Error cataloging features:', error);
    }

    return features.filter(Boolean);
  }

  /**
   * Detect testing framework and patterns
   */
  private detectTestFramework(): TestingFramework {
    const framework: TestingFramework = {
      name: 'unknown',
      testPattern: '*.test.*',
      testLocation: '__tests__'
    };

    try {
      if (existsSync(join(this.projectRoot, 'jest.config.js'))) {
        framework.name = 'jest';
      }

      const testDirs = this.findDirectories('test');
      if (testDirs.length > 0) {
        framework.testLocation = testDirs[0];
      }

    } catch (error) {
      console.error('Error detecting test framework:', error);
    }

    return framework;
  }

  /**
   * Detect potential conflicts and issues
   */
  private detectPotentialConflicts(): ConflictReport[] {
    const conflicts: ConflictReport[] = [];

    // Check for duplicate directories
    this.projectMap?.structure?.duplicateStructures?.forEach(duplicate => {
      conflicts.push({
        type: 'duplicate_directory',
        location: duplicate,
        recommendation: `Consolidate with canonical location`
      });
    });

    return conflicts;
  }

  /**
   * Prevent duplication by checking for existing implementations
   */
  preventDuplication(proposedFeature: string): DuplicationCheck {
    const existing = this.findSimilarFeatures(proposedFeature);
    
    return {
      isDuplicate: existing.length > 0,
      alternatives: existing,
      recommendation: existing.length > 0 
        ? `Consider extending existing: ${existing[0]}`
        : 'Safe to create new feature'
    };
  }

  /**
   * Suggest optimal location for new files
   */
  suggestLocation(fileType: string, featureName: string): string {
    const canonical = this.projectMap.structure.canonicalLocations;
    
    switch (fileType) {
      case 'component':
        return canonical.components || 'src/components';
      case 'utility':
        return canonical.lib || 'src/lib';
      case 'test':
        return this.projectMap.testFramework.testLocation || '__tests__';
      case 'documentation':
        return canonical.docs || 'docs';
      default:
        return 'src';
    }
  }

  /**
   * Validate naming against project conventions
   */
  validateNaming(proposedName: string, fileType: string): ValidationResult {
    const issues: string[] = [];
    const suggestions: string[] = [];

    // Check naming pattern
    const pattern = this.projectMap.patterns[fileType as keyof NamingPatterns];
    if (pattern && !this.matchesPattern(proposedName, pattern)) {
      issues.push(`Name doesn't match ${pattern} pattern`);
      suggestions.push(`Consider: ${this.suggestCorrectNaming(proposedName, pattern)}`);
    }

    // Check for conflicts
    const existing = this.findSimilarFeatures(proposedName);
    if (existing.length > 0) {
      issues.push('Similar feature already exists');
      suggestions.push(`Existing: ${existing.join(', ')}`);
    }

    return {
      isValid: issues.length === 0,
      issues,
      suggestions
    };
  }

  // Helper methods
  private findDirectories(name: string): string[] {
    try {
      const result = execSync(`find . -name "${name}" -type d | grep -v node_modules`, { encoding: 'utf8' });
      return result.trim().split('\n').filter(Boolean);
    } catch {
      return [];
    }
  }

  private findFiles(pattern: string, directory?: string): string[] {
    try {
      const searchPath = directory ? `-path "*/${directory}/*"` : '';
      const result = execSync(`find . ${searchPath} -name "${pattern}" | grep -v node_modules`, { encoding: 'utf8' });
      return result.trim().split('\n').filter(Boolean);
    } catch {
      return [];
    }
  }

  private selectCanonicalLocation(locations: string[], preferred: string): string {
    return locations.find(loc => loc.includes(preferred)) || locations[0];
  }

  private detectNamingPattern(files: string[]): string {
    // Simple heuristic - check if files use PascalCase
    const pascalCaseCount = files.filter(file => /[A-Z][a-z]/.test(file)).length;
    return pascalCaseCount > files.length / 2 ? 'PascalCase' : 'camelCase';
  }

  private detectTestPattern(files: string[]): string {
    if (files.some(f => f.includes('.test.'))) return '.test.*';
    if (files.some(f => f.includes('.spec.'))) return '.spec.*';
    return '.test.*';
  }

  private extractFeatureName(filePath: string): string {
    const fileName = filePath.split('/').pop() || '';
    return fileName.replace(/\.(ts|tsx|js|jsx)$/, '');
  }

  private findSimilarFeatures(feature: string): string[] {
    return this.projectMap.existingFeatures.filter(existing => 
      existing.toLowerCase().includes(feature.toLowerCase()) ||
      feature.toLowerCase().includes(existing.toLowerCase())
    );
  }

  private matchesPattern(name: string, pattern: string): boolean {
    switch (pattern) {
      case 'PascalCase':
        return /^[A-Z][a-zA-Z0-9]*$/.test(name);
      case 'camelCase':
        return /^[a-z][a-zA-Z0-9]*$/.test(name);
      case 'kebab-case':
        return /^[a-z][a-z0-9-]*$/.test(name);
      default:
        return true;
    }
  }

  private suggestCorrectNaming(name: string, pattern: string): string {
    switch (pattern) {
      case 'PascalCase':
        return name.charAt(0).toUpperCase() + name.slice(1);
      case 'camelCase':
        return name.charAt(0).toLowerCase() + name.slice(1);
      case 'kebab-case':
        return name.toLowerCase().replace(/[A-Z]/g, '-$&').replace(/^-/, '');
      default:
        return name;
    }
  }

  /**
   * Generate comprehensive project report
   */
  generateReport(): void {
    console.log('\n🎯 PROJECT INTELLIGENCE REPORT');
    console.log('================================');
    
    console.log('\n📊 Project Overview:');
    console.log(`Framework: ${this.projectMap.conventions.framework}`);
    console.log(`Language: ${this.projectMap.conventions.language}`);
    console.log(`Testing: ${this.projectMap.testFramework.name}`);
    
    console.log('\n🛡️ Duplicate Prevention:');
    console.log(`Canonical Locations: ${Object.keys(this.projectMap.structure.canonicalLocations).length}`);
    console.log(`Forbidden Locations: ${this.projectMap.structure.forbiddenLocations.length}`);
    console.log(`Conflicts Found: ${this.projectMap.conflicts.length}`);
    
    console.log('\n📁 Existing Features:');
    this.projectMap.existingFeatures.slice(0, 10).forEach(feature => {
      console.log(`  - ${feature}`);
    });
    
    if (this.projectMap.conflicts.length > 0) {
      console.log('\n⚠️ Issues to Address:');
      this.projectMap.conflicts.forEach(conflict => {
        console.log(`  - ${conflict.type}: ${conflict.location}`);
        console.log(`    Recommendation: ${conflict.recommendation}`);
      });
    }
  }
}

// CLI interface
if (require.main === module) {
  const intelligence = new ProjectIntelligence();
  intelligence.generateReport();
}

export default ProjectIntelligence;
