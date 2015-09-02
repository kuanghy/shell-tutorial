#!/bin/bash

# Filename: test5-9.sh
# Author: huoty <sudohuoty@163.com>
# Script starts from here:

while [ $1 ]
do
    if [ -f $1 ]
    then echo "display: $1"
        cat $1
    else echo "$1 is not filename."
    fi
    shift
done
