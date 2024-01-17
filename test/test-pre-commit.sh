#!/usr/bin/env bash

# Test Setup
touch staged-file-that-matches-rule.ts
git add staged-file-that-matches-rule.ts

# Test
./run-test-cases.sh --directory logs --input "input/pre-commit.txt" --hook-name pre-commit

# Test Cleanup
git reset HEAD staged-file-that-matches-rule.ts 1>/dev/null 2>&1
rm staged-file-that-matches-rule.ts
