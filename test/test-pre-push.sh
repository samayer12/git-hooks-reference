#!/usr/bin/env bash

COUNT=0
LOG_FILE_PREFIX='test-pre-push-case'
LOG_DIR='logs'

run_test_cases(){
  mkdir -p $LOG_DIR
  declare -a TEST_CASES=("$@")
  for TEST_CASE in "${!TEST_CASES[@]}";
  do
    RESULT=''
#    if ./call-pre-push -i "${TEST_CASES[TEST_CASE]}"; then
    if ./call-pre-push -i "${TEST_CASES[TEST_CASE]}" > "logs/$LOG_FILE_PREFIX-$COUNT-output.log" 2>&1; then
      RESULT='PASS'
    else
      RESULT='FAIL'
    fi

    printf "CASE %d - %s - Input: '%s'\n" "$COUNT" "$RESULT" "${TEST_CASES[TEST_CASE]}"
    COUNT=$((COUNT+1))

  done

  rm test-*.txt # Remove temporary test files
}


declare -a COMMIT_MESSAGES=( \
  "123: Pre Push Input 1" \
  "456: Pre Push Input 2" \
)

run_test_cases "${COMMIT_MESSAGES[@]}"
