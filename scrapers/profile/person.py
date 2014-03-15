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

    fname = 'ceolisting_final.csv'
    reader = csv.reader(open(fname, 'rU'), dialect='excel')
    fopen = csv.writer(open("ceoprofile_final_one.csv",'w'))


    for ceolink in reader:
        items = []
        if ceolink[3] is not '':            
            print 'Crawling people from :' + ceolink[3] 
            item = []
            name = ''
            jobTitle = ''
            worksFor = ''
            alumniOf = ''
            age = ''
            totalCompensation = ''
            desc = ''
            workLocation = ''
            affiliationsStr = ''

            profile_html = webscrape(ceolink[3])
            soup = BeautifulSoup(profile_html)
            keyExecs = soup.find("div", {'itemtype' : 'http://schema.org/Person'})
            if keyExecs :
                name = keyExecs.find("h1",{'itemprop':"name"}).text.strip().encode('utf8')
                jobTitle = keyExecs.find("span",{'itemprop':"jobTitle"}).text.strip().encode('utf8')
                worksFor = keyExecs.find("a",{'itemprop':"worksFor"}).text.strip().encode('utf8')
                if keyExecs.find("div",{'itemprop':"alumniOf"}):
                    alumniOf = keyExecs.find("div",{'itemprop':"alumniOf"}).text.strip().encode('utf8')
                largeDetail = keyExecs.findAll("td",{'class':"largeDetail"})
                if largeDetail :
                    age = largeDetail[0].text.strip().encode('utf8')
                    totalCompensation = largeDetail[1].text.strip().split('As of')[0]
                description = keyExecs.find("p",{'itemprop':"description"})
                moredescription = keyExecs.find("span",{"id":"hidden"})
                if description :
                    desc = description.text.strip().encode('utf8') + ' '
                if moredescription :
                    desc += moredescription.text.strip().encode('utf8')    
                if keyExecs.find("div",{'itemprop':"workLocation"}) :
                    workLocation = keyExecs.find("div",{'itemprop':"workLocation"}).text.strip().encode('utf8')
                affiliations = keyExecs.findAll("a",{'itemprop':"affiliation"})
                affiliationList = []
                for affiliation in affiliations :
                    affiliationList.append(affiliation.text.strip().encode('utf8'))
                affiliationsStr = "|".join(affiliationList)            
                              
                item.append(name)
                item.append(jobTitle)
                item.append(worksFor)
                item.append(alumniOf)
                item.append(age)
                item.append(totalCompensation)
                item.append(desc)
                item.append(workLocation)
                item.append(affiliationsStr)
                items.append(item)
                
                fopen.writerows(items)
                time.sleep(3)        

if __name__ == '__main__':
    main()