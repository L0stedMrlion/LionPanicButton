local PlayerData = {}
local Framework = Config.Framework

Framework = "esx"
    RegisterNetEvent('esx:playerLoaded')
    AddEventHandler('esx:playerLoaded', function(xPlayer)
        PlayerData = xPlayer
    end)

    RegisterNetEvent('esx:setJob')
    AddEventHandler('esx:setJob', function(job)
        PlayerData.job = job
    end)

RegisterCommand(Config.PanicCommand, function() 
    if Config.AllowCommand then
        local ped = PlayerPedId() 
        RequestAnimDict("random@arrests")    
        while (not HasAnimDictLoaded("random@arrests")) do
            Wait(100)
        end  
        TaskPlayAnim(ped, "random@arrests", "generic_radio_chatter", 8.0, 2.5, -1, 49, 0, 0, 0, 0)
        SetCurrentPedWeapon(ped, GetHashKey("GENERIC_RADIO_CHATTER"), true)
        lib.notify({
            id = 'PanicButton',
            title = 'YOUR PANIC BUTTON ACTIVATED',
            description = 'Your panic button has been activated!',
            position = 'top',
            icon = 'fa-solid fa-user',
            type = 'error',
        })
        local playerCoords = GetEntityCoords(PlayerPedId())
        TriggerServerEvent('panicButton:syncPosition', playerCoords)
        Wait(1000)  
        ClearPedTasks(ped)
    else
        ShowNotification('~r~' ..Config.CommandNotAllowed, 5000)
    end
end)

RegisterNetEvent('panicbutton:sendCoords')
AddEventHandler('panicbutton:sendCoords', function()
    print("hee")
    local ped = PlayerPedId()
    RequestAnimDict("random@arrests")
    while (not HasAnimDictLoaded("random@arrests")) do
        Wait(100)
    end
    TaskPlayAnim(ped, "random@arrests", "generic_radio_chatter", 8.0, 2.5, -1, 49, 0, 0, 0, 0)
    SetCurrentPedWeapon(ped, GetHashKey("GENERIC_RADIO_CHATTER"), true)
    local playerCoords = GetEntityCoords(PlayerPedId())
    TriggerServerEvent('panicButton:syncPosition', playerCoords)
    Wait(1000) 
    ClearPedTasks(ped) 
end)

RegisterNetEvent('panicButton:alarm')
AddEventHandler('panicButton:alarm', function(playername, pos)
    if Config.ShowNotification then 
        notification(Config.NotificationText)
    end

    Wait(1000) 
    ClearPedTasks(ped)

    lib.notify({
        id = 'PanicButton',
        title = 'PANIC BUTTON ACTIVATED',
        description = 'Officer is in danger! Needs immediate help!',
        position = 'top',
        icon = 'fa-solid fa-user',
        type = 'error',
        duration = "700"
    })

    SendNUIMessage({
        PayloadType = {"Panic", "ExternalPanic"}, 
        Payload = PlayerId() 
    })

    -- Blip

    local Blip = AddBlipForRadius(pos.x, pos.y, pos.z, 160.0)
    SetBlipRoute(Blip, true)
    CreateThread(function()
        while Blip do 
            SetBlipRouteColour(Blip, 1)
            Wait(150) 
            SetBlipRouteColour(Blip, 6)
            Wait(150)
            SetBlipRouteColour(Blip, 35)
            Wait(150)
            SetBlipRouteColour(Blip, 6)
        end
    end)
    SetBlipAlpha(Blip, 60)
    SetBlipColour(Blip, 1)
    SetBlipFlashes(Blip, true)
    SetBlipFlashInterval(Blip, 200)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.Blipname)
    EndTextCommandSetBlipName(Blip)

    Wait(Config.BlipTime * 1000) 

    RemoveBlip(Blip)
    Blip = nil
end)

RegisterNetEvent('panicButton:error')
AddEventHandler('panicButton:error', function()
    ShowNotification(Config.NotAllowedNotification)
end) 
