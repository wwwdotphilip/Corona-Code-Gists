local db
local path
local M = {}
 
local infoTable = "inforTable"
local info_name = "info_name";
local info_age = "info_age";
local info_gender = "info_gender";
 
function M.opendatabase()
    local sqlite3 = require "sqlite3"
    path = system.pathForFile ( "data.db", system.DocumentsDirectory )
    db = sqlite3.open ( path )
    
    local function onSystemEvent ( event )
        if event.type == "applicationExit" then
            if db and db:isopen() then
                db:close()
            end
        end
    end
    Runtime:addEventListener( "system", onSystemEvent )
    
    local createTable = [[CREATE TABLE IF NOT EXISTS]] .. infoTable .. [[( id INTEGER PRIMARY KEY autoincrement,]] .. info_name .. [[,]] .. info_age .. [[,]] .. info_gender .. [[); ]]
    db:exec ( createTable )
end
 
function M.getInfo()
      local temp_name = {};
      local temp_age = {};
      local temp_gender = {};
      local row
  
      for row in db:nrows("SELECT * FROM " .. infoTable) do
            local rowData1 = row.info_name;
            local rowData2 = row.info_age;
            local rowData3 = row.info_gender;
            temp_name[#temp_name+1] = rowData1;
            temp_age[#temp_age+1] = rowData2;
            temp_gender[#temp_gender+1] = rowData3;
      end
      
      return temp_name, temp_age, temp_gender;
end
 
function M.setInfo(name, age, gender)
      local addInfo = [[ INSERT INTO ]] .. infoTable .. [[ VALUES (NULL, ']] .. name .. [[',]] .. age .. [[,']] .. ender .. [[');]]
      db:exec ( addInfo )
end
 
function M.updateInfo(current_name, new_age)
      local updateInfo = [[ UPDATE ]] .. infoTable .. [[ SET ]] .. info_age .. [[ = ]] .. new_age .. [[ WHERE ]] .. current_name .. [[ = ']] .. info_name .. [['; ]]
      db:exec ( updateInfo )
end
 
return M