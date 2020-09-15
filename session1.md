# Session 1: Linux basics and files

## 1.1 Installing software

Package managers: apt-get,yum, etc

github -> git clone https://github.com/eead-csic-compbio/scripting_linux_shell

miniconda, etc

docker, singularity, etc

## 1.2 Linux environment and the file system

: input and commands, -h, --help, man; the home directory; ls (-a -l -lh -lrt -ad), wildcards (ls whatever*), relative paths (./ ../), the root directory, absolute paths (/, ~/); hard drives, df and mount; moving (cd DIR, cd ..). Creating, moving, renaming and copying files (touch, mv, cp, rename). Symbolic links (ln -s, unlink).

#### The terminal

Open a terminal (TODO depending of the OS or setup)
You should see a cursor and something similar to:

    username@host:~$

If you hit `Enter` several times, you should see how the previous line duplicates with every hit, and the cursor places itself after the last line.

username@host:~$
username@host:~$
username@host:~$
username@host:~$

This means that your keyboard is now bound to the terminal. In other terms, the terminal is "listening" your keyboard as an input, and you could start sending commands to it.
Usually, the first "word" that you write is a command. You intend to do something, and you use the right command to accomplish it. For example, you have just logged in the terminal, and you want to check "where" you are, that is, the current directory. To do that you use the `pwd` command:

pwd

Right after writing the command and pressing "Enter", to run the command, you should have the following output:

/home/username

Firstly, you are getting an output from the command, which is printed on your terminal. This means that besides the input (your keyboard), the terminal is also able to output text which you can read on the screen.

The `pwd` name is an abbreviation for "print working directory". Most commands use abbreviations, so that you don't need to write so much. However, this makes them not so easy to remember at first. Also, for every command there are different options, arguments or parameters to modify the way it works. Also, you could need further explanation of a command in order to fully understand it. Type:

pwd --help

You should get a list of options for the command. Many commands accept different "help" options, which allow you to see more usage info. The most common ones are --help and -h.

Let's check the current directory again:
pwd
/home/username

As you can see, we are within a directory called as our user name, and this directory is within the "home" directory. The home directory is where the user-specific directories of linux users are located. Within each user-specific directory, such user has permissions to create new directories and new files, run commands, etc. You should not be able to, for example, create a new file within the home directory of another user, except if such user, or an administrar, gives you permission for that. In general, your home directory (/home/username) is the place where you will carry out most of your work. Note also that the "home" directory (/home) it is not within any other directory. In fact yes, it is within the "root" directory (which is just "/"), from which all the other directories hang. We will ellaborate more about this "root" directory later.

Let's try other commands. First, we are going to create a directory. We can do this with the "mkdir" command:

mkdir iamz

Then, let's move within such directory. To move to another place, we use the "cd" (change directory) command:

cd iamz

Check that you changed the current directory:

pwd
/home/username/iamz

Now, let's create a few more directories within the current directory:

mkdir data
mkdir scripts
mkdir results

Also, let's create some empty files. We can do this with the "touch" command:

touch README
touch SETUP
touch dummy
touch dummy2
touch dummy3

Now that we know where we are, we want to know what it is within the current directory. We can "list" the contents of a directory with the "ls" command:

ls

And you should get as output the contents of the current directory.

You can also try running the command with other options and arguments:

ls -a (to show also the hidden files, which in linux are those prefixed with ".")
ls -l (to show the contents as a list, including further info, like permissions, sizes, dates, etc)
ls /home (to show the contents of the directory specified as argument, in this case to show the contents of the "home" directory)
ls -ld /home (to show just the info of the directory, and not its contents)

You can also combine different options. For example:

ls -lhrt (to show as a list, with sizes in "human readable format", sorted by date of modification, and from oldest to newest; respectively).

As argument you can also specify a filename, instead of a directory name. In fact, for linux it is the same, since everything on the system is considered a file, directories also. Also, using "wildcards", you can get more flexible results. For example:

ls dummy* (to list all the files starting with "myfiles" and followed by any other text).

Note that the argument of ls is a path to a file. There are different ways to specify a path. Compare the next 2 commands:

ls /home/username/iamz/data
ls data

The results are the same, because in fact we are asking to list the contents of the same path.

In the first example (ls /home/username/iamz/data) we are using what is called an absolute path. Absolute paths start always with "/", because we are giving the full path, from the root directory up to the directory which contains the file we are aiming for. With absolute paths, we can specify any file of the system, but logically sometimes the path can grow very rapidly to a very long text string.

With the second example (ls data), we are using a relative path, which means "from the place we are currently". This means that we are not using "/" to start a relative path, since instead of from the root directory, we are specifying the path from our current location.

Now lets say that we want to list the contents of a "sequences" directory within the "data" directory. From our current directory (/home/username) we would write:

mkdir sequences (to create 
ls data/sequences (as relative path)
ls /home/username/data/sequences (as absolute path)

But, what if we want to list the contents of a directory which is a level up over our current directory? That is what we did with our first example to list the /home directory fro /home/username

ls ../ (this means, go a level up)

What if we would be within the "sequences" directory, willing to list the contents of data, username, and home directories, respectively?

ls ../ (list /home/username/data from /home/username/data/sequences)
ls ../../ list /home/username from /home/username/data/sequences)
ls ../../../ (list /home from /home/username/data/sequences)

We can even go back first, to then go down again looking for a path which is "orthogonal", or in a different branch of the directory tree, in relation to the one in which we are located. For example, from the /home/username directory, try to list the "etc" directory which is within the root directory.

ls ../../etc



$PATH

## 1.3 Remote filesystems

ssh, scp, rsync


## 1.4 Working with files

Working with text files: cat, tac, head, tail (tail -n +X), more, less, grep (regular expressions), diff. Modifying text: sed, tr. Working with tabular data: column, sort, uniq, join, paste, awk. Compressing files and packing directories: gzip, gunzip, tar, zcat. Text editors: nano, vi, emacs.

.bashrc
