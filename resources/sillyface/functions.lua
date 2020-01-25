function print(data)
	TriggerEvent('chat:addMessage', { args = { data }})
end

function hideFOW(bool)
	SetMinimapHideFow(bool)
end

function godmode(bool)
	TriggerEvent('chat:addMessage', { args = { 'Toggle godmode ' .. tostring(bool) .. ''}})
	local lped = PlayerPedId()
	SetEntityInvincible(lped, bool)
end

function GiveWeapon(weapon)
	local lped = PlayerPedId()
	--Citizen.InvokeNative(0xADF692B254977C0C, lped, weapon, true, 120, true, true)
	--Citizen.InvokeNative(0x5E3BDDBCB83F3D84, lped, weapon, 10, true, true, GetWeapontypeGroup(weapon), true, 1056964608, 1065353216, 752097756, true, 0, 0)
	
	if Citizen.InvokeNative(0x937C71165CF334B3, GetHashKey(weapon)) then
		TriggerEvent('chat:addMessage', {
	        args = { 'Weapon Is Valid!!!'}
	    })
	end

	-- local t, t2 = GetCurrentPedWeapon(lped, false, 0, true)
	-- local s, s2 = GetCurrentPedWeapon(lped, false, 0, false)
    -- TriggerEvent('chat:addMessage', {
    --     args = { 't' .. t .. ' t2 ' .. t2 .. 's' .. s .. ' s2 ' .. s2 .. ''}
    -- })

	Citizen.InvokeNative(0x5E3BDDBCB83F3D84, lped, GetHashKey(weapon), 50, true, true, GetWeapontypeGroup(weapon), true, 1056964608, 1065353216, 752097756, true, 0)
	Citizen.InvokeNative(0xADF692B254977C0C, lped, GetHashKey(weapon), true)
    TriggerEvent('chat:addMessage', {
        args = { 'Player Id ' .. lped .. ' attempting to give weap hash ' .. weapon .. ''}
    })
end

function ShapeShift(a)
	TriggerEvent('chat:addMessage', { args = { 'ShapeShifting into ' .. a .. ''}})
	local animal = GetHashKey(a)
	local playerPed = PlayerPedId() -- get the local player ped
	--SetPlayerModel(playerPed, animal, true)
	Citizen.InvokeNative(0xED40380076A31506, 0, animal, true)
end

function SpawnAnimal(a)
    -- get the player's position
    local animal = GetHashKey(a)
  	TriggerEvent('chat:addMessage', { args = { 'animal hash before loaded ' .. animal .. ''}})
	Citizen.InvokeNative(0xFA28FE3A6246FC30, animal)
	while not Citizen.InvokeNative(0x1283B8B89DD5D1B6, animal) do
		Citizen.InvokeNative(0xFA28FE3A6246FC30, animal)
		Citizen.Wait(0)
	end
	TriggerEvent('chat:addMessage', { args = { 'animal hash after loaded ' .. animal .. ''}})
    local playerPed = PlayerPedId() -- get the local player ped
    local pos = GetEntityCoords(playerPed) -- get the position of the local player ped

    local object = CreatePed(animal, pos.x+2, pos.y, pos.z, 0.0, true, true, true, true)
    -- Set ped to visible
    Citizen.InvokeNative(0x283978A15512B2FE, object, true)
end

function SpawnVehicle(v)
	-- local horseHash = GetHashKey(str)
	local vehicle = GetHashKey(v)
  	TriggerEvent('chat:addMessage', { args = { 'vehicle hash before loaded ' .. vehicle .. ''}})
	Citizen.InvokeNative(0xFA28FE3A6246FC30, vehicle)
	while not Citizen.InvokeNative(0x1283B8B89DD5D1B6, vehicle) do
		Citizen.InvokeNative(0xFA28FE3A6246FC30, vehicle)
		Citizen.Wait(0)
	end
	TriggerEvent('chat:addMessage', { args = { 'vehicle hash after loaded ' .. vehicle .. ''}})
    local playerPed = PlayerPedId() -- get the local player ped
    local pos = GetEntityCoords(playerPed) -- get the position of the local player ped
    TriggerEvent('chat:addMessage', { args = { 'player pos x ' .. pos.x .. ' pos y ' .. pos.y .. ' pos z ' .. pos.z .. ''}})
    local spawn_vehicle = CreateVehicle(vehicle, pos.x, pos.y, pos.z, 0.0, true, true, true, true)
    --Citizen.InvokeNative(0x283978A15512B2FE, spawn_vehicle, true)
end

function DropObject(o, name)
    local playerPed = PlayerPedId() -- get the local player ped
    local pos = GetEntityCoords(playerPed) -- get the position of the local player ped
	local objHash = GetHashKey(o)
	Citizen.InvokeNative(0xFA28FE3A6246FC30, objHash)
	while not Citizen.InvokeNative(0x1283B8B89DD5D1B6, objHash) do
		Citizen.InvokeNative(0xFA28FE3A6246FC30, objHash)
		Citizen.Wait(0)
	end
	TriggerEvent('chat:addMessage', { args = { 'object after before loaded ' .. objHash .. ''}})
	local obj = CreateObject(objHash, pos.x, pos.y+1, pos.z, true, true, true)
	PlaceObjectOnGroundProperly(obj)
	-- hit db
	TriggerServerEvent("droppedItem", obj, name)

	--local network = NetworkGetNetworkIdFromEntity(object)
	--return network
end

-- helper functions


function Dismount()
	Citizen.InvokeNative(0x48E92D3DDE23C23A, PlayerPedId(), true)
end

-- not working
function Illuminate()
    local playerPed = PlayerPedId() -- get the local player ped
    local pos = GetEntityCoords(playerPed) -- get the position of the local player ped
    DrawRect(0.05, 0.55, 0.0075, 0.015, 200, 255, 200, 255)
    DrawRect(0.05, 0.55, 0.005, 0.01, 0, 55, 0, 255)
	DrawLightWithRange(pos.x, pos.y, pos.z, 255, 255, 255, 50.0, 5.0)
	print("illuminating...")
end


-- Fire Ball functions
function RotToDir(rot)
	TriggerEvent('chat:addMessage', { args = { 'rot ' .. rot.x .. ''}})
    local z = rot.z
    local retz = z * 0.0174532924
    local x = rot.x
    local retx = x * 0.0174532924
    local absx = math.abs(math.cos(retx))
    --TriggerEvent('chat:addMessage', { args = { 'absx ' .. absx .. ''}})
    return vector3(math.sin(retz) * absx, math.cos(retz) * absx, math.sin(retx))
end

function NCGetCamRotation()
	local gameplayrot = GetGameplayCamRot(0)
    return gameplayrot
end

function FireBall()
	print("testing")
	local playerPed = PlayerPedId() -- get the local player ped
	local pos = GetEntityCoords(playerPed) -- get the position of the local player ped
    local EXPCasting = false
    local EXPNumber = 1
    local MaxEXP = 100

    SetEntityInvincible(playerPed, true)
    local Shockspace = vector3(RotToDir(NCGetCamRotation()).x * 3, RotToDir(NCGetCamRotation()).y * 3, RotToDir(NCGetCamRotation()).z * 3);
 --    if EXPNumber < MaxEXP or EXPNumber == MaxEXP then
 --    	AddExplosion(pos.x + (EXPNumber*Shockspace.x), pos.y + (EXPNumber*Shockspace.y), pos.z + (EXPNumber*Shockspace.z), 2, 2.0, true, false, 0)
	-- 	Citizen.Wait(100)
	-- 	EXPNumber = EXPNumber + 1
 --    else
 --    	AddExplosion(pos.x + (MaxEXP*Shockspace.x), pos.y + (MaxEXP*Shockspace.y), pos.z + (MaxEXP*Shockspace.z), 2, 2.0, true, false, 0)
	-- 	Citizen.Wait(100)
	-- end
	AddExplosion(pos.x, pos.y, pos.z, 3, 2.0, true, false, 0)
	--AddExplosion(pos.x + Shockspace.x, pos.y + Shockspace.y, pos.z + Shockspace.z, 2, 2.0, true, false, 0)
	Citizen.Wait(100)
	SetEntityInvincible(playerPed, false)
	-- local rot = vector3(1.0, 2.0, 3.0)
	-- RotToDir(rot)
end

-- inventory functions
-- Open Gui and Focus NUI
function OpenGui()
  	SetNuiFocus(true, true)
  	SendNUIMessage({openInv = true, invItems = false})
  	TriggerEvent('chat:addMessage', { args = { 'opening inventory'}})
end

-- Close Gui and disable NUI
function CloseInv()
  	SetNuiFocus(false)
  	SendNUIMessage({openInv = false, invItems = false})
  	TriggerEvent('chat:addMessage', { args = { 'closing inventory'}})
end

function CloseChar()
  	SetNuiFocus(false)
  	SendNUIMessage({openChar = false, invItems = false})
  	TriggerEvent('chat:addMessage', { args = { 'closing character'}})
end

-- initialize inventory
function initInventory(inv)
	SendNUIMessage({invItems = inv})
end

-- character creation stuff
local firstSpawn = false
function BootCreator()
	SetNuiFocus(true, true)
	print("opening character ui")
	SendNUIMessage({openChar = true, invItems = false})
end
function BootCharSelect(chars)
	SetNuiFocus(true, true)
	print("opening character ui")
	SendNUIMessage({type = 1, list = chars, invItems = false})
end
-- Dropped item
function giveDroppedItem(item, id)
	--todo create log of free inventory slots
  	SetNuiFocus(true, true)
  	SendNUIMessage({openInv = true, giveItem = item})
  	--delete from dropped item db
  	TriggerServerEvent('removeDroppedItem', id)
	--call back to save item in database

	--GiveWeapon(item)
end


-- NUI Callback Methods
RegisterNUICallback('closeInv', function(data, cb)
  CloseInv()
  TriggerEvent('chat:addMessage', { args = { 'closing inventory callback'}})
  cb('ok')
end)

RegisterNUICallback('closeChar', function(data, cb)
  CloseChar()
  TriggerEvent('chat:addMessage', { args = { 'closing character screen callback'}})
  cb('ok')
end)


RegisterNUICallback('giveWeapon', function(data, cb)
  GiveWeapon(data.weapon)
  cb('ok')
end)

RegisterNUICallback('updatePickupSlot', function(data, cb)
	TriggerEvent('chat:addMessage', { args = { 'picked up item, updating db slot: '.. data.slot}})
	TriggerServerEvent("updateSlot", data.slot, data.item)
end)

RegisterNUICallback('dropItem', function(data, cb)
	TriggerEvent('chat:addMessage', { args = { 'item from UI '.. data.item}})
	-- SetEntityAsMissionEntity 
	-- this crashes client if not in thread
	Citizen.CreateThread(function()
		DropObject(data.item, data.item)
	end)
	TriggerServerEvent('removeFromSlot', data.slot)
	cb('ok')
end)


RegisterNUICallback('dropWeapon', function(data, cb)
	-- if item is a weapon RemoveWeaponFromPed
	local playerPed = PlayerPedId()
	TriggerEvent('chat:addMessage', { args = { 'weapon from UI '.. data.slot}})
	-- SetEntityAsMissionEntity 
	--SetPedDropsInventoryWeapon(playerPed, data.item, 0, 2.0, 0, -1)
	RemoveWeaponFromPed(playerPed, GetHashKey(data.item))
	Citizen.CreateThread(function()
		DropObject("P_BOXLRGMEAT01X", data.item)
		-- SetTextFont(0)
		-- SetTextProportional(1)
		-- SetTextScale(0.0, 0.45)
		-- SetTextDropshadow(1, 0, 0, 0, 255)
		-- SetTextEdge(1, 0, 0, 0, 255)

		-- SetTextDropShadow()
		-- SetTextOutline()
		-- SetTextEntry("STRING")
		-- AddTextComponentString(text)
		-- DrawText(0.174, 0.855)
	end)
	TriggerServerEvent('removeFromSlot', data.slot)
	-- Citizen.CreateThread(function()
	-- 	DropObject(data.item)
	-- end)
	-- cb('ok')
end)

-- create characte NUIs
RegisterNUICallback('createCharacter2', function(id, cb)
local ped = PlayerPedId()
FreezeEntityPosition(ped, false)
local charId = tonumber(id)
        --Citizen.Wait(0)
        --local spawned = Citizen.InvokeNative(0xB8DFD30D6973E135 --[[NetworkIsPlayerActive]], PlayerPedId(), Citizen.ResultAsInteger())
        --if spawned then
            --printClient("Player spawned!")
            TriggerEvent('chat:addMessage', { args = { 'player spawned!!!'}})
            TriggerServerEvent("xrp:firstSpawn", charId)
            firstSpawn = true
        --end
end)

RegisterNUICallback('newCharacter', function(data, cb)
	SetNuiFocus(false, false)
	local ped = PlayerPedId()
	local model = GetEntityModel(ped)
	local function tchelper(first, rest)
		return first:upper()..rest:lower()
	end
	local fname = data.name:gsub("(%a)([%w_']*)", tchelper)
	local lname = data.lname:gsub("(%a)([%w_']*)", tchelper)
	TriggerEvent('chat:addMessage', { args = { 'first name: '..fname..' last name: '..lname}})
	TriggerServerEvent("createCharacter", fname, lname, model)
	--new = 1
	TriggerEvent("SpawnCharacter")
	--TriggerEvent("redemrp_identity:SpawnCharacter")
	--new = 0

	-- doesnt exist
	--TriggerEvent("redemrp_skin:openCreator")
    cb('ok')
end)

RegisterNUICallback('selectCharacter', function(id, cb)
	-- this needs to get the inventory from db and pass it throughNUI
	SetNuiFocus(false, false)
	local ped = PlayerPedId()
	FreezeEntityPosition(ped, false)
	local charId = tonumber(id)

	exports.spawnmanager:setAutoSpawn(true)
	exports.spawnmanager:forceRespawn()

	-- get inventory from db
	-- give inventory items to ui
	local item = {item = "054.png"}
	local itemList = {}
	itemList[1] = item
	-- charList[1] = char
	initInventory(itemList)
	print("Player spawned!")
	--TriggerServerEvent("redemrp:selectCharacter", charId)
	--TriggerEvent("redemrp_identity:SpawnCharacter")
end)