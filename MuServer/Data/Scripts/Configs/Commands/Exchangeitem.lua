ExchangeItem_Config = {
    Enabled = true,

    Command = {
        ["Eng"] = "/exchange",
        ["Por"] = "/trocar",
        ["Spn"] = "/trocar"
    },

    Item = {
        ["creation"] =   {Name = "Jewel of Creation", Section = 14, Index = 22, Level = -1, Value = 1, Coin = 1},
        ["creation5"] =  {Name = "Jewel of Creation", Section = 14, Index = 22, Level = -1, Value = 1, Coin = 1},
        ["creation10"] = {Name = "Jewel of Creation", Section = 14, Index = 22, Level = -1, Value = 1, Coin = 1},
        ["creation20"] = {Name = "Jewel of Creation", Section = 14, Index = 22, Level = -1, Value = 1, Coin = 1},
        ["creation30"] = {Name = "Jewel of Creation", Section = 14, Index = 22, Level = -1, Value = 1, Coin = 1},
        ["creation40"] = {Name = "Jewel of Creation", Section = 14, Index = 22, Level = -1, Value = 1, Coin = 1},
        ["creation50"] = {Name = "Jewel of Creation", Section = 14, Index = 22, Level = -1, Value = 1, Coin = 1},
        ["creation64"] = {Name = "Jewel of Creation", Section = 14, Index = 22, Level = -1, Value = 1, Coin = 1},
    },

    Coin = {
        [1] = {Name = "JCPoints", Table = "MEMB_INFO", Column = "JCPoints", Where = "memb___id", IdType = 0},
    },

    Message = {
        ["Eng"] = {
            [1] = " Item not found ",
            [2] = " %d %s exchanged for %d %s ",
            [3] = " 0 %s found in the inventory ",
        },

        ["Por"] = {
            [1] = " Item não encontrado ",
            [2] = " %d %s trocado por %d %s ",
            [3] = " 0 %s encontrados no inventário ",
        },

        ["Spn"] = {
            [1] = " Item não encontrado ",
            [2] = " %d %s trocado por %d %s ",
            [3] = " 0 %s encontrados no inventário ",
        },
    }

}

return ExchangeItem_Config