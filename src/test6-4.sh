#!/bin/bash

# Filename: test6-4.sh
# Author: huoty <sudohuoty@163.com>
# Script starts from here:

testfile()
{
    if [ -d "$1" ]
    then echo "$1 is a directory."
    else echo "$1 is not a directory."
    fi
    echo "End of the function."
}

testfile /home/huoty/.vimrc
