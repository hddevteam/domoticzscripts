-- Modified the following part with the address and the auth code with your device.
url = 'http://192.168.1.204/sony/system'
headername = 'X-Auth-PSK'
headervalue = '0000'
  
function getPowerStatus()
  local jsonbodygetstatus = '{\\"id\\":2,\\"method\\":\\"getPowerStatus\\",\\"version\\":\\"1.0\\",\\"params\\":[]}'

  local runcommand = 'curl -v -H \"Content-Type:application/json\" -H \"' .. headername .. ':' .. headervalue .. '\" -d \"' .. jsonbodygetstatus .. '\" ' .. url .. ''
  print(runcommand)
  
  local h=io.popen(runcommand)
  local response=h:read("*a")
  h:close()

  if string.find(response, '{"status":"active"}') then
    return 'active'
  elseif string.find(response, '{"status":"standby"}') then
    return 'standby'
  else
    return 'unkown'
  end
end

commandArray = {}
if(devicechanged['TV']) then
  jsonbodypoweroff = '{\\"id\\":2,\\"method\\":\\"setPowerStatus\\",\\"version\\":\\"1.0\\",\\"params\\":[{ \\"status\\" : false}]}'
  jsonbodypoweron = '{\\"id\\":2,\\"method\\":\\"setPowerStatus\\",\\"version\\":\\"1.0\\",\\"params\\":[{ \\"status\\" : true}]}'
  powerStatus = getPowerStatus()
  print('TV status is: ' .. powerStatus ..'')
  if (devicechanged['TV'] == 'On') then
      if powerStatus == 'standby' then
        ---jxm remotely turn on the TV
        runcommand = 'curl -v -H \"Content-Type:application/json\" -H \"' .. headername .. ':' .. headervalue .. '\" -d \"' .. jsonbodypoweron .. '\" ' .. url .. ''
         response = os.execute(runcommand)
         if response then
           print('TV is ON')
         else
           print('TV turn on failed')
         end
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
