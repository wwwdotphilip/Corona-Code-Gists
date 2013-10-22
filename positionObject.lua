-- Paste this library in your project folder.
-- To call this library simply follow this line of code.
-- local objPos=require("positionObject")
--[[
Corona SDK object positioning

Example.
    local otherText=display.newText("Other text",100,100,nil,14)
    local text=display.newText("Text",0,0,nil,14)
    objPos.positionObject({object=text,x=display.contentWidth*.5,y=display.contentHeight*.5}) -- positions at the center
    objPos.positionObject({object=text,marginLeft=10,marginTop=10}) -- positions at the top left corner with a left margin and a top margin
    objPos.positionObject({object=text,other=otherText,margin=10}) -- positions at the right(default) of the other object with a margin of 10
    objPos.positionObject({object=text,other=otherText,margin=10,where="bottom"}) -- positions at the bottom of the other object with a margin of 10
]]

local O = {}
--[[
{
	object=object,
	marginTop=number,
	marginRight=number,
	marginBottom=number,
	marginLeft=number,
	x=number,
	y=number,	
	other=object,
	where=string, -- top,right,bottom,left
	otherMargin=number
}
]]
function O.positionObject(params)
	local params=params or {}
	local object=params.object or nil
	local other=params.other or nil
	local where=params.where or "default"
	local otherMargin=params.otherMargin or 0
	local marginTop=params.marginTop or nil
	local marginRight=params.marginRight or nil
	local marginBottom=params.marginBottom or nil
	local marginLeft=params.marginLeft or nil			
	local xPos=params.x or nil
	local yPos=params.y or nil
	local objectWidthHalf
	local objectHeightHalf
	local otherWidthHalf
	local otherHeightHalf
	if object then
		objectWidthHalf=object.width/2
		objectHeightHalf=object.height/2
	else
		local alert=native.showAlert("Error","Need an object to position.",{"OK"})
	end
	if other then 
		otherWidthHalf=other.width/2
		otherHeightHalf=other.height/2
	end
	if other and object then
		if where=="top" then
			object.x=other.x
			object.y=other.y-otherHeightHalf-otherMargin-objectHeightHalf
		elseif where=="right" or where=="default" then
			object.x=other.x+otherWidthHalf+otherMargin+objectWidthHalf
			object.y=other.y
		elseif where=="bottom" then
			object.x=other.x
			object.y=other.y+otherHeightHalf+otherMargin+objectHeightHalf
		elseif where=="left" then
			object.x=other.x-otherWidthHalf-otherMargin-objectWidthHalf
			object.y=other.y
		end
	end
	if object then
		if marginTop and not marginBottom then 
			if where=="top" or where=="bottom" then
				local alert=native.showAlert("Warning","You can't use marginTop/marginBottom with otherMargin.",{"OK"}) 
			else
				object.y=marginTop+objectHeightHalf	
			end
		elseif marginBottom and not marginTop then
			if where=="top" or where=="bottom" then
				local alert=native.showAlert("Warning","You can't use marginTop/marginBottom with otherMargin.",{"OK"}) 
			else
				object.y=display.contentHeight-(marginBottom + objectHeightHalf) 
			end			
		elseif marginTop and marginBottom then 
			local alert=native.showAlert("Warning","You can't use marginTop or marginBottom at the same time.",{"OK"}) 
		end
		if marginLeft and not marginRight then
			if where=="left" or where=="right" then
				local alert=native.showAlert("Warning","You can't use marginLeft/marginRight with otherMargin.",{"OK"}) 
			else		 
				object.x=marginLeft+objectWidthHalf
			end
		elseif marginRight and not marginLeft then
			if where=="left" or where=="right" then
				local alert=native.showAlert("Warning","You can't use marginLeft/marginRight with otherMargin.",{"OK"}) 
			else		 
		 		object.x=display.contentWidth-(marginRight+objectWidthHalf)
		 	end
		elseif marginLeft and marginRight then 
			local alert=native.showAlert("Warning","You can't use marginLeft or marginRight at the same time.",{"OK"}) 
		end				
		if xPos then object.x=xPos end
		if yPos then object.y=yPos end
	end
end
return O
