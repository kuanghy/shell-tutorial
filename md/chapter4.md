Shell 程序设计教程
==================

## Shell 编程中的输入输出命令

计算机都能执行输入、处理和输出的基本操作过程。而 UNIX/Linux 下的典型命令则包含执行输入输出的的基本操作。

### Shell 中输入输出的标准文件

Linux/UNIX 中每个命令以进程的方式运行，而每个进程运行时自动打开三个文件，这写文件称为命令的标准文件，分别用于命令读取输入、输入结果以及输出错误信息，即标准输入文件（stdin）、标准输出文件（stdout）、标准错误输出文件（stderr）。这些文件与执行命令的终端关联。更明确的说，键盘是标准输入，显示器是标准输出和标准错误输出。因此，默认情况下，每条命令都是从键盘读取输入，并将输出和错误信息发送到显示屏上。通过使用 Linux/UNIX 中文件重定向命令，可以将命令的输入、输出以及错误信息重定向到其他文件中，这就可以将多个命令组合起来，以完成单个命令不能完成的复杂任务。

### Shell 的输入输出重定向命令

#### 1. 输入重定向命令

输入重定向是通过使用小于号 `“<”` 来实现的。它的作用是解除键盘作为命令 “command” 的标准输入，并将文件 “input-file” 作为命令的输入源。这样，命令 “command” 读取的输入来自文件 “input-file”, 而不是与命令运行终端相连接的键盘。命令被 Shell 解释执行后，输出到显示器 “monitor” 上。如下图所示：

![输入重定向](http://ww1.sinaimg.cn/mw690/c3c88275jw1evf6xnq40fj20e3039weq.jpg)

其使用格式为：

> command < input-file

#### 2. 输出重定向命令

输出重定向通过使用大于号 `“>”` 来实现。该语法用于将命令 “command” 的输出重定向到文件 “output-file” 上以取代显示屏。如下图所示：

![输出重定向](http://ww1.sinaimg.cn/mw690/c3c88275jw1evf6xnhju2j20ee03g3yt.jpg)

其使用格式为：

> command > output-file

#### 3. 输出附加定向命令

输出附加定向命令通过使用两个大于号 `“>>”` 来实现。它的作用是把命令（或执行程序）的输出附加到指定文件的后面，文件原有内容不被破坏。其格式为：

> command >> output-file

#### 4. 标准错误重定向命令

标准错误重定向使用操作符 `“2>” `，对命令的错误进行重定向，将产生的错误消息发送到文件中，命令的输入也可以是命令行参数所指定的文件。其一般格式为：

> command 2> error-file

在 Shell 编程的过程中，可以混合的使用输入输出重定向命令，从而实现一些特定复杂的功能。

### Shell 的输入输出命令

Shell 的输入输出命令最常用的两个是 `read` 和 `echo`。echo 作为向屏幕输出信息的工具应用比较多，read 主要用于读取用户输入。

#### 1. read 命令

`read` 命令是标准的输入命令，可以利用 read 命令从标准输入读取数据，然后赋值给指定的变量。其一般格式为：

> read 变量1 [变量2] ...

利用 read 命令可以交互地为变量赋值。输入数据时，数据间以空格或制表符作为分隔符。若变量个数与给定数据个数相同，则一次对应赋值。若变量个数少于数据个数，则将剩下的数据全部赋给最后一个变量。若变量个数多于给定的数据个数，则多余的变量就被赋值为空串。示例：

```
#!/bin/bash

# Filename: test4-1.sh
# Author: huoty <sudohuoty@163.com>
# Script starts from here:

read n1 n2
# Input: a b <回车>

read na nb
# Input: First Second Third <回车>

read a b c 
# Input: 1 2 <回车>
```

#### 2. echo 命令

`echo` 命令是将其后的参数在标准输出上输出，个参数间以空格隔开，以换行符终止。如果数据间保留对个空格，则要用单引号或双引号把它们括起来，通常，最好用双引号把所有参数括起来，这样不仅易读并且能使 Shell 对它们进行正确的解释。

`echo`参数中有一些特殊字符，用于输出控制或者打印出无法显示的字符，如下表所示：

<table border="1">
<caption>echo 命令使用的特殊字符</caption>
<tr><th>字符</th><th>含义</th></tr>
<tr><td>\b</td><td>退格</td></tr>
<tr><td>\c</td><td>不将光标移动到下一行</td></tr>
<tr><td>\f</td><td>换页</td></tr>
<tr><td>\n</td><td>换行（光标移到下一行）</td></tr>
<tr><td>\r</td><td>回车</td></tr>
<tr><td>\t</td><td>水平制表符</td></tr>
<tr><td>\</td><td>垂直制表符</td></tr>
<tr><td>\\</td><td>转义符</td></tr>
<tr><td>\ON</td><td>ASCII码为八进制 N 的字符</td></tr>
</table>

下面是一个 read 和 echo 的综合例子：

```
#!/bin/bash

# Filename: test4-2.sh
# Author: huoty <sudohuoty@163.com>
# Script starts from here:

echo "Enter input: \c"
read line
echo "You entered: $line"
echo "Enter another line: \c"
read word1 word2 word3
echo "the first words is: $word1"
echo "the second word is: $word2"
echo "the rest words is: $word3"
exit 0
```