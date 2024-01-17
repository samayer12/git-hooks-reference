#!/usr/bin/env bash

# Test Setup
cat > unlinted-code.ts <<EOL
// File: extendedLintingViolations.js
const greetUser = (name): str => { return "Hello, " + name + "!"; };  // Violation: Prefer template literals over string concatenation
const multiplyNumbers = (a, b): number => { return a*b }  // Violation: Missing semicolon
const badlyFormattedComponent = function(props): number {
  // Violation: Inconsistent indentation
   const result = 10 * 2  // Violation: Missing semicolon
    return result
};
// Violation: Unused variable
const unusedVariable = "This variable is not used"
const isEven = (num): boolean => {
  if(num%2 === 0) {
    return true
  } else {
    return false
  }
}
// Violation: Multiple empty lines
const subtractNumbers = (a, b): number => {
  return a - b
}
export { greetUser, multiplyNumbers, badlyFormattedComponent, unusedVariable, isEven, subtractNumbers };
EOL


touch staged-file-that-matches-rule.ts
git add staged-file-that-matches-rule.ts unlinted-code.ts

# Test
./run-test-cases.sh --directory logs --input "input/pre-commit.txt" --hook-name pre-commit

# Test Cleanup
git reset HEAD staged-file-that-matches-rule.ts unlinted-code.js 1>/dev/null 2>&1
rm staged-file-that-matches-rule.ts unlinted-code.ts
