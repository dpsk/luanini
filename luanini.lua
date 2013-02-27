--[[
    Save and load for .INI files
    Written by Mikhail Nikalyukin <idups1k.at.gmail.com>
    Licensed under the GNU General Public License v3.
--]]

--[[
  Example of how load and display INI file:

    local config = loadConfiguration("path.ini")
    for tag, val in pairs(config) do
      for item, value in pairs(config[section]) do
        print(section, " -> ", item, ":", value, "\n")
      end
    end

  If you want to change only one line in the INI file:

    config[section][item] = value
    saveConfiguration(path, config)

--]]

function loadConfiguration(path)
  local file = io.open(path, "r")
  local configuration = {}
  local section = nil
  local item = nil
  local value = nil

  for line in file:lines() do
    if(string.sub(line,1,1) == "[") then
      section = trim(string.sub(line, 2, string.len(line) - 1 ))
      configuration[section] = {}
    else
      if(trim(line) ~= "") then
        item = trim(string.sub(line, 1, string.find(line, "=") - 1))
        value = string.sub(line, string.find(line, "=") + 1)
        configuration[section][item] = value or ""
      end
     end
  end

  file:close()

  return configuration
end

function saveConfiguration(path, tab)
  assert(path ~= nil, "Path can\'t be nil")
  assert(type(tab) == "table", "Second parameter must be a table")

  local f = io.open(path, "w")

  for section, val in pairs(tab) do
    f:write("["..section.."]".."\n")

    for item, value in pairs(tab[section]) do
      item = trim(item)
      value = trim(value)
      f:write(item.." = "..value.."\n")
    end
  end

  f:close()
end

function trim (s)
  return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end