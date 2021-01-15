#' Plot showing the relationship between parent abundance and mean and standard deviation
#'
#' @param clusterProperties a table of clusters
#'
#' @return Figures
#' @export
#' @import graphics
#'
#'
makeLoessPlot<-function(clusterProperties){
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

