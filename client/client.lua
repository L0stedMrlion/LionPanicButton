local PlayerData = {}
local Framework = Config.Framework

if Framework == "esx" then
    RegisterNetEvent('esx:playerLoaded')
    AddEventHandler('esx:playerLoaded', function(xPlayer)
        PlayerData = xPlayer
    end)

    RegisterNetEvent('esx:setJob')
    AddEventHandler('esx:setJob', function(job)
        PlayerData.job = job
    end)

elseif Framework == "qbcore" then
    local QBCore = exports['qb-core']:GetCoreObject()

    CreateThread(function()
        while QBCore == nil do
            Wait(0)
        end

        while QBCore.Functions.GetPlayerData().job == nil do
            Wait(10)
        end

        PlayerData = QBCore.Functions.GetPlayerData()
    end)

    RegisterNetEvent('QBCore:Client:OnJobUpdate')
    AddEventHandler('QBCore:Client:OnJobUpdate', function(jobInfo)
        PlayerData.job = jobInfo
    end)
end

RegisterCommand(Config.PanicCommand, function() 
    print("te")
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
            description = 'Your panic was activated!',
            position = 'top-left',
            icon = 'fa-solid fa-user',
            type = 'error',
        })
        local playerCoords = GetEntityCoords(PlayerPedId())
        TriggerServerEvent('panicButton:syncPosition', playerCoords)
        Wait(1000)  
        ClearPedTasks(ped)
    end
end)

RegisterNetEvent('panicbutton:sendCoords')
AddEventHandler('panicbutton:sendCoords', function()
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

    Wait(1000) 
    ClearPedTasks(ped)

    lib.notify({
        id = 'PanicButton',
        title = 'PANIC BUTTON ACTIVATED',
        description = 'Officer is in danger! Needs immediate help!',
        position = 'top-left',
        icon = 'fa-solid fa-user',
        type = 'error',
        duration = "700"
    })

    SendNUIMessage({
        PayloadType = {"Panic", "ExternalPanic"}, 
        Payload = PlayerId() 
    })

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
    lib.notify({
        title = 'Panic Button',
        description = 'Error just occurred!',
        type = 'error'
    })
end) 
