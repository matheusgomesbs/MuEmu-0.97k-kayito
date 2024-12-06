--[[ Prevent Player drop item ]]--

PreventDrop = {}

-- Level -1 = qualquer level

ITEM_DROP_BLOCK = {{Section = 13, Index = 201, Level = -1},}
ITEM_DROP_BLOCK = {{Section = 13, Index = 202, Level = -1},}
ITEM_DROP_BLOCK = {{Section = 13, Index = 203, Level = -1},}
ITEM_DROP_BLOCK = {{Section = 13, Index = 204, Level = -1},}
ITEM_DROP_BLOCK = {{Section = 13, Index = 205, Level = -1},}
ITEM_DROP_BLOCK = {{Section = 13, Index = 206, Level = -1},}
ITEM_DROP_BLOCK = {{Section = 13, Index = 207, Level = -1},}
ITEM_DROP_BLOCK = {{Section = 13, Index = 208, Level = -1},}
ITEM_DROP_BLOCK = {{Section = 13, Index = 209, Level = -1},}
ITEM_DROP_BLOCK = {{Section = 13, Index = 210, Level = -1},}
ITEM_DROP_BLOCK = {{Section = 13, Index = 211, Level = -1},}
ITEM_DROP_BLOCK = {{Section = 13, Index = 212, Level = -1},}
ITEM_DROP_BLOCK = {{Section = 13, Index = 213, Level = -1},}
ITEM_DROP_BLOCK = {{Section = 13, Index = 214, Level = -1},}
ITEM_DROP_BLOCK = {{Section = 13, Index = 268, Level =  0},}


ITEM_DROP_BLOCK = {{Section = 14, Index = 200, Level = -1},}
ITEM_DROP_BLOCK = {{Section = 14, Index = 201, Level = -1},}
ITEM_DROP_BLOCK = {{Section = 14, Index = 202, Level = -1},}
ITEM_DROP_BLOCK = {{Section = 14, Index = 203, Level = -1},}
ITEM_DROP_BLOCK = {{Section = 14, Index = 204, Level = -1},}
ITEM_DROP_BLOCK = {{Section = 14, Index = 205, Level = -1},}
ITEM_DROP_BLOCK = {{Section = 14, Index = 206, Level = -1},}
ITEM_DROP_BLOCK = {{Section = 14, Index = 207, Level = -1},}
ITEM_DROP_BLOCK = {{Section = 14, Index = 208, Level = -1},}
ITEM_DROP_BLOCK = {{Section = 14, Index = 209, Level = -1},}
ITEM_DROP_BLOCK = {{Section = 14, Index = 210, Level = -1},}
ITEM_DROP_BLOCK = {{Section = 14, Index = 211, Level = -1},}

ITEM_DROP_BLOCK = {{Section = 7,  Index = 234, Level = -1},}
ITEM_DROP_BLOCK = {{Section = 8,  Index = 234, Level = -1},}
ITEM_DROP_BLOCK = {{Section = 9,  Index = 234, Level = -1},}
ITEM_DROP_BLOCK = {{Section = 10, Index = 234, Level = -1},}
ITEM_DROP_BLOCK = {{Section = 11, Index = 234, Level = -1},}

ITEM_DROP_BLOCK = {{Section = 7,  Index = 235, Level = -1},}
ITEM_DROP_BLOCK = {{Section = 8,  Index = 235, Level = -1},}
ITEM_DROP_BLOCK = {{Section = 9,  Index = 235, Level = -1},}
ITEM_DROP_BLOCK = {{Section = 10, Index = 235, Level = -1},}
ITEM_DROP_BLOCK = {{Section = 11, Index = 235, Level = -1},}


function PreventDrop.PlayerDropItem(aIndex, x, y, position)
	local pInv = Inventory.new(aIndex)
	local item_index = pInv:getIndex(position)
	
	for i in ipairs(ITEM_DROP_BLOCK) do
		if item_index == GET_ITEM(ITEM_DROP_BLOCK[i].Section, ITEM_DROP_BLOCK[i].Index)
		then
			if (ITEM_DROP_BLOCK[i].Level == -1 or pInv:getLevel(position) == ITEM_DROP_BLOCK[i].Level)
			then
				return 1
			end
		end
	end
	
	return 0
end

GameServerFunctions.PlayerDropItem(PreventDrop.PlayerDropItem)

return PreventDrop