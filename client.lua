-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPS = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("hud",cRP)
vSERVER = Tunnel.getInterface("hud")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local voice = 1
local showHud = true
local showHudEvent = true
local showPainel = false 
local talking = false

-- fome - sede - stress - oxigen
local clientStress = 0
local clientHunger = 100
local clientThirst = 100
local clientOxigen = 100

local radioDisplay = ""
local pauseBreak = false

local saltyScreen = false
local homeInterior = false

local playerActive = true

local updateFoods = GetGameTimer()

-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATBELT
-----------------------------------------------------------------------------------------------------------------------------------------
local beltLock = 0
local beltSpeed = 0
local beltVelocity = 0



-----------------------------------------------------------------------------------------------------------------------------------------
-- DIVINABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local divingMask = nil
local divingTank = nil


local hardness = {}

local divingTimers = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOCKVARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local clockHours = 8
local clockMinutes = 0

-----------------------------------------------------------------------------------------------------------------------------------------
-- Verificar a necessidade das linha abaixo -- importado inicio
-----------------------------------------------------------------------------------------------------------------------------------------
local Config = module('java_hud', 'config')
local Locales = module('java_hud', 'locales/languages')

local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18, ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182, ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81, ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178, ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173, ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local AllWeapons = json.decode('{"melee":{"dagger":"0x92A27487","bat":"0x958A4A8F","bottle":"0xF9E6AA4B","crowbar":"0x84BD7BFD","unarmed":"0xA2719263","flashlight":"0x8BB05FD7","golfclub":"0x440E4788","hammer":"0x4E875F73","hatchet":"0xF9DCBF2D","knuckle":"0xD8DF3C3C","knife":"0x99B507EA","machete":"0xDD5DF8D9","switchblade":"0xDFE37640","nightstick":"0x678B81B1","wrench":"0x19044EE0","battleaxe":"0xCD274149","poolcue":"0x94117305","stone_hatchet":"0x3813FC08"},"handguns":{"pistol":"0x1B06D571","pistol_mk2":"0xBFE256D4","combatpistol":"0x5EF9FEC4","appistol":"0x22D8FE39","stungun":"0x3656C8C1","pistol50":"0x99AEEB3B","snspistol":"0xBFD21232","snspistol_mk2":"0x88374054","heavypistol":"0xD205520E","vintagepistol":"0x83839C4","flaregun":"0x47757124","marksmanpistol":"0xDC4DB296","revolver":"0xC1B3C3D1","revolver_mk2":"0xCB96392F","doubleaction":"0x97EA20B8","raypistol":"0xAF3696A1"},"smg":{"microsmg":"0x13532244","smg":"0x2BE6766B","smg_mk2":"0x78A97CD0","assaultsmg":"0xEFE7E2DF","combatpdw":"0xA3D4D34","machinepistol":"0xDB1AA450","minismg":"0xBD248B55","raycarbine":"0x476BF155"},"shotguns":{"pumpshotgun":"0x1D073A89","pumpshotgun_mk2":"0x555AF99A","sawnoffshotgun":"0x7846A318","assaultshotgun":"0xE284C527","bullpupshotgun":"0x9D61E50F","musket":"0xA89CB99E","heavyshotgun":"0x3AABBBAA","dbshotgun":"0xEF951FBB","autoshotgun":"0x12E82D3D"},"assault_rifles":{"assaultrifle":"0xBFEFFF6D","assaultrifle_mk2":"0x394F415C","carbinerifle":"0x83BF0278","carbinerifle_mk2":"0xFAD1F1C9","advancedrifle":"0xAF113F99","specialcarbine":"0xC0A3098D","specialcarbine_mk2":"0x969C3D67","bullpuprifle":"0x7F229F94","bullpuprifle_mk2":"0x84D6FAFD","compactrifle":"0x624FE830"},"machine_guns":{"mg":"0x9D07F764","combatmg":"0x7FD62962","combatmg_mk2":"0xDBBD7280","gusenberg":"0x61012683"},"sniper_rifles":{"sniperrifle":"0x5FC3C11","heavysniper":"0xC472FE2","heavysniper_mk2":"0xA914799","marksmanrifle":"0xC734385A","marksmanrifle_mk2":"0x6A6C02E0"},"heavy_weapons":{"rpg":"0xB1CA77B1","grenadelauncher":"0xA284510B","grenadelauncher_smoke":"0x4DD2DC56","minigun":"0x42BF8A85","firework":"0x7F7497E5","railgun":"0x6D544C99","hominglauncher":"0x63AB0442","compactlauncher":"0x781FE4A","rayminigun":"0xB62D1F67"},"throwables":{"grenade":"0x93E220BD","bzgas":"0xA0973D5E","smokegrenade":"0xFDBC8A50","flare":"0x497FACC3","molotov":"0x24B17070","stickybomb":"0x2C3731D9","proxmine":"0xAB564B93","snowball":"0x787F0BB","pipebomb":"0xBA45E8B8","ball":"0x23C9F95C"},"misc":{"petrolcan":"0x34A67B97","fireextinguisher":"0x60EC506","parachute":"0xFBAB5776"}}')

function _U(entry)
	return Locales[ Config.Locale ][entry]  
end

local vehiclesCars = {0,1,2,3,4,5,6,7,8,9,10,11,12,17,18,19,20};

-- fim importado


-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:PLAYERACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp:playerActive")
AddEventHandler("vrp:playerActive",function(user_id)
	playerActive = true
end)

RegisterNetEvent("vrp:attHoraHud")
AddEventHandler("vrp:attHoraHud",function(hora,minuto)
	clockHours = hora
	clockMinutes = minuto
end)

RegisterNetEvent("vrp:attFomeSedeStressHud")
AddEventHandler("vrp:attFomeSedeStressHud",function(fome,sede,stress)
	clientStress = stress
	clientHunger = fome
	clientThirst = sede
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SALTYSCREEN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("SaltyChat_PluginStateChanged",function(statusScreen)
	if statusScreen <= 1 then
		if not saltyScreen then
			saltyScreen = true
			SendNUIMessage({ acao = "toggleSaltyScreen", screen = saltyScreen })
		end
	else
		if saltyScreen then
			saltyScreen = false
			SendNUIMessage({ acao = "toggleSaltyScreen", screen = saltyScreen })
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADFOODS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		playerActive = true
		if playerActive then
			local ped = PlayerPedId()
			if GetEntityHealth(ped) > 101 then

				if clientThirst > 0 then 
					clientThirst = clientThirst - 1
				end 
				if clientHunger > 0 then 
					clientHunger = clientHunger - 1
				end 

				TriggerEvent("statusHunger",clientHunger)
				TriggerEvent("statusThirst",clientThirst)

				vRPS.clientFoods()
			end
		end

		Citizen.Wait(36000)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHEALTHREDUCE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if playerActive then
			local ped = PlayerPedId()
			if GetEntityHealth(ped) > 101 then
				if clientHunger >= 10 and clientHunger <= 20 then
					ApplyDamageToPed(ped,1,false)
					TriggerEvent("Notify","hunger","Sofrendo com a fome.",10000,"bottom","atenção")
				elseif clientHunger <= 9 then
					ApplyDamageToPed(ped,2,false)
					TriggerEvent("Notify","hunger","Sofrendo com a fome.",10000,"bottom","atenção")
				end

				if clientThirst >= 10 and clientThirst <= 20 then
					ApplyDamageToPed(ped,1,false)
					TriggerEvent("Notify","thirst","Sofrendo com a sede.",10000,"bottom","atenção")
				elseif clientThirst <= 9 then
					ApplyDamageToPed(ped,2,false)
					TriggerEvent("Notify","thirst","Sofrendo com a sede.",10000,"bottom","atenção")
				end
			end
		end

		Citizen.Wait(15000)
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADGLOBAL - NOVO
-----------------------------------------------------------------------------------------------------------------------------------------
local is_roupa_mergulho = false
local count_t = 0

Citizen.CreateThread(function()

	while true do

		local time_oxigenio = 1000
		

		local ped = PlayerPedId()

		if playerActive then
			if IsPedSwimmingUnderWater(ped) then 

				SetPedMaxTimeUnderwater(ped,5000.0)

				if is_roupa_mergulho then
					time_oxigenio = 1000
					count_t = count_t + 1
					if count_t == 4 then 
						clientOxigen = clientOxigen - 1
						count_t = 0
					end
				else 
					time_oxigenio = 250
					clientOxigen = clientOxigen - 1
				end

				if clientOxigen < 0 then 
					clientOxigen = 0
				end
				
				if clientOxigen <= 0 then
					ApplyDamageToPed(ped,10,false)
				end
			else
				if clientOxigen < 100 then
					clientOxigen = clientOxigen + 10
					time_oxigenio = 1000
					if clientOxigen > 100 then 
						clientOxigen = 100
					end
				end
			end
		end

		Citizen.Wait(time_oxigenio)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADGLOBAL - antigo
-----------------------------------------------------------------------------------------------------------------------------------------
-- Citizen.CreateThread(function()
-- 	while true do
-- 		if playerActive then
-- 			if divingMask ~= nil then
-- 				if GetGameTimer() >= divingTimers then
-- 					divingTimers = GetGameTimer() + 35000
-- 					clientOxigen = clientOxigen - 1
-- 					vRPS.clientOxigen()

-- 					if clientOxigen <= 0 then
-- 						ApplyDamageToPed(PlayerPedId(),50,false)
-- 					end
-- 				end
-- 			end
-- 		end

-- 		Citizen.Wait(5000)
-- 	end
-- end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSHAKESTRESS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		if playerActive then
			local ped = PlayerPedId()
			local health = GetEntityHealth(ped)

			if health > 101 then
				if clientStress then 
					if clientStress >= 99 then
						ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.95)
					elseif clientStress >= 80 and clientStress <= 98 then
						timeDistance = 9990
						ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.85)
					elseif clientStress >= 60 and clientStress <= 79 then
						timeDistance = 7500
						ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.75)
					elseif clientStress >= 40 and clientStress <= 59 then
						timeDistance = 9990
						ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.55)
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)





-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	DisplayRadar(false)

	RequestStreamedTextureDict("circlemap",false)
	while not HasStreamedTextureDictLoaded("circlemap") do
		Citizen.Wait(100)
	end

	AddReplaceTexture("platform:/textures/graphics","radarmasksm","circlemap","radarmasksm")

	SetMinimapClipType(1)

	SetMinimapComponentPosition("minimap","L","B",0.0,0.0,0.158,0.28)
	SetMinimapComponentPosition("minimap_mask","L","B",0.155,0.12,0.080,0.164)
	SetMinimapComponentPosition("minimap_blur","L","B",-0.005,0.021,0.240,0.302)

	Citizen.Wait(5000)

	SetBigmapActive(true,false)

	Citizen.Wait(100)

	SetBigmapActive(false,false)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- USERTALKING
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("SaltyChat_TalkStateChanged",function(status)
	talking = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROGRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Progress")
AddEventHandler("Progress",function(progressTimer)
	SendNUIMessage({ acao = "toggleProgress", progress = true, progressTimer = progressTimer })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHUD
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if playerActive then
			if IsPauseMenuActive() then
				SendNUIMessage({ acao = "toggleHud", hud = false })
				pauseBreak = true
			else
				if showHud and showHudEvent then
					SendNUIMessage({ acao = "toggleHud", hud = true })
				else
					SendNUIMessage({ acao = "toggleHud", hud = false })
				end
				if pauseBreak then
					pauseBreak = false
				end
			end

		end

		Citizen.Wait(1000)
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEDISPLAYHUD
-----------------------------------------------------------------------------------------------------------------------------------------
function updateDisplayHud()
	local ped = PlayerPedId()
	local armour = GetPedArmour(ped)
	SendNUIMessage({ acao = "updateDisplayHud", hunger = clientHunger, stress = clientStress, thirst = clientThirst, health = GetEntityHealth(ped) - 100, armour = armour, oxigen = clientOxigen, clockHours = clockHours, clockMinutes = clockMinutes })
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("confighud",function(source,args)
	-- if exports["chat"]:statusChat() then
		showPainel = not showPainel

		SendNUIMessage({ acao = "toggleConfiguracoes", showPainel = showPainel })
		SetNuiFocus(showPainel, showPainel)
	-- end
end)

RegisterNUICallback('confighud', function(data, cb)
	cb("")
	ExecuteCommand("confighud")
end)

RegisterCommand("definirHUdParaTodos",function(source,args)
	SendNUIMessage({ acao = "definirHUdParaTodos" })
end)

RegisterCommand("mostrarhud",function(source,args)
	showHud = true

	SendNUIMessage({ acao = "toggleHud", hud = showHud })

	if IsMinimapRendering() and not showHud then
		DisplayRadar(false)
	end
end)

RegisterCommand("fecharhud",function(source,args)
	showHud = false

	SendNUIMessage({ acao = "toggleHud", hud = showHud })

	if IsMinimapRendering() and not showHud then
		DisplayRadar(false)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:TOGGLEHOOD 
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:toggleHood")
AddEventHandler("hud:toggleHood",function()
	showHood = not showHood

	if showHood then
		DoScreenFadeOut(1000)
		SetPedComponentVariation(PlayerPedId(),1,69,0,1)
	else
		DoScreenFadeIn(1000)
		SetPedComponentVariation(PlayerPedId(),1,0,0,1)
	end

	SendNUIMessage({ acao = "toggleHood", hood = showHood })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:REMOVEHOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:removeHood")
AddEventHandler("hud:removeHood",function()
	if showHood then
		showHood = false
		SendNUIMessage({ acao = "removeHood", hood = showHood })
		SetPedComponentVariation(PlayerPedId(),1,0,0,1)
	end
end)



-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:HARDNESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("monkey_hud:plateHardness")
AddEventHandler("monkey_hud:plateHardness",function(vehPlate,status)
	hardness[vehPlate] = parseInt(status)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:ALLHARDNESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("monkey_hud:allHardness")
AddEventHandler("monkey_hud:allHardness",function(vehHardness)
	hardness = vehHardness
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:REMOVEHOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("monkey_hud:removeHood")
AddEventHandler("monkey_hud:removeHood",function()
	if showHood then
		showHood = false
		SendNUIMessage({ hood = showHood })
		SetPedComponentVariation(PlayerPedId(),1,0,0,1)
	end
end)





-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUSHUNGER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("statusHunger")
AddEventHandler("statusHunger",function(number)
	clientHunger = parseInt(number)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUSTHIRST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("statusThirst")
AddEventHandler("statusThirst",function(number)
	clientThirst = parseInt(number)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUSSTRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("statusStress")
AddEventHandler("statusStress",function(number)
	clientStress = parseInt(number)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUSOXIGEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("statusOxigen")
AddEventHandler("statusOxigen",function(number)
	clientOxigen = parseInt(number)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECHARGEOXIGEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("monkey_hud:rechargeOxigen")
AddEventHandler("monkey_hud:rechargeOxigen",function()
	TriggerEvent("Notify","sucesso","Reabastecimento concluído.")
	vRPS.rechargeOxigen()
	clientOxigen = 100
end)




-----------------------------------------------------------------------------------------------------------------------------------------
-- RECHARGEOXIGEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:rechargeOxigen")
AddEventHandler("hud:rechargeOxigen",function()
	TriggerEvent("Notify","verde","Reabastecimento concluído.",3000)
	vRPS.rechargeOxigen()
	clientOxigen = 100
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUDACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hudActived")
AddEventHandler("hudActived",function(status)
	showHudEvent = status

	updateDisplayHud()

	SendNUIMessage({ acao = "hudActived", hud = showHudEvent })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:VOICEMODE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("SaltyChat_VoiceRangeChanged")
AddEventHandler("SaltyChat_VoiceRangeChanged",function(_,status)
	voice = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:RADIODISPLAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:RadioDisplay")
AddEventHandler("hud:RadioDisplay",function(number)
	if parseInt(number) <= 0 then
		radioDisplay = ""
	else
		radioDisplay = parseInt(number).."Mhz <s>:</s>"
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FOWARDPED
-----------------------------------------------------------------------------------------------------------------------------------------
function fowardPed(ped)
	local heading = GetEntityHeading(ped) + 90.0
	if heading < 0.0 then
		heading = 360.0 + heading
	end

	heading = heading * 0.0174533

	return { x = math.cos(heading) * 2.0, y = math.sin(heading) * 2.0 }
end

Citizen.CreateThread(function()
	while true do
		updateDisplayHud()
		Citizen.Wait(500)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- HOMES:HOURS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("homes:Hours")
AddEventHandler("homes:Hours",function(status)
	homeInterior = status
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVESCUBA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:removeScuba")
AddEventHandler("hud:removeScuba",function()
	local ped = PlayerPedId()
	if DoesEntityExist(divingMask) or DoesEntityExist(divingTank) then
		if DoesEntityExist(divingMask) then
			TriggerServerEvent("tryDeleteEntity",ObjToNet(divingMask))
			divingMask = nil
		end

		if DoesEntityExist(divingTank) then
			TriggerServerEvent("tryDeleteEntity",ObjToNet(divingTank))
			divingTank = nil
		end

		SetEnableScuba(ped,false)
		SetPedMaxTimeUnderwater(ped,10.0)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:SETDIVING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:setDiving")
AddEventHandler("hud:setDiving",function()
	local ped = PlayerPedId()

	if DoesEntityExist(divingMask) or DoesEntityExist(divingTank) then
		if DoesEntityExist(divingMask) then
			TriggerServerEvent("tryDeleteEntity",ObjToNet(divingMask))
			divingMask = nil
		end

		if DoesEntityExist(divingTank) then
			TriggerServerEvent("tryDeleteEntity",ObjToNet(divingTank))
			divingTank = nil
		end

		SetEnableScuba(ped,false)
		SetPedMaxTimeUnderwater(ped,10.0)
	else
		local coords = GetEntityCoords(ped)
		local maskModel = GetHashKey("p_s_scuba_mask_s")
		local tankModel = GetHashKey("p_s_scuba_tank_s")

		RequestModel(tankModel)
		while not HasModelLoaded(tankModel) do
			Citizen.Wait(1)
		end

		RequestModel(maskModel)
		while not HasModelLoaded(maskModel) do
			Citizen.Wait(1)
		end

		if HasModelLoaded(tankModel) then
			divingTank = CreateObject(tankModel,coords["x"],coords["y"],coords["z"],true,true,false)
			local netObjs = ObjToNet(divingTank)

			SetNetworkIdCanMigrate(netObjs,true)

			SetEntityAsMissionEntity(divingTank,true,false)
			SetEntityInvincible(divingTank,true)

			AttachEntityToEntity(divingTank,ped,GetPedBoneIndex(ped,24818),-0.28,-0.24,0.0,180.0,90.0,0.0,1,1,0,0,2,1)

			SetModelAsNoLongerNeeded(tankModel)
		end

		if HasModelLoaded(maskModel) then
			divingMask = CreateObject(maskModel,coords["x"],coords["y"],coords["z"],true,true,false)
			local netObjs = ObjToNet(divingMask)

			SetNetworkIdCanMigrate(netObjs,true)

			SetEntityAsMissionEntity(divingMask,true,false)
			SetEntityInvincible(divingMask,true)

			AttachEntityToEntity(divingMask,ped,GetPedBoneIndex(ped,12844),0.0,0.0,0.0,180.0,90.0,0.0,1,1,0,0,2,1)

			SetModelAsNoLongerNeeded(maskModel)
		end

		SetEnableScuba(ped,true)
		SetPedMaxTimeUnderwater(ped,2000.0)
	end
end)

RegisterCommand("mudarLogoHud",function(source,args)
	SendNUIMessage({ acao = "mudarLogoHud" })
end)




---------------------------------------------------------------------------------------
-- inicio importado
---------------------------------------------------------------------------------------

-- atualiza localidades
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local player = GetPlayerPed(-1)
		local position = GetEntityCoords(player)
		if Config.ui.showLocation == true then
			local zoneNameFull = zones[GetNameOfZone(position.x, position.y, position.z)]
			local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(position.x, position.y, position.z))
			local locationMessage = nil
			if zoneNameFull then 
				locationMessage = streetName .. ', ' .. zoneNameFull
			else
				locationMessage = streetName
			end
			locationMessage = string.format(
				Locales[Config.Locale]['you_are_on_location'],
				locationMessage
			)
			SendNUIMessage({ action = 'setText', id = 'location', value = locationMessage })
		end
	end
end)

-- Vehicle Info
local vehicleCruiser
local vehicleSignalIndicator = 'off'
local seatbeltEjectSpeed = 45.0 
local seatbeltEjectAccel = 100.0
local seatbeltIsOn = false
local currSpeed = 0.0
local prevVelocity = {x = 0.0, y = 0.0, z = 0.0}

local g_vehicle = 100

Citizen.CreateThread(function()
	while true do

		local time = 1000

		local player = GetPlayerPed(-1)
		local vehicle = GetVehiclePedIsIn(player, false)
		local position = GetEntityCoords(player)
		local vehicleIsOn = GetIsVehicleEngineRunning(vehicle)
		local vehicleInfo

		if IsPedInAnyVehicle(player, false) and vehicleIsOn then

			time = 100

			local vehicleClass = GetVehicleClass(vehicle)

			if Config.ui.showMinimap == false then
				DisplayRadar(true)
			end

			-- Vehicle Speed
			local vehicleSpeedSource = GetEntitySpeed(vehicle)
			local vehicleSpeed
			if Config.vehicle.speedUnit == 'MPH' then
				vehicleSpeed = math.ceil(vehicleSpeedSource * 2.237)
			else
				vehicleSpeed = math.ceil(vehicleSpeedSource * 3.6)
			end

			-- Vehicle Gradient Speed
			local vehicleNailSpeed

			if vehicleSpeed > Config.vehicle.maxSpeed then
				vehicleNailSpeed = math.ceil(  280 - math.ceil( math.ceil(Config.vehicle.maxSpeed * 205) / Config.vehicle.maxSpeed) )
			else
				vehicleNailSpeed = math.ceil(  280 - math.ceil( math.ceil(vehicleSpeed * 205) / Config.vehicle.maxSpeed) )
			end

			-- Vehicle Fuel and Gear
			local vehicleFuel
			vehicleFuel = GetVehicleFuelLevel(vehicle)

			local vehicleGear = GetVehicleCurrentGear(vehicle)

			if (vehicleSpeed == 0 and vehicleGear == 0) or (vehicleSpeed == 0 and vehicleGear == 1) then
				vehicleGear = 'N'
			elseif vehicleSpeed > 0 and vehicleGear == 0 then
				vehicleGear = 'R'
			end

			-- Vehicle Lights
			local vehicleVal,vehicleLights,vehicleHighlights  = GetVehicleLightsState(vehicle)
			local vehicleIsLightsOn
			if vehicleLights == 1 and vehicleHighlights == 0 then
				vehicleIsLightsOn = 'normal'
			elseif (vehicleLights == 1 and vehicleHighlights == 1) or (vehicleLights == 0 and vehicleHighlights == 1) then
				vehicleIsLightsOn = 'high'
			else
				vehicleIsLightsOn = 'off'
			end

			-- Vehicle Siren
			local vehicleSiren

			if IsVehicleSirenOn(vehicle) then
				vehicleSiren = true
			else
				vehicleSiren = false
			end


			-- if has_value(vehiclesCars, vehicleClass) == true and vehicleClass ~= 8 then

			-- 	local prevSpeed = currSpeed
            --     currSpeed = vehicleSpeedSource

            --     SetPedConfigFlag(PlayerPedId(), 32, true)

            --     if not seatbeltIsOn then
            --     	local vehIsMovingFwd = GetEntitySpeedVector(vehicle, true).y > 1.0
            --         local vehAcc = (prevSpeed - currSpeed) / GetFrameTime()
            --         if (vehIsMovingFwd and (prevSpeed > (seatbeltEjectSpeed/2.237)) and (vehAcc > (seatbeltEjectAccel*9.81))) then

            --             SetEntityCoords(player, position.x, position.y, position.z - 0.47, true, true, true)
            --             SetEntityVelocity(player, prevVelocity.x, prevVelocity.y, prevVelocity.z)
            --             SetPedToRagdoll(player, 1000, 1000, 0, 0, 0, 0)
            --         else
            --             -- Update previous velocity for ejecting player
            --             prevVelocity = GetEntityVelocity(vehicle)
            --         end
            --     else
            --     	DisableControlAction(0, 75)
            --     end

			-- end

			vehicleInfo = {
				action = 'updateVehicle',

				status = true,
				speed = vehicleSpeed,
				nail = vehicleNailSpeed,
				gear = vehicleGear,
				fuel = vehicleFuel,
				lights = vehicleIsLightsOn,
				signals = vehicleSignalIndicator,
				cruiser = vehicleCruiser,
				type = vehicleClass,
				siren = vehicleSiren,
				seatbelt = {},

				config = {
					speedUnit = Config.vehicle.speedUnit,
					maxSpeed = Config.vehicle.maxSpeed
				}
			}

			vehicleInfo['seatbelt']['status'] = seatbeltIsOn
		else

			vehicleCruiser = false
			vehicleNailSpeed = 0
			vehicleSignalIndicator = 'off'

            seatbeltIsOn = false

			vehicleInfo = {
				action = 'updateVehicle',

				status = false,
				nail = vehicleNailSpeed,
				seatbelt = { status = seatbeltIsOn },
				cruiser = vehicleCruiser,
				signals = vehicleSignalIndicator,
				type = 0,
			}

			if Config.ui.showMinimap == false then
				DisplayRadar(false)
			end

		end

		SendNUIMessage(vehicleInfo)
		Wait(time)
	end
end)


-- voz
Citizen.CreateThread(function()

	if Config.ui.showVoice == true then

	    RequestAnimDict('facials@gen_male@variations@normal')
	    RequestAnimDict('mp_facial')

	    while true do
	        Citizen.Wait(300)
	        local playerID = PlayerId()

	        for _,player in ipairs(GetActivePlayers()) do
	            local boolTalking = NetworkIsPlayerTalking(player)

	            if player ~= playerID then
	                if boolTalking then
	                    PlayFacialAnim(GetPlayerPed(player), 'mic_chatter', 'mp_facial')
	                elseif not boolTalking then
	                    PlayFacialAnim(GetPlayerPed(player), 'mood_normal_1', 'facials@gen_male@variations@normal')
	                end
	            end
	        end
	    end

	end
end)

Citizen.CreateThread(function()
	if Config.ui.showVoice == true then

		local isTalking = false
		local voiceDistance = nil

		while true do
			Citizen.Wait(150)

			if NetworkIsPlayerTalking(PlayerId()) and not isTalking then 
				isTalking = not isTalking
				SendNUIMessage({ action = 'isTalking', value = isTalking })
			elseif not NetworkIsPlayerTalking(PlayerId()) and isTalking then 
				isTalking = not isTalking
				SendNUIMessage({ action = 'isTalking', value = isTalking })
			end

			if IsControlJustPressed(1, Keys[Config.voice.keys.distance]) then

				Config.voice.levels.current = (Config.voice.levels.current + 1) % 3

				if Config.voice.levels.current == 0 then
					NetworkSetTalkerProximity(Config.voice.levels.default)
					voiceDistance = 'normal'
				elseif Config.voice.levels.current == 1 then
					NetworkSetTalkerProximity(Config.voice.levels.shout)
					voiceDistance = 'shout'
				elseif Config.voice.levels.current == 2 then
					NetworkSetTalkerProximity(Config.voice.levels.whisper)
					voiceDistance = 'whisper'
				end

				SendNUIMessage({ action = 'setVoiceDistance', value = voiceDistance })
			end

			if Config.voice.levels.current == 0 then
				voiceDistance = 'normal'
			elseif Config.voice.levels.current == 1 then
				voiceDistance = 'shout'
			elseif Config.voice.levels.current == 2 then
				voiceDistance = 'whisper'
			end

		end

	end
end)

-- local armas_skins = {}

-- Citizen.CreateThread(function()
-- 	local pegar_armas_skins = true
-- 	armas_skins = vSERVER.getArmasSkins()
	
-- 	if armas_skins ~= nil then 
-- 		if #armas_skins > 0 then 
-- 			pegar_armas_skins = false
-- 		end
-- 	end
-- 	Wait(1000)
	
-- end)

-- armas


-----------------------------------------------------------------------------------------------------------------------------------------
-- WEAPONTYPES
-----------------------------------------------------------------------------------------------------------------------------------------
local weapon_types = {"WEAPON_KNIFE", "WEAPON_HATCHET", "WEAPON_BAT", "WEAPON_BATTLEAXE", "WEAPON_BOTTLE",
                      "WEAPON_CROWBAR", "WEAPON_DAGGER", "WEAPON_GOLFCLUB", "WEAPON_HAMMER", "WEAPON_MACHETE",
                      "WEAPON_POOLCUE", "WEAPON_STONE_HATCHET", "WEAPON_SWITCHBLADE", "WEAPON_WRENCH", "WEAPON_KNUCKLE",
                      "WEAPON_FLASHLIGHT", "WEAPON_NIGHTSTICK", "WEAPON_RPG", "WEAPON_RAYPISTOL", "WEAPON_PISTOL",
                      "WEAPON_PISTOL_MK2", "WEAPON_COMPACTRIFLE", "WEAPON_APPISTOL", "WEAPON_HEAVYPISTOL",
                      "WEAPON_MACHINEPISTOL", "WEAPON_MICROSMG", "WEAPON_MINISMG", "WEAPON_SNSPISTOL",
                      "WEAPON_SNSPISTOL_MK2", "WEAPON_VINTAGEPISTOL", "WEAPON_PISTOL50", "WEAPON_REVOLVER",
                      "WEAPON_COMBATPISTOL", "WEAPON_CARBINERIFLE", "WEAPON_PUMPSHOTGUN", "WEAPON_SAWNOFFSHOTGUN",
                      "WEAPON_SMG", "WEAPON_ASSAULTRIFLE", "WEAPON_ASSAULTRIFLE_MK2", "WEAPON_ASSAULTSMG",
                      "WEAPON_GUSENBERG", "WEAPON_PETROLCAN", "GADGET_PARACHUTE", "WEAPON_STUNGUN", "WEAPON_MUSKET",
                      "WEAPON_FIREEXTINGUISHER", "WEAPON_AKPARTEN", "WEAPON_AKYE", "WEAPON_AKMark", "WEAPON_AKTOE",
                      "WEAPON_AKWH", "WEAPON_AKWHITE", "WEAPON_AKWHITEB", "WEAPON_ASSAULTRIFLE_AA",
                      "WEAPON_ASSAULTRIFLE_AB", "WEAPON_ASSAULTRIFLE_AC", "WEAPON_ASSAULTRIFLE_AD",
                      "WEAPON_ASSAULTRIFLE_AE", "WEAPON_ASSAULTRIFLE_AF", "WEAPON_ASSAULTRIFLE_AG",
                      "WEAPON_ASSAULTRIFLE_AH", "WEAPON_ASSAULTRIFLE_AI", "WEAPON_ASSAULTRIFLE_AJ",
                      "WEAPON_ASSAULTRIFLE_AK", "WEAPON_ASSAULTRIFLE_AL", "WEAPON_ASSAULTRIFLE_AM",
                      "WEAPON_ASSAULTRIFLE_AN", "WEAPON_ASSAULTRIFLE_AO", "WEAPON_ASSAULTRIFLE_AP",
                      "WEAPON_ASSAULTRIFLE_AQ", "WEAPON_ASSAULTRIFLE_AR", "WEAPON_ASSAULTRIFLE_AS",
                      "WEAPON_ASSAULTRIFLE_AT", "WEAPON_M4COLT", "WEAPON_M4DK", "WEAPON_DRAGON", "WEAPON_M4GR",
                      "WEAPON_GRAU", "WEAPON_HAZARD", "WEAPON_HUNTER", "WEAPON_TECH", "WEAPON_ZEBRA", "WEAPON_M4A1_BL",
                      "WEAPON_M4AM", "WEAPON_M4W", "WEAPON_M4_AA", "WEAPON_M4_AB", "WEAPON_M4_AC", "WEAPON_M4_AD",
                      "WEAPON_M4_AE", "WEAPON_M4_AF", "WEAPON_M4_AG", "WEAPON_M4_AH", "WEAPON_M4_AI", "WEAPON_M4_AJ",
                      "WEAPON_M4_AK", "WEAPON_M4_AL", "WEAPON_M4_AN", "WEAPON_M4_AO", "WEAPON_M4_AP", "WEAPON_M4_AQ",
                      "WEAPON_M4_AR", "WEAPON_M4_AS", "WEAPON_M4_AT", "WEAPON_PISTOL_MK2_AA", "WEAPON_PISTOL_MK2_AB",
                      "WEAPON_PISTOL_MK2_AC", "WEAPON_PISTOL_MK2_AD", "WEAPON_PISTOL_MK2_AE", "WEAPON_PISTOL_MK2_AF",
                      "WEAPON_PISTOL_MK2_AH", "WEAPON_PISTOL_MK2_AI", "WEAPON_PISTOL_MK2_AJ", "WEAPON_PISTOL_MK2_AK",
                      "WEAPON_PISTOL_MK2_AL", "WEAPON_PISTOL_MK2_AM", "WEAPON_PISTOL_MK2_AN", "WEAPON_PISTOL_MK2_AO",
                      "WEAPON_PISTOL_MK2_AP", "WEAPON_PISTOL_MK2_AQ", "WEAPON_PISTOL_MK2_AR", "WEAPON_PISTOL_MK2_AS",
                      "WEAPON_PISTOL_MK2_AT", "WEAPON_WPISTOL", "WEAPON_COMBATPISTOL_BO", "WEAPON_COMBATPISTOL_BP",
                      "WEAPON_COMBATPISTOL_BQ", "WEAPON_COMBATPISTOL_BR", "WEAPON_COMBATPISTOL_BT",
                      "WEAPON_COMBATPISTOL_BU", "WEAPON_COMBATPISTOL_BV", "WEAPON_COMBATPISTOL_BW",
                      "WEAPON_COMBATPISTOL_BX", "WEAPON_COMBATPISTOL_BY", "WEAPON_COMBATPISTOL_BZ",
                      "WEAPON_COMBATPISTOL_CA", "WEAPON_COMBATPISTOL_CB", "WEAPON_COMBATPISTOL_CC",
                      "WEAPON_COMBATPISTOL_CD", "WEAPON_COMBATPISTOL_CE", "WEAPON_COMBATPISTOL_CF",
                      "WEAPON_COMBATPISTOL_CG", "WEAPON_COMBATPISTOL_CH", "WEAPON_COMBATPISTOL_CI",
                      "WEAPON_COMBATPISTOL_AA", "WEAPON_COMBATPISTOL_AB", "WEAPON_COMBATPISTOL_AC",
                      "WEAPON_COMBATPISTOL_AD", "WEAPON_COMBATPISTOL_AE", "WEAPON_COMBATPISTOL_AF",
                      "WEAPON_COMBATPISTOL_AG", "WEAPON_COMBATPISTOL_AH", "WEAPON_COMBATPISTOL_AI",
                      "WEAPON_COMBATPISTOL_AJ", "WEAPON_COMBATPISTOL_AK", "WEAPON_COMBATPISTOL_AL",
                      "WEAPON_COMBATPISTOL_AM", "WEAPON_COMBATPISTOL_AN", "WEAPON_COMBATPISTOL_AO",
                      "WEAPON_COMBATPISTOL_AP", "WEAPON_COMBATPISTOL_AQ", "WEAPON_COMBATPISTOL_AR",
                      "WEAPON_COMBATPISTOL_AS", "WEAPON_COMBATPISTOL_AT", "WEAPON_COMBATPISTOL_AU",
                      "WEAPON_COMBATPISTOL_AV", "WEAPON_COMBATPISTOL_AW", "WEAPON_COMBATPISTOL_AX",
                      "WEAPON_COMBATPISTOL_AY", "WEAPON_COMBATPISTOL_AZ", "WEAPON_COMBATPISTOL_BA",
                      "WEAPON_COMBATPISTOL_BB", "WEAPON_COMBATPISTOL_BC", "WEAPON_COMBATPISTOL_BD",
                      "WEAPON_COMBATPISTOL_BE", "WEAPON_COMBATPISTOL_BF", "WEAPON_COMBATPISTOL_BG",
                      "WEAPON_COMBATPISTOL_BH", "WEAPON_COMBATPISTOL_BI", "WEAPON_COMBATPISTOL_BJ",
                      "WEAPON_COMBATPISTOL_BK", "WEAPON_COMBATPISTOL_BL", "WEAPON_COMBATPISTOL_BM",
                      "WEAPON_COMBATPISTOL_BN"}

--vSERVER.getArmaHud()


Citizen.CreateThread(function()
	if Config.ui.showWeapons == true then
		while true do
			Citizen.Wait(250)

			local player = GetPlayerPed(-1)
			local status = {}

			status.show = false

			if IsPedArmed(player, 7) then

				local weapon = GetSelectedPedWeapon(player)
				local ammoTotal = GetAmmoInPedWeapon(player,weapon)
				local bool,ammoClip = GetAmmoInClip(player,weapon)
				local ammoRemaining = math.floor(ammoTotal - ammoClip)
				
				status.show = true

				for key,value in pairs(weapon_types) do
										
						if weapon == GetHashKey(value) then

							status['weapon'] = value

							if key == 'melee' then
								SendNUIMessage({ action = 'element', task = 'disable', value = 'weapon_bullets' })
								SendNUIMessage({ action = 'element', task = 'disable', value = 'bullets' })
							else
								if keyTwo == 'stungun' then
									SendNUIMessage({ action = 'element', task = 'disable', value = 'weapon_bullets' })
									SendNUIMessage({ action = 'element', task = 'disable', value = 'bullets' })
								else
									SendNUIMessage({ action = 'element', task = 'enable', value = 'weapon_bullets' })
									SendNUIMessage({ action = 'element', task = 'enable', value = 'bullets' })
								end
							end

						end
					

				end

				SendNUIMessage({ action = 'setText', id = 'weapon_clip', value = ammoClip })
				SendNUIMessage({ action = 'setText', id = 'weapon_ammo', value = ammoRemaining })

			end

			SendNUIMessage({ action = 'updateWeapon', status = status })

		end
	end
end)



-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBELT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if beltLock >= 1 then
			DisableControlAction(1,75,true)
		end
		Citizen.Wait(1)
	end
end)


Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		if playerActive then
			local ped = PlayerPedId()
			if IsPedInAnyVehicle(ped) then
				if not IsPedOnAnyBike(ped) and not IsPedInAnyHeli(ped) and not IsPedInAnyPlane(ped) then
					timeDistance = 1

					local vehicle = GetVehiclePedIsUsing(ped)
					local speed = GetEntitySpeed(vehicle) * 3.6
					if speed ~= beltSpeed then
						local plate = GetVehicleNumberPlateText(vehicle)

						if ((beltSpeed - speed) >= 50 and beltLock == 0) or ((beltSpeed - speed) >= 75 and beltLock == 0 and hardness[plate] == nil and GetPedInVehicleSeat(vehicle,-1) == ped) then
							local fowardVeh = fowardPed(ped)
							local coords = GetEntityCoords(ped)
							SetEntityCoords(ped,coords["x"] + fowardVeh["x"],coords["y"] + fowardVeh["y"],coords["z"] + 1,1,0,0,0)
							SetEntityVelocity(ped,beltVelocity["x"],beltVelocity["y"],beltVelocity["z"])
							ApplyDamageToPed(ped,50,false)

							Citizen.Wait(1)

							SetPedToRagdoll(ped,5000,5000,0,0,0,0)
						end

						beltVelocity = GetEntityVelocity(vehicle)
						beltSpeed = speed
					end
				end
			else
				if beltSpeed ~= 0 then
					beltSpeed = 0
				end

				if beltLock == 1 then
					beltLock = 0
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATBELT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("seatbelt",function(source,args)
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		if not IsPedOnAnyBike(ped) then
			if beltLock == 1 then
				TriggerEvent("sounds:source","unbelt",0.5)
				beltLock = 0
				seatbeltIsOn = false
			else
				TriggerEvent("sounds:source","belt",0.5)
				beltLock = 1
				seatbeltIsOn = true
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("seatbelt","Colocar/Retirar o cinto.","keyboard","g")




-- Everything that neededs to be at WAIT 0
Citizen.CreateThread(function()

	while true do
		local tempo = 1000

		local player = GetPlayerPed(-1)
		local vehicle = GetVehiclePedIsIn(player, false)
		local vehicleClass = GetVehicleClass(vehicle)
		
		if IsPedInAnyVehicle(player) then 
			tempo = 5
		end
		-- Vehicle Seatbelt
		-- if IsPedInAnyVehicle(player, false) and GetIsVehicleEngineRunning(vehicle) then
		-- 	if IsControlJustReleased(0, Keys[Config.vehicle.keys.seatbelt]) and (has_value(vehiclesCars, vehicleClass) == true and vehicleClass ~= 8) then
		-- 		seatbeltIsOn = not seatbeltIsOn

		-- 		if beltLock == 0 then 
		-- 			beltLock = 1 
		-- 		else 
		-- 			beltLock = 0
		-- 		end

		-- 	end
		-- end

		-- Vehicle Cruiser
		if IsControlJustPressed(1, Keys[Config.vehicle.keys.cruiser]) and GetPedInVehicleSeat(vehicle, -1) == player and (has_value(vehiclesCars, vehicleClass) == true) then
			
			local vehicleSpeedSource = GetEntitySpeed(vehicle)

			if vehicleCruiser == 'on' then
				vehicleCruiser = 'off'
				SetEntityMaxSpeed(vehicle, GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel"))
				
			else
				vehicleCruiser = 'on'
				SetEntityMaxSpeed(vehicle, vehicleSpeedSource)
			end
		end


		-- Vehicle Signal Lights
		if IsControlJustPressed(1, Keys[Config.vehicle.keys.signalLeft]) and (has_value(vehiclesCars, vehicleClass) == true) then
			if vehicleSignalIndicator == 'off' then
				vehicleSignalIndicator = 'left'
			else
				vehicleSignalIndicator = 'off'
			end

			TriggerEvent('trew_hud_ui:setCarSignalLights', vehicleSignalIndicator)
		end

		if IsControlJustPressed(1, Keys[Config.vehicle.keys.signalRight]) and (has_value(vehiclesCars, vehicleClass) == true) then
			if vehicleSignalIndicator == 'off' then
				vehicleSignalIndicator = 'right'
			else
				vehicleSignalIndicator = 'off'
			end

			TriggerEvent('trew_hud_ui:setCarSignalLights', vehicleSignalIndicator)
		end

		if IsControlJustPressed(1, Keys[Config.vehicle.keys.signalBoth]) and (has_value(vehiclesCars, vehicleClass) == true) then
			if vehicleSignalIndicator == 'off' then
				vehicleSignalIndicator = 'both'
			else
				vehicleSignalIndicator = 'off'
			end

			TriggerEvent('trew_hud_ui:setCarSignalLights', vehicleSignalIndicator)
		end

		Wait(tempo)
	end
end)

RegisterCommand("mh",function(source,args)
	SendNUIMessage({ action = 'ui', config = Config.ui })

	if Config.ui.showVoice == true then
		if Config.voice.levels.current == 0 then
			NetworkSetTalkerProximity(Config.voice.levels.default)
		elseif Config.voice.levels.current == 1 then
			NetworkSetTalkerProximity(Config.voice.levels.shout)
		elseif Config.voice.levels.current == 2 then
			NetworkSetTalkerProximity(Config.voice.levels.whisper)
		end
	end
end)



AddEventHandler('onClientMapStart', function()

	SendNUIMessage({ action = 'ui', config = Config.ui })
	
	if Config.ui.showVoice == true then
		if Config.voice.levels.current == 0 then
			NetworkSetTalkerProximity(Config.voice.levels.default)
		elseif Config.voice.levels.current == 1 then
			NetworkSetTalkerProximity(Config.voice.levels.shout)
		elseif Config.voice.levels.current == 2 then
			NetworkSetTalkerProximity(Config.voice.levels.whisper)
		end
	end
end)

AddEventHandler('playerSpawned', function()

	SendNUIMessage({ action = 'ui', config = Config.ui })


	if Config.ui.showVoice == true then
	    NetworkSetTalkerProximity(5.0)
	end

	HideHudComponentThisFrame(7) -- Area
	HideHudComponentThisFrame(9) -- Street
	HideHudComponentThisFrame(6) -- Vehicle
	HideHudComponentThisFrame(3) -- SP Cash
	HideHudComponentThisFrame(4) -- MP Cash
	HideHudComponentThisFrame(13) -- Cash changes!
end)

function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end






AddEventHandler('trew_hud_ui:setCarSignalLights', function(status)

	local ped = GetPlayerPed(-1)

	local vehicle = GetVehiclePedIsUsing(ped)
	local leftLight = false
	local rightLight = false

	if status == 'left' then
		leftLight = false
		rightLight = true

	elseif status == 'right' then
		leftLight = true
		rightLight = false

	elseif status == 'both' then
		leftLight = true
		rightLight = true

	else
		leftLight = false
		rightLight = false

	end

	TriggerServerEvent('trew_hud_ui:syncCarLights', status)

	SetVehicleIndicatorLights(vehicle, 0, leftLight)
	SetVehicleIndicatorLights(vehicle, 1, rightLight)
end)



RegisterNetEvent('trew_hud_ui:syncCarLights')
AddEventHandler('trew_hud_ui:syncCarLights', function(driver, status)

	if GetPlayerFromServerId(driver) ~= PlayerId() then
		local driver = GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(driver)), false)

		if status == 'left' then
			leftLight = false
			rightLight = true

		elseif status == 'right' then
			leftLight = true
			rightLight = false

		elseif status == 'both' then
			leftLight = true
			rightLight = true

		else
			leftLight = false
			rightLight = false
		end

		SetVehicleIndicatorLights(driver, 0, leftLight)
		SetVehicleIndicatorLights(driver, 1, rightLight)

	end
end)




-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVESCUBA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("monkey_hud:removeScuba")
AddEventHandler("monkey_hud:removeScuba",function()
	local ped = PlayerPedId()
	if DoesEntityExist(divingMask) or DoesEntityExist(divingTank) then
		if DoesEntityExist(divingMask) then
			TriggerServerEvent("tryDeleteEntity",NetworkGetNetworkIdFromEntity(divingMask))
			divingMask = nil
		end

		if DoesEntityExist(divingTank) then
			TriggerServerEvent("tryDeleteEntity",NetworkGetNetworkIdFromEntity(divingTank))
			divingTank = nil
		end

		SetEnableScuba(ped,false)
		--SetPedMaxTimeUnderwater(ped,10.0)
		is_roupa_mergulho = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:SETDIVING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("monkey_hud:setDiving")
AddEventHandler("monkey_hud:setDiving",function()
	local ped = PlayerPedId() 

	if DoesEntityExist(divingMask) or DoesEntityExist(divingTank) then
		if DoesEntityExist(divingMask) then
			TriggerServerEvent("tryDeleteEntity",NetworkGetNetworkIdFromEntity(divingMask))
			TriggerServerEvent("tryDeleteEntity",ObjToNet(divingMask))
			divingMask = nil
		end

		if DoesEntityExist(divingTank) then
			TriggerServerEvent("tryDeleteEntity",NetworkGetNetworkIdFromEntity(divingTank))
			TriggerServerEvent("tryDeleteEntity",ObjToNet(divingTank))
			divingTank = nil
		end

		SetEnableScuba(ped,false)
		is_roupa_mergulho = false
		--SetPedMaxTimeUnderwater(ped,10.0)
	else
		local maskModel = GetHashKey("p_s_scuba_mask_s")
		local tankModel = GetHashKey("p_s_scuba_tank_s")

		RequestModel(tankModel)
		while not HasModelLoaded(tankModel) do
			Citizen.Wait(1)
		end

		RequestModel(maskModel)
		while not HasModelLoaded(maskModel) do
			Citizen.Wait(1)
		end

		if HasModelLoaded(tankModel) then
			divingTank = CreateObject(tankModel,1.0,1.0,1.0,true,true,false)
			AttachEntityToEntity(divingTank,ped,GetPedBoneIndex(ped,24818),-0.28,-0.24,0.0,180.0,90.0,0.0,1,1,0,0,2,1)
			SetEntityAsMissionEntity(divingTank,true,true)
			SetModelAsNoLongerNeeded(divingTank)
		end

		if HasModelLoaded(maskModel) then
			divingMask = CreateObject(maskModel,1.0,1.0,1.0,true,true,false)
			AttachEntityToEntity(divingMask,ped,GetPedBoneIndex(ped,12844),0.0,0.0,0.0,180.0,90.0,0.0,1,1,0,0,2,1)
			SetEntityAsMissionEntity(divingMask,true,true)
			SetModelAsNoLongerNeeded(divingMask)
		end

		SetEnableScuba(ped,true)
		--SetPedMaxTimeUnderwater(ped,2000.0)
		is_roupa_mergulho = true
	end
end)



RegisterNUICallback('salvarPadrao', function(data, cb)
	vSERVER.salvarParaTodos(data)
	cb("")
end)

RegisterNUICallback('getPadraoHud', function(data, cb)
	cb(vSERVER.getPadraoHud())
end)
