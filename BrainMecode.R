etimg = TRUE)

  # orthographic(temp)
  # orthographic(register)
  # save_register = paste0(pathfolderOUT,filenumber.stub,"_reg")
  # writenii(register,filename = save_register)

  # cog = cog(fast_img, ceil=TRUE)
  # cog = paste("-c",paste(cog,collapse=" "))
  # outfile_without_brain = paste0(pathfolderOUT,filenumber.stub,"_withoutbrain")
  temp3 =fslbet_robust(fast_img, retimg = TRUE, correct = FALSE,
                       recog = TRUE, reorient = FALSE, bet.opts = "", remove.neck = TRUE, swapdim = FALSE,
                       robust.mask = FALSE, remover = "double_remove_neck",
                       template.file = file.path(fsldir(), "data/standard","MNI152_T1_1mm_brain.nii.gz"),
                       template.mask = file.path(fsldir(), "data/standard", "MNI152_T1_1mm_brain_mask.nii.gz"))

  orthographic(temp3)
  ## ----bet_plot, dependson="bet", cache=FALSE------------------------------
  # ortho2(fast_img, temp3 > 0, col.y=alpha("red", 0.5))

  ## ----fast, dependson="bet"-----------------------------------------------
  # outfast = paste0(pathfolderOUT,filenumber.stub,"_BET_FAST")
  fast = fast(file = temp3, opts = '-N')

  register_fast = flirt(infile = fast,reffile = temp_fast,dof = 12,retimg = TRUE)
  save_register_fast = paste0(pathfolderOUT,filenumber.stub,"_reg_fast")
  writenii(register_fast,filename = save_register_fast)

  Train_Data[[fnum,1]]<-register_fast

  ## ----fast_plot, dependson="fast", cache=FALSE----------------------------
  # ortho2(temp3, fast == 3, col.y=alpha("red", 0.5))
  #
  # ## ----fast_plot_csf_gm, dependson="fast", cache=FALSE---------------------
  # ortho2(temp3, fast == 1, col.y=alpha("red", 0.5), text="CSF Results")
  # ortho2(temp3, fast == 2, col.y=alpha("red", 0.5), text="Gray Matter\nResults")

  ## ----outfiles, results='markup'------------------------------------------
  # patternfile = paste0(filenumber.stub,"_BET_FAST")
  # list.files(pattern=patternfile)
  fnum = fnum +1
}
## ---------------- Create list of regester nifti image  -----------------
fnum = 1
w###--------------- libraries -------------
library(methods)
library(neurobase)
library(fslr)
library(extrantsr)
library(scales)
library(knitr)
library(apcluster)
#---- multi dimentional scalling
library(vegan)
library(ecodist)
library(labdsv)
library(ape)
library(ade4)
library(smacof)
library(MASS)
#------------- Watersheds
library(Watersheds)
library(freesurfer)
library(EBImage)
library(imager)
library(spm12r)
library(matlabr)
### ------------ Options Default Values ----------
opts_chunk$set(echo=TRUE, prompt=FALSE, message=FALSE, warning=FALSE, comment="", results='hide', cache= TRUE)
options(fsl.path = "/usr/local/fsl/fsl")
options(fsl.outputtype = "NIFTI_GZ")
options(freesurfer.path = "/Applications/freesurfer")
options(subjects.path = "/Applications/freesurfer/subjects")
options(freesurfer.outputtype = "NIFTI_GZ")
options(matlab.path = "/Applications/MATLAB_R2017b.app/bin")

nm <- list.files(path="~/Documents/Paper/HEDAYATI/BRAIN/BrainMe/SERVER")
nm1 <- list.files(path="~/Documents/Paper/HEDAYATI/BRAIN/BrainMe/SERVER/")
pathfolderREAD = "~/Documents/Paper/HEDAYATI/BRAIN/BrainMe/Data/"
pathfolderOUT = "~/Documents/Paper/HEDAYATI/BRAIN/BrainMe/output/"
pathfolderSER = "~/Documents/Paper/HEDAYATI/BRAIN/BrainMe/SERVER/"
pathfolderOUT_Temp = "~/Documents/Paper/HEDAYATI/BRAIN/BrainMe/output_temp/"
pathfolderOUT_REG = "~/Documents/Paper/HEDAYATI/BRAIN/BrainMe/output_REG/"
temp = readnii("~/Documents/Paper/HEDAYATI/BRAIN/BrainMe/Temp/sub1")
temp_fast = readnii(file.path(fsldir(), "data/standard","MNI152_T1_1mm_brain.nii.gz"))
Train_Data<-matrix(list(), length(nm1), 1)
Train_Data_temp<-matrix(list(), length(nm1), 1)

## ----img----------------------------------------------------------------
# img.name = "AD2.nii"
# img.stub = nii.stub(img.name)
fnum = 1
while (fnum <= length(nm)) {

  filenumber = nm[fnum]
  filenumber.name = filenumber
  filenumber.stub = nii.stub(filenumber.name)

  fileread = paste0(pathfolderREAD,filenumber)
  tasvir = readnii(fileread)

  register = flirt(infile = tasvir,reffile = temp,dof = 6,retimg = TRUE)

  # orthographic(temp)
  # orthographic(register)
  # save_register = paste0(pathfolderOUT,filenumber.stub,"_reg")
  # writenii(register,filename = save_register)

  # cog = cog(fast_img, ceil=TRUE)
  # cog = paste("-c",paste(cog,collapse=" "))
  # outfile_without_brain = paste0(pathfolderOUT,filenumber.stub,"_withoutbrain")
  temp3 =fslbet_robust(fast_img, retimg = TRUE, correct = FALSE,
                       recog = TRUE, reorient = FALSE, bet.opts = "", remove.neck = TRUE, swapdim = FALSE,
                       robust.mask = FALSE, remover = "double_remove_neck",
                       template.file = file.path(fsldir(), "data/standard","MNI152_T1_1mm_brain.nii.gz"),
                       template.mask = file.path(fsldir(), "data/standard", "MNI152_T1_1mm_brain_mask.nii.gz"))

  orthographic(temp3)
  ## ----bet_plot, dependson="bet", cache=FALSE------------------------------
  # ortho2(fast_img, temp3 > 0, col.y=alpha("red", 0.5))

  ## ----fast, dependson="bet"-----------------------------------------------
  # outfast = paste0(pathfolderOUT,filenumber.stub,"_BET_FAST")
  fast = fast(file = temp3, opts = '-N')

  register_fast = flirt(infile = fast,reffile = temp_fast,dof = 12,retimg = TRUE)
  save_register_fast = paste0(pathfolderOUT,filenumber.stub,"_reg_fast")
  writenii(register_fast,filename = save_register_fast)

  Train_Data[[fnum,1]]<-register_fast

  ## ----fast_plot, dependson="fast", cache=FALSE----------------------------
  # ortho2(temp3, fast == 3, col.y=alpha("red", 0.5))
  #
  # ## ----fast_plot_csf_gm, dependson="fast", cache=FALSE---------------------
  # ortho2(temp3, fast == 1, col.y=alpha("red", 0.5), text="CSF Results")
  # ortho2(temp3, fast == 2, col.y=alpha("red", 0.5), text="Gray Matter\nResults")

  ## ----outfiles, results='markup'------------------------------------------
  # patternfile = paste0(filenumber.stub,"_BET_FAST")
  # list.files(pattern=patternfile)
  fnum = fnum +1
}
## ---------------- Create list of regester nifti image  -----------------
fnum = 1
while (fnum <= length(nm1)) {
  filenumber = nm1[fnum]
  filenumber.name = filenumber
  filenumber.stub = nii.stub(filenumber.name)

  fileread = paste0(pathfolderSER,filenumber)
  tasvir = readnii(fileread)

  Train_Data[[fnum,1]]<-as.double(as.matrix(tasvir@.Data))
  Train_Data_temp[[fnum,1]]<-tasvir

  fnum = fnum+1
}
# ---------------- Template Selection With apclustring -------
row = do.call(rbind, Train_Data) # convert list to matrix

#sim <- expSimMat(row, r=2)
#apres <- apcluster(s=sim, q=0.2)

sim <- negDistMat(row, r=2)
apres2 <- apclusterK(s=sim, K=10)
show(apres2)

# --------------- Select exampleres image---------------
examples = as.vector(apres@exemplars)
Templatedata<-matrix(list(), length(examples), 1)
fnum = 1
while (fnum <= length(examples)) {
  filenumber = examples[fnum]

  Temp