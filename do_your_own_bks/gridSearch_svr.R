#regressão na tabela BKS usando Support Vector Regression
library("e1071")
library("randomForest")

#cria vetores de bit
createBitVectors <- function(num_features)
{
    #zera a matriz
	  tmp_array <- {}
	  #número de linhas será, nesse caso, 2^8=256 linhas
  	num_rows <- 2^num_features
  
	  for (i in 0:(num_rows-1))
	  {
        aux <- intToBits(i)
    
  		  for (j in 1:num_features)
		    {
      			tmp_array <- c(tmp_array, as.numeric(aux[j]))
    		}
  	}
  	
    features <- matrix(tmp_array,  nrow=num_rows, ncol=num_features, byrow =TRUE)
  	
    return (features)
}

createTrainingMatrix <- function(tableName, features)
{
  min_count_valid <- 0
  bkstable <- read.table(tableName, head=FALSE)
  just_ones <- bkstable[,2]
  total_count <- bkstable[,3]
  num_features <- log(nrow(bkstable),2)
  ratio <- just_ones/total_count
  #Combina horizontalmente as duas matrizes
  dataset <- cbind(features, ratio)
  
  #do que se trata isso?
  #elimina onde total de ocorrências é negativo, pelo fato da regressão?
  dataset <- dataset[total_count>min_count_valid, ]
  return (dataset)
}

createLockUpTable = function(name, dataset, features, C, G) 
{
  #training
  model.svm <- svm(dataset[,1:ncol(dataset)-1], dataset[,ncol(dataset)], type="nu-regression", cost=C, gamma=G)
  predicted_values <- predict(model.svm, features) #predict for full dataset
  #build output
  output <-cbind(features, predicted_values)
  #write
  #setwd('new_tables')
  write.table(output, paste("../bks_new_tables/svr/",substr(name, 1, nchar(name)-4),"_",C,"_",G,".csv",sep=""), row.names = FALSE, col.names= FALSE)
}

#createLockUpTable(tableName, tableName1, num_features, C, G)
costo = 2^(-3:10)
gamma = 2^(-3:10)

folder <- 'bks_original_tables'
tables <- list.files(folder, pattern = "csv", full.names=F)

setwd(folder)
for(tableName in tables){

  features <- createBitVectors(8)
  dataset <- createTrainingMatrix(tableName, features)
  
  for (c in costo) {
    for (g in gamma) {
      createLockUpTable(tableName, dataset, features, c, g)
    }
  }
}

