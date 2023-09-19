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
	- [Summary 2](#summary-2)
- [1.3 Working with files](#13-working-with-files)
	- [Setup and run blast](#setup-and-run-blast)
	- [Reading text files](#reading-text-files)
	- [Searching previous commands](#searching-previous-commands)
	- [Linux pipes](#linux-pipes)
	- [Text filters](#text-filters)
	- [Working with tabular data](#working-with-tabular-data)
	- [Working with several tables](#working-with-several-tables)
	- [Text editors](#text-editors)
	- [Compressing files and packaging directories](#compressing-files-and-packaging-directories)
	- [Summary 3](#summary-3)
- [1.4 Remote filesystems](#14-remote-filesystems)


## 1.1 Linux environment and the file system

<!-- : input and commands, -h, --help, man; the home directory; ls (-a -l -lh -lrt -ad), wildcards (ls whatever*), relative paths (./ ../), the root directory, absolute paths (/, ~/); hard drives, df and mount; moving (cd DIR, cd ..). Creating, moving, renaming and copying files (touch, mv, cp, rename). Symbolic links (ln -s, unlink). -->

In this course you will need to open a terminal to type your commands and a file system to store your data.
The way this can be done will depend on your setting, see [session 0](./session0.md).
For instance, if you are using a virtual machine (VM), please start it first with login and password 'osboxes.org'.
For compatibility with the VM, the examples below assume your username is 'osboxes' and 
your home directory is '/home/osboxes/'; in other settings your username and home will most likely 
be different, but that's ok, the examples should work as long as you adapt them.

### The terminal

How to open a terminal depends on the OS or setup. In Ubuntu 20.04 you can press *Ctrl+Alt+t*, or go to the **Show applications** button, type **Terminal**, and click on the *Terminal* icon. With an open terminal you can right-click on the icon at the task bar and *Add to favourites*.

You should see a cursor blinking at the end of a line which looks like:

    osboxes@osboxes:~$

The previous line is showing the username and hostname, which are both 'osboxes' in this case. If you hit `Enter` several times, you should see how the previous line duplicates with every hit, and the cursor places itself after the last line.

    osboxes@osboxes:~$
    osboxes@osboxes:~$
    osboxes@osboxes:~$
    osboxes@osboxes:~$

This means that your keyboard is now bound to the terminal. In other terms, the terminal is *listening* to your keyboard, and you could start sending **commands** to it.
Usually, the first word that you write is a command, and it can be followed by **options, parameters and arguments**. The first command you are going to try is the `clear` command: just type *clear*, and hit `Enter`. You should see how the terminal screen is cleared, showing again only one line and the cursor waiting for another command. (note: you can clear the screen also pressing 'Ctrl+l').

### Commands

Let's try another command. Again, we will run it without any parameter. You want to check *where* you are, that is, which is the current directory. To do that you use the `pwd` command:

    pwd

Right after writing the command and pressing `Enter`, to run the command, you should have the following output:

    /home/osboxes

Firstly, you are getting an output from the command, and such output is printed on your terminal. This means that ,besides listening to your keyboard, the terminal is also able to output text for you to read on the screen.

The name of the command, `pwd`, is an abbreviation for *print working directory*. Most commands names are abbreviations, so that you don't need to write so much. However, this makes them not so easy to remember at first. Don't worry. You will need to use the command several times, and in several sessions, until you remember them. As said before, for every command there are different options, parameters and arguments to modify the way it works. For example, many commands accept the `--help` option, which is used to ask for information about how to run the command:

    pwd --help

You should get a list of options for the command, like:

```
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
```

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

Note that we can create files within directories different from the current one, without need to `cd` to such directories, using a linux path, like `data/dummydata`.

### Listing directory contents

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

In linux, the hidden files are those prefixed with `.`. In the previous output you will notice that there are not hidden files, except for those weird `.` and `..` items. In fact, those items represent the path to the directory being listed `.`, and the path to its parent directory `..`. Actually, you can check this by using the `cd` command, for example:

    cd .

You will see that you remain in the same directory.

    cd ..

You will go to the parent directory `/home/osboxes/scripting`. Enter again within the `lesson1` directory using `cd lesson1` or `cd -`.

More on hidden files: you can actually create a hidden file very easily. You just need to prefix its name with `.`. For example, type `touch .dummyhidden` and compare the output of `ls` and `ls -a`.

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

    ls -l data/dummydata

You can also combine different options. For example, to list the contents of the current directory, as a list (`-l`), with file sizes in *human readable format* (`-h`), sorted by date of modification (`-t`):

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

```
-rw-rw-r-- 1 osboxes osboxes 0 Sep 24 12:38 data/dummydata
-rw-rw-r-- 1 osboxes osboxes 0 Sep 24 13:06 data/dummydata2
```

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

Also, the more you type, the more errors you will do. Therefore, using `TAB` autocompletion not only makes you more efficient, but also helps you to make less mistakes when typing commands, paths, etc.

### Summary

- `pwd` - print current directory
- `COMMAND --help`, `man COMMAND` - getting help or manual of a command
- `mkdir DIRECTORY` - create empty directory
- `touch FILENAME` - create empty file
- `ls DIRECTORY` - show contents of a directory
- `ls -l DIRECTORY` - list contents of a directory
- `ln -s PATH_TO_FILE` - create soft symbolic links
- `cp FILE COPY_OF_FILE` - copy a file
- `rm FILE` - remove a file
- `cp -r DIR COPY_OF_DIR` - copy a directory
- `rm -r DIR` - remove a directory
- `mv FILE FILE_NEW_PATHNAME` - move or rename files
- `mv FILE DIR` - move a file (or directory) to within another directory
- `unlink LINK` - remove a symbolic link or a file
- `TAB` autocompletion


## 1.2 Installing software

Besides the software included in our Linux distribution, we can install additional software. There are multiple ways to do this: 

* downloading and compiling source
* obtaining a ready to install binary for our system
* cloning a repository 
* using package managers 

The latter is the preferred method when we want to track the collection of software that we have installed, including the specific versions, in a centralized fashion, which makes it more manageable. Also, using package managers allow us to create different *views* or *environments* which we can switch to have a different collection of software available or "active" depending on the commands we want to run for a specific analysis or session. This *environments* are also helpful also to share dependencies, for example if we want to install a software which requires other software, importing or loading an environment with the list of dependencies will make it easier to install. Examples of package managers are apt, yum, conda, npm, ...

Other advanced options to organize, pack, distribute and run software include container systems, or containerization software, such as Docker or Singularity. But these are beyond the scope of this lesson.

### The apt package manager in Ubuntu

The *apt* manager is the the easiest way to install software in Ubuntu systems.
You'll need to use a special command named `sudo` that allows authorized users to do management tasks. In our VM, our 'osboxes.org' user is one of those users.

For example, we want use to the `git` command to be able to clone the GitHub repository used in this course. However, the `git` command is not installed in our system.
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

Conda is a popular software and packages manager, which is used mainly by the Python community, but it covers much more, including software for data science, R packages, etc. In this example, we are going to install a conda manager which includes just the basic packages (aka 'Miniconda'). Then, we will use this conda manager to create a specific environment which we will use to install the blast program.

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

Conda will detect a long list of dependencies to be installed for the blast program, just type "y" when prompted. Once the installation finishes, check the installed packages with `conda list`. Also, check one of the blast commands with `which`. For example:

    which blastp

You should get:

    /home/osboxes/miniconda3/envs/blastenv/bin/blastp

Note how the path includes the 'blastenv' environment which we created to install blast within. Now, you are ready to use the blast program. For example, type:

    blastn -version


### Summary 2

- `sudo COMMAND` - to run some commands with special permissions (e.g. to install software)
- `wget URL` - to download a file through HTTP
- `apt` or `apt-get` - linux software manager (e.g. `apt-get install SOFTWARE` to install a specific program)
- `git` - command-line software to manage GIT repositories (e.g. `git clone REPO_URL` to download a repository)
- `chmod` - command to modify files permissions (e.g. `chmod u+x FILE` to make a file executable for the owner user)
- `conda` - package and software manager (e.g. `conda activate` and `conda deactivate` to change environments, `conda install` to install packages)
- `which` - to get the path of a command
- a primer of Linux permissions is included in the section describing conda


## 1.3 Working with files

<!--
Working with text files: cat, tac, head, tail (tail -n +X), more, less, grep (regular expressions), diff. Modifying text: sed, tr. Working with tabular data: column, sort, uniq, join, paste, awk. Compressing files and packing directories: gzip, gunzip, tar, zcat. Text editors: nano, vi, emacs.

.bashrc

This part is adapted from: https://jvanheld.github.io/using_IFB_NNCR/practicals/blast_proteome/blast_proteome.html
-->

First, create a directory for this lesson and go within it:

    mkdir ~/scripting/lesson3
    cd ~/scripting/lesson3

### Setup and run blast

Download the query, which is the sequence of protein 'P08660' of the UniprotKB database, in FASTA format. We will be using again the `wget` command:

    wget https://www.uniprot.org/uniprot/P08660.fasta

Alternatively, you can copy the file, which is included within the `files` directory of the course repository:

    cp ~/scripting/scripting_linux_shell/files/P08660.fasta ./

Check the file with `ls -l`.

Download the sequences to be used as reference against which we want to align our query. In this case, it is the proteome of Escherichia coli strain k12, which we obtain from Ensembl Genomes. We could use `wget`, but we are going to show an alternative, which is the `curl` command. For `curl`, we need to specify the output file with the `-o` option:

    curl ftp://ftp.ensemblgenomes.org/pub/release-41/bacteria//fasta/bacteria_0_collection/escherichia_coli_str_k_12_substr_mg1655/pep/Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.pep.all.fa.gz -o Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.pep.all.fa.gz

Alternatively, you can copy the file, which is included within the `files` directory of the course repository:

    cp ~/scripting/scripting_linux_shell/files/Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.pep.all.fa.gz ./

Check the file with `ls -l`. Note the `.gz` extension of the file. This points out that the file we downloaded is compressed in gzip format. You can check it with the `file` command, like:

    file Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.pep.all.fa.gz

Among the output, you will read *"gzip compressed data"*. The `file` command is often useful when you are not sure about the type of file you are dealing with. In this case, a gzip compressed file, which is rather straightforward in Linux to uncompress files with gzip format, using the command `gunzip` (remember using TAB autocompletion to avoid writing the whole filename):

    gunzip Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.pep.all.fa.gz

If you check the file now with `ls -l` you will see no `.gz` extension, the file size has increased, and if you run the `file` command you will see *"ASCII text, with very long lines"*, that is, your file is now just plain text.

In blast, when the reference or file of target sequences is not very large, we can align a query to it directly using the `-subject` option to pass the reference file in plain fasta. However, in many cases, specially if the reference is large, blast will run faster if we first create a proper blast database. In this example, we are going to create a blast database first:

    makeblastdb -in Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.pep.all.fa -dbtype prot

We specify `-dbtype prot` because it is a database of proteins. If the reference is of nucletidic sequences, we would use `-dbtype nucl`. Now, if you type `ls -l` you will see that `makeblastdb` has created new files.

Now, lets make a first alignment of our query to the proteome. As we have created a database for our reference, we will use the `-db` option (instead of the `-subject` option mentioned above):

    blastp -db Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.pep.all.fa -query P08660.fasta

The last command, if it works, will print the alignments on the terminal. However, after we run several commands, all the alignments data will be lost. We would like to store the output from the `blastp` command into a file. We can do this in Linux with the `>` symbol, like:

    blastp -db Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.pep.all.fa -query P08660.fasta > P08660.aln

Which means *redirect the output of the blastp command to a file called "P08660.aln"*. Check the file exists with `ls -l`.



### Reading text files

In the previous section, we created a file with blast results. Now, how do we read a text file from the command line? There are several commands to achieve this, and they can be useful for different purposes.

For example, you can use the `less` command to open the file to read it. Even without noticing, you probably already used `less` when reading the output from the `man` command in lesson 1. Now, try:

    less P08660.aln

You will be able to scroll up and down the file. Within the `less` command, there are shortcuts to perform other actions besides just reading the file. If you type `h`, you will get a detailed list of shortcuts for navigation, to perform text searches, etc. You can exit the help using the `Q` key, and also exit from `less` using the same `Q` key to go back to the terminal.

Another option to read a file is the `more` command, which you probably also already used, when reading the license when installing conda. Try:

    more P08660.aln

You can go from top to bottom of the file by pressing `ENTER`, and once the end of file is reached, the `more` command finishes. You can also check the usage of `more` by typing `h`. To exit before the file ends, you can type `Q`.

Now, there is another way to show the contents of a file, which is the `cat` command. Try:

    cat P08660.aln

You will see that the contents of the file are now printed to the terminal. This is because the `cat` command emits as output the contents of the file, and as no redirection occurs (`>` for example), it ends in what is called the 'standard out', which in this case is the terminal screen. Of course, you could redirect the output of `cat` to another file using the `>` symbol (for example, `cat P08660.aln > P08660.aln.copy`), although in this case it makes no sense (since you could just copy the file with `cp`).

There are ways to print our own text to the terminal screen. For example, the `echo` command:

    echo "Hello world"

Or the `printf` command:

    printf "Hello world\n"

Note how the `echo` command ends with a new line before the command line. However, the `printf` command does not create this new line itself, and we have to tell it to do it with the `\n` special symbol. In linux, we can use `\n` meaning new line for any text string. Other useful symbol of this kind is the `\t` to insert a tab. Try:

    printf "\tHello world\n"

Besides `cat`, there are other commands to output the contents of a text file. For example, there is a way to print the content of the file, but in the opposite direction. Try:

    tac P08660.aln

Also, there are 2 very useful commands to print only part of the file:

    head -6 P08660.aln

Will print the first 6 lines of the file.

    tail -9 P08660.aln

Will print the last 9 lines of the file. `tail` can also be used to print the lines remaining after skipping a number of lines. For example, to skip the first line and print from the second one until the end of line:

    tail -n +2 P08660.aln

### Searching previous commands

Besides the use of the `TAB` autocompletion, there are other ways to work more efficiently in the linux command line. For example, you can use the arrow keys to "navigate" to previous commands you ran, so that you don't need to type them again. You could even just modify them before running them again. Try for example to look for the `tail -n +2 P09660.aln` command you already ran, using the arrow keys, and changing the +2 to +394.

    tail -n +394 P08660.aln

There is another way to access faster to a previous command, when you have a clear idea of the text that this command contained. Press `Ctrl+r`, and write `head`. You will see the last previous `head` command you ran. You can now for example modify the `-6` to `-2` and run the command again. Also, if you hit `Ctrl+r` repeatedly, you will cycle to older commands containing the work you typed. Try `Ctrl+r`, type `head` and then hit `Ctrl+r` again to see previous versions of the command you ran.

There is a command to obtain a list of all the previous commands you ran, which is `history`. Type the command and you will see that every command has a number assigned. You could run the exactly same command without typing it, just typing the number preceded by `!`. For example, if you want to run again the command "235", just type:

    !235

Another useful trick is that you can cut the right part of a command to remove it. For example, use the arrows to recover the command `tail -n +394 P08660.aln`, move the cursor to the space between +394 and the filename, and press `Ctrl+k`. Now you could write the name of another file, for example, and run the command.
    

### Linux pipes

The `>` symbol, to redirect the output of a command to a file, is not the only way to redirect output. The `|` *pipe* symbol can be used to send the output from a command as the input for the next one. For example, to see the last line of the first 10 lines of a file:

    head -10 P08660.aln | tail -1

Or to read with `less` only the last 100 lines of a file:

    tail -100 P08660.aln | less

You can chain all the commands you want like this. For example, to read with `less` the first 100 lines of the last 1000 lines:

    tail -1000 P08660.aln | head -100 | less

### Text filters

There is another useful command to filter the contents of a file, which is the `grep` command. In this case, you choose the text to search or to skip, and the command will return the output according to your choice. For example:

    grep "Stephen" P08660.aln

As a result, you will get 2 lines, which are the lines containing the "Stephen" text string:

```
Reference: Stephen F. Altschul, Thomas L. Madden, Alejandro A.
I. Wolf, Eugene V. Koonin, and Stephen F. Altschul (2001),
```

Note that the search is case-sensitive. Compare the previous results with `grep "stephen" P08660.aln`.

We can use the `-m` option to limit the results to a maximum number of matches. For example, to get only one result from the previous search:

    grep -m 1 "Stephen" P08660.aln

To get:

```
Reference: Stephen F. Altschul, Thomas L. Madden, Alejandro A.
```

You can also show the lines before the result with `-B` and the lines after the result with `-A`. For example, to get the previous line and the next 2 lines, besides the result, try:

    grep -B 1 -A 2 "Stephen" P08660.aln 

You get the next output (note how the 2 results are separated by a line with '--' which is not in the original file):

```
Reference: Stephen F. Altschul, Thomas L. Madden, Alejandro A.
Schaffer, Jinghui Zhang, Zheng Zhang, Webb Miller, and David J.
Lipman (1997), "Gapped BLAST and PSI-BLAST: a new generation of
--
L. Aravind, Thomas L. Madden, Sergei Shavirin, John L. Spouge, Yuri
I. Wolf, Eugene V. Koonin, and Stephen F. Altschul (2001),
"Improving the accuracy of PSI-BLAST protein database searches with
composition-based statistics and other refinements", Nucleic Acids
```

Now, note that if "Stephen" was part of "Stephenson" we would retrieve such result as well. For example:

    printf "Stephen" | grep "Stephen"
    printf "Stephenson" | grep "Stephen"

If we want to find only "Stephen" as a complete word, we can use the `-w` parameter:

    printf "Stephen" | grep -w "Stephen"
    printf "Stephenson" | grep -w "Stephen"

Note that the text to be searched by grep is in fact a **regular expression**. Regular expressions are beyond the scope of this lesson, and will be further covered in [session3](./session3.md) of this course. They are very powerful for text search, replacement and filtering. We will see just some examples using grep:

- Use `^` to represent the start of a line: `grep "^Reference" P08660.aln`

```
Reference: Stephen F. Altschul, Thomas L. Madden, Alejandro A.
Reference for composition-based statistics: Alejandro A. Schaffer,
```

- Use `$` to represent the end of a line: `grep "BLOSUM62$" P08660.aln`

```
Matrix: BLOSUM62
```

- Use the `.` symbol to represent any character: `grep ".HPA.L." P08660.aln`

```
Query  241  DEIAFAEAAEMATFGAKVLHPATLLPAVRSDIPVFVGSSKDPRAGGTLVCNKTENPPLFR  300
            DEIAFAEAAEMATFGAKVLHPATLLPAVRSDIPVFVGSSKDPRAGGTLVCNKTENPPLFR
Sbjct  241  DEIAFAEAAEMATFGAKVLHPATLLPAVRSDIPVFVGSSKDPRAGGTLVCNKTENPPLFR  300
Query  225  GIYTTDPRVVSAAKRIDEIAFAEAAEMATFGAKVLHPATLLPAVRSDIPVFVGSSKDPRA  284
Query  242  EIAFAEAAEMATFGAKVLHPATLLPAVRSDIPVFVGSSKDPRAGGTLV  289
Query  243  IAFAEAAEMATFGAKVLHPATLLPAVRSDIPV  274
Query  258  VLHPATLLPAVRSDIPVFVGSSKDPRAGGTL  288
Query  220  WTDVPGIYTTDPRVVSAAKRIDEIAFAEAAEMATFGAKVLHPATLLPAVRSDIPVFVGSS  279
            W  + G         S ++ + + A A     A    ++ HPATL P V + I + +  +
Sbjct  185  WQALQGAKLVLQDYASGSRPLIDAALARNGIQANIVQEIGHPATLFPMVAAGIGISILPA  244
```

- Use `*` to represent "the previous character any number of times. For example, use `.*` to represent any number of characters: `grep "^Sbjct.*.HPA.L.P" P08660.aln`

```
Sbjct  241  DEIAFAEAAEMATFGAKVLHPATLLPAVRSDIPVFVGSSKDPRAGGTLVCNKTENPPLFR  300
Sbjct  185  WQALQGAKLVLQDYASGSRPLIDAALARNGIQANIVQEIGHPATLFPMVAAGIGISILPA  244
```

- Use the `-v` option to instead of keeping the lines found, discard those and get the others: `grep ".HPA.L." P08660.aln | grep -v "^Query"`

```
            DEIAFAEAAEMATFGAKVLHPATLLPAVRSDIPVFVGSSKDPRAGGTLVCNKTENPPLFR
Sbjct  241  DEIAFAEAAEMATFGAKVLHPATLLPAVRSDIPVFVGSSKDPRAGGTLVCNKTENPPLFR  300
            W  + G         S ++ + + A A     A    ++ HPATL P V + I + +  +
Sbjct  185  WQALQGAKLVLQDYASGSRPLIDAALARNGIQANIVQEIGHPATLFPMVAAGIGISILPA  244
```

- Use "[0-9]" to represent a number. For example, to get any number of 1 or more digits, in %, try: `grep "[0-9][0-9]*%" P08660.aln`

```
 Identities = 449/449 (100%), Positives = 449/449 (100%), Gaps = 0/449 (0%)
 Identities = 142/471 (30%), Positives = 228/471 (48%), Gaps = 41/471 (9%)
 Identities = 23/82 (28%), Positives = 39/82 (48%), Gaps = 6/82 (7%)
 Identities = 90/288 (31%), Positives = 138/288 (48%), Gaps = 7/288 (2%)
 Identities = 28/92 (30%), Positives = 38/92 (41%), Gaps = 8/92 (9%)
 Identities = 32/122 (26%), Positives = 50/122 (41%), Gaps = 14/122 (11%)
 Identities = 21/89 (24%), Positives = 37/89 (42%), Gaps = 13/89 (15%)
 Identities = 16/39 (41%), Positives = 22/39 (56%), Gaps = 3/39 (8%)
 Identities = 14/56 (25%), Positives = 27/56 (48%), Gaps = 6/56 (11%)
 Identities = 19/73 (26%), Positives = 41/73 (56%), Gaps = 10/73 (14%)
 Identities = 12/36 (33%), Positives = 21/36 (58%), Gaps = 1/36 (3%)
 Identities = 22/84 (26%), Positives = 35/84 (42%), Gaps = 3/84 (4%)
 Identities = 12/31 (39%), Positives = 19/31 (61%), Gaps = 0/31 (0%)
 Identities = 9/20 (45%), Positives = 12/20 (60%), Gaps = 0/20 (0%)
 Identities = 38/117 (32%), Positives = 54/117 (46%), Gaps = 21/117 (18%)
 Identities = 25/96 (26%), Positives = 42/96 (44%), Gaps = 3/96 (3%)
```

- Actually, you can use the `[]` to define any set of characters. For example, to get all the pairs of positive and negative aminoacids in the aligned references: `grep "^Sbjct" P08660.aln | grep "[RHK][DE]"`

```
Sbjct  61   FEKLDAIRNIQFAILERLRYPNVIREEIERLLENITVLAEAAALATSPALTDELVSHGEL  120
Sbjct  121  MSTLLFVEILRERDVQAQWFDVRKVMRTNDRFGRAEPDIAALAELAALQLLPRLNEGLVI  180
Sbjct  241  DEIAFAEAAEMATFGAKVLHPATLLPAVRSDIPVFVGSSKDPRAGGTLVCNKTENPPLFR  300
Sbjct  361  TGDTLLTQSLLMELSALCRVEVEEGLALVALIGNDLSKACGVGKEVFGVLEPFNIRMICY  420
Sbjct  291  PGTLIGASRDEDELPVKGISNLNNMAMFSVSGPGMKGMVGMAARVFAAMSRARISVVLIT  350
Sbjct  351  QSSSEYSISFCVPQSDCVR-AERAMQEEFYLELKEGLLEPLAVTERLAIISVVGDGMRTL  409
Sbjct  133  SARLMSAVLNQQGLPAAWLDAREFLRA-ERAAQPQVDEGLSYPLLQQLLVQHPGKRLVVT  191
Sbjct  192  -GFISRNNAGETVLLGRNGSDYSATQIGALAGVSRVTIWSDVAGVYSADPRKVKDACLLP  250
Sbjct  99   GQMLLTRADMEDRERFLNARDTLRALLDN---NIVPVINENDAVA-----------TAEI  144
Sbjct  145  KVGDNDNLSALAAILAGADKLLLLTDQKGLYTADPRSNPQAELIKDVYGIDDALRAIAGD  204
Sbjct  60   IAVHKSQTATLLHTDSQQRVRGINADYLNLLKRALNIKLTLREYADHQKAMDALAEGEVD  119
Sbjct  168  VFQEGVSAEIQQINIVGNHAFT------TDELISHFQLRDEVPWWNVVGDRKYQKQ  217
Sbjct  318  RSPGTLSDWLQKQGLVEGISANSDPIVNGNSGVLAISASLTDKGLANRDQVVAAIFSYLN  377
Sbjct  378  LLREKGIDKQYFD  390
Sbjct  132  FGTITARDHDDVQQHVDVLLADGKTRLKVAITAQSG  167
Sbjct  145  TDSAACLRGIEIEADVVLKATKVDGVFTADPAKDPTATMYEQLTYSEVLEKEL---KVMD  201
Sbjct  202  LAAFTLARDHKLPIRVFNMNKPGA  225
Sbjct  144  MKRDGKYLRRVVASPQPRKILDSEAIELL--LKEGHVV----ICSGGGGVPVTDDGAGSE  197
Sbjct  198  AVIDKDLAAALLAEQINADGLVILTDADAVYENWGTPQQRAIRHATP-DELAPFAKA  253
```

The same regular expression can be used with another command, `sed`, to replace those patterns for other text strings. For example:

    grep "Stephen" P08660.aln | sed 's#Stephen#Osboxes#'

Will change "Stephen" by "Osboxes" in all the lines output by grep. We could use this easily to create another file with the author name changed:

    sed 's#Stephen#Osboxes#' P08660.aln > P08660.aln.osboxes

Check it:

    grep "Altschul" P08660.aln.osboxes

And use the `diff` command to compare both files:

    diff P08660.aln P08660.aln.osboxes

You will get the correspondence of lines which show changes:

```
4c4
< Reference: Stephen F. Altschul, Thomas L. Madden, Alejandro A.
---
> Reference: Osboxes F. Altschul, Thomas L. Madden, Alejandro A.
12c12
< I. Wolf, Eugene V. Koonin, and Stephen F. Altschul (2001),
---
> I. Wolf, Eugene V. Koonin, and Osboxes F. Altschul (2001),
```

Another example, changing all the [RHK][DE] pairs by "__my_motif_" text:

    grep "^Sbjct" P08660.aln | sed 's#[RHK][DE]#_my_motif_#g' | grep "_my_motif_"

Note in the previous expression the use of the `g` flag at the end, which means 'global' replacement, and instructs sed to replace not only the first occurrence of a pattern, but all the occurrences in the line.

We can use `-e` to perform several replacements, as alternative to pipe consecutive `sed` commands. Compare:

    sed 's#^Query#P08660#' P08660.aln | sed 's#^Sbjct#E.coli#'

    sed -e 's#^Query#P08660#' -e 's#^Sbjct#E.coli#' P08660.aln

`sed` has many other uses:

- To remove empty lines: `sed '/^$/d' P08660.aln`
- To show only an interval of lines, for example from 100 to 110: `sed -n "100,110p;111q" P08660.aln`
- To print only the replaced lines, using `-n` option and the `p` flag: `sed -n 's#Stephen#Osboxes#p' P08660.aln`
- To delete specific lines of a file: `sed '10,400d' P08660.aln`
- etc

Check more info and examples about sed at https://tldp.org/LDP/abs/html/x23170.html


### Working with tabular data

It is very common to work with tabular data. We are going to generate the same blastp alignments, but in tabular format, so that we can more easily manage and analyze the results based on its statistics, instead of on the detailed alignment of the residues. To create the alignment in tabular format, use the `-outfmt 6` option in blast. Check the `-outfmt` parameter in the blast documentation of whith `blastp -help`. The default fields in the output are: *qaccver saccver pident length mismatch gapopen qstart qend sstart send evalue bitscore*. Therefore, we are going to create a header first, for our output file, with those fields:

    printf "qaccver saccver pident length mismatch gapopen qstart qend sstart send evalue bitscore\n" | tr " " "\t" > P08660.aln.tsv

With the `tr` command we replace the white spaces to tabular spaces. Now, our output file, `P08660.aln.tsv`, contains only the header. However, if we now run blast like:

    blastp -db Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.pep.all.fa -query P08660.fasta -outfmt 6 > P08660.aln.tsv

we will overwrite the output file, and the header will be gone. To avoid this, we want to append the output from blastp into our existing output file. We can do this using `>>` instead of `>`, like:

    blastp -db Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.pep.all.fa -query P08660.fasta -outfmt 6 >> P08660.aln.tsv

And there we have our tabular file with header. If you try to inspect the table using `cat`, `less`, `more` or similar, you will not be able to match the columns of the different rows, because these programs are agnostic of the tabular nature of the file. An useful command, only to view the tabular contents in the terminal screen, is the `column` command, with the `-t` option. Try:

    column -t P08660.aln.tsv

However, this command alters the tabular spacing between rows, and thus it should be used only for the final visualization of the table, and its output should not be used to pipe it to further commands working on tabular data.

Now, we can use different commands to manipulate the table. For example, we could sort the results by different columns. Although to do this we need to avoid the header with `tail -n +2`. First, let's sort by starting position on the reference (9th column):

    tail -n +2 P08660.aln.tsv | sort -k9,9n | column -t

We use the `sort` command, using `-k` to sort by column, `9,9` means from 9th to 9th column, and `n` means numerical sort.

Now, let's sort the data by score (12th column), which is a decimal number. This is more complex, since depends on the decimal separator registered in your system. You can check this with:

    locale decimal_point

If the output is ".", you can sort by decimal numbers replacing the `n` by `g`. We are adding also the `r` option, so that the order is from largest to smallest numbers.

    tail -n +2 P08660.aln.tsv | sort -k12,12gr | column -t

If the output is ",", you could need first to modify your table, so that your the "." decimal separators from blast output are converted to ",". You can do this easily with the `tr` command:

    tail -n +2 P08660.aln.tsv | tr "." "," | sort -k12,12gr | tr "," "." | column -t

The last `tr` is just in case you want again decimal numbers of the table in the original format.

However, we want our table sorted so that those lines with the same score, are sorted by %identity (3rd column, pident):

If your locale is ".":

    tail -n +2 P08660.aln.tsv | sort -k12,12gr -k3,3gr | column -t

If your locale is ",":

    tail -n +2 P08660.aln.tsv | tr "." "," | sort -k12,12gr -k3,3gr | tr "," "." | column -t

This means, sort first by the 12th column, then by the 3rd column.

Now, we realize that we want to analyze the %identity of the targets of the alignment. So first we would like to remove the other columns from the table. You can remove columns from a table very easily using the `cut` command. For example:

    cut -f 2-3 P08660.aln.tsv | column -t

We use `2-3` as an interval from 2nd to 3rd columns. You can also use "," to add single columns, and combine both single columns and intervals. For example, to keep the query, %identity, start and end of the target and score:

    cut -f 1,3,9-10,12 P08660.aln.tsv | column -t

Another very useful command is `uniq`, which given a list returns the unique elements found in the list. Note however, that `uniq` only "merges" identical values when they are consecutive in the list. So, in general, to get uniq elements we should sort first. For example to get the list of targets from our alignment:

    tail -n +2 P08660.aln.tsv | cut -f 2 | sort | uniq

The previous line could be replaced by `sort -u`:

    tail -n +2 P08660.aln.tsv | cut -f 2 | sort -u
    
However, if we want to use other parameters of uniq, we cannot use directly `sort`. For example, to get the uniq elements and also how many occurrences of them we found:

    tail -n +2 P08660.aln.tsv | cut -f 2 | sort | uniq -c

You can also use `uniq` to keep only the duplicated elements:

    tail -n +2 P08660.aln.tsv | cut -f 2 | sort | uniq -d

Or the elements which appear only once:

    tail -n +2 P08660.aln.tsv | cut -f 2 | sort | uniq -u

Finally, there is a command, `awk`, which is a scripting language itself. As such, it gives us enormous versatility to parse text files, and combined with the previous commands will allow us to perform many different operations on text files, and specially with tabular data. For example, let's keep only the rows with identity equal or over 45.0:

    tail -n +2 P08660.aln.tsv | awk -F $'\t' '{if ($3>=45.0) print $0}' | column -t

Note that you might have to explicitely tell awk that $3 is a number by adding it zero:

    tail -n +2 P08660.aln.tsv | awk -F $'\t' '{if ($3+0>=45.0) print $0}' | column -t


You will get:

```
sp|P08660|AK3_ECOLI  AAC76994  100.000  449  0   0  1    449  1    449  0.0  903
sp|P08660|AK3_ECOLI  AAC75331  45.000   20   11  0  282  301  153  172  7.4  25.8
```

The `-F` option is to define the column separator, in our case tab (`-F $'\t'`). Then, the script is enclosed between `'{}'`. The code which we include within the script is going to be applied to every line of the input separatedly. So, in our example we check whether the 3rd column is equal or above 45.0 (`if ($3>45.0)`). If the condition is met, we print the whole line (`print $0`).

Check more info and examples about awk at https://tldp.org/LDP/abs/html/awk.html

Perl-one liners are a perfect fit for these jobs as well, as described in [session4](./session4.md).

### Working with several tables

Now, we want to work with more than 1 file. For example, make a copy of the previous file:

    cp P08660.aln.tsv P08660.aln.2.tsv

Imagine that they are 2 different files that we want to combine. As in this case both files have the same columns, we just want to concatenate the rows of one file with the other. This is simple using the `cat` command we already know:

    cat P08660.aln.tsv P08660.aln.2.tsv | column -t

Of course, we would need to do some changes to keep only one of the headers, etc. Also, we could store the concatenated file into a new file using `>`. For the moment, just remember how easy is to just concatenate files. You can apply the same to any arbitrary number of files.

Now, let's say that we have 2 files, but with different columns that we want to combine. First, let's create 2 example files:

    cut -f 1-7 P08660.aln.tsv > P08660.half.1.tsv
    cut -f 1,8- P08660.aln.tsv > P08660.half.2.tsv

The first file contains the first 7 columns, whereas the second file contains the first, and the columns from the eighth column to the end. With the `paste` command we can join the rows of two files row-by-row.

    paste P08660.half.1.tsv P08660.half.2.tsv  | column -t

However, in many cases we don't want to join two files row-by-row, but joining columns for those rows which share the same value in one of the columns, which acts as a key field to join the rows. This is typical when we have an identifier of any kind, associated to different values. To do this we can use the `join` command. First, update our two files to contain a column with the row number:

    cat -n P08660.half.1.tsv > P08660.half.1.ID.tsv
    cat -n P08660.half.2.tsv > P08660.half.2.ID.tsv

Check the first rows of one of the files, and notice how the first column is the row number:

    head -4 P08660.half.1.ID.tsv | column -t

You will get:

```
1  qaccver              saccver   pident   length  mismatch  gapopen  qstart
2  sp|P08660|AK3_ECOLI  AAC76994  100.000  449     0         0        1
3  sp|P08660|AK3_ECOLI  AAC73113  30.149   471     288       10       6
4  sp|P08660|AK3_ECOLI  AAC73113  28.049   82      53        2        298
```

Compare it with the columns present in the second file:

    head -4 P08660.half.2.ID.tsv | column -t

To get:

```
1  qaccver              qend  sstart  send  evalue    bitscore
2  sp|P08660|AK3_ECOLI  449   1       449   0.0       903
3  sp|P08660|AK3_ECOLI  448   3       460   5.79e-50  178
4  sp|P08660|AK3_ECOLI  373   386     467   6.4       26.2
```

In this case, we will join these two files using the row number as a unique identifier:

    join -t $'\t' P08660.half.1.ID.tsv P08660.half.2.ID.tsv | column -t

You should get a new table, including the columns of both previous tables for each row.

Note that we are using `-t $'\t'` just to indicate that the output must be in tabular format also. The `join` command is very versatile, and can be used to join rows in common, to show only the rows present in one of the files, etc. Check join options with `join --help`.


### Text editors

We have seen how to print, modify, join, etc text files. We need also a way to edit text files in more detail, as usual text processors allow to. We can also do this from the Linux command line. Although at first, using these editors is tough in comparison with those which are windows-based, command-line editors have a lot of advantages in comparison.

One simple editor is `nano`. You can just type `nano` and the file to be edited (if it doesn't exist will be created), and you will enter the editor window. Try:

    nano P08660.aln.tsv

You can move with the arrow keys within the file, make changes with the keyboard, and do other things with shortcuts, like:
- `Ctrl+s` to save the file
- `Ctrl+o` to save with a different name
- `Ctrl+w` to search for a regular expression
- `Ctrl+\` to search and replace a regular expression
- `Ctrl+k` to cut a line
- `Ctrl+u` to paste a line
- `Ctrl+x` to exit the editor and go back to the terminal
- etc

There are other more advanced, yet more complex, editors, like `vi` or `emacs`. Both of these are very powerful, and very different, and are widely used yet today for programming, OS administration, etc. Our recommendation would be to try these out once that you like and are confortable with something more simple, as `nano`, and you are looking for yet more features.


### Compressing files and packing directories

To end with the management of text files, we are going to explain how to compress them and uncompress them. This is a rather easy procedure from the command line.

To compress a file, use the `gzip` command:

    gzip P08660.aln.tsv

Check the result with `ls -l`. You should see a `P08660.aln.tsv.gz` file. Uncompress the file with `gunzip`:

    gunzip P08660.aln.tsv.gz


What if we want to keep both the original file and the compressed one:

    gzip -c P08660.aln.tsv > P08660.aln.tsv.gz

And the same when uncompressing:

    gunzip -c P08660.aln.tsv.gz > P08660.aln.tsv

As seen on [session3](./session3.md), there are other commands which use other compression algorithms, like `bzip` and `bunzip`. Try out these commands by yourself, and compare the size of the resulting files, and also the compression and uncompression timings.

Besides compressing files, in many occassions it is very useful to pack a whole directory. We can do this, and at the same time compress its contents, with the `tar` command.

To package and compress (using gzip) a directory:

    cd ..
    tar zcf lesson3.tar.gz lesson3

Using `ls` you should see a `lesson3.tar.gz` file, which actually contains the whole content of the original `lesson3` directory. You should be safe if you remove the `lesson3` directory. For the moment, let's just rename it:

    mv lesson3 lesson3_original

To uncompress and unpack a gzipped directory:

    tar zxf lesson3.tar.gz

And you should recover the original `lesson3` directory with its contents.


### Summary 3

- `file FILE` - to check the type of a file
- `curl URL -o FILE` - to download a file through http
- `cat`, `more`, `less`, `tac`, `head`, `tail` - different commands to output the content of a text file
- `echo`, `printf` - different commands to output text strings
- `\n` `\t` - special strings to represent in text the `ENTER` and the `TAB`
- `|` - the Linux pipe, to redirect the output of a command as the input for another
- `history`, `Ctrl+r`, arrow keys navigation - different ways to recover previous commands
- `Ctrl+k` - to cut the text from the current cursor to the end of line
- `grep` - to search for regular expressions in text
- `sed` - to replace text using regular expressions
- `diff` - to compare 2 text files
- `tr` - to replace a single character to another, in a given text
- `>>` - Linux redirection to a file, which appends the content to the existing ones, if the file already exists
- `column -t` - to show tabular data on the terminal output, so that the different columns are correctly visualized
- `tail -n +x` - to output the content of a text file from the "x" line to the end of file
- `sort` - to sort the lines of a text file
- `locale decimal-separator` - to check the decimal separator being used
- `cut` - to cut the columns of a text tabular file
- `uniq` - to collapse repeated lines into unique lines
- `awk` - an interpreter for the scripting language awk
- `paste` - to join text files row-by-row
- `join` - to join text files based on common values in a column
- `nano`, `vi`, `emacs` - different command-line text editors
- `gzip`, `gunzip` - to compress and uncompress files with the .gzip format, respectively
- `tar zcf`, `tar zxf` - to compress and pack, and uncompress and unpack, directories, respectively



## 1.4 Remote filesystems

There are occasions in which we need to work in a remote computer: for example, we are given access to a cluster of computers to perform our analyses. Very often, the remote computer will be a Linux OS, and we will be given an user and password to access to it. We will use `ssh` to connect to the server using our credentials:

    ssh user@remote

With the `ssh` command we ask to connect to the `remote` computer using our `user`. Once within the remote computer, we can run commands there, and once we finish we can use the `exit` command to disconnect from the remote computer and go back to our terminal in our local computer.

For example, John wants to connect to the a server using its IP address (138.130.130.130 for example). The server administrators send to John an email with the credentials:

- User: "john"
- Password: "johnpass"

John will use `ssh` to connect to the server:

    ssh john@138.130.130.130

He will be asked for his password, and he types `johnpass`. If the connection is OK and the password was typed correctly, the terminal will change to show that John is now within the `138.130.130.130` host:

    john@138.130.130.130:~$

And John will be ready to run commands within the remote computer. Once he finishes doing work remotely, John closes the remote session:

    exit

Sometimes we don't need to have a terminal session in the remote computer, but we want just to copy files between our computer and the remote one. To do this, we can use the `scp` or the `rsync` commands. For example, to copy a local file to the remote computer:

    rsync myfile user@remote:/home/user/

or

    scp myfile user@remote:/home/user/

Instead, to copy a remote file to our local computer:

    rsync user@remote:/home/user/myfile .

or

    scp user@remote:/home/user/myfile .

Therefore, the `rsync` or the `scp` commands have 2 arguments:
- The path to the file to be copied.
- The path to the destination were to make a copy of the file.

In either case, if it is a remote file, the format is `user@host:path`, using `:` to separate the user and host from the path of the file.

If you want to try out these commands and have no server no test them you can apply to get free accounts on servers listed at [https://shells.red-pill.eu](https://shells.red-pill.eu)
