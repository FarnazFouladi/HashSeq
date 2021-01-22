#' Loads the cluster table "OneMismatchCluster.txt with automatic retries"
#'
#' @param outputDir output directory where the OneMismatch is saved
#' @importFrom utils read.table
#' @noRd
#'
loadOneMismatchClusterFile <- function(outputDir)
{
  readIntervals <- c(rep(60, 360), -1)
  result <- NULL
  targetFileName <- 'OneMismatchCluster.txt'
  spacer <- '********'

  for(i in readIntervals)
  {
    tryCatch(
      {
        df <- NULL
        message(paste(spacer, "Attempting to load", targetFileName, spacer))
        df <- read.table(file.path(outputDir,"OneMismatchCluster.txt") ,sep="\t", header=TRUE, stringsAsFactors=F)
      },
      error=function(cond) {
        message("ERROR:")
        message(cond)
      },
      warning=function(cond) {
        message("WARNING:")
        message(cond)
      },
      finally={
        if(is.null(df))
        {
          if(i > 0)
          {
            cat('\n')
            message(paste("RETRYING IN", i, "SECONDS"))
            Sys.sleep(i)
          }
          else
          {
            break
          }
        }
        else
        {
          result <- df
          message(paste("Successfully retrieved contents for file", targetFileName))
          break
        }
      }
    )
  }
  if(is.null(result))
  {
    cat('\n')
    stop(paste("Unable to retrieve contents for file", targetFileName, "after", (length(readIntervals) - 1), "retries."))
  }

  return (result)
}
