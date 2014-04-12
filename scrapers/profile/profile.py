import sys
import urlparse

import lxml.html
from lxml.etree import tostring
import requests
import re

import httplib, urllib, urllib2, cookielib
import re
import base64
import os
import json
import markdown
import html2text
from datetime import datetime
from optparse import OptionParser
from ConfigParser import RawConfigParser
from urllib import urlretrieve
from bs4 import BeautifulSoup
import urllib2
import csv
#time is needed to pause while fetching the data, as it may affect the performance of server.
import time

user_agent = 'Mozilla/4.0 (compatible; MSIE 5.5; Windows NT)'
headers = { 'User-Agent' : user_agent}

crawl_url = 'http://investing.businessweek.com/research/stocks/people/people.asp?ticker='
base_url = 'http://investing.businessweek.com/research'

def webscrape(urlToScrape): # returns content of the webpage as html object for the given url
    req = urllib2.Request(urlToScrape, headers={'User-Agent' : "Mozilla Firefox"}) 
    response = urllib2.urlopen( req )
    html = response.read()
    return html

def read_file(self):
    with open(self.file, 'r') as f:
        data = [row for row in csv.reader(f.read().splitlines())]
    return data

def main():

    companyTickerArray = []
    companyNamesArray = []

    fname = '/Users/vinutha/IS5126/ba-mashup/starting_csv/sp500list.csv'
    reader = csv.reader(open(fname, 'rU'), dialect='excel')
    fopen = csv.writer(open("ceolisting_final.csv",'a+'))

    for item in reader:
        if item[0] is not '':            
            companyNamesArray.append(item[0])
            companyTickerArray.append(item[1])

    # print companyNamesArray
    # print companyTickerArray
    count = 0
    for company in companyTickerArray:
    # for i in range(300,500):
        items = []  
        # company = companyTickerArray[i]
        print 'Crawling people from :' + crawl_url + company

        profile_html = webscrape(crawl_url+company.replace('.','/'))
        soup = BeautifulSoup(profile_html)
        keyExecs = soup.find("table", {'id' : 'keyExecs'})
        if keyExecs :
            item = []
            allExecs = keyExecs.findAll("tr")
            userrows = [t for t in allExecs if t.findAll(text=re.compile('Chief Executive Officer|Chief Executive officer|Chief executive officer'))]
            if len(userrows) :
                personlink = userrows[0].findAll('a')[0]            
                personurl = base_url + personlink['href'][5:]
                personname = personlink.text.strip().encode('utf8')
            else :
                userrows = [t for t in allExecs if t.findAll(text=re.compile('Director|director'))]
                if len(userrows) :
                    personlink = userrows[0].findAll('a')[0]            
                    personurl = base_url + personlink['href'][5:]
                    personname = personlink.text.strip().encode('utf8')
                else :        
                    personurl = ''
                    personname = ''

            # print personname
            # print personurl                          
            item.append(companyNamesArray[count])
            item.append(company)
            item.append(personname)
            item.append(personurl)
            count = count+1
            items.append(item)
            time.sleep(1)        
    
        fopen.writerows(items)
        # coll.update({'id': item['id']}, {'$set': item}, upsert=True)

if __name__ == '__main__':
    main()