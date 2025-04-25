local Config = require 'shared/config'

AddEventHandler("K9:Shared:DependencyUpdate", RetrieveComponents)
local function RetrieveComponents()
    Notification = exports["sandbox-base"]:FetchComponent("Notification")
    Jobs = exports["sandbox-base"]:FetchComponent("Jobs")
    ListMenu = exports["sandbox-base"]:FetchComponent("ListMenu")
    Keybinds = exports["sandbox-base"]:FetchComponent("Keybinds")
    if Config.K9.target == "sandbox" then
        Targeting = exports["sandbox-base"]:FetchComponent("Targeting")
    end
end

AddEventHandler("Core:Shared:Ready", function()
    local dependencies = {
        "Notification",
        "Jobs",
        "ListMenu",
        "Keybinds"
    }
    if Config.K9.target == "sandbox" then
        table.insert(dependencies, "Targeting")
    end

    exports["sandbox-base"]:RequestDependencies("K9", dependencies, function(error)
        if #error > 0 then
            return
        end
        RetrieveComponents()
        InitK9Ped()
        RegisterKeyBinds()
    end)
end)
