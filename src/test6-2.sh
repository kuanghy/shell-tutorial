#!/bin/bash

# Filename: test5-14.sh
# Author: huoty <sudohuoty@163.com>
# Script starts from here:

fun_with_return()
{
    echo -n "Your first name: "
    read fname
    echo -n "Your last name:"
    read lname
    echo "Your name is $fname $lname"

    return 10
}

#fun_with_return
#ret=$?
ret=`fun_with_return`
echo "Ret: $ret"
