------------------ OVDE NE PIPAJ NISTA --------------------------
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('rakijica', function(source)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	TriggerClientEvent('lakijeva-rakija:efektRakije', _source)
end)