#!/usr/bin/Rscript
ep<-read.table("epilepsy.txt.assoc.adjusted", header = T)
row<-NULL
for(i in 1:length(ep[,1])){
  if(ep[i,5]<=0.05){
    row <- append(row,i)
  }
}
write.csv(ep[row,], "Bonadj.csv")

