if Config.KoristiESX then
	local ESX = nil
	CreateThread(function()
		while ESX == nil do 
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
			Wait(250) 
		end
	end)
end

RegisterNetEvent('lakijeva-rakija:efektRakije')
AddEventHandler('lakijeva-rakija:efektRakije', function()
	local prop_name = 'prop_vodka_bottle'

	RequestAnimSet("move_m@hobo@a")
	while not HasAnimSetLoaded("move_m@hobo@a") do 
		print('AHH') 
		Wait(200)
	end

	CreateThread(function()
		local playerPed = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(playerPed))
		local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(playerPed, 18905)
		AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
		if Config.KoristiESX then
			ESX.Streaming.RequestAnimDict('mp_player_intdrink', function()
				TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)
				Wait(3000)
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
				if Config.KoristiMythicNotify then
					exports['mythic_notify']:DoHudText('success', 'Ti si popio rakijicu!')
				else
					ESX.ShowNotification("~g~Popili ste rakijicu!XD~s~")
				end
			end)
		end
	end)

	Efekti(playerPed)
end)

function Efekti(igrac)
	Wait(3000)
	ClearPedTasksImmediately(igrac)
	SetTimecycleModifier("spectator3")
	SetPedMotionBlur(igrac, true)
	SetPedMovementClipset(igrac, "move_m@hobo@a", true)
	SetPedIsDrunk(igrac, true)
	AnimpostfxPlay("HeistCelebPass", 10000001, true)
	ShakeGameplayCam("DRUNK_SHAKE", Config.JacinaEfekta)
	SetEntityHealth(igrac, 200)
	SetPedArmour(PlayerPedId(), 200)
	Wait(Config.TrajanjeEfekta * 1000)
	SetPedMoveRateOverride(PlayerId(),1.0)
	SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
	SetPedIsDrunk(igrac, false)		
	SetPedMotionBlur(playerPed, false)
	ResetPedMovementClipset(igrac)
	AnimpostfxStopAll()
	ShakeGameplayCam("DRUNK_SHAKE", 0.0)
	SetTimecycleModifierStrength(0.0)
end
