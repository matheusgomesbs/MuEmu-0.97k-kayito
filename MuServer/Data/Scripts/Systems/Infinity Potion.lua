InfinityPotion = {}

InfinityPotion.AcitveItens = {}

function InfinityPotion.Init()
	if InfinityPotion_Config.Enabled then
		GameServerFunctions.CharacterSet(InfinityPotion.CharacterSet)
		Timer.Interval(1, InfinityPotion.Running)
		Timer.Interval(5, InfinityPotion.CheckPlayers)
	end
end

function InfinityPotion.Running()
	for i in pairs(InfinityPotion.AcitveItens) do
		if InfinityPotion.AcitveItens[i] == nil then goto continue end
		local item = InfinityPotion.AcitveItens[i]
		local pInv = Inventory.new(item.aIndex)

		if gObjIsConnectedGP(item.aIndex) == 0 then
			InfinityPotion.AcitveItens[i] = nil
			goto continue
		end

		if pInv:isItem(item.Slot) == 0 or pInv:getIndex(item.Slot) ~= item.Item then
			InfinityPotion.AcitveItens[i] = nil
			goto continue
		end

		local count = 0
		for slot = 12, 75 do
			if pInv:isItem(slot) ~= 0 then
				if pInv:getIndex(slot) == item.Potion then
					count = count + 1
				end
			end
		end

		if count < item.Count then
			local total = item.Count - count
			if total > 0 then
				for qtd = 1, total do
					ItemSerialCreateComplete(item.aIndex, 236,0,0,item.Potion, 0,255,0,0,0,0,0,0,0)
					ItemListSend(item.aIndex)
				end
			end
		end

		::continue::
	end
end

function InfinityPotion.CharacterSet(aIndex)
	local pInv = Inventory.new(aIndex)
	local playerItens = {
		[0]   = pInv:getIndex(0),
		[1]   = pInv:getIndex(1),
		[2]   = pInv:getIndex(2),
		[3]   = pInv:getIndex(3),
		[4]   = pInv:getIndex(4),
		[5]   = pInv:getIndex(5),
		[6]   = pInv:getIndex(6),
		[7]   = pInv:getIndex(7),
		[8]   = pInv:getIndex(8),
		[9]   = pInv:getIndex(9),
		[10]  = pInv:getIndex(10),
		[11]  = pInv:getIndex(11),
		[236] = pInv:getIndex(236),
		[237] = pInv:getIndex(237),
		[238] = pInv:getIndex(238),
		[239] = pInv:getIndex(239),
		[240] = pInv:getIndex(240),
		[241] = pInv:getIndex(241),
		[242] = pInv:getIndex(242),
		[243] = pInv:getIndex(243),
		[244] = pInv:getIndex(244),
		[245] = pInv:getIndex(245),
		[246] = pInv:getIndex(246),
		[247] = pInv:getIndex(247),
		[248] = pInv:getIndex(248),
	}
	for i in ipairs(InfinityPotion_Config.Itens) do
		local item = InfinityPotion_Config.Itens[i]
		if pInv:isItem(item.Slot) ~= 0 then
			if pInv:getIndex(item.Slot) == GET_ITEM(item.Section, item.Index) then
				local info = {aIndex = aIndex, Slot = item.Slot, Item = GET_ITEM(item.Section, item.Index), Potion = GET_ITEM(item.PotionSection, item.PotionIndex), Count = item.PotionAmount}
				if not InfinityPotion.GetItemActive(aIndex, info.Item) then
					table.insert(InfinityPotion.AcitveItens, info)
				end
			end
		end
	end
end

function InfinityPotion.GetItemActive(aIndex, Item)
	for i in pairs(InfinityPotion.AcitveItens) do
		if InfinityPotion.AcitveItens[i] ~= nil then
			if InfinityPotion.AcitveItens[i].aIndex == aIndex then
				if InfinityPotion.AcitveItens[i].Item == Item then
					return true
				end
			end
		end
	end

	return false
end

function InfinityPotion.CheckPlayers()
	for aIndex = 13000, 13999 do
		if gObjIsConnectedGP(aIndex) == 1 then
			InfinityPotion.CharacterSet(aIndex)
		end
	end
end


InfinityPotion.Init()

return InfinityPotion