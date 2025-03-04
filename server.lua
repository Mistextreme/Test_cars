-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRP = Proxy.getInterface("vRP") 
vRPclient = Tunnel.getInterface("vRP")

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("hud",cRP)  
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local hours = 8
local minutes = 0
local weather = 2
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNC : COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("noite",function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)

	if vRP.hasPermission(user_id,"owner") or vRP.hasPermission(user_id,"coo") or vRP.hasPermission(user_id,"cto") or vRP.hasPermission(user_id,"administrador") or vRP.hasPermission(user_id,"moderador") then
		minutes = parseInt(00)
		hours = parseInt(00)
		TriggerClientEvent("hud:syncTimers",-1,{ minutes,hours },weather)
	end	
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNC : COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("dia",function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)

	if vRP.hasPermission(user_id,"owner") or vRP.hasPermission(user_id,"coo") or vRP.hasPermission(user_id,"cto") or vRP.hasPermission(user_id,"administrador") or vRP.hasPermission(user_id,"moderador") then
		minutes = parseInt(00)
		hours = parseInt(12)
		TriggerClientEvent("hud:syncTimers",-1,{ minutes,hours },weather)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNC : COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hora",function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	
	if vRP.hasPermission(user_id,"owner") or vRP.hasPermission(user_id,"coo") or vRP.hasPermission(user_id,"cto") or vRP.hasPermission(user_id,"administrador") or vRP.hasPermission(user_id,"moderador") then
		if args[1] and args[2] then
			hours = parseInt(args[1])
			minutes = parseInt(args[2])
			TriggerClientEvent("hud:syncTimers",-1,{ minutes,hours },weather)
		else
			TriggerClientEvent('Notify', source, 'vermelho', 'Utilize: /hora horas minutos')
		end
	end
end)

--------------------------------------------------------------------------------------------------------------------------------
-- SYNC : CLIMA
--------------------------------------------------------------------------------------------------------------------------------

RegisterCommand('clima', function(source, args)

	local source = source
	local user_id = vRP.getUserId(source)

    if args[1] then
        weather = parseInt(args[1])
		if vRP.hasPermission(user_id,"owner") or vRP.hasPermission(user_id,"coo") or vRP.hasPermission(user_id,"cto") or vRP.hasPermission(user_id,"administrador") or vRP.hasPermission(user_id,"moderador") then
			if weather > 0 then

				TriggerClientEvent("hud:syncTimers",-1,{ minutes,hours },weather)
					
				TriggerClientEvent('Notify', source,  'verde', 'Você mudou o clima.',9000)
			end
		end
    end
	
end)


-- RegisterCommand('diminuirFomeEsede', function(source, args)

-- 	local source = source
-- 	local user_id = vRP.getUserId(source)

-- 	TriggerClientEvent("statusHunger",source,20)
-- 	TriggerClientEvent("statusThirst",source,20)

-- end)





-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do

		local time_tempo = 3000 

		if hours >= 8 and hours <= 18 then 
			time_tempo = 6000
		end

		minutes = minutes + 1
		if minutes >= 60 then
			minutes = 0
			hours = hours + 1
			if hours >= 24 then
				hours = 0
			end
		end

		--TriggerClientEvent("hud:syncTimers",-1,{ minutes,hours },weather)

		Citizen.Wait(time_tempo)
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	TriggerClientEvent("hud:syncTimers",source,{ minutes,hours },weather)
end)


-- local Config = module('trew_hud_ui', 'config')
-- local Locales = module('trew_hud_ui', 'locales/languages')

function _U(entry)
	return Locales[ Config.Locale ][entry] 
end

RegisterServerEvent('trew_hud_ui:getServerInfo')
AddEventHandler('trew_hud_ui:getServerInfo', function()

	local source = source
	local playerID = vRP.getUserId(source)

	local info = {
		hunger = vRP.getHunger(playerID),
		thirst = vRP.getThirst(playerID),

		job = vRP.getUserGroupByType(playerID, 'job'),

		money = vRP.getMoney(playerID),
		bankMoney = vRP.getBankMoney(playerID),
		blackMoney = vRP.getInventoryItemAmount(playerID, Config.vRP.items.blackMoney)
	}
	
	TriggerClientEvent('trew_hud_ui:setInfo', source, info)
end)

RegisterServerEvent('trew_hud_ui:syncCarLights')
AddEventHandler('trew_hud_ui:syncCarLights', function(status)
	TriggerClientEvent('trew_hud_ui:syncCarLights', -1, source, status)
end)


-- vRP.prepare("monkey_select_armas_loja_hud","SELECT * FROM monkey_armas_mod")

-- function cRP.getArmasSkins()
-- 	return vRP.query("monkey_select_armas_loja_hud")
-- end

-- function cRP.getArmaHud()

-- 	local uweapons = vRPclient.getWeapons(source)

-- 	local weaponuse = nil
			
-- 	for k,v in pairs(uweapons) do
-- 		if itemName == vRP.itemAmmoList(k) then
-- 			weaponuse = k
-- 		end
-- 	end

-- 	return weaponuse
-- end

vRP.prepare("java_hud:update", "UPDATE vrp_srv_data SET dvalue=@d WHERE dkey='java_hud_padrao_todos';")
vRP.prepare("java_hud:select", "SELECT dvalue FROM vrp_srv_data where dkey='java_hud_padrao_todos';")
vRP.prepare("java_hud:insert", "INSERT INTO vrp_srv_data (dkey, dvalue) VALUES('java_hud_padrao_todos', @d);")


function cRP.salvarParaTodos(data)

	local source = source
	local user_id = vRP.getUserId(source)

	if vRP.numPermission("admin") then 

		local rows = vRP.query("java_hud:select")

		if #rows > 0 then
			vRP.execute("java_hud:update", { d =  json.encode(data)  })
		else
			vRP.execute("java_hud:insert", { d =  json.encode(data) })
		end

		TriggerClientEvent("Notify",source,"aviso","Sua Hud foi definida para todos players que entrarem na cidade",15000)

	else
		TriggerClientEvent("Notify",source,"aviso","Acesso NEGADO!",8000)
	end
	
end


function cRP.getPadraoHud()

	local rows = vRP.query("java_hud:select")

	if #rows > 0 then 
		return rows[1].dvalue
	else
		return ""
	end

end
