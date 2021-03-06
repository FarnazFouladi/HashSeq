% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/inferTrueSequences.R
\name{inferTrueSequences}
\alias{inferTrueSequences}
\title{Infer true sequence variants from sequence errors}
\usage{
inferTrueSequences(inputDir, outputDir, abundanceThreshold = 1000, fdr = 0.05)
}
\arguments{
\item{inputDir}{Directory which contains fastq files}

\item{outputDir}{Directory which the outputs are save (This directory does not have exist)}

\item{abundanceThreshold}{An abundance threshold to remove low-abundance sequences Default = 1000.}

\item{fdr}{False discovery rate threshold Default = 0.05.}
}
\value{
writes the following files:
\enumerate{
\item OneMismatchCluster.txt: This file includes parents and one-mismatch children of all clusters.
\item ChildrePpoperties.txt: This file includes mean and standrad deviation of children abundances
for each cluster. This file can be used in "makeLoessPlot" to visualized the relationship between
abundance of parents and mean and standard deviations of children abundances.
\item InferenceTestSignificantChildren.txt: This file includes one-mismatch children that were significant in
an inference test at FDR 5\% and had an abundance above abundanceThreshold.
\item sequences.fata: This fasta file includes parent sequences with an abundance above abundance threshold and
one-mismatch children in "InferenceTestSignificantChildren.txt".
\item A count table with sequence variants in the columns and samples in the rows.
}
}
\description{
This function works on 16S rRNA gene datasets generated from Illumina.
It infers true sequence variants based on the normal distribution and smooth
regression of the background noise.
}
