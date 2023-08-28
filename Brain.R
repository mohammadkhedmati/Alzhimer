library(methods)
library(neurobase)
library(fslr)
library(extrantsr)
setwd()
knitr::opts_chunk$set(echo = TRUE, comment = "")

t1_fname = "AD1"
t1 = neurobase::readnii(t1_fname)
rt1 = robust_window(t1); 
red0.5 = scales::alpha("red", 0.5) # for plotting later
ortho2(rt1)


inme = t1_fname
outme = "/Users/mohammadkhedmati/Desktop/outputma"
biasbrain = fsl_biascorrect(file = inme,outfile = outme,opts = "-v")
brainextraction = fsl_bet(infile = inme,outfile = outme,opts = " -f 0.5 -g 0",betcmd = "bet2")
