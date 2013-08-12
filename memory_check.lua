local function checkmem()
    collectgarbage()
    print( "MemUsage: " .. string.format("%.00f",collectgarbage("count")) .. " KB" )
    
    local textMem = system.getInfo( "textureMemoryUsed" ) / 1048576
    print( "TexMem:   " .. string.format("%.03f", textMem) .. " MB" )
end

timer.performWithDelay(3000, checkmem, 0)
