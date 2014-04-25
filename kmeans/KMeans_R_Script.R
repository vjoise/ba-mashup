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
ceo_profile<-read.csv("~/ba-mashup/csv_data/profile/CEO_DataSet.csv",header=T,sep=",")

#selection of columns necessary
join_string <- "select
ceo_profile.Symbol,ceo_profile.Sector,ceo_profile.Name,ceo_profile.Compensation,ceo_profile.Age,ceo_profile.Starting_Age,ceo_profile.Performance,ceo_profile.Gender,ceo_profile.POB,ceo_profile.Nationality,ceo_profile.Bachelors_University,ceo_profile.Bachelors_Specialization,ceo_profile.Masters_University,ceo_profile.Masters_Specialization
from ceo_profile"

ceo_data <- sqldf(join_string,stringsAsFactors = FALSE)


###########
#KMEANS
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

a<-sqldf('select Masters_University university, count(*) avg from ceo_data where Masters_University <> "NA" group by Masters_University order by avg desc limit 10' )
options("scipen"=100, "digits"=4)
par(las=2) 
par(mar=c(3,12,4,2))
xf<-factor(a$university) 
barplot(a$avg, main="PG Universities",xlab="Count",horiz=TRUE, names.arg=xf, border="blue", cex.names=0.75, col=c("lightblue"), cex.axis=1)


barplot(table(ceo_data$Sector),ylab = 'Count',las=2)

######################
#Linear Regression
######################
summary(glm(formula=ceo_data$Age ~ ceo_data$Gender + ceo_data$Masters_Specialization + ceo_data$Sector + ceo_data$Bachelors_Specialization))
summary(glm(formula=ceo_data$Age ~ ceo_data$Performance + ceo_data$Gender + ceo_data$Masters_Specialization + ceo_data$Sector))
summary(glm(formula=ceo_data$Age ~ ceo_data$Performance + ceo_data$Gender + ceo_data$Sector))
par(mfrow=c(2,2))

  summary(glm(formula=ceo_data$Performance ~ ceo_data$Nationality + ceo_data$Masters_Specialization + ceo_data$Compensation))

ceo_data$Performance.cat <- bin.var(ceo_data$Performance, bins=4, method='proportions', labels=NULL)
summary(ceo_data$Performance.cat)

plotmeans(ceo_data$Age~ceo_data$Sector,par(las=2))



#############

par(las=1) 
barplot(table(ceo_data$Gender),main="Gender Distribution",col=c("pink", "lightblue"), xlab = 'Gender', ylab = 'Count')

barplot(table(na.omit(ceo_data$Masters_Specialization)),xlab = 'PostGrad Specialization', ylab = 'Count',las=2)

####################
#Decision Tree
####################

fit <- rpart(ceo_data$Age~ceo_data$Sector,data=solder,method='poisson')
summary(fit)
plot(fit)
text(fit,use.n=T)
post(fit,file="")


#######################

#######################
ceo_data$Performance.cat <- bin.var(ceo_data$Performance, bins=4, method='proportions', labels=NULL)
summary(ceo_data$Performance.cat <- bin.var(ceo_data$Performance, bins=4, method='proportions', labels=NULL))

#############
 #############[-23.5,-0.0244] (-0.0244,0.0607]   (0.0607,0.222]     (0.222,8.52] 
#############             125              125              125              125 
#############


