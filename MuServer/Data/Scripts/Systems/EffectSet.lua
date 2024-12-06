EffectSet = {}

local switch = true


function EffectSet.Init()
	if switch then
		GameServerFunctions.CharacterSet(EffectSet.CharacterSet)
	end
end

function EffectSet.CharacterSet(aIndex)
	local pInv = Inventory.new(aIndex)
	
	
	if pInv:getIndex(2) ==     GET_ITEM (7,  271)    then
        if pInv:getIndex(3) ==  GET_ITEM(8,  271)  then
        if pInv:getIndex(4) ==  GET_ITEM(9,  271)  then
        if pInv:getIndex(5) ==  GET_ITEM(10, 271) then
        if pInv:getIndex(6) ==  GET_ITEM(11, 271) then
		    if CheckBuffPlayer(aIndex, 83) == 0 then
			    Timer.TimeOut(1, AddEffect, aIndex, 0, 83, 0, 0, 0, 0, 0)
			end	
        end
        end		
        end
		end
	else
        if CheckBuffPlayer(aIndex, 83) == 1 then
            Timer.TimeOut(1, RemoveEffect,aIndex, 83)
		end	
    end		
	
	if pInv:getIndex(2) ==   GET_ITEM (7, 100)    then
        if pInv:getIndex(3) ==  GET_ITEM(8, 100)  then
        if pInv:getIndex(4) ==  GET_ITEM(9, 100)  then
        if pInv:getIndex(5) ==  GET_ITEM(10, 100) then
        if pInv:getIndex(6) ==  GET_ITEM(11, 100) then
		    if CheckBuffPlayer(aIndex, 7) == 0 then
			    Timer.TimeOut(1, AddEffect, aIndex, 0, 7, 0, 0, 0, 0, 0)
			end	
        end
        end		
        end
		end
	else
        if CheckBuffPlayer(aIndex, 85) == 1 then
            Timer.TimeOut(1, RemoveEffect,aIndex, 85)
		end	
    end		
	
	if pInv:getIndex(2) ==   GET_ITEM (7, 223)    then
        if pInv:getIndex(3) ==  GET_ITEM(8, 223)  then
        if pInv:getIndex(4) ==  GET_ITEM(9, 223)  then
        if pInv:getIndex(5) ==  GET_ITEM(10, 223) then
        if pInv:getIndex(6) ==  GET_ITEM(11, 223) then
		    if CheckBuffPlayer(aIndex, 85) == 0 then
			    Timer.TimeOut(1, AddEffect, aIndex, 0, 85, 0, 0, 0, 0, 0)
			end	
        end
        end		
        end
		end
	else
        if CheckBuffPlayer(aIndex, 85) == 1 then
            Timer.TimeOut(1, RemoveEffect,aIndex, 85)
		end	
    end		
	
	if pInv:getIndex(2) ==   GET_ITEM (7, 245)    then
        if pInv:getIndex(3) ==  GET_ITEM(8, 245)  then
        if pInv:getIndex(4) ==  GET_ITEM(9, 245)  then
        if pInv:getIndex(5) ==  GET_ITEM(10, 245) then
        if pInv:getIndex(6) ==  GET_ITEM(11, 245) then
		    if CheckBuffPlayer(aIndex, 7) == 0 then
			    Timer.TimeOut(1, AddEffect, aIndex, 0, 7, 0, 0, 0, 0, 0)
			end	
        end
        end		
        end
		end	   

	end		
	
	if pInv:getIndex(2) ==   GET_ITEM (7, 223)    then
        if pInv:getIndex(3) ==  GET_ITEM(8, 223)  then
        if pInv:getIndex(4) ==  GET_ITEM(9, 223)  then
        if pInv:getIndex(5) ==  GET_ITEM(10, 223) then
        if pInv:getIndex(6) ==  GET_ITEM(11, 223) then
		    if CheckBuffPlayer(aIndex, 7) == 0 then
			    Timer.TimeOut(1, AddEffect, aIndex, 0, 7, 0, 0, 0, 0, 0)
			end	
        end
        end		
        end
		end	
		
		
	end	
	if pInv:getIndex(2) ==   GET_ITEM (7, 263)    then
        if pInv:getIndex(3) ==  GET_ITEM(8, 263)  then
        if pInv:getIndex(4) ==  GET_ITEM(9, 263)  then
        if pInv:getIndex(5) ==  GET_ITEM(10, 263) then
        if pInv:getIndex(6) ==  GET_ITEM(11, 263) then
		    if CheckBuffPlayer(aIndex, 7) == 0 then
			    Timer.TimeOut(1, AddEffect, aIndex, 0, 7, 0, 0, 0, 0, 0)
			end	
        end
        end		
        end
		end				
		
	end	
	if pInv:getIndex(2) ==   GET_ITEM (7, 262)    then
        if pInv:getIndex(3) ==  GET_ITEM(8, 262)  then
        if pInv:getIndex(4) ==  GET_ITEM(9, 262)  then
        if pInv:getIndex(5) ==  GET_ITEM(10, 262) then
        if pInv:getIndex(6) ==  GET_ITEM(11, 262) then
		    if CheckBuffPlayer(aIndex, 7) == 0 then
			    Timer.TimeOut(1, AddEffect, aIndex, 0, 7, 0, 0, 0, 0, 0)
			end	
        end
        end		
        end
		end			
		
	end	
	if pInv:getIndex(2) ==   GET_ITEM (7, 261)    then
        if pInv:getIndex(3) ==  GET_ITEM(8, 261)  then
        if pInv:getIndex(4) ==  GET_ITEM(9, 261)  then
        if pInv:getIndex(5) ==  GET_ITEM(10, 261) then
        if pInv:getIndex(6) ==  GET_ITEM(11, 261) then
		    if CheckBuffPlayer(aIndex, 7) == 0 then
			    Timer.TimeOut(1, AddEffect, aIndex, 0, 7, 0, 0, 0, 0, 0)
			end	
        end
        end		
        end
		end			
		
	end	
	if pInv:getIndex(2) ==   GET_ITEM (7, 260)    then
        if pInv:getIndex(3) ==  GET_ITEM(8, 260)  then
        if pInv:getIndex(4) ==  GET_ITEM(9, 260)  then
        if pInv:getIndex(5) ==  GET_ITEM(10, 260) then
        if pInv:getIndex(6) ==  GET_ITEM(11, 260) then
		    if CheckBuffPlayer(aIndex, 7) == 0 then
			    Timer.TimeOut(1, AddEffect, aIndex, 0, 7, 0, 0, 0, 0, 0)
			end	
        end
        end		
        end
		end			
		
	end	
	
	if pInv:getIndex(2) ==   GET_ITEM   (7,  271)    then
        if pInv:getIndex(3) ==  GET_ITEM(8,  271)  then
        if pInv:getIndex(4) ==  GET_ITEM(9,  271)  then
        if pInv:getIndex(5) ==  GET_ITEM(10, 271) then
        if pInv:getIndex(6) ==  GET_ITEM(11, 271) then
		    if CheckBuffPlayer(aIndex, 7) == 0 then
			    Timer.TimeOut(1, AddEffect, aIndex, 0, 7, 0, 0, 0, 0, 0)
			end	
        end
        end		
        end
		end				
		
	end		
	if pInv:getIndex(2) ==   GET_ITEM (7, 259)    then
        if pInv:getIndex(3) ==  GET_ITEM(8, 259)  then
        if pInv:getIndex(4) ==  GET_ITEM(9, 259)  then
        if pInv:getIndex(5) ==  GET_ITEM(10, 259) then
        if pInv:getIndex(6) ==  GET_ITEM(11, 259) then
		    if CheckBuffPlayer(aIndex, 7) == 0 then
			    Timer.TimeOut(1, AddEffect, aIndex, 0, 7, 0, 0, 0, 0, 0)
			end	
        end
        end		
        end
		end				
		
	end	
	if pInv:getIndex(2) ==   GET_ITEM (7, 258)    then
        if pInv:getIndex(3) ==  GET_ITEM(8, 258)  then
        if pInv:getIndex(4) ==  GET_ITEM(9, 258)  then
        if pInv:getIndex(5) ==  GET_ITEM(10, 258) then
        if pInv:getIndex(6) ==  GET_ITEM(11, 258) then
		    if CheckBuffPlayer(aIndex, 7) == 0 then
			    Timer.TimeOut(1, AddEffect, aIndex, 0, 7, 0, 0, 0, 0, 0)
			end	
        end
        end		
        end
		end			
		
	end	
	if pInv:getIndex(2) ==   GET_ITEM (7, 257)    then
        if pInv:getIndex(3) ==  GET_ITEM(8, 257)  then
        if pInv:getIndex(4) ==  GET_ITEM(9, 257)  then
        if pInv:getIndex(5) ==  GET_ITEM(10, 257) then
        if pInv:getIndex(6) ==  GET_ITEM(11, 257) then
		    if CheckBuffPlayer(aIndex, 7) == 0 then
			    Timer.TimeOut(1, AddEffect, aIndex, 0, 7, 0, 0, 0, 0, 0)
			end	
        end
        end		
        end
		end				
		
	end	
	if pInv:getIndex(2) ==   GET_ITEM (7, 232)    then
        if pInv:getIndex(3) ==  GET_ITEM(8, 232)  then
        if pInv:getIndex(4) ==  GET_ITEM(9, 232)  then
        if pInv:getIndex(5) ==  GET_ITEM(10, 232) then
        if pInv:getIndex(6) ==  GET_ITEM(11, 232) then
		    if CheckBuffPlayer(aIndex, 7) == 0 then
			    Timer.TimeOut(1, AddEffect, aIndex, 0, 7, 0, 0, 0, 0, 0)
			end	
        end
        end		
        end
		end			
		
	end	
	if pInv:getIndex(2) ==   GET_ITEM (7, 231)    then
        if pInv:getIndex(3) ==  GET_ITEM(8, 231)  then
        if pInv:getIndex(4) ==  GET_ITEM(9, 231)  then
        if pInv:getIndex(5) ==  GET_ITEM(10, 231) then
        if pInv:getIndex(6) ==  GET_ITEM(11, 231) then
		    if CheckBuffPlayer(aIndex, 7) == 0 then
			    Timer.TimeOut(1, AddEffect, aIndex, 0, 7, 0, 0, 0, 0, 0)
			end	
        end
        end		
        end
		end			
		
	end	
	if pInv:getIndex(2) ==   GET_ITEM (7, 241)    then
        if pInv:getIndex(3) ==  GET_ITEM(8, 241)  then
        if pInv:getIndex(4) ==  GET_ITEM(9, 241)  then
        if pInv:getIndex(5) ==  GET_ITEM(10, 241) then
        if pInv:getIndex(6) ==  GET_ITEM(11, 241) then
		    if CheckBuffPlayer(aIndex, 7) == 0 then
			    Timer.TimeOut(1, AddEffect, aIndex, 0, 7, 0, 0, 0, 0, 0)
			end	
        end
        end		
        end
		end	
		
	end	
	if pInv:getIndex(2) ==   GET_ITEM (7, 110)    then
        if pInv:getIndex(3) ==  GET_ITEM(8, 110)  then
        if pInv:getIndex(4) ==  GET_ITEM(9, 110)  then
        if pInv:getIndex(5) ==  GET_ITEM(10, 110) then
        if pInv:getIndex(6) ==  GET_ITEM(11, 110) then
		    if CheckBuffPlayer(aIndex, 7) == 0 then
			    Timer.TimeOut(1, AddEffect, aIndex, 0, 7, 0, 0, 0, 0, 0)
			end	
        end
        end		
        end
		end	
		
	end	
	if pInv:getIndex(2) ==   GET_ITEM (7, 240)    then
        if pInv:getIndex(3) ==  GET_ITEM(8, 240)  then
        if pInv:getIndex(4) ==  GET_ITEM(9, 240)  then
        if pInv:getIndex(5) ==  GET_ITEM(10, 240) then
        if pInv:getIndex(6) ==  GET_ITEM(11, 240) then
		    if CheckBuffPlayer(aIndex, 7) == 0 then
			    Timer.TimeOut(1, AddEffect, aIndex, 0, 7, 0, 0, 0, 0, 0)
			end	
        end
        end		
        end
		end
	else
        if CheckBuffPlayer(aIndex, 85) == 1 then
            Timer.TimeOut(1, RemoveEffect,aIndex, 85)
		end	
    end		
	
	if pInv:getIndex(2) ==   GET_ITEM (7, 237)    then
        if pInv:getIndex(3) ==  GET_ITEM(8, 237)  then
        if pInv:getIndex(4) ==  GET_ITEM(9, 237)  then
        if pInv:getIndex(5) ==  GET_ITEM(10, 237) then
        if pInv:getIndex(6) ==  GET_ITEM(11, 237) then
		    if CheckBuffPlayer(aIndex, 7) == 0 then
			    Timer.TimeOut(1, AddEffect, aIndex, 0, 7, 0, 0, 0, 0, 0)
			end	
        end
        end		
        end
		end
	else
        if CheckBuffPlayer(aIndex, 85) == 1 then
            Timer.TimeOut(1, RemoveEffect,aIndex, 85)
		end	
    end		
	
	if pInv:getIndex(2) ==   GET_ITEM (7, 303)    then
        if pInv:getIndex(3) ==  GET_ITEM(8, 303)  then
        if pInv:getIndex(4) ==  GET_ITEM(9, 303)  then
        if pInv:getIndex(5) ==  GET_ITEM(10, 303) then
        if pInv:getIndex(6) ==  GET_ITEM(11, 303) then
		    if CheckBuffPlayer(aIndex, 7) == 0 then
			    Timer.TimeOut(1, AddEffect, aIndex, 0, 7, 0, 0, 0, 0, 0)
			end	
        end
        end		
        end
		end
	else
        if CheckBuffPlayer(aIndex, 85) == 1 then
            Timer.TimeOut(1, RemoveEffect,aIndex, 85)
		end	
    end		
	
	if pInv:getIndex(2) ==   GET_ITEM (7, 227)    then
        if pInv:getIndex(3) ==  GET_ITEM(8, 227)  then
        if pInv:getIndex(4) ==  GET_ITEM(9, 227)  then
        if pInv:getIndex(5) ==  GET_ITEM(10, 227) then
        if pInv:getIndex(6) ==  GET_ITEM(11, 227) then
		    if CheckBuffPlayer(aIndex, 7) == 0 then
			    Timer.TimeOut(1, AddEffect, aIndex, 0, 7, 0, 0, 0, 0, 0)
			end	
        end
        end		
        end
		end
	else
        if CheckBuffPlayer(aIndex, 85) == 1 then
            Timer.TimeOut(1, RemoveEffect,aIndex, 85)
		end	
    end		
	
	if pInv:getIndex(2) ==   GET_ITEM (7, 224)    then
        if pInv:getIndex(3) ==  GET_ITEM(8, 224)  then
        if pInv:getIndex(4) ==  GET_ITEM(9, 224)  then
        if pInv:getIndex(5) ==  GET_ITEM(10, 224) then
        if pInv:getIndex(6) ==  GET_ITEM(11, 224) then
		    if CheckBuffPlayer(aIndex, 7) == 0 then
			    Timer.TimeOut(1, AddEffect, aIndex, 0, 7, 0, 0, 0, 0, 0)
			end	
        end
        end		
        end
		end
	else
        if CheckBuffPlayer(aIndex, 85) == 1 then
            Timer.TimeOut(1, RemoveEffect,aIndex, 85)
		end	
    end	
	
	
	if pInv:getIndex(2) ==   GET_ITEM (7, 227)    then
        if pInv:getIndex(3) ==  GET_ITEM(8, 227)  then
        if pInv:getIndex(4) ==  GET_ITEM(9, 227)  then
        if pInv:getIndex(5) ==  GET_ITEM(10, 227) then
        if pInv:getIndex(6) ==  GET_ITEM(11, 227) then
		    if CheckBuffPlayer(aIndex, 84) == 0 then
			    Timer.TimeOut(1, AddEffect, aIndex, 0, 84, 0, 0, 0, 0, 0)
			end	
        end
        end		
        end
		end
	else
        if CheckBuffPlayer(aIndex, 84) == 1 then
            Timer.TimeOut(1, RemoveEffect,aIndex, 84)
		end			
	end
	
	if pInv:getIndex(2) ==   GET_ITEM (7, 303)    then
        if pInv:getIndex(3) ==  GET_ITEM(8, 303)  then
        if pInv:getIndex(4) ==  GET_ITEM(9, 303)  then
        if pInv:getIndex(5) ==  GET_ITEM(10, 303) then
        if pInv:getIndex(6) ==  GET_ITEM(11, 303) then
		    if CheckBuffPlayer(aIndex, 84) == 0 then
			    Timer.TimeOut(1, AddEffect, aIndex, 0, 84, 0, 0, 0, 0, 0)
			end	
        end
        end		
        end
		end
	else
        if CheckBuffPlayer(aIndex, 84) == 1 then
            Timer.TimeOut(1, RemoveEffect,aIndex, 84)
		end		
    end
end	
	    
		
EffectSet.Init()


return EffectSet