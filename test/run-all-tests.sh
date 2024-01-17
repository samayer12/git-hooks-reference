#!/usr/bin/env bash

for TEST_FILE in test-*.sh; do
  bash "$TEST_FILE"
done
