#!/usr/bin/env bash

# TODO: Stage a file that gets linted
git checkout -b '123456789-test-branch-prepare-commit'
echo "Current Branch: $(git symbolic-ref --short HEAD)"

./run-test-cases.sh --directory logs --input "input/valid-prepare-commit-msg.txt" --hook-name prepare-commit-msg

git checkout main
git branch -D '123456789-test-branch-prepare-commit'
