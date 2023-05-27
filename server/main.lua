ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('buyPhone4')
AddEventHandler('buyPhone4', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local sourceItem = xPlayer.getInventoryItem('tel')


      if xPlayer.getMoney() >= 250 then 
        if sourceItem.limit ~= -1 and (sourceItem.count) > sourceItem.limit then
            TriggerClientEvent('esx:showNotification', _source, "Vous n\'avez pas assez de place dans votre ~g~inventaire!")
        else 
             xPlayer.removeMoney(250)
            xPlayer.addInventoryItem('tel', 1)
            TriggerClientEvent('esx:showNotification', _source, "Vous venez d\'acheter un ~g~Téléphone~w~ pour ~g~250$")
        end
        else 
            TriggerClientEvent('esx:showNotification', _source, "Vous n\'avez pas assez ~g~d\'argent")

        end
    end)

    RegisterNetEvent('buySim')
    AddEventHandler('buySim', function()
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        local sourceItem = xPlayer.getInventoryItem('sim')
    
    
          if xPlayer.getMoney() >= 45 then 
            if sourceItem.limit ~= -1 and (sourceItem.count) > sourceItem.limit then
                TriggerClientEvent('esx:showNotification', _source, "Vous n\'avez pas assez de place dans votre ~g~inventaire!")
            else 
                 xPlayer.removeMoney(45)
                xPlayer.addInventoryItem('sim', 1)
                TriggerClientEvent('esx:showNotification', _source, "Vous venez d\'acheter une ~g~Carte Sim~w~ pour ~g~45$")
            end
            else 
                TriggerClientEvent('esx:showNotification', _source, "Vous n\'avez pas assez ~g~d\'argent")
    
            end
        end)