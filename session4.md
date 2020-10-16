# Session 4: Perl one-liners

<!-- made with perl -lne 'if(/^(#{1,}) (.*)/){ ($i,$t)=($1,$2); $l=lc($t); $l=~s/\W/\-/g; print "$i [$t](#$l)"}' session4.md -->

- [Dependencies](#dependencies)
	- [Perl](#perl)
	- [Git](#git)
	- [Optional software](#optional-software)
	- [Sample data files](#sample-data-files)
- [Key file formats](#key-file-formats)
	- [FASTA](#fasta)
	- [FASTQ](#fastq)
	- [BLAST tab-separated format](#blast-tab-separated-format)
	- [SAM](#sam)
	- [VCF](#vcf)
	- [PDB](#pdb)
	- [Newick](#newick)
[Perl](#perl)
- [Perl basics in 5 minutes](#perl-basics-in-5-minutes)
- [Perl one-liners](#perl-one-liners)
	- [Hello world one-liners](#hello-world-one-liners)
	- [One-liners that count input lines](#one-liners-that-count-input-lines)
	- [Split-column one-liners](#split-column-one-liners)
	- [One-liners calling modules](#one-liners-calling-modules)
	- [*In situ* edition of files with regular expressions (regexes)](#-in-situ--edition-of-files-with-regular-expressions--regexes-)
	- [One-liners that use range regexes](#one-liners-that-use-range-regexes)
	- [One-liner output piped to other process](#one-liner-output-piped-to-other-process)
	- [Some bioinformatics one-liners](#some-bioinformatics-one-liners)


The main goal of this lecture is to learn the basics of one-liners.
One-liners are short scripts in a single line, which are often useful when dealing with data files in the terminal.

## Dependencies

We will use Perl, R and Git in this lecture. You can check whether they are installed in your system by typing in the terminal:
```
perl --version 

git --version

R --version
```

### Perl

We will use [Perl5](http://www.perl.org/about.html), a classic programming language which is very powerful for the task of processing data files at the terminal. 
Perl is [installed by default](https://www.perl.org/get.html) in Linux, including macOS, but not in MS Windows. 
However, it is [easy to install in these systems](https://www.perl.org/get.html#win32) as well. 
My preference for casual Windows users is to install [MobaXterm](https://mobaxterm.mobatek.net), as explained in [session 0](./session0.md).

### Git

Git is a popular distributed version control software which is very common in Bioinformatics. 
It can be very useful to install and update third-party software. Follow these instructions to install Git:

```{r, engine='bash', eval=FALSE}
# Ubuntu
sudo apt-get install git 

# MacOSX: install Xcode Command Line Tools by typing
git --version

# MobaXterm: push "Packages" and select "git"
```

### Optional software

Some of the examples below make use of optional dependencies, which in Ubuntu systems can be installed as follows:

```

sudo apt-get install bioperl r-base

# for optional Perl modules we will use the official source, CPAN
sudo cpan App::cpanminus
cpanm HTTP::Server::Brick
```
To install bioperl in other systems please see [http://bioperl.org/INSTALL.html](http://bioperl.org/INSTALL.html).

### Sample data files

If *git* was succesfully installe the following command will download the sample data which will be used in this lecture.
These files can be also directly downloaded from [https://github.com/eead-csic-compbio/methods_biostats_bioinfo](https://github.com/eead-csic-compbio/methods_biostats_bioinfo/archive/master.zip):

```
git clone https://github.com/eead-csic-compbio/methods_biostats_bioinfo.git
```

## Key file formats

In Genomics and Computational Biology it is common to handle large datasets, which are often encoded in file formats such as FASTQ, FASTA, etc. Files in these formats are often so bulky that they are compressed to save disk space. Moreover, users of these files might only have remote access to them and therefore are required to operate with them with technologies compatible with the the SSH protocol. The most flexible of them is the terminal, which is easily reachable in Linux, but also MacOS and Windows systems.

### FASTA
```
>transcript XYZ
AAGAATTACAAACCTCAACAACTCTCGACTGTTACAGGCATCGCTGCCATAATATGAGTA
GAGTACATGGGCATCACCTAAATTCTGTGAGCGCCATCCATCAAACTATGTCTGACTGAC
TTGACTGTCTACTACAAGATATACTCATTCTCAATTACATGACGCTTTGACATAATGAGT
GCAAGAAAAATCTACTGATACATCATCACCAAACACACCAACCTAGATTTCCAAGAATCG
TCAATTCAAAACAAGAAACGCTAGAAACAACCTAATCAGATGCAATTATTATTCTTCCTC
TTGTTATGTCGTGAAGAAAGACCATAGCGTTTTCCCAATCGATTTGTTTCGC

>gi|5524211|gb|AAD44166.1| cytochrome b [Elephas maximus maximus]
LCLYTHIGRNIYYGSYLYSETWNTGIMLLLITMATAFMGYVLPWGQMSFWGATVITNLFSAIPYIGTNLV
EWIWGGFSVDKATLNRFFAFHFILPFTMVALAGVHLTFLHETGSNNPLGLTSDSDKIPFHPYYTIKDFLG
LLILILLLLLLALLSPDMLGDPDNHMPADPLNTPLHIKPEWYFLFAYAILRSVPNKLGGVLALFLSIVIL
GLMPFLHTSKHRSMMLRPLSQALFWTLTMDLLTLTWIGSQPVEYPYTIIGQMASILYFSIILAFLPIAGX
IENY*

>Homeobox protein hox-b1 (part of P40424|PBX1_HUMAN)
MEPNTPTART FDWMKVKRNP PKTAKVSEPG LGSPSGLRTN FTTRQLTELE 
KEFHFNKYLS RARRVEIAAT LELNETQVKI WFQNRRMKQK KREREGG
```

### FASTQ

This is the standard format for high-throughput sequencing reads. Each read takes four lines, with headers starting with char @. Note that in this example pair-end reads are interleaved, with read 2 of each pair coming just after read 1:

```
@SRR491411.1.1 HWUSI-EAS1737_0007:6:1:1007:2418 length=101
NCTACCGATGAGCCCGAAACTTTTCCGGTAATGCACGAAAACCTTCCGGTAACCAAATGAGGTCATCCTCTATCTCAATCTTCCATTCCGGACCATTCCGG
+SRR491411.1.1 HWUSI-EAS1737_0007:6:1:1007:2418 length=101
#*4*+000/0;???>@@<?<<9<<<=>8=;4+888>>>>><A@@?########################################################
@SRR491411.1.2 HWUSI-EAS1737_0007:6:1:1007:2418 length=101
ATATGGGCATCCAGGTCCCGCTATTGGATATTGACCGAGGAGTCTCTCGGGTCATGTCTACATAGTTCTCGAACCCGCAGGGACTGCACAACTAAGGTTGG
+SRR491411.1.2 HWUSI-EAS1737_0007:6:1:1007:2418 length=101
DEDBEE?:E?D5CDA@ACAA=E=D5D?5BCAA:-=5C5?C:?*A>BB?EC??D??CBB5=,/)775><>>B?-C?##########################
```

Check our [blog post](https://bioinfoperl.blogspot.com.es/2014/12/perl-module-kseqklib-parse-fastq-fasta-files.html) on highly efficient ways of parsing these files.

### BLAST tab-separated format

The 12-column format below is produced by BLAST when option **-outfmt 6** is in use; columns are **tab-separated** in
the [following order](https://www.ncbi.nlm.nih.gov/books/NBK279684): *qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore*

```
1	1	100.00	628	0	0	1	628	1	628	0.0	1281
1	4102	64.63	622	220	0	1	622	1	622	0.0	 852
1	5262	60.61	622	245	0	1	622	1	622	0.0	 812
1	7852	61.09	622	242	0	1	622	1	622	0.0	 818
1	13947	60.29	622	245	1	7	628	7	626	0.0	 767
1	17697	64.79	622	219	0	1	622	1	622	0.0	 853
2	2	100.00	274	0	0	1	274	1	274	2e-154	 544
```

### SAM

The format below contains at least 11 **tab-separated** columns in the 
[following order](https://en.wikipedia.org/wiki/SAM_(file_format)): 
*QNAME, FLAG, RNAME, POS, MAPQ, CIGAR, RNEXT, PNEXT, TLEN, SEQ, QUAL*

```
@SQ    SN:chr1    LN:50
read1    16    chr1    1    255    50M    *    0    0    ATTTAAAAATTAATTTAATGCTTGGCTAAATCTTAATTACATATATAATT   <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<    NM:i:0
read1    1032    chr1    1    255    50M    *    0    0    ATTTAAAAATTAATTTAATGCTTGGCTAAATCTTAATTACATATATAATT   <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<    NM:i:0
```

The binary version of SAM is called BAM, and can be queried with software [samtools](http://www.htslib.org/doc/samtools.html).

### VCF

The Variant Call Format was designed to summarize genetic variations mapped on a reference genome/sequence:

```
##fileformat=VCFv4.0
##fileDate=20090805
##source=myImputationProgramV3.1
##reference=1000GenomesPilot-NCBI36
##phasing=partial
##INFO=<ID=NS,Number=1,Type=Integer,Description="Number of Samples With Data">
##INFO=<ID=DP,Number=1,Type=Integer,Description="Total Depth">
##INFO=<ID=AF,Number=.,Type=Float,Description="Allele Frequency">
##INFO=<ID=AA,Number=1,Type=String,Description="Ancestral Allele">
##INFO=<ID=DB,Number=0,Type=Flag,Description="dbSNP membership, build 129">
##INFO=<ID=H2,Number=0,Type=Flag,Description="HapMap2 membership">
##FILTER=<ID=q10,Description="Quality below 10">
##FILTER=<ID=s50,Description="Less than 50% of samples have data">
##FORMAT=<ID=GT,Number=1,Type=String,Description="Genotype">
##FORMAT=<ID=GQ,Number=1,Type=Integer,Description="Genotype Quality">
##FORMAT=<ID=DP,Number=1,Type=Integer,Description="Read Depth">
##FORMAT=<ID=HQ,Number=2,Type=Integer,Description="Haplotype Quality">
#CHROM POS     ID        REF ALT    QUAL FILTER INFO                              FORMAT      NA00001        NA00002        NA00003
20     14370   rs6054257 G      A       29   PASS   NS=3;DP=14;AF=0.5;DB;H2           GT:GQ:DP:HQ 0|0:48:1:51,51 1|0:48:8:51,51 1/1:43:5:.,.
20     17330   .         T      A       3    q10    NS=3;DP=11;AF=0.017               GT:GQ:DP:HQ 0|0:49:3:58,50 0|1:3:5:65,3   0/0:41:3
20     1110696 rs6040355 A      G,T     67   PASS   NS=2;DP=10;AF=0.333,0.667;AA=T;DB GT:GQ:DP:HQ 1|2:21:6:23,27 2|1:2:0:18,2   2/2:35:4
20     1230237 .         T      .       47   PASS   NS=3;DP=13;AA=T                   GT:GQ:DP:HQ 0|0:54:7:56,60 0|0:48:4:51,51 0/0:61:2
20     1234567 microsat1 GTCT   G,GTACT 50   PASS   NS=3;DP=9;AA=G                    GT:GQ:DP    0/1:35:4       0/2:17:2       1/1:40:3
```

The binary version of VCF is called BCF, and can be queried with software [bcftools](https://samtools.github.io/bcftools/bcftools.html).

### PDB

The classic Protein Data Bank format, as well as the 
[updated PDBx variant](https://bioinfoperl.blogspot.com.es/2017/10/formato-pdbxmmcif-protein-data-bank.html), 
are used to annotate and describe the positions of atoms in macromolecules such as proteins, DNA and RNA:

```
ATOM      1  O5'  DG A   1      13.136  26.426  -2.541  1.00 15.00           O  
ATOM      2  C5'  DG A   1      11.802  26.362  -2.030  1.00 15.00           C  
ATOM      3  C4'  DG A   1      11.520  25.005  -1.428  1.00 15.00           C  
ATOM      4  O4'  DG A   1      10.541  24.330  -2.241  1.00 15.00           O  
ATOM      5  C3'  DG A   1      12.726  24.064  -1.369  1.00 15.00           C  
ATOM      6  O3'  DG A   1      12.764  23.394  -0.106  1.00 15.00           O  
ATOM      7  C2'  DG A   1      12.495  23.060  -2.494  1.00 15.00           C  
ATOM      8  C1'  DG A   1      11.234  23.552  -3.188  1.00 15.00           C  
ATOM      9  N9   DG A   1      11.483  24.384  -4.360  1.00 15.00           N  
ATOM     10  C8   DG A   1      12.655  25.014  -4.698  1.00 15.00           C  
ATOM     11  N7   DG A   1      12.579  25.674  -5.822  1.00 15.00           N  
ATOM     12  C5   DG A   1      11.275  25.473  -6.250  1.00 15.00           C  
ATOM     13  C6   DG A   1      10.606  25.944  -7.409  1.00 15.00           C  
ATOM     14  O6   DG A   1      11.047  26.655  -8.319  1.00 15.00           O  
ATOM     15  N1   DG A   1       9.287  25.503  -7.453  1.00 15.00           N  
ATOM     16  C2   DG A   1       8.687  24.712  -6.503  1.00 15.00           C  
ATOM     17  N2   DG A   1       7.404  24.394  -6.723  1.00 15.00           N  
ATOM     18  N3   DG A   1       9.301  24.266  -5.419  1.00 15.00           N  
ATOM     19  C4   DG A   1      10.583  24.683  -5.357  1.00 15.00           C  
```

### Newick

The Newick format does the job of describing a phylogenetic tree as a sucession of nodes, branches, and distances:

```
((((((((((BsyC:0.013358,BsyE:0.021549):0.090257,BsyG:0.027746):0.012743,Bpin:0.080853):0.015246,((B422:0.015850,Bpho:0.017473):0.034584,Brup:0.01
8335):0.025314):0.018883,Barb:0.108741):0.045155,((Bboi:0.115276,Bret:0.042738):0.050086,Bmex:0.153381):0.040856):0.159346,((Bdis:0.039945,Bhyb:0
.042164):0.016188,Bsta:0.054611):0.072495):0.093114,Osat:0.177214):0.071042):0.035521,Sbic:0.035521);
```

<!-- ---------------------------------------------------------------------------------- -->

# Perl

## Perl basics in 5 minutes

The following snippet illustrates the main features you must know in order to read and write Perl code. One of the strongest features of Perl are its [regular expressions](https://perldoc.perl.org/perlre.html), which are efficient and powerful. This code was adapted from
[https://learnxinyminutes.com/docs/perl](https://learnxinyminutes.com/docs/perl):

```perl
# This is a comment

# Adapted from https://learnxinyminutes.com/docs/perl

#### Strict and warnings

use strict;
use warnings;

# All perl scripts and modules should include these lines. Strict causes
# compilation to fail in cases like misspelled variable names, and
# warnings will print warning messages in case of common pitfalls like
# concatenating to an undefined value.

#### Perl variable types

#  Variables begin with a sigil, which is a symbol showing the type.
#  A valid variable name starts with a letter or underscore,
#  followed by any number of letters, numbers, or underscores.

### Perl has three main variable types: $scalar, @array, and %hash.

## Scalars
#  A scalar represents a single value:
my $animal = "camel";
my $answer = 42;
my $display = "You have $answer ${animal}s.\n";

# Scalar values can be strings, integers or floating point numbers, and
# Perl will automatically convert between them as required.

# Strings in single quotes are literal strings. Strings in double quotes
# will interpolate variables and escape codes like "\n" for newline.

## Arrays
#  An array represents a list of values:
my @animals = ("camel", "llama", "owl");
my @numbers = (23, 42, 69);
my @mixed   = ("camel", 42, 1.23);

# Array elements are accessed using square brackets, with a $ to
# indicate one value will be returned.
my $second = $animals[1];

# The size of an array is retrieved by accessing the array in a scalar
# context, such as assigning it to a scalar variable or using the
# "scalar" operator.

my $num_animals = @animals;
print "Number of numbers: ", scalar(@numbers), "\n";

# Be careful when using double quotes for strings containing symbols
# such as email addresses, as it will be interpreted as a variable.

my @example = ('secret', 'array');
my $oops_email = "foo@example.com"; # 'foosecret array.com'
my $ok_email = 'foo@example.com';

## Hashes
#   A hash represents a set of key/value pairs:

my %fruit_color = ("apple", "red", "banana", "yellow");

#  You can use whitespace and the "=>" operator to lay them out more
#  nicely:

my %fruit_color = (
  apple  => "red",
  banana => "yellow",
	 );

# Hash elements are accessed using curly braces, again with the $ sigil.
my $color = $fruit_color{apple};

# All of the keys or values that exist in a hash can be accessed using
# the "keys" and "values" functions.
my @fruits = keys %fruit_color;
my @colors = values %fruit_color;

# Scalars, arrays and hashes are documented more fully in perldata.
# (perldoc perldata).

#### Conditional and looping constructs

# Perl has most of the usual conditional and looping constructs.

if ($var) {
  ...
} elsif ($var eq 'bar') {
  ...
} else {
  ...
}

# the Perlish post-condition way
print "Yow!" if $zippy;
print "We have no bananas" unless $bananas;

#  while
while (condition) {
  ...
}

# for loops and iteration
for my $i (0 .. $max) {
  print "index is $i";
}

for my $element (@elements) {
  print $element;
}

map {print} @elements;

# iterating through a hash (for and foreach are equivalent)
foreach my $key (keys %hash) {
  print $key, ': ', $hash{$key}, "\n";
}

#### Regular expressions

# Perl's regular expression support is both broad and deep, and is the
# subject of lengthy documentation in perlrequick, perlretut, and
# elsewhere. However, in short:

# Simple matching
if (/foo/)       { ... }  # true if $_ contains "foo"
if ($x =~ /foo/) { ... }  # true if $x contains "foo"

# Simple substitution

$x =~ s/foo/bar/;         # replaces foo with bar in $x
$x =~ s/foo/bar/g;        # replaces ALL INSTANCES of foo with bar in $x
```

There are many tutorials available online in English. A good place to start might be:
[https://perlmaven.com/perl-tutorial](https://perlmaven.com/perl-tutorial)
If you prefer in Spanish, you can try [https://eead-csic-compbio.github.io/perl_bioinformatica](https://eead-csic-compbio.github.io/perl_bioinformatica)

## Perl one-liners

A one-liner is a Perl program in which the source code is typed in the terminal instead of being contained in a file.
Their main advantage is that they can be naturally combined with powerful command-line Linux such as *grep, sort or uniq*.
In the next sections we will show how to write some useful one-liners. The reader can learn even more from repositories such as 
[perl_the_swiss_knife](https://learnbyexample.gitbooks.io/command-line-text-processing/content/perl_the_swiss_knife.html) or
<!--[perl-one-liners](https://gist.github.com/mischapeters/1e8eef09a0aafd4f24f0) -->
[Perl one-liners](https://gist.github.com/joyrexus/7328094).
Occasionally we post one-liners at out [blog](https://bioinfoperl.blogspot.com.es).

### Hello world one-liners

One-liners are executed by calling the interpreter with option *-e* and some Perl syntax between 'single quotes':

```
perl -e 'print "hello world"'
echo

# -l adds newline char '\n' to each output line
perl -le 'print "hello world"'
echo

# add -n to read input file line by line ($_ = current line)
gunzip test_data/test.fasta.gz
perl -lne 'print $_ if(/ATGATGATG/)' test_data/test.fasta
echo

# now in reverse order
tac test_data/test.fasta | perl -lne 'print $_ if(/ATGATGATG/)'
gzip test_data/test.fasta
echo

# if input is gzipped a pipe (|) can be used
# NOTE this is equivalent tozcat test_data/test.fasta.gz | grep -P "^>"
zcat test_data/test.fasta.gz | perl -lne 'print if(/^>/)'
```

### One-liners that count input lines

Perl global variable $. contains at any moment the current input line number.
In this example we used to print the first line every four lines of a FASTQ file:
```
zcat test_data/testPE.fastq.gz | perl -lne 'print if($.%4==1)' | head -10
```

### Split-column one-liners

Option *-a* should be used to split input lines in columns and save teh resulting elements in array @F:

```
# parse 12-column TSV BLAST output and select hits of sequence "12" with some E-value cutoff
zcat test_data/test.blast.tsv.gz | perl -lane 'print $F[1] if($F[0] eq "12" && $F[10] < 0.0001)'
echo

# use -F to change column separator
zcat test_data/test.blast.tsv.gz | perl -F'\s+' -lane 'print "$F[0] $F[1]" if($F[10] < 0.0001)' | wc
echo

# combine with efficient system sort
zcat test_data/test.blast.tsv.gz | sort -nk1,1 -nk2,2 -nrk11,11 | \
  perl -lane 'print $F[1] if($F[0] eq "12" && $F[10] < 0.0001)'
```

### One-liners calling modules

Sometimes modules are required in one-liners. Core modules are pre-installed in most systems:
```
# List::Util is a core module
echo '34,17,6' | perl -MList::Util=max -F"," -lane 'print max @F'
```

Other modules must be installed before they can be used:
<!-- I believe this could be done easily with python as well -->
```
# HTTP::Server::Brick must be installed 
# this serves the current folder to share data through the Web
perl -MHTTP::Server::Brick -e '$s=HTTP::Server::Brick->new(port=>8000); $s->mount("/"=>{path=>"."}); $s->start'
```

### *In situ* edition of files with regular expressions (regexes)

Flag *-i* allows the edition of text files *in situ*, creating backups:

```
gunzip test_data/test.fasta.gz
perl -i.bk -ne 's/, complete genome\.//; print' test_data/test.fasta
```

### One-liners that use range regexes

The next example prints lines that appear in the input file after the first regex and before the second: 
```
zcat test_data/test.blast.tsv.gz | perl -lne 'print if /^10\t/../^12\t/'
```

### One-liner output piped to other process

In this examples the median and histogram are computed in R from data parsed with one-liner:

```
# this requires R installed and produces a PDF file

zcat test_data/test.blast.tsv.gz | perl -lane 'print $F[11] if($F[10] < 0.00001)' | \
  Rscript -e 'median(scan(file="stdin"))'

zcat test_data/test.blast.tsv.gz | perl -lane 'print $F[11] if($F[10] < 0.00001)' | \
  Rscript -e 'data=abs(scan(file="stdin")); pdf("bits.pdf"); hist(data,xlab="bitscore")'
```

![](pics/bits.png)

### Some bioinformatics one-liners

```
# get length of sequences in FASTA file
zcat test_data/test.fasta.gz |\
	perl -lne 'if(/^>/){ print $l if($l); $l=0 } else{$l+=length($_)} END{ print $l}'
echo

# find palindromes
zcat test_data/test.fasta.gz | perl -lne 'print if($_ eq reverse)'
echo

# convert FASTA file so that sequences take a single line (order changes)
zcat test_data/test.fasta.gz | perl -ne 'if(/^>/){ print "\n"; print } else { chomp; print }' > test_data/test.1.fasta

# compute frequency of 6-mers, print 10 random hexamers
perl -lne 'if(!/^>/){ while(/(\w{6})/g){$fq{$1}++}} END{ foreach $k (keys(%fq)){ print "$k $fq{$k}" }}' test_data/test.1.fasta | head -10
echo

# print top 6-mers
perl -lne 'if(!/^>/){ while(/(\w{6})/g){$fq{$1}++}} END{ foreach $k (sort {$fq{$b}<=>$fq{$a}} keys(%fq)){ print "$k $fq{$k}" }}' test_data/test.1.fasta | head -10

# get hard-masked genome file with repeats as Ns
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/715/135/GCF_000715135.1_Ntab-TN90/GCF_000715135.1_Ntab-TN90_genomic.fna.gz
zcat GCF_000715135.1_Ntab-TN90_genomic.fna.gz | perl -lne 'if(!/^>/){ s/[a-z]/N/g } print' > hard-masked.fna
```


If [Bio::Perl](http://bioperl.org) is installed in your system you can use one-liners to download and format sequences from databases:

```
# Bio::Perl must be installed 
perl -MBio::Perl -e '$gb=get_sequence("genbank","CP000524"); write_sequence(">CP000524.fna","fasta",$gb)'
```
