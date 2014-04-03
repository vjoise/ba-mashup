import json, csv

with open("/Users/venkateshjk/Downloads/abc.json") as file:
    data = json.load(file)
    print str(data['result']['religion'][0])
    

