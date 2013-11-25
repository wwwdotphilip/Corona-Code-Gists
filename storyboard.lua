local storyboard = require"storyboard";
local scene = storyboard.newScene();
local screenGroup;

-- Place all of your objects inside a table for easy identification and removal
local btn = {} -- use for button widgets.
local num = {} -- use for number value.
local str = {} -- use for string value.
local bol = {} -- use for bollean value.
local scrl = {} -- use for scrollview widget.
local text = {} -- use for text displays.
local img = {} -- use for images display.
local rect = {} -- use for rectangle display.
local crcl = {} -- use for circle display.
local line = {} -- use for line display.
local tab = {} -- use for tab widget.
local swt = {} -- use for switch widget.
local tmr = {} -- use for timers.
local tran = {} -- use for transitions.

function scene:createScene( event )
    screenGroup = self.view;
    -- Declaire all objects inside here
    -- Make sure you insert all object inside screenGroup
    -- like this screenGroup:insert(object)
end

function scene:enterScene( event )
    -- Call all functions and listeners here
    -- Destroy or remove previous scene here
end

function scene:exitScene( event )
    -- This is where you remove all listeners
    scene:removeEventListener( "createScene", scene );
    scene:removeEventListener( "enterScene", scene );
    scene:removeEventListener( "exitScene", scene );
    scene:removeEventListener( "destroyScene", scene );
end

function scene:destroyScene( event )
    -- Remove all declared variables here.
    btn = nil
    num = nil
    str = nil
    bol = nil
    scrl = nil
    text = nil
    img = nil
    rect = nil
    crcl = nil
    line = nil
    tab = nil
    swt = nil
    tmr = nil
    tran = nil
end

function scene:overlayBegan( event )
    -- Use this function if you want to use overlay
    -- Will be called when overlay has began
end

function scene:overlayEnded( event )
    -- Use this function if you want to use overlay
    -- Will be called when overlay has ended.
end

scene:addEventListener( "createScene", scene );
scene:addEventListener( "enterScene", scene );
scene:addEventListener( "exitScene", scene );
scene:addEventListener( "destroyScene", scene );
scene:addEventListener( "overlayBegan" );
scene:addEventListener( "overlayEnded" );

return scene;
