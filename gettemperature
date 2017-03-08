#this python scripts can help you get the temperature from the broadlink rm devices and send it to your domoticz sensor.
#this script also work when you enable the authorization on your domoticz server.
#install https://github.com/mjg59/python-broadlink first to import broadlink lib.
import broadlink,urllib2,base64
devices = broadlink.discover(timeout=5)
devices[0].auth()
temp =  devices[0].check_temperature()
print temp

#update url http://192.168.1.2:8084 with your domoticz address, you may also need to modifity the idx number with your own.
url = "http://192.168.1.2:8084/json.htm?type=command&param=udevice&idx=3&nvalue=0&svalue={0:0.1f}".format(temp)

print url

#refer to https://www.domoticz.com/wiki/Domoticz_API/JSON_URL%27s#Authorization
#update the username and password with your username and password. tested with form based authentication, should work with basic auth too.
auth = base64.b64encode('username:password')
auth = "Basic " + auth
print auth

opener = urllib2.build_opener()
opener.addheaders = [('Authorization', auth)]
response = opener.open(url)
print response.read()
