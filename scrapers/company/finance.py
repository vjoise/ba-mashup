import urllib2
 
#time is needed to pause while fetching the data, as it may affect the performance of server.
import time
 
#import csv for processing
import csv
 
#using beautifulsoup module for fetching and parsing html content
from bs4 import BeautifulSoup

import os, datetime, schema
 
#yahoo finance api link here
YAHOO_FINANCE_BASE_URL = 'http://ichart.yahoo.com/table.csv?g=m&ignore=.csv'

#company profile base url
COMPANY_PROFILE_BASE_URL = 'http://finance.yahoo.com/q/pr?s='

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
    
 
#this appends s=GOOG with interval of dates(start, end) a=0&b=1&c=2000&d=0&e=31&f=2010 to the above url.
def getFinanceData(stockSymbol, startDate, endDate):
    
    # DIRECTORY PATH 
    MARKET_DATA_DIR = '../../csv_data/companies/MARKET/';
    COMPETITORS     = '../../csv_data/companies/COMPETITORS/';

    ###########STOCK INFO##################

    #The parameters expected by YHOE finance api are as follows:
    a=startDate.split("-")[0];
    a = str(int(a) - 1)
    b=startDate.split("-")[1];
    c=startDate.split("-")[2];
    d=endDate.split("-")[0];
    d = str(int(d) - 1)
    e=endDate.split("-")[1];
    f=endDate.split("-")[2];
    
    url = YAHOO_FINANCE_BASE_URL +"&s="+ stockSymbol;
    url += '&a=' +a +'&b=' +b +'&c='+c;
    url += '&d=' +d +'&e=' +e +'&f='+f;
    print url
    return requestForData(url);
    


#list of companies will be parsed from another csv file from S&P list.
listOfCompanies = {
                    'GOOG' : ['04-10-2013', '03-10-2014'],
                    'AAPL' : ['04-10-2013', '03-10-2014'],
                    'YHOO' : ['04-10-2013', '03-10-2014']
                  };

schema.createDbSchema('../../database/schema.sql',True);

for companySymbol,dates in listOfCompanies.iteritems():
    data=getFinanceData(companySymbol, dates[0], dates[1])
    companyDirectory = MARKET_DATA_DIR+companySymbol;
    if not os.path.exists(companyDirectory):
        os.makedirs(companyDirectory)
    f = open(companyDirectory+'/' + companySymbol + '_' +dates[0] + '_'+dates[1]+'.csv', 'w')
    companyProfile=getFinanceData(companySymbol, dates[0], dates[1])
    #insert into company stock prices table
    #schema.insertRows();
    f.writelines(data)
    f.close()  
    f1 = open(companyDirectory+'/' + companySymbol + '_' +dates[0] + '_'+dates[1]+'.csv', 'r')
    insertStatements = []
    for finData in f1.readlines():
        finData = finData.split(',')
        date = finData[0]
        high = finData[2]
        low = finData[3]
        #build insert statements here
        insertStatement = "INSERT INTO COMPANY_FINANCE(COMPANY_ID, START_DATE, HIGH_PRICE, LOW_PRICE) VALUES( '"+ companySymbol +'\',' + '\''+date +'\''+ ',' + high + ','  + low +")"
        insertStatements.append(insertStatement)
    schema.insertRows(insertStatements);
    
