Race_Config = {
    Enabled = true,

    Command = {
        ["Eng"] = {
            Open = "/openrace",
            Go = "/race",
            Cancel = "/cancelrace"
        },

        ["Por"] = {
            Open = "/abrircorrida",
            Go = "/corrida",
            Cancel = "/cancelarcorrida"
        },

        ["Spn"] = {
            Open = "/abrircorrida",
            Go = "/corrida",
            Cancel = "/cancelarcorrida"
        }
    },

    Cron = {
        --{DayOfMonth = -1, DayOfWeek = -1, Hour = 22, Minute = 50},
    },

    TimeAnnounce = 0, -- time to announce event will happen in minutes, 0 to start with no delay

    TimeOpen = 30, -- time in seconds the players can enter the event

    Area = {
        Total = {Map  = 6, X1 = 185, X2 = 247, Y1 = 144, Y2 = 246},
        Wait = {Map  = 6, X = 187, Y = 146},
        Start = {Map = 6, X = 195, Y = 195}
    },

    Npc = {Class = 249, Map = 6, X = 240, Y = 240, Dir = 3},

    EventTimeOut = 5, -- time in minutes the event will end if don't have winners

    ResetSkills = true, -- remove skills of players when enter event (prevent use o teleport)

    Winners = 1, -- amount of winners

    PrizeItem = {
        [1] = {
            {Section = 0, Index = 1, Level = 15, Skill = 1, Luck = 1, Option = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, ItemTime = 0},
        },
    },

    PrizeCoin = {
        [1] = {
            {Name = "HPoints", Amount = 5, Tabela = "CashShopData", Coluna = "WCoinP", Where = "AccountID", IdType = 0},
            {Name = "Events", Amount = 1, Table = "MEMB_INFO", Column = "Events", Where = "memb___id", IdType = 0},
        },
    },

    PrizeZen = {
        --[1] = 0,
    },

    ReturnSkills = { -- skills to add to player when event finishes if ResetSkill = true
        [0] = {
            {Section = 12, ID = 7},
            {Section = 12, ID = 8},
            {Section = 12, ID = 9},
            {Section = 12, ID = 10},
            {Section = 12, ID = 11},
            {Section = 12, ID = 12},
            {Section = 12, ID = 13},
            {Section = 12, ID = 14},
        },
    
        [1] = {
            {Section = 12, ID = 7},
            {Section = 12, ID = 8},
            {Section = 12, ID = 9},
            {Section = 12, ID = 10},
            {Section = 12, ID = 11},
            {Section = 12, ID = 12},
            {Section = 12, ID = 13},
            {Section = 12, ID = 14},
        },
    
        [2] = {
            {Section = 12, ID = 7},
            {Section = 12, ID = 8},
            {Section = 12, ID = 9},
            {Section = 12, ID = 10},
            {Section = 12, ID = 11},
            {Section = 12, ID = 12},
            {Section = 12, ID = 13},
            {Section = 12, ID = 14},
        },
    
        [3] = {
            {Section = 12, ID = 7},
            {Section = 12, ID = 8},
            {Section = 12, ID = 9},
            {Section = 12, ID = 10},
            {Section = 12, ID = 11},
            {Section = 12, ID = 12},
            {Section = 12, ID = 13},
            {Section = 12, ID = 14},
        },
    
        [4] = {
            {Section = 12, ID = 7},
            {Section = 12, ID = 8},
            {Section = 12, ID = 9},
            {Section = 12, ID = 10},
            {Section = 12, ID = 11},
            {Section = 12, ID = 12},
            {Section = 12, ID = 13},
            {Section = 12, ID = 14},
        },
    
        [5] = {
            {Section = 12, ID = 7},
            {Section = 12, ID = 8},
            {Section = 12, ID = 9},
            {Section = 12, ID = 10},
            {Section = 12, ID = 11},
            {Section = 12, ID = 12},
            {Section = 12, ID = 13},
            {Section = 12, ID = 14},
        },
    
        [6] = {
            {Section = 12, ID = 7},
            {Section = 12, ID = 8},
            {Section = 12, ID = 9},
            {Section = 12, ID = 10},
            {Section = 12, ID = 11},
            {Section = 12, ID = 12},
            {Section = 12, ID = 13},
            {Section = 12, ID = 14},
        },
    },

    Message = {
        ["Eng"] = {
            [1] = "Já existe uma Corrida aberta, use %s para cancelar",
            [2] = "Tempo mínimo 5 segundos, use %s <tempo>",
            [3] = "Evento Corrida foi aberto",
            [4] = ">>>>>>   Evento Corrida   <<<<<<",
            [5] = "%s fecha em %d segundos",
            [6] = "%s fecha em %d segundo",
            [7] = "Não existe uma Corrida aberta, use %s para abrir",
            [8] = "Evento Corrida foi cancelado",
            [9] = "Não há evento Corrida aberto no momento",
            [10] = "Você foi movido ao evento",
            [11] = "Seu inventário precisa estar vazio para entrar no evento",
            [12] = "Sua loja pessoal precisa estar vazia para entrar no evento",
            [13] = "==============================",
            [14] = "Evento Corrida Iniciado",
            [15] = "Você saiu do evento",
            [16] = " Parabéns, você foi o %dº ganhador ",
            [17] = " Você será movido para lorencia",
            [18] = "%s foi o vencedor da corrida",
            [19] = " Você recebeu %d %s",
            [20] = "Evento Corrida foi finalizado",
            [21] = "Evento Corrida inicia em %d minuto(s)",
        },

        ["Por"] = {
            [1] = "Já existe uma Corrida aberta, use %s para cancelar",
            [2] = "Tempo mínimo 5 segundos, use %s <tempo>",
            [3] = "Evento Corrida foi aberto",
            [4] = ">>>>>>   Evento Corrida   <<<<<<",
            [5] = "%s fecha em %d segundos",
            [6] = "%s fecha em %d segundo",
            [7] = "Não existe uma Corrida aberta, use %s para abrir",
            [8] = "Evento Corrida foi cancelado",
            [9] = "Não há evento Corrida aberto no momento",
            [10] = "Você foi movido ao evento",
            [11] = "Seu inventário precisa estar vazio para entrar no evento",
            [12] = "Sua loja pessoal precisa estar vazia para entrar no evento",
            [13] = "==============================",
            [14] = "Evento Corrida Iniciado",
            [15] = "Você saiu do evento",
            [16] = " Parabéns, você foi o %dº ganhador ",
            [17] = " Você será movido para lorencia",
            [18] = "%s foi o vencedor da corrida",
            [19] = " Você recebeu %d %s",
            [20] = "Evento Corrida foi finalizado",
            [21] = "Evento Corrida inicia em %d minuto(s)",
        },

        ["Spn"] = {
            [1] = "Já existe uma Corrida aberta, use %s para cancelar",
            [2] = "Tempo mínimo 5 segundos, use %s <tempo>",
            [3] = "Evento Corrida foi aberto",
            [4] = ">>>>>>   Evento Corrida   <<<<<<",
            [5] = "%s fecha em %d segundos",
            [6] = "%s fecha em %d segundo",
            [7] = "Não existe uma Corrida aberta, use %s para abrir",
            [8] = "Evento Corrida foi cancelado",
            [9] = "Não há evento Corrida aberto no momento",
            [10] = "Você foi movido ao evento",
            [11] = "Seu inventário precisa estar vazio para entrar no evento",
            [12] = "Sua loja pessoal precisa estar vazia para entrar no evento",
            [13] = "==============================",
            [14] = "Evento Corrida Iniciado",
            [15] = "Você saiu do evento",
            [16] = " Parabéns, você foi o %dº ganhador ",
            [17] = " Você será movido para lorencia",
            [18] = "%s foi o vencedor da corrida",
            [19] = " Você recebeu %d %s",
            [20] = "Evento Corrida foi finalizado",
            [21] = "Evento Corrida inicia em %d minuto(s)",
        },
    }
}

return Race_Config