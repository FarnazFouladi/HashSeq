#' Properties of clusters
#'
#' Mean and standard deviation for each cluster are calculated and then means and
#' standard deviations are fitted to a LOESS regression as a function of parent abundance.
#'
#' @param clusters
#' @param outputDir
#'
#' @return
#' @export
#' @import dplyr
#'
#' @examples
getMeanAndSD<-function(clusters,outputDir){

   # parents with more than one child
  df1 <-  clusters %>% filter(!is.na(ChildAbundance), NumberOfChildren > 1)

  #children properties
  df2 <-  df1 %>%
    group_by(parent = desc(ParentAbundance), parentName=Parent) %>%
    summarize(mean=mean(log10(ChildAbundance)), sd=sd(log10(ChildAbundance)),
              variance=var(log10(ChildAbundance)),median=median(log10(ChildAbundance)),
              numOfChildren=n())  %>%
    select(parentName, parentAbundance = parent,
           numOfChildren, mean, sd, median) %>%
    mutate(parentAbundance = -parentAbundance)

  #LOESS regression
  fitMean <-loess( df2$mean ~ log10(df2$parentAbundance),span = 0.15)
  fitSD<-loess( df2$sd ~ log10(df2$parentAbundance),span = 0.15)

  df3 <- df2 %>%  mutate(
    predictedMean = predict(fitMean,log10(parentAbundance)),
    predictedSd = predict(fitSD,log10(parentAbundance)),
    mean.inference = ifelse(predictedMean > mean, predictedMean, mean),
    sd.inference = ifelse(predictedSd > sd, predictedSd, sd) )
  write.table(df3,file.path(outputDir, paste0("childrenProperties.txt")),sep="\t",quote = FALSE)
  return(df3)
}






