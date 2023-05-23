#!/bin/bash
# validateRange: chek if the argument agr1 is between <ag2,agr3>
echo "validateRange: The arguments passed in are : $@"

if [ "$1" -eq "$1" 2> /dev/null ]; then
  if [ ! "$1" -ge $2 ] || [ ! "$1" -le $3 ]; then
    echo "validateRange: parameter $1 outside the range <$2,$3>!"
    exit 2
  fi
else
    echo 'validateRange: You should enter an Integer!'
    exit 1

fi
