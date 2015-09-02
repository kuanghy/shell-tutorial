#!/bin/bash

# Filename: test5-8.sh
# Author: huoty <sudohuoty@163.com>
# Script starts from here:

dir=$1; shift
if [ -d $dir ]
then cd $dir
     for name # or "for name in $*"
     do
         if [ -f $name ]
         then cat $name
              echo "End of ${dir}/$name"
         else echo "Invalid file name: ${dir}/$name"
         fi
     done
else echo "Bad directory name:$dir"
fi
