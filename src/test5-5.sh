#!/bin/bash

# Filename: test5-5.sh
# Author: huoty <sudohuoty@163.com>
# Script starts from here:

case $1 in
    file) 
        echo "it is a file";;
    dir|path)
        echo "current directory is `pwd`";;
    [Dd]ate)
        echo "the date is `date`";;
    *)
        echo "it is not a filename";;
esac
