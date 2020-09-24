# Session 1: Linux basics and files

- [1.1 Linux environment and the file system](#11-linux-environment-and-the-file-system)
	- [The terminal](#the-terminal)
- [1.2 Installing software](#12-installing-software)
	- [The apt package manager in Ubuntu](#the-apt-package-manager-in-ubuntu)
	- [The conda manager](#the-conda-manager)
- [1.3 Working with files](#13-working-with-files)
- [1.4 Remote filesystems](#14-remote-filesystems)


## 1.1 Linux environment and the file system

<!-- : input and commands, -h, --help, man; the home directory; ls (-a -l -lh -lrt -ad), wildcards (ls whatever*), relative paths (./ ../), the root directory, absolute paths (/, ~/); hard drives, df and mount; moving (cd DIR, cd ..). Creating, moving, renaming and copying files (touch, mv, cp, rename). Symbolic links (ln -s, unlink). -->

### The terminal

First of all, start the Ubuntu virtual machine (VM) with login and password 'osboxes.org'.

How to open a terminal depends on the OS or setup.
In Ubuntu 20.04 you can press Ctrl+Alt+t, or go to the "Show applications" button, type "Terminal", and click on the resulting icon. With an open terminal you can right-click on the icon at the task bar and 'Add to favourites'.


You should see a cursor blinking at the end of a line which looks like:

    osboxes@osboxes:~$

The previous line is showing the user name and host name, which in this case is "osboxes" in both cases.

If you hit `Enter` several times, you should see how the previous line duplicates with every hit, and the cursor places itself after the last line.

```
username@host:~$
username@host:~$
username@host:~$
username@host:~$
```

This means that your keyboard is now bound to the terminal. In other terms, the terminal is "listening" your keyboard as an input, and you could start sending commands to it.
Usually, the first "word" that you write is a command, and it can be followed by options, parameters and arguments. You intend to do something, and you use the right command to accomplish it. The first command you are going to try is the `clear` command: just type "clear", and hit `Enter`. You should see again a single line and the cursor waiting for another command.

Let's try another example of a command without any parameter. You want to check "where" you are, that is, which is the current directory. To do that you use the `pwd` command:

    pwd

Right after writing the command and pressing `Enter`, to run the command, you should have the following output:

    /home/osboxes

Firstly, you are getting an output from the command, which is printed on your terminal. This means that besides listening to your input (your keyboard), the terminal is also able to output text which you can read on the screen.

The `pwd` name is an abbreviation for *print working directory*. Most commands use abbreviations, so that you don't need to write so much. However, this makes them not so easy to remember at first. Don't worry. You will need to use the command several times, and in several sessions, until you remember them. As said before, for every command there are different options, parameters and arguments to modify the way it works. For example, many command accept the "--help" option, to provide information about how to run the command:

    pwd --help

You should get a list of options for the command. Many commands accept different help options, which allow you to see more usage info. The most common ones are --help and -h. However, usually you can get a more comprehensive explanation of the command and how it works checking its manual. You can do this with the `man` command, using the command for which you need help as argument:

    man pwd

You will open the manual of the `pwd` command. Once you are done, you can press the `q` key to exit.

Let's check the current directory again:

    pwd

You will get the output:

    /home/osboxes

We are within a directory called as our user name (osboxes), and this directory is within the *home* directory. The *home* directory is where the user-specific directories of linux users are located. Within each user-specific directory, such user has permissions to create new directories and new files, run commands, etc. You should not be able, for example, to create a new file within the home directory of another user (for example, */home/anotheruser*), except if such user, or an administrator, gives you permission for that. In general, your home directory (*/home/osboxes*) is the place where you will carry out most of your work. Note also that the *home* directory itself (*/home*) it is not within any other directory. In fact yes, it is within the *root* directory (which is just */*), from which all the other directories hang. We will explain further about this *root* directory later.

Let's try other commands. First, we are going to create a directory. We can do this with the `mkdir` ("make directories") command:

    mkdir scripting


Then, let's move within such directory. To move to another place, we use the `cd` ("change directory") command:

    cd scripting

You will see that the line on the terminal has changed to:

    osboxes@osboxes:~/scripting$

Which indicates that you are currently within the "scripting" directory. Let's create and move to another directory:

    mkdir lesson1
    cd lesson1

Now, check your current directory with `pwd`. You should get:

    /home/osboxes/scripting/lesson1

If you compare this line with the cursor line:

    osboxes@osboxes:~/scripting/lesson1$    

you will realize that the "~" represents your home directory ("/home/osboxes"). You can use the "~" symbol as an abbreviation for your home directory. For example, to change from any location to your home directory, type:

    cd ~

Also, you can use the "-" symbol with the `cd` command, to go back to the last previous directory:

    cd -

You should be back at `/home/osboxes/scripting/lesson1`.

Now, let's create a few more directories within the current directory. For example, you just started a project and you know that you will need a "data" directory, a "scripts" directory and a "results" directory:

```
mkdir data
mkdir scripts
mkdir results
```

Also, let's create some empty files. We can do this with the `touch` command:

```
touch README
touch SETUP
touch data/dummydata
touch scripts/dummyscript
touch results/dummyresults
```

Now, let's check the contents within the current directory. We can "list" the contents of a directory with the "ls" command:

    ls

You should get:

```
data  README  results  scripts  SETUP
```

The output are the contents of the current directory. You can also try running the command with other options and arguments. For example, to show also the hidden files use the `-a` option to show all files:

```
ls -a
.  ..  data  README  results  scripts  SETUP
```

In linux, the hidden files are those prefixed with `.`. In the previous output you will notice that there are not hidden files, except for those weird `.` and `..` items. In fact, those items represent the path to the current directory `.`, and to the parent directory `..`. Actually, you can check this by using the `cd` command, for example:

    cd .

You will see that you remain in the same directory.

    cd ..

You will go to the parent directory `/home/osboxes/scripting`. Enter again within the `lesson1` directory using `cd lesson1` or `cd -`.

Going back to hidden files, you can actually create a hidden file very easily. You just need to prefix its name with `.`. For example, type `touch .dummyhidden` and compare the output of `ls` and `ls -a`.

In many circumstances, it is better to show the contents as a list, which we obtain using the `-l` option:

```
ls -l
total 12
drwxr-xr-x 2 osboxes osboxes 4096 sep 15 11:43 data
-rw-r--r-- 1 osboxes osboxes    0 sep 15 11:42 README
drwxr-xr-x 2 osboxes osboxes 4096 sep 15 11:43 results
drwxr-xr-x 2 osboxes osboxes 4096 sep 15 11:43 scripts
-rw-r--r-- 1 osboxes osboxes    0 sep 15 11:42 SETUP
```

We are not going in depth with all the info here. First you get a line with the total size of the directory in bytes, and then one line per file or directory. Each of these lines show, from left to right, the permissions (e.g. `drwxr-xr-x`), number of hard links, owner user name, owner group name, file size in bytes, date and time of last modification and the file or directory name.

Note that you don't need to be in a specific directory to list its contents. You can specify the *path* of the directory to be listed as an argument of the `ls` command. For example, to show the contents of the *home* directory:

    ls /home

You can also use the `-d` option to list the directory itself, instead of its contents, so that you can check its permissions, for example:

    ls -ld /home

You can also combine different options. For example, to list the contents of the data directory, as a list `l`, with file sizes in *human readable format* `h`, sorted by date of modification `t`:

    ls -lht data

As argument you can also specify a filename, instead of a directory name. In fact, in linux everything is a file, directories too.

    ls -lht data/dummydata

Note that we have been using file paths as an argument for `ls`. There are different ways to specify a path. Compare the next 2 commands:

```
ls -l /home/osboxes/scripting/lesson1/data
ls -l data
```

The results are the same, because in fact we are asking to list the contents of the same path.

In the first example (`ls -l /home/osboxes/scripting/lesson1/data`) we are using what is called an **absolute path**. Absolute paths start always with `/`, because we are specifying the full path, from the *root* directory up to the final file. With absolute paths, we can specify any file of the system, but sometimes the path can grow very rapidly to a very long string of text.

With the second example (`ls -l data`), we are using a **relative path**, which means "from the place we are currently". We are not using "/" to begin the path, since instead of from the root directory, we are specifying the path from our current location. This is a key to differentiate absolute and relative paths in linux: absolute paths start with "/", relative paths do not.

Another example, let's list the `dummydata` file within the `data` directory. From our current directory (`/home/osboxes/scripting/lesson1`) we could write a relative path:

    ls -l data/dummydata

Or an absolute path:

    ls -l /home/osboxes/lesson1/data/dummydata

But, what if we want to list the contents of the parent path of our current directory using a relative path? As we saw before, we can use `..`, which represents the parent directory. In fact, we can use this `..` recursively to go up through the directory tree, separating each further level with "/". For example, we want to list the contents of `/home` from different locations:

Change directory to `/home/osboxes/scripting` using relative path: `cd ..`
List `/home` from `/home/osboxes/scripting`: `ls ../..`
Change directory to `/home/osboxes/scripting/lesson1`: `cd lesson1`
List `/home` from `/home/osboxes/scripting/lesson1`: `ls ../../..`

We can even go up first, then go down looking for a path which is in a different branch of the directory tree, in relation to the one in which we are located. For example, from within the `/home/osboxes/scripting/lesson1/data` directory, try to list the `/home/osboxes/scripting/lesson1/results` directory.

```
cd data
ls -l ../results
```

As we saw before, you can use the `~` to represent the home directory. For example, try:

```
ls ~
ls -ld ~
ls -l ~/scripting/lesson1/data
```

Also, using *wildcards*, you can get more flexible results. For example, let's create a new file within `data`, and then list all the files within `data` which start with *dummy*:

```
cd ..
touch data/dummydata2
ls -l data/dummy*
```

In general, by combining absolute and relative paths, and special symbols for current, parent and home directory, you should be able to manage yourself within the linux directory hierarchy from the location of your choice.

There is another powerful way to avoid moving around in linux, and have "at hand" the files you wish to work with. For example, we want to access a file as if it was located within the current directory, when the file is actually located in a different directory. We can do this without making an actual copy of the file. We can create links to files (or directories) with the `ln -s` command, and access the actual files using path of the links instead of the actual paths of the files. For example, try:

```
ln -s data/dummydata
ls -l
```

We have seen how to create directories and files (and links). Next, we will see how to delete them, how to move them around, or how to change their names and also how to make copies of them.

To create a copy of a file, use the copy command `cp`:

```
cp data/dummydata2 data/dummydata3
ls data/dummy*
```

To delete a file, use the remove command `rm`:

```
rm data/dummydata3
rm data/dummydata2
ls data/dummy*
```

To copy and remove directories is similar, but we need to copy or remove also the contents of the directory. That is why we use the `-r` option, which means to do the same command recursively, that is, also with all the contents of the directory:

```
cp -r data data2
ls -l
cp -r data data3
ls -l
rm -r data3
ls -l
```

In linux, changing a file (or directory) location is the same as renaming it, and can be done with the move `mv` command. For example, to rename the `data2` dir to `data_moved`:

    mv data2 data_moved
    ls -l

Or to move a file to the current directory (as already seen, the current directory can be specified with `.`):

    mv data_moved/dummydata .
    ls -l

Note that if the second argument of `mv` is a directory, the file or directory of the first argument will be actually moved to within such directory:

    mv dummydata data_moved
    ls -l
    ls -l data_moved

We can remove a link with the `rm` or the `unlink` command. WARNING: despite its name, the `unlink` command behaves exactly as the `rm` command, so if you use it on an actual file, instead of a link, the file will be removed.

It is very important to note that removal, renaming, or moving of files in linux is permanent. So be very cautious when deleting or moving a file or directory.

Summary:
pwd - print current directory
getting help of a COMMAND - COMMAND --help, man COMMAND
create empty directory - mkdir DIRECTORY
create empty file - touch FILENAME
show contents of a directory - ls DIRECTORY
list contents of a directory, showing properties of files - ls -l DIRECTORY
create symbolic links - ln -s FILE_TO_LINK
copy files - cp FILE COPY_OF_FILE
remove files - rm FILE
copy directories - cp -r DIR COPY_OF_DIR
remove directories - rm -r DIR
move or rename files - mv FILE FILE_NEW_PATHNAME
move a file (or directory) to within another directory - mv FILE DIR
remove symbolic links - unlink LINK


## 1.2 Installing software

Besides the software included in our Linux distribution, we can install additional software. There are multiple ways to do this: 

* downloading and compiling source
* obtaining a ready to install binary for our system
* cloning a repository 
* using package managers 

The latter is the preferred method when we want to track the collection of software that we have installed, including the specific versions, in a centralized fashion, which makes it more maneagable. Also, using package managers allow in some cases to create different "views" or "environments" which we can switch to have a different collection of software available or "active" depending on the commands we want to run for a specific analysis or session. Examples of package managers are apt, yum, conda, npm, ...

Other advanced options to run software include running Docker or singularity containers.

### The apt package manager in Ubuntu

The *apt* manager is the the easiest way to install software in Ubuntu systems.
You'll need to use a special command named 'sudo' that allows authorized users to do management tasks. User 'osboxes.org' is one of those users (check file ).

Type the following commands on your terminal:
```
sudo apt-get update # get fresh software repos
sudo apt-get install git 

cd iamz
git clone https://github.com/eead-csic-compbio/scripting_linux_shell
```
These will clone the repository of this course on your local filesystem, which is another popular way of installing software.


### The conda manager

In this case, we are going to install a conda manager which includes just the basic packages (aka Miniconda). Then, we will use this conda manager to create a specific environment which we will use to install blast. To download the Miniconda installer we will do it directly from the terminal with the `wget` command:

cd iamz/scripting

wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

This ".sh" file is a script which we need to run in order to install conda. However, it is very likely that we will need to change permissions to be allowed to run the script. Try to run the file with:

    ./Miniconda3-latest-Linux-x86_64.sh

You will get:

    -bash: ./Miniconda3-latest-Linux-x86_64.sh: Permission denied

This is an opportunity to have a first sight at linux file permissions, and it is also useful to see it now, since many programs and scripts we will download will need to change permissions to be able to run them. This is true even for new scripts that you will program yourself. Let's check file permissions for the installer:

    ls -l Miniconda3-latest-Linux-x86_64.sh

We'll get an output similar to:

    -rw-r--r-- 1 cantalapiedra cantalapiedra 93052469 jul 28 18:13 Miniconda3-latest-Linux-x86_64.sh

We said before that permissions are in the first field of the output: `-rw-r--r--` in this case. Every character here has a different meaning. The first one indicates whether the file is actually a file "-", or if it a directory "d", a link "l", etc. Then there are other 9 characters, which we can divide in 3 groups of 3 characters. These 3 groups are the permissions for the owner of the file, the group of the owner of the file, and any other user. The 3 characters of each group indicate whether the file can be read "r", written "w" and executed "x".

In our Miniconda installer we see that the file is actually a regular file "-", the owner (us) has permission to read and write, but no to execute the file "rw-", and both the group of the owner and any other user have only permissions to read the file "r--". If we want to run the installer, how do we change permissions? We do it with the `chmod` (change file mode bits) command. We want to make the user (the owner) have permission to execute the file:

    chmod u+x Miniconda3-latest-Linux-x86_64.sh

The `u+x` argument means "for the user (u), activate (+) permission to execute (x) the file". Check file permissions again:

    ls -l Miniconda3-latest-Linux-x86_64.sh

You will get:

    -rwxr--r-- 1 cantalapiedra cantalapiedra 93052469 jul 28 18:13 Miniconda3-latest-Linux-x86_64.sh

You can se how the 4th character (or bit) has changed from "-" to "x". Now, we should be able to run the file:

    ./Miniconda3-latest-Linux-x86_64.sh

(TODO explain how to go through installation...)

Lets create a new environment to work with blast:

    conda create -n blastenv

Then, we need to activate the environment we want to use (this is how we switch between different environments):

    conda activate blastenv

Now, lets install blast within that environment. In conda, we can install software from different channels. In this case, we will use the "bioconda" channel, and we will specify the version of blast to be installed:

    conda install -c bioconda blast=2.10.1

conda will detect the need of installing dependencies for the blast program, and it will ask you whether you agree or not. Answer yes "y". Once the installation finishes, check the installed packages with:

    conda list

Also, we are going to use the `which` command, which is useful to check from which path it is being run a particular program:

    which blastp

You should get:

    /home/cantalapiedra/anaconda2/envs/blastenv/bin/blastp

Which means that blastp is running from the conda environment we created.


## 1.3 Working with files

Working with text files: cat, tac, head, tail (tail -n +X), more, less, grep (regular expressions), diff. Modifying text: sed, tr. Working with tabular data: column, sort, uniq, join, paste, awk. Compressing files and packing directories: gzip, gunzip, tar, zcat. Text editors: nano, vi, emacs.

.bashrc

First, we are going to use blast, to create some output files for the practice.

This part is adapted from: https://jvanheld.github.io/using_IFB_NNCR/practicals/blast_proteome/blast_proteome.html

Download the query, which is the sequence of protein P08660 of UniprotKB, in FASTA format. We will be using again the `wget` command:

    wget https://www.uniprot.org/uniprot/P08660.fasta

Download the subject or database against which we want to align our query. In this case, it is the proteome of Escherichia coli strain k12, which we obtain from Ensembl Genomes. In this case, we could be using `wget`, but we are going to show an alternative, which is the `curl` command. For `curl`, we need to specify the output file with the `-o` option:

    curl ftp://ftp.ensemblgenomes.org/pub/release-41/bacteria//fasta/bacteria_0_collection/escherichia_coli_str_k_12_substr_mg1655/pep/Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.pep.all.fa.gz -o Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.pep.all.fa.gz

The file we downloaded is compressed in gzip format. It is rather straightforward in Linux to uncompress files with gzip format, using the command `gunzip`:

    gunzip Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.pep.all.fa.gz

Finally, lets make a first alignment of our query to the proteome:

    blastp -subject <(zcat Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.pep.all.fa.gz) -query P08660.fasta


## 1.4 Remote filesystems

ssh, scp, rsync



Others:
$PATH
tree
rename
.bashrc
