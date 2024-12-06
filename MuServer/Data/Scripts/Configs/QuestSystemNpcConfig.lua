QUEST_SYSTEM_NPC_SWITCH = 0

QUEST_SYSTEM_NPC_ONLY_ACCOUNT =   1 -- if = 1, the quest will be only per account, if is 0, is per personagem
QUEST_SYSTEM_NPC_REMOVE_RESETS =  1
QUEST_SYSTEM_NPC_REMOVE_MRESETS = 1
QUEST_SYSTEM_NPC_REMOVE_COIN1 =   1
QUEST_SYSTEM_NPC_REMOVE_COIN2 =   1
QUEST_SYSTEM_NPC_REMOVE_COIN3 =   1

QUEST_SYSTEM_NPC_ONLY_ONE_QUEST = 0 -- if = 1, when player start a quest and cancel or finish he can't start again

--Npc Identification
QUEST_SYSTEM_NPC_LOCATION_INFO = {}

QUEST_SYSTEM_NPC_LOCATION_INFO = {
    { Class = 247, Map = 0,  CoordX = 130,  CoordY = 134,  QuestIdentification = 1},
    { Class = 249, Map = 3,  CoordX = 169,  CoordY = 111,  QuestIdentification = 2},
	{ Class = 247, Map = 2,  CoordX = 183,  CoordY = 29,   QuestIdentification = 3},
	{ Class = 247, Map = 7,  CoordX = 17,   CoordY = 25,   QuestIdentification = 4},
	{ Class = 247, Map = 0,  CoordX = 130,  CoordY = 121,  QuestIdentification = 5},
	{ Class = 247, Map = 4,  CoordX = 202,  CoordY = 82,   QuestIdentification = 6},
	{ Class = 247, Map = 8,  CoordX = 197,  CoordY = 59,   QuestIdentification = 7},
    { Class = 247, Map = 0, CoordX = 137,   CoordY = 122,   QuestIdentification = 8},
    { Class = 247, Map = 6,  CoordX = 60,   CoordY = 117,  QuestIdentification = 9},
}

--Identification of the quest
QUEST_SYSTEM_NPC_INFO = {}
QUEST_SYSTEM_NPC_INFO = {

-- QUEST OF LORENCIA
    { QuestIdentification = 1, Level = 400, Reset = 500, MReset = 0, Zen = 20000,    Coin1 = 0, Coin2 = 0, Coin3 = 0, Vip = 0, Kills = 100, QuestName = 'Freedom for Lorencia Quest',   Validity = '05/12/2022' },
	
-- 	QUEST OF NORIA	
	{ QuestIdentification = 2, Level = 400, Reset = 1000, MReset = 1, Zen = 200000,  Coin1 = 0, Coin2 = 0, Coin3 = 0, Vip = 0, Kills = 200,  QuestName = 'Freedom for Noria Quest',     Validity = '05/12/2022' },

-- 	QUEST OF DEVIAS	
    { QuestIdentification = 3, Level = 400, Reset = 1500, MReset = 2, Zen = 200000,  Coin1 = 0, Coin2 = 0, Coin3 = 0, Vip = 0, Kills = 300,  QuestName = 'Freedom for Devias Quest',    Validity = '05/12/2022' },

-- 	QUEST OF ATLANS	
    { QuestIdentification = 4, Level = 400, Reset = 2000, MReset = 3, Zen = 200000,  Coin1 = 0, Coin2 = 0, Coin3 = 0, Vip = 0, Kills = 350,  QuestName = 'Freedom for Atlans Quest',    Validity = '05/12/2022' },

-- 	QUEST OF DUNGEON	
    { QuestIdentification = 5, Level = 400, Reset = 2500, MReset = 4, Zen = 200000,  Coin1 = 0, Coin2 = 0, Coin3 = 0, Vip = 0, Kills = 400,  QuestName = 'Freedom for Dungeon Quest',    Validity = '05/12/2022' },

-- 	QUEST OF LOSTTOWER	
    { QuestIdentification = 6, Level = 400, Reset = 3000, MReset = 5, Zen = 200000,  Coin1 = 0, Coin2 = 0, Coin3 = 0, Vip = 0, Kills = 450,  QuestName = 'Freedom for Losttower Quest',  Validity = '05/12/2022' },

-- 	QUEST OF TARKAN	
    { QuestIdentification = 7, Level = 400, Reset = 3500, MReset = 6, Zen = 200000,  Coin1 = 0, Coin2 = 0, Coin3 = 0, Vip = 0, Kills = 500,  QuestName = 'Freedom for Tarkan Quest',     Validity = '05/12/2022' },

-- 	QUEST OF ICARUS	
    { QuestIdentification = 8, Level = 400, Reset = 4000, MReset = 7, Zen = 200000,  Coin1 = 0, Coin2 = 0, Coin3 = 0, Vip = 0, Kills = 550,  QuestName = 'Freedom for Icarus Quest',     Validity = '05/12/2022' },

-- 	QUEST OF ARENA	
    { QuestIdentification = 9, Level = 400, Reset = 5000, MReset = 10, Zen = 200000,  Coin1 = 0, Coin2 = 0, Coin3 = 0, Vip = 0, Kills = 700,  QuestName = 'Freedom for Arena Quest',     Validity = '05/12/2022' },

-- 	QUEST OF ARENA	
    { QuestIdentification = 10, Level = 400, Reset = 1, MReset = 1, Zen = 200000,  Coin1 = 0, Coin2 = 0, Coin3 = 0, Vip = 0, Kills = 0,  QuestName = 'Freedom for Arena Quest',     Validity = '05/12/2022' },

}

-- PARTE ONDE VOCÊ COLOCA OS ITENS NECESSÁRIO PARA CADA QUEST
QUEST_SYSTEM_NPC_REQUIREMENTS_ITEMS = {}

--[1] = INDENTIFICAÇÃO DOS ITENS NECESSÁRIOS (MÁXIMO 9 ITENS)
QUEST_SYSTEM_NPC_REQUIREMENTS_ITEMS[1] = {
    { ItemIndex = GET_ITEM(13, 15),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 1 },
    { ItemIndex = GET_ITEM(14, 63),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 1 },
    { ItemIndex = GET_ITEM(14, 68),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 1 },
    { ItemIndex = GET_ITEM(14, 153),  Level =  -1,  Luck = -1, Skill = -1,   Quantity = 1 },
    { ItemIndex = GET_ITEM(14, 154),  Level =  -1,  Luck = -1, Skill = -1,   Quantity = 1 },
    { ItemIndex = GET_ITEM(14, 51),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 1 },
    { ItemIndex = GET_ITEM(14, 112),  Level =  -1,  Luck = -1, Skill = -1,   Quantity = 1 },
    { ItemIndex = GET_ITEM(14, 113),  Level =  -1,  Luck = -1, Skill = -1,   Quantity = 1 },
    { ItemIndex = GET_ITEM(14, 11),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 1 },
	
	
}

QUEST_SYSTEM_NPC_REQUIREMENTS_ITEMS[2] = {
    { ItemIndex = GET_ITEM(13, 15),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 2 },
    { ItemIndex = GET_ITEM(14, 63),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 2 },
    { ItemIndex = GET_ITEM(14, 68),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 2 },
    { ItemIndex = GET_ITEM(14, 153),  Level =  -1,  Luck = -1, Skill = -1,   Quantity = 2 },
    { ItemIndex = GET_ITEM(14, 154),  Level =  -1,  Luck = -1, Skill = -1,   Quantity = 2 },
    { ItemIndex = GET_ITEM(14, 51),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 2 },
    { ItemIndex = GET_ITEM(14, 112),  Level =  -1,  Luck = -1, Skill = -1,   Quantity = 2 },
    { ItemIndex = GET_ITEM(14, 113),  Level =  -1,  Luck = -1, Skill = -1,   Quantity = 2 },
    { ItemIndex = GET_ITEM(14, 11),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 2 },
}

QUEST_SYSTEM_NPC_REQUIREMENTS_ITEMS[3] = {
    { ItemIndex = GET_ITEM(13, 15),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 3 },
    { ItemIndex = GET_ITEM(14, 63),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 3 },
    { ItemIndex = GET_ITEM(14, 68),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 3 },
    { ItemIndex = GET_ITEM(14, 153),  Level =  -1,  Luck = -1, Skill = -1,   Quantity = 3 },
    { ItemIndex = GET_ITEM(14, 154),  Level =  -1,  Luck = -1, Skill = -1,   Quantity = 3 },
    { ItemIndex = GET_ITEM(14, 51),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 3 },
    { ItemIndex = GET_ITEM(14, 112),  Level =  -1,  Luck = -1, Skill = -1,   Quantity = 3 },
    { ItemIndex = GET_ITEM(14, 113),  Level =  -1,  Luck = -1, Skill = -1,   Quantity = 3 },
    { ItemIndex = GET_ITEM(14, 11),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 3 },
}

QUEST_SYSTEM_NPC_REQUIREMENTS_ITEMS[4] = {
    { ItemIndex = GET_ITEM(13, 15),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 4 },
    { ItemIndex = GET_ITEM(14, 63),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 4 },
    { ItemIndex = GET_ITEM(14, 68),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 4 },
    { ItemIndex = GET_ITEM(14, 153),  Level =  -1,  Luck = -1, Skill = -1,   Quantity = 4 },
    { ItemIndex = GET_ITEM(14, 154),  Level =  -1,  Luck = -1, Skill = -1,   Quantity = 4 },
    { ItemIndex = GET_ITEM(14, 51),  Level =  -1,  Luck = -1, Skill = -1,    Quantity = 4 },
    { ItemIndex = GET_ITEM(14, 112), Level =  -1,  Luck = -1, Skill = -1,    Quantity = 4 },
    { ItemIndex = GET_ITEM(14, 113), Level =  -1,  Luck = -1, Skill = -1,    Quantity = 4 },
    { ItemIndex = GET_ITEM(14, 11),  Level =  -1,  Luck = -1, Skill = -1,    Quantity = 4 },
}


QUEST_SYSTEM_NPC_REQUIREMENTS_ITEMS[5] = {
    { ItemIndex = GET_ITEM(13, 15),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 5 },
    { ItemIndex = GET_ITEM(14, 63),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 5 },
    { ItemIndex = GET_ITEM(14, 68),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 5 },
    { ItemIndex = GET_ITEM(14, 153),  Level =  -1,  Luck = -1, Skill = -1,   Quantity = 5 },
    { ItemIndex = GET_ITEM(14, 154),  Level =  -1,  Luck = -1, Skill = -1,   Quantity = 5 },
    { ItemIndex = GET_ITEM(14, 51),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 5 },
    { ItemIndex = GET_ITEM(14, 112),  Level =  -1,  Luck = -1, Skill = -1,   Quantity = 5 },
    { ItemIndex = GET_ITEM(14, 113),  Level =  -1,  Luck = -1, Skill = -1,   Quantity = 5 },
    { ItemIndex = GET_ITEM(14, 11),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 5 },
}

QUEST_SYSTEM_NPC_REQUIREMENTS_ITEMS[6] = {
    { ItemIndex = GET_ITEM(13, 15),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 6 },
    { ItemIndex = GET_ITEM(14, 63),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 6 },
    { ItemIndex = GET_ITEM(14, 68),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 6 },
    { ItemIndex = GET_ITEM(14, 153),  Level =  -1,  Luck = -1, Skill = -1,   Quantity = 6 },
    { ItemIndex = GET_ITEM(14, 154),  Level =  -1,  Luck = -1, Skill = -1,   Quantity = 6 },
    { ItemIndex = GET_ITEM(14, 51),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 6 },
    { ItemIndex = GET_ITEM(14, 112),  Level =  -1,  Luck = -1, Skill = -1,   Quantity = 6 },
    { ItemIndex = GET_ITEM(14, 113),  Level =  -1,  Luck = -1, Skill = -1,   Quantity = 6 },
    { ItemIndex = GET_ITEM(14, 11),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 6 },
}

QUEST_SYSTEM_NPC_REQUIREMENTS_ITEMS[7] = {
    { ItemIndex = GET_ITEM(13, 15),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 7 },
    { ItemIndex = GET_ITEM(14, 63),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 7 },
    { ItemIndex = GET_ITEM(14, 68),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 7 },
    { ItemIndex = GET_ITEM(14, 153),  Level =  -1,  Luck = -1, Skill = -1,   Quantity = 7 },
    { ItemIndex = GET_ITEM(14, 154),  Level =  -1,  Luck = -1, Skill = -1,   Quantity = 7 },
    { ItemIndex = GET_ITEM(14, 51),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 7 },
    { ItemIndex = GET_ITEM(14, 112),  Level =  -1,  Luck = -1, Skill = -1,   Quantity = 7 },
    { ItemIndex = GET_ITEM(14, 113),  Level =  -1,  Luck = -1, Skill = -1,   Quantity = 7 },
    { ItemIndex = GET_ITEM(14, 11),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 5 },
}


QUEST_SYSTEM_NPC_REQUIREMENTS_ITEMS[8] = {
    { ItemIndex = GET_ITEM(13, 15),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 7 },
    { ItemIndex = GET_ITEM(14, 63),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 7 },
    { ItemIndex = GET_ITEM(14, 68),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 7 },
    { ItemIndex = GET_ITEM(14, 153),  Level =  -1,  Luck = -1, Skill = -1,   Quantity = 7 },
    { ItemIndex = GET_ITEM(14, 154),  Level =  -1,  Luck = -1, Skill = -1,   Quantity = 7 },
    { ItemIndex = GET_ITEM(14, 51),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 7 },
    { ItemIndex = GET_ITEM(14, 112),  Level =  -1,  Luck = -1, Skill = -1,   Quantity = 7 },
    { ItemIndex = GET_ITEM(14, 113),  Level =  -1,  Luck = -1, Skill = -1,   Quantity = 7 },
    { ItemIndex = GET_ITEM(14, 11),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 5 },
}

QUEST_SYSTEM_NPC_REQUIREMENTS_ITEMS[9] = {
    { ItemIndex = GET_ITEM(13, 15),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 7 },
    { ItemIndex = GET_ITEM(14, 63),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 7 },
    { ItemIndex = GET_ITEM(14, 68),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 7 },
    { ItemIndex = GET_ITEM(14, 153),  Level =  -1,  Luck = -1, Skill = -1,   Quantity = 7 },
    { ItemIndex = GET_ITEM(14, 154),  Level =  -1,  Luck = -1, Skill = -1,   Quantity = 7 },
    { ItemIndex = GET_ITEM(14, 51),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 7 },
    { ItemIndex = GET_ITEM(14, 112),  Level =  -1,  Luck = -1, Skill = -1,   Quantity = 7 },
    { ItemIndex = GET_ITEM(14, 113),  Level =  -1,  Luck = -1, Skill = -1,   Quantity = 7 },
    { ItemIndex = GET_ITEM(14, 11),   Level =  -1,  Luck = -1, Skill = -1,   Quantity = 5 },
}


-- PARTE ONDE VOCÊ COLOCA A QUANTIDADE DE MONSTROS NECESSÁRIOS (MÁXIMO 9)
QUEST_SYSTEM_NPC_REQUIREMENTS_MONSTER = {}

--[1] = QUEST OF LORENCIA

QUEST_SYSTEM_NPC_REQUIREMENTS_MONSTER[1] = {
    { MonsterIndex = 0,  Quantity = 10000 },
    { MonsterIndex = 1,  Quantity = 10000 },
    { MonsterIndex = 2,  Quantity = 10000 },
    { MonsterIndex = 3,  Quantity = 10000 },
    { MonsterIndex = 4,  Quantity = 10000 },
    { MonsterIndex = 6,  Quantity = 10000 },
    { MonsterIndex = 7,  Quantity = 10000 },
    { MonsterIndex = 16, Quantity = 10000 },
	
}
	
QUEST_SYSTEM_NPC_REQUIREMENTS_MONSTER[2] = {
    { MonsterIndex = 26,  Quantity = 12000 },
    { MonsterIndex = 27,  Quantity = 12000 },
    { MonsterIndex = 28,  Quantity = 12000 },
    { MonsterIndex = 29,  Quantity = 12000 },
    { MonsterIndex = 30,  Quantity = 12000 },
    { MonsterIndex = 31,  Quantity = 12000 },
    { MonsterIndex = 32,  Quantity = 12000 },
    { MonsterIndex = 33,  Quantity = 12000 },
}
	
QUEST_SYSTEM_NPC_REQUIREMENTS_MONSTER[3] = {
    { MonsterIndex = 19,  Quantity = 16000 },
    { MonsterIndex = 20,  Quantity = 16000 },
    { MonsterIndex = 21,  Quantity = 16000 },
    { MonsterIndex = 22,  Quantity = 16000 },
    { MonsterIndex = 23,  Quantity = 16000 },
    { MonsterIndex = 24,  Quantity = 16000 },
    { MonsterIndex = 25,  Quantity = 16000 },
}	

QUEST_SYSTEM_NPC_REQUIREMENTS_MONSTER[4] = {
    { MonsterIndex = 19,  Quantity = 19000 },
    { MonsterIndex = 20,  Quantity = 19000 },
    { MonsterIndex = 21,  Quantity = 19000 },
    { MonsterIndex = 22,  Quantity = 19000 },
    { MonsterIndex = 23,  Quantity = 19000 },
    { MonsterIndex = 24,  Quantity = 19000 },
    { MonsterIndex = 25,  Quantity = 19000 },
}

QUEST_SYSTEM_NPC_REQUIREMENTS_MONSTER[5] = {
    { MonsterIndex = 5,   Quantity = 20000 },
    { MonsterIndex = 8,   Quantity = 20000 },
    { MonsterIndex = 9,   Quantity = 20000 },
    { MonsterIndex = 10,  Quantity = 20000 },
    { MonsterIndex = 11,  Quantity = 20000 },
    { MonsterIndex = 12,  Quantity = 20000 },
    { MonsterIndex = 13,  Quantity = 20000 },
    { MonsterIndex = 14,  Quantity = 20000 },
    { MonsterIndex = 15,  Quantity = 20000 },
}


QUEST_SYSTEM_NPC_REQUIREMENTS_MONSTER[6] = {
    { MonsterIndex = 34,   Quantity = 22000 },
    { MonsterIndex = 35,   Quantity = 22000 },
    { MonsterIndex = 36,   Quantity = 22000 },
    { MonsterIndex = 37,   Quantity = 22000 },
    { MonsterIndex = 38,   Quantity = 22000 },
    { MonsterIndex = 39,   Quantity = 22000 },
    { MonsterIndex = 40,   Quantity = 22000 },
    { MonsterIndex = 41,   Quantity = 22000 },
}

QUEST_SYSTEM_NPC_REQUIREMENTS_MONSTER[7] = {
    { MonsterIndex = 57,   Quantity = 23000 },
    { MonsterIndex = 58,   Quantity = 23000 },
    { MonsterIndex = 59,   Quantity = 23000 },
    { MonsterIndex = 60,   Quantity = 23000 },
    { MonsterIndex = 61,   Quantity = 23000 },
    { MonsterIndex = 62,   Quantity = 23000 },
    { MonsterIndex = 63,   Quantity = 23000 },
}


QUEST_SYSTEM_NPC_REQUIREMENTS_MONSTER[8] = {
    { MonsterIndex = 69,   Quantity = 24000 },
    { MonsterIndex = 70,   Quantity = 24000 },
    { MonsterIndex = 71,   Quantity = 24000 },
    { MonsterIndex = 72,   Quantity = 24000 },
    { MonsterIndex = 73,   Quantity = 24000 },
    { MonsterIndex = 74,   Quantity = 24000 },
    { MonsterIndex = 75,   Quantity = 24000 },
    { MonsterIndex = 76,   Quantity = 24000 },
    { MonsterIndex = 77,   Quantity = 24000 },
}

QUEST_SYSTEM_NPC_REQUIREMENTS_MONSTER[9] = {
    { MonsterIndex = 64,   Quantity = 30000 },
    { MonsterIndex = 65,   Quantity = 30000 },
    { MonsterIndex = 66,   Quantity = 30000 },
    { MonsterIndex = 67,   Quantity = 30000 },
}

-----
-- Reward player
-----
--Coins
--CoinIdentification: 1 = WcoinC, 2 = WcoinP, 3 = GlobinPoint
QUEST_SYSTEM_NPC_REWARD_COINS = {}
--[1] = QuestIdentification
QUEST_SYSTEM_NPC_REWARD_COINS[200] = {
 { CoinName = 'WCoinC', CoinAmount = 50, CoinIdentification = 1 },
}

--[[
ItemTime: 0 = Eternal, time in seconds
DaysExpire: time the item will be able to stay in the rescue npc, after the person can no longer withdraw
Class: -1 = all class
]]--
QUEST_SYSTEM_NPC_REWARD_ITEMS = {}
--  QUEST OF LORENCIA
QUEST_SYSTEM_NPC_REWARD_ITEMS[1] = {
    { ItemIndex = GET_ITEM(7, 231),  Level = 0, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 0, Sock1 = 0, Sock2 = 0, Sock3 = 0, Sock4 = 0, Sock5 = 0, ItemTime = 0, DaysExpire = 60, Name = 'Transparency Reward', Count = 1, Class = -1},
    { ItemIndex = GET_ITEM(8, 231),  Level = 0, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 0, Sock1 = 0, Sock2 = 0, Sock3 = 0, Sock4 = 0, Sock5 = 0, ItemTime = 0, DaysExpire = 60, Name = 'Transparency Reward', Count = 1, Class = -1},

}

QUEST_SYSTEM_NPC_REWARD_ITEMS[2] = {
    { ItemIndex = GET_ITEM(9, 231),  Level = 0, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 0, Sock1 = 0, Sock2 = 0, Sock3 = 0, Sock4 = 0, Sock5 = 0, ItemTime = 0, DaysExpire = 60, Name = 'Transparency Reward', Count = 1, Class = -1},
    { ItemIndex = GET_ITEM(10, 231), Level = 0, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 0, Sock1 = 0, Sock2 = 0, Sock3 = 0, Sock4 = 0, Sock5 = 0, ItemTime = 0, DaysExpire = 60, Name = 'Transparency Reward', Count = 1, Class = -1},

}

QUEST_SYSTEM_NPC_REWARD_ITEMS[3] = {
    { ItemIndex = GET_ITEM(11, 231),  Level = 0, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 0, Sock1 = 0, Sock2 = 0, Sock3 = 0, Sock4 = 0, Sock5 = 0, ItemTime = 0, DaysExpire = 60, Name = 'Transparency Reward', Count = 1, Class = -1},

}


QUEST_SYSTEM_NPC_REWARD_ITEMS[4] = {
    { ItemIndex = GET_ITEM(7, 232),  Level = 0, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 0, Sock1 = 0, Sock2 = 0, Sock3 = 0, Sock4 = 0, Sock5 = 0, ItemTime = 0, DaysExpire = 60, Name = 'Transparency Reward', Count = 1, Class = -1},
    { ItemIndex = GET_ITEM(8, 232),  Level = 0, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 0, Sock1 = 0, Sock2 = 0, Sock3 = 0, Sock4 = 0, Sock5 = 0, ItemTime = 0, DaysExpire = 60, Name = 'Transparency Reward', Count = 1, Class = -1},

}

QUEST_SYSTEM_NPC_REWARD_ITEMS[5] = {
    { ItemIndex = GET_ITEM(9, 232),  Level = 0, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0,  JoH = 0, SocketBonus = 0, Sock1 = 0, Sock2 = 0, Sock3 = 0, Sock4 = 0, Sock5 = 0, ItemTime = 0, DaysExpire = 60,  Name = 'Transparency Reward', Count = 1, Class = -1},
    { ItemIndex = GET_ITEM(10, 232),  Level = 0, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 0, Sock1 = 0, Sock2 = 0, Sock3 = 0, Sock4 = 0, Sock5 = 0, ItemTime = 0, DaysExpire = 60, Name = 'Transparency Reward', Count = 1, Class = -1},

}

QUEST_SYSTEM_NPC_REWARD_ITEMS[6] = {
    { ItemIndex = GET_ITEM(11, 232),  Level = 0, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 0, Sock1 = 0, Sock2 = 0, Sock3 = 0, Sock4 = 0, Sock5 = 0, ItemTime = 0, DaysExpire = 60, Name = 'Transparency Reward', Count = 1, Class = -1},
}


QUEST_SYSTEM_NPC_REWARD_ITEMS[7] = {
    { ItemIndex = GET_ITEM(7, 233),  Level = 0, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 0, Sock1 = 0, Sock2 = 0, Sock3 = 0, Sock4 = 0, Sock5 = 0, ItemTime = 0, DaysExpire = 60, Name = 'Transparency Reward', Count = 1, Class = -1},
    { ItemIndex = GET_ITEM(8, 233),  Level = 0, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 0, Sock1 = 0, Sock2 = 0, Sock3 = 0, Sock4 = 0, Sock5 = 0, ItemTime = 0, DaysExpire = 60, Name = 'Transparency Reward', Count = 1, Class = -1},

}

QUEST_SYSTEM_NPC_REWARD_ITEMS[8] = {
    { ItemIndex = GET_ITEM(9, 233),  Level = 0, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0,  JoH = 0, SocketBonus = 0, Sock1 = 0, Sock2 = 0, Sock3 = 0, Sock4 = 0, Sock5 = 0, ItemTime = 0, DaysExpire = 60, Name = 'Transparency Reward', Count = 1, Class = -1},
    { ItemIndex = GET_ITEM(10, 233),  Level = 0, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 0, Sock1 = 0, Sock2 = 0, Sock3 = 0, Sock4 = 0, Sock5 = 0, ItemTime = 0, DaysExpire = 60, Name = 'Transparency Reward', Count = 1, Class = -1},
    { ItemIndex = GET_ITEM(6,  223),  Level = 0, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 0, Sock1 = 0, Sock2 = 0, Sock3 = 0, Sock4 = 0, Sock5 = 0, ItemTime = 0, DaysExpire = 60, Name = 'Transparency Reward', Count = 1, Class = -1},

}

QUEST_SYSTEM_NPC_REWARD_ITEMS[9] = {
    { ItemIndex = GET_ITEM(11, 233),  Level = 0, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 0, Sock1 = 0, Sock2 = 0, Sock3 = 0, Sock4 = 0, Sock5 = 0, ItemTime = 0, DaysExpire = 60, Name = 'Transparency Reward', Count = 1, Class = -1},
    { ItemIndex = GET_ITEM(0, 73),    Level = 0, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 0, Sock1 = 0, Sock2 = 0, Sock3 = 0, Sock4 = 0, Sock5 = 0, ItemTime = 0, DaysExpire = 60, Name = 'Transparency Reward', Count = 1, Class = -1},

}

--Buffs
QUEST_SYSTEM_NPC_REWARD_BUFF = {}
-- (1) INDENTIFICAÇÃO
-- O EFEITO É CONTABILIZADO POR SEGUNDOS

QUEST_SYSTEM_NPC_REWARD_BUFF[1]  = {
    { EffectID = 29, EffectTime = 3600, BuffName = 'Seal Ascencion' }
}

-- (2) INDENTIFICAÇÃO
QUEST_SYSTEM_NPC_REWARD_BUFF[2]  = {
    { EffectID = 29, EffectTime = 3600, BuffName = 'Seal Ascencion' }
}

-- (3) INDENTIFICAÇÃO
QUEST_SYSTEM_NPC_REWARD_BUFF[3]  = {
    { EffectID = 29, EffectTime = 3600, BuffName = 'Seal Ascencion' }
}
-- (4) INDENTIFICAÇÃO
QUEST_SYSTEM_NPC_REWARD_BUFF[4]  = {
    { EffectID = 29, EffectTime = 3600, BuffName = 'Seal Ascencion' }
}

-- (5) INDENTIFICAÇÃO
QUEST_SYSTEM_NPC_REWARD_BUFF[5]  = {
    { EffectID = 29, EffectTime = 3600, BuffName = 'Seal Ascencion' }
}

-- (6) INDENTIFICAÇÃO
QUEST_SYSTEM_NPC_REWARD_BUFF[6]  = {
    { EffectID = 29, EffectTime = 3600, BuffName = 'Seal Ascencion' }
}
-- (7) INDENTIFICAÇÃO
QUEST_SYSTEM_NPC_REWARD_BUFF[7]  = {
    { EffectID = 29, EffectTime = 3600, BuffName = 'Seal Ascencion' }
}

-- (8) INDENTIFICAÇÃO
QUEST_SYSTEM_NPC_REWARD_BUFF[8]  = {
    { EffectID = 29, EffectTime = 3600, BuffName = 'Seal Ascencion' }
}
-- (9) INDENTIFICAÇÃO
QUEST_SYSTEM_NPC_REWARD_BUFF[9]  = {
    { EffectID = 29, EffectTime = 3600, BuffName = 'Seal Ascencion' }
}

-- (9) INDENTIFICAÇÃO
QUEST_SYSTEM_NPC_REWARD_BUFF[10]  = {
    { EffectID = 29, EffectTime = 3600, BuffName = 'Seal Ascencion' }
}


QUEST_SYSTEM_NPC_PACKET = 0x04
QUEST_SYSTEM_NPC_PACKET_OPEN_NAME = 'QuestSystemNpcOpen'
QUEST_SYSTEM_NPC_PACKET_START_NAME = 'QuestSystemNpcStartQuest'
QUEST_SYSTEM_NPC_PACKET_GET_REWARD_NAME = 'QuestSystemNpcGetReward'
QUEST_SYSTEM_NPC_PACKET_DISMISS_QUEST_NAME = 'QuestSystemNpcDismissQuest'
QUEST_SYSTEM_NPC_PACKET_FINISHED_QUEST_NAME = 'QuestSystemNpcFinished'

QUEST_SYSTEM_NPC_MESSAGES = {}

QUEST_SYSTEM_NPC_MESSAGES['Por'] = {
[1] = 'Você está ocupado no momento!',
[2] = 'Não encontramos nenhuma quest disponível no momento!',
[3] = 'Você iniciou a quest %s!',
[4] = 'Não conseguimos identificar a sua quest!',
[5] = 'Você já está com uma quest ativa!',
[6] = 'Você precisa concluir todos os requisitos!',
[7] = 'Você recebeu %d %s',
[8] = 'Você já concluiu todas as quests!',
[9] = '%s - %s (%d/%d)',
[10] = 'Você foi premiado com: %d %s',
}

QUEST_SYSTEM_NPC_MESSAGES['Eng'] = {
[1] = 'You are busy at the moment!',
[2] = 'We havent found any quests available at the moment!',
[3] = 'You have started quest %s!',
[4] = 'We cant identify your quest!',
[5] = 'You already have an active quest!',
[6] = 'You must complete all requirements!',
[7] = 'You have received %d %s',
[8] = 'You have already completed all the quests!',
[9] = '%s - %s (%d/%d)',
[10] = 'Você foi premiado com: %d %s',
}

QUEST_SYSTEM_NPC_MESSAGES['Spn'] = {
[1] = '¡Estás ocupado en este momento!',
[2] = '¡No hemos encontrado ninguna misión disponible en este momento!',
[3] = '¡Has comenzado la misión %s!',
[4] = '¡No pudimos identificar tu misión!',
[5] = '¡Ya tienes una misión activa!',
[6] = '¡Debes completar todos los requisitos!',
[7] = 'Has recibido %d %s',
[8] = '¡Ya has completado todas las misiones!',
[9] = '%s - %s (%d/%d)',
[10] = 'Você foi premiado com: %d %s',
}
