local Keys = {
	["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57
}

ESX = nil 

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)
    
    AddEventHandler('esx:onPlayerDeath', function()
	isDead = true
	_menuPool:CloseAllMenus()
	NativeUI.CloseAll()
end)



_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("", "Vendeur de téléphone")
_menuPool:Add(mainMenu)

function AddShopsMenu(menu)
    local telephonie = _menuPool:AddSubMenu(menu, "Téléphonie","Téléphone disponible dans le magasin")
    
    local accessoires = _menuPool:AddSubMenu(menu, "Accessoires","Accessoires disponible dans le magasin")



    local phone4 = NativeUI.CreateItem("Samsung Galaxy s8", "Acheter un Samsung Galaxy s8 pour ~g~250 $")
    telephonie.SubMenu:AddItem(phone4)
    phone4:RightLabel(" →")

    local sim = NativeUI.CreateItem("Carte Sim", "Acheter une Carte Sim pour ~g~45 $")
    accessoires.SubMenu:AddItem(sim)
    sim:RightLabel(" →")



        telephonie.SubMenu.OnItemSelect = function(menu, item)
        if item == phone then
            TriggerServerEvent('buyPhone')
            Citizen.Wait(1)
        elseif item == phone2 then
            TriggerServerEvent('buyPhone2')
            Citizen.Wait(1)
        elseif item == phone3 then
            TriggerServerEvent('buyPhone3')
            Citizen.Wait(1)
        elseif item == phone4 then
            TriggerServerEvent('buyPhone4')
            Citizen.Wait(1)
        end
     end
        accessoires.SubMenu.OnItemSelect = function(menu, item)
        if item == sim then
            TriggerServerEvent('buySim')
            Citizen.Wait(1)


        end
     end

end









AddShopsMenu(mainMenu)
_menuPool:RefreshIndex()


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
        _menuPool:MouseEdgeEnabled (false);

        local playerCoords = GetEntityCoords(PlayerPedId())

        for k, v in pairs(Config.Shops_Config.Positions) do
            local distance = GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true)

            if distance < 10.0 then
                actualZone = v

                zoneDistance = GetDistanceBetweenCoords(playerCoords, actualZone.x, actualZone.y, actualZone.z, true)

                DrawMarker(Config.MarkerType, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, nil, nil, false)
            end
            
            if distance <= 1.5 then
                ESX.ShowHelpNotification('Appuyez sur ~INPUT_TALK~ pour parlez avec le ~r~vendeur')

                if IsControlJustPressed(1, 51) then
                    mainMenu:Visible(not mainMenu:Visible())
                end
            end

            if zoneDistance ~= nil then
                if zoneDistance > 1.5 then
                    _menuPool:CloseAllMenus()
                end
            end
        end
    end
end)



Citizen.CreateThread(function()
    for k, v in pairs(Config.Shops_Config.Positions) do
        local blip = AddBlipForCoord(v.x, v.y, v.z)

        SetBlipSprite(blip, Config.Blip)
        SetBlipScale (blip, Config.BlipTaille)
        SetBlipColour(blip, Config.BlipColor)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("DigitalDen")
        EndTextCommandSetBlipName(blip)
    end
end)