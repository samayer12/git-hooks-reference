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
#    if ./callers/call-pre-push -i "${TEST_CASES[TEST_CASE]}"; then
    if ./callers/call-pre-push -i "${TEST_CASES[TEST_CASE]}" > "logs/$LOG_FILE_PREFIX-$COUNT-output.log" 2>&1; then
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
  # "456: Pre Push Input 2" \ # Need to make a test case for sad path
)

CURRENT_SHA="$(git rev-parse HEAD)"
touch index.ts # A dummy frontend file
touch main.java # A dummy backend file
git add main.java index.ts
git commit -m "123123123: A change to backend and frontend" # Need to automate the 'y' prompt or branch appropriately
# Cannot just branch without also pushing and then deleting that branch because of rev-parse with origin/HEAD

run_test_cases "${COMMIT_MESSAGES[@]}"

git reset "$CURRENT_SHA"
rm main.java index.ts

[[ $CURRENT_SHA -eq $(git rev-parse HEAD) ]]; \
  (echo "INFO - Commit SHA reset success."; exit 0) || \
  (echo "ERROR - Commit SHA mismatch after running pre-push tests."; exit 1)
