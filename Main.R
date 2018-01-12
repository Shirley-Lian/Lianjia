source("GetInfoFromWeb.R", encoding = "UTF-8")
url <- "https://qd.lianjia.com/ershoufang/shinan/pg"
District <- c('shinan','shibei','licang','laoshan','huangdao','chengyang')
all_Price <- c()
all_Floor <- c()
all_Year <- c()
all_Room <- c()
all_Parlor <- c()
all_Area <- c()
all_village <- c()
all_orientation <- c()
all_Decoration <- c()
for (x in District) {
  url <- "https://qd.lianjia.com/ershoufang/shinan/pg"
  url <- paste(url, x, 'pg',sep="/")
  for(i in 1:getHouseInfo(url,Maxpage)){
    url <- "https://qd.lianjia.com/ershoufang/shinan/pg"
    url <- paste(url, i, sep="")
    Price = getHouseInfo(url,'Price')
    all_Price = c(all_Price, Price)
    Floor = getHouseInfo(url,'FloorInfo')
    all_Floor = c(all_Floor, Floor)
    Year = getHouseInfo(url,'builtYear')
    all_Year = c(all_Year, Year)
    Room = getHouseInfo(url,'Room')
    all_Room = c(all_Room, Room)
    Parlor = getHouseInfo(url,'Parlor')
    all_Parlor = c(all_Parlor, Parlor)
    Area = getHouseInfo(url,'Area')
    all_Area = c(all_Area, Area)
    village = getHouseInfo(url,'village')
    all_village = c(all_village, village)
    orientation = getHouseInfo(url,'orientation')
    all_orientation = c(all_orientation, orientation)
    Decoration = getHouseInfo(url,'Decoration')
    all_Decoration = c(all_Decoration, Decoration)
  }
}