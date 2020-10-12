#!/usr/bin/env bash
# The previous line is the shebang, whereas the current line is a comment
# Comments are lines starting with "#", with the exception of the shebang,
# and can be used to write anything: comments will be ignored by the interpreter.

##
# Script arguments

# First, arguments are variables available within the script
# $1: first argument
# $2: second argument
# etc
#
# For example: the call to this script is:
# ./sample_script.sh Carlos Cantalapiedra 39
#
# echo $1
# Carlos
# echo $2
# Cantalapiedra
# echo $3
# 39

# I like to assign those arguments to variable as the first step of the script, so that I have descriptive variable names
#

user_name="${1}"
user_surname="${2}"
user_age="${3}"

# Then, I like to define global variables to be used in my script, which I declare with uppercase

ADULT_AGE=18

# Then, I start the script printing to stderr the arguments received by the script
# so the user calling the script can check if they are correct

printf "Running sample_script.sh for:\n" 1>&2
printf "\tUser name: ${user_name}\n" 1>&2
printf "\tUser surname: ${user_surname}\n" 1>&2
printf "\tUser age: ${user_age}\n" 1>&2

##
# Then, we start our script

if [ ${user_age} -lt ${ADULT_AGE} ]; then
    printf "Sorry, this script is only for adults.\n" 1>&2
    exit 1 # exit status not OK: user is not adult
else
    user_config_file="sample_script.sh.${user_name}.${user_surname}.config"
    if [ -e "${user_config_file}" -a -f "${user_config_file}" ]; then
	printf "Printing config file ${user_config_file} for user ${user_name}\n" 1>&2
	cat "${user_config_file}" | grep "^CONFIG"
	if [ $? -eq 0 ]; then
	    printf "Config was correctly found for user ${user_name}\n" 1>&2
	else
	    printf "No CONFIG lines were found in ${user_config_file} for user ${user_name}\n" 1>&2;
	fi
    else
	printf "Couldn't find user config file ${user_config_file} for user ${user_name}\n" 1>&2
	exit 2 # exit status not OK: config file not found
    fi;
fi;

exit 0 # exit status OK
