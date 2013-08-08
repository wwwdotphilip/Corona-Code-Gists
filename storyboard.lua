local storyboard = require"storyboard";
local scene = storyboard.newScene();


function scene:createScene( event )
    -- Declaire all objects inside here
end

function scene:enterScene( event )
    -- Call all functions and listeners here
    -- Destroy or remove previous scene here
end

function scene:exitScene( event )
    -- remove all listeners here such as Runtime listeners.
    scene:removeEventListener( "createScene", scene )
    scene:removeEventListener( "enterScene", scene )
    scene:removeEventListener( "exitScene", scene )
    scene:removeEventListener( "destroyScene", scene )
end

function scene:destroyScene( event )
    
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene;
