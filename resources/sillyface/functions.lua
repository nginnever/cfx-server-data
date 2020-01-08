function print(data)
	TriggerEvent('chat:addMessage', { args = { data }})
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

    local object = CreatePed(animal, pos.x, pos.y, pos.z, 0.0, true, true, true, true)
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
    --return Function.Call<Vector3>(Hash.GET_GAMEPLAY_CAM_ROT, 0)
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
	AddExplosion(pos.x + Shockspace.x, pos.y + Shockspace.y, pos.z + Shockspace.z, 2, 2.0, true, false, 0)
	Citizen.Wait(100)
	SetEntityInvincible(playerPed, false)
	-- local rot = vector3(1.0, 2.0, 3.0)
	-- RotToDir(rot)
end


-- If GUI setting turned on, listen for INPUT_PICKUP keypress
local enableInventoryGui = true

if enableInventoryGui then
  Citizen.CreateThread(function()
    local i_key = keys["I"]
    while true do
      Citizen.Wait(0)
      if IsControlJustReleased(0, i_key)  then -- IF INPUT_PICKUP Is pressed
        TriggerEvent('chatMessage', "", {255, 0, 0}, "tab key pressed");
        OpenGui()
      end
    end
  end)
end

-- inventory functions
-- Open Gui and Focus NUI
function OpenGui()
  SetNuiFocus(true, true)
  SendNUIMessage({openInv = true})
  TriggerEvent('chat:addMessage', { args = { 'opening inventory'}})
end

-- Close Gui and disable NUI
function CloseGui()
  SetNuiFocus(false)
  SendNUIMessage({openInv = false})
  TriggerEvent('chat:addMessage', { args = { 'closing inventory'}})
end

-- NUI Callback Methods
RegisterNUICallback('close', function(data, cb)
  CloseGui()
  TriggerEvent('chat:addMessage', { args = { 'closing inventory callback'}})
  cb('ok')
end)