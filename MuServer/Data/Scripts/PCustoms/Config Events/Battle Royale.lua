--Função de Ativar ou Desativar o Evento Automatico
BattleRoyale_SWITCH = 0 -- 1 ATIVADO // 0 DESATIVADO


--Day -> Só vai rodar no dia que você selecionar
-->Day of Week -> Dia da semana que vai rodar numero dos dias: (0 Domingo), (1 Segunda), (2 Terça), (3 Quarta), (4 Quinta), (5 Sexta), (6 Sábado)
--Caso todos os 2 Day e DayOfWeek esteja -1, então vai valer apenas a Hour e Minute.
EVENT_BattleRoyale = { 
--{_Day = -1, _DayOfWeek = -1, _Hour = 14, _Minute = 35},
}

--Comando de Abrir e de Ir Ao Evento
BattleRoyale_COMANDO_ABRIR = "/abrirbattle"
BattleRoyale_COMANDO_IR = "/battle"

-- O evento acontece em stadium, porém, pode ser usado outro mapa, basta configurar abaixo
-- a safearea deve obrigatoriamente ser uma extensão na parte de cima da area de pvp, do mesmo jeito que stadium
BattleRoyale_MapNumber = 6
BattleRoyale_PvpArea = {X1 = 55, Y1 = 142, X2 = 69, Y2 = 159}
BattleRoyale_SafeArea = {X1 = 55, Y1 = 161, X2 = 69, Y2 = 177}
BattleRoyale_DropArea = {X1 = 55, Y1 = 142, X2 = 69, Y2 = 177}
BattleRoyale_SafeCentro = {X = 63, Y = 168}
BattleRoyale_PvpCentro = {X = 63, Y = 150}

-- Classes permitidas a aprticipar do evento
-- 0 SM, 1 BK, 2 ELF, 3 MG, 4 DL
BattleRoyale_Classepermitida = {}
BattleRoyale_Classepermitida[0] = true
BattleRoyale_Classepermitida[1] = true
BattleRoyale_Classepermitida[2] = true
BattleRoyale_Classepermitida[3] = true
BattleRoyale_Classepermitida[4] = true
BattleRoyale_Classepermitida[5] = true
BattleRoyale_Classepermitida[6] = true

-- Level minimo para entrar no evento
BattleRoyale_LevelMinimo = 100

-- true Remover os pontos de status do char, false deixa como esta
BattleRoyale_ResetStats = true

-- true Redistribui a MasterSkillTree
BattleRoyale_ResetSkillTree = false

-- true Remove todas as skill do player
BattleRoyale_ResetSkills = false

BattleRoyale_ReturnSkills = {
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
}

-- Quantidade de pontos que recebera para distribuir
BattleRoyale_Points = 10000

--Contagem Regressiva de Abertura do evento
BattleRoyale_TIMER_OPEN = 15 -- Tempo em Segundos !

BattleRoyale_Premio = {Nome = "EventPoints", Valor = 50, Tabela = "CashShopData", Coluna = "WCoinP", Where = "AccountID", Tipo = 0}
BattleRoyale_Pontos = {Valor = 1, Tabela = "Character", Coluna = "BattleR", Where = "Name", Tipo = 1}
BattleRoyale_Pontos2 = {Valor = 1, Tabela = "Character", Coluna = "BattleR", Where = "Name", Tipo = 1}

BattleRoyale_DropSteps = 2

-- configurar lista de drops
BattleRoyale_Itens = {
    [1] = {
        {Section = 12, ID = 7, DropCount = 5 },
        {Section = 12, ID = 8, DropCount = 5 },
        {Section = 12, ID = 9, DropCount = 5 },
        {Section = 12, ID = 10, DropCount = 5 },
        {Section = 12, ID = 11, DropCount = 5 },
        {Section = 12, ID = 12, DropCount = 5 },
        {Section = 12, ID = 13, DropCount = 5 },
        {Section = 12, ID = 14, DropCount = 5 },
    },

    [2] = {
        {Section = 0 , ID = 0 , DropCount = 5 },
        {Section = 0 , ID = 12, DropCount = 5 },
        {Section = 0 , ID = 11, DropCount = 5 },
        {Section = 0 , ID = 8 , DropCount = 5 },
        {Section = 0 , ID = 19, DropCount = 5 },
        {Section = 2 , ID = 4 , DropCount = 5 },
        {Section = 2 , ID = 12, DropCount = 5 },
        {Section = 6 , ID = 5 , DropCount = 5 },
        {Section = 6 , ID = 12, DropCount = 5 },
        {Section = 6 , ID = 13, DropCount = 5 },
        {Section = 6 , ID = 8 , DropCount = 5 },
        {Section = 7 , ID = 0 , DropCount = 5 },
        {Section = 8 , ID = 0 , DropCount = 5 },
        {Section = 9 , ID = 0 , DropCount = 5 },
        {Section = 10, ID = 0 , DropCount = 5 },
        {Section = 11, ID = 0 , DropCount = 5 },
        {Section = 7 , ID = 1 , DropCount = 5 },
        {Section = 8 , ID = 1 , DropCount = 5 },
        {Section = 9 , ID = 1 , DropCount = 5 },
        {Section = 10, ID = 1 , DropCount = 5 },
        {Section = 11, ID = 1 , DropCount = 5 },
        {Section = 7 , ID = 8 , DropCount = 5 },
        {Section = 8 , ID = 8 , DropCount = 5 },
        {Section = 9 , ID = 8 , DropCount = 5 },
        {Section = 10, ID = 8 , DropCount = 5 },
        {Section = 11, ID = 8 , DropCount = 5 },
        {Section = 7 , ID = 9 , DropCount = 5 },
        {Section = 8 , ID = 9 , DropCount = 5 },
        {Section = 9 , ID = 9 , DropCount = 5 },
        {Section = 10, ID = 9 , DropCount = 5 },
        {Section = 11, ID = 9 , DropCount = 5 },
        {Section = 7 , ID = 16, DropCount = 5 },
        {Section = 8 , ID = 16, DropCount = 5 },
        {Section = 9 , ID = 16, DropCount = 5 },
        {Section = 10, ID = 16, DropCount = 5 },
        {Section = 11, ID = 16, DropCount = 5 },
        {Section = 12, ID = 2 , DropCount = 15},
    },
}


BattleRoyale_Message = {
    ["Eng"] = {
        [1] = "[Sistema] Battle Royale está aberto!",
        [2] = "[Sistema] Você saiu do evento!",
        [3] = "[Battle Royale] O mapa agora vai começar a tirar HP!",
        [4] = "CORRA para o centro do mapa %d %d para não perder HP!!!",
        [5] = "[Sistema] Vá para o centro do mapa %d %d para não perder HP!",
        [6] = "[Battle Royale] Todos devem sair AGORA da área protegida!",
        [7] = "Quem permanecer por mais de 30 segundos, será movido!!!!",
        [8] = "(Venham para %d %d e se matem!)",
        [9] = "[Sistema] Você foi movido por permanecer na área protegida!",
        [10] = "[Battle Royale] %s movido porque ficou na área protegida!",
        [11] = "[Battle Royale] Restam %d players vivos!",
        [12] = "[Sistema] Battle Royale finalizado!",
        [13] = "(Os players demoraram para se matar ou todos saíram do mapa/jogo).",
        [14] = "Vencedor: %s",
        [15] = "~> Prémio: %d %s! <~",
        [16] = "[Sistema] O evento não pode iniciar",
        [17] = "porque vieram menos de 2 players!",
        [18] = "Move %s fechou!",
        [19] = "Aguarde o próximo evento.",
        [20] = "Distribua seus pontos, os itens droparão em alguns segundos",
        [21] = "Move %s fecha em %d segundo(s)",
        [22] = "Itens foram dropados no safezone",
        [23] = "[Sistema] Uso %s tempo",
        [24] = "[Sistema] O tempo máximo para abrir é de 60 segundos!",
        [25] = "[Sistema] %s abriu %s",
        [26] = "[Sistema] STAFFERs não podem participar de eventos!",
        [27] = "Você precisa estar no level %d para participar",
        [28] = "[Sistema] Battle Royale não está aberto neste momento.",
        [29] = "[Sistema] Sua classe não é permitida no evento",
        [30] = "[Sistema] Seu inventário precisa estar vazio, sem NENHUM item!",
        [31] = "--> Guarde todos os seus itens no Baú.",
        [32] = "[Sistema] Feche o Baú ou outras janelas que estiverem abertas!",
        [33] = "[Sistema] Você será movido em alguns segundos...",
        [34] = "Não relogue, não mova ou será eliminado",
        [35] = "[Battle Royale] %s matou %s",
        [36] = "[Battle Royale] Você matou %s",
        [37] = "[Battle Royale] %s matou você!",
    },
    ["Por"] = {
        [1] = "[Sistema] Battle Royale está aberto!",
        [2] = "[Sistema] Você saiu do evento!",
        [3] = "[Battle Royale] O mapa agora vai começar a tirar HP!",
        [4] = "CORRA para o centro do mapa %d %d para não perder HP!!!",
        [5] = "[Sistema] Vá para o centro do mapa %d %d para não perder HP!",
        [6] = "[Battle Royale] Todos devem sair AGORA da área protegida!",
        [7] = "Quem permanecer por mais de 30 segundos, será movido!!!!",
        [8] = "(Venham para %d %d e se matem!)",
        [9] = "[Sistema] Você foi movido por permanecer na área protegida!",
        [10] = "[Battle Royale] %s movido porque ficou na área protegida!",
        [11] = "[Battle Royale] Restam %d players vivos!",
        [12] = "[Sistema] Battle Royale finalizado!",
        [13] = "(Os players demoraram para se matar ou todos saíram do mapa/jogo).",
        [14] = "Vencedor: %s",
        [15] = "~> Pr?mio: %d %s! <~",
        [16] = "[Sistema] O evento não pode iniciar",
        [17] = "porque vieram menos de 2 players!",
        [18] = "Move %s fechou!",
        [19] = "Aguarde o próximo evento.",
        [20] = "Distribua seus pontos, os itens droparão em alguns segundos",
        [21] = "Move %s fecha em %d segundo(s)",
        [22] = "Itens foram dropados no safezone",
        [23] = "[Sistema] Uso %s tempo",
        [24] = "[Sistema] O tempo máximo para abrir é de 60 segundos!",
        [25] = "[Sistema] %s abriu %s",
        [26] = "[Sistema] STAFFERs não podem participar de eventos!",
        [27] = "Você precisa estar no level %d para participar",
        [28] = "[Sistema] Battle Royale não está aberto neste momento.",
        [29] = "[Sistema] Sua classe não é permitida no evento",
        [30] = "[Sistema] Seu inventário precisa estar vazio, sem NENHUM item!",
        [31] = "--> Guarde todos os seus itens no Baú.",
        [32] = "[Sistema] Feche o Baú ou outras janelas que estiverem abertas!",
        [33] = "[Sistema] Você será movido em alguns segundos...",
        [34] = "Não relogue, não mova ou será eliminado",
        [35] = "[Battle Royale] %s matou %s",
        [36] = "[Battle Royale] Você matou %s",
        [37] = "[Battle Royale] %s matou você!",
    },
    ["Spn"] = {
        [1] = "[Sistema] Battle Royale está aberto!",
        [2] = "[Sistema] Você saiu do evento!",
        [3] = "[Battle Royale] O mapa agora vai começar a tirar HP!",
        [4] = "CORRA para o centro do mapa %d %d para não perder HP!!!",
        [5] = "[Sistema] Vá para o centro do mapa %d %d para não perder HP!",
        [6] = "[Battle Royale] Todos devem sair AGORA da área protegida!",
        [7] = "Quem permanecer por mais de 30 segundos, será movido!!!!",
        [8] = "(Venham para %d %d e se matem!)",
        [9] = "[Sistema] Você foi movido por permanecer na área protegida!",
        [10] = "[Battle Royale] %s movido porque ficou na área protegida!",
        [11] = "[Battle Royale] Restam %d players vivos!",
        [12] = "[Sistema] Battle Royale finalizado!",
        [13] = "(Os players demoraram para se matar ou todos saíram do mapa/jogo).",
        [14] = "Vencedor: %s",
        [15] = "~> Prémio: %d %s! <~",
        [16] = "[Sistema] O evento não pode iniciar",
        [17] = "porque vieram menos de 2 players!",
        [18] = "Move %s fechou!",
        [19] = "Aguarde o próximo evento.",
        [20] = "Distribua seus pontos, os itens droparão em alguns segundos",
        [21] = "Move %s fecha em %d segundo(s)",
        [22] = "Itens foram dropados no safezone",
        [23] = "[Sistema] Uso %s tempo",
        [24] = "[Sistema] O tempo máximo para abrir é de 60 segundos!",
        [25] = "[Sistema] %s abriu %s",
        [26] = "[Sistema] STAFFERs não podem participar de eventos!",
        [27] = "Você precisa estar no level %d para participar",
        [28] = "[Sistema] Battle Royale não está aberto neste momento.",
        [29] = "[Sistema] Sua classe não é permitida no evento",
        [30] = "[Sistema] Seu inventário precisa estar vazio, sem NENHUM item!",
        [31] = "--> Guarde todos os seus itens no Baú.",
        [32] = "[Sistema] Feche o Baú ou outras janelas que estiverem abertas!",
        [33] = "[Sistema] Você será movido em alguns segundos...",
        [34] = "Não relogue, não mova ou será eliminado",
        [35] = "[Battle Royale] %s matou %s",
        [36] = "[Battle Royale] Você matou %s",
        [37] = "[Battle Royale] %s matou você!",
    },


}