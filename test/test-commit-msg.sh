#!/usr/bin/env bash

declare -a TEST_COMMIT_MESSAGES=( \
  'Test message 0' \
  'Test message 1' \
)

for TEST_MESSAGE in "${!TEST_COMMIT_MESSAGES[@]}";
do
  ./commit-msg -i "${TEST_COMMIT_MESSAGES[TEST_MESSAGE]}" -m "test" > /dev/null 2>&1

  RESULT="$([[ $? -eq 0 ]] && echo 'PASS' || echo 'FAIL')"
  printf 'CASE %d - %s - %s\n' "$TEST_MESSAGE" "$RESULT" "${TEST_COMMIT_MESSAGES[TEST_MESSAGE]}"

done
