CustomSD = {}

function CustomSD.Init()
    if CustomSD_Config.Enable then
        GameServerFunctions.CharacterSet(CustomSD.SetSD)
        Timer.Interval(1, CustomSD.Recovery)
    end
end

function CustomSD.Recovery()
    for aIndex = 13000, 13999 do
        local player = User.new(aIndex)
       
        if player:getCacheInt("sdrecoveryOn") == 1 then
            if player:getCacheInt("sdrecoveryCount") >= player:getCacheInt("sdrecoveryTime") then
                player:setShield(math.floor(player:getMaxShield()*player:getCacheInt("sdrecoveryRate")))
                RefreshCharacter(aIndex)
                player:setCacheInt("sdrecoveryCount", 0)
            else
                player:setCacheInt("sdrecoveryCount", player:getCacheInt("sdrecoveryCount")+1)
            end
        end
    end
end

function CustomSD.SetSD(aIndex)
    
    local player = User.new(aIndex)
    local pInv = Inventory.new(aIndex)

    local brinco = {
        Right = pInv:getIndex(238),
        Left = pInv:getIndex(239)
    }

    if brinco.Right ~= -1 then
        if CustomSD_Config.RightEar[brinco.Right] ~= nil then
            local newmax = math.floor(player:getMaxShield()*CustomSD_Config.RightEar[brinco.Right])
            if player:getShield() <= 0 then
                player:setMaxShield(newmax)
                player:setShield(newmax)
                RefreshCharacter(aIndex)
            end

            if brinco.Left ~= -1 then
                if CustomSD_Config.LeftEar[brinco.Left] ~= nil then
                    player:setCacheInt("sdrecoveryOn", 1)
                    player:setCacheInt("sdrecoveryTime", CustomSD_Config.LeftEar[brinco.Left].Time)
                    player:setCacheInt("sdrecoveryRate", CustomSD_Config.LeftEar[brinco.Left].Rate)
                    if player:getCacheInt("sdrecoveryCount") <= 0 then
                        player:setCacheInt("sdrecoveryCount", 0)
                    end
                    return
                end
            end
            player:setCacheInt("sdrecoveryOn", 0)
            player:setCacheInt("sdrecoveryTime", 0)
            player:setCacheInt("sdrecoveryRate", 0)
            player:setCacheInt("sdrecoveryCount", 0)
            return       
        end
    end
    player:setCacheInt("sdrecoveryOn", 0)
    player:setCacheInt("sdrecoveryTime", 0)
    player:setCacheInt("sdrecoveryRate", 0)
    player:setCacheInt("sdrecoveryCount", 0)
    player:setShield(0)
    player:setMaxShield(0)
    RefreshCharacter(aIndex)
end

CustomSD.Init()

return CustomSD