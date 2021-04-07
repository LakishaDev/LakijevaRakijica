-- !! NE DIRAJ NISTA AKO NE ZNAS !! --
ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(1)
    end
end)

RegisterNetEvent('lakijeva-rakija:efektRakije')
AddEventHandler('lakijeva-rakija:efektRakije', function(prop_name)
    prop_name = prop_name or 'prop_vodka_bottle'

    RequestAnimSet("move_m@hobo@a") 
    while not HasAnimSetLoaded("move_m@hobo@a") do
      Citizen.Wait(200)
    end    

    if Config.KoristiMythicNotify then
        exports['mythic_notify']:DoHudText('success', 'Ti si popio rakijicu!')
    else
        ESX.ShowNotification("~g~Popili ste rakijicu!~s~")
    end

	Citizen.CreateThread(function()
        local playerPed = GetPlayerPed(-1)
		local x,y,z = table.unpack(GetEntityCoords(playerPed))
		local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(playerPed, 18905)
        AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
		ESX.Streaming.RequestAnimDict('mp_player_intdrink', function()
			TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)
			Wait(3000)
			ClearPedSecondaryTask(playerPed)
			DeleteObject(prop)
		end)
    end)
    Efekti(playerPed)
end)

function Efekti(igrac)
    Citizen.Wait(3000)
    ClearPedTasksImmediately(igrac)
    SetTimecycleModifier("spectator3")
    SetPedMotionBlur(igrac, true)
    SetPedMovementClipset(igrac, "move_m@hobo@a", true)
    SetPedIsDrunk(igrac, true)
    AnimpostfxPlay("HeistCelebPass", 10000001, true)
    ShakeGameplayCam("DRUNK_SHAKE", Config.JacinaEfekta)
    SetEntityHealth(igrac, 200)
    SetPedArmour(PlayerPedId(), 200)
    Citizen.Wait(Config.TrajanjeEfekta * 1000)
    SetPedMoveRateOverride(PlayerId(),1.0)
    SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
    SetPedIsDrunk(igrac, false)		
    SetPedMotionBlur(playerPed, false)
    ResetPedMovementClipset(igrac)
    AnimpostfxStopAll()
    ShakeGameplayCam("DRUNK_SHAKE", 0.0)
    SetTimecycleModifierStrength(0.0)
end