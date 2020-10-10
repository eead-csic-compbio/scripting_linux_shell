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

So far, we have seen how to run commands in different ways, and even combinations of several commands, either using the pipe `|` or using *subshells*. We have also seen how to use variables.

Sometimes, we need to run a command or use a variable only if a specific condition is met. On other occasions, we need to run a command several times, for example changing the input or the parameters in each iteration. In this section, we will see how to achieve this in bash.

First, create a new directory within the `scripting` directory:

```
mkdir -p ~/scripting/control_sts
cd ~/scripting/control_sts
```

when we want to check if a condition is met, we use the `if then else fi` statements. The key element of this is how we check the condition that we want to assess. For example, we can remove a file, only if the file exists:

```
if [ -e myfile ]; then
    echo "FILE EXISTS";
else
    echo "file doesn't exist";
fi;
```

You will get:

    file doesn't exist

In the first line, we have the `if` with the condition to be checked. The condition has to be enclosed within `[` and `]`, and it will be an statement returning either *true* or *false* (i.e. it is a boolean value). In our example, the condition is `-e myfile`, which is using a bash *file test operator* used to check if a file exists. If the file does exist, `-e myfile` will yield *true*, and the `echo "FILE EXISTS"` command will be run. If the file does not exist, `-e myfile` will yield *false*, and the command under the `else` will be run: `echo "file doesn't exist" in our example.

Now try to create the file and see what happens:

```
touch myfile
if [ -e myfile ]; then
    echo "FILE EXISTS";
else
    echo "file doesn't exist";
fi;
```

You should get:

    FILE EXISTS

We will not go further into *file test operators* in this lesson, but you should be aware that there are operators to check if a file exists (`-e`), if the file is an actual file (`-f`) or a directory (`-d`), and others which you can check at https://tldp.org/LDP/abs/html/fto.html.

You can add more conditions to a single `if` block, to have more alternatives, using the `elif` word:


```
if [ -e nonexistingfile ]; then
    echo "NON EXISTING ACTUALLY EXISTS";
elif [ -e myfile ]; then
    echo "myfile DOES exist"
else
    echo "none of them exist
fi;
```

You will get:

    "myfile DOES exist"

because `nonexistingfile` does not exist and then the second condition `elif [ -e myfile ];` is assessed.

You can use `if` statements to check any condition you may need. For example, to compare 2 different values:

```
if [ 1 -eq 1 ]; then
    echo "equal";
else
    echo "different";
fi;
```

Besides the `-eq` to check if 2 values are the same, you can use other operators for comparison, including:

- `a -eq b`: *true* if a is equal to b
- `a -gt b`: *true* if a is greater than b
- `a -ge b`: *true* if a is greater or equal than b
- and other operators that you may check at https://tldp.org/LDP/abs/html/comparison-ops.html

You can also check different conditions at once using compound comparisons. For example, use `&&`, the *and* boolean operator, to check if 2 conditions are both true:

```
if [ 1 -eq 1 ] && [ 2 -eq 2 ]; then
    echo "both are equal";
fi;
```

Which is the same as using `-a`:

```
if [ 1 -eq 1 -a  2 -eq 2 ]; then
    echo "both are equal";
fi;
```

To check if at least one of the conditions is true, you can use `||`, the *or* boolean operator:

```
if [ 1 -eq 2 ] || [ 10 -eq 10 ]; then
    echo "at least one is equal";
fi;
```

Or using `-o`:

```
if [ 1 -eq 2 -o 10 -eq 10 ]; then
    echo "at least one is equal";
fi;
```

You can also use the `!` operator, *not* boolean operator, to check if a condition is *not true*:

```
if [ ! 1 -eq 2 ]; then
    echo "not equal"
fi;
```

You can also compare strings, or variables containing strings:

```
user_continent="Europe"
if [ "$user_continent" = "Europe" ]; then
    echo "User is from Europe";
elif [ "$user_continent" = "Africa" ]; then
    echo "User is from Africa";
else
    echo "User is not from Europe or Africa";
fi;
```

We can also use the `if` statements to check the outcome of commands. If the command returns 0, the condition is considered *true*, whether if a command returns value different to 0 the condition is considered *false*. For example, our `myfile` file is empty. Thus, if we search a pattern with grep we will find nothing. `grep` returns a 0 when the pattern is found and 1 if the pattern is not found. Therefore:

```
if grep "any" myfile; then
    echo "any found in myfile";
else
    echo "grep found nothing";
fi;
```

It should output:

    grep found nothing

Actually, every command in Linux returns an *exit stats* value, which is usually 0 if the command was successful, or a value greather than 0 if something went wrong. Note that the definition of success or error depends on the specific command. As we have seen, for `grep` success means pattern found. Importantly, besides check directly the command within an `if` condition statement, we can directly retrieve the exit status of the last command run through the special variable `$?`:

```
grep "any" myfile
status=$?
echo "$status"
if [ "$status" -eq 0 ]; then
    echo "command successful"
else
    echo "command returned $status"
fi;
```

Another widely used trick, implicitly using the *exit status*, is running a command only if the previous one was successful using `&&` between commands in a *one-liner*:

```
grep "any" myfile && rm myfile
```

The previous *one-liner* will delete `myfile` only if the `grep` finds the pattern "any" within it.



Now, let's move to other control statements. In this case, those allowing us to run a given block of code any number of times (yes, from 0 to infinite). These control statements are often called just *loops*. 

The `for` loop allows itering over a list of elements, keeping track of the current element on a variable, so that we can use such variable within the code block to be run. For example:

```
for animal in cat dog human; do
    echo "$animal";
done
```

You will get:

```
cat
dog
human
```

We can use this to iterate over any list of elements:

```
for current in $(ls /); do
    echo "$current";
done
```

The previous command will obtain the list of files within the root directory (`ls /`), and will create a list with it using command substitution `$(ls /)`. This list is iterated and each filename printed (`echo "$current"`).

The `for` loop will end once that the list of elements has been iterated over completely. However, there are ways to exit from a loop before the end of the list, using the `break` command:

```
for current in $(ls /); do
if [ "$currentfile" = "etc" ]; then
    break
else
    echo "$currentfile";
fi;
done
```

The previous code will `echo` the name of files until a file called `etc` is found, using the `break` command at that point to end prematurely the loop.

There is another special word, `continue`, in this case to just "jump" to the next item in the iteration:

for current in $(ls /); do
if [ ! "$currentfile" = "tmp" ]; then
    continue
else
    echo "$currentfile";
    break;
fi;
done
```

In this latter case, if the current file is not "tmp", just go to the next element of the list. Only the "tmp" file will be printed, and once this happens the `break` command interrupts the loop, so that no more iterations are carried out.


The `while` loop does not use a list of elements, but instead a condition (as the conditions used in the `if` statements). Therefore, the `while` loop will keep running while the condition is *true*, whereas it will finish once the condition is *false*. We can use this even to create a *infinite loop*, which will never end unless we stop it pressing `Ctrl+c`:

```
while [ 1 -eq 1 ]; do
    echo "loop";
    sleep 1;
done
```

The previous loop will keep printing "loop" while `1 -eq 1` is true, that is, forever. The `sleep 1` just makes the loop "freeze" 1 second, before the next iteration is run. This is a kind of abstract example, but you will see later in this course other uses of the `while` loop, including parsing text files.

There is another loop in bash, `until`, which is conceptually similar to `while` and we will not cover here. Check more info about these loops at https://tldp.org/LDP/abs/html/loops1.html



## 2.5 Scripting basics

shebang. chmod. comments. input parameters. output status (exit and $?).




## 2.6 Running scripts

./script
shebang (just mention the system uses, and reference section 2.6)
chmod
export and $PATH

Ctrl+C, &, Ctrl+Z, bg, nohup, screen and tmux