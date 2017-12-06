#!/usr/bin/Rscript
ep<-read.table("epilepsy.txt.assoc.adjusted", header = T)
ep1<-read.table("epilepsy.txt.assoc", header = T)
row<-NULL
for(i in 1:160170){
  if(ep[i,5]<=0.5){
    row <- append(row,i)
  }
}

