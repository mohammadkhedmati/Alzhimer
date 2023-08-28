library(methods)
library(neurobase)
library(fslr)
library(extrantsr)
library(scales)
library(knitr)
library(BiocManager)

opts_chunk$set(echo=TRUE, prompt=FALSE, message=FALSE, warning=FALSE, comment="", results='hide', cache= TRUE)

options(fsl.path = "/usr/local/fsl/fsl")
options(fsl.outputtype = "NIFTI_GZ")

packages = installed.packages()
packages = packages[, "Package"]
if (!"oro.nifti" %in% packages) {
  install.packages("oro.nifti")
  ### development version
  # devtools::install_github("bjw34032/oro.nifti")
}

temp = readnii("D:/2021/HARD BLACK/last files/CHANGE/Documents/Paper/HEDAYATI/AD02.nii")


orthographic(temp)

temp3 =fslbet_robust(fast_img, outfile = temp, retimg = TRUE, correct = FALSE,
                     recog = TRUE, reorient = FALSE, bet.opts = "", remove.neck = TRUE, swapdim = FALSE,
                     robust.mask = FALSE, remover = "double_remove_neck",
                     template.file = file.path(fsldir(), "data/standard","MNI152_T1_1mm_brain.nii.gz"), 
                     template.mask = file.path(fsldir(), "data/standard", "MNI152_T1_1mm_brain_mask.nii.gz"))

orthographic(temp3)
