#' Inference test
#'
#' @param clusterProperties
#' @param cluster
#' @param outputDir
#'
#' @return
#' @export
#' @import dplyr
#'
#' @examples
infer<-function(clusterProperties,cluster,abundanceThreshold,outputDir){

  view_inference_test <- left_join(clusterProperties, cluster, by=c("parentName" = "Parent")) %>%
    arrange(parentName, ChildAbundance) %>%
    mutate(pval = pnorm(log10(ChildAbundance),lower.tail = FALSE, mean.inference,sd.inference)) %>%
    select(parentName, parentAbundance, childName = Child, childAbundance = ChildAbundance, pval)
  view_inference_test$pvalAdjusted <- p.adjust(view_inference_test$pval,method = "BH")

  view_inference_test_sig_children <-
    left_join(view_inference_test %>% filter(pvalAdjusted < 0.050, parentAbundance > abundanceThreshold),
              df, by=c('parentName' = 'Parent', 'childName' = 'Child')) %>%
    select(parentName,
           parentAbundance,
           ParentSeq,
           childName,
           childAbundance,
           ChildSeq,
           NumberOfChildren,
           PositionOfSNP,
           SNP,
           Parent.child,
           pval,
           pvalAdjusted)
  write.table(view_inference_test_sig_children,file.path(outputDir, paste0("InferenceTestSignificantChildren.txt")),sep="\t",quote = FALSE)
  return(view_inference_test_sig_children)
}
