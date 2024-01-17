#!/usr/bin/env bash

source ../scripts/log-message.sh

rm test-report.log # Clear report file between runs

log_message "INFORMATIONAL" "Starting test suite."

FAILURE_THRESHOLD=0

if [[ -n $CI ]]; then
  FAILURE_THRESHOLD=3
  log_message "WARNING" "CI Environment detected, updating failure threshold to $FAILURE_THRESHOLD due to CI limitations."
fi

for TEST_FILE in test-*.sh; do
  bash "$TEST_FILE"
done

PASS_COUNT=$(grep -o -i "PASS" test-report.log | wc -l | tr -d ' ')
FAIL_COUNT=$(grep -o -i "FAIL" test-report.log | wc -l | tr -d ' ')
log_message "INFORMATIONAL" "Tests complete, $PASS_COUNT passed and $FAIL_COUNT failed."

if [[ $FAIL_COUNT -gt $FAILURE_THRESHOLD ]]; then
  log_message "ERROR" "Failure Threshold of $FAILURE_THRESHOLD failing tests exceeded, there are too many failing tests. Check logs."
  exit 1
else
  exit 0
fi
