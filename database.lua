local db
local path
local M = {}
 
local infoTable = "inforTable";  -- Declaire string variables. Make sure that your variable name and value are the same.
local info_name = "info_name";
local info_age = "info_age";
local info_gender = "info_gender";
 
function M.opendatabase()
    local sqlite3 = require "sqlite3" -- call sqlite3 library.
    path = system.pathForFile ( "data.db", system.DocumentsDirectory ) -- create path.
    db = sqlite3.open ( path ) -- open the database.
    
    local function onSystemEvent ( event ) -- close database when app exits.
        if event.type == "applicationExit" then
            if db and db:isopen() then
                db:close()
            end
        end
    end
    Runtime:addEventListener( "system", onSystemEvent ) -- callback for closing the database
    
    local createTable = [[CREATE TABLE IF NOT EXISTS]] .. infoTable .. [[( id INTEGER PRIMARY KEY autoincrement,]] .. info_name .. [[,]] .. info_age .. [[,]] .. info_gender .. [[); ]]
    db:exec ( createTable ) -- create table if it does not exist.
end
 
function M.getInfo() -- retrieve contents of table.
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
 
function M.setInfo(name, age, gender) -- store data to table.
      local addInfo = [[ INSERT INTO ]] .. infoTable .. [[ VALUES (NULL, ']] .. name .. [[',]] .. age .. [[,']] .. gender .. [[');]]
      db:exec ( addInfo )
end
 
function M.updateInfo(current_name, new_age) -- update data of table.
      local updateInfo = [[ UPDATE ]] .. infoTable .. [[ SET ]] .. info_age .. [[ = ]] .. new_age .. [[ WHERE ]] .. current_name .. [[ = ']] .. info_name .. [['; ]]
      db:exec ( updateInfo )
end
 
return M -- We must return the variable M in order to call its functions.
