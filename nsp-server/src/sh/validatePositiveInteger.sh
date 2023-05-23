#!/bin/bash
# validatePositiveInteger: chek if the argument i and positive Integer
echo "validatePositiveInteger: The arguments passed in are : $@"

if [ "$1" -eq "$1" 2> /dev/null ]; then
  if [ ! "$1" -gt 0 ]; then
    echo 'validatePositiveInteger: You should enter a positive Integer! '
    exit 2
  fi
else
    echo 'validatePositiveInteger: You should enter an Integer! '
    exit 1

fi
