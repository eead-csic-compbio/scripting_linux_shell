# Session 1: Linux basics and files

- [1.1 Linux environment and the file system](#11-linux-environment-and-the-file-system)
	- [The terminal](#the-terminal)
	- [Commands](#commands)
	- [Linux paths](#linux-paths)
	- [Creating files and directories, moving around](#creating-files-and-directories-moving-around)
	- [Listing directory contents](#listing-directory-contents)
	- [Absolute and relative paths](#absolute-and-relative-paths)
	- [Useful path symbols and abbreviations](#useful-path-symbols-and-abbreviations)
	- [Copying, renaming and deleting files and directories](#copying-renaming-and-deleting-files-and-directories)
	- [TAB autocompletion](#tab-autocompletion)
	- [Summary](#summary)
- [1.2 Installing software](#12-installing-software)
	- [The apt package manager in Ubuntu](#the-apt-package-manager-in-ubuntu)
	- [Cloning repositories with git](#cloning-repositories-with-git)
	- [The conda manager](#the-conda-manager)
- [1.3 Working with files](#13-working-with-files)
- [1.4 Remote filesystems](#14-remote-filesystems)


## 1.1 Linux environment and the file system

<!-- : input and commands, -h, --help, man; the home directory; ls (-a -l -lh -lrt -ad), wildcards (ls whatever*), relative paths (./ ../), the root directory, absolute paths (/, ~/); hard drives, df and mount; moving (cd DIR, cd ..). Creating, moving, renaming and copying files (touch, mv, cp, rename). Symbolic links (ln -s, unlink). -->

### The terminal

First of all, start the Ubuntu virtual machine (VM) with login and password 'osboxes.org'.

How to open a terminal depends on the OS or setup. In Ubuntu 20.04 you can press Ctrl+Alt+t, or go to the 'Show applications' button, type 'Terminal', and click on the resulting icon. With an open terminal you can right-click on the icon at the task bar and 'Add to favourites'.

You should see a cursor blinking at the end of a line which looks like:

    osboxes@osboxes:~$

The previous line is showing the user name and host name, which in this case is 'osboxes' in both cases.

If you hit `Enter` several times, you should see how the previous line duplicates with every hit, and the cursor places itself after the last line.

```
username@host:~$
username@host:~$
username@host:~$
username@host:~$
```

This means that your keyboard is now bound to the terminal. In other terms, the terminal is *listening* to your keyboard, and you could start sending commands to it.
Usually, the first word that you write is a command, and it can be followed by options, parameters and arguments. You intend to do something, and you use the right command to accomplish it. The first command you are going to try is the `clear` command: just type 'clear', and hit `Enter`. You should see again a single line and the cursor waiting for another command, being the terminal empty, as if no previous commands were run. (note: you can clear the screen also typing 'Ctrl+l').

### Commands

Let's try another command. Again, we will run it without any parameter. You want to check *where* you are, that is, which is the current directory. To do that you use the `pwd` command:

    pwd

Right after writing the command and pressing `Enter`, to run the command, you should have the following output:

    /home/osboxes

Firstly, you are getting an output from the command, and such output is printed on your terminal. This means that ,besides listening to your keyboard, the terminal is also able to output text for you to read on the screen.

The name of the command, `pwd`, is an abbreviation for *print working directory*. Most commands names are abbreviations, so that you don't need to write so much. However, this makes them not so easy to remember at first. Don't worry. You will need to use the command several times, and in several sessions, until you remember them. As said before, for every command there are different options, parameters and arguments to modify the way it works. For example, many commands accept the `--help` option, which is used to ask for information about how to run the command:

    pwd --help

You should get a list of options for the command, like:

'''
pwd: pwd [-LP]
    Print the name of the current working directory.
    
    Options:
      -L        print the value of $PWD if it names the current working
                directory
      -P        print the physical directory, without any symbolic links
    
    By default, `pwd' behaves as if `-L' were specified.
    
    Exit Status:
    Returns 0 unless an invalid option is given or the current directory
    cannot be read.
'''

Many commands accept different help options, which allow you to see more usage info. The most common ones are `--help` and `-h`. However, usually you can get a more comprehensive explanation of the command and how it works checking its manual. You can do this running `man`, using as an argument the command for which you want further information:

    man pwd

This will open the manual of the `pwd` command. You can navigate up and down the manual with the arrow keys. Once you are done, you can press the `q` key to exit.

### Linux paths

Let's check the current directory again, to explain the structure of a linux path:

    pwd

You will get the output:

    /home/osboxes

We are within a directory called as our user name (`osboxes`), and this directory is within the `home` directory. The `home` directory is the parent of the `osboxes` directory, and they are separated by a single `/`. The `home` directory is where user-specific directories of linux users are located. Within each user-specific directory, such user has permissions to create new directories and new files, run commands, etc. You should not be able, for example, to create a new file within the home directory of another user (for example, `/home/anotheruser`), except if such user, or an administrator, gives you permission for that. In general, your home directory (`/home/osboxes`) is the place where you will carry out most of your work. Note also that the `home` directory itself it is not within any other directory. In fact yes, it is within the *root* directory (which is denoted just as `/`), from which all the other directories hang.

In summary, the `/home/osboxes` path contains the root directory `/`, the home directory `home`, a separator `/`, and the osboxes home directory `osboxes`.

### Creating files and directories, moving around

Let's try other commands. First, we are going to create a directory. We can do this with the `mkdir` (*make directories*) command:

    mkdir scripting

Then, let's move within such directory. To move to another place, we use the `cd` (*change directory*) command:

    cd scripting

You will see that the line on the terminal has changed to:

    osboxes@osboxes:~/scripting$

Which indicates that you are currently within the `scripting` directory. Let's create and move to another directory:

    mkdir lesson1
    cd lesson1

Now, check your current directory with `pwd`. You should get:

    /home/osboxes/scripting/lesson1

If you compare this line with the cursor line:

    osboxes@osboxes:~/scripting/lesson1$    

you will realize that the `~` symbol represents your home directory (`/home/osboxes`). You can use the `~` symbol as an abbreviation for your user-specific home directory. For example, to change from any location to your home directory, type:

    cd ~

Also, you can use the `-` symbol with the `cd` command, to go back to the last previous directory:

    cd -

You should be back at `/home/osboxes/scripting/lesson1`.

Now, let's create a few more directories within the current directory. For example, you just started a project and you know that you will need a `data` directory, a `scripts` directory and a `results` directory:

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

### Listing directory contents

Note that we can create files within directories different from the current one, without need to `cd` to such directories, using a linux path, like `data/dummydata`.

Now, let's check the contents of the current directory. We can show the contents of a directory with the `ls` command:

    ls

You should get:

```
data  README  results  scripts  SETUP
```

These are the contents of the current directory. You can also try running the command with other options and arguments. For example, to show also the hidden files use the `-a` option to show all files:

```
ls -a
.  ..  data  README  results  scripts  SETUP
```

In linux, the hidden files are those prefixed with `.`. In the previous output you will notice that there are not hidden files, except for those weird `.` and `..` items. In fact, those items represent the path to the directory being listed `.`, and the path to the parent directory `..`. Actually, you can check this by using the `cd` command, for example:

    cd .

You will see that you remain in the same directory.

    cd ..

You will go to the parent directory `/home/osboxes/scripting`. Enter again within the `lesson1` directory using `cd lesson1` or `cd -`.

More regarding hidden files: you can actually create a hidden file very easily. You just need to prefix its name with `.`. For example, type `touch .dummyhidden` and compare the output of `ls` and `ls -a`.

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

Besides the contents of the directory as a list, you obtain several fields for each of the files. We are not going into details with all them here. First you get a line with the total size of the directory in bytes (`total 12` in this example) Then one line per file or directory. Each of these lines show, from left to right:
- The type of file it is (in our example, a `d` for directories, a `-` for regular files)
- The permissions (e.g. `rwxr-xr-x`) of the file
- Number of hard links (don't mind about this now)
- User name of the user which *owns* the file (`osboxes` is our user name)
- Group name of the group which *owns* the file (`osboxes` is also our user group).
- File size in bytes. Note that empty files have `0` size, whereas empty directories have a size of `4096` bytes.
- Date and time of last modification.
- The file or directory name.

As we have seen with the `touch` command, we don't need to be in a specific directory to list its contents. You can specify the *path* of the directory to be listed as an argument of the `ls` command. For example, to show the contents of the *home* directory:

    ls /home

Hence, this is true in general when a command accepts a path as an argument. 

You can also use the `-d` option to list the directory itself, instead of its contents, so that you can check its permissions, for example:

    ls -ld /home

You should get something like:

    drwxr-xr-x 4 root root 4096 sep 17  20:26 /home

As argument you can also specify a filename, instead of a directory name.

    ls -lht data/dummydata

You can also combine different options. For example, to list the contents of the current directory, as a list `l`, with file sizes in *human readable format* `h`, sorted by date of modification `t`:

    ls -lht 

### Absolute and relative paths

Note that we have been using different paths as arguments for `ls`. There are different ways to specify a path. Compare the next 2 commands:

```
ls -l /home/osboxes/scripting/lesson1/data
ls -l data
```

The results are the same, because in fact we are asking to list the contents of the same directory, using different type of path.

In the first example (`ls -l /home/osboxes/scripting/lesson1/data`) we are using what is called an **absolute path**. Absolute paths start always with `/`, because we are specifying the full path: from the root directory up to the final file.

With the second example (`ls -l data`), we are using a **relative path**, which means *from the place we are currently at*. We are not using `/` to begin the path, since instead of from the root directory, we are specifying the path from our current location. This is a key to differentiate absolute and relative paths in linux: absolute paths start with "/", relative paths do not.

Another example, let's list the `dummydata` file within the `data` directory. From our current directory (`/home/osboxes/scripting/lesson1`) we could write a relative path:

    ls -l data/dummydata

Or an absolute path:

    ls -l /home/osboxes/scripting/lesson1/data/dummydata

In general, an absolute path will grow very rapidly if the target file is underneath a lot of directories, whereas a relative path will grow when the target file is far from our current location.

### Useful path symbols and abbreviations

But, what if we want to list the contents of the parent path of our current directory using a relative path? As we saw before, we can use `..`, which represents the parent directory. In fact, we can use this `..` recursively to go up through the directory tree, separating each further level with the path separator: `/`. For example, we want to list the contents of `/home` from different locations:

Change directory to `/home/osboxes/scripting` using relative path: `cd ..`
List `/home` from `/home/osboxes/scripting`: `ls ../..`
Change directory to `/home/osboxes/scripting/lesson1`: `cd lesson1`
List `/home` from `/home/osboxes/scripting/lesson1`: `ls ../../..`

We can even go up first, then go down looking for a path which is in a different branch of the directory tree, in relation to the one in which we are located. For example, from within the `/home/osboxes/scripting/lesson1/data` directory ...

   cd data

... to list the `/home/osboxes/scripting/lesson1/results` directory we could type:

    ls -l ../results

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

You should get the info of both files within the directory, since both names start with `dummy`:

'''
-rw-rw-r-- 1 osboxes osboxes 0 Sep 24 12:38 data/dummydata
-rw-rw-r-- 1 osboxes osboxes 0 Sep 24 13:06 data/dummydata2
'''

In general, by combining absolute and relative paths, and special symbols for current, parent and home directory, you should be able to manage yourself within the linux directory hierarchy from the location of your choice.

There is another powerful way to avoid moving around in linux, and have "at hand" the files you wish to work with. For example, we want to access a file as if it was located within the current directory, when the file is actually located in a different directory. We can do this without making an actual copy of the file. We can create links to files (or directories) with the `ln -s` command, and access the actual files using path of the links instead of the actual paths of the files. For example, try:

```
ln -s data/dummydata
ls -l
```

You will see now a symbolic link, among the list of files, like:

    lrwxrwxrwx 1 osboxes osboxes 14 Sep 24 13:09 dummydata -> data/dummydata

Like this, you can use the path to `dummydata` as if you were using the path to `data/dummydata`. The file you will access is the same. Also, this is a *soft link*, meaning that if we remove the link the original file will persist.

### Copying, renaming and deleting files and directories

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

To copy and remove directories is similar, but we need to copy or remove also the contents of the directory. That is why we must use the `-r` option, which means to do the same command recursively, that is, also with all the contents of the directory:

```
cp -r data data2
ls -l
cp -r data data3
ls -l
rm -r data3
ls -l
```

That being said, you can check what happens if you type `rm data2`, without the `-r` option.

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

### TAB autocompletion

Finally, there are several things which are very important to work efficiently in the command line. One of them is using the `TAB` key to autocomplete our commands and paths. If you want to be efficient in linux in the long term, you should force yourself to use the `TAB` key for autocompletion as soon as possible, so that you get used to it.

For example, type `ls da` and then hit `TAB`. You should see how your line is now `ls data`, because the only possible option was that you were going to write `ls data`. However, if you further hit `TAB` you will get a list of 2 options (`data/` and `data_moved/`), since there are those 2 possible paths you want to write. You can now add `_` to get `ls data_` and hit `TAB`. The command will be completed to `ls data_moved/`. This means that you can consecutively combine writing and hitting `TAB` until your command or path is complete. This will save you a lot of effort and time in the end.

### Summary

- pwd - print current directory
- getting help of a COMMAND - COMMAND --help, man COMMAND
- create empty directory - mkdir DIRECTORY
- create empty file - touch FILENAME
- show contents of a directory - ls DIRECTORY
- list contents of a directory, showing properties of files - ls -l DIRECTORY
- create symbolic links - ln -s FILE_TO_LINK
- copy files - cp FILE COPY_OF_FILE
- remove files - rm FILE
- copy directories - cp -r DIR COPY_OF_DIR
- remove directories - rm -r DIR
- move or rename files - mv FILE FILE_NEW_PATHNAME
- move a file (or directory) to within another directory - mv FILE DIR
- remove symbolic links - unlink LINK
- `TAB` autocompletion


## 1.2 Installing software

Besides the software included in our Linux distribution, we can install additional software. There are multiple ways to do this: 

* downloading and compiling source
* obtaining a ready to install binary for our system
* cloning a repository 
* using package managers 

The latter is the preferred method when we want to track the collection of software that we have installed, including the specific versions, in a centralized fashion, which makes it more maneagable. Also, using package managers allow us to create different "views" or "environments" which we can switch to have a different collection of software available or "active" depending on the commands we want to run for a specific analysis or session. This "environments" are helpful also to share dependencies, for example if we want to install a software which requires other software, importing or loading an environment with the list of dependencies will make it easier to install. Examples of package managers are apt, yum, conda, npm, ...

Other advanced options to organize, pack, distribute and run software include container systems, or containerization software, such as Docker or Singularity. But these are beyond the scope of this lesson.

### The apt package manager in Ubuntu

The *apt* manager is the the easiest way to install software in Ubuntu systems.
You'll need to use a special command named `sudo` that allows authorized users to do management tasks. In our VM, our 'osboxes.org' user is one of those users.

For example, we want use the `git` command to be able to clone the GitHub repository used in this course. However, the `git` command is not installed in our system.
To install `git`, type the following commands on your terminal:

```
sudo apt-get update # get fresh software repos
sudo apt-get install git
```

When prompted, type "Y". Once the `apt-get` command finishes, if it was successful, you should be able to run the `git` command.

### Cloning repositories with git

Now, let's clone a repository with `git`. We want to clone it within our `~/scripting` directory, so first of all use `cd` to go there. Then, to clone the repository of this course, which is hosted at https://github.com/eead-csic-compbio/scripting_linux_shell, type:

```
git clone https://github.com/eead-csic-compbio/scripting_linux_shell
```

This will clone the repository of this course on your local filesystem. In this case, the repository contains basically text and data. Nonetheless, using `git` is in fact another popular way of installing software, for example from repositories hosted at GitHub. Basically you would do the same, `git clone` followed by the http address of the repository. Then, follow the installation instructions of the specific software, since some will be ready to use after being cloned, whereas others will require running some commands to be properly installed.

### The conda manager

Conda is a popular software and packages manager, which is used mainly within the Python community, but it covers much more, including software for data science, R packages, etc. In this example, we are going to install a conda manager which includes just the basic packages (aka 'Miniconda'). Then, we will use this conda manager to create a specific environment which we will use to install the blast program.

To download Miniconda, you could look for the latest distribution on your web browser and download the `.sh` for your operating system from there. In our example, we are going to download it directly from the terminal using the `wget` command:

    cd ~/scripting
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

Once `wget` finishes, check the downloaded file with `ls -l Miniconda3-latest-Linux-x86_64.sh`:

    -rw-rw-r-- 1 osboxes osboxes 93052469 Jul 28 12:13 Miniconda3-latest-Linux-x86_64.sh

This `.sh` file is a script which we need to run in order to install conda. Try to run the file with:

    ./Miniconda3-latest-Linux-x86_64.sh

You will get:

    -bash: ./Miniconda3-latest-Linux-x86_64.sh: Permission denied

We need to change permissions to be allowed to run the script.

This is an opportunity to have a first sight at linux file permissions. Take a look again at the `ls -l Miniconda3-latest-Linux-x86_64.sh` output:

    -rw-rw-r-- 1 osboxes osboxes 93052469 Jul 28 12:13 Miniconda3-latest-Linux-x86_64.sh

Our user `osboxes` is the owner of the file. Also, our group `osboxes` is the group owner of the file. Now check the next characters, which we already said are the ones showing the file permissions:

    -rw-rw-r--

The first character `-` just indicates that it is a regular file, and not a directory (`d`), a symbolic link (`l`), etc. File permissions are coded in the next 9 characters, which are actually divided in 3 groups of 3 characters. These 3 groups are, from left to right, the permissions for the owner of the file (`rw-`), for the group (also `rw-`), and for any other user which is not the owner of a member of the owner group (`r--`). The 3 characters of each group indicate, from left to right, whether the file can be read "r", written "w" and executed "x".

In our `.sh` file that the owner user as well as the owner group have permission to read and write, but no to execute the file: `rw-`. However, any other user has only permissions to read the file: `r--`. If we want to run the installer, we need to be able to execute the `.sh` script. We will change its permissions with the `chmod` (*change file mode bits*) command. We want to make the user (the owner) have permission to execute the file:

    chmod u+x Miniconda3-latest-Linux-x86_64.sh

The `u+x` argument means *"for the user (`u`), activate (`+`) permission to execute (`x`) the file"*. Check file permissions again:

    ls -l Miniconda3-latest-Linux-x86_64.sh

You will get:

    -rwxrw-r-- 1 osboxes osboxes 93052469 jul 28 12:13 Miniconda3-latest-Linux-x86_64.sh

You can see how the 1st group has changed from `rw-` to `rwx`. This means that the owner user has now permission to execute or run the script. To do it, just type:

    ./Miniconda3-latest-Linux-x86_64.sh

When prompted, hit `ENTER`, and again keep `ENTER` pressed until all the License text has been scrolled down. Then, just type `yes`. You will be asked to confirm the directory where to install Miniconda. The suggestion should be to install it within your home directory `/home/osboxes/miniconda3`; just press `ENTER`. If it is not, please change it to `/home/osboxes/miniconda3` and press `ENTER`. When asked if wish to run conda init, type `yes`. Now close this terminal (you can use the `exit` command for this), and open a new one (for example, pressing Ctrl+Alt+t), so that conda is initialized properly. You command line should now be showing `(base)` at the beginning:

    (base) osboxes@osboxes:~$

This means that the 'base' environment from conda is active, and thus the software installed within such conda environment will be ready to be used. Note that in some cases you will prefer to inactivate the conda environment, for example to run another version of the same software installed by other means. To inactivate a conda environment just type:

    conda deactivate

The `(base)` has disappear from your command line. To activate the conda environment again just type:

    conda activate

And there it is the 'base' environment active again. What software is available in a given environment? You can list the software installed within the active environment with:

    conda list

Now, let's install `git`, which we already installed with `apt-get`, but now using `conda`:

    conda install git

When prompted, you will see a list of dependencies to be installed or updated to be able to install `git`. Just type "y". Now, we have 2 `git` commands installed in our system. When we type `git`, which of those commands are being run? In Linux, we can check from which actual path a command is being run with the `which` command:

    which git

And you will get:

    /home/osboxes/miniconda3/bin/git

Hence, we are running git from the binary within the Miniconda distribution. Also, check the `git` version with:

    git --version

To get, for example:

    git version 2.23.0

Now, let's deactivate the conda environment and repeat the `which git` and `git --version` commands:

    conda deactivate
    which git
    git --version

You should get something similar to:

    /usr/bin/git
    git version 2.25.1

Now we are running the `git` installed through `apt-get`. Thus, there is no problem at all having different versions of the same command, always that we are aware of which particular version of the command we are running.

Now, let's create a new environment, which we want to use to work with the blast alignment program:

    conda create -n blastenv

When prompted, type "y". Then, we need to activate the environment we want to use:

    conda activate blastenv

In fact, 'activate' is a way to switch between different conda environments.

Now, if you run `conda list`, you should get an empty list of software. Let's install blast within that environment. In conda, we can install software from different channels. In this case, we will use the 'bioconda' channel. You can even specify the version of the program to be installed, which is a great advantage in order to create reproducible pipelines, for example. In this case, let's install the 2.10.1 version of blast:

    conda install -c bioconda blast=2.10.1

Conda will detect a long list of dependencies to be installed for the blast program, just type "y". Once the installation finishes, check the installed packages with `conda list`. Also, check one the blast commands with `which`. For example:

    which blastp

You should get:

    /home/osboxes/miniconda3/envs/blastenv/bin/blastp

Note how the path includes the 'blastenv' environment which we created to install blast within. Now, you are ready to use the blast program. For example:

    blastn -version

## 1.3 Working with files

Working with text files: cat, tac, head, tail (tail -n +X), more, less, grep (regular expressions), diff. Modifying text: sed, tr. Working with tabular data: column, sort, uniq, join, paste, awk. Compressing files and packing directories: gzip, gunzip, tar, zcat. Text editors: nano, vi, emacs.

.bashrc

This part is adapted from: https://jvanheld.github.io/using_IFB_NNCR/practicals/blast_proteome/blast_proteome.html

First, create a directory for this lesson and go within it:

    mkdir ~/scripting/lesson3
    cd ~/scripting/lesson3

Download the query, which is the sequence of protein 'P08660' of the UniprotKB database, in FASTA format. We will be using again the `wget` command:

    wget https://www.uniprot.org/uniprot/P08660.fasta

Check the file with `ls -l`.

Download the sequences to be used as reference against which we want to align our query. In this case, it is the proteome of Escherichia coli strain k12, which we obtain from Ensembl Genomes. We could use `wget`, but we are going to show an alternative, which is the `curl` command. For `curl`, we need to specify the output file with the `-o` option:

    curl ftp://ftp.ensemblgenomes.org/pub/release-41/bacteria//fasta/bacteria_0_collection/escherichia_coli_str_k_12_substr_mg1655/pep/Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.pep.all.fa.gz -o Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.pep.all.fa.gz

Check the file with `ls -l`. Note the `.gz` extension of the file. This points out that the file we downloaded is compressed in gzip format. You can check it with the `file` command, like:

    file Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.pep.all.fa.gz

Among the output, you will read *"gzip compressed data"*. The `file` command is often useful when you are not sure about the type of file you are dealing with. In this case, a gzip compressed file, which is rather straightforward in Linux to uncompress files with gzip format, using the command `gunzip`:

    gunzip Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.pep.all.fa.gz

If you check the file now with `ls -l` you will see no `.gz` extension, the file size has increased, and if you run the `file` command you will see *"ASCII text, with very long lines"*, that is, your file is now just plain text.

In blast, when the reference or file of target sequences is not very large, we can align a query to it directly using the `-subject` option to pass the reference file in plain fasta. However, in many cases, specially if the reference is large, blast will run faster if we first create a proper blast database. In this example, we are going to create a blast database first:

    makeblastdb -in Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.pep.all.fa -dbtype prot

We specify `-dbtype prot` because it is a database of proteins. If the reference is of nucletidic sequences, we would use `-dbtype nucl`. Now, if you type `ls -l` you will see that `makeblastdb` has created new files.

Now, lets make a first alignment of our query to the proteome. As we have created a database for our reference, we will use the `-db` option (instead of the `-subject` option mentioned above):

    blastp -db Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.pep.all.fa -query P08660.fasta

If it works, you should see some alignments printed on the terminal. However, after we keep running commands in our session, all the alignments will be lost. We would like to store the output from the `blastp` command in a file. We can do this in Linux with the `>` symbol, like:

    blastp -db Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.pep.all.fa -query P08660.fasta > P08660.aln`

Which means *redirect the output of the blastp command to a file called "P08660.aln"*. Check the file exists with `ls -l`. Now, how do I read the file from the command line? There are several commands to achieve this, and they can be useful for different purposes.

For example, you can use the `less` command to open the file to read it. Even without noticing, you probably already used `less` when reading the output from the `man` command in lesson 1. Now, try:

    less P08660.aln

You will be able to scroll up and down the file. Within the `less` command, there are shortcuts to perform other actions besides just reading the file. If you type `h`, you will get a detailed list of shortcuts for navigation, to perform text searches, etc. You can exit the help using the `Q` key, and also exit from `less` using the same `Q` key to go back to the terminal.

Another option to read a file is the `more` command, which you probably also already used, when reading the license when installing conda. Try:

    more P08660.aln

You can go from top to bottom of the file by pressing `ENTER`, and once the end of file is reached, the `more` command finishes. You can also check the usage of `more` by typing `h`. To exit before the file ends, you can type `Q`.

Now, there is another way to show the contents of a file, which is the `cat` command. Try:

    cat P08660.aln

You will see that the contents of the file are now printed to the terminal. This is because the `cat` command emits as output the contents of the file, and as no redirection of such output is done, it ends in what is called the 'standard out', which in this case is the terminal screen. Of course, you could redirect the output of cat to another file using the `>` symbol (for example, `cat P08660.aln > P08660.aln.copy`), although in this case it makes no sense (since you could just copy the file with `cp`).

There is a way to print the content of the file, but in the opposite direction. Try:

    tac P08660.aln

Also, there are 2 very useful commands to print only part of the file:

    head -6 P08660.aln

Will print the first 6 lines of the file.

    tail -9 P08660.aln

Will print the last 9 lines of the file. `tail` can also be used to print the lines remaining after skipping a number of lines. For example, to skip the first line and print from the second one until the end of line:

    tail -n +2 P08660.aln

### Searching previous commands

Besides the use of the `TAB` autocompletion, there are other ways to work more efficiently in the linux command line. For example, you can use the arrow keys to "navigate" to previous commands you ran, so that you don't need to write them again. You could even just modify them before running them again. Try for example to look for the `tail -n +2 P09660.aln` command you already ran, using the arrow keys, and changing the +2 to +394.

    tail -n +394 P08660.aln

There is another way to access faster to a previous command, when you have a clear idea of the text this command it contained. Press 'Ctrl+r', and write 'head'. You will see the last previous `head` command you ran. You can now for example modify the `-6` to `-2` and run the command again. Also, if you hit 'Ctrl+r' repeatedly, you will cycle to older commands containing the work you typed. Try 'Ctrl+r', type 'head' and then hit 'Ctrl+r' again to see previous versions of the command you previously ran.

There is a command to obtain a list of all the previous commands you ran, which is `history`. Type the command and you will see that every command has a number assigned. You could run the exactly same command without typing it, just typing the number preceded by "!". For example, if you want to run again the command "235", just type:

    !235

Another useful trick is that you can cut the right part of a command to remove it. For example, use the arrows to recover the command `tail -n +394 P08660.aln`, move the cursor to the space between +394 and the filename, and press 'Ctrl+k'. Now you could write the name of another file, for example, and run the command.

    

### Linux pipes

The `>` symbol, to redirect the output of a command to a file, is not the only way to redirect output. The `|` *pipe* symbol can be used to send the output from a command as the input for the next one. For example, to see the last line of the first 10 lines of a file:

    head -10 P08660.aln | tail -1

Or to read with `less` only the last 100 lines of a file:

    tail -100 P08660.aln | less

You can chain all the commands you want like this. For example, to read with `less` the first 100 lines of the last 1000 lines:

    tail -1000 P08660.aln | head -100 | less


## 1.4 Remote filesystems

ssh, scp, rsync



Others:
$PATH
tree
rename
.bashrc
