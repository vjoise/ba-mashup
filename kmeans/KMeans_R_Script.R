######################################################
#K Means R SCript

# Age with sector

# specialization Vs sector

# performance parameters:
# performance within sectors
# performance vs age
# performance vs compensation
# performance vs uni
# performance vs specialization
# performance vs combinations
								
######################################################
##
##Read file
ceo_profile<-read.csv("/Users/vinutha/IS5126/ba-mashup/csv_data/profile/CEO_DataSet.csv.csv",header=T,sep=",")

#selection of columns necessary
join_string <- "select
ceo_profile.Symbol,ceo_profile.Sector,ceo_profile.Name,ceo_profile.Compensation,ceo_profile.Age,ceo_profile.Starting_Age,ceo_profile.Performance,ceo_profile.Gender,ceo_profile.POB,ceo_profile.Nationality,ceo_profile.Bachelors_University,ceo_profile.Bachelors_Specialization,ceo_profile.Masters_University,ceo_profile.Masters_Specialization
from ceo_profile"

uni_string <- "select ceo_profile.Bachelors_University, ceo_profile.Bachelors_Specialization, ceo_profile.Masters_University, ceo_profile.Masters_Specialization from ceo_profile"

unidata  <- sqldf(uni_string,stringsAsFactors = FALSE)

ceo_data <- sqldf(join_string,stringsAsFactors = FALSE)


###########


age<-subset(ceo_data,select=c(Age,Performance))
x<-data.matrix(age,rownames.force = NA)
(cl=kmeans(na.omit(x),3))
plot(x,col=cl$cluster,xlab="Age",ylab="Performance")
points(cl$centers,col=1:3,pch=8,cex=2)

sector<-subset(ceo_data,select=c(Sector,Performance))
x<-data.matrix(sector,rownames.force = NA)
(cl=kmeans(na.omit(x),10))
plot(x,col=cl$cluster)
points(cl$centers,col=1:10,pch=8,cex=2)

age<-subset(ceo_data,select=c(Sector,Starting_Age))
x<-data.matrix(age,rownames.force = NA)
(cl=kmeans(na.omit(x),10))
plot(x,col=cl$cluster)
points(cl$centers,col=1:10,pch=8,cex=2)

age<-subset(ceo_data,select=c(Gender,Performance))
x<-data.matrix(age,rownames.force = NA)
(cl=kmeans(na.omit(x),2))
plot(x,col=cl$cluster)
points(cl$centers,col=1:2,pch=8,cex=2)

# Fitting Labels 
par(las=2) # make label text perpendicular to axis
par(mar=c(3,10,4,2)) # increase y-axis margin.
counts <- table(ceo_data$Sector)
barplot(counts, main="Sector Distribution", horiz=TRUE, names.arg=c("Consumer Discretionary", "Consumer Staples", "Energy","Financials","Health Care","Industrials","Information Technology","Materials","Telecommunications Services","Utilities"), cex.names=0.8)




barplot(table(ceo_data$Sector),ylab = 'Count',las=2)

###########

age<-subset(ceo_data,select=c(Age))
x<-data.matrix(age,rownames.force = NA)
(cl=kmeans(na.omit(x),3))
plot(x,col=cl$cluster,ylab="Age")
points(cl$centers,col=1:3,pch=8,cex=2)

png('/Users/vinutha/IS5126/GP2/plots/kmeans/Sal_FG.png')

age<-subset(ceo_data,select=c(Age,Compensation))
x<-data.matrix(age,rownames.force = NA)
(cl=kmeans(na.omit(x),3))
plot(x,col=cl$cluster)
points(cl$centers,col=1:3,pch=8,cex=2)


barplot(table(ceo_data$Gender),col=c("pink", "lightblue"), xlab = 'Gender', ylab = 'Count')


barplot(table(na.omit(ceo_data$PostGrad_Specialization))


barplot(table(ceo_data$Gender),col=c("pink", "lightblue"), xlab = 'Gender', ylab = 'Count')
options("scipen"=100, "digits"=4)
par(xaxt="n") 
xf<-factor(ceo_data$PostGrad_Specialization) 
plot(xf, ceo_data$PostGrad_Specialization, xlab='') 
text(xf, par("usr")[3] - 0.25,labels=ceo_data$PostGrad_Specialization, srt = 60, pos = 2, xpd = TRUE, cex=0.75)


age<-subset(ceo_data,select=c(Starting_Age))
x<-data.matrix(age,rownames.force = NA)
(cl=kmeans(na.omit(x),3))
plot(x,col=cl$cluster,ylab = 'Starting_Age')
points(cl$centers,col=1:3,pch=8,cex=2)


options("scipen"=100, "digits"=4)
par(las=1) 
xf<-factor(unidata$Masters_Specialization) 
barplot(unidata$Masters_Specialization, main="Universities",ylab="Count", names.arg=xf, border="blue", cex.names=0.75, col=c("lightblue"), cex.axis=1)


barplot(table(na.omit(unidata$Masters_Specialization)),xlab = 'PostGrad Specialization', ylab = 'Count')

par(xaxt="n") 
barplot(table(na.omit(unidata$Masters_Specialization)),xlab = 'PostGrad Specialization', ylab = 'Count')
text(xf, par("usr")[3] - 0.25,labels=unidata$Masters_Specialization, srt = 70, pos = 2, xpd = TRUE, cex=0.75)


####################
ceo_profile$Sector.cat <- bin.var(ceo_profile$Sector, bins=10, method='proportions', labels=NULL)
plotMeans(ceo_profile$Sector, ceo_profile$Sector.cat, ceo_profile$Performance, error.bars="none")

plotmeans(ceo_profile$Sector ~ ceo_profile$Performance)


vari <- ceo_profile$Sector
var2 <- ceo_profile$Age
nb.clusters <- 10
breaks <- quantile(vari, seq(0,1,1/nb.clusters))
Xqual <- cut(vari,breaks, include.lowest=TRUE)
summary(Xqual)


means <- ddply(ceo_profile, "Sector", function(x) c(xmean=mean(x$Performance), xsd=sd(x$Performance), ymean=mean(x$Age), ysd=sd(x$Age)))

plot(means$xmean, means$ymean, xlim=c(-1, 1), ylim=c(54, 58))

agexeduc<-brkdn(ceo_profile$Sector~ceo_profile$Age,ceo_profile$Performance)


######
fit1 <- rpart(ceo_data$Age~ceo_data$Sector,data=solder,method='poisson')

fit2 <- rpart(ceo_data$Performance~ceo_data$Sector,data=solder,method='poisson')

fit2 <- rpart(ceo_data$Performance~ceo_data$Sector,data=solder,method='poisson')


fit <- rpart(ceo_data$Sector~ceo_data$Age,data=solder,method='poisson')
summary(fit)
plot(fit)
text(fit,use.n=T)
post(fit,file="")
