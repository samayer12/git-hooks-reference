#!/usr/bin/env bash

rm test-report.log # Clear report file between runs

printf "INFO - Starting test suite.\n"

FAILURE_THRESHOLD=$([[ -n $CI ]] && { printf "WARN - CI Environment detected, updating failure threshold due to CI limitations." && echo 3; } \
                  ||  { echo 0; })

printf "INFO - Failure Threshold allows %s test failures.\n" "$FAILURE_THRESHOLD"

for TEST_FILE in test-*.sh; do
  bash "$TEST_FILE"
done

PASS_COUNT=$(grep -o -i "PASS" test-report.log | wc -l)
FAIL_COUNT=$(grep -o -i "FAIL" test-report.log | wc -l)
printf "INFO - Tests complete, %d passed and %d failed. See logs for details." "$PASS_COUNT" "$FAIL_COUNT"

[[ $FAIL_COUNT -gt $FAILURE_THRESHOLD ]] &&  exit 1 # Report failure if any test failed
