
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

local lokacky = {}
local _tablet = false
local ziskaniVanu = false
local dovezeniVanu = false
local autickoOtevreno = false
local model = 'burrito3'
local bonbon
local dealer = false
local _pdCount = false

RegisterNetEvent('tv_bonbony:hack_usb')
AddEventHandler('tv_bonbony:hack_usb', function(tablet, bonbonos)
    _tablet = tablet
    --print("Tablet client: "..tostring(_tablet))
    if _tablet == true then
        if bonbonos == 'zele' then
            if IsPedArmed(PlayerPedId(),4) then
                ESX.ShowNotification('Ozbrojeny nemuzes hackovat')
            else
                TriggerEvent('mhacking:show')
                TriggerEvent('mhacking:start', Config.mobileHackLength, Config.mobileHackTime, Zele)
            end
        elseif bonbonos == 'lipo' then
            if IsPedArmed(PlayerPedId(),4) then
                ESX.ShowNotification('Ozbrojeny nemuzes hackovat')
            else
                TriggerEvent('mhacking:show')
                TriggerEvent('mhacking:start', Config.mobileHackLength, Config.mobileHackTime, Lipo)
            end
        elseif bonbonos == 'lentilky' then
            if IsPedArmed(PlayerPedId(),4) then
                ESX.ShowNotification('Ozbrojeny nemuzes hackovat')
            else
                TriggerEvent('mhacking:show')
                TriggerEvent('mhacking:start', Config.mobileHackLength, Config.mobileHackTime, Lentilky)
            end
        end
    else
        ESX.ShowNotification(_U('no_tablet'), 'error', 3000)
    end
end)

function Zele(success, timeremaining)
    local hack_uspech = false
    local pedi = 'G_M_ImportExport_01'
    if success then
        hack_uspech = true
        TriggerEvent('mhacking:hide')
    else
        ESX.ShowNotification(_U('hack_failed'), 'error', 3000)
        TriggerEvent('mhacking:hide')
    end

    if hack_uspech == true then
        ziskaniVanu = true
        bonbon = 'zele'
        for k,v in pairs(Zele) do
            local vsechnyidcka = 1
            table.insert(lokacky, {
                idcka = vsechnyidcka,
                pozisn = v.Pos,
                pozisn_auto = v.carPos,
                heading_auto = v.carHeading
            })
            vsechnyidcka = vsechnyidcka + 1
            print("IDcka: "..tostring(vsechnyidcka))
        end
        nahodnalokacka = math.random(1,#lokacky)


        for k,v in pairs(ZeleBlips) do
            blipos = AddBlipForCoord(lokacky[nahodnalokacka].pozisn)
            SetBlipSprite(blipos, v.blipSprite)
            SetBlipColour(blipos, v.blipColor)
            SetBlipScale(blipos, v.blipSize)
            SetBlipAsShortRange(blipos, true)
            SetBlipRoute(blipos, true)
            SetBlipRouteColour(blipos, v.blipColor)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v.blipName)
            EndTextCommandSetBlipName(blipos)
        end
        

        if not IsModelInCdimage(model) then return end
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(0)
        end
        auticko = CreateVehicle(model, lokacky[nahodnalokacka].pozisn_auto, lokacky[nahodnalokacka].heading_auto, true, false)
        SetVehicleDoorsLocked(auticko, 2)
        --print("Auticko funkce: "..tostring(auticko))

        AddRelationshipGroup('kamosi')
        for i = 1,Config.zelePeds,1 do
            RequestModel(pedi)
            while not HasModelLoaded(pedi) do
                Citizen.Wait(1)
            end
            pedik = CreatePed(4,pedi, lokacky[nahodnalokacka].pozisn + vector3(10.0, 0.0, 0.0), true, false)
            SetPedAsEnemy(pedik, true)
            SetPedKeepTask(pedik,true)
            SetPedCombatAttributes(pedik,5,true) -- vzdy bojuje
            SetPedCombatAttributes(pedik,46,true) -- bojuje i beze zbrane
            SetPedCombatAttributes(pedik,54,true) -- zvoli nejlepsi zbran
            SetPedRelationshipGroupHash(pedik, GetHashKey('kamosi'))
            SetRelationshipBetweenGroups(0, GetHashKey('kamosi'), GetHashKey('kamosi'))
            GiveWeaponToPed(pedik, GetHashKey(Config.zeleGuns), 1000, false, true)
            TaskCombatPed(pedik, PlayerPedId())
        end
        hack_uspech = false
        lokacky = {}
    end
end

function Lipo(success, timeremaining)
    local hack_uspech = false
    local pedi = 'G_M_M_CartelGuards_02'
    if success then
        hack_uspech = true
        TriggerEvent('mhacking:hide')
    else
        ESX.ShowNotification(_U('hack_failed'), 'error', 3000)
        TriggerEvent('mhacking:hide')
    end

    if hack_uspech == true then
        ziskaniVanu = true
        bonbon = 'lipo'
        for k,v in pairs(Lipo) do
            local vsechnyidcka = 1
            table.insert(lokacky, {
                idcka = vsechnyidcka,
                pozisn = v.Pos,
                pozisn_auto = v.carPos,
                heading_auto = v.carHeading
            })
            vsechnyidcka = vsechnyidcka + 1
        end
        nahodnalokacka = math.random(1,#lokacky)


        for k,v in pairs(LipoBlips) do
            blipos = AddBlipForCoord(lokacky[nahodnalokacka].pozisn)
            SetBlipSprite(blipos, v.blipSprite)
            SetBlipColour(blipos, v.blipColor)
            SetBlipScale(blipos, v.blipSize)
            SetBlipAsShortRange(blipos, true)
            SetBlipRoute(blipos, true)
            SetBlipRouteColour(blipos, v.blipColor)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v.blipName)
            EndTextCommandSetBlipName(blipos)
        end
        

        if not IsModelInCdimage(model) then return end
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(0)
        end
        auticko = CreateVehicle(model, lokacky[nahodnalokacka].pozisn_auto, lokacky[nahodnalokacka].heading_auto, true, false)
        SetVehicleDoorsLocked(auticko, 2)
        --print("Auticko funkce: "..tostring(auticko))

        AddRelationshipGroup('kamosi')
        for i = 1,Config.lipoPeds,1 do
            RequestModel(pedi)
            while not HasModelLoaded(pedi) do
                Citizen.Wait(1)
            end
            pedik = CreatePed(4,pedi, lokacky[nahodnalokacka].pozisn + vector3(3.0, 0.0, 0.0), true, false)
            SetPedAsEnemy(pedik, true)
            SetPedKeepTask(pedik,true)
            SetPedArmour(pedik, 50)
            SetPedCombatAttributes(pedik,5,true)
            SetPedCombatAttributes(pedik,46,true)
            SetPedCombatAttributes(pedik,54,true)
            SetPedRelationshipGroupHash(pedik, GetHashKey('kamosi'))
            SetRelationshipBetweenGroups(0, GetHashKey('kamosi'), GetHashKey('kamosi'))
            GiveWeaponToPed(pedik, GetHashKey(Config.lipoGuns), 1000, false, true)
            TaskCombatPed(pedik, PlayerPedId())
        end
        hack_uspech = false
        lokacky = {}
    end
end

function Lentilky(success, timeremaining)
    local hack_uspech = false
    local pedi = 'CSB_MWeather'
    if success then
        hack_uspech = true
        TriggerEvent('mhacking:hide')
    else
        ESX.ShowNotification(_U('hack_failed'), 'error', 3000)
        TriggerEvent('mhacking:hide')
    end

    if hack_uspech == true then
        ziskaniVanu = true
        bonbon = 'lentilky'
        for k,v in pairs(Leentilky) do
            local vsechnyidcka = 1
            table.insert(lokacky, {
                idcka = vsechnyidcka,
                pozisn = v.Pos,
                pozisn_auto = v.carPos,
                heading_auto = v.carHeading
            })
            vsechnyidcka = vsechnyidcka + 1
        end
        nahodnalokacka = math.random(1,#lokacky)


        for k,v in pairs(LeentilkyBlips) do
            blipos = AddBlipForCoord(lokacky[nahodnalokacka].pozisn)
            SetBlipSprite(blipos, v.blipSprite)
            SetBlipColour(blipos, v.blipColor)
            SetBlipScale(blipos, v.blipSize)
            SetBlipAsShortRange(blipos, true)
            SetBlipRoute(blipos, true)
            SetBlipRouteColour(blipos, v.blipColor)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v.blipName)
            EndTextCommandSetBlipName(blipos)
        end
        

        if not IsModelInCdimage(model) then return end
        RequestModel(model) -- Request the model
        while not HasModelLoaded(model) do -- Waits for the model to load
            Wait(0)
        end
        auticko = CreateVehicle(model, lokacky[nahodnalokacka].pozisn_auto, lokacky[nahodnalokacka].heading_auto, true, false)
        SetVehicleDoorsLocked(auticko, 2)
        --print("Auticko funkce: "..tostring(auticko))

        AddRelationshipGroup('kamosi')
        for i = 1,Config.lentilkyPeds,1 do
            RequestModel(pedi)
            while not HasModelLoaded(pedi) do
                Citizen.Wait(1)
            end
            pedik = CreatePed(4,pedi, lokacky[nahodnalokacka].pozisn + vector3(3.0, 0.0, 0.0), true, false)
            SetPedAsEnemy(pedik, true)
            SetPedKeepTask(pedik,true)
            SetPedMaxHealth(pedik, 100)
            SetPedArmour(pedik, 100)
            SetPedCombatAttributes(pedik,5,true)
            SetPedCombatAttributes(pedik,46,true)
            SetPedCombatAttributes(pedik,54,true)
            SetPedRelationshipGroupHash(pedik, GetHashKey('kamosi'))
            SetRelationshipBetweenGroups(0, GetHashKey('kamosi'), GetHashKey('kamosi'))
            GiveWeaponToPed(pedik, GetHashKey(Config.lentilkyGuns), 1000, false, true)
            TaskCombatPed(pedik, PlayerPedId())
        end
        hack_uspech = false
        lokacky = {}
    end
end

function VykresliTextMise(x, y, sirka, vyska, scale, text, r, g, b, a)
    SetTextFont(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(1, 0, 0, 0, 255)
    SetTextDropShadow()
    --SetTextWrap(0.5, 0.5)
    SetTextJustification(0)
    BeginTextCommandDisplayText('STRING')
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(x,y)
end

function Vykresli3DText(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
    SetTextScale(0.5, 0.35)
    SetTextFont(4)
    SetTextCentre(true)
    SetTextColour(255, 255, 255, 255)
    --SetTextDropShadow(0, 0, 0, 0, 255)
    --SetTextDropShadow()
    --SetTextOutline()
    local factor = (string.len(text)) / 200

    --print("Factor: "..tostring(factor))
    DrawRect(_x, _y + 0.0105, factor - 0.05, 0.03, 0, 0, 0, 155)
    BeginTextCommandDisplayText('STRING')
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(_x, _y)
end

function DovezeniVanu()
    ziskaniVanu = false
    dovezeniVanu = true
    RemoveBlip(blipos)

    for k,v in pairs(Delivery) do
        karlos = AddBlipForCoord(v.Pos)
        SetBlipSprite(karlos, v.blipSprite)
        SetBlipColour(karlos, v.blipColor)
        SetBlipScale(karlos, v.blipSize)
        SetBlipAsShortRange(karlos, true)
        SetBlipRoute(karlos, true)
        SetBlipRouteColour(karlos, v.blipColor)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.blip_nazev)
        EndTextCommandSetBlipName(karlos)
    end

    TriggerEvent("tv_bonbony:MissionText")
end

function LockMnoz(item)
    local lock = ESX.SearchInventory("lockpick", 1)
    if lock >= 1 then
        return true
    else
        return false
    end
end

Citizen.CreateThread(function()
    local wait = 500
    while true do
        Citizen.Wait(wait)
        local hrac = PlayerPedId()
        local autickoPos = GetEntityCoords(auticko)
        local dist = #(GetEntityCoords(hrac) - autickoPos)
        if dist < 50 and ziskaniVanu == true then
            wait = 5
            DrawMarker(0, autickoPos + vector3(0.0,0.0,3.0), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 255, true, false, 2, true)
            if dist < 3.0 then
                ESX.ShowHelpNotification(_U('car_unlock'))
                if dist < 2.0 and IsControlJustPressed(1,51) and LockMnoz("lockpick") then
                    local lockpick = exports['lockpick']:startLockpick(Config.lockpickTries)
                    if lockpick then
                        ESX.ShowNotification(_U('lockpick_success'), 'success', 3000)
                        DovezeniVanu()
                        --print("Auticko odemknuti: "..tostring(auticko))
                        SetVehicleDoorsLocked(auticko, 1)
                    else
                        ESX.ShowNotification(_U('lockpick_failed'), 'error', 3000)
                        TriggerServerEvent("tv_bonbony:lockpickremove")
                    end
                elseif dist < 2.0 and IsControlJustPressed(1,51) and LockMnoz("lockpick") == false then
                    ESX.ShowNotification(_U('no_lockpick'), 'error', 3000)
                end
            end
        end
    end
end)

RegisterNetEvent('tv_bonbony:MissionText')
AddEventHandler('tv_bonbony:MissionText', function()
    CreateThread(function()
        local wait = 500
        while dovezeniVanu do
            Citizen.Wait(wait)
            local hrac = PlayerPedId()
            if GetVehiclePedIsIn(hrac, false) == auticko and dovezeniVanu == true then
                wait = 7
                if bonbon == 'zele' then
                    VykresliTextMise(0.5, 0.965, 1.0, 1.1, 0.4, _U('zele_delivery'), 255, 255, 255, 255)
                elseif bonbon == 'lipo' then
                    VykresliTextMise(0.5, 0.965, 1.0, 1.1, 0.4, _U('lipo_delivery'), 255, 255, 255, 255)
                elseif bonbon == 'lentilky' then
                    VykresliTextMise(0.5, 0.965, 1.0, 1.1, 0.4, _U('lentilky_delivery'), 255, 255, 255, 255)
                end
            elseif GetVehiclePedIsIn(hrac, false) ~= auticko and dovezeniVanu == true then
                wait = 7
                VykresliTextMise(0.5, 0.965, 1.0, 1.1, 0.4, _U('get_in_van'), 255, 255, 255, 255)
            end
        end
    end)
end)

Citizen.CreateThread(function()
    local wait = 500
    while true do
        Citizen.Wait(wait)
        local hrac = PlayerPedId()
        for k,v in pairs(Delivery) do
            local dist = #(GetEntityCoords(hrac) - v.Pos)
            if dist < 10 and dovezeniVanu == true and GetVehiclePedIsIn(hrac, false) == auticko then
                wait = 5
                DrawMarker(0, v.Pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 255, false, false, 2, false)
                if dist < 3.0 then
                    ESX.ShowHelpNotification(_U('delivery_marker'))
                    if dist < 2.0 and IsControlJustPressed(1,51) then
                        local autinko = GetVehiclePedIsIn(hrac, false)
                        SetVehicleDoorOpen(autinko, 2, false, false)
                        SetVehicleDoorOpen(autinko, 3, false, false)
                        autickoOtevreno = true
                        dovezeniVanu = false
                        RemoveBlip(karlos)
                        TriggerEvent('tv_bonbony:CarText')
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('tv_bonbony:CarText')
AddEventHandler('tv_bonbony:CarText', function()
    CreateThread(function()
        local wait = 500
        while autickoOtevreno do
            --print("Auticko Text Event: "..tostring(autickoOtevreno))
            Citizen.Wait(wait)
            local hrac = PlayerPedId()
            local autickoPos = GetEntityCoords(auticko)
            --print("Auticko Pozisn: "..tostring(autickoPos))
            --print("Auticko Pozisn X: "..tostring(autickoPos.x))
            local autickoDist = #(GetEntityCoords(hrac) - autickoPos)
            --print("AutickoDist: "..tostring(autickoDist))
            if autickoDist < 10.0 and IsPedOnFoot(hrac) then
                wait = 5
                --print("3D Text vykresleni :)")
                Vykresli3DText(autickoPos.x, autickoPos.y + 2.0, autickoPos.z + 0.5, _U('car_3d_text'))
                if autickoDist < 4.0 and IsControlJustPressed(1,51) then
                    RequestAnimDict('amb')
                    RequestAnimDict('amb@prop_human_bum_bin')
                    RequestAnimDict('amb@prop_human_bum_bin@base')
                    while (not HasAnimDictLoaded('amb@prop_human_bum_bin@base')) do Citizen.Wait(0) end
                    TaskPlayAnim(hrac,'amb@prop_human_bum_bin@base', 'base', 8.0, 8.0, 5000, 10, 0.0, 0, 0, 1)
                    lib.progressBar({
                        duration = 5000,
                        label = _U('progress_car'),
                        useWhileDead = false,
                        canCancel = false,
                        disable = {
                            move = true,
                            car = true,
                            mouse = true,
                        },
                    })
                    DeleteVehicle(auticko)
                    TriggerServerEvent('tv_bonbony:end', bonbon)
                    autickoOtevreno = false
                end
            end
        end
    end)
end)

RegisterCommand("dealer", function(ped, args, rawCommand)
        --print("Command zavolan")
        if dealer == false then
            dealer = true
            TriggerEvent("tv_bonbony:sellClient")
        elseif dealer == true then
            dealer = false
            TriggerEvent("tv_bonbony:sellClient")
        end
end, false)

function MnozDrog(item)
    local zele = ESX.SearchInventory("zele_1g", 1)
    local lipo = ESX.SearchInventory("lipo_1g", 1)
    local lentilky = ESX.SearchInventory("lentilky_1g", 1)
    if (zele or lipo or lentilky) >= 1 then
        return true
    else
        return false
    end
end

ESX.TriggerServerCallback('tv_bonbony:pdcount', function(pdCount)
    _pdCount = pdCount
end)

RegisterNetEvent("tv_bonbony:policeblip")
AddEventHandler("tv_bonbony:policeblip", function(position)
    policeblip = AddBlipForCoord(position)
    SetBlipSprite(policeblip, Config.policeBlip)
    SetBlipColour(policeblip, Config.policeBlipColor)
    SetBlipScale(policeblip, 1.0)
    SetBlipAsShortRange(policeblip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.policeBlipText)
    EndTextCommandSetBlipName(policeblip)
    Wait(Config.policeBlipTime * 1000)
    RemoveBlip(policeblip)
end)

RegisterNetEvent("tv_bonbony:sellClient")
AddEventHandler("tv_bonbony:sellClient", function()
    CreateThread(function()
        local wait = 500
        while dealer do
            Citizen.Wait(wait)
            local hrac = PlayerPedId()
            local hracPos = GetEntityCoords(hrac)
            local nejblizsiPed = ESX.Game.GetClosestPed(hracPos)
            local pedPos = GetEntityCoords(nejblizsiPed)
            local dist = #(hracPos - pedPos)
            local pedTyp = GetPedType(nejblizsiPed)
            --print("nejblizsi ped: "..tostring(nejblizsiped))
            if dist < 5.0 and not IsPedDeadOrDying(nejblizsiPed) and not (IsPedInAnyVehicle(nejblizsiPed) or IsPedInAnyVehicle(hrac)) and pedTyp ~= 28 and nejblizsiPed ~= nepotrebnyped then
                wait = 5
                ESX.ShowFloatingHelpNotification(_U('sell_3dtext'), pedPos + vector3(0.0, 0.0, 0.75))
                if dist < 1.5 and IsControlJustPressed(1, 51) then
                    if _pdCount then
                        nepotrebnyped = nejblizsiPed
                        TaskLookAtEntity(nejblizsiPed, hrac, 3000, 2048, 3)
                        TaskStandStill(nejblizsiPed, 3000)
                        SetEntityAsMissionEntity(nejblizsiPed)
                        if MnozDrog("zele_1g") or MnozDrog("lipo_1g") or MnozDrog("lentilky_1g") then
                            local nahoda = math.random(1,3)
                            lib.progressBar({
                                duration = 3000,
                                label = _U('progress_sell'),
                                useWhileDead = false,
                                canCancel = false,
                                disable = {
                                    move = true,
                                    car = true,
                                    combat = true
                                },
                            })
                            if nahoda == 1 then
                                RequestAnimDict('mp_common')
                                while (not HasAnimDictLoaded('mp_common')) do Citizen.Wait(0) end
                                TaskPlayAnim(hrac,'mp_common', 'givetake1_a', 8.0, 8.0, 2000, 10, 0.0, 0, 0, 1)
                                RequestAnimDict('mp_common')
                                while (not HasAnimDictLoaded('mp_common')) do Citizen.Wait(0) end
                                TaskPlayAnim(nejblizsiPed,'mp_common', 'givetake1_a', 8.0, 8.0, 2000, 10, 0.0, 0, 0, 1)
                                TriggerServerEvent("tv_bonbony:sell")
                            elseif nahoda == 2 then
                                ESX.ShowNotification(_U('candy_refused'), 'error', 3000)
                            elseif nahoda == 3 then
                                ESX.ShowNotification(_U('cit_call_police'), 'error', 3000)
                                RequestAnimDict('cellphone@')
                                while (not HasAnimDictLoaded('cellphone@')) do Citizen.Wait(0) end
                                TaskPlayAnim(nejblizsiPed,'cellphone@', 'cellphone_call_listen_base', 8.0, 8.0, 2000, 16, 0.0, 0, 0, 1)
                                local street, road = GetStreetNameAtCoord(hracPos.x,hracPos.y,hracPos.z)
                                local streetName = GetStreetNameFromHashKey(street)
                                local mug, shot = ESX.Game.GetPedMugshot(hrac)
                                TriggerServerEvent("tv_bonbony:policecall", hracPos, mug, shot, streetName)
                                UnregisterPedheadshot(mug)
                            end
                        else
                            ESX.ShowNotification(_U('no_candies'), 'info', 3000)
                        end
                        SetPedAsNoLongerNeeded(nepotrebnyped)
                    else
                        ESX.ShowNotification(_U('not_enough_pd'), 'error', 3000)
                    end
                end
            end
        end
    end)
end)