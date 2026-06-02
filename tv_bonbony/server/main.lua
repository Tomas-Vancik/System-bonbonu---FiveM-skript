
--[[
████████╗░█████╗░███╗░░░███╗░█████╗░░██████╗  ██╗░░░██╗░█████╗░███╗░░██╗░█████╗░██╗██╗░░██╗
╚══██╔══╝██╔══██╗████╗░████║██╔══██╗██╔════╝  ██║░░░██║██╔══██╗████╗░██║██╔══██╗██║██║░██╔╝
░░░██║░░░██║░░██║██╔████╔██║███████║╚█████╗░  ╚██╗░██╔╝███████║██╔██╗██║██║░░╚═╝██║█████═╝░
░░░██║░░░██║░░██║██║╚██╔╝██║██╔══██║░╚═══██╗  ░╚████╔╝░██╔══██║██║╚████║██║░░██╗██║██╔═██╗░
░░░██║░░░╚█████╔╝██║░╚═╝░██║██║░░██║██████╔╝  ░░╚██╔╝░░██║░░██║██║░╚███║╚█████╔╝██║██║░╚██╗
░░░╚═╝░░░░╚════╝░╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═════╝░  ░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚══╝░╚════╝░╚═╝╚═╝░░╚═╝

██████╗░░░░██████╗░
╚════██╗░░░██╔══██╗
░░███╔═╝░░░██████╦╝
██╔══╝░░░░░██╔══██╗
███████╗██╗██████╦╝
╚══════╝╚═╝╚═════╝░
]]--

ESX = exports["es_extended"]:getSharedObject()

ESX.RegisterUsableItem('usb_zele', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local tablet
    local bonbonos = 'zele'
    if xPlayer.getInventoryItem('hack_tablet').count > 0 then
        tablet = true
    else
        tablet = false
    end
    --print("Tablet server: "..tostring(tablet).."\nDrogos Server: "..bonbonos)
    TriggerClientEvent('tv_bonbony:hack_usb', source, tablet, bonbonos)
end)

ESX.RegisterUsableItem('usb_lipo', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local tablet = false
    local bonbonos = 'lipo'
    if xPlayer.getInventoryItem('hack_tablet').count > 0 then
        tablet = true
    else
        tablet = false
    end
    TriggerClientEvent('tv_bonbony:hack_usb', source, tablet, bonbonos)
end)

ESX.RegisterUsableItem('usb_lentilky', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local tablet = false
    local bonbonos = 'lentilky'
    if xPlayer.getInventoryItem('hack_tablet').count > 0 then
        tablet = true
    else
        tablet = false
    end
    TriggerClientEvent('tv_bonbony:hack_usb', source, tablet, bonbonos)
end)

RegisterNetEvent("tv_bonbony:konec")
AddEventHandler("tv_bonbony:konec", function(bonbon)
    local xPlayer = ESX.GetPlayerFromId(source)
    --print("Droga konec Server: "..bonbon)
    if bonbon == 'zele' then
        local nahoda = math.random(Config.zeleMin,Config.zeleMax)
        if xPlayer.canCarryItem('zele_1kg', nahoda) then
            xPlayer.addInventoryItem('zele_1kg', nahoda)
        end

        local zele = {
            {		
                ["color"] = "65280",
                ["title"] = "Player Delivered Drugs",
                ["description"] = "`IC Name:` " ..xPlayer.getName().."\n`Player:` " ..GetPlayerName(source).."\n`Identifier:` " ..xPlayer.getIdentifier().."\n`Quantity (Kg):` " ..nahoda.."",
                ["footer"] = {
                ["text"] = os.date('%H:%M - %d. %m. %Y', os.time()),
                },
            }
        }
        PerformHttpRequest(Config.zeleWebHook, function(err, text, headers) end, 'POST',json.encode({username = Config.zeleWebHookName, embeds = zele}), { ['Content-Type'] ='application/json' })
    elseif bonbon == 'lipo' then
        local nahoda = math.random(Config.lipoMin,Config.lipoMax)
        if xPlayer.canCarryItem('lipo_1kg', nahoda) then
            xPlayer.addInventoryItem('lipo_1kg', nahoda)
        end

        local lipo = {
            {		
                ["color"] = "57855",
                ["title"] = "Player Delivered Drugs",
                ["description"] = "`IC Name:` " ..xPlayer.getName().."\n`Player:` " ..GetPlayerName(source).."\n`Identifier:` " ..xPlayer.getIdentifier().."\n`Quantity (Kg):` " ..nahoda.."",
                ["footer"] = {
                ["text"] = os.date('%H:%M - %d. %m. %Y', os.time()),
                },
            }
        }
        PerformHttpRequest(Config.lipoWebHook, function(err, text, headers) end, 'POST',json.encode({username = Config.lipoWebHookName, embeds = lipo}), { ['Content-Type'] ='application/json' })
    elseif bonbon == 'lentilky' then
        local nahoda = math.random(Config.lentilkyMin,Config.lentilkyMax)
        if xPlayer.canCarryItem('lentilky_1kg', nahoda) then
            xPlayer.addInventoryItem('lentilky_1kg', nahoda)
        end

        local lentilky = {
            {		
                ["color"] = "16777215",
                ["title"] = "Player Delivered Drugs",
                ["description"] = "`IC Name:` " ..xPlayer.getName().."\n`Player:` " ..GetPlayerName(source).."\n`Identifier:` " ..xPlayer.getIdentifier().."\n`Quantity (Kg):` " ..nahoda.."",
                ["footer"] = {
                ["text"] = os.date('%H:%M - %d. %m. %Y', os.time()),
                },
            }
        }
        PerformHttpRequest(Config.lentilkyWebHook, function(err, text, headers) end, 'POST',json.encode({username = Config.lentilkyWebHookName, embeds = lentilky}), { ['Content-Type'] ='application/json' })
    end
end)

-- Želé Sackovani

ESX.RegisterUsableItem('zele_1kg', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem('zip_bag').count > 0 then
        xPlayer.removeInventoryItem('zele_1kg', 1)
        xPlayer.addInventoryItem('zele_100g', 5)
        xPlayer.removeInventoryItem('zip_bag', Config.zipRemove)
        TriggerClientEvent('esx:showNotification', source, _U('spilled_some'))
    end
end)

ESX.RegisterUsableItem('zele_100g', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem('zip_bag').count > 0 then
        xPlayer.removeInventoryItem('zele_100g', 1)
        xPlayer.addInventoryItem('zele_10g', 5)
        xPlayer.removeInventoryItem('zip_bag', Config.zipRemove)
        TriggerClientEvent('esx:showNotification', source, _U('spilled_some'))
    end
end)

ESX.RegisterUsableItem('zele_10g', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem('zip_bag').count > 0 then
        xPlayer.removeInventoryItem('zele_10g', 1)
        local nahoda = math.random(5,10)
        xPlayer.addInventoryItem('zele_1g', nahoda)
        xPlayer.removeInventoryItem('zip_bag', Config.zipRemove)
        TriggerClientEvent('esx:showNotification', source, _U('spilled_some'))
    end
end)

-- Pervitin Sackovani
ESX.RegisterUsableItem('lipo_1kg', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem('zip_bag').count > 0 then
        xPlayer.removeInventoryItem('lipo_1kg', 1)
        xPlayer.addInventoryItem('lipo_100g', 5)
        xPlayer.removeInventoryItem('zip_bag', Config.zipRemove)
        TriggerClientEvent('esx:showNotification', source, _U('spilled_some'))
    end
end)

ESX.RegisterUsableItem('lipo_100g', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem('zip_bag').count > 0 then
        xPlayer.removeInventoryItem('lipo_100g', 1)
        xPlayer.addInventoryItem('lipo_10g', 5)
        xPlayer.removeInventoryItem('zip_bag', Config.zipRemove)
        TriggerClientEvent('esx:showNotification', source, _U('spilled_some'))
    end
end)

ESX.RegisterUsableItem('lipo_10g', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem('zip_bag').count > 0 then
        xPlayer.removeInventoryItem('lipo_10g', 1)
        local nahoda = math.random(5,10)
        xPlayer.addInventoryItem('lipo_1g', nahoda)
        xPlayer.removeInventoryItem('zip_bag', Config.zipRemove)
        TriggerClientEvent('esx:showNotification', source, _U('spilled_some'))
    end
end)

-- lentilky Sackovani
ESX.RegisterUsableItem('lentilky_1kg', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem('zip_bag').count > 0 then
        xPlayer.removeInventoryItem('lentilky_1kg', 1)
        xPlayer.addInventoryItem('lentilky_100g', 5)
        xPlayer.removeInventoryItem('zip_bag', Config.zipRemove)
        TriggerClientEvent('esx:showNotification', source, _U('spilled_some'))
    end
end)

ESX.RegisterUsableItem('lentilky_100g', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem('zip_bag').count > 0 then
        xPlayer.removeInventoryItem('lentilky_100g', 1)
        xPlayer.addInventoryItem('lentilky_10g', 5)
        xPlayer.removeInventoryItem('zip_bag', Config.zipRemove)
        TriggerClientEvent('esx:showNotification', source, _U('spilled_some'))
    end
end)

ESX.RegisterUsableItem('lentilky_10g', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem('zip_bag').count > 0 then
        xPlayer.removeInventoryItem('lentilky_10g', 1)
        local nahoda = math.random(5,10)
        xPlayer.addInventoryItem('lentilky_1g', nahoda)
        xPlayer.removeInventoryItem('zip_bag', Config.zipRemove)
        TriggerClientEvent('esx:showNotification', source, _U('spilled_some'))
    end
end)

RegisterNetEvent("tv_bonbony:lockpickremove")
AddEventHandler("tv_bonbony:lockpickremove", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem("lockpick", 1)
end)

RegisterNetEvent("tv_bonbony:sell")
AddEventHandler("tv_bonbony:sell", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local zele = xPlayer.getInventoryItem("zele_1g").count
    local lipo = xPlayer.getInventoryItem("lipo_1g").count
    local lentilky = xPlayer.getInventoryItem("lentilky_1g").count

    if zele > 0 then
        local nahoda = math.random(1, zele)
        xPlayer.removeInventoryItem("zele_1g", nahoda)
        local nahodaP = math.random(Config.zeleMinPrice, Config.zeleMaxPrice)
        local penizky = nahodaP * nahoda
        xPlayer.addMoney(penizky)
    elseif lipo > 0 then
        local nahoda = math.random(1, lipo)
        xPlayer.removeInventoryItem("lipo_1g", nahoda)
        local nahodaP = math.random(Config.lipoMinPrice, Config.lipoMaxPrice)
        local penizky = nahodaP * nahoda
        xPlayer.addMoney(penizky)
    elseif lentilky > 0 then
        local nahoda = math.random(1, lentilky)
        xPlayer.removeInventoryItem("lentilky_1g", lentilky)
        local nahodaP = math.random(Config.lentilkyMinPrice, Config.lentilkyMaxPrice)
        local penizky = nahodaP * nahoda
        xPlayer.addMoney(penizky)
    end
end)


local pdCount = false
ESX.RegisterServerCallback('tv_bonbony:pdcount', function(src, cb, pdCount)
    local jobs
    local PDs = 0

    for k, v in pairs(Config.policeJobs) do
        jobs = ESX.GetExtendedPlayers('job', v)
        PDs = PDs + #jobs
    end
    
    if PDs >= Config.policeRequired then
        pdCount = true
    else
        pdCount = false
    end
    cb(pdCount)
end)

RegisterNetEvent("tv_bonbony:policecall")
AddEventHandler("tv_bonbony:policecall", function(pos, mug, shot, street)
    for k,v in pairs(Config.policeJobs) do
        local policejobs = ESX.GetExtendedPlayers('job', v)
        for i=1, #(policejobs) do
            local xPlayer = policejobs[i]
            TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, "Citizen selling activity", "Candies", "Citizen is selling candies on "..tostring(street), shot, 2)
            TriggerClientEvent("tv_bonbony:policeblip", xPlayer.source, pos)
        end
    end
end)