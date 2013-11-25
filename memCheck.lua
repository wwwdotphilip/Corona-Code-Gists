--[[
    local mem = require"memCheck"
    mem.checkMem(3000) -- displays memory consumption every 3 seconds.
]]

local M = {}

local function checkmem()
    collectgarbage()
    print( "MemUsage: " .. string.format("%.03f",collectgarbage("count")) .. " KB" ) -- print in KB
    
    local textMem = system.getInfo( "textureMemoryUsed" ) / 1048576
    print( "TexMem:   " .. string.format("%.03f", textMem) .. " MB" ) -- print in MB
end

function M.checkMem(dTime)
    timer.performWithDelay(dTime, checkmem, 0)
end

return M
