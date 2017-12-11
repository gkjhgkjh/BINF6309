#!/usr/bin/Rscript
#read adjusted association result
ep<-read.table("epilepsy.txt.assoc.adjusted", header = T)
row<-NULL
#find rows with significant
for(i in 1:length(ep[,1])){
  if(ep[i,5]<=0.05){
    row <- append(row,i)
  }
}
write.csv(ep[row,], "Bonadj.csv")

