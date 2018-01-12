oneHotDec <- function(decol){
  x <- c()
  for (d in decol) {
   if(gsub('\\s*','',d) == '精装'){
    x <- rbind(x,c(1,0,0))
   }else if(gsub('\\s*','',d) == '简装'){
    x <- rbind(x,c(0,1,0))
   }else{
    x <- rbind(x,c(0,0,1))
  }
  }
  return(x)
}

oneHotO <- function(orientation){
  res <- c()
  orl <- gsub('\\s*','',orientation)
  x1 <- strsplit(orl,'')
  for (l in 1:length(x1)) {
    re <- c(0,0,0,0)
    for (i in 1:length(x1[[l]])) {
      if(x1[[l]][i] == '东'){
        re[1] <- 1
      }else if (x1[[l]][i] == '南'){
        re[2] <- 1
      }else if (x1[[l]][i] == '西'){
        re[3] <- 1
      }else if (x1[[l]][i] == '北'){
        re[4] <- 1
      }
    }
    res <- rbind(res, re)
  }
  return(res)
}
