Batatinha_Config = {
    Enabled = true, -- ativa/desativa o evento

    Comando = {
        Abrir = { --comando para bairr o evento
            ["Eng"] = "/opengreenlight",
            ["Por"] = "/abrirbatatinha",
            ["Spn"] = "/abrirbatatinha",
        },
        
        Ir = { -- comando para participar do evento
            ["Eng"] = "/greenlight",
            ["Por"] = "/batatinha",
            ["Spn"] = "/batatinha",
        },

        Cancelar = { --comando para cancelar o envento
            ["Eng"] = "/cancelgreenlight",
            ["Por"] = "/cancelarbatatinha",
            ["Spn"] = "/cancelarbatatinha",
        }
    },

    Local = {
        Area = {Mapa = 6, X1 = 51, Y1 = 136, X2 = 74, Y2 = 184}, --area total do evento, se sair sera eliminado
        Move = {Mapa = 6, X = 62, Y = 182}, --local onde os players vao nascer no evento
        Npc = {Mapa = 6, X = 62, Y = 139}, -- local onde fica o npc
        SafeArea = {Mapa = 6, X1 = 60, Y1 = 138, X2 = 65, Y2 = 141} -- area que o player tem que estar pra poder clicar no npc
    },

    EliminatePlayerIfNotInArea = true, -- true o player é eliminado se clicar no npc e nao estiver na area segura

    CanGoWithItens = false, -- false o player nao pode ter itens no inventario/lojinha para ir no evento

    Npc = {Class = 224, Dir = -1}, -- classe e direção do npc

    MinimoPlayers = 1, -- minimo de player a participar

    Tempo = 5, -- tempo em minutos do evento, após esse tempo o evento é finalizado

    TempoAnuncio = 1, -- tempo em minutos q avisa que vai haver o evento

    TempoAberto = 15, -- tempo em segundos que o comando de entrar fica aberto no evento automatico

    Agenda = { -- data e hora que o evento acontece
       -- {Dia = -1, DiaDaSemana = -1, Hora = 13, Minuto = 57},
    },

    Vencedores = 1, -- quantidade de players que podem vencer (tem que ser mior ou igual a quantidade minima de participantes)

    Premio = { -- premio para os vencedores, entre colchetes a posição do player (tem que ter a configuração para todos os ganhadores)
        [1] = {
            {Nome = "EventPoints", Valor = 15, Tabela = "CashShopData", Coluna = "WCoinP", Where = "AccountID", IdType = 0},
            {Nome = "Events", Valor = 1, Tabela = "CashShopData", Coluna = "Events", Where = "AccountID", IdType = 0},
        },
    },

    Ponto = {
        [1] = {-- pontos para os vencedores, entre colchetes a posição do player (tem que ter a configuração para todos os ganhadores)
            {Valor = 1, Tabela = "Character", Coluna = "Batatinha", Where = "Name", IdType = 1},
        },
    },
	
	PremioItem = {
		[1] = {
            { ItemIndex = GET_ITEM(14, 212), Level = 0, Op1 = 0, Op2 = 0, Life = 0, Exc = 0, Ancient = 0, JoH = 0, SocketBonus = 0, Sock1 = 0, Sock2 = 0, Sock3 = 0, Sock4 = 0, Sock5 = 0, ItemTime = 0, DaysExpire = 30, Name = 'Luck Events Reward', Count = 1},		
        },
	},

    Message = { -- mensagens do sistema
        ["Eng"] = {
            [1] = " The event is already open, use %s ",
            [2] = " Use %s <time> ",
            [3] = " %s opened: Green Ligth Red Light ",
            [4] = "%s closes in %d second(s)",
            [5] = "%s closed",
            [6] = "Atention, the event starts in 5 seconds",
            [7] = " There are no opened events, use %s ",
            [8] = "Event cancelled: Green Ligth Red Light",
            [9] = " You were teleported and are unable to move ",
            [10] = " Wait till the event start ",
            [11] = "Green Ligth Red Light starts ib %d second(s)",
            [12] = "Green Ligth Red Light started",
            [13] = "Green Ligth Red Light cancelled for lack of players",
            [14] = " You left the event ",
            [15] = "GREEN LIGHT",
            [16] = "GREEN LIGHT",
            [17] = "GREEN LIGHT",
            [18] = "GREEN LIGHT",
            [19] = "RED LIGHT",
            [20] = "%s eliminated",
            [21] = "Green Ligth Red Light has ended without winners!",
            [22] = " Congrats! you were the %dº winner ",
            [23] = " You will be teleported to Lorencia ",
            [24] = "%s Won Green Ligth Red Light",
            [25] = " You received %d %s as a reward ",
            [26] = " Your inventory must be empty to enter the event ",
            [27] = " Your personal store must be empty to enter the event "
        },

        ["Por"] = {
            [1] = " Já há um evento aberto, use %s ",
            [2] = " Use %s <tempo> ",
            [3] = " %s Abriu o evento: Batatinha Frita 123 ",
            [4] = "%s fecha em %d segundo(s)",
            [5] = "%s fechado",
            [6] = "Preparem-se, o evento inicia em 5 segundos",
            [7] = " Não há um evento aberto, use %s ",
            [8] = "Evento cancelado: Batatinha Frita 123",
            [9] = " Você foi movido e esta impossibilitado de andar ",
            [10] = " Aguarde o inicio do evento ",
            [11] = "Batatinha Frita 123 inicia em %d minuto(s)",
            [12] = "Batatinha Frita 123 iniciado",
            [13] = "Batatinha Frita 123 cancelado por falta de participantes",
            [14] = " você saiu do evento ",
            [15] = "BATATINHA",
            [16] = "FRITA",
            [17] = "1",
            [18] = "2",
            [19] = "3",
            [20] = "%s eliminado",
            [21] = "Batatinha Frita 123 finalizado, não houve vencedores!",
            [22] = " Parabéns! você foi o %dº vencedor(a) ",
            [23] = " Você será movido para Lorencia ",
            [24] = "%s venceu o evento Batatinha Frita 123",
            [25] = " Você recebeu %d %s como premiação ",
            [26] = " Seu inventário precisa estar vazio para participar do evento ",
            [27] = " Sua loja pessoal precisa estar vazia para participar do evento "
        },

        ["Spn"] = {
            [1] = " Já há um evento aberto, use %s ",
            [2] = " Use %s <tempo> ",
            [3] = " %s Abriu o evento: Batatinha Frita 123 ",
            [4] = "%s fecha em %d segundo(s)",
            [5] = "%s fechado",
            [6] = "Preparem-se, o evento inicia em 5 segundos",
            [7] = " Não há um evento aberto, use %s ",
            [8] = "Evento cancelado: Batatinha Frita 123",
            [9] = " Você foi movido e esta impossibilitado de andar ",
            [10] = " Aguarde o inicio do evento ",
            [11] = "Batatinha Frita 123 inicia em %d minuto(s)",
            [12] = "Batatinha Frita 123 iniciado",
            [13] = "Batatinha Frita 123 cancelado por falta de participantes",
            [14] = " você saiu do evento ",
            [15] = "BATATINHA",
            [16] = "FRITA",
            [17] = "1",
            [18] = "2",
            [19] = "3",
            [20] = "%s eliminado",
            [21] = "Batatinha Frita 123 finalizado, não houve vencedores!",
            [22] = " Parabéns, você foi o %dº vencedor(a) ",
            [23] = " Você será movido para Lorencia ",
            [24] = "%s venceu o evento Batatinha Frita 123",
            [25] = " Você recebeu %d %s como premiação ",
            [26] = " Seu inventário precisa estar vazio para participar do evento ",
            [27] = " Sua loja pessoal precisa estar vazia para participar do evento "
        }
    }

}