#!/bin/bash

# Filename: test5-15.sh
# Author: huoty <sudohuoty@163.com>
# Script starts from here:

# Calling one function from another
number_one () {
   echo "Url_1 is http://kuanghy.github.io/"
   number_two
}

number_two () {
   echo "Url_2 is http://kuanghy.github.io/about/"
}

number_one
