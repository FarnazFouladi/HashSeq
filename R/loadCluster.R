#' Loading the cluster table "OneMismatchCluster.txt"
#'
#' @param outputDir Output Directory where OneMismatchCluster.txt is placed
#'
#' @return
#' @export
#' @import dplyr
#'
#' @examples
loadCluster<-function(outputDir){

  parentPrefix <- "parent"
  numOfPrefixCharacters <- nchar(parentPrefix)
  addLeadingZeros <- function(input, maxCount){paste0(parentPrefix, paste0(rep("0", maxCount-nchar(strsplit(input, parentPrefix)[[1]][2])), collapse=""), strsplit(input, "parent")[[1]][2]) }

  # Retrieve source data file
  df <- read.table(file.path(outputDir,"OneMismatchCluster.txt") ,sep="\t", header=TRUE, stringsAsFactors=F)
  offset <- max(nchar(df$Parent)) - numOfPrefixCharacters
  df$Parent = sapply(df$Parent, addLeadingZeros, numOfPrefixCharacters)
  df<-df %>% mutate(Parent.child=paste0(Parent, "_", Child))
  return(df)
}
