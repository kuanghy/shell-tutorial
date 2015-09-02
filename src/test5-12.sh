#!/bin/bash

# Filename: test5-12.sh
# Author: huoty <sudohuoty@163.com>
# Script starts from here:

for i in 1 2 3 4 5 6
do
    if [ "$i" -eq 3 ]
    then continue
    else echo "$i"
    fi
done
