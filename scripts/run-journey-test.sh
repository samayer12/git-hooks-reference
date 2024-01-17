#!/usr/bin/env sh

exec < /dev/tty

YELLOW='\033[0;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NOCOLOR='\033[0m' # No Color

isEquipmentServiceRunning(){
  # shellcheck disable=SC2116
  while read -p "$(echo "${YELLOW}"WARN - Please run your equipment microservice. Press y when running. "${NOCOLOR}")" -n 1 -r
  echo
    do
      if [[ $REPLY =~ ^[Yy]$ ]]
      then
        break;
      else
        echo "${RED}ERROR - Invalid input.${NOCOLOR}"
      fi
    done
}

read -p "$(echo "${BLUE}"INFO - Do you want to run Journey tests? [y/n] "${NOCOLOR}")" -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]
then
  isEquipmentServiceRunning
  echo "${BLUE}INFO - Starting Journey tests${NOCOLOR}"
  yarn --cwd journey test
else
  echo "${BLUE}INFO - SKIPPING JOURNEY TESTS${NOCOLOR}"
fi