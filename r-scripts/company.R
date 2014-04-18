#######################################
#COMP Vs Uni
#######################################
a<-sqldf('select Bachelors_University university, avg(Compensation) avg from CEO_Uni where Bachelors_University <> "NA" group by Bachelors_University order by avg desc limit 10' )
options("scipen"=100, "digits"=4)
par(xaxt="n") 
xf<-factor(a$university) 
plot(xf, a$avg, xlab='') 
text(xf, par("usr")[3] - 0.25,labels=a$university, srt = 60, pos = 2, xpd = TRUE, cex=0.75)


########################################
#Count Vs Universities
########################################

a<-sqldf('select Bachelors_University university, count(*) avg from CEO_Uni where Bachelors_University <> "NA" group by Bachelors_University order by avg desc limit 10' )
options("scipen"=100, "digits"=4)
par(las=1) 
xf<-factor(a$university) 
barplot(a$avg, main="Universities",ylab="Count", names.arg=xf, border="blue", cex.names=0.75, col=c("lightblue"), cex.axis=1)

#######################################
#Popular universities vs Compensation
######################################

a<-sqldf('select Bachelors_University university, avg(Compensation) avg from CEO_Uni where Bachelors_University <> "NA" group by Bachelors_University order by avg desc limit 10' )
options("scipen"=100, "digits"=4)
par(las=1) 
xf<-factor(a$university) 
barplot(a$avg, main="Universities",ylab="Count", names.arg=xf, border="blue", cex.names=0.75, col=c("lightblue"), cex.axis=1)


#######################################
#Popular universities vs Compensation
######################################

sqldf("select ceo.Name, ceo.symbol, stock.Date, stock.Close, (stock.open - stock.Close) from CEO_DataSet_Final ceo, Stock_Data stock where ceo.symbol = stock.symbol and university='Harvard University' group by ceo.symbol")
summary(CEO_DataSet_Final)
options("scipen"=100, "digits"=4)
par(las=1) 
xf<-factor(a$university) 
barplot(a$avg, main="Universities",ylab="Count", names.arg=xf, border="blue", cex.names=0.75, col=c("lightblue"), cex.axis=1)
View(Stock_Data)