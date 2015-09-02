#!/bin/bash

# Filename: test5-11.sh
# Author: huoty <sudohuoty@163.com>
# Script starts from here:

x=1
while true
do
    echo $x
    x=`expr $x + 1`
    if [ "$x" -gt 10 ]
    then break
    fi
done
