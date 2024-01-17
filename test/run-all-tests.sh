#!/usr/bin/env bash

source ../hooks/utilities/log-message.sh

TEST_REPORT_PATH="logs/test-report.log"

rm $TEST_REPORT_PATH > /dev/null 2>&1 # Clear report file between runs

log_message "INFO" "Starting test suite."

FAILURE_THRESHOLD=0

if [[ -n $CI ]]; then
  FAILURE_THRESHOLD=3
  log_message "WARN" "CI Environment detected, updating failure threshold to $FAILURE_THRESHOLD due to CI limitations."
fi

for TEST_FILE in test-*.sh; do
  bash "$TEST_FILE"
done

PASS_COUNT=$(grep -o -i "PASS" $TEST_REPORT_PATH | wc -l | tr -d ' ')
FAIL_COUNT=$(grep -o -i "FAIL" $TEST_REPORT_PATH | wc -l | tr -d ' ')
log_message "INFO" "Tests complete, $PASS_COUNT passed and $FAIL_COUNT failed."

if [[ $FAIL_COUNT -gt $FAILURE_THRESHOLD ]]; then
  log_message "ERROR" "Failure Threshold of $FAILURE_THRESHOLD failing tests exceeded, there are too many failing tests. Check logs."
  exit 1
else
  exit 0
fi
