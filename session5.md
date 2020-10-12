# Session 5: Advanced scripts

- [Shebang](#shebang)
- [Imported libraries, modules or packages](#imported-libraries-modules-or-packages)
- [Argument parsing and environment variables](#argument-parsing-and-environment-variables)
- [Running, reading and modifying scripts](#running-reading-and-modifying-scripts)

So far we have been using one-liners or short scripts that can be easily typed in the terminal.
However, some tasks are more complex than that an require longer scripts, which are typically stored in text files. We will learn how to run and modify script files in this section, with examples in BASH, perl, R and python.

## Shebang

The Shebang interpreter directive is usually the first line on scripts. 
It is used to tell the operating system which interpreter to use to parse the rest of the file.
It takes the following form: ```#!interpreter [arguments]```

These are portable shebangs for some scripting languages:
```
#!/usr/bin/env bash

#!/usr/bin/env perl 

#!/usr/bin/env python # most likely python3 in 2020

#!/usr/bin/env Rscript
```

Note that it is possible to have different versions of the same intepreter on the same environment and thus you must make sure that you are using the appropriate one. This might be more difficult that it seems in systems with many users and that's why tools such as conda (seen in previous sessions), [pyenv](https://github.com/pyenv/pyenv) or [perlbrew](https://perlbrew.pl) can often be your best friend.

## Imported libraries, modules or packages

Programming languages usually have what's we can call the i) **core language**, which includes the main functions, data types and syntax, and ii) the **ecosystem of libraries** than extend the language. Usually you will see any imported modules at the header of scripts.

In order to install accessory modules you have mainly two choices:
 * the operating systen package manager, such as *apt-get* in Ubuntu or *yum* in redhat like Linux distros
 * Language specific package managers:
   - [pip](https://pip.pypa.io/en/stable) takes python modules from [PyPI](https://pypi.org)
   - cpanm for Perl, seen in the previous session, downloads from [CPAN](https://www.cpan.org)
   - install.packages(), core function of R to install from [CRAN](https://cran.r-project.org) 

## Argument parsing and environment variables

Scripts will typically take input arguments and will produce some kind of output.
Most languages have core modules for handling arguments, such as [argparse](https://docs.python.org/3/library/argparse.html) for python or [Getopt::Long](https://perldoc.perl.org/Getopt::Long) in Perl. You will see a couple of examples in the next section.

## Running, reading and modifying scripts

Please check the example scripts at folder [files/](./files/) and do the following tasks:
* Check their file permissions, are they executable?
* Make them executable with *chmod +x*
* What are these scripts doing? Can you see the comments?
* Do they have library/modules dependencies? Install them if required
* Run them, what kind of output they produce?
