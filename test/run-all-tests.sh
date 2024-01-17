#!/usr/bin/env bash

rm test-report.log # Clear report file between runs

printf "INFO - Starting test suite.\n"

FAILURE_THRESHOLD=0

if [[ -n $CI ]]; then
  FAILURE_THRESHOLD=3
  printf "WARN - CI Environment detected, updating failure threshold to %d due to CI limitations.\n" \
         "$FAILURE_THRESHOLD"
fi

for TEST_FILE in test-*.sh; do
  bash "$TEST_FILE"
done

PASS_COUNT=$(grep -o -i "PASS" test-report.log | wc -l)
FAIL_COUNT=$(grep -o -i "FAIL" test-report.log | wc -l)
printf "INFO - Tests complete, %d passed and %d failed. See logs for details." \
       "$PASS_COUNT" \
       "$FAIL_COUNT"

[[ $FAIL_COUNT -gt $FAILURE_THRESHOLD ]] &&  exit 1
