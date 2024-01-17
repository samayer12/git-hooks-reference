#!/usr/bin/env bash

declare -a TEST_INPUT=( \
  "Prepare Commit Input 1" \
  "Prepare Commit Input 2" \
)

for TEST_ITEM in "${TEST_INPUT[@]}";
do
  echo "$TEST_ITEM"
done
