# Session 2: Processes and scripts

- [2.1 Redirections](#21-redirections)
- [2.2 Variables](#22-variables)
- [2.3 Subshells](#23-subshells)
- [2.4 Bash control statements](#24-bash-control-statements)
- [2.5 A bash script primer](#25-a-bash-script-primer)
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

```
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



## 2.5 A bash script primer

Now, we have enough elements to make our own bash scripts. Here, we will cover the basics.

First, we need to create a file, our script, to write code within it. We will use the `nano` text editor to create the file.

```
cd ~/scripting
nano myscript.sh
```

We will begin with a special line, which is a *shebang*. It has to be the first line of the script, and it is telling the OS which interpreter should be use to interpret (to run) our code. As we are doing a bash script, we will write:

    #!/usr/bin/env bash

Then, we will include the code of our script, which will be very basic to begin with:


```
printf "UPPERCASE GOES TO THE STDOUT\n"
printf "lowercase goes to the stderr\n" 1>&2
printf "HERE I INCLUDE THE MAIN OUTPUT FROM MY SCRIPT\n"
printf "here I could output a warning or errors\n" 1>&2
printf "END OF THE SCRIPT\n"
printf "the script ended ok\n" 1>&2
```

Finally, we could just let the script end without an `exit` command, and it will end by default with *exit status* 0. However, it is a good practice to always include the `exit` command along with the *exit status* of our script:

    exit 0

We can save our script with `Ctrl+s` and exit with `Ctrl+x`. We can later edit the script again with `nano myscript.sh`.
Now, try to run the script:

    ./myscript.sh

You will get `Permission denied`, since we created the file, but it is without permission to execute by default. Check the permissions with `ls -l myscript.sh`:

```
-rw-rw-r-- 1 osboxes osboxes 77 Oct 10 07:52 myscript.sh
```

The owner of the file is `osboxes`, but he has not right to execute the script. To change this type:

    chmod u+x myscript.sh

And check again the permissions with `ls -l myscript.sh`:

```
-rwxrw-r-- 1 osboxes osboxes 77 Oct 10 07:52 myscript.sh
```

Now, osboxes has right to run the script. Type:

    ./myscript.sh

And you should get:

```
UPPERCASE GOES TO THE STDOUT
lowercase goes to the stderr
HERE I INCLUDE THE MAIN OUTPUT FROM MY SCRIPT
here I could output a warning or errors
END OF THE SCRIPT
the script ended ok
```

As we have seen in previous examples, we can redirect stdout and stderr to different files:

    ./myscript.sh > myscript.out 2> myscript.err

Check `cat myscript.out`:

```
UPPERCASE GOES TO THE STDOUT
HERE I INCLUDE THE MAIN OUTPUT FROM MY SCRIPT
END OF THE SCRIPT
```

Check `cat myscript.err`:

```
lowercase goes to the stderr
here I could output a warning or errors
the script ended ok
```

This is how we create a script in Linux. Later in this course we will explain more details about writing scripts in bash.







## 2.6 Running scripts

Now, we know how to run commands in the terminal, including bash scripts that we wrote our own.

It is important though to know how is determining the OS which command should actually be run.

When we write the name of command, the shell, which is the interpreter running in your terminal, looks for the command in a special variable (an environment variable) called PATH. The PATH variable stores a string, which is in fact a list of paths where the shell will look for installed programs. Check your PATH variable (you already know how to print the content of variables):

    echo "$PATH"

You will see something similar to:

/home/osboxes/miniconda3/bin:/home/osboxes/miniconda3/condabin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

This is hard to read, but you will notice that it is a list of paths, using `:` as separator. Take a look a the list, one line per path, translating `:` to `\n`:

    echo "$PATH" | tr ":" "\n"

You will get:

```
/home/osboxes/miniconda3/bin
/home/osboxes/miniconda3/condabin
/usr/local/sbin
/usr/local/bin
/usr/sbin
/usr/bin
/sbin
/bin
```

These are the locations were the shell will look for commands. In fact, you can use `which` to check the result of that search:

```
which conda
/home/osboxes/miniconda3/bin/conda
which ls
/usr/bin/ls
```

You can modify the PATH variable to add new paths to the list, so that the shell will look for commands there.

First, let's create a new script, called `wait.sh`, within our `~/scripting` directory, with the following code:

```
#!/usr/bin/env bash

while :
do
    echo "WAIT!"
    sleep 2
done

exit 0
```

After saving the script, remember to change the permissions with `chmod u+x wait.sh`. Our script `wait.sh` performs an infinite `while` loop, printing "WAIT!" every 2 seconds.

You can run it with `./wait.sh`, and interrupt it with `Ctrl+c`. The shell is able to run your script even when it is not within the paths included in the PATH variable, because you are giving the path to the script (`./wait.sh` tells to run the script called `wait.sh` which is in the current directory `./`). In fact, you should be able to run it like this, using the path to the script, from another directory:

```
cd ..
pwd
/home/osboxes
./scripting/wait.sh
```

Or

    /home/osboxes/scripting/wait.sh

However, if you try to run it as any other command it will be not found:

    wait.sh

You will get:

    wait.sh: command not found

Thus, to run it like this, we need to add the path to the directory containing the script to the PATH variable. We could do (don't do it please):

    PATH=/home/osboxes/scripting

But we will lose the previous paths of the PATH variable. Therefore, we insert or append our new path along with the previous value of the PATH variable, using the `:` as separator:

    PATH="$PATH":/home/osboxes/scripting

Now, if you did that, you should be able to run the script, just typing:

    wait.sh

If you print the content of PATH (`echo "$PATH"`) you should see now your path along with the others.

However, every time that you login again into the shell (every time you open a terminal) you will have again the original PATH variable, and you will need to add again the path of your script to the PATH variable. However, there are user-specific scripts which are run every time a terminal is open by that user. You can edit those files, to add the paths you may want to the PATH variable. For example, open the `/home/osboxes/.bashrc` file:

    nano ~/.bashrc

Go to the end of the script and add a new line with:

    PATH="$PATH":/home/osboxes/scripting

Save the file and exit nano. Exit from the terminal with `exit`, and open a new terminal. Right after opening the terminal, you should be able to run `wait.sh`.
However, you will often see that this is done using the `export` command:

    export PATH="$PATH":/home/osboxes/scripting

You should be fine with either choice. Just be aware that you will find examples using both. For further info check https://unix.stackexchange.com/questions/138504/setting-path-vs-exporting-path-in-bash-profile



Now, open the terminal and run the script `wait.sh` and keep it running. It will print:

```
WAIT!
WAIT!
WAIT!
...
```

We already know that we can interrupt the script using `Ctrl+c`. There is also a way to just pause the script, which is `Ctrl+z`. Try it, and the type:

    jobs

You will see:

    [1]+ Stopped wait.sh

Your script is still there, but it is stopped, and no output ("WAIT!") is being output. You also have control of the terminal again, so you could run other commands. How do you resume the script? Type:

    fg

And the script will run in "forward" again, that is, it will output "WAIT!" and you will not be able to input new commands. Now, there is a way to have your script running in the background, so that you get again the control of the terminal to input commands. Pause your script again with `Ctrl+z` and then type:


    bg

You will see how the script prints again "WAIT!" to the terminal, so it is running, but you are able to input commands: the script is running in the background. You could again put the script to "forward" with `fg`, to be able to stop it with `Ctrl+c`.

As you can see, when you run a script in the background it is not confortable to have the output on the screen. Therefore, it is better if you redirect the output to a file, so that the script runs in the background and you can type new commands without ease:

    wait.sh > /dev/null
    Ctrl+z
    bg
    jobs

You should see:

    [1]+ Running wait.sh > /dev/null &

Now you could cancel the job by using `fg` and `Ctrl+c`, or directly using the `kill` command:

    kill %1

There is also a way to run a command directly on the background, which is appending `&` to the end of the command line:

    wait.sh > /dev/null &

You will see:

    [1] 4222

Which are the job number (1) and the process ID (4222). You could also use the PID to kill the job:

    kill 4222


However, what happens to a command running on the background when the terminal is closed. The process is usually terminated even if it is running on the background. This is important, specially when you are working in remote computers in which you want to run commands, exit, and come back once the process has ended. There are several ways to run a process on the background and avoid it being killed.

One method is using the `nohup` command:

    nohup wait.sh

In this case, the output of `wait.sh` will be redirected to a file called `nohup.out`, and `nohup` itself will be running on the foreground, so that you cannot enter new commands. However, you can run `nohup` on the background itself. Cancel the previous command (`Ctrl+c`), and type:

   nohup wait.sh &

Now, you will be able to type other commands into the terminal, while the `nohup` command keeps running, and so it is the `wait.sh` command. Use the `tail -f` command to check how the output from `wait.sh` is being generated in the `nohup.out` file:

    tail -f nohup.out

You can cancel the `tail`, once more, with `Ctrl+c`.

There is an even more advanced way to run our commands so that we can exit from the terminal and leave the commands running. This is using *terminal multiplexers* like `screen` or `tmux`. We are going to see a very simple example using `tmux`, but notice that both `screen`, `tmux`, and other software alike has a lot of useful possibilities, like using several windows, several tabs, splitting the window into panes, switching sessions, etc.

First, let's install `tmux`, which is not included in the osboxes VM. You will remember from a previous lesson that we can install software using `apt` (similar to `apt-get`):

    sudo apt install tmux

Type your password (osboxes.org), and type "Y". Once the software is installed, let's create first a session. We can do that using the `new` command of `tmux`, and giving a name to the new session with `-s` followed by the new name:

    tmux new -s mysession

You will be automatically *attached* to such session. Run our script

    wait.sh

Now, press `Ctrl+b`, release and then just press `d`. You will go back to your previous terminal, and will see something similar to:

    [detached (from session mysession)]

You have *detached* from the session. However, the session is still there:

    tmux ls

You will get:

    mysession: 1 windows (created Sat Oct 10 12:00:00 2020)

Let's attach to the session again. You can do that with the `attach` command of `tmux`, and the `-t` argument followed by the session name:

    tmux -t mysession

You should see your "WAIT!" output from you script still running! You can even exit the terminal, open the terminal and re-attach, and it will keep running:

    Ctrl+b, then d
    exit
    Ctrl+Alt+t
    tmux attach -t mysession

However, this is not magic. If you shutdown the computer where the command is running (where you opened the tmux session), the command will die, of course. Note however, that if you open a terminal, connect through `ssh` to a remote computer, open a tmux session, run a command, detach, exit from the terminal and shutdown the computer, the server will keep running. Therefore, you can use `tmux` sessions to run remote jobs, so that those jobs keep running unless the remote computer is shutdown (which is not the usual thing for computer servers).

Finally, by detaching you "leave" the session temporarily. However, sometimes you just want to definitely end the session. To do that, end the tmux session, so that it will not exist anymore, from the terminal within the tmux session just type:

    exit


