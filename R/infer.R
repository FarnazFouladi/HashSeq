#' Inference test
#'
#' @param clusterProperties A table that includes the properties of the clusters
#' @param cluster a cluster table
#' @param  abundanceThreshold threshold for removing low abundant sequences
#'
#' @return a table with significant children
#' @import dplyr
#' @importFrom stats pnorm p.adjust
#' @importFrom utils write.table
#' @noRd
#'
infer<-function(clusterProperties,cluster,abundanceThreshold){

  view_inference_test <- left_join(clusterProperties, cluster, by=c("parentName" = "Parent")) %>%
    arrange(.data$parentName, .data$ChildAbundance) %>%
    mutate(pval = pnorm(log10(.data$ChildAbundance),lower.tail = FALSE, .data$mean.inference,.data$sd.inference)) %>%
    select(.data$parentName,
           .data$parentAbundance,
           .data$ParentSeq,
           .data$Child,
           .data$ChildAbundance,
           .data$ChildSeq,
           .data$NumberOfChildren,
           .data$PositionOfSNP,
           .data$SNP,
           .data$Parent.child,
           .data$pval)
  view_inference_test$pvalAdjusted <- p.adjust(view_inference_test$pval,method = "BH")

  view_inference_test_sig_children <-view_inference_test %>% filter(.data$pvalAdjusted < 0.050, .data$parentAbundance > abundanceThreshold)

  write.table(view_inference_test_sig_children,file.path(paste0("InferenceTestSignificantChildren.txt")),sep="\t",quote = FALSE)
  return(view_inference_test_sig_children)
}
