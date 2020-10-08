# Session 2: Processes and scripts

- [2.1 Redirections](#21-redirections)
- [2.2 Variables](#22-variables)
- [2.3 Subshells](#23-subshells)
- [2.4 Bash control statements](#24-bash-control-statements)
- [2.5 Scripting basics](#25-scripting-basics)
- [2.6 Running scripts](#26-running-scripts)


## 2.1 Redirections

So far, we have seen some example of how to redirect the output of a script to a file (`>`), to another script (`|`), or appending it to an existing file (`>>`). All of these are examples of Linux redirection, which we will further study here.

In Linux, there are 2 different channels (actually, *file descriptors*) to which the programs or scripts could send text output: the standard output (aka "stdout", which uses the *file descriptor* `/dev/stdout`) and the standard error (aka "stderr", whose *file descriptor* is `/dev/stderr`). In fact, you can use these *file descriptors* directly:

    echo "Hello" > /dev/stdout
    echo "Bye" > /dev/stderr

We are redirecting the output of the `echo` command to these stdout and stderr. As you can see, in both cases what we redirect to these files is immediately printed on the terminal.

Managing the stdout and stderr through redirections is very important in Linux, since almost every command does at least one of the following:

- Create output files with the results of running the command.
- Modify files or its properties (e.g. permissions) as the results of running the command.
- Print output to stdout (which in fact means modifying `/dev/stdout`.
- Print output to stderr (which actually means modifying `/dev/stderr`.

Or any combination of the previous ones.

Now, let's try a tiny code:

    (printf "Hello\n"; printf "Bye\n" 1>&2)

After running the previous code you should see as output:

    Hello
    Bye

Don't worry if you don't understand the previous code in detail. Just consider that it is a code which prints "Hello" to the stdout and "Bye" to the stderr.

However, it is very important to understand that the stdout is represented with the number 1, and when we redirect it to a file with `> FILE`, as we saw in session1, it is equivalent to `1> FILE`. On the other hand, the stderr is represented with the number 2, so when we want to redirect the stderr to a file we use `2> FILE`. A bit more complex: to redirect the stdout to stderr we write `1>&2`, and to redirect the stderr to stdout we write `2>&1`.

Therefore, the previous parentheses-enclosed code (technically called a *subshell*) prints text to both stdout and stderr. From outside the code, we can redirect that output in different ways:

    (printf "Hello\n"; printf "Bye\n" 1>&2) > file.out

The terminal will print:

    Bye

We have redirected the stdout to `file.out`, so when we output its contents we get:

    cat file.out
    Hello

Now, we will redirect the stderr instead:

    (printf "Hello\n"; printf "Bye\n" 1>&2) 2> file.out

The output on the screen is now:

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

And, finally, we could merge both outputs to a single file, by redirecting stdout to a file `> file.out`, and redirecting the stderr to stdout `2>&1`

    (printf "Hello\n"; printf "Bye\n" 1>&2) > file.out 2>&1

Of course, we could also redirect the stderr to a file `2> file.out`, and then redirect the stdout to stderr `1>&2`

    (printf "Hello\n"; printf "Bye\n" 1>&2) 2> file.out 1>&2

Both methods will yield the same contents in `file.out`:

    cat file.out
    Hello
    Bye

Remember also the append redirection (`>>`), synonym of `1>>`, which redirects the stdout appending its contents to a file. You can also use `2>>` to redirect the stderr appending its contents to a file:

    (printf "Hello\n"; printf "Bye\n" 1>&2) 2>> file.out
    Hello

The "Hello" appears because we didn't redirect the output from the first `printf`. Then, we print the contents of `file.out`, and "Bye" appears twice, due to the appending with `2>>`.

    cat file.out
    Hello
    Bye
    Bye

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

You can store data into variables in bash. For example:

    myvar=Hello

Note how the `=` separates the name of the variable that you choose (`myvar` in our example) and the value to store into the variable (`Hola` in our example). It is very important to note that there are no white spaces at both sides of the `=` symbol.

You can access the value of a variable with the `$` symbol:

    echo $myvar

It should print:

    Hello

However, if you want to store a text which includes white spaces, you need to use other methods. To assign the value, you need to use quotes (either single or double):

    myvar="Hello, how are you"

White spaces can also be problematic when accesing the variable contents. For example:

    dirname="my directory"
    mkdir $dirname

In this example, `mkdir` will create 2 directories! One called "my" and one called "directory". Check it out with `ls -l`. Now, try the next:

    mkdir "$dirname"

Now, `mkdir` will create a single directory called "my directory", which was our intention. Therefore, it is safier to access the content of a variable, specially leading with paths, using quotes, as in `"$dirname"`.

There is another way to access variable contents, which is using curly braces:

    echo "${dirname}"

In some cases, the code is more readable using curly braces. And in some rare cases will be safer to use "${var}" than "$var", depending on what you want to do, and how you will express it:

    dirname_second="my second dir"
    echo $dirname_second
    echo "$dirname_second"
    echo "$dirname"_second
    echo "${dirname}"_second
    echo "${dirname}_second"

Also, using curly braces allows using parameter substutition with variables:

- Printing the length of the contents of the variable: `echo ${#dirname_second}`
- Removing a pattern at the beginning of the content: `echo ${dirname@my }`
- Removing a pattern at the end of the content: `echo ${dirname% directory}`
- Replacing a pattern with another content: `echo ${dirname/ectory/_example}`
- Slicing a part of the contents: `echo ${dirname:3:5}`

And other uses: https://www.cyberciti.biz/tips/bash-shell-parameter-substitution-2.html

In summary:
- If the content you want to assign to a variable can contain white spaces, use always quotes.
- If possible, always access a variable using quotes, and even better if you also use curly braces.


Of course, besides text you can assign also numbers as the content for a variable:

    mynum=1

We can also use `let` to assign a variable using arithmetical expressions:

    let "two=$mynum + 2"

We get:

    echo $mynum
    1
    echo $two
    3

If you want to more specifically declare your variable as an integer:

    declare -i mynum
    mynum=2
    mynum="$mynum * $mynum"
    echo $mynum
    4

And we can also use double parentheses to perform arithmetic operations:

    (( mynum = 4 * 4 ))
    echo $mynum
    16

We can do these operations without assigning to any variable with `$(( ))`:

    echo $(( 4 * 4 ))
    16
    


## 2.3 Subshells

Let's back to the code from section 2.1:

    (printf "Hello\n"; printf "Bye\n" 1>&2)

We mentioned that this is a *subshell*, which is a way to run several lines of code as if it was a single command. More in detail:

- We are using the parentheses `(` and `)` to enclose 2 commands which we want to run as a single one.
- The first `printf "Hello\n"` just prints "Hello" to the stdout (which is the default output of `printf`).
- We separate both commands with `;`.
- The second command `printf "Bye\n" 1>&2` prints "Bye" to the stderr, because we use `1>&2` to redirect the stdout to the stderr.

We could add more commands within the parentheses, just separating every command of each other with `;`. It is like creating a script, but without storing the code within any file.

Moreover, with `$()` we can assign the output of a *subshell* to a variable. Try:

    subsh=$(printf "Hello\n"; printf "Bye\n" 1>&2)
    Bye
    echo "$subsh"
    Hello

Note however that we are assigning only the text from stdout.

The use of `$()` is technically called a *command substitution*, and it is also running a *subshell*, as with `()`, but in this case we can assign the output to a variable.

There is another interesting expression in bash, which is the process substitution `<()`. In this case, the result from the *subshell* will be sent to a new *file descriptor*, which we can use as a temporary file. For example, compare:

    wc file.out
    wc <(cat file.out)

You can check the path of the file descriptor being created:

    ls <(cat file.out)

This is useful to use the output of a command, which you enclose within `<()`, to another command which requires its output as a file, but you don't want to store the result of the first command as an actual file, but as a temporary file only to be used just once.

We will see more examples of *subshells*, *command substitutions* and *process substitutions* later in this course.






## 2.4 Bash control statements

if then else fi
-d -f -z -e
! && || = == -eq -ne -gt -lt -gte -lte

for in ; do done
while; do done
continue
break





## 2.5 Scripting basics

shebang. chmod. comments. input parameters. output status (exit and $?).




## 2.6 Running scripts

./script
shebang (just mention the system uses, and reference section 2.6)
chmod
export and $PATH

Ctrl+C, &, Ctrl+Z, bg, nohup, screen and tmux