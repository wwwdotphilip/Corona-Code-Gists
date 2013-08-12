-- Note: When using this for your config.lua make sure when you declare an object ALWAYS use the contentHeight
-- as reference for the y coordinates.
-- example:
-- 
-- local _W = display.contentWidth
-- local _H = display.contentHeight
-- local rect = display.newRect(40, 40, 80, 80)
-- rect.x = _W / 2; rect.y = _H / 2; -- this will place the rectangle in the middle
-- no matter what the screen size is.

if display.pixelHeight > 960 then -- for device with longer height e.g. iPhone 5 and most Android Devices.
    application = {
        content = {
            width = 640,
            height = 1136,
            scale = "zoomStretch", -- Stretch to fit entire screen. This will cause some objects to look flat or stretched.
            fps = 30,              -- But I advice to use this scale since some app stores rejects apps that will not display
            antialias = "true",    -- all objects properly.
        },
        imageSuffix = {
            ["@2x"] = 2,           -- For iPhone retina display. Apple requires that all apps support retina display.
        },
    }
else -- for devices with shorter height e.g. iPhone 4, 3GS, iPad, some Android phones.
    application = {
        content = {
            width = 640,
            height = 960,
            scale = "zoomStretch",
            fps = 30,
            antialias = "true",
        },
        imageSuffix = {
            ["@2x"] = 2,
        },
    }
end
