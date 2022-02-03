if Config.KoristiESX then
	local ESX = nil
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	ESX.RegisterUsableItem('rakijica', function(source)
	    local src = source
		local xPlayer = ESX.GetPlayerFromId(src)
		TriggerClientEvent('lakijeva-rakija:efektRakije', src)
	end)
end
