NewJewelCustom = {}

function NewJewelCustom.Init()	
	if NewJewelCustom_Ativado then
		GameServerFunctions.PlayerUseItem(NewJewelCustom.PlayerUseItem)
	end
end

function NewJewelCustom.PlayerUseItem(aIndex, SourceSlot, TargetSlot)
	local  p = User.new(aIndex)
	local pInv = Inventory.new(aIndex)
	local vip = p:getVip()	
	local joia = {item = pInv:getIndex(SourceSlot), level = pInv:getLevel(SourceSlot)}
	local target = {item = pInv:getIndex(TargetSlot), level = pInv:getLevel(TargetSlot), exe = pInv:isExc(TargetSlot)}
	local joia2 = nil
	
	LogAddC(2, string.format("Index Joia: %d, Level Joia: %d, Index Item: %d, Level Item %d", joia.item, joia.level, target.item, target.level))

	for i in ipairs(NewJewelCustom_Config) do
		if joia.item == Utils.GetItem(NewJewelCustom_Config[i].Grupo , NewJewelCustom_Config[i].Id) then
			if NewJewelCustom_Config[i].Level == -1 or joia.level == NewJewelCustom_Config[i].Level then
				joia2 = joia
				joia = NewJewelCustom_Config[i]
				break
			end
		end
	end
	
	if joia.Index == nil then
		return 0 
	end
		
	if not joia.Vip[vip] then 
		SendMessage(string.format(NewJewelCustom_MensagemVIp), aIndex, 1)
		InventoryDeleteItem(aIndex, SourceSlot)
		SendInventoryDeleteItem(aIndex, SourceSlot)
		ItemSerialCreate(aIndex, 236, 0, 0, joia2.item, joia2.level, 0, 0, 0, 0, 0)
		return 1 
	end
	
	for i in ipairs(NewJewelCustom_ItemOriginal) do
		if NewJewelCustom_ItemOriginal[i].Index == joia.Index then
			if target.item == Utils.GetItem(NewJewelCustom_ItemOriginal[i].Grupo , NewJewelCustom_ItemOriginal[i].Id) then
				if NewJewelCustom_ItemOriginal[i].Level == -1 or joia.level == NewJewelCustom_ItemOriginal[i].Level then
					if NewJewelCustom_ItemOriginal[i].Excelente then
						if target.exe == 1 then
							target = NewJewelCustom_ItemOriginal[i]
							break
						end
					else
						target = NewJewelCustom_ItemOriginal[i]
						break
					end
				end
			end
		end
	end
	
	if target.Index == nil then
		InventoryDeleteItem(aIndex, SourceSlot)
		SendInventoryDeleteItem(aIndex, SourceSlot)
		ItemSerialCreate(aIndex, 236, 0, 0, joia2.item, joia2.level, 0, 0, 0, 0, 0)
		return 1
	end
	
	if not Utils.GetSuccessByRate(joia.Sucesso[vip]) then
		SendMessage(string.format(NewJewelCustom_MensagemFalha, joia.Nome), aIndex, 1)
		InventoryDeleteItem(aIndex, SourceSlot)
		SendInventoryDeleteItem(aIndex, SourceSlot)
		
		if not target.CriarItemNexSeFalhar and target.DeletarSeFalhar  then
			InventoryDeleteItem(aIndex, TargetSlot)
			SendInventoryDeleteItem(aIndex, TargetSlot)
			for i = 1, NewJewelCustom_NovoItemSeDeletar.Quantidade do
				local Options = NewJewelCustom.GetOption(NewJewelCustom_NovoItemSeDeletar)
				if NewJewelCustom_NovoItemSeDeletar.Dias > 0 then
					ItemSerialCreatePeriodic(aIndex, 236, 0, 0, Utils.GetItem(NewJewelCustom_NovoItemSeDeletar.Grupo, NewJewelCustom_NovoItemSeDeletar.Id), Options.Level, Options.Dur, Options.Skill, Options.Luck, Options.Option, Options.Exc, NewJewelCustom_NovoItemSeDeletar.Dias)
				else
					ItemSerialCreate(aIndex, 236, 0, 0, Utils.GetItem(NewJewelCustom_NovoItemSeDeletar.Grupo, NewJewelCustom_NovoItemSeDeletar.Id), Options.Level, Options.Dur, Options.Skill, Options.Luck, Options.Option, Options.Exc)
				end
			end
			
			if NewJewelCustom_NovoItemSeDeletar.Extras then
				for i in ipairs(NewJewelCustom_NovoItemSeDeletarExtras) do
					local item = NewJewelCustom_NovoItemSeDeletarExtras[i]
					
					for i = 1, item.Quantidade do
						local Options = NewJewelCustom.GetOption(item)
						if item.Dias > 0 then
							ItemSerialCreatePeriodic(aIndex, 236, 0, 0, Utils.GetItem(item.Grupo, item.Id), Options.Level, Options.Dur, Options.Skill, Options.Luck, Options.Option, Options.Exc, item.Dias)
						else
							ItemSerialCreate(aIndex, 236, 0, 0, Utils.GetItem(item.Grupo, item.Id), Options.Level, Options.Dur, Options.Skill, Options.Luck, Options.Option, Options.Exc)
						end
					end			
				end
			end
		end
		
		if not target.DeletarSeFalhar and target.CriarItemNexSeFalhar then
			InventoryDeleteItem(aIndex, TargetSlot)
			SendInventoryDeleteItem(aIndex, TargetSlot)	
			ItemSerialCreate(aIndex, 236, 0, 0, GET_ITEM(target.Grupo, target.Id), 0, 0, 0, 0, 0, 0)	
		end
				
		return 1
	end
	
	InventoryDeleteItem(aIndex, TargetSlot)
	SendInventoryDeleteItem(aIndex, TargetSlot)
	InventoryDeleteItem(aIndex, SourceSlot)
	SendInventoryDeleteItem(aIndex, SourceSlot)
	
	local Item = nil
	
	for i in ipairs(NewJewelCustom_ItemNovo) do
		if NewJewelCustom_ItemNovo[i].Index == target.ItemNovo then
			Item = NewJewelCustom_ItemNovo[i]
			break
		end
	end
	
	if Item == nil then return 1 end
	
	for i = 1, Item.Quantidade do
		local Options = Utils.GetOption(Item)
		if Item.Dias > 0 then
			ItemSerialCreatePeriodic(aIndex, 236, 0, 0, Utils.GetItem(Item.Grupo, Item.Id), Options.Level, Options.Dur, Options.Skill, Options.Luck, Options.Option, Options.Exc, Item.Dias)
		else
			ItemSerialCreate(aIndex, 236, 0, 0, Utils.GetItem(Item.Grupo, Item.Id), Options.Level, Options.Dur, Options.Skill, Options.Luck, Options.Option, Options.Exc)
		end
	end
	
	for i in ipairs(NewJewelCustom_ItemNovoExtra) do
		if NewJewelCustom_ItemNovoExtra[i].Index == Item.Extras then
			local item = NewJewelCustom_ItemNovoExtra[i]
			
			for i = 1, item.Quantidade do
				local Options = Utils.GetOption(item)
				if item.Dias > 0 then
					ItemSerialCreatePeriodic(aIndex, 236, 0, 0, Utils.GetItem(item.Grupo, item.Id), Options.Level, Options.Dur, Options.Skill, Options.Luck, Options.Option, Options.Exc, item.Dias)
				else
					ItemSerialCreate(aIndex, 236, 0, 0, Utils.GetItem(item.Grupo, item.Id), Options.Level, Options.Dur, Options.Skill, Options.Luck, Options.Option, Options.Exc)
				end
			end			
		end
	end
	
	SendMessage(string.format(NewJewelCustom_MensagemSucesso, joia.Nome), aIndex, 1)
	
	return 1
end

NewJewelCustom.Init()

return NewJewelCustom