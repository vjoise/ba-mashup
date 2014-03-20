import urllib2
 
#time is needed to pause while fetching the data, as it may affect the performance of server.
import time
 
#import csv and xlrd for processing
import csv,xlrd
 
#using beautifulsoup module for fetching and parsing html content
from bs4 import BeautifulSoup

import os, datetime, schema
 
#yahoo finance api link here
YAHOO_FINANCE_BASE_URL = 'http://ichart.yahoo.com/table.csv?g=w&ignore=.csv'

#company profile base url
COMPANY_PROFILE_BASE_URL = 'http://finance.yahoo.com/q/co?s='

def requestForData(url) :
    req = urllib2.Request(url)
    response = urllib2.urlopen( req )
    data = response.read()
    return data

#this appends s=GOOG for gathering company profile
def getCompanyProfileData(stockSymbol):
    url = COMPANY_PROFILE_BASE_URL + stockSymbol;
    print url
    return requestForData(url);
    
def insertIntoDB(csvfile,stkSymbol) :
    f1 = open(csvfile, 'r')
    insertStatements = []
    for finData in f1.readlines():
        finData = finData.split(',')
        date = finData[0]
        high = finData[2]
        low = finData[3]
        #build insert statements here
        insertStatement = "INSERT INTO COMPANY_FINANCE(COMPANY_ID, START_DATE, HIGH_PRICE, LOW_PRICE) VALUES( '"+ stkSymbol +'\',' + '\''+date +'\''+ ',' + high + ','  + low +")"
        insertStatements.append(insertStatement)
    schema.insertRows(insertStatements);

 
#this appends s=GOOG with interval of dates(start, end) a=0&b=1&c=2000&d=0&e=31&f=2010 to the above url.
def getFinanceData(stockSymbol, startDate, endDate):
    
    # DIRECTORY PATH 
    MARKET_DATA_DIR = '../../csv_data/companies/MARKET/';
    COMPETITORS_DATA_DIR  = '../../csv_data/companies/COMPETITORS/';

    companyDirectory = MARKET_DATA_DIR+stockSymbol;
    if not os.path.exists(companyDirectory):
        os.makedirs(companyDirectory)

    ###########STOCK INFO##################

    #The parameters expected by YHOE finance api are as follows:
    a=startDate.split("-")[0];
    a = str(int(a) - 1)  #YHOO Finance API starts index of they year from 0 instead of 1.
    b=startDate.split("-")[1];
    c=startDate.split("-")[2];
    d=endDate.split("-")[0];
    d = str(int(d) - 1)  #YHOO Finance API starts index of they year from 0 instead of 1.
    e=endDate.split("-")[1];
    f=endDate.split("-")[2];
    
    stockUrl = YAHOO_FINANCE_BASE_URL +"&s="+ stockSymbol;
    stockUrl += '&a=' +a +'&b=' +b +'&c='+c;
    stockUrl += '&d=' +d +'&e=' +e +'&f='+f;
    print "Stock URL =" + stockUrl
    stockData = requestForData(stockUrl)
    #Insert the finance data of one company into the table
    f = open(companyDirectory+'/' + stockSymbol + '_' +startDate + '_'+endDate+'.csv', 'w')
    f.writelines(stockData)
    f.close()    
    
    #Company data
    insertIntoDB(companyDirectory+'/' + stockSymbol + '_' +startDate + '_'+endDate+'.csv',stockSymbol);
    
    ###########COMPETITOR INFO ############
    competitorDirectory = COMPETITORS_DATA_DIR;
    if not os.path.exists(competitorDirectory):
        os.makedirs(competitorDirectory)
    
    competitorUrl = COMPANY_PROFILE_BASE_URL + stockSymbol + "+Competitors";
    print "Competitor URL =" + competitorUrl
    competitorData = requestForData(competitorUrl)
    competitorList = []
    #print  competitorData
    competitorData = BeautifulSoup(str(competitorData))
    
    for a in competitorData.find_all("th",{"class" : "yfnc_tablehead1"}) :
        if 'PVT' in a.get_text():
            pass
        else:
            if 'Industry' in a.get_text():
                break;
            competitorList.append(stockSymbol + ',' + a.get_text()+'\n')
    #print compNames
    #Insert the finance data of one company into the table
    f = open(competitorDirectory +'/CompetitorData.csv' , 'a')
    f.writelines(competitorList)
    f.close() 
    

schema.createDbSchema('../../database/schema.sql',True);


#######  STARTING CSVs #######
COMPANY_DIR = '../../starting_csv';
ceoProfilexls = COMPANY_DIR + '/' + 'ceolisting_final' + '.csv'
company_file = open(ceoProfilexls , 'r')
print company_file;
data = []
for CEOData in company_file.readlines():
    #print CEOData
    data = CEOData.split(',')
    getFinanceData(data[1], data[len(data) -2], data[len(data)-1])
        

