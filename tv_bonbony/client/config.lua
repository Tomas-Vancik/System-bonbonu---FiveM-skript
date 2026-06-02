
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
Config = {}

Config.Locale = 'en'

Config.zelePeds = 2 -- HOW MANY PEDS WILL BE ON LOCATION
Config.lipoPeds = 4 -- SAME
Config.lentilkyPeds = 5 -- SAME

Config.zeleGuns = 'WEAPON_MICROSMG' -- Hash key of weapons you want to give for the peds (Zele Locations)
Config.lipoGuns = 'WEAPON_SMG' -- (Lipo Locations)
Config.lentilkyGuns = 'WEAPON_CARBINERIFLE' -- (Lentilky Locations)

Config.mobileHackLength = 3 -- LENGTH OF CHARACTERS YOU NEED TO FIND IN MOBILE HACKING MINIGAME
Config.mobileHackTime = 60 -- TIME TO HACK MOBILE MINIGAME IN SECONDS (60 seconds = 1 min)

Config.lockpickTries = 3 -- HOW MANY TRIES PLAYER HAS BEFORE FAIL

Config.policeBlip = 51 -- PD BLIP ON PLAYER WHEN CITIZEN CALLS POLICE
Config.policeBlipColor = 59 -- BLIP COLOR
Config.policeBlipText = "Citizen is selling candies"
Config.policeBlipTime = 20 -- HOW LONG WILL BE BLIP ON MAP IN SECONDS!!!


ZeleBlips = {
    {        
        blipSprite = 140, -- YOU CAN FIND HERE: https://docs.fivem.net/docs/game-references/blips/#blips
        blipColor = 25, -- YOU CAN FIND HERE: https://docs.fivem.net/docs/game-references/blips/#blip-colors
        blipSize = 0.5, -- SIZE OF THE BLIP ON MAP
        blipName = "Zele Location" -- NAME OF THE BLIP IN PAUSE MENU MAP
    }
}

LipoBlips = {
    {
        blipSprite = 499,
        blipColor = 3,
        blipSize = 0.5,
        blipName = "Lipo Location"
    }
}

LentilkyBlips = {
    {
        blipSprite = 514,
        blipColor = 4,
        blipSize = 0.5,
        blipName = "Lentilky Location"
    }
}

Delivery = {
    {
        Pos = vector3(-440.1111, -2180.5479, 8.9739), -- DELIVERY POS
        blipSprite = 500,
        blipColor = 46,
        blipSize = 0.8,
        blipName = "Delivery"
    }
}

------------------------------------------------------------------------

-- You can add as many locations as you want

------------------------------------------------------------------------

-- FROM HERE --
Zele = {
    ['1'] = {
        Pos = vector3(1746.4714, 3059.5825, 61.1026), -- BLIP POSITION AND PEDS POSITIONS
        carPos = vector3(1763.9161, 3049.9243, 61.1127), -- CAR POSITION
        carHeading = 0 -- CAR ROTATION
    },
    ['2'] = {
        Pos = vector3(391.6552, 2970.3328, 40.9590),
        carPos = vector3(412.1150, 2997.6479, 40.4995),
        carHeading = 0
    },
    ['3'] = {
        Pos = vector3(80.8018, 3650.3718, 39.7028),
        carPos = vector3(92.9468, 3692.2065, 39.6608),
        carHeading = 0
    }
    --[[EXAMPLE
        [NAME YOU WANT (I USE NUMBERS)] = {
            Pos = vector3(coords - you can get it in txAdmin menu),
            peds = {vector3(),vector3()},
            carPos = vector3(same),
            carHeading = rotation of the car (number)
        } <-- HERE IF YOU WANT ADD MORE LOCATIONS YOU NEED PLACE , BEHIND } !!! THE LAST LOCATION WONT HAS ,
    ]]
}

Lipo = {
    ['1'] = {
        Pos = vector3(1518.5579, 1714.8135, 110.3227),
        carPos = vector3(1532.9265, 1702.6921, 109.7417),
        carHeading = 0
    },
    ['2'] = {
        Pos = vector3(2421.1279, 1997.0392, 84.5018),
        carPos = vector3(2430.1951, 1982.7535, 83.0012),
        carHeading = 0
    },
    ['3'] = {
        Pos = vector3(2760.8193, -711.5075, 8.9094),
        carPos = vector3(2778.3518, -709.4180, 5.4114),
        carHeading = 0
    }
}

Lentilky = {
    ['1'] = {
        Pos = vector3(-2332.6140, 303.2684, 169.4671),
        carPos = vector3(-2331.9768, 296.5809, 169.4671),
        carHeading = 0
    },
    ['2'] = {
        Pos = vector3(620.4028, 630.8930, 128.9208),
        carPos = vector3(610.6677, 627.4186, 128.9111),
        carHeading = 0
    },
    ['3'] = {
        Pos = vector3(-74.8981, 897.1141, 235.5396),
        carPos = vector3(-67.4468, 895.1738, 235.5415),
        carHeading = 0
    }
}
-- TO HERE --