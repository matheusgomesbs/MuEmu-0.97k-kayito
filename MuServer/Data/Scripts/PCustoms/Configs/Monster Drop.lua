MonsterDrop_Config = {
    Enabled = true,
    
    Monster = {
        {Class = 424,  Local = -1, Drop = {Enabled = true, Index = 5, Random = false}, Coin = {Enabled = true, Index = 5, Random = false}, CoinAndItem = true, ItemToCoinRate = {[0] = 100, [1] = 100, [2] = 100},  Vip = {[0] = true, [1] = true, [2] = true}},
   },
    
    Local = {
        [5] = {Mapa = 83, Start = {X = 30,  Y = 30}, End ={ X = 210, Y = 230}},

    },

    Drop = {
        -- Section = -1, Index = 0 (Bypass drop)
        -- Section = -1, Index = 1 (Block drop)
        [5] = {
            {Section =  14, Index =  269 , Level = {Min = 0, Max = 0}, Skill = {[0] = 0, [1] = 0, [2] = 0}, Luck = {[0] = 0, [1] = 0, [2] = 0}, Opt = {Min = 0, Max = 7}, Exc = {[1] = {[0] = 0, [1] = 0, [2] = 0}, [2] = {[0] = 0, [1] = 0, [2] = 0}, [3] = {[0] = 0, [1] = 0, [2] = 0}, [4] = {[0] = 0, [1] = 0, [2] = 0}, [5] = {[0] = 0, [1] = 0, [2] = 0}, [6] = {[0] = 0, [1] = 0, [2] = 0}}, Ancient = {[0] = 0, [1] = 0, [2] = 0}, Socket = {[1] = {[0] = 0, [1] = 0, [2] = 0}, [2] = {[0] = 0, [1] = 0, [2] = 0}, [3] = {[0] = 0, [1] = 0, [2] = 0}}, ItemTime = 0, Rate = {[0] = 0, [1] = 0, [2] = 0}},
        }, 
    },

    Coin = {
        [5] = {
            {Name = "Ur Points", Amount = 1, Table = "Character", Column = "RankedUr", Where = "Name", IdType = 1, Announce = true, Rate = {[0] = 100, [1] = 100, [2] = 100}},
			
        },    
    },

    Message = {
        ["Por"] = {
			[1] = "You received %d %s",
		},
        ["Eng"] = {
			[1] = "Você recebeu %d %s",
		},
        ["Spn"] = {
			[1] = "Ricibiste %d %s",
		}
    }
}

return MonsterDrop_Config