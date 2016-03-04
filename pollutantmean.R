pollutantmean <- function(directory,pollutant, id=1:332){
    oid <- getwd()

#    print(id)
#    setwd(directory)
    mydata <- data.frame(matrix(ncol = 1, nrow = 1))
    for (e in id){
        if (e<10){
            p <- "00"
        }else if (e < 100){
            p <- "0"
        }else{
            p <- ""
        }
        fp <- file.path(directory,paste0(p,e,".csv",""))
        if (file.exists(fp)){
            newdata <- read.csv(fp)
            if (dim(mydata)[1] > 1){
                mydata = rbind(mydata,newdata)
            }else{
                mydata = newdata
            }
        }else{
            print("NOT")
        }
    }
    
    print(mean(mydata[[pollutant]],na.rm=TRUE))

    #setwd(oid)
}
complete <- function(directory,id=1:332){
    
    #    print(id)
    #    setwd(directory)
    mydata <- data.frame(matrix(ncol = 2, nrow = 1))
    names(mydata) <- c("id","nobs")
    for (e in id){
        if (e<10){
            p <- "00"
        }else if (e < 100){
            p <- "0"
        }else{
            p <- ""
        }
        fp <- file.path(directory,paste0(p,e,".csv",""))
        if (file.exists(fp)){
            nd <- read.csv(fp)
            bv <- complete.cases(nd[2],nd[3])  # Incase column 2 and 3 aren't uniformly NA!
            gd = nd[bv,]
            mydata <- rbind(mydata,c(e,dim(gd)[1]))
        }
    }
    print(mydata)
}


corr <- function(directory,threshold=0){
    # Leave id= in there for debugging purposes
    #    print(id)
    #    setwd(directory)
    ans <- c()
    dp <- file.path(directory)
    lf = list.files(dp)
    
    for (e in lf){
        fp <- file.path(directory,e)
        if (file.exists(fp)){
            nd <- read.csv(fp)
            bv <- complete.cases(nd[2],nd[3])  # Incase column 2 and 3 aren't uniformly NA!
            gd = nd[bv,]
            if (dim(gd)[1] >= threshold){
                nc <- cor(gd[2],gd[3])
                ans <- c(ans,nc)
            }
 
 
        }
    }
    ans
}
