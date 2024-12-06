CONFIG_INVASION_SWITCH = 0

local CONFIG_INVASION_DATE = {

    {index = 1, dayofweek = -1, day = -1,  hour = 16,  minute = 25},
	

}

local CONFIG_INVASION_SYSTEM = {}


CONFIG_INVASION_SYSTEM[1] = {
    name = "Ora Ora", duration = 30, announce_global = 1, announce_death = 1, event_bag = -1
	
}




local INVASION_MONSTER_CREATE = {}


INVASION_MONSTER_CREATE[1] = {
    {class = 424, map = 83, count = 100},
}


local MONSTER_DROP_CLASS = {}

-- [01] GOLDEN DRAGON INVASION (LORENCIA)

MONSTER_DROP_CLASS[1] = {
    { class = 424, section = 14, item_index = 269,   level = 0, luck = 0, skill = 0, opt = 0, exc = 0, count = 25},
	
}


local INVASION_MESSAGES = { }

INVASION_MESSAGES["Por"] = {
[1] = "A Invasão: %s, começou!!! ",
[2] = "A Invasão: %s acabou!!!",
[3] = "%s matou um %s",
[4] = "Restam %d monstros vivos!",
}

INVASION_MESSAGES["Eng"] = {
[1] = "The Invasion: %s has started !!! ",
[2] = "The Invasion: %s is over !!!",
[3] = "%s killed a %s",
[4] = "%d monsters left alive!",
}

INVASION_MESSAGES["Spn"] = {
[1] = "¡¡¡La invasión: %s ha comenzado !!! ",
[2] = "La invasión: ¡¡¡ %s terminó !!!",
[3] = "%s mató a %s",
[4] = "¡%d monstruos quedan vivos!",
}

Invasion = {}

--System
local INVASION_MONSTERS = {}
local INVASION_SYSTEM = {}
local INVASION_ITEMS_RAND = {}

function Invasion.Init()
    if CONFIG_INVASION_SWITCH ~= 1
    then
        return
    end

    GameServerFunctions.MonsterDie(Invasion.MonsterDie)
	GameServerFunctions.MonsterDieGiveItem(Invasion.MonsterDieGiveItem)

    Timer.Interval(1, Invasion.Running)

    for i in ipairs(CONFIG_INVASION_DATE) do
		if CONFIG_INVASION_DATE[i].dayofweek ~= -1
		then
			Schedule.SetDayOfWeek(CONFIG_INVASION_DATE[i].dayofweek, CONFIG_INVASION_DATE[i].hour, CONFIG_INVASION_DATE[i].minute, Invasion.Start, CONFIG_INVASION_DATE[i].index)
		elseif CONFIG_INVASION_DATE[i].day ~= -1
		then
			Schedule.SetDayAndHourAndMinute(CONFIG_INVASION_DATE[i].day, CONFIG_INVASION_DATE[i].hour, CONFIG_INVASION_DATE[i].minute, Invasion.Start, CONFIG_INVASION_DATE[i].index)
		else
			Schedule.SetHourAndMinute(CONFIG_INVASION_DATE[i].hour, CONFIG_INVASION_DATE[i].minute, Invasion.Start, CONFIG_INVASION_DATE[i].index)
		end
	end
end

function Invasion.Start(index)
    local getInvasion = CONFIG_INVASION_SYSTEM[index]

    if getInvasion ~= nil
    then
        Message.SendMessageGlobalMultLangArgs(INVASION_MESSAGES, 1, 0, getInvasion.name)

        local monsterInvasion = INVASION_MONSTER_CREATE[index]

        if monsterInvasion ~= nil
        then
            for n=1, #monsterInvasion do
                local monster = monsterInvasion[n]

                if monster ~= nil
                then
                    Invasion.CreateMonster(index, monster.class, monster.map, monster.count)
                end
            end
        end

        table.insert(INVASION_SYSTEM, 
                    { _index = index, 
                    _end = getInvasion.duration * 60,
                    _state = true,
                    _running = true, 
                    _Name = getInvasion.name,
                    _Announce_Death = getInvasion.announce_death,
                    _Announce_Global = getInvasion.announce_global,
                    _EventBag = getInvasion.event_bag }
                    )
    end
end

function Invasion.Running()
    if #INVASION_SYSTEM <= 0
    then
        return
    end

    for n = 1, #INVASION_SYSTEM do
        local getInvasion = INVASION_SYSTEM[n]

        if getInvasion ~= nil
        then
            if getInvasion._running == true
            then
                if getInvasion._end <= 0
                then
                    Invasion.InvasionEnd(n)
                else
                    getInvasion._end = getInvasion._end - 1
                end
            end
        end
    end
end

function Invasion.CreateMonster(invasion, class, map, count)
    for i = 1, count do
		local index = AddMonster(map)
		
		if index == -1
		then
			LogAdd(string.format("[Invasion] Problema ao criar o monstro :%d", class))
			return
		end
		
		local monster = User.new(index)
		
		SetPositionMonster(index, map)
		SetMonster(index, class)
		
		monster:setRegenTime(0)
		
		LogAdd(string.format("[Invasion] Class:%d Map:%d CoordX:%d CoordY:%d",class, monster:getMapNumber(), monster:getX(), monster:getY()))
		
        INVASION_MONSTERS[index] = {_index = index, invasionIndex = invasion, class = class}
	end
end

function Invasion.InvasionEnd(invasion)
    local getInvasion = INVASION_SYSTEM[invasion]

    if getInvasion == nil
    then
        return
    end

	--Anunciar no global o fim da 
	Message.SendMessageGlobalMultLangArgs(INVASION_MESSAGES, 2, 0, getInvasion._Name)
	
	--Remove os monstros
	Invasion.ClearInvasionBy(invasion)
	
	--Limpar o sistema
	Invasion.ClearSystemByInvasion(invasion)
end

function Invasion.ClearInvasionBy(index)
	local getInvasion = INVASION_SYSTEM[index]

    if getInvasion == nil
    then
        return
    end

    --Remover monstros caso exista algum vivo
    Invasion.ClearByMonster(index)
end

function Invasion.ClearByMonster(index)
    for key in pairs(INVASION_MONSTERS) do
		if INVASION_MONSTERS[key].invasionIndex == index
		then
			if INVASION_MONSTERS[key]._index ~= -1
			then
				gObjDel(INVASION_MONSTERS[key]._index)
				INVASION_MONSTERS[key] = nil
            else
                INVASION_MONSTERS[key] = nil
			end
		end
	end
end

function Invasion.ClearSystemByInvasion(index)
    local getInvasion = INVASION_SYSTEM[index]

    if getInvasion == nil
    then
        return
    end

    INVASION_SYSTEM[index] = nil
end

function Invasion.DelByMonster(invasion, index)

	for key in pairs(INVASION_MONSTERS) do
		if INVASION_MONSTERS[key].invasionIndex == invasion
		then
			if INVASION_MONSTERS[key]._index == index
			then
				if INVASION_MONSTERS[key]._index ~= -1
				then
					gObjDel(INVASION_MONSTERS[key]._index)
					
					INVASION_MONSTERS[key]._index = -1
				end
			end
		end
	end
end

function Invasion.GetByMonster(invasion, index)
	if INVASION_MONSTERS[index] == nil
	then
		return -1
	end
	
	if INVASION_MONSTERS[index]._index == -1
	then
		return -1
	end
	
	if INVASION_MONSTERS[index].invasionIndex == invasion
	then
		return INVASION_MONSTERS[index]._index
	end
	
	return -1
end

function Invasion.GetCountMonsterByInvasion(invasion)
	local count = 0

	for key in pairs(INVASION_MONSTERS) do
		if INVASION_MONSTERS[key].invasionIndex == invasion
		then
			if INVASION_MONSTERS[key]._index ~= -1
			then
				count = count + 1
			end
		end
	end
	
	return count
end

function Invasion.InsertItens(item)
	InsertKey(INVASION_ITEMS_RAND, item)
end

function Invasion.GetItemRand()
	if #INVASION_ITEMS_RAND > 0
	then
		return GetRand(1, #INVASION_ITEMS_RAND)
	end
	
	return -1
end

function Invasion.DropItemByMonster(index, Player, Monster)
	INVASION_ITEMS_RAND = {}

	local monster = User.new(Monster)
    local monsterDrop = MONSTER_DROP_CLASS[index]

    if monsterDrop ~= nil
    then
        for i = 1, #monsterDrop do 
            local monsterInfo = monsterDrop[i]

            if monsterInfo ~= nil
            then
                if monsterInfo.class == monster:getClass()
                then
                    Invasion.InsertItens(monsterInfo)
                end
            end
        end
    end
	
	local key_rand = Invasion.GetItemRand()
	
	if key_rand == -1
	then
		LogAdd("[Invasion] Existe uma má configuração no sistema de dropar item")
		return
	end

    local player = User.new(Player)
	
	local ItemDrop = INVASION_ITEMS_RAND[key_rand]
	
	for i = 1, ItemDrop.count do
		ItemSerialCreate(Player, player:getMapNumber(), player:getX(), player:getY(), GET_ITEM(ItemDrop.section, ItemDrop.item_index), ItemDrop.level, 255, ItemDrop.luck, ItemDrop.skill, ItemDrop.opt, ItemDrop.exc)
	end
end

function Invasion.MonsterDie(Player, Monster)
    if #INVASION_SYSTEM <= 0
    then
        return
    end

    local player = User.new(Player)
	local monster = User.new(Monster)
	
	for key = 1, #INVASION_SYSTEM do
        local invasionInfo = INVASION_SYSTEM[key]

        if invasionInfo ~= nil
        then
            if invasionInfo._running == true
            then
                if Invasion.GetByMonster(invasionInfo._index, Monster) == Monster
                then
                    --Monstrar no global que o player X matou o monstro X
                    if invasionInfo._Announce_Death == 1
                    then
                        Message.SendMessageGlobalMultLangArgs(INVASION_MESSAGES, 3, 0, player:getName(), monster:getName())
                    end
                    
                    --Dizer quantos monstros restam
                    if invasionInfo._Announce_Global == 1
                    then
                        local MonsterCount = math.abs(Invasion.GetCountMonsterByInvasion(invasionInfo._index) - 1)
                        if MonsterCount > 0
                        then
                            Message.SendMessageGlobalMultLangArgs(INVASION_MESSAGES, 4, 0, MonsterCount)
                        else
                            --Finalizar a invasão mataram todos monstros
                            Timer.TimeOut(5, Invasion.InvasionEnd, key)
                        end
                    end
                end
            end
        end
	end
end

function Invasion.MonsterDieGiveItem(Player, Monster)
    if #INVASION_SYSTEM <= 0
    then
        return 0
    end

    for key = 1, #INVASION_SYSTEM do
        local invasionInfo = INVASION_SYSTEM[key]

        if invasionInfo ~= nil
        then
            if invasionInfo._running == true
            then
                if Invasion.GetByMonster(invasionInfo._index, Monster) == Monster
                then
                    --Sistema onde vai gerar 1 item aleatório
                    Invasion.DropItemByMonster(invasionInfo._index, Player, Monster)
                    
                    --Remover o monstro do sistema
                    Invasion.DelByMonster(invasionInfo._index, Monster)
                    return 1
                end
            end
        end
	end

    return 0
end

Invasion.Init()

return Invasion