luanini
=======

Small lua lib for R/W access to the INI files.

# Load

    local config = loadConfiguration("path.ini")
    for tag, val in pairs(config) do
      for item, value in pairs(config[section]) do
        print(section, " -> ", item, ":", value, "\n")
      end
    end
# Save

    saveConfiguration(path, config)

If you want to only change one line

    config[section][item] = value
    local config = loadConfiguration("path.ini")