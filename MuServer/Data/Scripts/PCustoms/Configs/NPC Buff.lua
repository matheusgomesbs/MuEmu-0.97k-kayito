NPCBuff_Config = {
    Enabled = false,

    Monster = {
        [1] = {Class = 249, Map = 0, X = 137, Y = 122, Dir = 3, Item = 1, Coin = 1, Buff = 1},
    },

    Coin = {
        [1] = {
            {Name = "HPoints", Amount = 10, Table = "MEMB_INFO", Column = "HPoints", Where = "memb___id", IdType = 0},
        }
    },

    Item = {
        [1] = {
            {Name = "Jewel of Creation", Amount = 1, Section = 14, Index = 22, Level = -1},
        },
  },

    Buff = {
        [1] = {
            {Id = 50, Time = 5},
            {Id = 52, Time = 5},
        },
    },

    Message = {
        ["Eng"] = {
            [1] = "Você precisa de %d %s ",
            [2] = "A benção foi concedida ",
        },
        ["Por"] = {
            [1] = "Você precisa de %d %s ",
            [2] = "A benção foi concedida ",
        },
        ["Spn"] = {
            [1] = "Você precisa de %d %s ",
            [2] = "A benção foi concedida ",
        },
    }

}