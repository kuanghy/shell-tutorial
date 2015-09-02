#!/bin/bash

# Filename: 
# Author: huoty <sudohuoty@163.com>
# Script starts from here:

if test -f "$1"
then echo "$1 is an ordinary file"
else echo "$1 is not an ordinary file"
fi
