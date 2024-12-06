BattleRoyale = {}

local Players = {}
local Participantes = {}
local idtimer = -1
local timer = nil
local started = false
local ComandoOn = false
local timer_check = nil
local timer_finish = nil
local timer_vivos = nil
local timer_vivos2 = nil
local gm = ''
local timer_hp = nil
local timer_hp2 = nil
local timer_areaprotegida = nil
local timer_areaprotegida2 = nil
local timer_areaprotegida3 = nil
local dropCount = 0
local dropStep = 1

function BattleRoyale.Init()
--[[
	if GetServerName() ~= "King" then
		LogAddC(4, string.format("Battle Royale não foi licenciado para %s", GetServerName()))
		Timer.TimeOut(20, os.exit)
		return
	end
	]]
	if BattleRoyale_SWITCH ~= 1 then
		return
	end
	
	Commands.Register(BattleRoyale_COMANDO_ABRIR, BattleRoyale.CommandOpen)
	Commands.Register(BattleRoyale_COMANDO_IR, BattleRoyale.CommandGo)
	GameServerFunctions.PlayerDie(BattleRoyale.Morte)
	GameServerFunctions.PlayerLogout(BattleRoyale.PlayerLeft)

	for i in ipairs(EVENT_BattleRoyale) do
		if EVENT_BattleRoyale[i]._DayOfWeek ~= -1
		then
			Schedule.SetDayOfWeek(EVENT_BattleRoyale[i]._DayOfWeek, EVENT_BattleRoyale[i]._Hour, EVENT_BattleRoyale[i]._Minute, BattleRoyale.CommandOpen_Auto)
		elseif EVENT_BattleRoyale[i]._Day ~= -1
		then
			Schedule.SetDayAndHourAndMinute(EVENT_BattleRoyale[i]._Day, EVENT_BattleRoyale[i]._Hour, EVENT_BattleRoyale[i]._Minute, BattleRoyale.CommandOpen_Auto)
		else
			Schedule.SetHourAndMinute(EVENT_BattleRoyale[i]._Hour, EVENT_BattleRoyale[i]._Minute, BattleRoyale.CommandOpen_Auto)
		end
	end	
end

function BattleRoyale.CommandOpen_Auto()
	timer_check = nil
	timer_finish = nil
	timer_vivos = nil
	timer_vivos2 = nil
	gm = ''

	Players = {}
	Participantes = {}
	math.randomseed(os.clock()*os.time()/GetTick())
	timer = BattleRoyale_TIMER_OPEN
		
	started = false
	ComandoOn = true
	
	
	idtimer = Timer.Repeater(1, timer, BattleRoyale.Running)
	
	Message.SendMessageGlobalMultLang(BattleRoyale_Message, 1, 0)
end

function BattleRoyale.CheckUser()
	if started == false
	then
		return
	end

	for i, name in ipairs(Participantes) do 
		local index = Participantes[name].Index
		local player = User.new(index)
		local NickRemover = player:getName()
			
		if player:getConnected() ~= 3
		then
			BattleRoyale.RemoveUser(i)
			BattleRoyale.CheckVivos()
		end
		
		if player:getMapNumber() ~= BattleRoyale_MapNumber
		then
			SendMessage(BattleRoyale_Message[player:getLanguage()][2], index, 1)
				if BattleRoyale_ResetStats then
					player:setStrength(Participantes[name].Str)
					player:setDexterity(Participantes[name].Agi)
					player:setVitality(Participantes[name].Vit)
					player:setEnergy(Participantes[name].Ene)
					player:setLeaderShip(Participantes[name].Cmd)
					player:setLevelUpPoint(Participantes[name].Points)
					LevelUpSend(Participantes[name].Index)
					RefreshCharacter(Participantes[name].Index)
					CalCharacter(Participantes[name].Index)
				end
		
				if BattleRoyale_ResetSkillTree then
					player:setMasterPoint(Participantes[name].MPoints)
					LevelUpSend(Participantes[name].Index)
					MasterLevelInfoSend(Participantes[name].Index)
					RefreshCharacter(Participantes[name].Index)
					CalCharacter(Participantes[name].Index)
				end

				local pInv = Inventory.new(Participantes[name].Index)
				for slot = 0, 139 do
					if pInv:isItem(slot) ~= 0 then
						InventoryDeleteItem(Participantes[name].Index, slot)
						SendInventoryDeleteItem(Participantes[name].Index, slot)
					end
				end
				for slot = 204, 235 do
					if pInv:isItem(slot) ~= 0 then
						InventoryDeleteItem(Participantes[name].Index, slot)
						SendInventoryDeleteItem(Participantes[name].Index, slot)
					end
				end
				RefreshCharacter(Participantes[name].Index)
				ItemListSend(Participantes[name].Index)

				if BattleRoyale_ResetSkills then
					local class = player:getClass()
				
					for m in ipairs(BattleRoyale_ReturnSkills[class]) do
						local item = BattleRoyale_ReturnSkills[class][m]
						ItemSerialCreate(Participantes[name].Index, 236, 0, 0, GET_ITEM(item.Section, item.ID), 0, 0, 0, 0, 0, 0)
					end
				end
			
				ItemListSend(Participantes[name].Index)
			BattleRoyale.RemoveUser(NickRemover)
			BattleRoyale.CheckVivos()
		else
			if player:getX() >= BattleRoyale_PvpArea.X1 and player:getX() <= BattleRoyale_SafeArea.X2 and player:getY() >= BattleRoyale_PvpArea.Y1 or player:getY() <= BattleRoyale_SafeArea.Y2 then
			
			else
				SendMessage(BattleRoyale_Message[player:getLanguage()][2], index, 1)
					if BattleRoyale_ResetStats then
						player:setStrength(Participantes[name].Str)
						player:setDexterity(Participantes[name].Agi)
						player:setVitality(Participantes[name].Vit)
						player:setEnergy(Participantes[name].Ene)
						player:setLeaderShip(Participantes[name].Cmd)
						player:setLevelUpPoint(Participantes[name].Points)
						LevelUpSend(Participantes[name].Index)
						RefreshCharacter(Participantes[name].Index)
						CalCharacter(Participantes[name].Index)
					end
			
					if BattleRoyale_ResetSkillTree then
						player:setMasterPoint(Participantes[name].MPoints)
						LevelUpSend(Participantes[name].Index)
						MasterLevelInfoSend(Participantes[name].Index)
						RefreshCharacter(Participantes[name].Index)
						CalCharacter(Participantes[name].Index)
					end

					local pInv = Inventory.new(Participantes[name].Index)
				for slot = 0, 139 do
					if pInv:isItem(slot) ~= 0 then
						InventoryDeleteItem(Participantes[name].Index, slot)
						SendInventoryDeleteItem(Participantes[name].Index, slot)
					end
				end
				RefreshCharacter(Participantes[name].Index)
				ItemListSend(Participantes[name].Index)

				if BattleRoyale_ResetSkills then
					local class = player:getClass()
				
					for m in ipairs(BattleRoyale_ReturnSkills[class]) do
						local item = BattleRoyale_ReturnSkills[class][m]
						ItemSerialCreate(Participantes[name].Index, 236, 0, 0, GET_ITEM(item.Section, item.ID), 0, 0, 0, 0, 0, 0)
					end
				end
			
				ItemListSend(Participantes[name].Index)
				Teleport(index, 0, 125, 125)
				BattleRoyale.RemoveUser(NickRemover)
				BattleRoyale.CheckVivos()
			end
		end		
	end
end

function BattleRoyale.CheckBau(nome)
	if not started then return false end
	
	for i, name in ipairs(Participantes) do 
		if nome == name then
			return true
		end
	end
	
	return false
end

function BattleRoyale.TirarHP()
	if started == false
	then
		return
	end
	
	SendMessageGlobal(string.format(" "), 0)
	Message.SendMessageGlobalMultLang(BattleRoyale_Message, 3, 0)
	Message.SendMessageGlobalMultLangArgs(BattleRoyale_Message, 3, 0, BattleRoyale_PvpCentro.X, BattleRoyale_PvpCentro.Y)
	
	timer_hp2 = Timer.Interval(3, BattleRoyale.TirarHP2)
end

function BattleRoyale.TirarHP2()
	if started == false
	then
		return
	end

	for i, name in ipairs(Participantes) do 
		local index = Participantes[name].Index
		local player = User.new(index)
		local NickRemover = player:getName()
			
		if player:getMapNumber() == BattleRoyale_MapNumber
		then
			if player:getX() >= BattleRoyale_PvpCentro.X-3 and player:getX() <= BattleRoyale_PvpCentro.X+3 and player:getY() >= BattleRoyale_PvpCentro.Y-3 and player:getY() <= BattleRoyale_PvpCentro.Y+3 then
				
			else				
				SendMessage(string.format(BattleRoyale_Message[player:getLanguage()][5], BattleRoyale_PvpCentro.X, BattleRoyale_PvpCentro.Y), 1)
				player:setAddLife((math.floor(player:getAddLife() - 5000)))
				LifeUpdate(index, player:getAddLife())
			end
		end
		
	end
			
			
end

function BattleRoyale.AreaProtegida()
	if started == false
	then
		return
	end
	
		
	SendMessageGlobal(string.format(" "), 0)
	Message.SendMessageGlobalMultLang(BattleRoyale_Message, 6, 0)
	Message.SendMessageGlobalMultLang(BattleRoyale_Message, 7, 0)
	Message.SendMessageGlobalMultLangArgs(BattleRoyale_Message, 8, 0, BattleRoyale_PvpCentro.X, BattleRoyale_PvpCentro.Y)
	

	timer_areaprotegida2 = Timer.TimeOut(30, BattleRoyale.AreaProtegida2)
end

function BattleRoyale.AreaProtegida2()
	if started == false
	then
		return
	end
	
	timer_areaprotegida3 = Timer.Interval(1, BattleRoyale.AreaProtegida3)	
end

function BattleRoyale.AreaProtegida3()
	if started == false
	then
		return
	end

	for i, name in ipairs(Participantes) do 
		local index = Participantes[name].Index
		local player = User.new(index)
		local NickRemover = player:getName()
			
		if player:getMapNumber() == BattleRoyale_MapNumber then
			if player:getX() >= BattleRoyale_SafeArea.X1 and player:getX() <= BattleRoyale_SafeArea.X2 and player:getY() >= BattleRoyale_SafeArea.Y1 and player:getY() <= BattleRoyale_SafeArea.Y2 then
				SendMessage(BattleRoyale_Message[player:getLanguage()][9], index, 1)
				Message.SendMessageGlobalMultLangArgs(BattleRoyale_Message, 10, 0, NickRemover)
				if BattleRoyale_ResetStats then
					player:setStrength(Participantes[name].Str)
					player:setDexterity(Participantes[name].Agi)
					player:setVitality(Participantes[name].Vit)
					player:setEnergy(Participantes[name].Ene)
					player:setLeaderShip(Participantes[name].Cmd)
					player:setLevelUpPoint(Participantes[name].Points)
					LevelUpSend(Participantes[name].Index)
					RefreshCharacter(Participantes[name].Index)
					CalCharacter(Participantes[name].Index)
				end
		
				if BattleRoyale_ResetSkillTree then
					player:setMasterPoint(Participantes[name].MPoints)
					LevelUpSend(Participantes[name].Index)
					MasterLevelInfoSend(Participantes[name].Index)
					RefreshCharacter(Participantes[name].Index)
					CalCharacter(Participantes[name].Index)
				end

				local pInv = Inventory.new(Participantes[name].Index)
				for slot = 0, 139 do
					if pInv:isItem(slot) ~= 0 then
						InventoryDeleteItem(Participantes[name].Index, slot)
						SendInventoryDeleteItem(Participantes[name].Index, slot)
					end
				end
				for slot = 204, 235 do
					if pInv:isItem(slot) ~= 0 then
						InventoryDeleteItem(Participantes[name].Index, slot)
						SendInventoryDeleteItem(Participantes[name].Index, slot)
					end
				end
				RefreshCharacter(Participantes[name].Index)
				ItemListSend(Participantes[name].Index)

				if BattleRoyale_ResetSkills then
					local class = player:getClass()
				
					for m in ipairs(BattleRoyale_ReturnSkills[class]) do
						local item = BattleRoyale_ReturnSkills[class][m]
						ItemSerialCreate(Participantes[name].Index, 236, 0, 0, GET_ITEM(item.Section, item.ID), 0, 0, 0, 0, 0, 0)
					end
				end
			
				ItemListSend(Participantes[name].Index)
				Teleport(index, 0, 125, 125)
				table.remove(Participantes, i)
			end
		end
	end
end

function BattleRoyale.CheckVivos()
	if started == false
	then
		return
	end
	
	if #Participantes <= 3 and #Participantes > 1
	then
		Message.SendMessageGlobalMultLangArgs(BattleRoyale_Message, 11, 0, #Participantes)
	end
	
	if #Participantes == 1
	then
	
		if timer_vivos2 ~= nil
		then
			Timer.Cancel(timer_vivos2)
			timer_vivos2 = nil
		end
		
		BattleRoyale.FinishEvent()	
	end	
end

function BattleRoyale.CheckVivos2()
	if started == false
	then
		return
	end
	
	if #Participantes == 1
	then
		BattleRoyale.FinishEvent()
	end
end

function BattleRoyale.FinishEvent()
	Message.SendMessageGlobalMultLang(BattleRoyale_Message, 12, 0)
	
	if #Participantes >= 2 or #Participantes < 1
	then
	
		Message.SendMessageGlobalMultLang(BattleRoyale_Message, 13, 0)
		
		for i, name in ipairs(Participantes) do 
			local index = Participantes[name].Index
			local player = User.new(index)
			local NickRemover = player:getName()
				
			if player:getConnected() ~= 3
			then
				BattleRoyale.RemoveUser(NickRemover)
			end
			if BattleRoyale_ResetStats then
				player:setStrength(Participantes[name].Str)
				player:setDexterity(Participantes[name].Agi)
				player:setVitality(Participantes[name].Vit)
				player:setEnergy(Participantes[name].Ene)
				player:setLeaderShip(Participantes[name].Cmd)
				player:setLevelUpPoint(Participantes[name].Points)
				LevelUpSend(Participantes[name].Index)
				RefreshCharacter(Participantes[name].Index)
				CalCharacter(Participantes[name].Index)
			end
	
			if BattleRoyale_ResetSkillTree then
				player:setMasterPoint(Participantes[name].MPoints)
				LevelUpSend(Participantes[name].Index)
				MasterLevelInfoSend(Participantes[name].Index)
				RefreshCharacter(Participantes[name].Index)
				CalCharacter(Participantes[name].Index)
			end

			local pInv = Inventory.new(Participantes[name].Index)
				for slot = 0, 139 do
					if pInv:isItem(slot) ~= 0 then
						InventoryDeleteItem(Participantes[name].Index, slot)
						SendInventoryDeleteItem(Participantes[name].Index, slot)
					end
				end
				for slot = 204, 235 do
					if pInv:isItem(slot) ~= 0 then
						InventoryDeleteItem(Participantes[name].Index, slot)
						SendInventoryDeleteItem(Participantes[name].Index, slot)
					end
				end
				RefreshCharacter(Participantes[name].Index)
				ItemListSend(Participantes[name].Index)

				if BattleRoyale_ResetSkills then
					local class = player:getClass()
				
					for m in ipairs(BattleRoyale_ReturnSkills[class]) do
						local item = BattleRoyale_ReturnSkills[class][m]
						ItemSerialCreate(Participantes[name].Index, 236, 0, 0, GET_ITEM(item.Section, item.ID), 0, 0, 0, 0, 0, 0)
					end
				end
			
				ItemListSend(Participantes[name].Index)
			Teleport(Participantes[name].Index, 0, 125, 125)
		end
			
	elseif #Participantes == 1
	then
	
		for i, name in ipairs(Participantes) do 
			local index = Participantes[name].Index
			local player = User.new(index)
			Message.SendMessageGlobalMultLangArgs(BattleRoyale_Message, 14, 0, player:getName())
			local tipo = ""
			if BattleRoyale_Premio.Tipo == 0 then
				tipo = player:getAccountID()
			else
				tipo = player:getName()
			end						
			DataBase.SetAddValue(BattleRoyale_Premio.Tabela, BattleRoyale_Premio.Coluna, BattleRoyale_Premio.Valor, BattleRoyale_Premio.Where, tipo)
			
			if BattleRoyale_Pontos.Tipo == 0 then
				tipo = player:getAccountID()
			else
				tipo = player:getName()
			end	
			DataBase.SetAddValue(BattleRoyale_Pontos.Tabela, BattleRoyale_Pontos.Coluna, BattleRoyale_Pontos.Valor, BattleRoyale_Pontos.Where, tipo)
			
			if BattleRoyale_Pontos2.Tipo == 0 then
				tipo = player:getAccountID()
			else
				tipo = player:getName()
			end

			DataBase.SetAddValue(BattleRoyale_Pontos2.Tabela, BattleRoyale_Pontos2.Coluna, BattleRoyale_Pontos2.Valor, BattleRoyale_Pontos2.Where, tipo)
			Message.SendMessageGlobalMultLangArgs(BattleRoyale_Message, 15, 0, BattleRoyale_Premio.Valor, BattleRoyale_Premio.Nome)

			if BattleRoyale_ResetStats then
				player:setStrength(Participantes[name].Str)
				player:setDexterity(Participantes[name].Agi)
				player:setVitality(Participantes[name].Vit)
				player:setEnergy(Participantes[name].Ene)
				player:setLeaderShip(Participantes[name].Cmd)
				player:setLevelUpPoint(Participantes[name].Points)
				LevelUpSend(Participantes[name].Index)
				RefreshCharacter(Participantes[name].Index)
				CalCharacter(Participantes[name].Index)
			end
	
			if BattleRoyale_ResetSkillTree then
				player:setMasterPoint(Participantes[name].MPoints)
				LevelUpSend(Participantes[name].Index)
				MasterLevelInfoSend(Participantes[name].Index)
				RefreshCharacter(Participantes[name].Index)
				CalCharacter(Participantes[name].Index)
			end

			local pInv = Inventory.new(Participantes[name].Index)
				for slot = 0, 139 do
					if pInv:isItem(slot) ~= 0 then
						InventoryDeleteItem(Participantes[name].Index, slot)
						SendInventoryDeleteItem(Participantes[name].Index, slot)
					end
				end
				for slot = 204, 235 do
					if pInv:isItem(slot) ~= 0 then
						InventoryDeleteItem(Participantes[name].Index, slot)
						SendInventoryDeleteItem(Participantes[name].Index, slot)
					end
				end
				RefreshCharacter(Participantes[name].Index)
				ItemListSend(Participantes[name].Index)

				if BattleRoyale_ResetSkills then
					local class = player:getClass()
				
					for m in ipairs(BattleRoyale_ReturnSkills[class]) do
						local item = BattleRoyale_ReturnSkills[class][m]
						ItemSerialCreate(Participantes[name].Index, 236, 0, 0, GET_ITEM(item.Section, item.ID), 0, 0, 0, 0, 0, 0)
					end
				end
			
				ItemListSend(Participantes[name].Index)
			
			Teleport(Participantes[name].Index, 0, 125, 125)

		end
		
	end
	
	started = false
	ComandoOn = false
	
	if timer_finish ~= nil
	then
		Timer.Cancel(timer_finish)
		timer_finish = nil
	end
	
	if timer_vivos ~= nil
	then
		Timer.Cancel(timer_vivos)
		timer_vivos = nil
	end
	
	if timer_vivos2 ~= nil
	then
		Timer.Cancel(timer_vivos2)
		timer_vivos2 = nil
	end
	
	if timer_check ~= nil
	then
		Timer.Cancel(timer_check)
		timer_check = nil
	end
	
	if timer_hp ~= nil
	then
		Timer.Cancel(timer_hp)
		timer_hp = nil
	end
	
	if timer_hp2 ~= nil
	then
		Timer.Cancel(timer_hp2)
		timer_hp2 = nil
	end
	
	if timer_areaprotegida ~= nil
	then
		Timer.Cancel(timer_areaprotegida)
		timer_areaprotegida = nil
	end
	
	if timer_areaprotegida2 ~= nil
	then
		Timer.Cancel(timer_areaprotegida2)
		timer_areaprotegida2 = nil
	end
	
	if timer_areaprotegida3 ~= nil
	then
		Timer.Cancel(timer_areaprotegida3)
		timer_areaprotegida3 = nil
	end

end

function BattleRoyale.Running()
	if timer == 0
	then			
		for i, name in ipairs(Players) do 
			local index = Players[name].Index
			local player = User.new(index)
			local NickRemover = player:getName()
			
			if player:getConnected() ~= 3
			then
				BattleRoyale.RemoveUserPlayers(NickRemover)
			end
			
			InsertKey(Participantes, player:getName())
			Participantes[player:getName()] = {Index = Players[name].Index, Str = Players[name].Str, Agi = Players[name].Agi, Vit = Players[name].Vit, Ene = Players[name].Ene, Cmd = Players[name].Cmd, Points = Players[name].Points, MPoints = Players[name].MPoints}
			Teleport(Participantes[name].Index, BattleRoyale_MapNumber, BattleRoyale_SafeCentro.X, BattleRoyale_SafeCentro.Y)
						
			player:setReqWarehouseOpen(0)
			
		end
		
		if #Participantes < 2
		then
			Message.SendMessageGlobalMultLang(BattleRoyale_Message, 16, 0)
			Message.SendMessageGlobalMultLang(BattleRoyale_Message, 17, 0)
			
			for i, name in ipairs(Participantes) do 
				local index = Participantes[name].Index
				local player = User.new(index)
				local NickRemover = player:getName()
				
				if player:getConnected() ~= 3
				then
					BattleRoyale.RemoveUser(NickRemover)
				end
				if BattleRoyale_ResetStats then
					player:setStrength(Participantes[name].Str)
					player:setDexterity(Participantes[name].Agi)
					player:setVitality(Participantes[name].Vit)
					player:setEnergy(Participantes[name].Ene)
					player:setLeaderShip(Participantes[name].Cmd)
					player:setLevelUpPoint(Participantes[name].Points)
					LevelUpSend(Participantes[name].Index)
					RefreshCharacter(Participantes[name].Index)
					CalCharacter(Participantes[name].Index)
				end
		
				if BattleRoyale_ResetSkillTree then
					player:setMasterPoint(Participantes[name].MPoints)
					LevelUpSend(Participantes[name].Index)
					MasterLevelInfoSend(Participantes[name].Index)
					RefreshCharacter(Participantes[name].Index)
					CalCharacter(Participantes[name].Index)
				end

				local pInv = Inventory.new(Participantes[name].Index)
				for slot = 0, 139 do
					if pInv:isItem(slot) ~= 0 then
						InventoryDeleteItem(Participantes[name].Index, slot)
						SendInventoryDeleteItem(Participantes[name].Index, slot)
					end
				end
				for slot = 204, 235 do
					if pInv:isItem(slot) ~= 0 then
						InventoryDeleteItem(Participantes[name].Index, slot)
						SendInventoryDeleteItem(Participantes[name].Index, slot)
					end
				end
				RefreshCharacter(Participantes[name].Index)
				ItemListSend(Participantes[name].Index)

				if BattleRoyale_ResetSkills then
					local class = player:getClass()
				
					for m in ipairs(BattleRoyale_ReturnSkills[class]) do
						local item = BattleRoyale_ReturnSkills[class][m]
						ItemSerialCreate(Participantes[name].Index, 236, 0, 0, GET_ITEM(item.Section, item.ID), 0, 0, 0, 0, 0, 0)
					end
				end
			
				ItemListSend(Participantes[name].Index)
				
				Teleport(Participantes[name].Index, 0, 125, 125)				
			end
			
			started = false
			ComandoOn = false
			
			if timer_finish ~= nil
			then
				Timer.Cancel(timer_finish)
				timer_finish = nil
			end
			
			if timer_vivos ~= nil
			then
				Timer.Cancel(timer_vivos)
				timer_vivos = nil
			end
			
			if timer_vivos2 ~= nil
			then
				Timer.Cancel(timer_vivos2)
				timer_vivos2 = nil
			end
			
			if timer_check ~= nil
			then
				Timer.Cancel(timer_check)
				timer_check = nil
			end
			
			if timer_hp ~= nil
			then
				Timer.Cancel(timer_hp)
				timer_hp = nil
			end
			
			if timer_hp2 ~= nil
			then
				Timer.Cancel(timer_hp2)
				timer_hp2 = nil
			end
			
			if timer_areaprotegida ~= nil
			then
				Timer.Cancel(timer_areaprotegida)
				timer_areaprotegida = nil
			end
			
			if timer_areaprotegida2 ~= nil
			then
				Timer.Cancel(timer_areaprotegida2)
				timer_areaprotegida2 = nil
			end
			
			if timer_areaprotegida3 ~= nil
			then
				Timer.Cancel(timer_areaprotegida3)
				timer_areaprotegida3 = nil
			end
		
			return
			
		end

		dropCount = BattleRoyale_DropSteps
		dropStep = 1
		started = true
		ComandoOn = false
		
		Message.SendMessageGlobalMultLangArgs(BattleRoyale_Message, 18, 0, BattleRoyale_COMANDO_IR)
		Message.SendMessageGlobalMultLang(BattleRoyale_Message, 19, 0)
		Message.SendMessageGlobalMultLang(BattleRoyale_Message, 20, 0)
		Timer.Repeater(15, dropCount, BattleRoyale.DropItens)
	else
		Message.SendMessageGlobalMultLangArgs(BattleRoyale_Message, 21, 0, BattleRoyale_COMANDO_IR, timer)
		timer = timer - 1
	end
	
end

function BattleRoyale.DropItens()
	if dropCount <= 0 then
		BattleRoyale.StartEvent()
	else
		Message.SendMessageGlobalMultLang(BattleRoyale_Message, 22, 0)
		for i in ipairs(BattleRoyale_Itens[dropStep]) do
			local item = BattleRoyale_Itens[dropStep][i]
			for n = 1, item.DropCount do
				local x = math.random(BattleRoyale_DropArea.X1, BattleRoyale_DropArea.X2)
				local y = math.random(BattleRoyale_DropArea.Y1, BattleRoyale_DropArea.Y2)
					
				ItemSerialCreate(13000, BattleRoyale_MapNumber, x, y, GET_ITEM(item.Section, item.ID), math.random(0,5), 255, math.random(0,1), math.random(0,1), math.random(0, 63), 0)
			end
		end
		dropStep = dropStep+1
		dropCount = dropCount-1
	end
end

function BattleRoyale.StartEvent()
	timer_check = Timer.Interval(2, BattleRoyale.CheckUser)
	timer_vivos = Timer.Interval(15, BattleRoyale.CheckVivos)
	timer_vivos2 = Timer.Interval(3, BattleRoyale.CheckVivos2)
	timer_finish = Timer.TimeOut(5 * 60, BattleRoyale.FinishEvent)
		
	timer_areaprotegida = Timer.TimeOut(15, BattleRoyale.AreaProtegida)
	timer_hp = Timer.TimeOut(2 * 60, BattleRoyale.TirarHP)
	
	BattleRoyale.CheckVivos()
end

function BattleRoyale.CommandOpen(aIndex, Arguments)	
	local player = User.new(aIndex)
	local lang = player:getLanguage()
	if player:getAuthority() == 1
	then
		return
	end

	timer_check = nil
	timer_finish = nil
	timer_vivos = nil
	timer_vivos2 = nil
	gm = player:getName()
	
	Players = {}
	Participantes = {}
	
	timer = command:getNumber(Arguments, 1)
	
	if timer == 0
	then
		SendMessage(string.format(BattleRoyale_Message[lang][23], BattleRoyale_COMANDO_ABRIR), aIndex, 1)
		return
	end
	
	if timer > 60
	then
		SendMessage(BattleRoyale_Message[lang][24], aIndex, 1)
		return
	end
	
	math.randomseed(os.clock()*os.time()/GetTick())
	
	started = false
	ComandoOn = true
	
	
	idtimer = Timer.Repeater(1, timer, BattleRoyale.Running)
	
	Message.SendMessageGlobalMultLangArgs(BattleRoyale_Message, 25, 1 , player:getName(), BattleRoyale_COMANDO_IR)
end

function BattleRoyale.CommandGo(aIndex, Arguments)
	local player = User.new(aIndex)
	local pInv = Inventory.new(aIndex)
	local lang = player:getLanguage()

	if player:getAuthority() ~= 1
	then
		SendMessage(BattleRoyale_Message[lang][26], aIndex, 1)
		return
	end
	
	if player:getLevel() < BattleRoyale_LevelMinimo then
		SendMessage(string.format(BattleRoyale_Message[lang][27], BattleRoyale_LevelMinimo), aIndex, 1)
		return
	end
	
	if ComandoOn == false
	then
		SendMessage(BattleRoyale_Message[lang][28], aIndex, 1)
		return
	end
	
	if not BattleRoyale_Classepermitida[player:getClass()]
	then
		SendMessage(BattleRoyale_Message[lang][29], aIndex, 1)
		return
	end
	
	for i = 0, 139 do
		if pInv:isItem(i) ~= 0
		then
			SendMessage(BattleRoyale_Message[lang][30], aIndex, 1)
			SendMessage(BattleRoyale_Message[lang][31], aIndex, 1)
			return
		end
	end

	for i = 204, 235 do
		if pInv:isItem(i) ~= 0
		then
			SendMessage(BattleRoyale_Message[lang][30], aIndex, 1)
			SendMessage(BattleRoyale_Message[lang][31], aIndex, 1)
			return
		end
	end
		
	local Name = player:getName()
	
	if player:getInterfaceUse() ~= 0 or player:getState() == 32 or player:getDieRegen() ~= 0 or player:getTeleport() ~= 0
	then
		SendMessage(BattleRoyale_Message[lang][32], aIndex, 1)
		return
	end
	
	if Players[player:getName()] == nil
	then
		InsertKey(Players, player:getName())
		local str = 0
		local agi = 0
		local vit = 0
		local ene = 0
		local cmd = 0
		local points = 0
		local mpoints = 0
		
		if BattleRoyale_ResetStats then
			str = player:getStrength()
			agi = player:getDexterity()
			vit = player:getVitality()
			ene = player:getEnergy()
			cmd = player:getLeaderShip()
			points = player:getLevelUpPoint()
			player:setStrength(0)
			player:setDexterity(0)
			player:setVitality(0)
			player:setEnergy(0)
			player:setLeaderShip(0)
			player:setLevelUpPoint(BattleRoyale_Points)
			LevelUpSend(aIndex)
			RefreshCharacter(aIndex)
			CalCharacter(aIndex)
		end

		if BattleRoyale_ResetSkillTree then
			gObjRebuildMasterSkillTree(aIndex)
			mpoints = player:getMasterPoint()
			player:setMasterPoint(0)
			MasterLevelInfoSend(aIndex)
			LevelUpSend(aIndex)
			RefreshCharacter(aIndex)
			CalCharacter(aIndex)
		end

		if BattleRoyale_ResetSkills then
			ResetSkills(aIndex)
		end
		
		Players[player:getName()] = {Index = aIndex, Str = str, Agi = agi, Vit = vit, Ene = ene, Cmd = cmd, Points = points, MPoints = mpoints}
		
		SendMessage(BattleRoyale_Message[lang][33], aIndex, 1)
		SendMessage(BattleRoyale_Message[lang][34], aIndex, 1)
		player:setReqWarehouseOpen(1)
		Teleport(aIndex, BattleRoyale_MapNumber, BattleRoyale_SafeCentro.X, BattleRoyale_SafeCentro.Y)

	else
		SendMessage(BattleRoyale_Message[lang][33], aIndex, 1)
		player:setReqWarehouseOpen(1)
		Teleport(aIndex, BattleRoyale_MapNumber, BattleRoyale_SafeCentro.X, BattleRoyale_SafeCentro.Y)
	end
	
end

function BattleRoyale.Morte(aIndex, TargetIndex)
	if started == false
	then
		return
	end
	local player1 = User.new(aIndex)
	local player2 = User.new(TargetIndex)
	local nomeMatador = player1:getName()
	local nomeRemover = player2:getName()
	local lang1 = player1:getLanguage()
	local lang2 = player2:getLanguage()
	
	if Participantes[nomeMatador] ~= nil and Participantes[nomeRemover] ~= nil
	then
		Message.SendMessageGlobalMultLangArgs(BattleRoyale_Message, 35, 0, nomeMatador, nomeRemover)
		SendMessage(string.format(BattleRoyale_Message[lang1][36], nomeRemover), aIndex, 1)
		SendMessage(string.format(BattleRoyale_Message[lang2][37], nomeMatador), TargetIndex, 1)
		
		if BattleRoyale_ResetStats then
			player2:setStrength(Participantes[nomeRemover].Str)
			player2:setDexterity(Participantes[nomeRemover].Agi)
			player2:setVitality(Participantes[nomeRemover].Vit)
			player2:setEnergy(Participantes[nomeRemover].Ene)
			player2:setLeaderShip(Participantes[nomeRemover].Cmd)
			player2:setLevelUpPoint(Participantes[nomeRemover].Points)
			LevelUpSend(TargetIndex)
			RefreshCharacter(TargetIndex)
			CalCharacter(TargetIndex)
		end

		if BattleRoyale_ResetSkillTree then
			player2:setMasterPoint(Participantes[nomeRemover].MPoints)
			LevelUpSend(TargetIndex)
			RefreshCharacter(TargetIndex)
			CalCharacter(TargetIndex)
		end

		local pInv = Inventory.new(TargetIndex)
		for slot = 0, 139 do
			if pInv:isItem(slot) ~= 0 then
				InventoryDeleteItem(TargetIndex, slot)
				SendInventoryDeleteItem(TargetIndex, slot)
			end
		end
		for slot = 204, 235 do
			if pInv:isItem(slot) ~= 0 then
				InventoryDeleteItem(TargetIndex, slot)
				SendInventoryDeleteItem(TargetIndex, slot)
			end
		end
		RefreshCharacter(TargetIndex)
		ItemListSend(TargetIndex)
		
		if BattleRoyale_ResetSkills then
			local class = player2:getClass()

			for m in ipairs(BattleRoyale_ReturnSkills[class]) do
				local item = BattleRoyale_ReturnSkills[class][m]
				ItemSerialCreate(TargetIndex, 236, 0, 0, GET_ITEM(item.Section, item.ID), 0, 0, 0, 0, 0, 0)
			end
		end

		ItemListSend(TargetIndex)
		Teleport(TargetIndex, 0, 125, 125)		
		BattleRoyale.RemoveUser(nomeRemover)
		BattleRoyale.CheckVivos()
	end
end

function BattleRoyale.RemoveUser(Name)
	for i, key in ipairs(Participantes) do
		if key == Name
		then
			table.remove(Participantes, i)
		end
	end
end

function BattleRoyale.RemoveUserPlayers(Name)
	for i, key in ipairs(Players) do
		if key == Name
		then
			table.remove(Players, i)
		end
	end
end

function BattleRoyale.PlayerLeft(aIndex)
	if started == false
	then
		return
	end

	local player = User.new(aIndex)
	local nome = player:getName()

	if Participantes[nome] ~= nil
	then
		if BattleRoyale_ResetStats then
			player:setStrength(Participantes[nome].Str)
			player:setDexterity(Participantes[nome].Agi)
			player:setVitality(Participantes[nome].Vit)
			player:setEnergy(Participantes[nome].Ene)
			player:setLeaderShip(Participantes[nome].Cmd)
			player:setLevelUpPoint(Participantes[nome].Points)
			LevelUpSend(aIndex)
			RefreshCharacter(aIndex)
			CalCharacter(aIndex)
		end

		if BattleRoyale_ResetSkillTree then
			player:setMasterPoint(Participantes[nome].MPoints)
			LevelUpSend(aIndex)
			RefreshCharacter(aIndex)
			CalCharacter(aIndex)
		end

		local pInv = Inventory.new(aIndex)
		for slot = 0, 139 do
			if pInv:isItem(slot) ~= 0 then
				InventoryDeleteItem(aIndex, slot)
				SendInventoryDeleteItem(aIndex, slot)
			end
		end
		for slot = 204, 235 do
			if pInv:isItem(slot) ~= 0 then
				InventoryDeleteItem(aIndex, slot)
				SendInventoryDeleteItem(aIndex, slot)
			end
		end
		RefreshCharacter(aIndex)
		ItemListSend(aIndex)
		
		if BattleRoyale_ResetSkills then
			local class = player:getClass()

			for m in ipairs(BattleRoyale_ReturnSkills[class]) do
				local item = BattleRoyale_ReturnSkills[class][m]
				ItemSerialCreate(aIndex, 236, 0, 0, GET_ITEM(item.Section, item.ID), 0, 0, 0, 0, 0, 0)
			end
		end

		ItemListSend(aIndex)
		Teleport(aIndex, 0, 125, 125)		
		BattleRoyale.RemoveUser(nome)
		BattleRoyale.CheckVivos()
	end
end

BattleRoyale.Init()

return BattleRoyale