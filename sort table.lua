
local t = {2,1,9,6,8,7,5}
local t = {"a","f","e","u","y","k","l"}
local t = {"hfolv","ydvbbk","setggh","nhfrtfh","bgsdfrty","afdfg","axcbh"}
local t2 = {}

--table.sort(t, function(a,b) return a>b end) -- sort reverse
print("Initial value ", table.concat(t, ","))
for i = 1, #t do
    if t2[1] == nil then
        t2[i] = t[i];
    else
        local skip = false
        for j = 1, #t2 do
            if t[i] < t2[j] then
                local tempT2 = t2[j]
                t2[j] = t[i]
                table.insert(t2, j+1, tempT2)
                skip = true
                break;
            end
        end
        if skip == false then
            t2[#t2+1] = t[i];
        end
    end
end

print("Final value ", table.concat(t2, ","))


