BuffBrinco = {}

local switch = false


function BuffBrinco.Init()
	if switch then
		GameServerFunctions.CharacterSet(BuffBrinco.CharacterSet)
	end
end

function BuffBrinco.CharacterSet(aIndex)
	local pInv = Inventory.new(aIndex)
	local player = User.new(aIndex)
	
	
	if pInv:isItem(238) ~= 0 and pInv:isItem(239) ~= 0 then
		local direito = pInv:getIndex(239)
		local esquerdo = pInv:getIndex(238)
		
		if direito == GET_ITEM(13, 225) and esquerdo == GET_ITEM(13, 224) then
			Timer.TimeOut(50,  AddEffect, aIndex, 0, 114, 0, 0, 0, 0, 0)
		end
		
		if direito == GET_ITEM(13, 227) and esquerdo == GET_ITEM(13,226) then	
			Timer.TimeOut(50,  AddEffect, aIndex, 0, 114, 0, 0, 0, 0, 0)
		end
		
		if direito == GET_ITEM(13, 230) and esquerdo == GET_ITEM(13, 229) then
			Timer.TimeOut(50,  AddEffect, aIndex, 0, 114, 0, 0, 0, 0, 0)
		end		
		
		
		if direito == GET_ITEM(13, 235) and esquerdo == GET_ITEM(13, 234) then
			Timer.TimeOut(50,  AddEffect, aIndex, 0, 114, 0, 0, 0, 0, 0)
		end
	else
		if CheckBuffPlayer(aIndex, 114) == 1 then
			Timer.TimeOut(50, RemoveEffect, aIndex, 114)
		end
	end
end

BuffBrinco.Init()


return BuffBrinco