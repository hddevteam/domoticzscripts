# domoticzscripts
Useful Domoticz scripts 
# gettemperature.py
This python scripts can get the temperature from your broadlink rm devices in your local network and send it to your domoticz sensor.

This script also work when you enable the authorization on your domoticz server.

Install https://github.com/mjg59/python-broadlink first to import broadlink lib.
# sendcode.py
You may use the file to send code via the json code file exported from the rmbridge. Please check the code.json as the sample json file format.

Usage: 
```sh
sendcode.py codename
```
# sony_device_lua.lua
You may use the script on your domoticz server with the virtual switch. I've tested with my Sony TV (Android TV based). The script will help you turn on the tv from the standby mode or turn it off to standby mode via network.

# switch_hdmi_sony_device.lua
This is a example that can control the sony tv to open and switch to HDMI2 over network. Tested on Sony bravia 55x8000c(Android TV) based.

# launch_kodi_sony_device.lua
This script will power on the sony tv first from standby mode and launch the kodi app over the network, tested on Sony TV 55x8000c

# How to get the Sony TV remote controller info?

Run following command. Replace the tvip with the IP address your tv used.
```sh
curl -XPOST http://tvip/sony/system -d '{"method":"getRemoteControllerInfo","params":[],"id":10,"version":"1.0"}'
```
# How to get the installed application of the Sony TV?
Run following command. Replace the tvip with the IP address your tv used. 
```sh
curl -v -H "Content-Type:application/json" -H "X-Auth-PSK:0000" -d "{\"id\":11,\"method\":\"getApplicationList\",\"version\":\"1.0\",\"params\":[]}" http://tvip/sony/appControl
```
# How to set the X-Auth-PSK key of your Sony TV?
Enable pre-shared key on your TV: [Settings] → [Network] → [Home Network Setup] → [IP Control] → [Authentication] → [Normal and Pre-Shared Key]

Set pre-shared key on your TV: [Settings] → [Network] → [Home Network Setup] → [IP Control] → [Pre-Shared Key] → [0000]


# More discussion 
https://www.domoticz.com/forum/viewtopic.php?t=8301
