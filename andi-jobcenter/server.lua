local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","Andi-Jobcenter")

RegisterNetEvent("Andi-Jobcenter")
AddEventHandler("Andi-Jobcenter", function(job)
    local user_id = vRP.getUserId({source})
    if Config.Jobs[job] or Config.KriminelJobs[job] ~= nil then
        if vRP.hasGroup({user_id, job}) then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har allerede ' ..job.. ' ?', length = 2500 })
        else
            vRP.addUserGroup({user_id, job})
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Hva så din lille snyder! jobbet var ikke jobcenteret', length = 2500 })
    end
end)