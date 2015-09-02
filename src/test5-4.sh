#!/bin/bash

# Filename: test5-4.sh
# Author: huoty <sudohuoty@163.com>
# Script starts from here:

s1=1
s2=test5-4.sh
s3=5
a=6

if [ ! "$s1" -le 0 ]
then echo "s1大于0"
else echo "s1小于等于0"
fi

if [ -f "$s2" -a -w "$s2" ]
then echo "$s2 是普通文件并且具有写权限"
else echo "$s2 不是普通文件或者没有写权限"
fi

if [ "$s1" -gt 0 -o "$s3" -lt 10 ]
then echo "s1大于0且s3小于10"
else echo "不在指定范围内"
fi

if [ \( "$a" -gt 0 -a "$a" -lt 10 \) -a "$a" -ne 5 ]
then echo "0 < a < 10 且 a 不等于 5"
else echo "不在指定范围内"
fi
