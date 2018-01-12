#创建数据库链接
con <- dbConnect(MySQL(), user = "root", password = "123", dbname="lekecheng", host = "127.0.0.1")
#设置循环MySQL命令
for (i in 1:length(all_movies)) {
  #向MySQL插入一条数据
  sql = sprintf("insert into movie_info set movie_name = '%s',director='%s',rating='%s'",all_movies[i], Director[i], Rating[i])
  #连接到数据库执行sql命令
  information <- dbSendQuery(con, sql)
}

#连接数据库提取所有数据
result <- dbSendQuery(con, 'SELECT * FROM movie_info')
#将数据存储到变量
data <-fetch(result)
#断开连接
dbDisconnect(con)