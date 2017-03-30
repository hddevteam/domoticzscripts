#!/usr/bin/python
#you may use the file to send code via the json code file exported from the rmbridge.
#usage: sendcode.py codename
import sys
import json
import broadlink

#modify the file name to the file exported from rmbridge the file content shoud like the following
#if you want to run this script in the domoticz, make sure you are using the absolute path of the json file.
jsonFile = 'code.json'

#modify the ip address and the mac address with your device.
device_ip = "192.168.1.57"
device_mac = "34ea34e398a7"

device_type = "broadlink.rm2"
device_port = 80

device = broadlink.rm(host=(device_ip,device_port), mac=bytearray.fromhex(device_mac))

device.auth()
device.host
print 'host: ' + ' '.join(str(v) for v in device.host)

codeName = ''
if len(sys.argv)>1: #check if user has input the code name.
    #print len(sys.argv)
    codeName = sys.argv[1]
    codeName = codeName.strip()
    if codeName!='':
        isfound = False
        with open(jsonFile) as json_data:
            jsonData = json.load(json_data)
        #print(jsonData)   
        #print len(json.loads(data))
        for jd in jsonData:  #Traverse and find the code with name
            #print jd
            if jd.get("name") == codeName: #compare name
                codeData = jd.get("data")
                isfound = True 
                print jd.get("name")
                print codeData
                pad_len = 32 - (len(codeData) - 24) % 32
                codeData = codeData + "".ljust(pad_len, '0') 
                print codeData 
                device.send_data(codeData.decode('hex'))
                print 'Data sent'
        if not isfound:
            print 'Can not find the code via codeName:', codeName, '. Please check it.'
else:
    print 'received no codeName'
