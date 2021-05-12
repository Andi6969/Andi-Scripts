HT = nil

Citizen.CreateThread(function()
    while HT == nil do
        TriggerEvent('HT_base:getBaseObjects', function(obj) HT = obj end)
        Citizen.Wait(0)
    end
end)




Citizen.CreateThread(function()
    while true do
    Citizen.Wait(1)
        for k,v in pairs(Config.Jobcenter) do
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v[1], v[2],v[3], true) < 2 then
                DrawText3Ds(v[1], v[2],v[3], "~b~E~s~ | Jobcenter")
                if IsControlJustPressed(0, 38) then
                    LovligMenu()
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(1)
        for k,v in pairs(Config.Kriminel) do
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v[1], v[2],v[3], true) < 2 then
                DrawText3Ds(v[1], v[2],v[3], "~b~E~s~ | Kriminelt Jobcenter")
                if IsControlJustPressed(0, 38) then
                    KriminelMenu()
                end
            end
        end
    end
end)

RegisterCommand('testjob', function()
    TriggerServerEvent("Andi-Jobcenter", "thanighthawk")
end)



function LovligMenu()
    local elements = {}
    for k,v in pairs(Config.Jobs) do
     table.insert(elements,{label = k, value = v.givejob})
     end 
     table.insert(elements,{label = "Forlad Jobcenteret", value = "close"})
     HT.UI.Menu.Open('default', GetCurrentResourceName(), "TNW-Jobcenter",
         {
             title    = "Jobcenter",
             align    = "Center",
             elements = elements
         }, function(data, menu)
             for k,v in pairs(Config.Jobs) do
               if data.current.value == v.givejob then
                TriggerServerEvent("Andi-Jobcenter", k,v.givejob)
                menu.close()
               elseif data.current.value == "close" then
                 menu.close()
               end
            end
        end, function(data, menu) 
           menu.close()
        end, function(data, menu)
    end)
end

function KriminelMenu()
    local elements = {}
    for k,v in pairs(Config.KriminelJobs) do
     table.insert(elements,{label = k, value = v.givejob})
     end 
     table.insert(elements,{label = "Forlad", value = "close"})
     HT.UI.Menu.Open('default', GetCurrentResourceName(), "TNW-JobcenterKriminel",
         {
             title    = "Kriminel",
             align    = "Center",
             elements = elements
         }, function(data, menu)
             for k,v in pairs(Config.KriminelJobs) do
               if data.current.value == v.givejob then
                TriggerServerEvent("Andi-Jobcenter", k,v.givejob)
                menu.close()
               elseif data.current.value == "close" then
                 menu.close()
               end
            end
        end, function(data, menu) 
           menu.close()
        end, function(data, menu)
    end)
end

  function DrawText3Ds(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextDropshadow(0, 0, 0, 155)
    SetTextEdge(1, 0, 0, 0, 250)
    SetTextDropShadow()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+factor, 0.03, 41, 41, 41, 68)
end