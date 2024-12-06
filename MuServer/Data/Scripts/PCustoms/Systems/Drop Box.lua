DropBox = {}

function DropBox.Init()	
	if DropBox_Config.Enabled then
		GameServerFunctions.PlayerDropItem(DropBox.PlayerDrop)
	end
end

function DropBox.PlayerDrop(aIndex, x, y, position)
	local player = User.new(aIndex)
	local pInv = Inventory.new(aIndex)
	local lang = player:getLanguage()

	local itemInfo = {Index = pInv:getIndex(position), Level = pInv:getLevel(position), Name = pInv:getName(position)}

	if DropBox_Config.Box[itemInfo.Index] == nil then return 0 end

	local box = DropBox_Config.Box[itemInfo.Index][-1]
	if DropBox_Config.Box[itemInfo.Index][itemInfo.Level] ~= nil then
		box = DropBox_Config.Box[itemInfo.Index][itemInfo.Level]
	end

	if box.Itens == -1 and box.Group == -1 then return 0 end

	if box.Inventory then
		for slot = 12, 75 do
			if slot ~= position then
				if pInv:isItem(slot) ~= 0 then
					SendMessage(DropBox_Config.Message[lang][1], aIndex, 1)
					return 2
				end
			end
		end
	end

	if player:getInterfaceUse() > 0 or player:getTeleport() ~= 0 or player:getDieRegen() ~= 0 then
		SendMessage(DropBox_Config.Message[lang][2], aIndex, 1)
		return 2
	end

	local vip = player:getVip()

	if box.Vip[vip] == nil or not box.Vip[vip] then
		SendMessage(DropBox_Config.Message[lang][3], aIndex, 1)
		return 2
	end

	local item = -1
	if box.Group ~= -1 then
		item = DropBox.GetDropByGroup(box, vip)
	else
		if box.Random then
			item = DropBox.GetItem(box.Itens, -1)
		else
			item = DropBox.GetItem(box.Itens, vip)
		end
	end

	if item == -1 then return 0 end

	DeleteItemCount(aIndex, itemInfo.Index, itemInfo.Level, 1)
	ItemListSend(aIndex)

	local troll = false
	if item.Section == -1 or item.Index == -1 then
		SendMessage(string.format(DropBox_Config.Message[lang][4], itemInfo.Name), aIndex, 1)
		troll = true
	end

	if not troll then
		item.DurMin = 255
		item.DurMax = 255

		local options = Utils.GetOption(item)
		local socket = 0
		if item.MinSocket == item.MaxSocket then
			socket = item.MinSocket
		else
			socket = Utils.GetRandom(item.MinSocket, item.MaxSocket, math.random(1,10))
		end
		if socket == 0 then socket = 255 end
		if socket > 3 then socket = 3 end

		local map = player:getMapNumber()

		local index = GET_ITEM(item.Section, item.Index)
		if InventoryCheckSpaceByItem(aIndex, index) == 1 and box.Inventory then
			CreateItemInventory(aIndex, index, options.Level, options.Skill, options.Luck, options.Option, options.Exc, 0, 0, 255, socket, 255, 255, 255, 255, item.Time)
		else
			CreateItemMap(aIndex, map, (x+math.random(-2, 2)), (y+math.random(-2, 2)), index, options.Level, options.Skill, options.Luck, options.Option, options.Exc, 0, 0, socket, item.Time)
		end

		if item.ExtraItens ~= -1 then
			if DropBox_Config.ExtraItens[item.ExtraItens] ~= nil then
				for i = 1, #DropBox_Config.ExtraItens[item.ExtraItens] do
					local extraitem = DropBox_Config.ExtraItens[item.ExtraItens][i]
					local extraoption = options
					if extraitem.RecalculateOptions then
						extraitem.DurMin = 255
						extraitem.DurMax = 255
						extraoption = Utils.GetOption(extraitem)
					end
					index = GET_ITEM(extraitem.Section, extraitem.Index)
					if InventoryCheckSpaceByItem(aIndex, index) == 1 and box.Inventory then
						CreateItemInventory(aIndex, index, extraoption.Level, extraoption.Skill, extraoption.Luck, extraoption.Option, extraoption.Exc, 0, 0, 255, socket, 255, 255, 255, 255, extraitem.Time)
					else
						CreateItemMap(aIndex, map, (x+math.random(-2, 2)), (y+math.random(-2, 2)), index, extraoption.Level, extraoption.Skill, extraoption.Luck, extraoption.Option, extraoption.Exc, 0, 0, socket, extraitem.Time)
					end
				end
			end
		end
	end

	if item.Fireworks then
		FireWorks(aIndex, 0, 0, 0)
	end

	if item.Announce then
		Message.SendMessageGlobalMultLang(DropBox_Config.Message, 5, 0)
		Message.SendMessageGlobalMultLangArgs(DropBox_Config.Message, 6, 0, itemInfo.Name)
		if troll then
			Message.SendMessageGlobalMultLangArgs(DropBox_Config.Message, 9, 0, player:getName())
		else
			Message.SendMessageGlobalMultLangArgs(DropBox_Config.Message, 7, 0, player:getName())
			Message.SendMessageGlobalMultLangArgs(DropBox_Config.Message, 8, 0, item.Name)
		end
		Message.SendMessageGlobalMultLang(DropBox_Config.Message, 5, 0)
	end

	ItemListSend(aIndex)
	return 2
end

function DropBox.GetDropByGroup(box, vip)
	local item = -1
	local grupo = DropBox_Config.Group[box.Group]
	if grupo ~= nil then
		local t = {}
		for i = 1, #grupo do
			if grupo[i].Rate[vip] ~= nil then
				local qtd = (grupo[i].Rate[vip]/100)*10000
				for b = 1, qtd do
					table.insert(t, grupo[i])
				end
			end
		end

		grupo = t[Utils.GetRandom(1, #t, math.random(1,10))]
		if box.Random then
			item = DropBox.GetItem(grupo.Itens, -1)
		else
			item = DropBox.GetItem(grupo.Itens, vip)
		end
	end

	return item
end

function DropBox.GetItem(id, vip)
	local item = -1

	local grupo = DropBox_Config.Itens[id]
	if grupo ~= nil then
		local t = {}
		
		if vip == -1 then
			for i = 1, #grupo do
				table.insert(t, grupo[i])
			end
		else
			for i = 1, #grupo do
				if grupo[i].Rate[vip] ~= nil then
					local qtd = (grupo[i].Rate[vip]/100)*10000
					for b = 1, qtd do
						table.insert(t, grupo[i])
					end
				end
			end
		end
		if #t > 0 then
			item = t[Utils.GetRandom(1, #t, math.random(1,10))]
		end
	end

	return item
end

DropBox.Init()

return DropBox