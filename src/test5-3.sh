#!/bin/bash

# Filename: test5-3.sh
# Author: huoty <sudohuoty@163.com>
# Script starts from here:

echo "key in a number(1-10):"
read a
if [ "$a" -lt 1 -o "$a" -gt 10 ]
then echo "Error Number."
elif [ ! "$a" -lt 5 ]
then echo "It's not less 5."
else echo "It's less 5."
fi
