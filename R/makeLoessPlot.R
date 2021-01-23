#' Plot showing the relationship between parent abundance and mean and standard deviation of one-mismatch children.
#'
#' This plot helps to choose an abundance threshold for the "inferTrueSequence.R" function.
#' Based on this plot, a threshold at which the mean or standard deviation of one-mismatch children are
#' not a smooth function of the parent abundance can be chosen for filtering the low abundant sequence variants.
#'
#' @param outputDir The directory where childrenproperties.txt has been saved
#' @param fileName Default=childrenproperties.txt
#'
#' @return Figures
#' @export
#' @import graphics
#'
makeLoessPlot<-function(outputDir, fileName="childrenproperties.txt"){
  clusterProperties<-read.table(file.path(outputDir,"childrenProperties.txt"),sep="\t",header = TRUE)
  par(mfrow=c(1,2))
  makeScatterPlot(clusterProperties,"mean")
  makeScatterPlot(clusterProperties,"sd")
}

makeScatterPlot<-function(clusterProperties,param){
  clusterProperties<-as.data.frame(clusterProperties)
  scattermore::scattermoreplot(log10(clusterProperties$parentAbundance),clusterProperties[,param],
                               ylim=c(0,max(clusterProperties[,param])),cex=0.3,
                               xlab = expression('log'[10]~'abundance of parents'),ylab = param)

  lines(log10(clusterProperties$parentAbundance),clusterProperties[,paste0("predicted",Hmisc::capitalize(param))],col="red",type = "l",lwd=2)
}
