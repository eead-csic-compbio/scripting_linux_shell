# Session 3: Parsing files with regular expressions

In Genomics and Computational Biology it is common to handle large datasets, which are often encoded in file formats such as FASTQ, FASTA, etc. Files in these formats are often so bulky that they are compressed to save disk space. Moreover, users of these files might only have remote access to them and therefore are required to operate with them with technologies compatible with the the SSH protocol. The most flexible of them is the terminal, which is easily reachable in Linux, but also MacOS and Windows systems.

## 3.1 Parsing files

text, CSV, TSV, Excel

\n \r

while read p; do
  echo "$p"
  done <file.txt

## 3.2 Regular expressions

Portable Perl regex styles, should work in R and python

## 3.3 Writing to files

wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/715/135/GCF_000715135.1_Ntab-TN90/GCF_000715135.1_Ntab-TN90_genomic.fna.gz

zcat GCF_000715135.1_Ntab-TN90_genomic.fna.gz | perl -lne 'if(!/^>/){ s/[a-z]/N/g } print' > hard-masked.fna


