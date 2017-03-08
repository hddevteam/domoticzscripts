-- this script will power on the sony tv first from standby mode and launch the kodi app over the network, tested on Sony TV 55x8000c
commandArray = {}
if(devicechanged['KODI']) then
  url = 'http://192.168.1.204/sony/system'
  urlircc = 'http://192.168.1.204/sony/IRCC'
  urlappcontrol = 'http://192.168.1.204/sony/appControl'
  headername = 'X-Auth-PSK'
  headervalue = '0000'
  jsonbodypoweroff = '{\\"id\\":2,\\"method\\":\\"setPowerStatus\\",\\"version\\":\\"1.0\\",\\"params\\":[{ \\"status\\" : false}]}'
  jsonbodypoweron = '{\\"id\\":2,\\"method\\":\\"setPowerStatus\\",\\"version\\":\\"1.0\\",\\"params\\":[{ \\"status\\" : true}]}'
  
  jsonbodykodi = '{\\"id\\":10,\\"method\\":\\"setActiveApp\\",\\"version\\":\\"1.0\\",\\"params\\":[{ \\"uri\\":\\"com.sony.dtv.org.xbmc.kodi.org.xbmc.kodi.Splash\\"}]}'
  
  
  if (devicechanged['KODI'] == 'On') then
    ---remotely turn on the TV first
    runcommand = 'curl -v -H \"Content-Type:application/json\" -H \"' .. headername .. ':' .. headervalue .. '\" -d \"' .. jsonbodypoweron .. '\" ' .. url .. ''
    print(runcommand)
    response = os.execute(runcommand)
    if response then
        print('TV is ON')
    else
        print('TV turn on failed')
    end

    runcommand = 'curl -v -H \"Content-Type:application/json\" -H \"' .. headername .. ':' .. headervalue .. '\" -d \"' .. jsonbodykodi .. '\" ' .. urlappcontrol .. ''
    print(runcommand)
    print(response)
    response = os.execute(runcommand)
    if response then
      print('TV open kodi application')
    else
      print('TV open kodi application failed')
    end
  end
  
  if (devicechanged['KODI'] == 'Off') then
    runcommand = 'curl -v -H \"Content-Type:application/json\" -H \"' .. headername .. ':' .. headervalue .. '\" -d \"' .. jsonbodypoweroff .. '\" ' .. url .. ''
    response = os.execute(runcommand)
    if response then
      print('TV goes sleepy sleep')
    else
      print('TV not in the mood for sleepy sleep')
    end
  end 
end

return commandArray
