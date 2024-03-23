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

RegisterCommand('panic', function()
    TaskPlayAnim(ped, "random@arrests", "generic_radio_chatter", 8.0, 2.5, -1, 49, 0, 0, 0, 0)
    SetCurrentPedWeapon(ped, GetHashKey("GENERIC_RADIO_CHATTER"), true)
    local playerCoords = GetEntityCoords(PlayerPedId())
    TriggerServerEvent('panicButton:syncPosition', playerCoords)
    Wait(1000)
    ClearPedTasks(ped)
else
    lib.notify({
        title = 'PANIC BUTTON',
        description = 'You dont have permission for panic button!',
        type = 'error'
    })
end)

local BlipRoute = AddBlipForRadius(pos.x, pos.y, pos.z, 160.0)
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
end