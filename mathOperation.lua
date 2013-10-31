--[[Some math operations

1. Random numbers with probability
2. Round numbers to the specified decimal value
3. Insert comma for number with more that 3 digits.

to initialize this just require it on your lua file
local mathOperations = require"mathOperation"

example math call:
print(mathOperation.round(123.123, 0)
output = 123

print(mathOperation.commaVal(12345678)
output = 12,345,678

local options = {
                returnVal = "object1",
                probability = 20,      -- 20% probability
            },
            {
                returnVal = "object2",
                probability = 10,      -- 10% probability
            },
            {
                returnVal = "object3",
                probability = 15,      -- 15% probability
            },
}
print(mathOperation.probabilityCheck(options)
output = object1
]]

local M = {}

function M.probabilityCheck(params)
    local val = {}
    local rand = math.random(1, 10000)
    for i = 1,#params do
        local loopVal = params[i].probability * 100
        for j = 1,loopVal do
            val[#val+1] = params[i].returnVal
        end
    end
    if not val[rand] then
        return false
    else
        return val[rand]
    end
end

function M.round(num, idp)
    local mult = 10^(idp or 0)
    if num >= 0 then 
        return math.floor(num * mult + 0.5) / mult
    else 
        return math.getCeil(num * mult - 0.5) / mult 
    end
end

function M.commaVal(amount)
    local formatted = amount
    local k;
    while true do  
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k==0) then
            break
        end
    end
    return formatted
end

return M
