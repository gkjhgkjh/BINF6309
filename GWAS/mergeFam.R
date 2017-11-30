#!/usr/bin/Rscript
fam <- read.table("cornell_canine.fam")
colnames(fam)<-c("dogID", "inFam", "inFamF", "inFamM", "sex", "pheno")
pheno <- read.table("phenotypes.txt", header = T)
famPheno<-merge(fam,pheno)
famPheno<- subset(famPheno, select=c(dogID, inFam, inFamF, inFamM, sex, epilepsy_irishWolfhounds))
write.table(famPheno, file = "famEpilepsy.fam", col.names = F, row.names = F, quote = F)
