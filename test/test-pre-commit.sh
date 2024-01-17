#!/usr/bin/env bash

declare -a TEST_INPUT=( \
  "Input 1" \
  "Input 2" \
)

for TEST_ITEM in "${TEST_INPUT[@]}";
do
  echo "$TEST_ITEM"
done
