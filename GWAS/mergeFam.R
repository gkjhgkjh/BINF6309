#!/usr/bin/Rscript
#read fam file
fam <- read.table("cornell_canine.fam")
#assign col names
colnames(fam)<-c("dogID", "inFam", "inFamF", "inFamM", "sex", "pheno")
#read phenotypes
pheno <- read.table("phenotypes.txt", header = T)
#merge
famPheno<-merge(fam,pheno)
#select fields
famPheno<- subset(famPheno, select=c(dogID, inFam, inFamF, inFamM, sex, epilepsy_irishWolfhounds))
#print into new file
write.table(famPheno, file = "famEpilepsy.fam", col.names = F, row.names = F, quote = F)
