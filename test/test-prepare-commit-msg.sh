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
    if ./callers/call-prepare-commit-msg -i "${TEST_CASES[TEST_CASE]}" > "logs/$LOG_FILE_PREFIX-$COUNT-output.log" 2>&1; then
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
  '123456789: Branch name already in message' \
  '456: Invalid issue ID in message' \
  'No issue ID in message' \
)

# TODO: Stage a file that gets linted
git checkout -b '123456789-test-branch-prepare-commit'
echo "Current Branch: $(git symbolic-ref --short HEAD)"

run_test_cases "${COMMIT_MESSAGES[@]}"

git checkout main
git branch -D '123456789-test-branch-prepare-commit'
