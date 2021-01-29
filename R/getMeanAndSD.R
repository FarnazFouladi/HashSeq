#' Properties of clusters
#'
#' Mean and standard deviation for each cluster are calculated and then means and
#' standard deviations are fitted to a LOESS regression as a function of parent abundance.
#'
#' @param clusters A table of clusters with parents and children
#' @param outputDir output directory
#' @import dplyr
#' @importFrom utils write.table
#' @importFrom stats sd median var loess predict
#' @noRd
#'
getMeanAndSD<-function(clusters,outputDir){
   # parents with more than one child
  df1 <-  clusters %>% filter(!is.na(.data$ChildAbundance), .data$NumberOfChildren > 1)

  #children properties
  df2 <-  df1 %>%
    group_by(parent = desc(.data$ParentAbundance), parentName=.data$Parent) %>%
    summarize(mean=mean(log10(.data$ChildAbundance)), sd=sd(log10(.data$ChildAbundance)),
              variance=var(log10(.data$ChildAbundance)),median=median(log10(.data$ChildAbundance)),
              numOfChildren=n())  %>%
    select(.data$parentName, parentAbundance = .data$parent,
           .data$numOfChildren, .data$mean, .data$sd, .data$median) %>%
    mutate(parentAbundance = -(.data$parentAbundance))

  #LOESS regression
  fitMean <-loess( df2$mean ~ log10(df2$parentAbundance),span = 0.15)
  fitSD<-loess( df2$sd ~ log10(df2$parentAbundance),span = 0.15)

  df3 <- df2 %>%  mutate(
    predictedMean = predict(fitMean,log10(.data$parentAbundance)),
    predictedSd = predict(fitSD,log10(.data$parentAbundance)),
    mean.inference = ifelse(.data$predictedMean > .data$mean, .data$predictedMean, .data$mean),
    sd.inference = ifelse(.data$predictedSd > .data$sd, .data$predictedSd, .data$sd) )
  write.table(df3,file.path(outputDir,paste0("childrenProperties.txt")),sep="\t",quote = FALSE,row.names = FALSE)
  return(df3)
}
