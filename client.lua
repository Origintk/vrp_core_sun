-- Desenvolvido por Sun 
-- Base do código Sighmir

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
--CORESUNserver = Tunnel.getInterface("vrp_core_sun_basico")

local sun_mao = false

Citizen.CreateThread(function()
  while true do
      Citizen.Wait(0)
      if IsControlJustPressed(1, 73) then -- Erguer as maos X
            local player = GetPlayerPed( -1 )
            loadAnimDict( "random@arrests" )
            loadAnimDict( "random@arrests@busted" )
            if not sun_mao then
			  SetEnableHandcuffs(GetPlayerPed(-1), sun_mao)
               vRP._playAnim(true,{{"random@mugging3", "handsup_standing_base", 1}},true)
                sun_mao = true
            else
			vRP._stopAnim(true)
			SetPedStealthMovement(GetPlayerPed(-1),false,"") -- deixa lento
                sun_mao = false

		end
    end
end
end)

Citizen.CreateThread(function()
  while true do
      Citizen.Wait(0)
      if IsControlJustPressed(1, 244) then -- Ajoelhar M
            local player = GetPlayerPed( -1 )
            loadAnimDict( "random@arrests" )
            loadAnimDict( "random@arrests@busted" )
            if not sun_mao then
                TaskPlayAnim( player, "random@arrests@busted", "exit", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
                Wait (3000)
                TaskPlayAnim( player, "random@arrests", "kneeling_arrest_get_up", 8.0, 1.0, -1, 128, 0, 0, 0, 0 )
                sun_mao = true
            else
                sun_mao = false
                TaskPlayAnim( player, "random@arrests", "idle_2_hands_up", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
                Wait (4000)
                TaskPlayAnim( player, "random@arrests", "kneeling_arrest_idle", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
                Wait (500)
                TaskPlayAnim( player, "random@arrests@busted", "enter", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
                Wait (1000)
                TaskPlayAnim( player, "random@arrests@busted", "idle_a", 8.0, 1.0, -1, 9, 0, 0, 0, 0 )
        end
    end
end
end)


Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if sun_mao then
      SetPedStealthMovement(GetPlayerPed(-1),true,"")
      DisableControlAction(0,21,true) -- correr
      DisableControlAction(0,24,true) -- atacar
      DisableControlAction(0,25,true) -- mirar
      DisableControlAction(0,47,true) -- armas
      DisableControlAction(0,58,true) -- armas
      DisableControlAction(0,71,true) -- carro 1
      DisableControlAction(0,72,true) -- carro 2
      DisableControlAction(0,63,true) -- carro 3
      DisableControlAction(0,64,true) -- carro 4
      DisableControlAction(0,263,true) -- faca
      DisableControlAction(0,264,true) -- faca
      DisableControlAction(0,257,true) -- faca
      DisableControlAction(0,140,true) -- faca
      DisableControlAction(0,141,true) -- faca
      DisableControlAction(0,142,true) -- faca
      DisableControlAction(0,143,true) -- faca
    end
  end
end)

function loadAnimDict( dict )
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
      Citizen.Wait(100)
  end
end
