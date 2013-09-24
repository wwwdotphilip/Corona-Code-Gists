-- This code will scale the font size of textfield for different devices.
-- Note: I have only tested this on iPod, iPad and Galaxy S2. So I cannot give a 100% guaranty that this will work on all devices.

textField = native.newTextField( 40, 80, 560, 80 ) -- declaire native textfield
        
local fontSize = textField.height * .3 -- Value of font size.
        
if( display.contentScaleY < 1 ) then
    fontSize =  fontSize / display.contentScaleY -- Scale the font depending on the screen size.
end

textField.font = native.newFont( "Helvetica" ) -- You can change this to any font you like.
textField.size = fontSize  -- Set the new font
