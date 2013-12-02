--[[
Note: For Android Only
This Code Will check if the app is installed in the device
]]
local checkapp = display.newImageRect("android.app.icon://eight.app.studio.aliendisruption",0,0)

if checkapp then
    --app is intalled
else
    --app is not intalled
end
