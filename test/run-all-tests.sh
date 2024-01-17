#!/usr/bin/env bash

rm test-report.log # Clear report file between runs

for TEST_FILE in test-*.sh; do
  bash "$TEST_FILE"
done

PASS_COUNT=$(grep -o -i "PASS" test-report.log | wc -l)
FAIL_COUNT=$(grep -o -i "FAIL" test-report.log | wc -l)
printf "INFO - Tests complete, %d passed and %d failed. See logs for details." "$PASS_COUNT" "$FAIL_COUNT"

[[ $FAIL_COUNT -gt 0 ]] &&  exit 1 # Report failure if any test failed
