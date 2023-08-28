er
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
  
  fast_img = fsl_biascorrect(register,retimg = TRUE)
  
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
  
  ## --###--------------- libraries -------------
library(methods)
library(neurobase)
library(fslr)
library(extrantsr)
library(scales)
library(knitr)
library(apcluster)
library(R.matlab)

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

# nm <- list.files(path="~/Desktop/BRAIN/BrainMe/Data")
# nm1 <- list.files(path="~/Desktop/BRAIN/BrainMe/output/")
# pathfolderREAD = "~/Desktop/BRAIN/BrainMe/Data/"
# pathfolderOUT = "~/Desktop/BRAIN/BrainMe/output/"
# pathfolderOUT_Temp = "~/Desktop/BRAIN/BrainMe/output_temp/"
# temp = readnii("~/Desktop/BRAIN/BrainMe/Temp/sub1")
# temp_fast = readnii(file.path(fsldir(), "data/standard","MNI152_T1_1mm_brain.nii.gz"))

nm <- list.files(path="/Elements/Data//AD/1")
nm1 <- list.files(path="/Elements/Data/AD/output/")
pathfolderREAD = "/Elements/Data/AD/"
pathfolderOUT = "/Elements/Data/AD/output/"
pathfolderOUT_Temp = "/Elements/Data/AD/output_temp/"
temp = readnii("~/Desktop/BRAIN/BrainMe/Temp/sub1")
temp_fast = readnii(file.path(fsldir(), "data/standard","MNI152_T1_1mm_brain.nii.gz"))

Train_Data<-matrix(list(), length(nm1), 1)
Train_Data_temp<-matrix(list(), length(nm1), 1)

MatPath = file.path("~/Desktop","MRI_Data.mat")
MRI_Data = readMat(MatPath)

## ----img----------------------------------------------------------------
# img.name = "AD2.nii"
# img.stub = nii.stub(img.name)
fnum = 1
while (fnum <= length(nm)) {
  fnum=1
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
  
  fast_img = fsl_biascorrect(register,retimg = TRUE)
  
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
  
  fileread = paste0(pathfolderOUT,filenumber)
  tasvir = readnii(fileread)
  
  Train_Data[[fnum,1]]<-as.double(as.matrix(tasvir@.Data))
  Train_Data_temp[[fnum,1]]<-tasvir
  
  fnum = fnum+1
}
# ---------------- Template Selection With apclustring -------
row = do.call(rbind, Train_Data) # convert list to matrix
row1 = do.call(rbind, MRI_Data['vect']) # convert list to matrix

sim <- expSimMat(row1, r=2)
apres <- apcluster(s=dsim1, q=0.2)

dsim <- negDistMat(row1, r=2)
dsim1 <- expSimMat(row1, r=2)
# dssim <- as.SparseSimilarityMatrix(dsim,lower=-0.2)
dssim <- as.SparseSimilarityMatrix(dsim)
apres1 <- apclusterK(dssim, K=6, )

show(apres)
# --------------- Select exampleres image---------------
examples = as.vector(apres@exemplars)
Templatedata<-matrix(list(), length(examples), 1)
fnum = 1
while (fnu