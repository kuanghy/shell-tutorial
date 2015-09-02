#!/bin/bash

# Filename: 
# Author: huoty <sudohuoty@163.com>
# Script starts from here:

for i in *.sh
do
    cat $i | pr
done
