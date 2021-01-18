
<!-- README.md is generated from README.Rmd. Please edit that file -->

# HashSeq

<!-- badges: start -->

<!-- badges: end -->

The goal of HashSeq is to infer true biological 16 rRNA sequences from
background error.

## Installation

Install from github with:

``` r
# install.packages("devtools")
devtools::install_github("FarnazFouladi/HashSeq")
```

## Example

Specify the input directory including sequences, and output directory,
and a filter threshold where it is used to remove low abundant sequence
variants.

``` r
library(HashSeq)
inputDir="inst/extdata/example/sequences"
outputDir="inst/extdata/example/output"
threshold=1000
```

Run the inferTrueSequences to generate a count table

``` r
inferTrueSequences(inputDir,outputDir,threshold)
#> [1] "***************PLEASE WAIT.  PROCESSING INPUT SEQUENCES***************"
#> [1] "Class Path: /Library/Frameworks/R.framework/Versions/4.0/Resources/library/rJava/java"                                                       
#> [2] "Class Path: /private/var/folders/xy/_t9k7cp17rlf0j7xk3l006zh0000gn/T/RtmpJ1r2fC/temp_libpatha9b826f810f1/HashSeq/extdata/SequenceVariant.jar"
#> [1] "*****Dimensions of Cluster Table*****"
#> [1] "number of rows: 5643"
#> [1] "number of columns: 10"
#> 
#> [1] "*****Dimensions of Abundance Parents Table*****"
#> [1] "number of rows: 9"
#> [1] "number of columns: 2"
#> 
#> [1] "*****Dimensions of Children Properties Table*****"
#> [1] "number of rows: 230"
#> [1] "number of columns: 10"
#> 
#> [1] "*****Dimensions of Significant Children Table*****"
#> [1] "number of rows: 26"
#> [1] "number of columns: 12"
#> 
#> [1] "Class Path: /Library/Frameworks/R.framework/Versions/4.0/Resources/library/rJava/java"                                                       
#> [2] "Class Path: /private/var/folders/xy/_t9k7cp17rlf0j7xk3l006zh0000gn/T/RtmpJ1r2fC/temp_libpatha9b826f810f1/HashSeq/extdata/SequenceVariant.jar"
#> [1] "******INFERENCE PROCESSING IS COMPLETE******"
#> [1] "TODO:  Add text that informs the user about which methods can be invoked to visualize results."
```

Visualize the mean and standard deviation of one-mimatch variants

``` r
makeLoessPlot(outputDir,clusterProps)
```

<img src="man/figures/README-unnamed-chunk-3-1.png" width="100%" />
