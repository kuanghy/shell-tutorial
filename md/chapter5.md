## Shell 程序控制结构语句

Shell 程序类似其他高级语言，同样具有控制结构，程序的控制结构语句用于决定 Shell 脚本中的语句的执行顺序。脚本的控制结构语句有三种基本类型：两个分支、多路分支以及一个或者多个命令的循环执行。Linux 的 Bash 中的两路分支语句是 if 语句，多路分支是 if 和 case 语句，代码的循环执行语句是 for、while 和 unitl 语句。

### if 语句

Shell 提供了功能丰富的 if 语句，其一般用于两路分支，但也可以用于多路分支，是最常用的条件控制语句。

#### 1. 两路分支的 if 语句

if 语句的最基本形式一般是用于两路分支，下面是该语句的一般格式：

```
if 判断条件
then 命令1
else 命令2
fi
```

其中 if、then、else 和 fi 是关键字，若没有 else 行，则变为“一路分支”单纯的 if 语句。判断条件包括命令语句和测试语句两种方式。

**（1）命令语句形式的判断条件**

一般以命令的执行成功与否来判断，如果命令成功执行并正常结束，则返回值 0，判断条件为真；如果命令执行不成功，其返回值不等于 0，判断条件为假。如果命令语句形式的判断条件由多条命令组成，那么判断条件以最后一条命令是否执行成功为准。

下面列举一个示例，查找给定用户是否在系统中工作，如果在系统中就发一个问候给他：

```
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
```

**（2）测试语句形式的判断条件**

测试语句是 Shell 程序最常用的判断条件，它包括字符串测试、文件测试和数值测试，之后将详细介绍这些内容。下面列举一个简单示例，利用位置参数携带一个文件名，判断该文件在当前目录下是否存在且是一个普通文件：

```
#!/bin/bash

# Filename: test5-2.sh
# Author: huoty <sudohuoty@163.com>
# Script starts from here:

if test -f "$1"
then echo "$1 is an ordinary file"
else echo "$1 is not an ordinary file"
fi
```

#### 2. 多路条件判断分支的 if 语句

在 if 语句两路分支中再嵌套一组 if 语句两路分支，则可以变成多路条件分支，它可以简写为以下格式：

```
if 判断条件1
then 命令1
elif 判断条件2
then 命令2
...
else 命令n
fi
```

其中 elif 是 else if 的缩写。下面编写一个简单例子，输入 1 ~ 10 之间的一个数，并判断是否小于5。

```
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
```

### 测试语句

测试语句是 Shell 的特有功能，它往往是和各种条件语句结合使用，如与 if、case、while 搭配，它在 Shell 编程中起着很重要的作用，使用频率很高。测试语句计算一个表达式的值，并返回“真”或“假”。该语句有两种语法格式，一种是使用关键字 `test`，而另一种是使用方括号。格式如下：

格式1：

> test expression

格式2：

> [ expression ]

例如测试位置参数携带的文件名是否在当前目录下已存在并且为普通文件，可写成：

```
test -f  "$1"  # 格式1写法
[ -f "$1" ]      # 格式2写法
```

**注意：**<br/>
（1）如果在 test 语句中使用 Shell 变量，为表示完整，避免造成歧义，最好用双引号将变量括起来。
（2）在任何一个运算符、圆括号或者方括号等操作符额前后**至少需要留有一个空格，否则可能会出错**。
（3）如果需要下一行继续测试表达式，应该在换行之前加上反斜杠（\），这样 Shell 就会将下一行当做上一行的接续。

测试语句支持很多运算符，它们用于三种形式的测试：文件测试、字符测试和数值测试，也可以在罗辑上将两个或者更多的测试语句连接成更复杂的表达式，大多数 UNIX/Linux 系统上的测试语句都支持运算符的含义。

#### 1. 文件测试

文件测试是判断当前路径下的文件属性即类型，所指的文件一般用变量所代表的文件名表示。文件测试的各个参数及功能如下所示：

-b filename : 当filename 存在并且是块文件时返回真(返回0)
-c filename : 当filename 存在并且是字符文件时返回真
-d pathname : 当pathname 存在并且是一个目录时返回真
-e pathname : 当由pathname 指定的文件或目录存在时返回真
-f filename : 当filename 存在并且是正规文件时返回真
-g pathname : 当由pathname 指定的文件或目录存在并且设置了SGID 位时返回真
-h filename : 当filename 存在并且是符号链接文件时返回真 (或 -L filename)
-k pathname : 当由pathname 指定的文件或目录存在并且设置了"粘滞"位时返回真
-p filename : 当filename 存在并且是命名管道时返回真
-r pathname : 当由pathname 指定的文件或目录存在并且可读时返回真
-s filename : 当filename 存在并且文件大小大于0 时返回真
-S filename : 当filename 存在并且是socket 时返回真
-t fd       : 当fd 是与终端设备相关联的文件描述符时返回真
-u pathname : 当由pathname 指定的文件或目录存在并且设置了SUID 位时返回真
-w pathname : 当由pathname 指定的文件或目录存在并且可写时返回真
-x pathname : 当由pathname 指定的文件或目录存在并且可执行时返回真
-O pathname : 当由pathname 存在并且被当前进程的有效用户id 的用户拥有时返回真(字母O 大写)
-G pathname : 当由pathname 存在并且属于当前进程的有效用户id 的用户的用户组时返回真
file1 -nt file2 : file1 比file2 新时返回真
file1 -ot file2 : file1 比file2 旧时返回真

#### 2. 字符串测试

有关字符串的测试参数及功能如下所示：

-z string    : 字符串string 为空串(长度为0)时返回真
-n string    : 字符串string 为非空串时返回真
str1 = str2  : 字符串str1 和字符串str2 相等时返回真
str1 != str2 : 字符串str1 和字符串str2 不相等时返回真
str1 < str2  : 按字典顺序排序，字符串str1 在字符串str2 之前
str1 > str2  : 按字典顺序排序，字符串str1 在字符串str2 之后

字符串的测试语句实例：判断两个变量 是s1 和 s2 所代表的字符串是否相等，可以写成：

> [ "$s1" = "$s2" ] 或 test "$s1" = "$s2"

在引用变量及字符串时，要求用双引号括起来，又如在判断变量 s1 是否等于字符串 “yes” 时，可以写成：

> [ "$s1" = "yes" ] 或 test "$s1" = "yes"

#### 3. 数值测试

有关数值测试参数及功能如下所示：

int1 -eq int2 : 如果int1 等于int2，则返回真
int1 -ne int2 : 如果int1 不等于int2，则返回真
int1 -lt int2 : 如果int1 小于int2，则返回真
int1 -le int2 : 如果int1 小于等于int2，则返回真
int1 -gt int2 : 如果int1 大于int2，则返回真
int1 -ge int2 : 如果int1 大于等于int2，则返回真

数值测试语句实例：判断变量 s1 所代表的数值是否大于10，可以写成：

> [ "$s1" -gt 10 ] 或 test "$s1" -gt 10

#### 4. 用逻辑操作符进行组合的测试语句

判断条件可以在 if 语句或循环语句中单个使用，也可以通过逻辑操作符把它们组合起来使用，形成更复杂的表达式。可以在测试语句中使用的逻辑操作符有：逻辑与、逻辑或、逻辑非。它们的参数和功能如下所示：

-a     逻辑与，操作符两边均为真，结果为真，否则为假。
-o     逻辑或，操作符两边一边为真，结果为真，否则为假。
!       逻辑否，条件为假，结果为真。即将原来真的表达式变为假，假的变为真。
()      圆括号，用于将表达式分组，优先得到结果。括号前后应该有空格并用转义符转义。

用逻辑操作符进行组合的测试语句实例如下：

```
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
```

### case 语句

`case语句` 即选择语句，其允许从几种情况中选择一种情况执行，而且 case 语句不但取代了多个 elif 和 then 语句，还可以用变量值对多个模式进行匹配，当某个模式与变量匹配后，其后的一系列命令将被执行。在 Shell 中，可以使用 case 语句比较带有通配符的字符串，这比其他高级语句的功能稍强。Bash 的 case 语句格式如下：

```
case string1 in
str1)
    commands-list1;;
str2)
    commands-list2;;
...
strn)
    commands-listn;;
esac
```

**作用：**将 string1 和 str1, ... , strn 比较，如果 str1 到 strn 中的任何一个和 string1 相符合，则执行其后的命令一直到分号（;;）结束。如果 str1 到 strn 中没有和 string1 相符合的，则其后语句不被执行。其中，str1 到 strn 也称之为正则表达式。示例：

```
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
```

**使用 case 时应注意以下几点：**
（1）每个正则表达式后面可以有一条或多条命令，其最后一条命令必须以两个分号（;;）结束。
（2）正则表达式中可以使用通配符。
（3）如果一个正则表达式是由多个模式组成，那么各模式之间应以 `“|”` 隔开。表示各模式是“或”的关系，即只要给定字符串与其中一个模式相匹配，就会执行其后的命令表。
（4）各正则表达式是唯一的，不应重复出现。
（5）case 语句以关键字 case 开头，以关键字 esac 结束。
（6）case 的退出（返回）值是整个结构中最后执行的那个命令的退出值。若没有执行任何命令则退出值为零

### for 语句

Shell 中有有三种用于循环的语句，它们是 for 语句、while 语句和 until 语句。 for 语句是程序设计中循环语句最常用的一个，其一般格式为：

```
for variable [in argument-list]
do
    command-list
done
```

**作用：**重复执行 command-list 中命令，执行次数与 in argument-list 中的单词个数相同。其中的 [in argument-list] 部分为可选项，由于它的不同又可以有三种形式:

#### 1. [argument-list]为变量值表

其执行过程是：变量 variable 依次取值表中各字符串，取值表中字符串的个数就决定了 for 循环执行的次数。例如：

```
for people in Debbie Tom John Kitty Kuhn
do
    echo "$people"
done
```

#### 2. [argument-list]为文件的表达式

其执行过程是：变量的值依次取当前目录（或指定目录）下与文件表达式相匹配的文件名，每取值一次，就进入循环执行命令表，直到所有匹配的文件取完为止。例如：

```
for i in *.sh
do
    cat $i | pr
done
```

其中的 `pr` 命令用于将文本转换成适合打印的文件，基本用途就是将较大的文件分割成多个页面，并为每个页面添加标题。

#### 3. [argument-list]为空

此种形式中，[argument]也可以用 $* 来代替，两者都是等价的。执行过程是变量依次取位置参数的值，然后执行循环体中的命令表，直至所有位置参数取完为止。示例：

```
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
```

### while 语句

while 语句用于根据一个表达式的条件重复执行代码块，即循环语句。其一般语法格式为：

```
while expression
do
    command-list
done 
```

**作用：**只要 expression 的值为真，则进入循环体，执行 command -lsit 中的命令，然后再做条件测试，直到测试条件为假时才终止 while 语句的执行。下面列举一个示例，判断各个位置参数是否是一个普通文件，若是则显示其内容，否则显示它不是文件名的信息：

```
#!/bin/bash

# Filename: test5-9.sh
# Author: huoty <sudohuoty@163.com>
# Script starts from here:

while [ $1 ]
do
    if [ -f $1 ]
    then echo "display: $1"
        cat $1
    else echo "$1 is not filename."
    fi
    shift
done
```

该例中巧妙的利用了 shift 命令，每读取一个位置参数后便将剩余的位置参数左移。这一编程技巧非常值得借鉴，应为在 Shell 中默认位置参数之后 10 个，如果需要获取更多的位置参数，则需要采用一些特殊的技巧。**while 的条件表达式除了可以为测试语句外，还可以是一组命令，根据命令的退出状态决定是否执行循环体**。

### until 语句

`until 语句`是另一种循环，它的语法类似与 while 语句，但在语义上有所不同。在 while 语句中，只有表达式的值为真时才执行循环体；而在 until 语句中，只在表达式为假时才执行循环体。该语句的语法格式为：

```
until expression
do
    command-list
done
```

**作用：**只要 expression 的值为假，则执行 command-list 的命令。示例：

```
#!/bin/bash

# Filename: test5-10.sh
# Author: huoty <sudohuoty@163.com>
# Script starts from here:

x=1
until [ $x -gt 10 ]
do
    echo $x
    x=`expr $x + 1`
done
```

上例主要实现循环输出 1 到 10 之间的整数。其中 x 赋值符号右边为倒引号包裹的算术表达式，expr 为数值运算符。

### break 和 continue 语句

`break` 和 `continue` 命令用于中断循环体的顺序执行。其中 break 命令将控制转移到 done 后面的命令，因此循环提前结束。continue 命令将控制转移到 done，接着再次计算条件的值，以决定是否继续循环。

#### 1. break 语句
break 命令可以从循环体中退出。其语法格式为：

> break [n]

其中 n 表示跳出几层循环。默认值是 1，表示只跳出一层循环。如果 n 为 3，则表示一次跳出 3 层循环。执行 break 时，是从包含它的那个循环体中向外跳出。示例：

```
#!/bin/bash

# Filename: test5-11.sh
# Author: huoty <sudohuoty@163.com>
# Script starts from here:

x=1
while true
do
    echo $x
    x=`expr $x + 1`
    if [ "$x" -gt 10 ]
    then break
    fi
done
```

#### 2. continue 语句

`continue` 命令跳过循环体中在它之后的语句，回到本层循环的开头，进行下一次循环。其语法格式为：

> continue [n]

其中 n 表示从 continue 语句的最内层循环向外跳出第 n 层循环，默认值为 1。示例，输出一组数，打印除了值为 3 的所有数：

```
#!/bin/bash

# Filename: test5-12.sh
# Author: huoty <sudohuoty@163.com>
# Script starts from here:

for i in 1 2 3 4 5 6
do
    if [ "$i" -eq 3 ]
    then continue
    else echo "$i"
    fi
done
```

### 算术表达式和退出脚本程序命令

与其他编程语言一样，Shell 也提供了丰富的算术表达式。

#### 1. 算术表达式

Shell 提供五种基本的算术运算：+（加）、-（减）、\*（乘）、/（除）和 %（取模）。Shell 只提供整形数的运算。其一般格式为：

> expr n1 运算符 n2

示例：

```
expr 20 - 10    # =10
expr 15 \* 15    # =225
expr 15 % 4    # =3
```

**注意：**在运算符的前后都留有空格，否则 expr 不对表达式进行计算，而直接输出它们。表示“乘”的运算符前应加一个转义符 “\*”。

#### 2. 退出脚本程序命令

在 Shell 脚本中， exit 命令是立即退出正在运行的 Shell 脚本，并设有退出值。其语法格式为：

> exit [n]

其中 n 为设定的退出值，如果未给定 n 的值，则退出状态为最后一个命令的执行状态。
