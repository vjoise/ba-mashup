

##
ceo_profile<-read.csv("/Users/vinutha/Desktop/CEO_DataSet_Final.csv",header=T,sep=",")

ceo_profile<-read.csv("/Users/vinutha/Desktop/CEO_DataSet_Final_0.3.csv",header=T,sep=",")

join_string <- "select
                ceo_profile.*
              from ceo_profile"

#working
join_string <- "select
ceo_profile.name,ceo_profile.compensation,ceo_profile.age,ceo_profile.Gender,ceo_profile.POB,ceo_profile.Nationality,ceo_profile.Bachelor_University,ceo_profile.Bachelors_Specialization,ceo_profile.Masters_University,ceo_profile.Masters_Specialization
from ceo_profile"

join_string <- "select
cp.name,cp.compensation,cp.age,cp.Gender,cp.POB,cp.Nationality,cp.Grad_University,cp.Grad_Specialization,cp.PostGrad_University,cp.PostGrad_Specialization
from ceo_profile cp"


join_string <- "select ceo_profile.Starting_Age from ceo_profile"

uni_string <- "select ceo_profile.Bachelors_University, ceo_profile.Bachelors_Specialization, ceo_profile.Masters_University, ceo_profile.Masters_Specialization from ceo_profile"

unidata  <- sqldf(uni_string,stringsAsFactors = FALSE)

ceo_data <- sqldf(join_string,stringsAsFactors = FALSE)

age<-subset(ceo_data,select=c(Age))
x<-data.matrix(age,rownames.force = NA)
(cl=kmeans(na.omit(x),3))
plot(x,col=cl$cluster)
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

