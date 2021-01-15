#' Fasta file including inferred sequences and parents
#'
#' @param inferredseq
#' @param parents
#' @param outputDir
#'
#' @return
#' @export
#' @import dplyr
#' @examples
writeInferedSequences<-function(inferredseq,parents,outputDir){
  set1 <- inferredseq %>% ungroup() %>% select(parentName)
  set2 <- parents %>% select(parentName)
  parentNameSet <- union(set1, set2)
  view_parent_sequence_exceed_threshold <- parents %>% filter(parentName %in% parentNameSet$parentName)
  Sequences_combined<-c(view_inference_test_sig_children$ChildSeq,view_parent_sequence_exceed_threshold$parentSeq)
  Names_combined<-c(view_inference_test_sig_children$parent.child,view_parent_sequence_exceed_threshold$parentName)
  write.fasta(as.list(Sequences_combined),Names_combined,file.path(outputDir, paste0("sequences.fasta")),nbchar=250)
}
