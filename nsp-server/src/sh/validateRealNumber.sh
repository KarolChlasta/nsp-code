#!/bin/bash
# validateRealNUmber: chek if the argument agr1 is real number
echo "validateRealNumber: The arguments passed in are : $@"
ex='^[0-9]+([.][0-9]+)?$'
if [[ "$1" =~ $ex ]] ; then
     echo 'validateRealNumber: parameter is Real number. OK'
 else
     echo 'validateRealNumber: You should enter an real!'
     exit 1

 fi
