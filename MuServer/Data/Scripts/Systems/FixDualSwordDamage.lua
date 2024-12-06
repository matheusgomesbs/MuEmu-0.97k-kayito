FixDualSwordDamage = {}

FixDualSwordDamage.Rate = 2

function FixDualSwordDamage.Init()
    GameServerFunctions.PlayerAttack(FixDualSwordDamage.FixDamage)
end


function FixDualSwordDamage.FixDamage(aIndex)
    local player = User.new(aIndex)
    local pInv = Inventory.new(aIndex)

    if pInv:isItem(1) ~= 0 then
        for sec = 0, 3 do
            if pInv:getSection(1) == sec then
               return 1
            end
        end
    end
	
	return 0
end

FixDualSwordDamage.Init()

return FixDualSwordDamage