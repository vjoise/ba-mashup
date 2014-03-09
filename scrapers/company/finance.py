import urllib2
 
#time is needed to pause while fetching the data, as it may affect the performance of server.
import time
 
#import csv for processing
import csv
 
#using beautifulsoup module for fetching and parsing html content
from bs4 import BeautifulSoup

import os, datetime
 
#yahoo finance api link here
YAHOO_FINANCE_BASE_URL = 'http://ichart.yahoo.com/table.csv?g=w&ignore=.csv'

#this appends s=GOOG with interval of dates(start, end) a=0&b=1&c=2000&d=0&e=31&f=2010 to the above url.
def getFinanceData(stockSymbol, startDate, endDate):
    print "stocksymbol : " + stockSymbol;
    print "startDate :"  + startDate;
    print "endDate :"  + endDate;
    
    #The parameters expected by YHOE finance api are as follows:
    a=startDate.split("-")[0];
    b=startDate.split("-")[1];
    c=startDate.split("-")[2];
    d=endDate.split("-")[0];
    e=endDate.split("-")[1];
    f=endDate.split("-")[2];
    
    url = YAHOO_FINANCE_BASE_URL +"&s="+ stockSymbol;
    url += '&a=' +a +'&b=' +b +'&c='+c;
    url += '&d=' +d +'&e=' +e +'&f='+f;
    print url;
    req = urllib2.Request(url)
    response = urllib2.urlopen( req )
    data = response.read()
    return data
 
listOfCompanies = {
                    'GOOG' : ['12-10-2013', '03-10-2014']
                  };

for companySymbol,dates in listOfCompanies.iteritems():
    data=getFinanceData(companySymbol, dates[0], dates[1])
    print data

