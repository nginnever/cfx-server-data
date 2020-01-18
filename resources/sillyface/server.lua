RegisterCommand("save", function(src, args)
	local argstring = table.concat(args, " ")
	MySQL.Async.fetchAll("INSERT INTO main (id, name, args) VALUES(@source, @name, @args)",
		{["@source"] = src, ["@name"] = GetPlayerName(src), ["@args"] = argstring},
		function(res)
			TriggerClientEvent("output", src, "^2"..argstring.."^0")
		end
	)
end)

RegisterCommand("get", function(src)
	--local argstring = table.concat(args, " ")
	MySQL.Async.fetchAll("SELECT * FROM main ORDER BY id DESC LIMIT 1 ",
		{},
		function(res)
			local concat = "^3(".. res[1].name.. " ), (" .. res[1].args..")"
			TriggerClientEvent("getData", src, concat)
		end
	)
end)

RegisterServerEvent("serverGetCharacters")
AddEventHandler("serverGetCharacters", function(firstname, lastname, model)
	local _source = source
	local playerInfo = table.concat(GetPlayerIdentifiers(source), " ")
	local ptable = GetPlayerIdentifiers(source)
	--local numberid = string.gsub(ptable[1], "steam:", "")
	--local SteamID = tonumber(numberid, 16)
	local SteamID = ptable[1]
	SteamID = "'"..SteamID.."'"
	--local SteamID = string.gsub(ptable[1], "steamid=", "")
	--TriggerClientEvent("serverprint", _source, "server get chars event fired!")

	MySQL.Async.fetchAll("SELECT * FROM characters WHERE steamid="..SteamID.." ORDER BY fname DESC",
		{},
		function(res)
			--local resInfo = table.concat(res, " ")
			--local concat = "^3(".. res[1].name.. " ), (" .. res[1].args..")"
			--TriggerClientEvent("serverprint", _source, "database returned "..res[2].fname)
			TriggerClientEvent("clientGetCharacter", _source, res)
		end
	)

	-- TriggerEvent("redem:getPlayerFromId", _source, function(user)
	-- 	addCharacter(_source, user, firstname, lastname)
	-- end)
end)

RegisterServerEvent("serverGetInventory")
AddEventHandler("serverGetInventory", function(firstname, lastname, model)
	local _source = source
	local playerInfo = table.concat(GetPlayerIdentifiers(source), " ")
	local ptable = GetPlayerIdentifiers(source)
	local SteamID = ptable[1]
	SteamID = "'"..SteamID.."'"
	local id = 5
	-- hardcoded id to 5 for now
	MySQL.Async.fetchAll("SELECT * FROM inventory WHERE id="..id.." ",
		{},
		function(res)
			TriggerClientEvent("clientGetInventory", _source, res)
		end
	)
end)


RegisterServerEvent("createCharacter")
AddEventHandler("createCharacter", function(firstname, lastname, model)
	TriggerEvent('chat:addMessage', { args = { 'testing server callback'}})
	local _source = source
	local playerInfo = table.concat(GetPlayerIdentifiers(source), " ")
	local ptable = GetPlayerIdentifiers(source)
	--local numberid = string.gsub(ptable[1], "steam:", "")
	--local SteamID = tonumber(numberid, 16)
	local SteamID = ptable[1]
	--TriggerClientEvent("serverprint", _source, "Entity model ".. model)
-- Same as above but uses the DB to get a user instead of memory.
-- AddEventHandler("redem:getPlayerFromIdentifier", function(identifier, cb)
-- 	db.retrieveUser(identifier, function(user)
-- 		cb(user)
-- 	end)
-- end)

	MySQL.Async.fetchAll("INSERT INTO characters (charid, steamid, fname, lname, class, level, model) VALUES(@cid, @sid, @fn, @ln, @cl, @lvl, @md)",
		{["@cid"] = source, ["@sid"] = SteamID, ["@fn"] = firstname, ["@ln"] = lastname, ["@cl"] = "Human", ["@lvl"] = 0, ["@md"] = model},
		function(res)
			TriggerClientEvent("serverprint", _source, "Data added to database!")
		end
	)

	-- TriggerEvent("redem:getPlayerFromId", _source, function(user)
	-- 	addCharacter(_source, user, firstname, lastname)
	-- end)
end)