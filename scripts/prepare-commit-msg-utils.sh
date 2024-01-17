#!/usr/bin/env bash

RED='\033[0;31m'

updateCommitMessage(){
  echo "${BLUE}INFO - Prepending issue number to commit message.${NOCOLOR}"
  if [ -n "$BRANCH_NAME" ]; then
  sed -i.bak -e "1s/^/$EXTRACTED_ISSUE_ID: /" "$1" # Prepend trimmed branch ID to the commit message
  fi
}

askUserToContinue(){
  exec < /dev/tty
  read -p "$(echo "${BLUE}"INFO - Commit anyway? [y/n]"${NOCOLOR}")" -n 1 -r
  echo
  [[ $REPLY =~ ^[Yy]$ ]] && exit 0 || exit 1
}

printIssueURL(){
  echo "${BLUE}INFO - View on Pivotal Tracker: https://www.pivotaltracker.com/story/show/$EXTRACTED_ISSUE_ID${NOCOLOR}"
}

doesInputMatchIssueFormat(){
  [[ "$1" =~ $2 ]]
}

handleInputMismatch(){
  echo "${RED}ERROR - Could not detect issue number from filtered input of '$1'${NOCOLOR}"
  echo "${RED}ERROR - Branch name did not match regular expression $ISSUE_ID_FORMAT${NOCOLOR}"
  askUserToContinue "$@"
}
