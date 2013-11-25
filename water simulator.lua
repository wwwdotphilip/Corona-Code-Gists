display.setStatusBar(display.HiddenStatusBar)
local physics = require"physics"

local resetbtn = nil
local up, down = nil, nil

display.setDefault( "background", 255, 200, 100 )

display.setStatusBar( display.HiddenStatusBar )

local stage = display.getCurrentStage()

local balls, statics, water, ui = display.newGroup(), display.newGroup(), display.newGroup(), display.newGroup()
local scenary, blobs = display.newGroup(), display.newGroup()
statics:insert(scenary)
statics:insert(blobs)

local count = display.newText( "10", 50, 50, nil, 38 )

physics.start()
physics.setGravity(0,10)
physics.setDrawMode("normal")

--physics.addBody( display.newRect( scenary, 0,0 , display.contentWidth,5 ), "static" ) -- top
physics.addBody( display.newRect( scenary, 0,display.contentHeight-5, display.contentWidth,5 ), "static" ) -- bottom

physics.addBody( display.newRect( scenary, 0,-display.contentHeight, 5,display.contentHeight*2 ), "static" ) -- left
physics.addBody( display.newRect( scenary, display.contentWidth-5,-display.contentHeight, 5,display.contentHeight*2 ), "static" ) -- right

-- spout
physics.addBody( display.newRect( scenary, 0,30, 300, 10 ), "static" )
scenary[scenary.numChildren].rotation = 30
physics.addBody( display.newRect( scenary, display.contentWidth-300,30, 300, 10 ), "static" )
scenary[scenary.numChildren].rotation = -30

-- interact with the water
local function touch(e)
    if (e.phase == "began") then
        local circle = display.newCircle(ui,e.x,e.y,30)
        physics.addBody(circle,"dynamic", { friction=0, bounce=0, density=1, radius=30 } )
        stage:setFocus( circle )
        circle.hasFocus = true
        circle.touchjoint = physics.newJoint( "touch", circle, e.x, e.y )
        circle:addEventListener("touch",touch)
        return true
    elseif (e.target.hasFocus) then
        if (e.phase == "moved") then
            e.target.touchjoint:setTarget( e.x, e.y )
        else
            stage:setFocus(nil)
            e.target:removeEventListener("touch",touch)
            e.target.touchjoint:removeSelf()
            e.target:removeSelf()
        end
        return true
    end
    return false
end

-- update trailing water tails
local function updateTrail( group )
    local root = group[1]
    local history = group.history
    
    table.insert( history, 1, { x=root.x, y=root.y } )
    
    for i=2, group.numChildren do
        local child = group[i]
        local item = history[i]
        child.x, child.y = item.x, item.y
    end
    
    if (#history > group.numChildren) then
        table.remove(history)
    end
end

local function enterFrame()
    for i=1, balls.numChildren do
        balls[i]:updateTrail()
    end
end

-- create the water
local function justAddWater()
    for r=1, count.text do
        for c=1, 5 do
            local x, y = 100+20*c+math.random(-3,3), -100-r*20
            
            local ball = display.newGroup()
            balls:insert(ball)
            ball.history = {}
            
            for i=16, 10, -2 do
                display.newCircle( ball, 0, 0, i ):setFillColor(0,0,255)
                ball.history[#ball.history+1] = {x=-100,y=-100}
            end
            
            ball[1].x, ball[1].y = x, y
            ball.updateTrail = updateTrail
            
            physics.addBody( ball[1], "dynamic", { friction=.3, bounce=.6, density=.4, radius=4 } )
        end
    end
    
    Runtime:removeEventListener("tap",justAddWater)
    Runtime:removeEventListener("touch",draw)
    
    Runtime:addEventListener("touch",touch)
    
    Runtime:addEventListener("enterFrame",enterFrame)
    
    print("Droplets #: ",balls.numChildren)
    
    resetbtn.alpha = 1
    up.alpha = 0
    down.alpha = 0
end

-- draw obstacles
local function draw(e)
    local blob = display.newCircle( blobs, e.x, e.y, 20 )
    blob:setFillColor(133, 94, 66)
    physics.addBody( blob, "static" )
    return true
end

Runtime:addEventListener("touch",draw)

Runtime:addEventListener("tap",justAddWater)

-- controls...
resetbtn = display.newCircle(50, 120, 30)
resetbtn:setFillColor(255,0,0)
resetbtn.alpha = 0
local function reset()
    print("Resetting")
    
    resetbtn.alpha = 0
    up.alpha = 1
    down.alpha = 1
    
    Runtime:removeEventListener("touch",touch)
    Runtime:removeEventListener("enterFrame",enterFrame)
    
    while (balls.numChildren > 0) do
        balls[1]:removeSelf()
    end
    while (blobs.numChildren > 0) do
        blobs[1]:removeSelf()
    end
    
    Runtime:addEventListener("touch",draw)
    Runtime:addEventListener("tap",justAddWater)
    
    return true
end
resetbtn:addEventListener("tap",reset)

local function ignore()
    return true
end
local function add()
    count.text = count.text+1
    return true
end
local function subtract()
    count.text = count.text-1
    if (tonumber(count.text)<1) then count.text=1 end
    return true
end
up = display.newCircle(display.contentWidth-50, 50, 30)
down = display.newCircle(display.contentWidth-50, 120, 30)
up:addEventListener("tap",add)
down:addEventListener("tap",subtract)
up:addEventListener("touch",ignore)
down:addEventListener("touch",ignore)

