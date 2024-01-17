#!/usr/bin/env bash

./run-test-cases.sh --directory logs --input "input/valid-commit-msg.txt" --hook-name commit-msg
./run-test-cases.sh --directory logs --input "input/invalid-commit-msg.txt" --hook-name commit-msg
