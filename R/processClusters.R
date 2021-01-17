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
processCluster <- function(inputDir,outputDir,countTable=FALSE)
{
  # initialize Java Virtual Machine (JVM)
  rJava::.jinit()

  inputParams <- paste('-inputdirectory',inputDir,
                       '-outputdirectory',outputDir,
                       '-finaloutput',countTable)

  inputArray <- rJava::.jarray(strsplit(inputParams, ' ')[[1]])
  jarDir <- system.file('extdata',package = 'HashSeq')
  jarName <- 'SequenceVariant.jar'

  # Add JAR file to class path
  rJava::.jaddClassPath(file.path(jarDir, jarName))

  # Display class path
  print(paste0('Class Path: ', rJava::.jclassPath()))

  # Invoke static sequenceVariant.RunPipelineRefactor.main method
  rJava::.jcall("sequenceVariant/RunPipelineRefactor", returnSig = "V", "main", inputArray)

  setwd(outputDir)
}
