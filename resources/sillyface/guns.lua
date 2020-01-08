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
			SpawnAnimal("A_C_Horse_Gang_John")
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

-- give weapon
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

-- fireball
Citizen.CreateThread(function()
	local f_key = keys["F"]
	while true do
		Citizen.Wait(0)
		if IsControlJustReleased(0, f_key) then
			FireBall()
		end
	end
end)


-- illuminate
-- Citizen.CreateThread(function()
-- 	local f_key = keys["F"]
-- 	while true do
-- 		Citizen.Wait(0)
-- 		if IsControlJustReleased(0, f_key) then
-- 			Illuminate()
-- 		end
-- 	end
-- end)

-- inventory
-- fireball
Citizen.CreateThread(function()
	local isOpen = false
	local tab_key = keys["TAB"]
	while true do
		Citizen.Wait(0)
		if IsControlJustReleased(0, tab_key) then
			if not isOpen then
				isOpen = true
				OpenGui()
			else
				isOpen = false
				CloseGui()
			end
		end
	end
end)



RegisterCommand("gunomata", function()
	gunomata("spawning a bear...")
end, false)

function gunomata(data)
	-- spawnAnimal("WEAPON_RIFLE_SPRINGFIELD")
	GiveWeapon("WEAPON_PISTOL_M1899")
	--SpawnHorse("Horse")
	-- TriggerEvent("chatMessage", "[Natomata]", {255,0,0}, data)
end
