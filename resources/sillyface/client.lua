sillfaceSelected = false
-- spawn vehicle by key
Citizen.CreateThread(function()
	local b_key = keys["B"]
	while true do
		Citizen.Wait(0)
		if IsControlJustReleased(0, b_key) then
			-- SpawnHorse(0x8BD282A4)
			SpawnVehicle("horseBoat")
		end
	end

end)

-- spawn animal by key
Citizen.CreateThread(function()
	local g_key = keys["U"]
	while true do
		Citizen.Wait(0)
		if IsControlJustReleased(0, g_key) then
			-- SpawnHorse(0x8BD282A4)
			SpawnAnimal("A_C_Horse_Arabian_White")
		end
	end

end)

-- shapeshift animal by key
Citizen.CreateThread(function()
	local y_key = keys["G"]
	while true do
		Citizen.Wait(0)
		if IsControlJustReleased(0, y_key) then
			-- SpawnHorse(0x8BD282A4)
			ShapeShift("A_C_Cat_01")
		end
	end

end)


-- dismount by key
Citizen.CreateThread(function()
	local j_key = keys["J"]
	while true do
		Citizen.Wait(0)
		if IsControlJustReleased(0, j_key) then
			Dismount()
		end
	end

end)

-- give weapon ----
Citizen.CreateThread(function()
	local l_key = keys["L"]
	while true do
		Citizen.Wait(0)
		if IsControlJustReleased(0, l_key) then
			-- GiveWeapon(0xBE8D2666)
			GiveWeapon("WEAPON_PISTOL_M1899")
		end
	end
end)

-- drop object ----
-- Citizen.CreateThread(function()
-- 	local l_key = keys["RIGHTBRACKET"]
-- 	while true do
-- 		Citizen.Wait(0)
-- 		if IsControlJustReleased(0, l_key) then
-- 			DropObject("P_BOXLRGMEAT01X")
-- 		end
-- 	end
-- end)

-- fireball ----
Citizen.CreateThread(function()
	local f_key = keys["F"]
	while true do
		Citizen.Wait(0)
		if IsControlJustReleased(0, f_key) then
			FireBall()
		end
	end
end)


-- illuminate ----

-- Citizen.CreateThread(function()
-- 	local f_key = keys["F"]
-- 	while true do
-- 		Citizen.Wait(0)
-- 		if IsControlJustReleased(0, f_key) then
-- 			Illuminate()
-- 		end
-- 	end
-- end)

-- inventory ----
Citizen.CreateThread(function()
	local tab_key = keys["I"]
	while true do
		Citizen.Wait(0)
		if IsControlJustReleased(0, tab_key) then
			OpenGui()
		end
	end
end)


local isFOW = false
local isGOD = false

RegisterCommand("gunomata", function()
	gunomata("spawning a bear...")
end, false)

RegisterCommand("togglefow", function()
	if isFOW then
		hideFOW(false)
		isFOW = false
	else
		hideFOW(true)
		isFOW = true
	end
end, false)

RegisterCommand("togglegod", function()
	if isGOD then
		godmode(false)
		isGOD = false
	else
		godmode(true)
		isGOD = true
	end
end, false)

function gunomata(data)
	-- spawnAnimal("WEAPON_RIFLE_SPRINGFIELD")
	GiveWeapon("WEAPON_PISTOL_M1899")
	--SpawnHorse("Horse")
	-- TriggerEvent("chatMessage", "[Natomata]", {255,0,0}, data)
end


-- look for object ----

-- function scenrionahoi(text)
-- 	SetTextComponentFormat('STRING')
-- 	AddTextComponentString(text)
-- 	DisplayHelpTextFromStringLabel(0, false, false, -1)
-- end

-- void PedPickupNearestWeapon(Ped ped)    {
--     Prop NearestWeapon = Function.Call<Prop>(Hash.GET_CLOSEST_OBJECT_OF_TYPE, ped.Position.X, ped.Position.Y, ped.Position.Z, 7f, Function.Call<int>(Hash.GET_HASH_KEY, "w_pi_pistol"), 0, 0, 0);
--     if (NearestWeapon != null && NearestWeapon.Exists() && ped.Weapons.Current.Hash.Equals(WeaponHash.Unarmed))        {
--         ped.Task.ClearAllImmediately();
--         ped.Weapons.RemoveAll();
--         TaskSequence PedPickupWeapon = new TaskSequence();
--         PedPickupWeapon.AddTask.RunTo(NearestWeapon.Position);
--         PedPickupWeapon.AddTask.PlayAnimation("pickup_object", "pickup_low", 8f, -1, false, 0f);
--         PedPickupWeapon.Close();
--         ped.Task.PerformSequence(PedPickupWeapon);
--         Script.Wait(750); 
--         NearestWeapon.Delete();
--         NearestWeapon = null;
--        ped.Weapons.Give(WeaponHash.Pistol, 9999, true, true);
--    }
-- }

function DeleteThing(o)
	TriggerEvent("chatMessage", "[Natomata]", {255,0,0}, "running pickup item")
  	SetEntityAsMissionEntity(o, true, true)
  	--DeleteEntity(o) -- also works
  	DeleteObject(o)
  	-- local playerPed = PlayerPedId()
  	-- local taskID = TaskPickUpWeapon(o)
  	-- TaskPerformSequence(playerPed, taskID)
  	--TaskPickUpWeapon(o)
end

local text_take = 'Pick up items [ENTER]'

local dropList = {}
dropList[GetHashKey("P_BOXLRGMEAT01X")] = true
--dropList[GetWeapontypeModel(GetHashKey("WEAPON_PISTOL_M1899"))] = true
Citizen.CreateThread(function()
	while true do
	Citizen.Wait(0)
		local playerPed = PlayerPedId() -- get the local player ped
		local pos = GetEntityCoords(playerPed) -- get the position of the local player ped
		--local w = GetWeapontypeModel(GetHashKey("WEAPON_PISTOL_M1899"))
		for k,v in pairs(dropList) do
			if DoesObjectOfTypeExistAtCoords(pos.x, pos.y, pos.z, 1.3, k, true) then
				--GetWeapontypeModel
				--TriggerEvent("chatMessage", "[Natomata]", {255,0,0}, "Item " ..k.. " ")
				local Obj = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.3, k, false, false, false)
				-- if HasModelLoaded(Obj) then
				-- 	TriggerEvent("chatMessage", "[Natomata]", {255,0,0}, "gun loaded " ..k.. " ")
				-- end
				--TriggerEvent("chatMessage", "[Natomata]", {255,0,0}, "Item " ..Bag.. " ")
				--if NetworkGetNetworkIdFromEntity(Bag) == k then
					--scenrionahoi(text_take)
					if IsControlJustReleased(0, keys["ENTER"]) then
						-- TriggerServerEvent('DropSystem:take', k)
						TriggerEvent("chatMessage", "[Natomata]", {255,0,0}, "Item id? " ..Obj.. " , "..Obj.x)
						TriggerServerEvent("getDroppedItem", Obj)
						DeleteThing(Obj)
					end
				--end
			end
		end
	end
end)

-- open character creator
Citizen.CreateThread(function()
	-- local char = {characterid = 0, identifier = 420, firstname = "Natomata", lastname = "Haxorz", class = "human", level = 0}
	-- local char2 = {characterid = 1, identifier = 1337, firstname = "Natomata", lastname = "Haxorz", class = "oddity", level = 420}
	-- local char3 = {characterid = 2, identifier = 1338, firstname = "Natomata", lastname = "Haxorz", class = "hunter", level = 1337}
	-- local charList = {}
	-- charList[1] = char -- the value of that element is a table
	-- charList[2] = char2
	-- charList[3] = char3
	ShutdownLoadingScreen()
	Citizen.Wait(3000)
	TriggerServerEvent("serverGetCharacters")
	TriggerServerEvent("serverGetInventory")
	--BootCreator()
	--BootCharSelect(charList)
	--DisplayHud(false)
	DisplayRadar(false)
end)


-- server forced print
RegisterNetEvent("serverprint")
AddEventHandler("serverprint", function(arg)
	TriggerEvent("chatMessage", "[Natomata]", {255,0,0}, "From Server: " ..arg)
end)

-- database client
RegisterNetEvent("output")
AddEventHandler("output", function(arg)
	TriggerEvent("chatMessage", "[Natomata]", {255,0,0}, "Databases successfully added " ..arg.. " into the database")
end)

RegisterNetEvent("getData")
AddEventHandler("getData", function(arg)
	TriggerEvent("chatMessage", "[Natomata]", {255,0,0}, "Databases successfully retrieved " ..arg.. " from the database")
end)

RegisterNetEvent("clientGetCharacter")
AddEventHandler("clientGetCharacter", function(charList)
	TriggerEvent("chatMessage", "[Natomata]", {255,0,0}, "Server returned char list from db")
	BootCharSelect(charList)
end)

RegisterNetEvent("clientGiveDroppedItem")
AddEventHandler("clientGiveDroppedItem", function(item, id)
	TriggerEvent("chatMessage", "[Natomata]", {255,0,0}, "Server returned dropped item from db "..item)
	--todo add type of item
	giveDroppedItem(item, id)
	--delete from dropped_items db
end)

RegisterNetEvent("clientGetInventory")
AddEventHandler("clientGetInventory", function(invList)
	TriggerEvent("chatMessage", "[Natomata]", {255,0,0}, "Server returned inv list from db")
	initInventory(invList)
end)


-- RegisterNetEvent('SpawnCharacter')
-- AddEventHandler('SpawnCharacter', function()
-- 	TriggerEvent("chatMessage", "[Natomata]", {255,0,0}, "SpawnCharacter netevent hit")
-- 	--TriggerServerEvent("redemrp:selectCharacter", charId)
-- 	--TriggerEvent("redemrp_identity:SpawnCharacter")
-- end)