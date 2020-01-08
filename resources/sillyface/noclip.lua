local noclip = false
local noclip_speed = 5.0

function admin_no_clip()
  noclip = not noclip
  local ped = PlayerPedId()
  if noclip then -- active
    SetEntityInvincible(ped, true)
    SetEntityVisible(ped, false, false)
		
  else -- deactive
  	SetEntityVisible(ped, true, false)
  	Citizen.Wait(10000)
    SetEntityInvincible(ped, false)
	
  end
end

function isNoclip()
  return noclip
end



function getPosition()
  local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
  return x,y,z
end

function getCamDirection()
  local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(PlayerPedId())
  local pitch = GetGameplayCamRelativePitch()

  local x = -math.sin(heading*math.pi/180.0)
  local y = math.cos(heading*math.pi/180.0)
  local z = math.sin(pitch*math.pi/180.0)

  local len = math.sqrt(x*x+y*y+z*z)
  if len ~= 0 then
    x = x/len
    y = y/len
    z = z/len
  end

  return x,y,z
end

Citizen.CreateThread(function()
  while true do
    Wait(0)
	
	if IsControlJustPressed(0, keys['N']) then
	
	admin_no_clip()
	end
    if noclip then
      local ped = PlayerPedId()
      local x,y,z = getPosition()
      local dx,dy,dz = getCamDirection()
      local speed = noclip_speed

      -- reset du velocity
      SetEntityVelocity(ped, 0.0001, 0.0001, 0.0001)

      -- aller vers le haut
      if IsControlPressed(0, keys['W']) then -- MOVE UP
        x = x+speed*dx
        y = y+speed*dy
        z = z+speed*dz
      end

      -- aller vers le bas
      if IsControlPressed(0, keys['S']) then -- MOVE DOWN
        x = x-speed*dx
        y = y-speed*dy
        z = z-speed*dz
      end

      SetEntityCoordsNoOffset(ped,x,y,z,true,true,true)
    end
  end
end)