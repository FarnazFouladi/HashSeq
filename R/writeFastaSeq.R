#' Fasta file including inferred sequences and parents
#'
#' @param inferredseq Significant children
#' @param parents parents with abundance above the threshold
#' @param outputDir output directory
#'
#' @return writes a fasta file
#' @import dplyr
#' @noRd
#'
writeFastaSeq<-function(inferredseq,parents,outputDir)
{
  set1 <- inferredseq %>% ungroup() %>% select(.data$parentName)
  set2 <- parents %>% select(.data$parentName)
  parentNameSet <- union(set1, set2)
  view_parent_sequence_exceed_threshold <- parents %>% filter(.data$parentName %in% parentNameSet$parentName)
  Sequences_combined<-c(inferredseq$ChildSeq,view_parent_sequence_exceed_threshold$parentSeq)
  Names_combined<-c(inferredseq$Parent.child,view_parent_sequence_exceed_threshold$parentName)
  seqinr::write.fasta(as.list(Sequences_combined),Names_combined,file.path(outputDir,paste0("sequences.fasta")),nbchar=nchar(Sequences_combined[1]))
}
