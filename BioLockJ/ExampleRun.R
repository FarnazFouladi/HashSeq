#Author: Farnaz Fouladi
#BioLockJ configuration: Alicia Sorgen
#Date: 02-02-21
#Description: 

## Libraries
# library(devtools)
# devtools::install_github("FarnazFouladi/HashSeq")
library(HashSeq)

rm(list=ls())

# Set an input directory where you want to download the sequences
pipeRoot = dirname(dirname(getwd()))
moduleDir <- dirname(getwd())
dir.create(paste0(moduleDir, "/sequences"), showWarnings = FALSE)
seqDir <- paste0(moduleDir, "/sequences")

# Create temp file to store downloaded zip file
temp <- tempfile(fileext = ".zip")

# Download zip file into temp file
download.file("https://github.com/FarnazFouladi/Examples/raw/main/zymo.zip",temp)

# Unzip files into input directory
unzip(zipfile=temp, exdir=seqDir)

# Delete temp file
unlink(temp)

#In case heap size 512MB (default) is not enough:
#options(java.parameters="-Xmx1024m")
inputDir <- file.path(seqDir,"zymo")
outputDir=paste0(moduleDir, "/output")
threshold=1000

inferTrueSequences(inputDir, outputDir, threshold)

pdf(paste0(outputDir, "/LoessPlot.pdf"), height = 7, width = 10)
makeLoessPlot(outputDir,fileName = "childrenProperties.txt")
dev.off()
