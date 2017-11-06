#set timezone. un-comment the line for your timezone
Sys.setenv(TZ="US/Eastern")
#Sys.setenv(TZ="US/Central")
#Sys.setenv(TZ="US/Moutain")
#Sys.setenv(TZ="US/Pacific")

#install knitr to support R Markdown
install.packages("knitr")

#install RColorBrewer to provide palette for plot colors
install.packages("RcolorBrewer",quiet = T)

#install devtools to support package installation form github
install.packages("devtools")

#install pheatmap to pruduce heatmaps
install.packages("pheatmap", quiet = T)

#set the source to BioConductor
source("http://bioconductor.org/biocLite.R")
#Update all BioConductor packages
biocLite(ask=F)

#install DESeq2
biocLite("DESeq2", quiet=T,ask=F, suppressUpdates = T)
#install limma for venn diagrams
biocLite("limma", ask=F, suppressUpdates = T)


