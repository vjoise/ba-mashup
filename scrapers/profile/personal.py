import json
import urllib2

BASE_URL = "https://www.googleapis.com/freebase/v1/topic/en/$username$?key=AIzaSyCYxVBpapMmVLRtgPZAmoU3H-wthx2yreQ"

PROFILE_CSV_FILE = "../../starting_csv/ceoprofile.csv"
PROFILE_CSV_FILE_UPDATED = "../../starting_csv/ceoprofile_updated.csv"

FREEBASE_PROFILE_KEY_MAP = {}
#/business/employment_tenure/title
#/business/employment_tenure/to

#/people/person/date_of_birth
#/people/person/employment_history
#/people/person/gender
#/people/person/nationality
#/people/person/place_of_birth
#/people/person/parents
#/people/person/profession
#/people/person/education

def requestForData(url) :
    req = urllib2.Request(url)
    response = urllib2.urlopen( req )
    data = response.read()
    return data

profileCSVFile = open(PROFILE_CSV_FILE , 'r')
data = []
js = ""
count=0;

def remove_ascii(text):
   return ''.join([i if ord(i) < 128 else ' ' for i in text])

updatedProfileCSVFile = open(PROFILE_CSV_FILE_UPDATED , 'w+')
def safeGet(key, multiple) :
    value = "";
    if dat['property'].has_key(key) :
        if multiple :
            for values in dat['property'][key]['values']:
                value += values['text'] + " | ";
        else :
            value = dat['property'][key]['values'][0]['text'];
    return remove_ascii(value);
ind=0
for CEOData in profileCSVFile.readlines():
    name = "";
    try :
        data = CEOData.split(',')
        name = data[1].replace('.','');    
        name = str(name).replace('  ', '_')
        name = str(name).replace(' ', '_')   
        name = name.replace('__', '_').lower();
        url = BASE_URL.replace('$username$', name)
        js = requestForData(url)
        count += 1;
        dat = json.loads(js);
        print url
        FREEBASE_PROFILE_KEY_MAP[name] = {};
        CEOData = CEOData.replace('\r\n','')
        print CEOData.count('\r\n')
        CEOData += "," + safeGet('/people/person/gender', False)
        CEOData += "," +  safeGet('/people/person/date_of_birth', False)
        CEOData += "," +  safeGet('/people/person/place_of_birth', False)
        CEOData += "," + safeGet('/people/person/nationality', True)
        CEOData += "," + safeGet('/people/person/employment_history', True)
        CEOData += "," + safeGet('/people/person/parents', True)
        CEOData += '\n'
        updatedProfileCSVFile.write(CEOData);
    except Exception as e:
        print 'couldn\'t find data for person : ' + name
        pass
    ind = ind + 1
    updatedProfileCSVFile.flush()
    updatedProfileCSVFile.close()