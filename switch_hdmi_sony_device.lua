-- This is a example that can control the sony tv to open and switch to HDMI2 over network. Tested on Sony bravia 55x8000c(Android TV) based.
function sleep(n)
  os.execute("sleep " .. tonumber(n))
end

commandArray = {}
if(devicechanged['TV']) then
  url = 'http://192.168.1.204/sony/system'
  urlircc = 'http://192.168.1.204/sony/IRCC'
  urlappcontrol = 'http://192.168.1.204/sony/appControl'
  headername = 'X-Auth-PSK'
  headervalue = '0000'
  jsonbodypoweroff = '{\\"id\\":2,\\"method\\":\\"setPowerStatus\\",\\"version\\":\\"1.0\\",\\"params\\":[{ \\"status\\" : false}]}'
  jsonbodypoweron = '{\\"id\\":2,\\"method\\":\\"setPowerStatus\\",\\"version\\":\\"1.0\\",\\"params\\":[{ \\"status\\" : true}]}'
  
  xboxonesoap = '<?xml version=\\"1.0\\"?><s:Envelope xmlns:s=\\"http://schemas.xmlsoap.org/soap/envelope/\\" s:encodingStyle=\\"http://schemas.xmlsoap.org/soap/encoding/\\"><s:Body><u:X_SendIRCC xmlns:u=\\"urn:schemas-sony-com:service:IRCC:1\\"><IRCCCode>AAAAAgAAABoAAABbAw==</IRCCCode></u:X_SendIRCC></s:Body></s:Envelope>' 
  
  
  if (devicechanged['TV'] == 'On') then
    ---jxm remotely turn on the TV first
    runcommand = 'curl -v -H \"Content-Type:application/json\" -H \"' .. headername .. ':' .. headervalue .. '\" -d \"' .. jsonbodypoweron .. '\" ' .. url .. ''
    print(runcommand)
    response = os.execute(runcommand)
    if response then
        print('TV is ON')
    else
        print('TV turn on failed')
    end
    
    sleep(3) 
    
    runcommand = 'curl -v -H \"Content-Type:text/xml; charset=UTF-8\" -H \'SOAPACTION: \"urn:schemas-sony-com:service:IRCC:1#X_SendIRCC\"\' -H \"' .. headername .. ':' .. headervalue .. '\" -d \"' .. xboxonesoap .. '\" ' .. urlircc .. ''
    print(runcommand)
    print(response)
    response = os.execute(runcommand)
    if response then
      print('TV turn to HDMI2')
    else
      print('TV turn to HDMI2 failed')
    end
  end
  
  if (devicechanged['TV'] == 'Off') then
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
