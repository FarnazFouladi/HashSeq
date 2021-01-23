#' Infer true sequence variants from sequence errors
#'
#'This function works on 16S rRNA gene datasets generated from Illumina.
#'It infers true sequence variants based on the normal distribution and smooth
#'regression of the background noise.
#'
#' @param inputDir Directory which contains fastq files
#' @param outputDir Directory which the outputs are save (This directory does not have exist)
#' @param abundanceThreshold An abundance threshold to remove low-abundance sequences Default = 1000.
#'
#' @return writes the following files:
#' 1. OneMismatchCluster.txt: This file includes parents and one-mismatch children of all clusters.
#' 2. ChildrePpoperties.txt: This file includes mean and standrad deviation of children abundances
#'    for each cluster. This file can be used in "makeLoessPlot" to visualized the relationship between
#'    abundance of parents and mean and standard deviations of children abundances.
#' 3. InferenceTestSignificantChildren.txt: This file includes one-mismatch children that were significant in
#'    an inference test at FDR 5% and had an abundance above abundanceThreshold.
#' 4. sequences.fata: This fasta file includes parent sequences with an abundance above abundance threshold and
#'    one-mismatch children in "InferenceTestSignificantChildren.txt".
#' 5. A count table with sequence variants in the columns and samples in the rows.
#'
#'
#' @export
#'
#'
inferTrueSequences <- function(inputDir,outputDir,abundanceThreshold=1000)
{
  print("***************PLEASE WAIT.  PROCESSING INPUT SEQUENCES***************")
  printDim <- function(df, name)
  {
    print(paste0("*****Dimensions of ", name, "*****"))
    print(paste0("number of rows: ", nrow(df)))
    print(paste0("number of columns: ", ncol(df)))
    cat('\n')
  }
  #options(java.parameters = mem)
  processCluster(inputDir,outputDir)

  cluster <- loadCluster(outputDir)
  printDim(cluster, "Cluster Table")

  dfAbundantParents <- getAbundantParents(cluster,abundanceThreshold)
  printDim(dfAbundantParents, "Abundance Parents Table")

  childrenProperties <- getMeanAndSD(cluster,outputDir)
  printDim(childrenProperties, "Children Properties Table")

  significantChildren <- infer(childrenProperties,cluster,abundanceThreshold,outputDir)
  printDim(significantChildren, "Significant Children Table")

  writeFastaSeq(significantChildren,dfAbundantParents,outputDir)

  processCluster(inputDir,outputDir,countTable = TRUE)

  print("******INFERENCE PROCESSING IS COMPLETE******")

}
