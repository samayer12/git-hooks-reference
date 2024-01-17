#!/usr/bin/env bash

COUNT=0
LOG_FILE_PREFIX='test-prepare-commit-msg'
LOG_DIR='logs'

run_test_cases(){
  mkdir -p $LOG_DIR
  declare -a TEST_CASES=("$@")
  for TEST_CASE in "${!TEST_CASES[@]}";
  do
    RESULT=''
    if ./call-prepare-commit-msg -i "${TEST_CASES[TEST_CASE]}" > "logs/$LOG_FILE_PREFIX-$COUNT-output.log" 2>&1; then
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
  '123: Prepare test message 0' \
  '456: Prepare test message 1' \
)

# TODO: Stage a file that gets linted

run_test_cases "${COMMIT_MESSAGES[@]}"
