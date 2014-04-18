computeEPS <- function(){
EPS_Growth <- read.csv("~/ba-mashup/csv_data/companies/MARKET/EPS_Growth.csv", header=T)
len=length(EPS_Growth[,'Years'])
perf<-matrix(data=NA,ncol=2,nrow=500,dimnames=list(c(), c("Symbol", "Performance")))
as.data.frame(EPS_Growth)
EPS_Growth[,25:41] <-lapply(EPS_Growth[,25:41], as.double)
for(row in 1:len){
  sumOfEPS = 0
  perf[row, 'Symbol'] = as.character(EPS_Growth[row, 'Symbol'])
  print(EPS_Growth[2,'Years'])
    for(year in 1:EPS_Growth[row,'Years']){
      yearValue =  paste('Year', year, sep='')
      sumOfEPS = sum( (sumOfEPS), (EPS_Growth[row, yearValue]))
    }
    perf[row, 'Performance'] = as.numeric(sumOfEPS)/as.numeric(EPS_Growth[row,'Years']);
}
}
