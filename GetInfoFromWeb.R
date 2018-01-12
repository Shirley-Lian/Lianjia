
url <- "https://qd.lianjia.com/ershoufang/shinan/pg"
getHouseInfo <- function(url,type){
  House <- readLines(url,encoding = "UTF-8")
  #房屋位置所在信息
  reserve_1 <- gregexpr('<div class="positionInfo">.*?</div>', House)
  #房屋信息所在位置
  reserve_2 <- gregexpr('<span class=\"houseIcon\">.*?</div>', House)
  #价格所在位置
  reserve_3 <- gregexpr('<div class="totalPrice"><span>\\d+</span>万', House)
  #
  Maxpage <- gregexpr('"totalPage":\\d+', House)

  #取出有信息的对象所在的下标
  for (i in 1:length(reserve_1)){
    if(reserve_1[i][[1]] != -1){
     des = i
     break
    }
  }
  Position <- c()
  HouseInfo <- c()
  PriceInfo <- c()
  FloorInfo <- c()
  builtYear <- c()
  village <- c()
  RoomInfo <- c()
  ParlorInfo <- c()
  AreaInfo <- c()
  orientationInfo <- c()
  DecorationInfo <- c()
  totalPriceInfo <- c()
  for (i in 1:length(reserve_1[des][[1]])) {
    #提取这一页所有的位置信息
    Position[i] <- substring(House[des],reserve_1[des][[1]][i],reserve_1[des][[1]][i]+attr(reserve_1[des][[1]],"match.length")-1)
    HouseInfo[i] <- substring(House[des],reserve_2[des][[1]][i],reserve_2[des][[1]][i]+attr(reserve_2[des][[1]],"match.length")-1)
    PriceInfo[i] <- substring(House[des],reserve_3[des][[1]][i],reserve_3[des][[1]][i]+attr(reserve_3[des][[1]],"match.length")-1)
    if(type == "FloorInfo"){
      FloorInfo[i] <- as.numeric(gsub('(.*?共)|(层.*)','',Position[i]))

    }else if(type == "builtYear"){
      Year <- gregexpr('\\d+年',Position[i])
      builtYear[i] <- as.numeric(substring(Position[i],Year[1][[1]][1],Year[1][[1]][1]+attr(Year[1][[1]],"match.length")-2))

    }else if(type == "village"){
      village[i] <- gsub('(.*\">)|(</a>.*)','',HouseInfo[i])

    }else if(type == "Room"){
      Room <- gregexpr('\\d+室',HouseInfo[i])
      RoomInfo[i] <- as.numeric(substring(HouseInfo[i],Room[1][[1]][1],Room[1][[1]][1]+attr(Room[1][[1]],"match.length")-2))

    }else if(type == "Parlor"){
      Parlor <- gregexpr('\\d+厅',HouseInfo[i])
      ParlorInfo[i] <- as.numeric(substring(HouseInfo[i],Parlor[1][[1]][1],Parlor[1][[1]][1]+attr(Parlor[1][[1]],"match.length")-2))

    }else if(type == "Area"){
      Area <- gregexpr('\\d+\\.?\\d+平米',HouseInfo[i])
      AreaInfo[i] <- as.numeric(substring(HouseInfo[i],Area[1][[1]][1],Area[1][[1]][1]+attr(Area[1][[1]],"match.length")-3))

    }else if(type == "orientation"){
      orientationInfo[i] <- gsub('(.*?平米\\s+\\|)|([|].*)','',HouseInfo[i])

    }else if(type == "Decoration"){
      DecorationInfo[i] <- gsub('.*?平米\\s+\\|.*?\\|','',HouseInfo[i])
      DecorationInfo[i] <- gsub('([|].*)|(</d.*)', '',DecorationInfo[i])

    }else if(type == "Price"){
      totalPriceInfo[i] <- gsub('<div class=\"totalPrice\"><span>|</span>万','',PriceInfo[i])
    }

  }
  
  Max_page <- as.numeric(substring(maxpage[827],Maxpage[827][[1]][1]+nchar('"totalPage":'),Maxpage[827][[1]][1]+attr(Maxpage[827][[1]],"match.length")-1))
  
  switch(type,
         'FloorInfo' = return(FloorInfo),
         'builtYear' = return(builtYear),
         'village' =  return(village),
         'Room' = return(RoomInfo),
         'Parlor' = return(ParlorInfo),
         'Area' = return(AreaInfo),
         'orientation' = return(orientationInfo),
         'Decoration' = return(DecorationInfo),
         'Price' = return(totalPriceInfo),
         'Maxpage' = return(Max_page))
  }
source('util.R',encoding = 'UTF-8')
dec <- oneHotDec(getHouseInfo(url,'Decoration'))
orl <- oneHotO(getHouseInfo(url,'orientation'))
train_data <- data.frame(
  Floor = getHouseInfo(url,'FloorInfo'),
  Year = getHouseInfo(url,'builtYear'),
  Room = getHouseInfo(url,'Room'),
  Parlor = getHouseInfo(url,'Parlor'),
  Area = getHouseInfo(url,'Area'),
  dec1 = dec[,1],
  dec2 = dec[,2],
  dec3 = dec[,3],
  orl1 = orl[,1],
  orl2 = orl[,2],
  orl3 = orl[,3],
  orl4 = orl[,4],
  Price = getHouseInfo(url,'Price')
)

