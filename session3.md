# Session 3: Parsing files and regular expressions

Parsing has different meanings in [Computer Science](https://en.wikipedia.org/wiki/Parsing). 
In data science is broadly the task of extracting features of interest from data files.

## 3.1 Some general file formats 

* **Text** is the natural format for human readable files, where bytes encode characters according to the [UTF-8](https://en.wikipedia.org/wiki/UTF-8) or the [ASCII](https://en.wikipedia.org/wiki/ASCII) tables. Text files can be easily parsed in the terminal or edited with text editors, particularly in English. Some languages such as [Raku](https://raku.org) excel at parsing text and grammars. Text files usually can have extension *.txt* or have no extension at all.

A specially important character is the [newline](https://en.wikipedia.org/wiki/Newline), which is used in text files to indicate that a line has terminated. In UNIX/Linux and derived systems such as MacOS newlines are encoded with character '\n' while in Windows it is actually two chars ('\r\n'). This can cause problems while parsing files across systems. A useful software to avoid this is the terminal utility [dos2unix](http://manpages.ubuntu.com/manpages/focal/man1/dos2unix.1.html).

* **CSV/TSV** are files containing comma or TAB-separated text columns. These files are very convenient for processing and wrangling in the terminal. They can be exported from Spreadsheet software such as [MS Excel](https://en.wikipedia.org/wiki/Microsoft_Excel), [Google Sheets](https://en.wikipedia.org/wiki/Google_Sheets) or [OpenCalc](https://en.wikipedia.org/wiki/OpenOffice.org). These files usually have extensions *.csv*, *.tsv* or *.tab*

Note that the TAB character is encoded as '\t'.

* **markdown** files are text files that support some simple text formatting, with headers, section, hyperlinks or bullet points. See this [cheatsheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) to learn more. This course in written in this format and GitHub renders it by default. These files have *.md* extension. 

* **Excel** files can be on a variety of [formats](https://support.microsoft.com/en-us/office/file-formats-that-are-supported-in-excel-0943ff2c-6014-4e8d-aaea-b83d51d46247) but for the sake of this course they should be converted to CSV or TSV formats. A typical excel extension is *.xlsx*

* **GZIP** files are binary, compressed using the software [gzip/gunzip](https://en.wikipedia.org/wiki/Gzip). They usually have extension *.gz*, but in doubt you can always identify them with the terminal utility *file*. They can be extracted on the fly with *zcat*

* **BZIP2** files are also compressed, in this case using the software [bzip2/bunzip2](https://en.wikipedia.org/wiki/Bzip2). They usually have extension *.bz2* and can be extracted in real time with *bzcat*.

<!-- * *tar* files are actually bundles of files which can be extracted using the utility [tar](https://en.wikipedia.org/wiki/Tar_(computing). -->

### Exercises

```
## set the path to the course material cloned in session 1
COURSEDIR=./scripting_linux_shell
file $COURSEDIR/files/exampleCRLF.txt 

less $COURSEDIR/files/exampleCRLF.txt

dos2unix $COURSEDIR/files/exampleCRLF.txt

file $COURSEDIR/files/exampleCRLF.txt

less $COURSEDIR/files/exampleCRLF.txt
```

Now try to convert this [spreadsheet](https://docs.google.com/spreadsheets/d/1h9ELze4Idjr5NTtksK11i1JQh6EyI7ZrPKLcT8AxoEk) to TSV format, for instance the QTL sheet. Please rename the resulting file as 'files/QTL.tsv' and do the following:

```
# rename file, blanks in filenames can be troublesome
mv dataIAMZ\ -\ QTL.tsv QTL.tsv

ls -l QTL.tsv
gzip QTL.tsv

ls -l QTL.tsv.gz
file QTL.tsv.gz

zcat QTL.tsv.gz
zless QTL.tsv.gz

gunzip QTL.tsv.gz

bzip2 QTL.tsv
ls QTL.tsv.bz2
file QTL.tsv.bz2

# which compressed format saves more space?

```
You can try bzcat and bzless as well.


## 3.2 Reading files 

Files are handy when processing data on the terminal. 
You can use them to repeat the same operation on all lines of a file, for instance.
Before we learn how to do that, let's first see how you can use BASH to read a text file
line by line:

```
while read line; do
	echo $line
	# do something with this word/line
done < "QTL.tsv"
```

This code will work if there is only one word per line, or when you want to process the whole line. 

You might recall from session 2 that pipes can be used to transfer data from one process to another. In that case, the second process will be actually reading the standard output of process 1 as if it was a file. 
<!-- ## 3.3 Writing to files --> 

## 3.3 Regular expressions

Regular expressions, or regexes, are useful for extracting information from text files.
Regexes are search patterns expressed in the form of a sequence of text characters
that are used to match particular contents in files.

Regexes are usually applied to strings, which are lists of characters.
For instance, in the previous section, each line of the file being read is a string.

Their syntax is weird at first, but once you’ve learned it, 
you can actually use a similar syntax in most programming languages, 
such as Python, R, Perl, or sed and awk, with minor differences.

### Basics

```
# basic characters

a      # an 'a'
1      # a digit '1'
.      # any char, wildcard

\w     # word alphanumeric char, including underscore '_'
\d     # digit 
\s     # whitespace character (plus tab and newline)  

\W     # non-word
\D     # non-digit
\S     # non-whitespace

\t     # tab ->|
\r     # carriage return 
\n     # newline

\\     # char \ escaped, literal

# anchors

^      # start of string
$      # end of string
atg    # matches occurrences of 'atg' 
^atg$  # exact string match

# quantifiers

+      # one or more occurrences
?      # cero or one occurrence
*      # cero or more occurrences
{2}    # two occurrences
{2,}   # at least two occurrences
{2,4}  # two to four occurrences

# character classes

[abc]  # matches a string that has either a OR b OR c
[a-z]  # matches any letter from alphabet
[A-Z]  # same but uppercase
[^A-Z] # negation of previous, any char not in A-Z
```

Regexes are usually written in the form /abc/, where the search pattern is delimited by two slash characters /. At the end we can add flags to control matching:

```
g (global) do not return after the first match, continue from there

i case-(insensitive)

```

### Grep with regexes

<!-- egrep
https://ryanstutorials.net/linuxtutorial/cheatsheetgrep.php
-->




### Exercises

<!-- such as code, log files, spreadsheets, or even documents. And while there is a lot of theory behind formal languages, the following lessons and examples will explore the more practical uses of regular expressions so that you can use them as quickly as possible. -->




