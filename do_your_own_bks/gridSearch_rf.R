library("e1071")
library("randomForest")

createBitVectors <- function(num_features){
  tmp_array <- {}
  num_rows <- 2^num_features
  for (i in 0:(num_rows-1)){
    aux <- intToBits(i)
    for (j in 1:num_features){
      tmp_array <- c(tmp_array, as.numeric(aux[j]))
    }
  }
  features <- matrix(tmp_array,  nrow=num_rows, ncol=num_features, byrow =TRUE)
  return (features)
}

createTrainingMatrix <- function(tableName, features){
  min_count_valid <- 0
  bkstable <- read.table(tableName, head=FALSE)
  just_ones <- bkstable[,2]
  total_count <- bkstable[,3]
  num_features <- log(nrow(bkstable),2)
  ratio <- just_ones/total_count
  dataset <- cbind(features, ratio)
  dataset <- dataset[total_count>min_count_valid, ]
  return (dataset)
}

createLockUpTable = function(name, dataset, features, nT, mT) {
  #training
  model.randomForest = randomForest(dataset[,1:ncol(dataset)-1], dataset[,ncol(dataset)], ntree=nT, mtry=mT)
  predicted_values <- predict(model.randomForest, features) #predict for full dataset
  #build output
  output <-cbind(features, predicted_values)
  #write
  write.table(output, paste("../bks_new_tables/rf/",substr(name, 1, nchar(name)-4),"_",nT,"_",mT,".csv",sep=""), row.names = FALSE, col.names=FALSE)
  
}

#createLockUpTable(tableName, tableName1, num_features, C, G)
ntree <- c(100, 250, 500, 750, 1000, 1250, 1500, 1750, 2000, 2250)


folder <-'bks_original_tables'
tables <- list.files(folder, pattern = "csv", full.names=F)
setwd(folder)
for(tableName in tables){

  
  features <- createBitVectors(8)
  dataset <- createTrainingMatrix(tableName, features)
  
  mtry <- 2:(ncol(dataset)-1)
  for (nt in ntree) {
    for (mt in mtry) {
      createLockUpTable(tableName, dataset, features, nt, mt)
    }
  }
}

