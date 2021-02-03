## build command: docker build -f hashSeq.Dockerfile -t asorgen/hashseq:v1 .
## Use this for a lot of the R scripts


# Install R version 4.0.2
FROM rocker/tidyverse:4.0.2


#1.) set shell to bash
SHELL ["/bin/bash", "-c"]
ARG DEBIAN_FRONTEND=noninteractive


# Make ~/.R
RUN mkdir -p $HOME/.R

RUN apt-get update && \
    apt-get install -y openjdk-11-jdk && \
    apt-get install -y liblzma-dev && \
    apt-get install -y libbz2-dev

RUN Rscript -e "install.packages('rJava')"


#2.) Install R Packages 
RUN Rscript -e "devtools::install_github('FarnazFouladi/HashSeq')" 

#3.) check that packages installed
#RUN Rscript -e "library('devtools') "
#RUN R -e "library('HashSeq') "

#4.) Cleanup
RUN	apt-get clean && \
	find / -name *python* | xargs rm -rf && \
	rm -rf /tmp/* && \
	rm -rf /usr/share/* && \
	rm -rf /var/cache/* && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/log/*
