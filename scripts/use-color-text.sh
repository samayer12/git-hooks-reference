source log-message.sh

rm color.log
log_message "EMERGENCY" "The message" >> color.log
log_message "ALERT" "The message" >> color.log
log_message "CRITICAL" "The message " >> color.log
log_message "ERROR" "The message " >> color.log
log_message "WARNING" "The message " >> color.log
log_message "NOTICE" "The message " >> color.log
log_message "INFORMATIONAL" "The message " >> color.log
log_message "DEBUG" "The message " >> color.log
cat color.log
