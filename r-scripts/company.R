#K Means Plot: FG Vs Salary
#Select sector data first
install.packages('gridExtra')
library(gridExtra)
install.packages("sqldf")
library(sqldf)
install.packages("ggplot2")
library(ggplot2)
install.packages("directlabels")
library(directlabels)
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

sqldf("select ceo.Name, ceo.symbol, stock.Date, stock.Close, (stock.open - stock.Close) from CEO_DataSet ceo, Stock_Data stock where ceo.symbol = stock.symbol and university='Harvard University' group by ceo.symbol")
summary(CEO_DataSet)
options("scipen"=100, "digits"=4)
par(las=1) 
xf<-factor(a$University) 
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
 
uni_sector<-sqldf("select Sector, Performance, Compensation from CEO_DataSet")
dat <- data.frame(X=uni_sector$Sector, Y=uni_sector$Performance, Z=uni_sector$Compensation)
#ggplot(dat,mapping=aes(),groups=factor(uni_sector$Performance)) +  geom_point(aes(x=uni_sector$Sector,y=uni_sector$Performance, color=factor(uni_sector$Compensation)),size=4)
options("scipen"=10000, "digits"=6)
#ggplot(dat, aes(x = Z/1000000, y = Y, colour = X, shape=X )) + geom_point(size=5) + facet_grid(shrink=TRUE, ~ X) + scale_shape_manual(values=uni_sector$Sector) +coord_cartesian(ylim = c(0, 4), xlim=c(0, 40)) +xlab(label='Compensation in Milliions') + ylab(label='Performance via Earnings per share')
  ggplot(dat, aes(x = Z/1000000, y = Y, colour = X, )) + 
      geom_point(size=5,) + facet_grid(space="free_x",shrink=TRUE, ~ X, margins=TRUE)+
    coord_cartesian(ylim = c(-10, 10), xlim=c(0, 40)) +
    xlab(label='Compensation in Milliions') + 
    ylab(label='Performance (Earnings/Share)')+
  scale_colour_hue(name = "Sectors")+
  theme(legend.key = element_rect(colour = "lightblue"))
  
#######################################
# Sector Vs Compensation vs Performance
#######################################
uni_sector<-sqldf("select Sector, Performance, Compensation from CEO_DataSet")
dat <- data.frame(X=uni_sector$Sector, Y=uni_sector$Performance, Z=uni_sector$Compensation)
options("scipen"=10000, "digits"=6)
ggplot(dat, aes(x = Z/1000000, y = Y, colour = X, )) + 
  geom_point(size=5,) + facet_grid(space="free_x",shrink=TRUE, ~ X, margins=TRUE)+
  coord_cartesian(ylim = c(-10, 10), xlim=c(0, 40)) +
  xlab(label='Compensation in Milliions') + 
  ylab(label='Performance (Earnings/Share)')+
  scale_colour_hue(name = "Sectors")+
  theme(legend.key = element_rect(colour = "lightblue"))

#######################################
# University Vs Compensation vs Performance
#######################################
uni_sector<-sqldf("select University, Performance, Compensation from CEO_DataSet where University in (select University  from CEO_DataSet where University <> 'NA' group by University order by count(University) desc limit 10)")
dat <- data.frame(X=uni_sector$University, Y=uni_sector$Performance, Z=uni_sector$Compensation)
ggplot(dat, aes(x = Z/1000000, y = Y, colour = X, )) + 
  geom_point(size=5,) + facet_grid(space="free_x",shrink=TRUE, ~ X, margins=TRUE)+
  coord_cartesian(ylim = c(-10, 10), xlim=c(0, 40)) +
  xlab(label='Compensation in Milliions') + 
  ylab(label='Performance (Earnings/Share)')+
  scale_colour_hue(name = "Universities")+
  theme(legend.key = element_rect(colour = "lightblue"))

#######################################
# Market Data Vs CEO Tenure
#######################################
stockData<-matrix(data=NA,ncol=4,dimnames=list(c(), c("Symbol", "Performance")))
as.data.frame(Stock_Data)
for(row in 1:len){
  sumOfEPS = 0
  stockData[row, 'Symbol'] = as.character(EPS_Growth[row, 'Symbol'])
}
sqldf("select * from Stock_Data where  Symbol in('GOOG') ")
#stock_tenure<-sqldf("select substr(stock.Date,6,2) Market_Month,substr(stock.Date,0,5) Market_Year, ceo.Symbol, ceo.Tenure_To, stock.Value, ceo.Tenure_From from CEO_DataSet ceo, Stock_Data stock where 
#                  ceo.Symbol = stock.Symbol and ceo.Symbol in(select Symbol from CEO_Data ceo_data limit 10)
#              and trim(substr(stock.Date,0,5)) between trim(ceo.Tenure_From) and trim(ceo.Tenure_To)")
Stock_Data <- read.csv("~/ba-mashup/csv_data/companies/MARKET/Stock_Data.csv")
CEO_DataSet <- read.csv("~/ba-mashup/csv_data/profile/CEO_DataSet.csv")
par(mfrow=c(1,5))

#sym<-sqldf("select distinct Symbol from Stock_Data stock where substr(stock.Date,0,5) < '2005' and Symbol <> 'MMM' limit 5")
#for(i in sym){
  #print(as.character(i))
 i='BAC'
  stock_tenure<-sqldf(sprintf("select Name, substr(stock.Date,6,2) Market_Month,substr(stock.Date,0,5) Market_Year, ceo.Symbol, ceo.Tenure_To, stock.Value, ceo.Tenure_From from CEO_DataSet ceo, Stock_Data stock where 
                  ceo.Symbol = stock.Symbol and ceo.Symbol = '%s'  order by Performance desc", i))
  dat <- data.frame(X=stock_tenure$Market_Month, Y=stock_tenure$Value, Z=stock_tenure$Market_Year, W=stock_tenure$Symbol, N=stock_tenure$Name)
  s<-subset(dat,( (dat$Z==2011) & (dat$X=='01') & (dat$N == stock_tenure$Name)))
  a<-aes(x = dat$X, y = dat$Y, group=dat$Z, color='darkblue',fill = 'red')
  b<-aes(x = '01', y = max(dat$Y), group=s$Z, color='darkblue', fill = 'red', label=s$N)
  png("Dropbox/IS5126_Projects/Screenshots/BAC.png",1000,800)
  ggplot(dat, a) + 
    geom_area() +
    facet_wrap(shrink=TRUE, W ~ Z)+
   facet_grid(shrink=TRUE, W ~ Z)+
    coord_cartesian(ylim=c(0,max(dat$Y)+20)) +
    xlab(label='Market date') + 
    ylab(label='Market Price/$')+
    geom_text(data=s, b, color='blue')
  dev.off()
i='RRC'
stock_tenure<-sqldf(sprintf("select Name, substr(stock.Date,6,2) Market_Month,substr(stock.Date,0,5) Market_Year, ceo.Symbol, ceo.Tenure_To, stock.Value, ceo.Tenure_From from CEO_DataSet ceo, Stock_Data stock where 
                  ceo.Symbol = stock.Symbol and ceo.Symbol = '%s'  order by Performance desc", i))
dat <- data.frame(X=stock_tenure$Market_Month, Y=stock_tenure$Value, Z=stock_tenure$Market_Year, W=stock_tenure$Symbol, N=stock_tenure$Name)
s<-subset(dat,( (dat$Z==stock_tenure$Tenure_From) & (dat$X=='01') & (dat$N == stock_tenure$Name)))
a<-aes(x = dat$X, y = dat$Y, group=dat$Z, color='darkblue',fill = 'red')
b<-aes(x = '01', y = max(dat$Y), group=s$Z, color='darkblue', fill = 'red', label=s$N)
png("Dropbox/IS5126_Projects/Screenshots/RRC.png",1000,800)

ggplot(dat, a) + 
  geom_area() +
  facet_wrap(shrink=TRUE, W ~ Z)+
  facet_grid(shrink=TRUE, W ~ Z)+
  coord_cartesian(ylim=c(0,max(dat$Y)+20)) +
  xlab(label='Market date') + 
  ylab(label='Market Price/$')+
  geom_text(data=s, b, color='blue')
dev.off()
i='FB'
stock_tenure<-sqldf(sprintf("select Name, substr(stock.Date,6,2) Market_Month,substr(stock.Date,0,5) Market_Year, ceo.Symbol, ceo.Tenure_To, stock.Value, ceo.Tenure_From from CEO_DataSet ceo, Stock_Data stock where 
                  ceo.Symbol = stock.Symbol and ceo.Symbol = '%s'  order by Performance desc", i))
dat <- data.frame(X=stock_tenure$Market_Month, Y=stock_tenure$Value, Z=stock_tenure$Market_Year, W=stock_tenure$Symbol, N=stock_tenure$Name)
s<-subset(dat,( (dat$Z==2012) & (dat$X=='05') & (dat$N == stock_tenure$Name)))
a<-aes(x = dat$X, y = dat$Y, group=dat$Z, color='darkblue',fill = 'lightblue')
b<-aes(x = '05', y = 100, group='2012', color='darkblue', fill = 'lightblue', label=s$N)
png("Dropbox/IS5126_Projects/Screenshots/Facebook.png",1000,800)
 ggplot(dat, a) + 
  geom_area() +
  facet_wrap(shrink=TRUE, W ~ Z)+
  facet_grid(shrink=TRUE, W ~ Z)+
  coord_cartesian(ylim=c(0,200)) +
  xlab(label='Market date') + 
  ylab(label='Market Price/$')+
  geom_text(data=s, b, color='blue')
dev.off()
#grid.arrange(p1,p2)

i='VZ'
stock_tenure<-sqldf(sprintf("select Name, substr(stock.Date,6,2) Market_Month,substr(stock.Date,0,5) Market_Year, ceo.Symbol, ceo.Tenure_To, stock.Value, ceo.Tenure_From from CEO_DataSet ceo, Stock_Data stock where 
                  ceo.Symbol = stock.Symbol and ceo.Symbol = '%s'  order by Performance desc", i))
dat <- data.frame(X=stock_tenure$Market_Month, Y=stock_tenure$Value, Z=stock_tenure$Market_Year, W=stock_tenure$Symbol, N=stock_tenure$Name)
s<-subset(dat,( (dat$Z==stock_tenure$Tenure_From) & (dat$X=='01') & (dat$N == stock_tenure$Name)))
a<-aes(x = dat$X, y = dat$Y, group=dat$Z, color='darkblue',fill = 'cyan')
b<-aes(x = '06', y = max(dat$Y), group=s$Z, color='darkblue', fill = 'cyan', label=s$N)
  png("Dropbox/IS5126_Projects/Screenshots/Verizon.png",1000,800)
ggplot(dat, a) + 
  geom_area() +
  facet_wrap(shrink=TRUE, W ~ Z)+
  facet_grid(shrink=TRUE, W ~ Z)+
  coord_cartesian(ylim=c(0,max(dat$Y)+20)) +
  xlab(label='Market date') + 
  ylab(label='Market Price/$')+
  #theme(legend.key = element_rect(colour = "lightblue")) + 
  geom_text(data=s, b, color='blue')
dev.off()
i='MAS'
stock_tenure<-sqldf(sprintf("select Name, substr(stock.Date,6,2) Market_Month,substr(stock.Date,0,5) Market_Year, ceo.Symbol, ceo.Tenure_To, stock.Value, ceo.Tenure_From from CEO_DataSet ceo, Stock_Data stock where 
                  ceo.Symbol = stock.Symbol and ceo.Symbol = '%s'  order by Performance desc", i))
dat <- data.frame(X=stock_tenure$Market_Month, Y=stock_tenure$Value, Z=stock_tenure$Market_Year, W=stock_tenure$Symbol, N=stock_tenure$Name)
s<-subset(dat,( (dat$Z==stock_tenure$Tenure_From) & (dat$X=='01') & (dat$N == stock_tenure$Name)))
a<-aes(x = dat$X, y = dat$Y, group=dat$Z, color='darkblue',fill = 'green')
b<-aes(x = '06', y = max(dat$Y), group=s$Z, color='darkblue', fill = 'green', label=s$N)
png("Dropbox/IS5126_Projects/Screenshots/MASCO.png",1000,800)

ggplot(dat, a) + 
  geom_area() +
  facet_wrap(shrink=TRUE, W ~ Z)+
  facet_grid(shrink=TRUE, W ~ Z)+
  coord_cartesian(ylim=c(0,max(dat$Y)+20)) +
  xlab(label='Market date') + 
  ylab(label='Market Price/$')+
  geom_text(data=s, b, color='blue')
dev.off()
i='AAPL'
stock_tenure<-sqldf(sprintf("select Name, substr(stock.Date,6,2) Market_Month,substr(stock.Date,0,5) Market_Year, ceo.Symbol, ceo.Tenure_To, stock.Value, ceo.Tenure_From from CEO_DataSet ceo, Stock_Data stock where 
                  ceo.Symbol = stock.Symbol and ceo.Symbol = '%s'  order by Performance desc", i))
dat <- data.frame(X=stock_tenure$Market_Month, Y=stock_tenure$Value, Z=stock_tenure$Market_Year, W=stock_tenure$Symbol, N=stock_tenure$Name)
s<-subset(dat,( (dat$Z==stock_tenure$Tenure_From) & (dat$X=='01') & (dat$N == stock_tenure$Name)))
a<-aes(x = dat$X, y = dat$Y, group=dat$Z, color='darkblue',fill = 'yellow')
b<-aes(x = '06', y = max(dat$Y), group=s$Z, color='darkblue', fill = 'yellow', label=s$N)
#png("Dropbox/IS5126_Projects/Screenshots/Apple.png",1080,900)
ggplot(dat, a) + 
  geom_area() +
  facet_wrap(shrink=TRUE, W ~ Z)+
  facet_grid(shrink=TRUE, W ~ Z)+
  coord_cartesian(ylim=c(0,max(dat$Y)+20)) +
  xlab(label='Market date') + 
  ylab(label='Market Price/$')+
  geom_text(data=s, b, color='blue')
#dev.off()
#}
  #annotate("text", x=01, y=100, ,cyl = factor(2009,levels = c("2009")), label="Observed \n value", color = "blue")
#######################################
# Regression of Compensation vs Performance
#######################################
png("Dropbox/IS5126_Projects/Screenshots/Perf_Comp_Regression.png",1080,900)
uni_sector<-sqldf("select Performance, Compensation from CEO_DataSet")
model<-lm(uni_sector$Performance ~ uni_sector$Compensation + uni_sector)
plot(uni_sector$Compensation, uni_sector$Performance)
par(mfrow=c(2,2))
plot(model)
dev.off()
model

#######################################
# Regression of Compensation vs Performance vs Age
#######################################
uni_sector<-sqldf("select Performance, Compensation, Age, Revenue, Bachelors_University from CEO_DataSet where Compensation <> 'NA' and (Bachelors_University<> 'NA' or Masters_University <> 'NA') order by Performance desc")
model<-lm(uni_sector$Performance ~ uni_sector$Revenue)
summary(model)
par(mfrow=c(2,2))
plot(model)
dev.off()

log_df<-data.frame(uni=uni_sector$Bachelors_University, perf=uni_sector$Performance, age=uni_sector$Age)
log<-glm(log_df$perf ~ log_df$age + log_df$Compensation,  family=binomial())
summary(log)

Revenue_Data <- read.csv("~/ba-mashup/csv_data/companies/MARKET/Revenue_Data.csv", header=F)
Revenue_Data
Rev<-sqldf("select V2,V3,V4 from Revenue_Data where V1 = 'MMM' ")
summary(Rev)

######################################
#Regression on Age Vs Revenue with Performance
######################################
for(i in 1:length(Revenue_Data)){
  print(Revenue_Data[i])
}
uni_sector_b<-sqldf("select b, count(*) cb from (select Bachelors_University b from CEO_DataSet order by Performance desc limit 100) group by b")
uni_sector_m<-sqldf("select m, count(*) from (select Masters_University m from CEO_DataSet order by Performance desc limit 100)  group by m")
all_uni<-sqldf("select b, sum(cb) s from (select * from uni_sector_b union  select * from uni_sector_m) where b <> 'NA' group by b having s > 1")

xf=factor(all_uni$b)
par(las=2)
par(mar=c(8,2,1,0))
barplot(all_uni$s, main="Universities of Top 100 performing CEOs",ylab="Count", names.arg=xf, border="blue", cex.names=0.75, col=c("lightblue"), cex.axis=1)


wharton<-sqldf("select count(*) from CEO_DataSet Bachelors_University where Bachelors_University in ('Wharton University') or Masters_University in ('Wharton University')")
bs_degree<-sqldf("select count(*) from CEO_DataSet where Bachelors_Specialization in ('BS') and Masters_Specialization in ('MS')")
comp_bs_degree<-sqldf("select Bachelors_Specialization, avg(Compensation) avg from CEO_DataSet  where Bachelors_Specialization in ('BS') and Masters_Specialization in ('NA')")
comp_mba_degree<-sqldf("select Masters_Specialization, avg(Compensation) avg from CEO_DataSet  where Masters_Specialization in ('MBA')")
