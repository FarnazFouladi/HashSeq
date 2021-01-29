#' Create clusters
#'
#'Creates clusters of parents and one-mismatch children.
#'
#' @param inputDir String
#' @param outputDir String
#' @param countTable Boolean
#'
#' @return writes a text file named as OneMimatchCluster.txt
#' @noRd
#'
processCluster <- function(inputDir,outputDir,countTable=FALSE,mem)
{
  inputParams <- paste('-inputdirectory',inputDir,
                       '-outputdirectory',outputDir,
                       '-finaloutput',countTable)

  inputArray <- rJava::.jarray(strsplit(inputParams, ' ')[[1]])

  # Invoke static sequenceVariant.RunPipelineRefactor.main method
  rJava::.jcall("sequenceVariant/RunPipelineRefactor", returnSig = "V", "main", inputArray)
}
