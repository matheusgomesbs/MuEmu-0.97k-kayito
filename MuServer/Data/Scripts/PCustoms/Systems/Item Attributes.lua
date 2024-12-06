ItemAttributes = {}

function ItemAttributes.Init()

    if ItemAttributes_Config.Enabled then
        GameServerFunctions.CharacterSet(ItemAttributes.CharacterSet)
    end
end

function ItemAttributes.CharacterSet(aIndex)
    local player = User.new(aIndex)
    local pInv = Inventory.new(aIndex)
	local playerItens = {
		[0] = {Index = pInv:getIndex(0), Level = pInv:getLevel(0)},
		[1] = {Index = pInv:getIndex(1), Level = pInv:getLevel(1)},
		[2] = {Index = pInv:getIndex(2), Level = pInv:getLevel(2)},
		[3] = {Index = pInv:getIndex(3), Level = pInv:getLevel(3)},
		[4] = {Index = pInv:getIndex(4), Level = pInv:getLevel(4)},
		[5] = {Index = pInv:getIndex(5), Level = pInv:getLevel(5)},
		[6] = {Index = pInv:getIndex(6), Level = pInv:getLevel(6)},
		[7] = {Index = pInv:getIndex(7), Level = pInv:getLevel(7)},
		[8] = {Index = pInv:getIndex(8), Level = pInv:getLevel(8)},
		[9] = {Index = pInv:getIndex(9), Level = pInv:getLevel(9)},
		[10] = {Index = pInv:getIndex(10), Level = pInv:getLevel(10)},
		[11] = {Index = pInv:getIndex(11), Level = pInv:getLevel(11)},
		[15] = {Index = pInv:getIndex(15), Level = pInv:getLevel(15)},
		[236] = {Index = pInv:getIndex(236), Level = pInv:getLevel(236)},
		[237] = {Index = pInv:getIndex(237), Level = pInv:getLevel(237)},
		[238] = {Index = pInv:getIndex(238), Level = pInv:getLevel(238)},
		[239] = {Index = pInv:getIndex(239), Level = pInv:getLevel(239)},
		[240] = {Index = pInv:getIndex(240), Level = pInv:getLevel(240)},
		[241] = {Index = pInv:getIndex(241), Level = pInv:getLevel(241)},
		[242] = {Index = pInv:getIndex(242), Level = pInv:getLevel(242)},
		[243] = {Index = pInv:getIndex(243), Level = pInv:getLevel(243)},
		[244] = {Index = pInv:getIndex(244), Level = pInv:getLevel(244)},
		[245] = {Index = pInv:getIndex(245), Level = pInv:getLevel(245)},
		[246] = {Index = pInv:getIndex(246), Level = pInv:getLevel(246)},
		[247] = {Index = pInv:getIndex(247), Level = pInv:getLevel(247)},
		[248] = {Index = pInv:getIndex(248), Level = pInv:getLevel(248)},
	}

    for i in ipairs(ItemAttributes_Config.Itens) do
        local item = ItemAttributes_Config.Itens[i]
        
        if playerItens[item.Slot].Index == GET_ITEM(item.Section, item.Index) then
            if item.Level == -1 or item.Level == playerItens[item.Slot].Level then
                if ItemAttributes_Config.Attributes[item.Attribute].DefenseMultiply ~= 0    then
					PLAYER_PVP[aIndex].NewValue.Defense = PLAYER_PVP[aIndex].NewValue.Defense + ((PLAYER_PVP[aIndex].Original.Defense * ItemAttributes_Config.Attributes[item.Attribute].DefenseMultiply) - PLAYER_PVP[aIndex].Original.Defense)
					PLAYER_PVP[aIndex].NewValue.DefensePvP = PLAYER_PVP[aIndex].NewValue.DefensePvP + ((PLAYER_PVP[aIndex].Original.DefensePvP * ItemAttributes_Config.Attributes[item.Attribute].DefenseMultiply) - PLAYER_PVP[aIndex].Original.DefensePvP)
                end
            
                if ItemAttributes_Config.Attributes[item.Attribute].DefenseAdd ~= 0    then
					PLAYER_PVP[aIndex].NewValue.Defense = PLAYER_PVP[aIndex].NewValue.Defense + ItemAttributes_Config.Attributes[item.Attribute].DefenseAdd
					PLAYER_PVP[aIndex].NewValue.DefensePvP = PLAYER_PVP[aIndex].NewValue.DefensePvP + ItemAttributes_Config.Attributes[item.Attribute].DefenseAdd
					
                end

                if ItemAttributes_Config.Attributes[item.Attribute].BlockSuccessMultiply ~= 0
                then
					PLAYER_PVP[aIndex].NewValue.SuccessBlock = PLAYER_PVP[aIndex].NewValue.SuccessBlock + ((PLAYER_PVP[aIndex].Original.SuccessBlock * ItemAttributes_Config.Attributes[item.Attribute].BlockSuccessMultiply) - PLAYER_PVP[aIndex].Original.SuccessBlock)
					PLAYER_PVP[aIndex].NewValue.SuccessBlockPvP = PLAYER_PVP[aIndex].NewValue.SuccessBlockPvP + ((PLAYER_PVP[aIndex].Original.SuccessBlockPvP * ItemAttributes_Config.Attributes[item.Attribute].BlockSuccessMultiply) - PLAYER_PVP[aIndex].Original.SuccessBlockPvP)
                end
            
                if ItemAttributes_Config.Attributes[item.Attribute].BlockSuccessAdd ~= 0
                then
					PLAYER_PVP[aIndex].NewValue.SuccessBlock = PLAYER_PVP[aIndex].NewValue.SuccessBlock + ItemAttributes_Config.Attributes[item.Attribute].BlockSuccessAdd
					PLAYER_PVP[aIndex].NewValue.SuccessBlockPvP = PLAYER_PVP[aIndex].NewValue.SuccessBlockPvP + ItemAttributes_Config.Attributes[item.Attribute].BlockSuccessAdd
                end

                if ItemAttributes_Config.Attributes[item.Attribute].LifeAdd ~= 0
                then
					PLAYER_PVP[aIndex].NewValue.AddLife = PLAYER_PVP[aIndex].NewValue.AddLife +ItemAttributes_Config.Attributes[item.Attribute].LifeAdd
                end
            
                if ItemAttributes_Config.Attributes[item.Attribute].ManaAdd ~= 0 
                then
					PLAYER_PVP[aIndex].NewValue.AddMana = PLAYER_PVP[aIndex].NewValue.AddMana +ItemAttributes_Config.Attributes[item.Attribute].ManaAdd
                end
            
                if ItemAttributes_Config.Attributes[item.Attribute].DamageAdd ~= 0 
                then					
					PLAYER_PVP[aIndex].NewValue.AttackDamageMinLeft = PLAYER_PVP[aIndex].NewValue.AttackDamageMinLeft +ItemAttributes_Config.Attributes[item.Attribute].DamageAdd
					PLAYER_PVP[aIndex].NewValue.AttackDamageMaxLeft = PLAYER_PVP[aIndex].NewValue.AttackDamageMaxLeft +ItemAttributes_Config.Attributes[item.Attribute].DamageAdd
					PLAYER_PVP[aIndex].NewValue.AttackDamageMinRight = PLAYER_PVP[aIndex].NewValue.AttackDamageMinRight +ItemAttributes_Config.Attributes[item.Attribute].DamageAdd 
					PLAYER_PVP[aIndex].NewValue.AttackDamageMaxRight = PLAYER_PVP[aIndex].NewValue.AttackDamageMaxRight +ItemAttributes_Config.Attributes[item.Attribute].DamageAdd                                                                               
                end
            
                if ItemAttributes_Config.Attributes[item.Attribute].DamageMultiply ~= 0 
                then
					PLAYER_PVP[aIndex].NewValue.AttackDamageMinLeft = PLAYER_PVP[aIndex].NewValue.AttackDamageMinLeft + ((PLAYER_PVP[aIndex].Original.AttackDamageMinLeft * ItemAttributes_Config.Attributes[item.Attribute].DamageMultiply) - PLAYER_PVP[aIndex].Original.AttackDamageMinLeft)
					PLAYER_PVP[aIndex].NewValue.AttackDamageMaxLeft = PLAYER_PVP[aIndex].NewValue.AttackDamageMaxLeft + ((PLAYER_PVP[aIndex].Original.AttackDamageMaxLeft * ItemAttributes_Config.Attributes[item.Attribute].DamageMultiply) - PLAYER_PVP[aIndex].Original.AttackDamageMaxLeft)
					PLAYER_PVP[aIndex].NewValue.AttackDamageMinRight = PLAYER_PVP[aIndex].NewValue.AttackDamageMinRight + ((PLAYER_PVP[aIndex].Original.AttackDamageMinRight * ItemAttributes_Config.Attributes[item.Attribute].DamageMultiply) - PLAYER_PVP[aIndex].Original.AttackDamageMinRight)
					PLAYER_PVP[aIndex].NewValue.AttackDamageMaxRight = PLAYER_PVP[aIndex].NewValue.AttackDamageMaxRight + ((PLAYER_PVP[aIndex].Original.AttackDamageMaxRight * ItemAttributes_Config.Attributes[item.Attribute].DamageMultiply) - PLAYER_PVP[aIndex].Original.AttackDamageMaxRight)
					
                end

                if ItemAttributes_Config.Attributes[item.Attribute].MagicDamageAdd ~= 0
                then
					PLAYER_PVP[aIndex].NewValue.MagicDamageMin = PLAYER_PVP[aIndex].NewValue.MagicDamageMin +ItemAttributes_Config.Attributes[item.Attribute].MagicDamageAdd
					PLAYER_PVP[aIndex].NewValue.MagicDamageMax = PLAYER_PVP[aIndex].NewValue.MagicDamageMax +ItemAttributes_Config.Attributes[item.Attribute].MagicDamageAdd
                end
            
                if ItemAttributes_Config.Attributes[item.Attribute].MagicDamageMultiply ~= 0
                then
					PLAYER_PVP[aIndex].NewValue.MagicDamageMin = PLAYER_PVP[aIndex].NewValue.MagicDamageMin + ((PLAYER_PVP[aIndex].Original.MagicDamageMin * ItemAttributes_Config.Attributes[item.Attribute].MagicDamageMultiply) - PLAYER_PVP[aIndex].Original.MagicDamageMin)
					PLAYER_PVP[aIndex].NewValue.MagicDamageMax = PLAYER_PVP[aIndex].NewValue.MagicDamageMax + ((PLAYER_PVP[aIndex].Original.MagicDamageMax * ItemAttributes_Config.Attributes[item.Attribute].MagicDamageMultiply) - PLAYER_PVP[aIndex].Original.MagicDamageMax)
                end

                if ItemAttributes_Config.Attributes[item.Attribute].AttackSpeedAdd ~= 0
                then
					PLAYER_PVP[aIndex].NewValue.AttackSpeed = PLAYER_PVP[aIndex].NewValue.AttackSpeed +ItemAttributes_Config.Attributes[item.Attribute].AttackSpeedAdd
                end
            
                if ItemAttributes_Config.Attributes[item.Attribute].AttackSpeedMultiply ~= 0
                then
					PLAYER_PVP[aIndex].NewValue.AttackSpeed = PLAYER_PVP[aIndex].NewValue.AttackSpeed + ((PLAYER_PVP[aIndex].Original.AttackSpeed * ItemAttributes_Config.Attributes[item.Attribute].AttackSpeedMultiply) - PLAYER_PVP[aIndex].Original.AttackSpeed)
                end

                if ItemAttributes_Config.Attributes[item.Attribute].MagicSpeedAdd ~= 0
                then
					PLAYER_PVP[aIndex].NewValue.MagicSpeed = PLAYER_PVP[aIndex].NewValue.MagicSpeed +ItemAttributes_Config.Attributes[item.Attribute].MagicSpeedAdd
                end
            
                if ItemAttributes_Config.Attributes[item.Attribute].MagicSpeedMultiply ~= 0
                then
					PLAYER_PVP[aIndex].NewValue.MagicSpeed = PLAYER_PVP[aIndex].NewValue.MagicSpeed + ((PLAYER_PVP[aIndex].Original.MagicSpeed * ItemAttributes_Config.Attributes[item.Attribute].MagicSpeedMultiply) - PLAYER_PVP[aIndex].Original.MagicSpeed)
                end
            end
        end
    end
end

ItemAttributes.Init()

return ItemAttributes