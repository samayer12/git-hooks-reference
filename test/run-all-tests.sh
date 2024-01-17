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
printf "INFO - Tests complete, %d passed and %d failed.\n" \
       "$PASS_COUNT" \
       "$FAIL_COUNT"

if [[ $FAIL_COUNT -gt $FAILURE_THRESHOLD ]]; then
  printf "ERROR - Failure Threshold of %d failing tests broken, there are too many failing tests. Check logs.\n" "$FAILURE_THRESHOLD"
  exit 1
else
  exit 0
fi
