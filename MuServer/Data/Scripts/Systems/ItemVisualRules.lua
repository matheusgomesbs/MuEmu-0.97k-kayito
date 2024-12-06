--[[
    Slots Itens/ Slot Itens visuais (Interno)

    Helm: 2
    Helm Visual: 242
    
    Armor: 3
    Armor Visual: 243

    Pants: 4
    Pants Visual: 244

    Gloves: 5
    Gloves Visual: 245
    
    Boots: 6
    Boots Visual: 246
    
    Sword: 0
    Sword Visual: 240
    
    Shield: 1
    Shield Visual: 241

    Wing: 7
    Wing Visual: 247

    Pet normal: 8
    Pet normal Visual: 248
]]

ItemVisualRules = {}

ItemVisualRulesSwitch = true
ItemVisualMoveItemNormal = false

ItemEquip = 0
ItemNotEquip = 1

ItemVisualRules_slotsVisual = {}
ItemVisualRules_slotsVisual[240] = {slot = 00, blockWhenNoItem = true, messageCod = 0} -- Armas
ItemVisualRules_slotsVisual[241] = {slot = 01, blockWhenNoItem = true, messageCod = 1} -- Shield
ItemVisualRules_slotsVisual[242] = {slot = 02, blockWhenNoItem = true, messageCod = 2} -- Helm
ItemVisualRules_slotsVisual[243] = {slot = 03, blockWhenNoItem = true, messageCod = 3} -- Armor
ItemVisualRules_slotsVisual[244] = {slot = 04, blockWhenNoItem = true, messageCod = 4} -- Pants
ItemVisualRules_slotsVisual[245] = {slot = 05, blockWhenNoItem = true, messageCod = 5} -- Gloves
ItemVisualRules_slotsVisual[246] = {slot = 06, blockWhenNoItem = true, messageCod = 6} -- Boots
ItemVisualRules_slotsVisual[247] = {slot = 07, blockWhenNoItem = true, messageCod = 7} -- Wings/Capes
ItemVisualRules_slotsVisual[248] = {slot = 08, blockWhenNoItem = true, messageCod = 8} -- Pets

ItemVisualRules_slots = {}
ItemVisualRules_slots[00] = {slot = 240, blocRemoveNormalItemWhenEquipedItem = true, messageCod = 09} -- Armas
ItemVisualRules_slots[01] = {slot = 241, blocRemoveNormalItemWhenEquipedItem = true, messageCod = 10} -- Shield
ItemVisualRules_slots[02] = {slot = 242, blocRemoveNormalItemWhenEquipedItem = true, messageCod = 11} -- Helm
ItemVisualRules_slots[03] = {slot = 243, blocRemoveNormalItemWhenEquipedItem = true, messageCod = 12} -- Armor
ItemVisualRules_slots[04] = {slot = 244, blocRemoveNormalItemWhenEquipedItem = true, messageCod = 13} -- Pants
ItemVisualRules_slots[05] = {slot = 245, blocRemoveNormalItemWhenEquipedItem = true, messageCod = 14} -- Gloves
ItemVisualRules_slots[06] = {slot = 246, blocRemoveNormalItemWhenEquipedItem = true, messageCod = 15} -- Boots
ItemVisualRules_slots[07] = {slot = 247, blocRemoveNormalItemWhenEquipedItem = true, messageCod = 16} -- Wings/Capes
ItemVisualRules_slots[08] = {slot = 248, blocRemoveNormalItemWhenEquipedItem = true, messageCod = 17} -- Pets

ItemVisualRules_messages = {}
ItemVisualRules_messages['Por'] = {
    [0] = 'Você precisa estar com uma Arma equipada',
    [1] = 'Você precisa estar com um Shield equipado',
    [2] = 'Você precisa estar com um Helm equipado',
    [3] = 'Você precisa estar com um Armor equipado',
    [4] = 'Você precisa estar com uma Pants equipada',
    [5] = 'Você precisa estar com uma Gloves equipada',
    [6] = 'Você precisa estar com um Boots equipado',
    [7] = 'Você precisa estar com um(a) Wing/Cape equipada',
    [8] = 'Você precisa estar com um Pet equipado',

    [09] = 'Você precisa desequipar a Arma visual equipada',
    [10] = 'Você precisa desequipar o Shield visual equipado',
    [11] = 'Você precisa desequipar o Helm visual equipado',
    [12] = 'Você precisa desequipar o Armor visual equipado',
    [13] = 'Você precisa desequipar a Pants visual equipada',
    [14] = 'Você precisa desequipar a Gloves visual equipada',
    [15] = 'Você precisa desequipar o Boots visual equipado',
    [16] = 'Você precisa desequipar a Wing/Cape visual equipada',
    [17] = 'Você precisa desequipar o Pet visual equipado',

}

ItemVisualRules_messages['Spn'] = {
    [0] = 'Você precisa estar com uma Arma equipada',
    [1] = 'Você precisa estar com um Shield equipado',
    [2] = 'Você precisa estar com um Helm equipado',
    [3] = 'Você precisa estar com um Armor equipado',
    [4] = 'Você precisa estar com uma Pants equipada',
    [5] = 'Você precisa estar com uma Gloves equipada',
    [6] = 'Você precisa estar com um Boots equipado',
    [7] = 'Você precisa estar com um(a) Wing/Cape equipada',
    [8] = 'Você precisa estar com um Pet equipado',

    [09] = 'Você precisa desequipar a Arma visual equipada',
    [10] = 'Você precisa desequipar o Shield visual equipado',
    [11] = 'Você precisa desequipar o Helm visual equipado',
    [12] = 'Você precisa desequipar o Armor visual equipado',
    [13] = 'Você precisa desequipar a Pants visual equipada',
    [14] = 'Você precisa desequipar a Gloves visual equipada',
    [15] = 'Você precisa desequipar o Boots visual equipado',
    [16] = 'Você precisa desequipar a Wing/Cape visual equipada',
    [17] = 'Você precisa desequipar o Pet visual equipado',
}

ItemVisualRules_messages['Eng'] = {
    [0] = 'Você precisa estar com uma Arma equipada',
    [1] = 'Você precisa estar com um Shield equipado',
    [2] = 'Você precisa estar com um Helm equipado',
    [3] = 'Você precisa estar com um Armor equipado',
    [4] = 'Você precisa estar com uma Pants equipada',
    [5] = 'Você precisa estar com uma Gloves equipada',
    [6] = 'Você precisa estar com um Boots equipado',
    [7] = 'Você precisa estar com um(a) Wing/Cape equipada',
    [8] = 'Você precisa estar com um Pet equipado',

    [09] = 'Você precisa desequipar a Arma visual equipada',
    [10] = 'Você precisa desequipar o Shield visual equipado',
    [11] = 'Você precisa desequipar o Helm visual equipado',
    [12] = 'Você precisa desequipar o Armor visual equipado',
    [13] = 'Você precisa desequipar a Pants visual equipada',
    [14] = 'Você precisa desequipar a Gloves visual equipada',
    [15] = 'Você precisa desequipar o Boots visual equipado',
    [16] = 'Você precisa desequipar a Wing/Cape visual equipada',
    [17] = 'Você precisa desequipar o Pet visual equipado',
}


function ItemVisualRules.Init()
    if ItemVisualRulesSwitch then
        GameServerFunctions.PlayerCanEquipItem(ItemVisualRules.VisualSlot)
    end

    if ItemVisualMoveItemNormal then 
        GameServerFunctions.PlayerMoveItem(ItemVisualRules.NormalSlot)
    end
end

function ItemVisualRules.VisualSlot(aIndex, _, targetSlot)
    local slotCanEquipitem = ItemVisualRules_slotsVisual[targetSlot]
    local pInv = Inventory.new(aIndex)
    local player = User.new(aIndex)
	
    local idioma = player:getLanguage()
    local messages = ItemVisualRules_messages[idioma]
	
    if slotCanEquipitem ~= nil then
        if slotCanEquipitem.blockWhenNoItem then 
            if pInv:isItem(slotCanEquipitem.slot) == 0 then
                SendMessage(messages[slotCanEquipitem.messageCod], aIndex, 1)
                return ItemNotEquip
            end
        end
    end

    return ItemEquip
end

function ItemVisualRules.NormalSlot(aIndex, sourceSlot, _, _)
    local slotCanDesequipitem = ItemVisualRules_slots[sourceSlot]
    local pInv = Inventory.new(aIndex)
    local player = User.new(aIndex)

    local idioma = player:getLanguage()
    local messages = ItemVisualRules_messages[idioma]

    if slotCanDesequipitem ~= nil then
        if slotCanDesequipitem.blocRemoveNormalItemWhenEquipedItem then
            if pInv:isItem(slotCanDesequipitem.slot) ~= 0 then
                SendMessage(messages[slotCanDesequipitem.messageCod], aIndex, 1)
                return ItemNotEquip
            end
        end
    end

    return ItemEquip
end

ItemVisualRules.Init()

return ItemVisualRules