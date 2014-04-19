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

#######################################
# Sector Vs Age
#######################################
sector_age<-sqldf("select Sector, Age from CEO_DataSet_Final_Sectors group by Sector, Age")
leng <-sqldf('select count(distinct Sector) from CEO_DataSet_Final_Sectors')
options("scipen"=100, "digits"=4)
#K Means Plot: FG Vs Salary
age_sector<-subset(CEO_DataSet_Final_Sectors,select=c(Sector, Starting_Age))
x<-data.matrix(age_sector,rownames.force = NA)
cl=kmeans(x,5)
xf<-factor(CEO_DataSet_Final_Sectors$Sector)
plot(x,col=cl$cluster)
text(xf, par("usr")[3] - 0.25,labels=age_sector$Sector, srt = 60, pos = 2, xpd = TRUE, cex=0.75)

#######################################
# Sector Vs Age
#######################################
sector_age<-sqldf("select Sector, Age from CEO_DataSet_Final_Sectors group by Sector, Age")
leng <-sqldf('select count(distinct Sector) from CEO_DataSet_Final_Sectors')
options("scipen"=100, "digits"=4)
#K Means Plot: FG Vs Salary
age_sector<-subset(CEO_DataSet_Final_Sectors,select=c(Sector, Starting_Age))
x<-data.matrix(age_sector,rownames.force = NA)
cl=kmeans(x,5)
xf<-factor(CEO_DataSet_Final_Sectors$Sector)
plot(x,col=cl$cluster)
text(xf, par("usr")[3] - 0.25,labels=age_sector$Sector, srt = 60, pos = 2, xpd = TRUE, cex=0.75)

#######################################
# Sector Vs Uni vs Count
#######################################
#K Means Plot: FG Vs Salary
#Select sector data first
install.packages("sqldf")
library(sqldf)
install.packages("ggplot2")
library(ggplot2)

uni_sector<-sqldf("select Sector, University, count(*) cnt from CEO_DataSet_Final_Sectors where University<> '' group by Sector, University having count(*) > 1")
dat <- data.frame(X = uni_sector$Sector,Y =uni_sector$University)
ggplot(dat) + geom_point(aes(x=uni_sector$Sector,y=uni_sector$cnt,group=uni_sector$University, color=factor(uni_sector$University)),size=4)
sqldf("select Sector, University from CEO_DataSet_Final_Sectors where University = 'Harvard University'")

#######################################
# Sector Vs Uni vs Count
#######################################
#K Means Plot: FG Vs Salary
#Select sector data first
install.packages("sqldf")
library(sqldf)
install.packages("ggplot2")
library(ggplot2)
install.packages("directlabels")
library(directlabels)

uni_sector<-sqldf("select Sector, University, count(*) cnt from CEO_DataSet_Final_Sectors where University<> '' group by Sector, University having count(*) > 2")
dat <- data.frame(X = uni_sector$Sector,Y =uni_sector$University)
ggplot(dat) + geom_point(aes(x=uni_sector$Sector,y=uni_sector$cnt,group=uni_sector$University, color=factor(uni_sector$University)),size=4, hjust=0, vjust=0)



#######################################
# Sector Vs Compensation vs Performance
#######################################
#K Means Plot: FG Vs Salary
#Select sector data first
install.packages("sqldf")
library(sqldf)
install.packages("ggplot2")
library(ggplot2)
install.packages("directlabels")
library(directlabels)

uni_sector<-sqldf("select Sector, Performance, Compensation from CEO_DataSet_Final_Sectors")
dat <- data.frame(X=uni_sector$Sector, Y=uni_sector$Performance, Z=uni_sector$Compensation)
ggplot(dat,mapping=aes(),groups=factor(uni_sector$Performance)) +  geom_point(aes(x=uni_sector$Sector,y=uni_sector$Performance, color=factor(uni_sector$Compensation)),size=4)


library(ggplot2)
uni_sector$Compensation <- factor(uni_sector$Compensation)
subset(CEO_DataSet_Final_Sectors,select=c(Sector, Starting_Age))
boxplot(x=uni_sector,col=uni_sector$Performance, subset=)
ggplot(dat,aes(x=uni_sector$Sector,y=uni_sector$Compensation,colour=uni_sector$Performance)) + geom_boxplot(aes(fill=uni_sector$Performance)) + coord_cartesian(ylim=20:50)
ggplot(dat,aes(x=uni_sector$Sector,y=uni_sector$Compensation,colour=uni_sector$Performance, group=1)) + geom_point() + scale_y_discrete(breaks=(seq(0,50000000, by=10000000)))
