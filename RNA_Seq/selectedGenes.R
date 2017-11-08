rm(list=ls())
load("summarizedDeResults.RData")
spAnnot <- read.delim("proteinGeneGo.txt", sep="\t", header=FALSE)
colnames(spAnnot) = c("Gene", "Protein", "GeneDesc", "GO")
goDesc <- subset(spAnnot, select=c(GO, Gene))

immune <- goDesc[grep("immune", goDesc$GO),]
immuneGenes<-unique(immune$Gene)
immuneDE <- dfBothAnnot[row.names(dfBothAnnot) %in% immuneGenes, ]
colnames(immuneDE) <- c("lfcM", "pM", "lfcV", "pV", "Desc")
rownames(immuneDE) <- paste(rownames(immuneDE), immuneDE$Desc, sep='-')
immuneDE <- subset(immuneDE, select = c(lfcM, pM, lfcV, pV) )
write.csv(immuneDE, file="ImmuneRelated.csv")