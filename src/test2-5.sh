#!/bin/bash

# Filename: test2-1.sh
# Author: huoty <sudohuoty@163.com>
# Script starts from here:

myEmail="huoty@gmail.com"
echo $myEmail
unset myEmail
echo $myEmail

myUrl="http://see.xidian.edu.cn/cpp/shell/"
echo $myUrl
readonly myUrl
myUrl="http://see.xidian.edu.cn/cpp/danpianji/"
