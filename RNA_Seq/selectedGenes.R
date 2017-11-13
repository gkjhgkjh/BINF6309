rm(list=ls())
#Load Summarized DE Results
load("summarizedDeResults.RData")
#Read Annotation Files
spAnnot <- read.delim("proteinGeneGo.txt", sep="\t", header=FALSE)
#Set Column Names
colnames(spAnnot) = c("Gene", "Protein", "GeneDesc", "GO")
#Select Desired Columns
goDesc <- subset(spAnnot, select=c(GO, Gene))

#Find Immune-Related
immune <- goDesc[grep("immune", goDesc$GO),]
immuneGenes<-unique(immune$Gene)
immuneDE <- dfBothAnnot[row.names(dfBothAnnot) %in% immuneGenes, ]
colnames(immuneDE) <- c("lfcM", "pM", "lfcV", "pV", "Desc")
rownames(immuneDE) <- paste(rownames(immuneDE), immuneDE$Desc, sep='-')
immuneDE <- subset(immuneDE, select = c(lfcM, pM, lfcV, pV) )
write.csv(immuneDE, file="ImmuneRelated.csv")