-- if you can not trigger the sendcode.py command on you raspberry pi via domoticz switch, you may try to use this lua script.
-- it will call out the sendcode.py python and control it by the device name.

-- create the lua from Setup -> More Options -> Events
-- in the right pannel
-- Event Name -> callpython_device or other name you prefer
-- Lua
-- Device
-- check Event active checkbox.

commandArray = {}

-- setup your python script here, remember to use the full path.
runcommand = '/home/pi/domoticz/scripts/python/sendcode.py'
param = ""
-- loop through all the changed devices
for deviceName,deviceValue in pairs(devicechanged) do
    print ("Device based event fired on '"..deviceName.."', value '"..tostring(deviceValue).."'");
-- modify your device name and the param here.
    if (deviceName=='书房灯') then
        if deviceValue == 'On' then
            param = 'studyroom-on'
        elseif deviceValue == 'Off' then
            param = 'studyroom-off'
        end
    elseif (deviceName=='走廊灯') then
        if deviceValue == 'On' then
            param = 'entrancelight-on'
        elseif deviceValue == 'Off' then
            param = 'entrancelight-off'
        end
    end

    runcommand = runcommand .." "..param
    print(runcommand)
-- will run the command like this '/home/pi/domoticz/scripts/python/sendcode.py studyroom-off'
    response = os.execute(runcommand)

end

return commandArray
