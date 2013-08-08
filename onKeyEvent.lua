local function onKeyEvent( event )
    local phase = event.phase -- handles the phase of hardware keys e.g "up", "down"
    local keyName = event.keyName -- handles keyName e.g "back", "search", "menu", "volumeUp", "volumeDown"
    if phase == "up" and keyName == "back" then
        --Put here what you want to do
        return true -- OS will not handle this key once return true.
    else
        return false -- OS will handle the rest of key exept for the back key.
    end
end
 
Runtime:addEventListener("key", onKeyEvent) -- callback key event.