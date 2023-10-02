# Session 5: Advanced scripts

- [Shebang](#shebang)
- [Imported libraries, modules or packages](#imported-libraries-modules-or-packages)
- [Argument parsing and environment variables](#argument-parsing-and-environment-variables)
- [Running and reading scripts](#running-and-reading-scripts)
- [Writing your own script](#writing-your-own-script)
- [Resources for scripting languages](#resources-for-scripting-languages)

So far we have been using one-liners or short scripts that can be easily typed in the terminal.
However, some tasks are more complex than that an require longer scripts, which are typically stored in text files. We will learn how to run and modify script files in this section, with examples in BASH, perl, R and python.

## Shebang

The shebang interpreter directive is usually the first line on scripts. 
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

## Running and reading scripts

Please check the example scripts at folder [files/](./files/) and do the following tasks:
* Check their file permissions, are they executable?
* Make them executable with *chmod +x*
* What are these scripts doing? Do the comments help?
* Do they have library/modules dependencies? Install them if required
* Run them, what kind of output they produce?

## Writing your own script

The last task of this course is meant to be a way of demonstrating how to put the things you have learned to action. The idea is that you should write a script to perform a series of tasks introduced in the sessions in **(parentheses)**:

* Create a text file named 'myscript.sh' with a BASH shebang (1,2,5). **Tip**: use editor *nano*. **Tip 2**: to handle script arguments see [sample_script.sh](./files/sample_script.sh) 

These are the tasks that should be carried out by the script. Please add them as comments (lines starting with '#') to the script, as well as some messages to *stderr* so that the progress of the script can be tracked e.g. "Running step 1", "Running step 2", ..., "Finished." (2.1).

You can test them first in the terminal before actually writting them in the script:

1. Create a directory called 'test_script' or the name passed as argument (1,2)

2. Move into that directory (1)

3. Clone the GitHub repo https://github.com/eead-csic-compbio/methods_biostats_bioinfo.git (1)

4. List the contents of the methods_biostats_bioinfo/test_data (1)

5. Check which files in that folder are compressed (1,3). **Tip**: use *file* command with wildcards

6. Create a folder named 'uncompressed' and copy all the compressed files there (1,2,3). **Tip**: use a loop such as:

```
for file in files/*; do 
	iscomp=$(file $file | grep _regex_from_task5_); 
	if [[ ! -z $iscomp ]]; then 
		echo $file; 
	fi; 
done
```

7. Uncompress the files in folder 'uncompressed' (1,3)

8. Create a folder named 'analyses' (1)

9. Get the names of the first 10 sequences in FASTQ file *uncompressed/testPE.fastq* (1,2,4). **Tip**: this is important as in tasks 11 & 12 we select some sequences by name, not position

10. Sort the BLAST hits on file uncompressed/test.blast.tsv by query and bitscore (1,4). **Tip**: check column order at [session 4](./session4.md#blast-tab-separated-format) 

11. Produce a list of sorted hits for query sequence 12 (1,4) and save them in file *analyses/12.hits.tsv*. **Note**: keep all columns from the original BLAST format

12. Extract the sorted BLAST hits for sequences 10 to 12 (1,3,4). **Tip**: check regular expressions at [session 4](./session4.md#one-liners-that-use-range-regexes) 

13. Convert sequences in FASTA file *uncompressed/test.fasta* to single-lines and saved them in file *analyses/test.1line.fasta* (4). **Tip**: see [session4](./session4.md#some-bioinformatics-one-liners)

14. Check result file *analyses/test.1line.fasta* has been successfully created (2). **Tip**: use this syntax: 

```
if [ -e "$FILE" ]; then
	echo "$FILE created correctly"
else 
	echo "$FILE does not exist, stop"
	exit 1
fi
```

15. Tar the folder *analyses* to file *analyses.tar.gz* or *analyses.tgz* (1)

Once that you have those steps within the 'myscript.sh' file:

* Make the script file executable (1.2, 2.5)

<!-- * Add the **absolute path** of 'myscript.sh' to your PATH environmental variable (2.6) -->

* Create a new directory 'final_test', move to within that directory and run your script redirecting the output to 'myscript.out' and the error to 'myscript.err' (2.5). 


## Resources for scripting languages

There are many resources to help you learn programming online. Here's a list:

* Our own [blog](https://bioinfoperl.blogspot.com.es), in Spanish and English

* [Plants & Python: A series of lessons in coding, plant biology, computation, and bioinformatics](https://plantsandpython.github.io/PlantsAndPython/00_Opening_page.html)

* [Perl Programming Course for Beginners](https://www.youtube.com/watch?v=_DFa26ep-h4), 4h

* [Perl en bioinformática](https://eead-csic-compbio.github.io/perl_bioinformatica), in Spanish 

* [R bloggers](https://www.r-bloggers.com)
