#!/usr/bin/env bash

source ../scripts/log-message.sh

# TODO: Stage a file that gets linted
git checkout -b '123456789-test-branch-prepare-commit' 1>/dev/null 2>&1
log_message "DEBUG" "Current Branch: $(git symbolic-ref --short HEAD)" 1>/dev/null 2>&1

./run-test-cases.sh --directory logs --input "input/valid-prepare-commit-msg.txt" --hook-name prepare-commit-msg

git checkout main 1>/dev/null 2>&1
git branch -D '123456789-test-branch-prepare-commit' 1>/dev/null 2>&1
