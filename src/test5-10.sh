#!/bin/bash

# Filename: test5-10.sh
# Author: huoty <sudohuoty@163.com>
# Script starts from here:

x=1
until [ $x -gt 10 ]
do
    echo $x
    x=`expr $x + 1`
done
