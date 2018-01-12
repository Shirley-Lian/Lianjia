source('GetInfoFromWeb.R',encoding = 'utf-8')
model <- lm(Price~Floor+Year+Room+Parlor+Area+dec1+dec2+dec3+orl1+orl2+orl3+orl4,data = train_data)