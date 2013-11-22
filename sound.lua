--[[
To use this library simple require this on your lua file and call the functions

local sound = require"sound"
sound.loadSound()
sound.playSound(1)
sound.stopSound()
sound.pauseSound()
sound.resumeSound()
]]

local M = {}
M.stopSound = false
local soundSet

function M.loadSounds()
    soundSet = {
        audio.loadStream("sounds/bg.mp3"),
        audio.loadSound("sounds/button.mp3"),
        audio.loadSound("sounds/dead.mp3"),
    };
end

function M.pauseSound()
    audio.pause()
end

function M.resumeSound()
    audio.resume()
end

function M.stopSound()
    M.stopSound = true;
    audio.stop()
    for i = 1, #soundSet do
        audio.dispose( soundSet[i] )
        soundSet[i] = nil
    end
    soundSet = nil
end

function M.playSound(soundIndex)
    if soundIndex == 1 then
        if M.stopSound then
            M.stopSound = false
        else
            audio.play(soundSet[soundIndex], {onComplete = function()M.playSound(soundIndex)end}) -- replay the sound after it finished playing.
        end
    else
        audio.play(soundSet[soundIndex])
    end
end

return M
