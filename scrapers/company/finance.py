import urllib2
 
#time is needed to pause while fetching the data, as it may affect the performance of server.
import time
 
#import csv for processing
import csv
 
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
    
 
#this appends s=GOOG with interval of dates(start, end) a=0&b=1&c=2000&d=0&e=31&f=2010 to the above url.
def getFinanceData(stockSymbol, startDate, endDate):
    
    # DIRECTORY PATH 
    MARKET_DATA_DIR = '../../csv_data/companies/MARKET/';
    COMPETITORS_DATA_DIR  = '../../csv_data/companies/COMPETITORS/';

    companyDirectory = MARKET_DATA_DIR+companySymbol;
    if not os.path.exists(companyDirectory):
        os.makedirs(companyDirectory)

    ###########STOCK INFO##################

    #The parameters expected by YHOE finance api are as follows:
    a=startDate.split("-")[0];
    b=startDate.split("-")[1];
    c=startDate.split("-")[2];
    d=endDate.split("-")[0];
    e=endDate.split("-")[1];
    f=endDate.split("-")[2];
    
    stockUrl = YAHOO_FINANCE_BASE_URL +"&s="+ stockSymbol;
    stockUrl += '&a=' +a +'&b=' +b +'&c='+c;
    stockUrl += '&d=' +d +'&e=' +e +'&f='+f;
    print "Stock URL =" + stockUrl
    stockData = requestForData(stockUrl)
    #Insert the finance data of one company into the table
    f = open(companyDirectory+'/' + companySymbol + '_' +dates[0] + '_'+dates[1]+'.csv', 'w')
    f.writelines(stockData)
    f.close()    
    
    ###########COMPETITOR INFO ############
    companyDirectory = COMPETITORS_DATA_DIR+companySymbol;
    if not os.path.exists(companyDirectory):
        os.makedirs(companyDirectory)
    
    competitorUrl = COMPANY_PROFILE_BASE_URL + stockSymbol + "+Competitors";
    print "Competitor URL =" + competitorUrl
    competitorData = requestForData(competitorUrl)
    #print  competitorData
    competitorData = BeautifulSoup(str(competitorData))
    
    for a in competitorData.find_all("th",{"class" : "yfnc_tablehead1"}) :
        print a.get_text()
    print compNames
    #Insert the finance data of one company into the table
    f = open(companyDirectory+'/' + companySymbol + '_' +dates[0] + '_'+dates[1]+'.csv', 'w')
    f.writelines(stockData)
    f.close() 
    
    
    


#list of companies will be parsed from another csv file from S&P list.
listOfCompanies = {
                    'GOOG' : ['12-10-2013', '03-10-2014']
                  };

for companySymbol,dates in listOfCompanies.iteritems():
    getFinanceData(companySymbol, dates[0], dates[1])
    
