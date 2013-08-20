local media = require"media";

local soundSet = {
    shortSound1 = media.newEventSound("sounds/shortSound1.wav"),
    shortSound2 = media.newEventSound("sounds/shortSound2.wav"),
    bgSound = audio.loadStream("sounds/bgSound.wav")
};

local function playShortSound1()
    media.playEventSound( soundSet["shortSound1"] );
end
timer.performWithDelay(1000, playShortSound1);

local function playShortSound2()
    media.playEventSound( soundSet["shortSound2"] );
end
timer.performWithDelay(2000, playShortSound2);

local function playbgSound()
    audio.play(soundSet["bgSound"]);
end
timer.performWithDelay(3000, playbgSound);
