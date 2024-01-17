#!/usr/bin/env bash

declare -a TEST_INPUT=( \
  "Pre Push Input 1" \
  "Pre Push Input 2" \
)

for TEST_ITEM in "${TEST_INPUT[@]}";
do
  echo "$TEST_ITEM"
done
