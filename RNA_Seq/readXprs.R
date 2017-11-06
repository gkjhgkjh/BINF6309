#Set a variable with the path containing eXpress file.
xprsPath<-"xprs_gg"
#set a variable with eXpress results filename
xprsFile<-"results.xprs"
#create a vextor of eXpress resuts files
files <- list.files(path = xprsPath,pattern = xprsFile, full.names = T,recursive = T)
#check the vector contents
files
#read the first file
firstFile<-read.delim(files[1],sep="\t")
#Display the top of the first table
head(firstFile)

#Initialize a variable with null to store the merged table
merged<-NULL
#iterate over the vector of eXpress results files
for (file in files) {
  #read results.xprs for the sample as tab-delimited
  nextSample<-read.delim(file,sep="\t")
  #select the two columns we need
  nextSample<-nextSample[,c("target_id","uniq_counts")]
  #rename the uniq_counts column so it identifies the sample
  colnames(nextSample)<-c("transcript",file)
  #if theis is the first results file (merged is null) copy to merged
  if(is.null(merged)){
    merged<-nextSample
  #else merge the next sample
  }
  else{
    merged<-merge(merged,nextSample)
  }
}
head(merged)

#get the column names
uglyColumns=colnames(merged)
#replace the path with an empty string
lessUglyColumns=gsub(paste0(xprsPath,'/'),"",uglyColumns)
lessUglyColumns

#replace /results.xprs with an empty string
prettyColumns=gsub(paste0('/',xprsFile),"",lessUglyColumns)
prettyColumns

#get the column names
uglyColumns=colnames(merged)
#replace path/ with an empty string
lessUglyColumns=gsub(paste0(xprsPath,'/'),"",uglyColumns)
#replace /results.xprs with an empty string
prettyColumns=gsub(paste0('/',xprsFile),"",lessUglyColumns)
prettyColumns
colnames(merged)<- prettyColumns
write.csv(merged, file = "mergedCountTable.csv", row.names = FALSE)









