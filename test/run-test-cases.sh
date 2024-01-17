#!/usr/bin/env bash

# Default variable values
COUNT=0
LOG_DIR="log-not-set"
HOOK_NAME="hook-not-set"
TEST_CASES="test-cases-not-set"

# Function to display script usage
usage() {
  echo "Usage: $0 [OPTIONS]"
  echo "Options:"
  echo " -h, --help       Display this help message"
  echo " -v, --verbose    Enable verbose mode"
  echo " -d, --directory  Specify output directory for .log files"
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
    if ./callers/call-"$HOOK_NAME" -i "$TEST_CASE" > "logs/$HOOK_NAME-$COUNT-output.log" 2>&1; then
      RESULT='PASS'
    else
      RESULT='FAIL'
    fi

    printf "CASE %d - %s - Input: '%s'\n" "$COUNT" "$RESULT" "$TEST_CASE"
    COUNT=$((COUNT+1))
  done < "$TEST_CASES"

  rm test-*.txt* # Remove temporary test files
}

handle_options "$@"

run_test_cases
