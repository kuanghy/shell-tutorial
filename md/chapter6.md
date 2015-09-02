## 自定义函数

在 Shell 中可以自定义并使用函数。其定义格式为：

```
Function()
{
    command-list
    [ return-value ]
}
```

函数应先定义，后使用。**调用函数时，直接利用函数名调用**。示例：

```
#!/bin/bash

# Filename: test6-1.sh
# Author: huoty <sudohuoty@163.com>
# Script starts from here:

hello()
{
    echo "Hello, I am huoty(http://kuanghy.github.io/) !"
}

hello
```

Shell 函数也可以有**返回值**，但是该返回值只能为整数。我们可以这样来理解函数的返回值，其实函数就相当于一个命令，其返回值用于表示其执行的状态，所以只能为整数。返回值的接受有两种方式：一种是用变量接收，这其实是将标准输出传递给主程序的变量；另一种是用 `$?` 接收。示例：

```
#!/bin/bash

# Filename: test6-2.sh
# Author: huoty <sudohuoty@163.com>
# Script starts from here:

fun_with_return()
{
    echo -n "Your first name: "
    read fname
    echo -n "Your last name:"
    read lname
    echo "Your name is $fname $lname"

    return 10
}

fun_with_return
ret=$?  # or "ret=`fun_with_return`"
echo "Ret: $ret"
```

Shell 函数可以**嵌套调用**，示例：

```
#!/bin/bash

# Filename: test6-3.sh
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
```

在Shell中，调用函数时可以向其传递参数。在函数体内部，通过 $n 的形式来获取参数的值，例如，$1表示第一个参数，$2表示第二个参数等等。但需要注意的是， $10 不能获取第十个参数，获取第十个参数需要${10}。当n>=10时，需要使用${n}来获取参数。在调用函数传参时，直接在函数名后加上参数即可，各参数间用空格隔开。示例：

```
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
```

另外，还有几个特殊变量用来处理参数： `$#` 传递给函数的参数个数；`$*` 显示所有传递给函数的参数；`$?` 函数的返回值。