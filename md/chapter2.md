Shell 程序设计教程
==================

## Shell 变量

与其他高级语言一样，Shell 支持自定义变量。Shell 的变量类型有两种，即 Shell 环境变量（Shell Enviroment Variable）和用户自定义变量（User Define Variable）。

### Shell 的环境变量

Shell 环境变量的作用是定制 Shell 的运行环境，并保证 Shell 命令的正确执行。它又分为可写和只读两大类。

#### 可写的环境变量

可写的环境变量可以对其进行赋值操作，大部分可写的 shell 环境变量都在登录过程中执行 `“/etc/profile”` 文件时进行初始化。该文件在用户登录时，被系统自动执行，为所有用户设置公共的工作环境。用户也可以通过修改自己主目录下的 `.profile` 或 `.bash_profile` 中的部分变量值来定制自己的运行环境。以下列出部分可写的环境变量：

**BASH** 展开为调用bash实例时使用的全路径名
**CDPATH** cd命令的搜索路径。它是以冒号分隔的目录列表，shell通过它来搜索cd命令指定的目标目录。
**EDITOR** 内置编辑器emacs、gmacs或vi的路径名
**ENV** 每一个新的bash shell(包括脚本)启动时执行的环境文件。通常赋予这个变量的文件名是.bashrc。
**EUID** 展开为在shell启动时被初始化的当前用户的有效ID
**GROUPS** 当前用户所属的组
**HISTFIL**E 指定保存命令行历史的文件。默认值是~/.bash_history。如果被复位，交互式shell退出时将不保存命令行历史
**HISTSIZE** 记录在命令行历史文件中的命令数。默认是500
**HOME** 主目录。未指定目录时，cd命令将转向该目录
**IFS** 内部字段分隔符，一般是空格符、制表符和换行符，用于由命令替换，循环结构中的表和读取的输入产生的词的字段划分
**LANG** 用来为没有以LC_开头的变量明确选取的种类确定locale类
**OLDPWD** 前一个工作目录
**PATH** 命令搜索路径。一个由冒号分隔的目录列表，shell用它来搜索命令。
**LD_LIBRARY_PATH** 库文件搜索路径。在执行程序是会自动到该变量设置的路径下搜索库文件。
**PPID** 父进程的进程ID
**PS1** 主提示符串，默认值是$
**PS2** 次提示符串，默认值是>
**PS3** 与select命令一起使用的选择提示符串，默认值是#?
**PS4** 当开启追踪时使用的调试提示符串，默认值是+。追踪可以用set –x开启
**PWD** 当前工作目录。由cd设置
**RANDOM** 每次引用该变量，就产生一个随机整数。随机数序列可以通过给RANDOM赋值来初始化。如果RANDOM被复位，即使随后再设置，它也将失去特定的属性
**REPLY** 当没有给read提供参数时设置
**SHEL**L 当调用shell时，它扫描环境变量以寻找该名字。shell给PATH、PS1、PS2、MAILCHECK和IFS设置默认值。HOME和MAIL由login(1)设置
**SHELLOPTS** 包含一列开启的shell选项，比如braceexpand、hashall、monitor等
**UID** 展开为当前用户的用户ID，在shell启动时初始化

这里重点讲解一下 `PATH` 和 `LD_LIBRARY_PATH` 环境变量，这两个变量是在我的工作经历中用的最多的，如果在 Linux 下进行工作，就不可避免的会用到这两个变量。其他变量也并非不重要，有的使用频率也很高，只是相对来说 PATH 和 LD_LIBRARY_PATH 的实用性很强。**PATH** 用于保存可执行文件的搜索路径，在该变量中的目录下的可执行程序可以直接执行。**LD_LIBRARY_PATH** 用于保存库文件的搜索路径，在 Linux 中通常把很多程序都会用到的通用的库文件方法一些固定的目录下，程序运行时再到这些目录中去搜索加载库文件。在工作，我通常需要编译统一软件的多个版本，并且同时放到系统中运行。这个时候，如果将多个版本都直接安装到系统指定的目录中，则会引起混乱，或者覆盖之前的版本。所以 `PATH` 和 `LD_LIBRARY_PATH` 环境变量就起到了作用，你可以将不同的版本安装到不同的目录下，然后将它们的可执行文件路径和库文件路径添加到 PATH 和 LD_LIBRARY_PATH 变量中。在做嵌入式的开发中，配置交叉编译工具时，也会用到这两个变量。

环境变量一般都是大写的，系统启动后自动加载，可写的环境变量用户也可以随时进行修改。查看环境变量时，可以在变量名前加上美元符号 `$`，然后再用 echo 打印, 例如：

> echo $PS1

输出结果：

\[\033[01;32m\]\u\[\033[01;31m\]$\[\033[01;36m\][\W]\[\033[01;32m\] ->\[\033[00m\]

这是我的终端提示符样式，我在 `～/.bashrc` 文件中对其进行了设置。

#### 只读的环境变量
只读的 Shell 环境变量意味着用户能使用和读取它们的值，而不能对他们进行修改。只读的 Shell 环境变量有两种：一种是特殊的环境变量，另一种是位置参数。

**（1）特殊环境变量**

特殊的环境变量是系统预先定义好的，用户不能重新设置，常见的只读环境变量如下所示：

$0：当前脚本的文件名
$num：num为从1开始的数字，$1是第一个参数，$2是第二个参数，${10}是第十个参数
$#：传入脚本的参数的个数
$*：所有的位置参数(作为单个字符串)
$@：所有的位置参数(每个都作为独立的字符串)。
$?：当前shell进程中，上一个命令的返回值，如果上一个命令成功执行则$?的值为0，否则为其他非零值，常用做if语句条件
$$：当前shell进程的pid
$!：后台运行的最后一个进程的pid
$-：显示shell使用的当前选项
$_：之前命令的最后一个参数

**（2）位置参数**

用于处理命令行参数（Command Lines Argument），出现在命令行上的位置确定的参数称作位置参数（Positon Argument），也就是在命令行传递给 Shell 脚本的参数。

在 Bash 中总共有十个位置参数，其对应的名称一次是 $0, $1, $2, $3, $4, $5, $6, $7, $8, $9。其中 $0 始终表示命令名或者 Shell 脚本名，对于一个名行，必然有命令名，也就必有 $0；而其他位置参数依据实际需求，可有可无。

- 输出位置参数:

可以用 echo 命令输出位置参数。如下例所示：

```
#!/bin/bash

# Filename: test2-1.sh
# Author: huoty <sudohuoty@163.com>
# Script starts from here:

echo $1 $2 $3 $4 $5 $6 $7 $8 $9 $0
```

执行该脚本：

> sh test2-1.sh a b c d e f g

输出：

a b c d e f g test2-1.sh

- 用 set 命令给位置参数赋值

除了 $0 不能用 set 赋值外，其他位置参数都能用 set 对其手动赋值。示例：

```
#!/bin/bash

# Filename: test2-2.sh
# Author: huoty <sudohuoty@163.com>
# Script starts from here:

echo $1 $2 $3
set m1 m2 m3
echo $1 $2 $3
```

运行脚本：

> sh test2-2.sh a1 a2 a3

输出：

a1 a2 a3
m1 m2 m3

- 移动位置参数

在 Shell 中规定，位置参数最多不能超过 9 个，即 $1 ~ $9。如果实际给定的命令行参数多于 9 个，就需要用 shift 命令移动位置参数。执行一次 shift 命令，就把诶之参数整体向左移一位，即原来 $1 的值被移走了，新 $1 的值是原来 $2 的值，新 $2 的值是原来 $3 的值，依次类推。Shitf 命令不会将 $0 移走，所以经 shitf 左移参数后，$1 不会取代 $0 的值。Shift 命令可以带有一个整数作为参数，该参数表示一次左移的位数，若果未带参数，则默认值为1。如下示例所示：

```
#!/bin/bash

# Filename: test2-3.sh
# Author: huoty <sudohuoty@163.com>
# Script starts from here:

echo $0 $1 $2 $3 $4 $5 $6 $7 $8 $9 $#
shift
echo $0 $1 $2 $3 $4 $5 $6 $7 $8 $9 $#
shift 5
echo $0 $1 $2 $3 $4 $5 $6 $7 $8 $9 $#
```

执行脚本：

> sh test2-3.sh a b c d f g h i j k

输出结果:

test2-3.sh a b c d f g h i j 10
test2-3.sh b c d f g h i j k 9
test2-3.sh h i j k 4

### Shell 的用户自定义变量

Shell 编程中允许用户自定义变量，变量拥有临时的存储空间，在程序执行过程中其值可以改变，这些变量可以被设置为只读，也可以传递给定义他们的 Shell 脚本中的命令。Shell 中的变量无需声明和初始化，一个未初始化的 Shell 变量，其默认的初始化值为空字符串。

用户自定义变量的命名只要是合法的标识符即可，且区分大小写，变量名的长度不收限制。定义变量名并赋值的形式有以下几种：

（1）字符串赋值，其格式为：

> 变量名=字符串

例如：`mydir=/home/a`，其中，“mydir”是变量名，“=”是赋值符号，字符串“/home/a”是赋予的值。变量的值可以改变，秩序利用赋值语句重新给它赋值即可。**注意：**再赋值语句中，赋值符号的两边没有空格，否则在执行时会引起错误。

在程序中，变量的使用方式是再变量名前加上符号 `$`。该符号告诉 Shell 要取出其后变量的值。示例：

> $ mydir=/home/a

> $ echo $mydir

> mydir=/home/a

> $ echo mydir

> mydir

以上演示结果显示，如果不加 `$` 就如法引用变量的值。

（2）如果再赋值给变量的值中含有空格、制表符或者换行符，那么就应该用双引号把这个字符串括起来。例如：myname="Huoty Kong"，如果没有用引号括起来，则 myname 的值就是 Huoty。

（3）变量值可以作为某个长字符串中的一部分，如果它在长字符串的末尾，就可以利用直接引用形式。变量名出现在一个长字符串的开头或者中间，应该用`"{}"` 把变量名括起来。示例：

```
#!/bin/bash

# Filename: test2-1.sh
# Author: huoty <sudohuoty@163.com>
# Script starts from here:

s1=ing
echo walk$s1 or read$s1 or sleep$s1
dir=/home/huoty/
echo ${dir}m1.c
```

使用不带参数的 `set` 命令可以显示可以显示所有 Shell 变量（包括环境变量和用户自定义变量）名以及它们的当前值。Set 命令也可以用于改变一些只读 Shell 环境变量的值。对用户自定义变量使用 `readonly` 命令，可以将变量定义为只读变量，只读变量的值不能被改变。定义好的变量也可以使用 `unset` 命令进行删除。示例：

```
#!/bin/bash

# Filename: test2-1.sh
# Author: huoty <sudohuoty@163.com>
# Script starts from here:

myEmail="huoty@gmail.com"
echo $myEmail
unset myEmail
echo $myEmail

myUrl="http://kuanghy.github.io/"
echo $myUrl
readonly myUrl
myUrl="http://kuanghy.github.io/kswd"
```

运行时会出现如下错误：

test2-5.sh: 15: test2-5.sh: myUrl: is read only

