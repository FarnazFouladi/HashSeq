#' Parents with abundance more than a threshold
#'
#' Selects only parents that have an abundance above a threshold
#'
#' @param cluster the table loaded by loadCluster method
#' @param abundanceThreshold  threshold for filtering sequences (defualt=1000)
#'
#' @return a table with parents having abundance above threshold
#' @import dplyr
#' @noRd
#'

getAbundantParents<-function(cluster,abundanceThreshold=1000){

  AbundantParents <- cluster %>% filter(.data$ParentAbundance > abundanceThreshold) %>%
    distinct(parentName = .data$Parent, parentSeq = .data$ParentSeq)
  return(AbundantParents)
}
