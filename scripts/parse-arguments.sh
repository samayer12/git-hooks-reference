#!/usr/bin/env bash

# TODO: Maybe this file can be deprecated
# Default variable values
verbose_mode=false
output_file=""
input_string=""

# Function to display script usage
usage() {
  echo "Usage: $0 [OPTIONS]"
  echo "Options:"
  echo " -h, --help      Display this help message"
  echo " -v, --verbose   Enable verbose mode"
  echo " -i, --input     Specify input to this script"
  echo " -f, --file      FILE Specify an output file"
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
      -i | --input)
        input_string=$(extract_argument "$@")
        shift
        ;;
      -f | --file*)
        if ! has_argument "$@"; then
          echo "File not specified." >&2
          usage
          exit 1
        else
          output_file=$(extract_argument "$@")
        fi
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


#######################
# Main script prep
#######################
handle_options "$@"

# Perform the desired actions based on the provided flags and arguments
if [ "$verbose_mode" = true ]; then
 echo "Verbose mode enabled."
fi

if [ -n "$output_file" ]; then
 echo "Output file specified: $output_file"
fi

echo "$input_string"
