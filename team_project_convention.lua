 --[[
 Naming convention for team development projects.
 All object will be place inside a table for easy identification and remobal.
 
 for example: 
 
 str.name = "John Doe"
 
 bol.isUsable = false

 btn.close = widget.newButton{
      defaultFile = "close.png",
      overFile = "closeOver.png",
      width = 120,
      height = 80
 }
]]

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

--[[
    Team project structure
    
    Project folder
        \-- main.lua
        \-- build.settings
        \-- config.lua
            class(folder)
                \-- mainScreen.lua
                \-- gameScreen.lua
            lib(folder)
                \-- ads.lua
                \-- database.lua
            sound(folder)
                \-- hit.wav
                \-- jump.wav
                \-- bg.mp3
            images(folder)
                \-- button.png
                \-- character.png
            video(folder)
                \-- intro.mp4
]]

