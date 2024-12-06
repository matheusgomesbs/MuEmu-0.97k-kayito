MataMata_Config = {
    Enabled = true,

    -- Version = 2 (season 2)
    -- Version = 6 (season 6)
    Version = 6,

    Command = {
        ["Eng"] = {
            Open = "/abrirmtmt",
            Go = "/matamata",
            Cancel = "/cancelarmtmt"
        },
        ["Por"] = {
            Open = "/abrirmtmt", -- /comando tempo type, se nao digitar type ser� um mata-mata normal
            Go = "/matamata",
            Cancel = "/cancelarmtmt"
        },
        ["Spn"] = {
            Open = "/abrirmtmt",
            Go = "/matamata",
            Cancel = "/cancelarmtmt"
        },
    },

    Cron = {
        --{DayOfMonth = -1, DayOfWeek = -1, Hour = 12, Minute = 15, Type = 0, AnnounceName = 37},
        --{DayOfMonth = -1, DayOfWeek = -1, Hour = 12, Minute = 17, Type = 0, AnnounceName = 37},
        --{DayOfMonth = -1, DayOfWeek = -1, Hour = 12, Minute = 20, Type = 0, AnnounceName = 37},
        --{DayOfMonth = -1, DayOfWeek = -1, Hour = 12, Minute = 23, Type = 0, AnnounceName = 37},
        --{DayOfMonth = -1, DayOfWeek = -1, Hour = 12, Minute = 26, Type = 0, AnnounceName = 37},
        --{DayOfMonth = -1, DayOfWeek = -1, Hour = 12, Minute = 29, Type = 0, AnnounceName = 37},
        --{DayOfMonth = -1, DayOfWeek = -1, Hour = 12, Minute = 32, Type = 0, AnnounceName = 37},
        --{DayOfMonth = -1, DayOfWeek = -1, Hour = 12, Minute = 35, Type = 0, AnnounceName = 37},
        --{DayOfMonth = -1, DayOfWeek = -1, Hour = 12, Minute = 38, Type = 0, AnnounceName = 37},
        --{DayOfMonth = -1, DayOfWeek = -1, Hour = 12, Minute = 41, Type = 0, AnnounceName = 37},
        --{DayOfMonth = -1, DayOfWeek = -1, Hour = 12, Minute = 43, Type = 0, AnnounceName = 37},
        --{DayOfMonth = -1, DayOfWeek = -1, Hour = 12, Minute = 46, Type = 0, AnnounceName = 37},
        --{DayOfMonth = -1, DayOfWeek = -1, Hour = 12, Minute = 49, Type = 0, AnnounceName = 37},
        --{DayOfMonth = -1, DayOfWeek = -1, Hour = 12, Minute = 52, Type = 0, AnnounceName = 37},
        --{DayOfMonth = -1, DayOfWeek = -1, Hour = 12, Minute = 55, Type = 0, AnnounceName = 37},
        --{DayOfMonth = -1, DayOfWeek = -1, Hour = 13, Minute = 00, Type = 0, AnnounceName = 37},
    },

    TimeAnnounce = 1, -- tempo em minutos que avisa que vai haver o evento

    TimeOpen = 15, -- tempo em segundo que o comando entrar fica aberto

    Area = { -- Somente dois mapas
        [1] = {
            Total = {Map  = 6, X1 = 185, X2 = 247, Y1 = 144, Y2 = 246},
            Wait = {Map  = 6, X1 = 185, X2 = 247, Y1 = 144, Y2 = 246},
            PvP = {Map  = 6, X1 = 198, X2 = 234, Y1 = 165, Y2 = 224},
            Spot = {
                [1] = {Map  = 6, X = 216, Y = 195},
                [2] = {Map  = 6, X = 217, Y = 195},
            },
            Watch = {Map  = 6, X = 216, Y = 192},
            Respawn = {Map  = 6, X = 195, Y = 195},
        },

        [2] = {
            Total = {Map  = 6, X1 = 185, X2 = 247, Y1 = 144, Y2 = 246},
            Wait = {Map  = 6, X1 = 185, X2 = 247, Y1 = 144, Y2 = 246},
            PvP = {Map  = 6, X1 = 198, X2 = 234, Y1 = 165, Y2 = 224},
            Spot = {
                [1] = {Map  = 6, X = 216, Y = 195},
                [2] = {Map  = 6, X = 217, Y = 195},
            },
            Watch = {Map  = 6, X = 216, Y = 192},
            Respawn = {Map  = 6, X = 242, Y = 195},
        }
    },

    Rounds = { -- a quantidade de rounds deve ser sempre IMPAR (1, 3, 5, etc) 
        Normal = 1, -- quantidades de rounds a ser disputados em lutas normais
        Semi = 1, -- quantidade de rounds a ser disputados na semi-final
        Final = 3 -- quantidade de rounds a ser disputados na final
    },
	
	RoundDelay = 10, -- segundos que demora entre uma luta e outra

    LogoutExitEvent = true, -- true = � removido do evento se relogar, false pode voltar ao evento se ainda estiver na mesma fase

    RemoveBuffBeforeFight = false, -- true remove todos so buffs do char antes de lutar, false nao remove

    rewardBattlePassXp = true,
    rewardBattlePassXpConfig = {
        [1] = 50,
        [2] = 25,
        [3] = 20,
    },

    Prize = {
        [1] = {
            {Name = "EventPoints", Amount = 20, Table = "CashShopData", Column = "WCoinP", Where = "AccountID", IdType = 0, Announce = true},
            {Name = "MataMata", Amount = 1, Table = "Character", Column = "matamata", Where = "Name", IdType = 1, Announce = false},			
        },
        [2] = {
            {Name = "EventPoints", Amount = 10, Table = "CashShopData", Column = "WCoinP", Where = "AccountID", IdType = 0, Announce = true},	

        },
        [3] = {
            {Name = "EventPoints", Amount = 5, Table = "CashShopData", Column = "WCoinP", Where = "AccountID", IdType = 0, Announce = true},	
			
        }  	
    },
	
	PrizeItem = {
		[1] = {
            --{ ItemIndex = GET_ITEM(14, 236), Level = 0, Op1 = 0, Op2 = 0, Life = 0, Exc = 0, Ancient = 0, JoH = 0, SocketBonus = 0, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, ItemTime = 0, DaysExpire = 30, Name = 'Luck Events Reward', Count = 1},		
        },
	},

    CounterItem = { -- Remove = mortes removidas quando perde, Add = mortes adicionadas quando ganha, so funciona para itens no slot 0
        [51 ] = {Remove = 0, Add = 1},
        [53 ] = {Remove = 0, Add = 1},
        [58 ] = {Remove = 0, Add = 1},
        [50 ] = {Remove = 0, Add = 1},
        [38 ] = {Remove = 0, Add = 1},
        [39 ] = {Remove = 0, Add = 1},
        [62 ] = {Remove = 0, Add = 1},
        [63 ] = {Remove = 0, Add = 1},
        [64 ] = {Remove = 0, Add = 1},
        [65 ] = {Remove = 0, Add = 1},
        [86 ] = {Remove = 0, Add = 1},
        [90 ] = {Remove = 0, Add = 1},
        [91 ] = {Remove = 0, Add = 1},
        [92 ] = {Remove = 0, Add = 1},
        [93 ] = {Remove = 0, Add = 1},
        [97 ] = {Remove = 0, Add = 1},
        [98 ] = {Remove = 0, Add = 1},
        [99 ] = {Remove = 0, Add = 1},
        [100] = {Remove = 0, Add = 1},
        [101] = {Remove = 0, Add = 1},
        [102] = {Remove = 0, Add = 1},
        [103] = {Remove = 0, Add = 1},
        [104] = {Remove = 0, Add = 1},
        [105] = {Remove = 0, Add = 1},
        [106] = {Remove = 0, Add = 1},
        [114] = {Remove = 0, Add = 1},
        [115] = {Remove = 0, Add = 1},
        [116] = {Remove = 0, Add = 1},
        [117] = {Remove = 0, Add = 1},
        [118] = {Remove = 0, Add = 1},
        [120] = {Remove = 0, Add = 1},
		
        [164] = {Remove = 0, Add = 1},
        [165] = {Remove = 0, Add = 1},
        [166] = {Remove = 0, Add = 1},
        [144] = {Remove = 0, Add = 1},
        [145] = {Remove = 0, Add = 1},
        [132] = {Remove = 0, Add = 1},
        [133] = {Remove = 0, Add = 1},
        [146] = {Remove = 0, Add = 1},
        [147] = {Remove = 0, Add = 1},
        [157] = {Remove = 0, Add = 1},
        [158] = {Remove = 0, Add = 1},
        [170] = {Remove = 0, Add = 1},
        [171] = {Remove = 0, Add = 1},
        [172] = {Remove = 0, Add = 1},
        [175] = {Remove = 0, Add = 1},
        [176] = {Remove = 0, Add = 1},
        [177] = {Remove = 0, Add = 1},
        [178] = {Remove = 0, Add = 1},
        [167] = {Remove = 0, Add = 1},
        [168] = {Remove = 0, Add = 1},
        [169] = {Remove = 0, Add = 1},
    },

    Types = {
        [1] = {Name = 38, AllowedItem = 1, AllowedClass = 1, Invite = -1},
        [2] = {Name = 39, AllowedItem = -1, AllowedClass = -1, Invite = 1},
    },

    Invite = {
        [1] = {Amount = 1, Section = 14, Index = 32, Level = -1},
    },

    AllowedClasses = {
        [1] = {
            [0] = false, -- SM
            [1] = true,  -- BK
            [2] = false, -- ELF
            [3] = false, -- MG
            [4] = false, -- DL
            [5] = false, -- SUM
            [6] = false, -- RF
        }
    },

    AllowedItens = {
        [1] = {
            {Section = 0 , Index = 1 , MaxLevel = 3, Skill = 0, Luck = 0, MaxOpt = 3, MaxExc = 0, Ancient = 0},
            {Section = 6 , Index = 20, MaxLevel = 3, Skill = 0, Luck = 0, MaxOpt = 3, MaxExc = 0, Ancient = 0},
            {Section = 7 , Index = 1 , MaxLevel = 3, Skill = 0, Luck = 0, MaxOpt = 3, MaxExc = 0, Ancient = 0},
            {Section = 8 , Index = 1 , MaxLevel = 3, Skill = 0, Luck = 0, MaxOpt = 3, MaxExc = 0, Ancient = 0},
            {Section = 9 , Index = 1 , MaxLevel = 3, Skill = 0, Luck = 0, MaxOpt = 3, MaxExc = 0, Ancient = 0},
            {Section = 10, Index = 1 , MaxLevel = 3, Skill = 0, Luck = 0, MaxOpt = 3, MaxExc = 0, Ancient = 0},
            {Section = 11, Index = 1 , MaxLevel = 3, Skill = 0, Luck = 0, MaxOpt = 3, MaxExc = 0, Ancient = 0},
        },
    },

    Message = {
        ["Eng"] = {
            [1] = "Ja existe um Mata-Mata aberto, use %s para cancelar",
            [2] = "Tempo mínimo 5 segundos, use %s <tempo>",
            [3] = " Evento Mata-Mata foi aberto",
            [4] = ">>>>>>   Evento Mata-Mata   <<<<<<",
            [5] = "%s fecha em %d segundos",
            [6] = "%s fecha em %d segundo",
            [7] = "Nao existe um Mata-Mata aberto, use %s para abrir",
            [8] = "Evento Mata-Mata foi cancelado",
            [9] = "Não ha evento Mata-mata aberto no momento",
            [10] = "Voce foi movido ao evento",
            [11] = "=============",
            [12] = "%s",
            [13] = "X",
            [14] = "Fase Final Iniciada",
            [15] = "%s passou de fase por falta de oponente",
            [16] = "%dª Fase Iniciada",
            [17] = "Mata-Mata cancelado por falta de participantes",
            [18] = "ATENCAO!",
            [19] = "JAAH!",
            [20] = "%d",
            [21] = "%s Win",
            [22] = "VENCEDORES:",
            [23] = "%dº - %s",
            [24] = "Fase Semi Final Iniciada",
            [25] = "Fase Final de 3 Iniciada",
            [26] = "%s[%s] Win",
            [27] = "Tipo de evento nao existe",
            [28] = " Sua classe nao é permitida nesse evento",
            [29] = " Voce esta usando itens proibidos no evento",
            [30] = " Voce precisa ter o convite no seu inventário para participar",
            [31] = "%s %d X %d %s",
            [32] = "=========== Melhor de %d ===========",
            [33] = " Parabens, Voce foi o %dº colocado",
            [34] = " Voce recebeu %d %s",
            [35] = " Evento Mata-Mata finalizado",
            [36] = " Voce foi removido do evento",
            [37] = " Mata-Mata inicia em %d minuto(s)",
            [38] = ">>>>>>   Evento Mata-Mata Iniciante (BK's)   <<<<<<",
            [39] = ">>>>>>   Evento Mata-Mata Privado   <<<<<<",
            [40] = "Mata-Mata Privado inicia em %d minuto(s)"
        },

        ["Por"] = {
            [1] = "Ja existe um Mata-Mata aberto, use %s para cancelar",
            [2] = "Tempo mínimo 5 segundos, use %s <tempo>",
            [3] = " Evento Mata-Mata foi aberto",
            [4] = ">>>>>>   Evento Mata-Mata   <<<<<<",
            [5] = "%s fecha em %d segundos",
            [6] = "%s fecha em %d segundo",
            [7] = "Nao existe um Mata-Mata aberto, use %s para abrir",
            [8] = "Evento Mata-Mata foi cancelado",
            [9] = "Não ha evento Mata-mata aberto no momento",
            [10] = "Voce foi movido ao evento",
            [11] = "=============",
            [12] = "%s",
            [13] = "X",
            [14] = "Fase Final Iniciada",
            [15] = "%s passou de fase por falta de oponente",
            [16] = "%dª Fase Iniciada",
            [17] = "Mata-Mata cancelado por falta de participantes",
            [18] = "ATENCAO!",
            [19] = "JAAH!",
            [20] = "%d",
            [21] = "%s Win",
            [22] = "VENCEDORES:",
            [23] = "%dº - %s",
            [24] = "Fase Semi Final Iniciada",
            [25] = "Fase Final de 3 Iniciada",
            [26] = "%s[%s] Win",
            [27] = "Tipo de evento nao existe",
            [28] = " Sua classe nao é permitida nesse evento",
            [29] = " Voce esta usando itens proibidos no evento",
            [30] = " Voce precisa ter o convite no seu inventário para participar",
            [31] = "%s %d X %d %s",
            [32] = "=========== Melhor de %d ===========",
            [33] = " Parabens, Voce foi o %dº colocado",
            [34] = " Voce recebeu %d %s",
            [35] = " Evento Mata-Mata finalizado",
            [36] = " Voce foi removido do evento",
            [37] = " Mata-Mata inicia em %d minuto(s)",
            [38] = ">>>>>>   Evento Mata-Mata Iniciante (BK's)   <<<<<<",
            [39] = ">>>>>>   Evento Mata-Mata Privado   <<<<<<",
            [40] = "Mata-Mata Privado inicia em %d minuto(s)"
        },

        ["Spn"] = {
            [1] = "Ja existe um Mata-Mata aberto, use %s para cancelar",
            [2] = "Tempo mínimo 5 segundos, use %s <tempo>",
            [3] = " Evento Mata-Mata foi aberto",
            [4] = ">>>>>>   Evento Mata-Mata   <<<<<<",
            [5] = "%s fecha em %d segundos",
            [6] = "%s fecha em %d segundo",
            [7] = "Nao existe um Mata-Mata aberto, use %s para abrir",
            [8] = "Evento Mata-Mata foi cancelado",
            [9] = "Não ha evento Mata-mata aberto no momento",
            [10] = "Voce foi movido ao evento",
            [11] = "=============",
            [12] = "%s",
            [13] = "X",
            [14] = "Fase Final Iniciada",
            [15] = "%s passou de fase por falta de oponente",
            [16] = "%dª Fase Iniciada",
            [17] = "Mata-Mata cancelado por falta de participantes",
            [18] = "ATENCAO!",
            [19] = "JAAH!",
            [20] = "%d",
            [21] = "%s Win",
            [22] = "VENCEDORES:",
            [23] = "%dº - %s",
            [24] = "Fase Semi Final Iniciada",
            [25] = "Fase Final de 3 Iniciada",
            [26] = "%s[%s] Win",
            [27] = "Tipo de evento nao existe",
            [28] = " Sua classe nao é permitida nesse evento",
            [29] = " Voce esta usando itens proibidos no evento",
            [30] = " Voce precisa ter o convite no seu inventário para participar",
            [31] = "%s %d X %d %s",
            [32] = "=========== Melhor de %d ===========",
            [33] = " Parabens, Voce foi o %dº colocado",
            [34] = " Voce recebeu %d %s",
            [35] = " Evento Mata-Mata finalizado",
            [36] = " Voce foi removido do evento",
            [37] = " Mata-Mata inicia em %d minuto(s)",
            [38] = ">>>>>>   Evento Mata-Mata Iniciante (BK's)   <<<<<<",
            [39] = ">>>>>>   Evento Mata-Mata Privado   <<<<<<",
            [40] = "Mata-Mata Privado inicia em %d minuto(s)"
        },
    }
}


return MataMata_Config