-- This code will scale the font size of textfield with different device.
-- Note: I have only tested this on iPod, iPad and Galaxy S2. So I cannot give a 100% guaranty that this will work.

textField = native.newTextField( 40, 80, 560, 80 ) -- declaire native textfield
        
local fontSize = 24 -- Value of font size. Change this value if your textfield height is not 80 like I have set.
        
if( display.contentScaleY < 1 ) then
    fontSize =  newMoveFont / display.contentScaleY -- Scale the font depending on the screen size.
end

textField.font = native.newFont( "Helvetica" ) -- You can change this to any font you like.
textField.size = fontSize  -- Set the new font
