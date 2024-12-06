SimpleItemAttributes = {}

function SimpleItemAttributes.Init()
    if SimpleItemAttributes_Config.Enabled then
        GameServerFunctions.CharacterSet(SimpleItemAttributes.CharacterSet)
    end
end

function SimpleItemAttributes.CharacterSet(aIndex)
    local player = User.new(aIndex)
    local pInv = Inventory.new(aIndex)
	local playerItens = {
		[0] =   {Index = pInv:getIndex(0),   Level = pInv:getLevel(0)},
		[1] =   {Index = pInv:getIndex(1),   Level = pInv:getLevel(1)},
		[2] =   {Index = pInv:getIndex(2),   Level = pInv:getLevel(2)},
		[3] =   {Index = pInv:getIndex(3),   Level = pInv:getLevel(3)},
		[4] =   {Index = pInv:getIndex(4),   Level = pInv:getLevel(4)},
		[5] =   {Index = pInv:getIndex(5),   Level = pInv:getLevel(5)},
		[6] =   {Index = pInv:getIndex(6),   Level = pInv:getLevel(6)},
		[7] =   {Index = pInv:getIndex(7),   Level = pInv:getLevel(7)},
		[8] =   {Index = pInv:getIndex(8),   Level = pInv:getLevel(8)},
		[9] =   {Index = pInv:getIndex(9),   Level = pInv:getLevel(9)},
		[10] =  {Index = pInv:getIndex(10),  Level = pInv:getLevel(10)},
		[11] =  {Index = pInv:getIndex(11),  Level = pInv:getLevel(11)},
		[15] =  {Index = pInv:getIndex(15),  Level = pInv:getLevel(15)},
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

    for i in ipairs(SimpleItemAttributes_Config.Itens) do
        local item = SimpleItemAttributes_Config.Itens[i]
        
        if playerItens[item.Slot].Index == GET_ITEM(item.Section, item.Index) then
            if item.Level == -1 or item.Level == playerItens[item.Slot].Level then
                if SimpleItemAttributes_Config.Attributes[item.Attribute].DefenseAdd ~= 0    then
                    player:setDefense((math.floor(player:getDefense() + SimpleItemAttributes_Config.Attributes[item.Attribute].DefenseAdd)))
                    player:setDefensePvP((math.floor(player:getDefensePvP() + SimpleItemAttributes_Config.Attributes[item.Attribute].DefenseAdd)))
                end

                if SimpleItemAttributes_Config.Attributes[item.Attribute].LifeAdd ~= 0
                then
                    player:setAddLife((math.floor(player:getAddLife() + SimpleItemAttributes_Config.Attributes[item.Attribute].LifeAdd)))
                end

                if SimpleItemAttributes_Config.Attributes[item.Attribute].DamageAdd ~= 0 
                then
                    player:setAttackDamageMinLeft((math.floor(player:getAttackDamageMinLeft() + SimpleItemAttributes_Config.Attributes[item.Attribute].DamageAdd)))
                    player:setAttackDamageMaxLeft((math.floor(player:getAttackDamageMaxLeft() + SimpleItemAttributes_Config.Attributes[item.Attribute].DamageAdd)))
                    player:setAttackDamageMinRight((math.floor(player:getAttackDamageMinRight() + SimpleItemAttributes_Config.Attributes[item.Attribute].DamageAdd)))
                    player:setAttackDamageMaxRight((math.floor(player:getAttackDamageMaxRight() + SimpleItemAttributes_Config.Attributes[item.Attribute].DamageAdd)))
                end
            end
        end
    end
end

SimpleItemAttributes.Init()

return SimpleItemAttributes