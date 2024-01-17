#!/usr/bin/env bash
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
LIME_YELLOW=$(tput setaf 190)
BLUE=$(tput setaf 4)
BRIGHT=$(tput bold)
NORMAL=$(tput sgr0)
REVERSE=$(tput smso)
UNDERLINE=$(tput smul)

log_message(){
  SEVERITY=$1
  MESSAGE=$2
  SEVERITY_COLOR=$NORMAL
  case $SEVERITY in
  EMERGENCY) SEVERITY_COLOR=$RED$REVERSE ;;
  ALERT) SEVERITY_COLOR=$RED$UNDERLINE ;;
  CRITICAL) SEVERITY_COLOR=$RED$BRIGHT ;;
  ERROR) SEVERITY_COLOR=$RED ;;
  WARN) SEVERITY_COLOR=$YELLOW ;;
  NOTICE) SEVERITY_COLOR=$LIME_YELLOW ;;
  INFO) SEVERITY_COLOR=$GREEN ;;
  DEBUG) SEVERITY_COLOR=$BLUE ;;
  *) SEVERITY_COLOR=$CHGME;;
  esac

  printf "${SEVERITY_COLOR}%s${NORMAL} - %s\n" "$SEVERITY" "$MESSAGE"
}

# Other possible colors
#BLACK=$(tput setaf 0)
#POWDER_BLUE=$(tput setaf 153)
#MAGENTA=$(tput setaf 5)
#CYAN=$(tput setaf 6)
#WHITE=$(tput setaf 7)
#BLINK=$(tput blink)
#printf "%s - %s\n" "SEVERITY" "${BLACK}Black Text${NORMAL} Reset Text"
#printf "%s - %s\n" "SEVERITY" "${POWDER_BLUE}Powder Blue Text${NORMAL} Reset Text"
#printf "%s - %s\n" "SEVERITY" "${MAGENTA}MAGENTA Text${NORMAL} Reset Text"
#printf "%s - %s\n" "SEVERITY" "${CYAN}CYAN Text${NORMAL} Reset Text"
#printf "%s - %s\n" "SEVERITY" "${WHITE}WHITE Text${NORMAL} Reset Text"
#printf "%s - %s\n" "SEVERITY" "${BLINK}Blink Text${NORMAL} Reset Text"
