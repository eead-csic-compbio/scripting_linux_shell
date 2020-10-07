# Session 2: Processes and scripts

- [2.1 Redirections](#21-redirections)
- [2.2 Variables](#22-variables)
- [2.3 Subshells](#23-subshells)
- [2.4 Running scripts](#24-running-scripts)
- [2.5 Bash control statements](#25-bash-control-statements)
- [2.6 Scripting basics](#26-scripting-basics)


## 2.1 Redirections

So far, we have seen some example of how to redirect the output of a script to a file (`>`), to another script (`|`), or appending it to an existing file (`>>`). All of these are examples of Linux redirection, which we will further study here.

In Linux, there are 2 different channels (actually, *file descriptors*) to which the programs or scripts could send text output: the standard output ("stdout") and the standard error ("stderr"). In fact, you can use these *file descriptors* directly:

    echo "Hello" > /dev/stdout
    echo "Bye" > /dev/stderr

We are redirecting the output of the `echo` command to these stdout and stderr. As you can see, in both cases what we redirect to these files is immediately printed on the terminal.

Now, let's try a small code which prints text to both stdout and stderr:

    (printf "Hello\n"; printf "Bye\n" 1>&2)

After running the previous code you should see as output:

    Hello
    Bye

Don't worry if you don't understand the previous code in detail. Just consider it as a code which you run, and prints "Hello" to the stdout and "Bye" to the stderr. However, it is very important to understand that the stdout is represented with the number 1, and when we redirect with `>`, as we saw in session1, it is the same as if we would use `1>`. On the other hand, the stderr is represented with the number 2, so when we want to redirect the stderr we use `2>`. A bit more complex, to redirect the stdout to stderr we write `1>&2`, and to redirect the stderr to stdout we write `2>&1`.

Nonetheless, we give a brief explanation of the previous code:

- We are using the parentheses `(` and `)` to enclose 2 commands which we want to run as a single one.
- The first `printf "Hello\n"` just prints "Hello" to the stdout (which is the default output of `printf`).
- We separate both commands with `;`.
- The second command `printf "Bye\n" 1>&2` prints "Bye" to the stderr, because we use `1>&2` to redirect the stdout to the stderr.

Therefore, the previous parentheses-enclosed command (technically called a *subshell*) prints text to both stdout and stderr, and we can redirect that output in different ways:

    (printf "Hello\n"; printf "Bye\n" 1>&2) > file.out

The terminal will print:

    Bye

We have redirected the stdout to `file.out`, so when we output its contents we get:

    cat file.out
    Hello

Now, we will redirect the stderr instead:

    (printf "Hello\n"; printf "Bye\n" 1>&2) 2> file.out

The output now is:

    Hello

And the content of the file is:

    cat file.out
    Bye

We can also redirect both outputs to different files, so that we can later check what was the result of the command:

    (printf "Hello\n"; printf "Bye\n" 1>&2) > file.out 2> file.err
    cat file.out
    Hello
    cat file.err
    Bye

And, finally, we could merge both outputs to a single file in different ways:

- Redirecting stdout to a file `> file.out`, and redirecting the stderr to stdout `2>&1`

    (printf "Hello\n"; printf "Bye\n" 1>&2) > file.out 2>&1

- Redirecting stderr to a file `2> file.out`, and redirecting the stdout to stderr `1>&2`

    (printf "Hello\n"; printf "Bye\n" 1>&2) 2> file.out 1>&2

Both methods will yield the same contents in `file.out`:

    cat file.out
    Hello
    Bye


Remember also the append redirection `>>`, which is in fact a synonym of `1>>`, that is, redirect the stdout appending to a file. You can also use `2>>` to redirect the stderr appending to a file:

    (printf "Hello\n"; printf "Bye\n" 1>&2) 2>> file.out
    Hello # we didn't redirect this
    cat file.out
    Hello
    Bye
    Bye # appended using `2>>`

Note also that when we use the pipe `|` to redirect the output of a command as input of another, what we are redirecting by default is just the stdout, not the stderr:

    (printf "Hello\n"; printf "Bye\n" 1>&2) | awk '{printf "awk input was --> "$0}'
    Bye
    awk input was --> Hello

However, we can also change this:

    (printf "Hello\n"; printf "Bye\n" 1>&2) 2>&1 | awk '{printf "awk input was --> "$0}'
    awk input was --> Hello
    awk input was --> Bye

Besides `/dev/stdout` and `/dev/stderr` there are other especial files in Linux we are very useful. One of them is `/dev/null`, which will be always empty. In fact, we can use this to redirect to it any output that we just want to discard, so that it will end nor in a file either on the screen:

    (printf "Hello\n"; printf "Bye\n" 1>&2) 2>&1 1> /dev/null | awk '{printf "awk input was --> "$0}'
    awk input was --> Bye

As you can see, the "Hello" text was discarded, by sending the stdout to the null file with `1> /dev/null`.

Finally, there is another kind of redirection, which is `<`. It is the "Input redirection", represented with the number 0 and corresponding to the file `/dev/stdin`. When you use `<` and a filename, the contents of the file will be copied to `/dev/stdin` from which the commands can take input when no other input source is specified. For example:

    cat file.out

Here we are telling `cat` to open `file.out` and use it as input. Compare it with:

    cat <file.out

Here, the *shell* is opening the file, copying its contents to the stdin, and `cat`, which did not received a file as parameter in this case, will read from the stdin. In this case the result will be the same, which is output the contents of `file.out`. However, note the next difference:

    cat file.out | awk '{print $0}'

And:

    awk '{print $0}' < file.out

In the first case we use 2 commands, `cat` and `awk`, and use the pipe to redirect the output of `cat` to `awk`. In the second example only one command is involved, `awk`, which we use to process the stdin, after redirecting the contents of `file.out` to stdin. This could make a difference, for example, when processing a large file.

You can also experiment *live* how `cat` reads from stdin, by typing just:

    cat

The command receives not input, either as a filename or as input redirection, and thus will constantly read from `/dev/stdin` to output its contents. You can try: anything you type, it is output to the screen. You can cancel the command with `Ctrl+c`. You could even use as a very simple text editor, to create a file on the fly:

    cat > onthefly.out

Write anything, cancel with `Ctrl+c`, and then check the contents of `onthefly.out`:

    cat onthefly.out

It should show on the screen what you just wrote.





## 2.2 Variables

var=, ${var}, 





## 2.3 Subshells


(), var=$(), let var=

arithmetic (( ))




## 2.4 Running scripts

./script
shebang (just mention the system uses, and reference section 2.6)
chmod
export and $PATH

Ctrl+C, &, Ctrl+Z, bg, nohup, screen and tmux



## 2.5 Bash control statements

if then else fi
-d -f -z -e
! && || = == -eq -ne -gt -lt -gte -lte

for in ; do done
while; do done
continue
break





## 2.6 Scripting basics

shebang. chmod. comments. input parameters. output status (exit and $?).
