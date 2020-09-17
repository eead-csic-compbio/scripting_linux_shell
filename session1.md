# Session 1: Linux basics and files

## 1.1 Linux environment and the file system

: input and commands, -h, --help, man; the home directory; ls (-a -l -lh -lrt -ad), wildcards (ls whatever*), relative paths (./ ../), the root directory, absolute paths (/, ~/); hard drives, df and mount; moving (cd DIR, cd ..). Creating, moving, renaming and copying files (touch, mv, cp, rename). Symbolic links (ln -s, unlink).

#### The terminal

Open a terminal (TODO depending of the OS or setup)
You should see a cursor and something similar to:

    username@host:~$

If you hit `Enter` several times, you should see how the previous line duplicates with every hit, and the cursor places itself after the last line.

```
username@host:~$
username@host:~$
username@host:~$
username@host:~$
```

This means that your keyboard is now bound to the terminal. In other terms, the terminal is "listening" your keyboard as an input, and you could start sending commands to it.
Usually, the first "word" that you write is a command. You intend to do something, and you use the right command to accomplish it. For example, you have just logged in the terminal, and you want to check "where" you are, that is, the current directory. To do that you use the `pwd` command:

    pwd

Right after writing the command and pressing `Enter`, to run the command, you should have the following output:

    /home/username

Firstly, you are getting an output from the command, which is printed on your terminal. This means that besides listening to your input (your keyboard), the terminal is also able to output text which you can read on the screen.

The `pwd` name is an abbreviation for *print working directory*. Most commands use abbreviations, so that you don't need to write so much. However, this makes them not so easy to remember at first. Also, for every command there are different options, arguments or parameters to modify the way it works. Also, you could need further explanation of a command in order to fully understand it. Type:

    pwd --help

You should get a list of options for the command. Many commands accept different help options, which allow you to see more usage info. The most common ones are --help and -h. However, usually you can get a more comprehensive explanation of the command and how it works checking its manual. You can do this with the `man` command, using the command for which you need help as argument:

    man pwd

You will open the manual of the `pwd` command. Once you are done, you can press the `q` key to exit.

Let's check the current directory again:

```
pwd
/home/username
```

As you can see, we are within a directory called as our user name, and this directory is within the *home* directory. The *home* directory is where the user-specific directories of linux users are located. Within each user-specific directory, such user has permissions to create new directories and new files, run commands, etc. You should not be able to, for example, create a new file within the home directory of another user (for example, */home/anotheruser*), except if such user, or an administrator, gives you permission for that. In general, your home directory (*/home/username*) is the place where you will carry out most of your work. Note also that the *home* directory itself (*/home*) it is not within any other directory. In fact yes, it is within the *root* directory (which is just */*), from which all the other directories hang. We will ellaborate more about this *root* directory later.

Let's try other commands. First, we are going to create a directory. We can do this with the `mkdir` command:

    mkdir lesson1

Then, let's move within such directory. To move to another place, we use the `cd` (change directory) command:

    cd lesson1

Check that you changed the current directory:

```
pwd
/home/username/lesson1
```

Now, let's create a few more directories within the current directory:

```
mkdir data
mkdir scripts
mkdir results
```

Also, let's create some empty files. We can do this with the "touch" command:

```
touch README
touch SETUP
touch data/dummydata
touch scripts/dummyscript
touch results/dummyresults
```

Now, let's check the contents within the current directory. We can "list" the contents of a directory with the "ls" command:

```
ls
data  README  results  scripts  SETUP
```

The output is the contents of the current directory. You can also try running the command with other options and arguments:

```
ls -a
.  ..  data  README  results  scripts  SETUP
```

Will show also the hidden files, which in linux are those prefixed with ".". You can try to create a hidden file, for example with `touch .dummyhidden`. Compare the outcome of `ls` and `ls -a`.

In many circumstances, it is better to show the contents as a list, which we obtain using the `-l` option:

```
ls -l
total 12
drwxr-xr-x 2 username username 4096 sep 15 11:43 data
-rw-r--r-- 1 username username    0 sep 15 11:42 README
drwxr-xr-x 2 username username 4096 sep 15 11:43 results
drwxr-xr-x 2 username username 4096 sep 15 11:43 scripts
-rw-r--r-- 1 username username    0 sep 15 11:42 SETUP
```

We are not going in depth with all the info here. First you get a line with the total size of the directory in bytes, and then one line per file or directory. Each of these lines show, from left to right, the permissions (e.g. `drwxr-xr-x`), number of hard links, owner user name, owner group name, file size in bytes, date and time of last modification and the file or directory name.

Note that you don't need to be in a specific directory to list its contents. You can specify the path to the directory to list as an argument of the `ls` command. For example, to show the contents of the *home* directory:

    ls /home

You can also use the `-d` option to list the directory itself, instead of its contents:

    ls -ld /home

You can also combine different options. For example, to list the contents of the data directory, as a list, with file sizes in *human readable format*, sorted by date of modification:

    ls -lhr data

As argument you can also specify a filename, instead of a directory name. In fact, in linux everything is a file, directories too.

    ls -lhr data/dummydata

Note that we have been using file paths as an argument for `ls`. There are different ways to specify a path. Compare the next 2 commands:

```
ls -l /home/username/lesson1/data
ls -l data
```

The results are the same, because in fact we are asking to list the contents of the same path.

In the first example (`ls -l /home/username/lesson1/data`) we are using what is called an **absolute path**. Absolute paths start always with `/`, because we are specifying the full path, from the *root* directory up to the final file. With absolute paths, we can specify any file of the system, but sometimes the path can grow very rapidly to a very long text string.

With the second example (`ls -l data`), we are using a **relative path**, which means "from the place we are currently". This means that we are not using "/" to start a relative path, since instead of from the root directory, we are specifying the path from our current location.

Another example, let's list the `dummydata` file within the `data` directory. From our current directory (`/home/username/lesson1`) we could write a relative path:

    ls -l data/dummydata

Or an absolute path:

    ls -l /home/username/lesson1/data/dummydata

But, what if we want to list the contents of a directory which is a level up over our current directory using a relative path? We can use `..` to go up through the directory tree, and use this in the path that we supply to `ls` as an argument. In general, we can use `..` to specify a level up for any path, and use it for any command which requires a path as argument. Also, we can use `/` separator to go up more than one level. For example, we want to list the contents of `/home` from different locations:

Change directory to `/home/username` using relative path: `cd ..`
List `/home` from `/home/username`: `ls ..`
Change directory to `/home/username/lesson1`: `cd lesson1`
List `/home` from `/home/username/lesson1`: `ls ../..`

We can even go up first, then go down looking for a path which is "orthogonal", or in a different branch of the directory tree, in relation to the one in which we are located. For example, from within the `/home/username/lesson1/data` directory, try to list the `/home/username/lesson1/results` directory.

```
cd data
ls -l ../results
cd ..
```

There is also a shortcut to the user home directory in linux, which is widely used: `~`. For example, try:

```
ls ~
ls -ld ~
ls -l ~/lesson1/data
```

Also, using *wildcards*, you can get more flexible results. For example, let's create a new file within `data`, and then list all the files within `data` which start with *dummy*:

```
touch data/dummydata2
ls -l data/dummy*
```

We have seen how to create directories with `mkdir`, to list contents of directories with `ls`, and to change the current directory with `cd`. We have also seen how to create empty files with `touch`. Now, how do we remove files and directories, or how do we change their location, their name or make copies of them?

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
cp -r data data3
rm -r data3
```

In linux, changing a file (or directory) location is the same as renaming it, and can be done with the move `mv` command. For example, to rename the `data2` dir to `data_moved`:

    mv data2 data_moved
    ls -l

Or to move a file to the current directory (the current directory can be specified with `.`):

    mv data_moved/dummydata .
    ls -l
    ls -l data_moved

Note that if the second argument is a directory, the file or directory of the first argument will be actually moved to within such directory:

    mv dummydata data_moved
    ls -l
    ls -l data_moved

Finally, sometimes we want to access a file from the current directory as if it was located here, when the file it is located in a different directory. For example, we don't want to make an actual copy of the file (for example, the file is huge), and if we use absolute or relative paths we are going to end with very long paths. We can create links to files (or directories), and access the actual files using the links, with the `ln -s` command:

```
ln -s data/dummydata
ls -l
```

We can remove a link with the `rm` or the `unlink` command. WARNING: if you use these commands on an actual file, instead of a link, the file will be removed.

```
unlink dummydata
```

Summary:
pwd - print current directory
getting help of a COMMAND - COMMAND --help, man COMMAND
create empty directory - mkdir DIRECTORY
create empty file - touch FILENAME
show contents of a directory - ls DIRECTORY
list contents of a directory, showing properties of files - ls -l DIRECTORY
copy files - cp FILE COPY_OF_FILE
remove files - rm FILE
copy directories - cp -r DIR COPY_OF_DIR
remove directories - rm -r DIR
move or rename files - mv FILE FILE_NEW_PATHNAME
move a file (or directory) to within another directory - mv FILE DIR
create symbolic links - ln -s FILE_TO_LINK




Others:
$PATH
tree
rename


## 1.2 Installing software

Package managers: apt-get,yum, etc
github -> git clone https://github.com/eead-csic-compbio/scripting_linux_shell
miniconda, etc
docker, singularity, etc


Besides the commands included in our Linux distribution, we can install additional software. There are multiple ways to do this: downloading and compiling source, obtaining a ready to install binary for our system, cloning a repository or using package managers. The latter is the preferred method when we want to track the collection of software that we have installed, including the specific versions, in a centralized fashion, which makes it more maneagable. Also, using package managers allow in some cases to create different "views" or "environments" which we can switch to have a different collection of software available or "active" depending on the commands we want to run for a specific analysis or session. Examples of package managers are apt, yum, conda, npm, ...

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