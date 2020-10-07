#!/usr/bin/env Rscript

# This script was first published described at 
# https://bioinfoperl.blogspot.com/2020/10/violines-desde-varios-ficheros-en-r.html

# https://cran.r-project.org/web/packages/vioplot
library(vioplot)

# setwd("path") # if required, this is a comment
filedir="./"

# parse input TSV file names
repeat_files = list.files(path=filedir, pattern="\\.tsv")
series_names = gsub("\\.tsv", "", repeat_files)

# actually read files into data frames
repeats = lapply(repeat_files, function(i){
  log10(read.table(i, header=FALSE))
})
names(repeats) <- series_names

# increase left and bottom margins to make room for axis labels
par(mar = c(4, 11, 1, 1)) 

plot("", 
  ylim = c(0.5, length(repeats)+0.5), 
  xlim = c(1, max(unlist(repeats))), 
  yaxt = "n",  
  ylab = "", 
  xlab = "variable" # changed as needed
)
axis(2, labels = series_names, at = c(1:length(repeats)), las=1)

# add violins one by one
lapply(seq_along(repeats), function(x)
  vioplot(repeats[[x]], at = x,  add = T, box = F, horizontal=T)
)
