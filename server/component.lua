AddEventHandler("K9:Shared:DependencyUpdate", RetrieveComponents)
function RetrieveComponents()
	Fetch = exports["sandbox-base"]:FetchComponent("Fetch")
	Logger = exports["sandbox-base"]:FetchComponent("Logger")
	Jobs = exports["sandbox-base"]:FetchComponent("Jobs")
	Inventory = exports["sandbox-base"]:FetchComponent("Inventory")
end

AddEventHandler("Core:Shared:Ready", function()
	exports["sandbox-base"]:RequestDependencies("K9", {
		"Fetch",
		"Logger",
		"Jobs",
		"Inventory",
	}, function(error)
		if #error > 0 then
			exports["sandbox-base"]:FetchComponent("Logger"):Critical("K9", "Failed To Load All Dependencies")
			return
		end
		RetrieveComponents()
	end)
end)
