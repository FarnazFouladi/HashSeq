#' Create clusters
#'
#'Creates clusters of parents and one-mismatch children.
#'
#' @param inputDir String
#' @param outputDir String
#' @param finaloutput Boolean
#'
#' @return writes a text file named as OneMimatchCluster.txt
#' @export
#'
#' @examples
createCluster <- function(inputDir,outputDir,finaloutput=FALSE)
{
  # initialize Java Virtual Machine (JVM)
  rJava::.jinit()

  inputParams <- paste('-inputdirectory',inputDir,
                       '-outputdirectory',outputDir,
                       '-finaloutput',finaloutput)

  inputArray <- rJava::.jarray(strsplit(inputParams, ' ')[[1]])
  jarDir <- '.'
  jarName <- 'SequenceVariant.jar'

  # Add JAR file to class path
  rJava::.jaddClassPath(file.path(jarDir, jarName))

  # Display class path
  print(paste0('Class Path: ', .jclassPath()))

  # Invoke static sequenceVariant.RunPipelineRefactor.main method
  rJava::.jcall("sequenceVariant/RunPipelineRefactor", returnSig = "V", "main", inputArray)
}



