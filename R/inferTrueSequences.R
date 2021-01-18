#' Infer true amplicon sequence variants
#'
#'Invokes algorithm to infer true amplicon sequence variants.
#'
#' @param inputDir String
#' @param outputDir String
#' @param abundanceThreshold threshold to remove low abundance sequences
#' @param countTable Boolean
#'
#' @return TODO:  determine what result to return
#' @export
#'
#'
inferTrueSequences <- function(inputDir,outputDir,abundanceThreshold=1000, countTable=FALSE)
{
  print("***************PLEASE WAIT.  PROCESSING INPUT SEQUENCES***************")
  printDim <- function(df, name)
  {
    print(paste0("*****Dimensions of ", name, "*****"))
    print(paste0("number of rows: ", nrow(df)))
    print(paste0("number of columns: ", ncol(df)))
    cat('\n')
  }
  processCluster(inputDir,outputDir)

  cluster <- loadCluster()
  printDim(cluster, "Cluster Table")

  dfAbundantParents <- getAbundantParents(cluster,abundanceThreshold)
  printDim(dfAbundantParents, "Abundance Parents Table")

  childrenProperties <- getMeanAndSD(cluster)
  printDim(childrenProperties, "Children Properties Table")

  significantChildren <- infer(childrenProperties,cluster,abundanceThreshold)
  printDim(significantChildren, "Significant Children Table")

  writeFastaSeq(significantChildren,dfAbundantParents)

  print("******INFERENCE PROCESSING IS COMPLETE******")
  print("TODO:  Add text that informs the user about which methods can be invoked to visualize results.")

}
