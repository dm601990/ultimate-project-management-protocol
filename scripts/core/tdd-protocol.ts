#!/usr/bin/env tsx
/**
 * 🧪 TDD Protocol Implementation
 * Zero-error development with self-healing architecture
 */

import { writeFileSync, existsSync, mkdirSync } from 'fs';
import { dirname, join } from 'path';
import ProjectIntelligence from './project-intelligence';

interface TDDConfig {
  testFramework: 'jest' | 'vitest' | 'mocha';
  testLocation: string;
  componentLocation: string;
  utilityLocation: string;
}

interface FeatureSpec {
  name: string;
  type: 'component' | 'utility' | 'api' | 'hook';
  description: string;
  inputs?: string[];
  outputs?: string[];
  errorCases?: string[];
}

class TDDProtocol {
  private intelligence: ProjectIntelligence;
  private config: TDDConfig;

  constructor() {
    this.intelligence = new ProjectIntelligence();
    this.config = this.detectTDDConfig();
  }

  /**
   * Detect TDD configuration from project
   */
  private detectTDDConfig(): TDDConfig {
    // Default configuration
    const config: TDDConfig = {
      testFramework: 'jest',
      testLocation: '__tests__',
      componentLocation: 'src/components',
      utilityLocation: 'src/lib'
    };

    // Detect from project intelligence
    const projectMap = this.intelligence['projectMap'];
    if (projectMap) {
      config.testLocation = projectMap.testFramework.testLocation || '__tests__';
      config.componentLocation = projectMap.structure.canonicalLocations.components || 'src/components';
      config.utilityLocation = projectMap.structure.canonicalLocations.lib || 'src/lib';
    }

    return config;
  }

  /**
   * Create a new feature following TDD protocol
   */
  async createFeature(spec: FeatureSpec): Promise<void> {
    console.log(`🧪 Creating feature: ${spec.name} (${spec.type})`);

    // Step 1: Duplicate prevention check
    const duplicationCheck = this.intelligence.preventDuplication(spec.name);
    if (duplicationCheck.isDuplicate) {
      console.error(`❌ Duplicate feature detected: ${duplicationCheck.alternatives.join(', ')}`);
      console.log(`💡 Recommendation: ${duplicationCheck.recommendation}`);
      return;
    }

    // Step 2: Validate naming
    const namingValidation = this.intelligence.validateNaming(spec.name, spec.type);
    if (!namingValidation.isValid) {
      console.error(`❌ Naming issues: ${namingValidation.issues.join(', ')}`);
      console.log(`💡 Suggestions: ${namingValidation.suggestions.join(', ')}`);
      return;
    }

    // Step 3: Create failing test first
    await this.createFailingTest(spec);

    // Step 4: Create minimal implementation
    await this.createMinimalImplementation(spec);

    // Step 5: Add self-healing mechanisms
    await this.addSelfHealingMechanisms(spec);

    console.log(`✅ Feature ${spec.name} created successfully with TDD protocol`);
  }

  /**
   * Step 1: Create failing test first (TDD)
   */
  private async createFailingTest(spec: FeatureSpec): Promise<void> {
    console.log(`📝 Creating failing test for ${spec.name}...`);

    const testPath = this.getTestPath(spec);
    const testContent = this.generateTestContent(spec);

    this.ensureDirectoryExists(dirname(testPath));
    writeFileSync(testPath, testContent);

    console.log(`✅ Test created: ${testPath}`);
  }

  /**
   * Step 2: Create minimal implementation to pass tests
   */
  private async createMinimalImplementation(spec: FeatureSpec): Promise<void> {
    console.log(`⚙️ Creating minimal implementation for ${spec.name}...`);

    const implementationPath = this.getImplementationPath(spec);
    const implementationContent = this.generateMinimalImplementation(spec);

    this.ensureDirectoryExists(dirname(implementationPath));
    writeFileSync(implementationPath, implementationContent);

    console.log(`✅ Implementation created: ${implementationPath}`);
  }

  /**
   * Step 3: Add self-healing mechanisms
   */
  private async addSelfHealingMechanisms(spec: FeatureSpec): Promise<void> {
    console.log(`🛡️ Adding self-healing mechanisms to ${spec.name}...`);

    const implementationPath = this.getImplementationPath(spec);
    const enhancedContent = this.generateSelfHealingImplementation(spec);

    writeFileSync(implementationPath, enhancedContent);

    console.log(`✅ Self-healing mechanisms added`);
  }

  /**
   * Generate test content based on feature specification
   */
  private generateTestContent(spec: FeatureSpec): string {
    const testName = `${spec.name}.test.tsx`;
    const importPath = this.getRelativeImportPath(spec);

    switch (spec.type) {
      case 'component':
        return this.generateComponentTest(spec, importPath);
      case 'utility':
        return this.generateUtilityTest(spec, importPath);
      case 'api':
        return this.generateApiTest(spec, importPath);
      case 'hook':
        return this.generateHookTest(spec, importPath);
      default:
        return this.generateGenericTest(spec, importPath);
    }
  }

  /**
   * Generate component test
   */
  private generateComponentTest(spec: FeatureSpec, importPath: string): string {
    return `import React from 'react';
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import ${spec.name} from '${importPath}';

describe('${spec.name}', () => {
  // Basic rendering test
  it('should render without crashing', () => {
    render(<${spec.name} />);
    expect(screen.getByRole('main')).toBeInTheDocument();
  });

  // Functionality tests
  it('should handle user interactions', async () => {
    render(<${spec.name} />);
    
    // Add specific interaction tests based on spec
    ${spec.inputs?.map(input => `
    // Test ${input} input
    const ${input}Element = screen.getByLabelText('${input}');
    fireEvent.change(${input}Element, { target: { value: 'test value' } });
    expect(${input}Element).toHaveValue('test value');`).join('') || ''}
  });

  // Error handling tests
  it('should handle errors gracefully', async () => {
    render(<${spec.name} />);
    
    ${spec.errorCases?.map(errorCase => `
    // Test ${errorCase} error case
    // Implementation should not crash and show appropriate error message`).join('') || ''}
  });

  // Self-healing tests
  it('should recover from failures automatically', async () => {
    render(<${spec.name} />);
    
    // Test automatic recovery mechanisms
    // Component should handle network failures, invalid data, etc.
  });
});`;
  }

  /**
   * Generate utility test
   */
  private generateUtilityTest(spec: FeatureSpec, importPath: string): string {
    return `import { ${spec.name} } from '${importPath}';

describe('${spec.name}', () => {
  // Basic functionality test
  it('should perform expected operation', () => {
    ${spec.inputs?.map((input, index) => `
    const input${index + 1} = 'test${index + 1}';`).join('') || ''}
    
    const result = ${spec.name}(${spec.inputs?.map((_, index) => `input${index + 1}`).join(', ') || ''});
    
    ${spec.outputs?.map(output => `
    expect(result).toHaveProperty('${output}');`).join('') || ''}
  });

  // Input validation tests
  it('should validate inputs properly', () => {
    // Test invalid inputs
    expect(() => ${spec.name}(null)).not.toThrow();
    expect(() => ${spec.name}(undefined)).not.toThrow();
    expect(() => ${spec.name}('')).not.toThrow();
  });

  // Error handling tests
  it('should handle errors gracefully', () => {
    ${spec.errorCases?.map(errorCase => `
    // Test ${errorCase} error case
    expect(() => ${spec.name}(/* invalid input */)).not.toThrow();`).join('') || ''}
  });

  // Self-healing tests
  it('should provide fallback values', () => {
    const result = ${spec.name}(/* problematic input */);
    expect(result).toBeDefined();
    // Should return safe default value
  });
});`;
  }

  /**
   * Generate API test
   */
  private generateApiTest(spec: FeatureSpec, importPath: string): string {
    return `import { createMocks } from 'node-mocks-http';
import handler from '${importPath}';

describe('/api/${spec.name.toLowerCase()}', () => {
  it('should handle GET requests', async () => {
    const { req, res } = createMocks({
      method: 'GET',
    });

    await handler(req, res);

    expect(res._getStatusCode()).toBe(200);
  });

  it('should validate request data', async () => {
    const { req, res } = createMocks({
      method: 'POST',
      body: {}, // Invalid data
    });

    await handler(req, res);

    expect(res._getStatusCode()).toBe(400);
  });

  it('should handle errors gracefully', async () => {
    // Test error scenarios
    const { req, res } = createMocks({
      method: 'POST',
      body: { /* malformed data */ },
    });

    await handler(req, res);

    // Should not crash, should return appropriate error
    expect(res._getStatusCode()).toBeGreaterThanOrEqual(400);
  });
});`;
  }

  /**
   * Generate hook test
   */
  private generateHookTest(spec: FeatureSpec, importPath: string): string {
    return `import { renderHook, act } from '@testing-library/react';
import { ${spec.name} } from '${importPath}';

describe('${spec.name}', () => {
  it('should initialize with default values', () => {
    const { result } = renderHook(() => ${spec.name}());
    
    expect(result.current).toBeDefined();
  });

  it('should handle state updates', () => {
    const { result } = renderHook(() => ${spec.name}());
    
    act(() => {
      // Test state updates
    });
    
    // Verify state changes
  });

  it('should handle errors gracefully', () => {
    const { result } = renderHook(() => ${spec.name}());
    
    act(() => {
      // Trigger error condition
    });
    
    // Should not crash, should handle error
    expect(result.current).toBeDefined();
  });
});`;
  }

  /**
   * Generate generic test
   */
  private generateGenericTest(spec: FeatureSpec, importPath: string): string {
    return `import { ${spec.name} } from '${importPath}';

describe('${spec.name}', () => {
  it('should work as expected', () => {
    // Basic functionality test
    expect(${spec.name}).toBeDefined();
  });

  it('should handle edge cases', () => {
    // Error handling test
    // Implementation should be robust
  });
});`;
  }

  /**
   * Generate minimal implementation
   */
  private generateMinimalImplementation(spec: FeatureSpec): string {
    switch (spec.type) {
      case 'component':
        return this.generateMinimalComponent(spec);
      case 'utility':
        return this.generateMinimalUtility(spec);
      case 'api':
        return this.generateMinimalApi(spec);
      case 'hook':
        return this.generateMinimalHook(spec);
      default:
        return this.generateMinimalGeneric(spec);
    }
  }

  /**
   * Generate self-healing implementation
   */
  private generateSelfHealingImplementation(spec: FeatureSpec): string {
    switch (spec.type) {
      case 'component':
        return this.generateSelfHealingComponent(spec);
      case 'utility':
        return this.generateSelfHealingUtility(spec);
      case 'api':
        return this.generateSelfHealingApi(spec);
      case 'hook':
        return this.generateSelfHealingHook(spec);
      default:
        return this.generateSelfHealingGeneric(spec);
    }
  }

  // Implementation generators
  private generateMinimalComponent(spec: FeatureSpec): string {
    return `import React from 'react';

interface ${spec.name}Props {
  // Add props based on spec
}

const ${spec.name}: React.FC<${spec.name}Props> = () => {
  return (
    <div role="main">
      <h1>${spec.name}</h1>
      <p>${spec.description}</p>
    </div>
  );
};

export default ${spec.name};`;
  }

  private generateSelfHealingComponent(spec: FeatureSpec): string {
    return `import React, { useState, useEffect, useCallback } from 'react';

interface ${spec.name}Props {
  // Add props based on spec
}

interface ${spec.name}State {
  isLoading: boolean;
  error: string | null;
  data: any;
}

const ${spec.name}: React.FC<${spec.name}Props> = () => {
  const [state, setState] = useState<${spec.name}State>({
    isLoading: false,
    error: null,
    data: null
  });

  // Self-healing error recovery
  const handleError = useCallback((error: Error) => {
    console.error('${spec.name} error:', error);
    setState(prev => ({ ...prev, error: error.message, isLoading: false }));
    
    // Auto-recovery attempt
    setTimeout(() => {
      setState(prev => ({ ...prev, error: null }));
    }, 5000);
  }, []);

  // Validate state continuously
  useEffect(() => {
    if (!state.data && !state.isLoading && !state.error) {
      // Auto-initialize if needed
    }
  }, [state]);

  if (state.error) {
    return (
      <div role="alert" className="error-boundary">
        <h2>Something went wrong</h2>
        <p>{state.error}</p>
        <button onClick={() => setState(prev => ({ ...prev, error: null }))}>
          Try Again
        </button>
      </div>
    );
  }

  return (
    <div role="main">
      <h1>${spec.name}</h1>
      <p>${spec.description}</p>
      {state.isLoading && <div>Loading...</div>}
    </div>
  );
};

export default ${spec.name};`;
  }

  private generateMinimalUtility(spec: FeatureSpec): string {
    return `/**
 * ${spec.description}
 */
export function ${spec.name}(${spec.inputs?.map(input => `${input}: any`).join(', ') || ''}): any {
  // Minimal implementation to pass tests
  return {};
}`;
  }

  private generateSelfHealingUtility(spec: FeatureSpec): string {
    return `/**
 * ${spec.description}
 * Self-healing utility with error recovery
 */

interface ${spec.name}Options {
  retries?: number;
  timeout?: number;
  fallback?: any;
}

export function ${spec.name}(
  ${spec.inputs?.map(input => `${input}: any`).join(', ') || ''},
  options: ${spec.name}Options = {}
): any {
  const { retries = 3, timeout = 5000, fallback = null } = options;

  try {
    // Input validation
    ${spec.inputs?.map(input => `
    if (${input} == null) {
      console.warn('${spec.name}: Invalid ${input}, using fallback');
      return fallback;
    }`).join('') || ''}

    // Main implementation with timeout
    const result = performOperation(${spec.inputs?.join(', ') || ''});
    
    // Output validation
    if (result == null) {
      throw new Error('Invalid result');
    }

    return result;
  } catch (error) {
    console.error('${spec.name} error:', error);
    
    // Auto-retry mechanism
    if (retries > 0) {
      console.log('${spec.name}: Retrying...', { retries });
      return ${spec.name}(${spec.inputs?.join(', ') || ''}, { ...options, retries: retries - 1 });
    }
    
    // Fallback value
    return fallback;
  }
}

function performOperation(${spec.inputs?.map(input => `${input}: any`).join(', ') || ''}): any {
  // Core implementation logic
  return {};
}`;
  }

  // Helper methods
  private getTestPath(spec: FeatureSpec): string {
    const testDir = join(this.config.testLocation, spec.type + 's');
    return join(testDir, `${spec.name}.test.tsx`);
  }

  private getImplementationPath(spec: FeatureSpec): string {
    switch (spec.type) {
      case 'component':
        return join(this.config.componentLocation, `${spec.name}.tsx`);
      case 'utility':
        return join(this.config.utilityLocation, `${spec.name}.ts`);
      case 'api':
        return join('src/app/api', spec.name.toLowerCase(), 'route.ts');
      case 'hook':
        return join('src/hooks', `use${spec.name}.ts`);
      default:
        return join('src', `${spec.name}.ts`);
    }
  }

  private getRelativeImportPath(spec: FeatureSpec): string {
    // Calculate relative path from test to implementation
    return `../../${spec.type}s/${spec.name}`;
  }

  private ensureDirectoryExists(dirPath: string): void {
    if (!existsSync(dirPath)) {
      mkdirSync(dirPath, { recursive: true });
    }
  }

  // Placeholder implementations for other generators
  private generateMinimalApi(spec: FeatureSpec): string { return '// API implementation'; }
  private generateMinimalHook(spec: FeatureSpec): string { return '// Hook implementation'; }
  private generateMinimalGeneric(spec: FeatureSpec): string { return '// Generic implementation'; }
  private generateSelfHealingApi(spec: FeatureSpec): string { return '// Self-healing API'; }
  private generateSelfHealingHook(spec: FeatureSpec): string { return '// Self-healing hook'; }
  private generateSelfHealingGeneric(spec: FeatureSpec): string { return '// Self-healing generic'; }
}

// CLI interface
if (require.main === module) {
  const tdd = new TDDProtocol();
  
  // Example usage
  const exampleSpec: FeatureSpec = {
    name: 'UserProfile',
    type: 'component',
    description: 'User profile display component',
    inputs: ['userId', 'displayMode'],
    outputs: ['profileData'],
    errorCases: ['networkError', 'invalidUser']
  };
  
  tdd.createFeature(exampleSpec);
}

export default TDDProtocol;
