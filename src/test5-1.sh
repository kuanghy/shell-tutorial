#!/bin/bash

# Filename: test5-1.sh
# Author: huoty <sudohuoty@163.com>
# Script starts from here:

echo "Type in the user name"
read user

if who | grep $user
then echo "Hello $user" | write $user
else echo "$user has not logged in the system"
fi
