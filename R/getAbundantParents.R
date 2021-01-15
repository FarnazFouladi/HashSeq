#' Parents with abundance more than a threshold
#'
#' Selects only parents that have an abundance above a threshold
#'
#' @param cluster table loaded by loadCluster method
#' @param abundanceThreshold  threshold for filtering sequences defualt=1000
#'
#' @return
#' @export
#' @import dplyr
#' @examples
getAbundantParents<-function(cluster,abundanceThreshold=1000){

  AbundantParents <- cluster %>% filter(ParentAbundance > abundanceThreshold) %>%
    distinct(parentName = Parent, parentSeq = ParentSeq)
  return(AbundantParents)
}
