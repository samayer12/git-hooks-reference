#!/usr/bin/env bash

source ../hooks/utilities/log-message.sh

# Default variable values
COUNT=0
LOG_DIR="log-not-set"
HOOK_NAME="hook-not-set"
TEST_CASES="test-cases-not-set"
SHOULD_FAIL=false

# Function to display script usage
usage() {
  echo "Usage: $0 [OPTIONS]"
  echo "Options:"
  echo " -h, --help       Display this help message"
  echo " -v, --verbose    Enable verbose mode"
  echo " -d, --directory  Specify output directory for .log files"
  echo " -f, -should-fail Consider failures successful, useful for testing 'sad path'"
  echo " -i, --input      Specify array of test cases for git hook under test"
  echo " -n, --hook-name  Specify name of git hook under test"
  echo " -p, --prefix     Specify prefix for .log file name"
}

has_argument() {
  [[ ("$1" == *=* && -n ${1#*=}) || ( -n "$2" && "$2" != -*)  ]];
}

extract_argument() {
  echo "${2:-${1#*=}}"
}

# Function to handle options and arguments
handle_options() {
  while [ $# -gt 0 ]; do
    case $1 in
      -h | --help)
        usage
        exit 0
        ;;
      -v | --verbose)
        verbose_mode=true
        ;;
      -d | --directory)
        LOG_DIR=$(extract_argument "$@")
        shift
        ;;
      -i | --input)
        TEST_CASES=$(extract_argument "$@")
        shift
        ;;
      -n | --hook-name)
        HOOK_NAME=$(extract_argument "$@")
        shift
        ;;
      -f | --should-fail)
        SHOULD_FAIL=true
        shift
        ;;
      *)
        echo "Invalid option: $1" >&2
        usage
        exit 1
        ;;
    esac
    shift
  done
};


run_test_cases(){
  mkdir -p "$LOG_DIR"
  while read -r TEST_CASE;
  do
    RESULT=''
    # TODO: Handle "successful failure" cases for testing 'invalid' input
    if $SHOULD_FAIL; then
     # Sad Path
     if ./callers/call-"$HOOK_NAME" -i "$TEST_CASE" > "logs/invalid-$HOOK_NAME-$COUNT-output.log" 2>&1; then
        RESULT='FAIL'
      else
        RESULT='PASS'
      fi
    else
     # Happy Path
     if ./callers/call-"$HOOK_NAME" -i "$TEST_CASE" > "logs/$HOOK_NAME-$COUNT-output.log" 2>&1; then
        RESULT='PASS'
      else
        RESULT='FAIL'
      fi
    fi

    log_message "INFO" "$(printf "%s - CASE %d - %s - Input: '%s'\n" "$HOOK_NAME" "$COUNT" "$RESULT" "$TEST_CASE")" 2>&1 | tee -a logs/test-report.log
    COUNT=$((COUNT+1))
  done < "$TEST_CASES"

  rm test-*.txt* # Remove temporary test files
}

handle_options "$@"

run_test_cases
