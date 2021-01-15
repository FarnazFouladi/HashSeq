#' Loading the cluster table "OneMismatchCluster.txt"
#'
#' @export
#' @import dplyr
#' @importFrom utils read.table
#'
#'
loadCluster<-function(){

  parentPrefix <- "parent"
  numOfPrefixCharacters <- nchar(parentPrefix)
  addLeadingZeros <- function(input, maxCount){paste0(parentPrefix, paste0(rep("0", maxCount-nchar(strsplit(input, parentPrefix)[[1]][2])), collapse=""), strsplit(input, "parent")[[1]][2]) }

  # Retrieve source data file
  df <- read.table(file.path("OneMismatchCluster.txt") ,sep="\t", header=TRUE, stringsAsFactors=F)
  offset <- max(nchar(df$Parent)) - numOfPrefixCharacters
  df$Parent = sapply(df$Parent, addLeadingZeros, numOfPrefixCharacters)
  df<-df %>% mutate(Parent.child=paste0(.data$Parent, "_", .data$Child))
  return(df)
}
