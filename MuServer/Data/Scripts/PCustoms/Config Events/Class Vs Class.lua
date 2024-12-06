CVC_Config = {
    Enabled = true,

    Command = {
        ["Eng"] = {
            Open = "/opencvc",
            Go = "/cvc",
            Cancel = "/cancelcvc"
        },

        ["Por"] = {
            Open = "/abrircvc",
            Go = "/cvc",
            Cancel = "/cancelarcvc"
        },

        ["Spn"] = {
            Open = "/abrircvc",
            Go = "/cvc",
            Cancel = "/cancelarcvc"
        }
    },

    Cron = {
        --{DayOfMonth = -1, DayOfWeek = -1, Hour = 22, Minute = 50},
    },

    TimeAnnounce = 0, -- time to announce event will happen in minutes, 0 to start with no delay

    TimeOpen = 30, -- time in seconds the players can enter the event

    TimePrep = 1, -- minutes before pvp is enabled (for player to distribute points, equip itens, etc) (at least 1 minute)

    LevelUpPoints = 150000, -- level up points players will have (-1 they keep their points)

    MasterSkillPoints = 100, -- master skill points player will have (-1 they keep their points)

    Itens = {
        [0] = {
            {Section = 0, Index = 1, Level = 15, Skill = 1, Luck = 1, Option = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255},
            {Section = 6, Index = 0, Level = 15, Skill = 1, Luck = 1, Option = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255},
        },
        [1] = {
            {Section = 0, Index = 1, Level = 15, Skill = 1, Luck = 1, Option = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255},
            {Section = 6, Index = 0, Level = 15, Skill = 1, Luck = 1, Option = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255},
        },
        [2] = {
            {Section = 0, Index = 1, Level = 15, Skill = 1, Luck = 1, Option = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255},
            {Section = 6, Index = 0, Level = 15, Skill = 1, Luck = 1, Option = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255},
        },
        [3] = {
            {Section = 0, Index = 1, Level = 15, Skill = 1, Luck = 1, Option = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255},
            {Section = 6, Index = 0, Level = 15, Skill = 1, Luck = 1, Option = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255},
        },
        [4] = {
            {Section = 0, Index = 1, Level = 15, Skill = 1, Luck = 1, Option = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255},
            {Section = 6, Index = 0, Level = 15, Skill = 1, Luck = 1, Option = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255},
        },
        [5] = {
            {Section = 0, Index = 1, Level = 15, Skill = 1, Luck = 1, Option = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255},
            {Section = 6, Index = 0, Level = 15, Skill = 1, Luck = 1, Option = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255},
        },
        [6] = {
            {Section = 0, Index = 1, Level = 15, Skill = 1, Luck = 1, Option = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255},
            {Section = 6, Index = 0, Level = 15, Skill = 1, Luck = 1, Option = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255},
        },
    },

    Area = {
        Total = {Map = 6, X1 = 196, X2 = 234, Y1 = 166, Y2 = 227},
        Spawn = {Map = 6, X = 215, Y = 195},
        Watch = {Map = 6, X = 216, Y = 192}
    },

    PrizeItem = {
        {Section = 0, Index = 1, Level = 15, Skill = 1, Luck = 1, Option = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, ItemTime = 0},
    },

    PrizeCoin = {
        {Name = "HPoints", Amount = 10, Table = "CashShopData", Column = "WCoinP", Where = "AccoutnID", IdType = 0},
    },

    PrizeZen = 0,

    Message = {
        ["Eng"] = {
            [1] = "Já existe uma Classe Vs Classe aberta, use %s para cancelar",
            [2] = "Tempo mínimo 5 segundos, use %s <tempo>",
            [3] = "Evento Classe Vs Classe foi aberto",
            [4] = ">>>>>>   Evento Classe Vs Classe   <<<<<<",
            [5] = "%s fecha em %d segundos",
            [6] = "%s fecha em %d segundo",
            [7] = "Não existe uma Classe Vs Classe aberta, use %s para abrir",
            [8] = "Evento Classe Vs Classe foi cancelado",
            [9] = "Não há evento Classe Vs Classe aberto no momento",
            [10] = "Você foi movido ao evento",
            [11] = "Seu inventário precisa estar vazio para entrar no evento",
            [12] = "Sua loja pessoal precisa estar vazia para entrar no evento",
            [13] = "==============================",
            [14] = "Evento Classe Vs Classe Iniciado",
            [15] = "Você saiu do evento",
            [16] = "%s matou %s",
            [17] = "Mortes: %d",
            [18] = "%s foi o vencedor do Classe Vs Classe",
            [19] = " Você recebeu %d %s",
            [20] = "Evento Classe Vs Classe foi finalizado",
            [21] = "Evento Classe Vs Classe inicia em %d minuto(s)",
            [22] = "PvP será liberado em %d minuto(s)",
            [23] = "Aguarde o inicio do evento para atacar",
        },
        ["Por"] = {
            [1] = "Já existe uma Classe Vs Classe aberta, use %s para cancelar",
            [2] = "Tempo mínimo 5 segundos, use %s <tempo>",
            [3] = "Evento Classe Vs Classe foi aberto",
            [4] = ">>>>>>   Evento Classe Vs Classe   <<<<<<",
            [5] = "%s fecha em %d segundos",
            [6] = "%s fecha em %d segundo",
            [7] = "Não existe uma Classe Vs Classe aberta, use %s para abrir",
            [8] = "Evento Classe Vs Classe foi cancelado",
            [9] = "Não há evento Classe Vs Classe aberto no momento",
            [10] = "Você foi movido ao evento",
            [11] = "Seu inventário precisa estar vazio para entrar no evento",
            [12] = "Sua loja pessoal precisa estar vazia para entrar no evento",
            [13] = "==============================",
            [14] = "Evento Classe Vs Classe Iniciado",
            [15] = "Você saiu do evento",
            [16] = "%s matou %s",
            [17] = "Mortes: %d",
            [18] = "%s foi o vencedor do Classe Vs Classe",
            [19] = " Você recebeu %d %s",
            [20] = "Evento Classe Vs Classe foi finalizado",
            [21] = "Evento Classe Vs Classe inicia em %d minuto(s)",
            [22] = "PvP será liberado em %d minuto(s)",
            [23] = "Aguarde o inicio do evento para atacar",
        },
        ["Spn"] = {
            [1] = "Já existe uma Classe Vs Classe aberta, use %s para cancelar",
            [2] = "Tempo mínimo 5 segundos, use %s <tempo>",
            [3] = "Evento Classe Vs Classe foi aberto",
            [4] = ">>>>>>   Evento Classe Vs Classe   <<<<<<",
            [5] = "%s fecha em %d segundos",
            [6] = "%s fecha em %d segundo",
            [7] = "Não existe uma Classe Vs Classe aberta, use %s para abrir",
            [8] = "Evento Classe Vs Classe foi cancelado",
            [9] = "Não há evento Classe Vs Classe aberto no momento",
            [10] = "Você foi movido ao evento",
            [11] = "Seu inventário precisa estar vazio para entrar no evento",
            [12] = "Sua loja pessoal precisa estar vazia para entrar no evento",
            [13] = "==============================",
            [14] = "Evento Classe Vs Classe Iniciado",
            [15] = "Você saiu do evento",
            [16] = "%s matou %s",
            [17] = "Mortes: %d",
            [18] = "%s foi o vencedor do Classe Vs Classe",
            [19] = " Você recebeu %d %s",
            [20] = "Evento Classe Vs Classe foi finalizado",
            [21] = "Evento Classe Vs Classe inicia em %d minuto(s)",
            [22] = "PvP será liberado em %d minuto(s)",
            [23] = "Aguarde o inicio do evento para atacar",
        },
    }


}

return CVC_Config