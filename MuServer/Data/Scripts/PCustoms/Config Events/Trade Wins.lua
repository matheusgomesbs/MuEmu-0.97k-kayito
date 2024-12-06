TradeWins_Ativado = false

TradeWins_Agenda = {
--{DiaDoMes = -1, DiaDaSemana = -1, Hora = 23, Minuto = 20},
}

TradeWins_Mapas = {
{Nome = "/bar",	Mapa = 0, X = 124, Y = 124},
{Nome = "/ferreiro", Mapa = 0, X = 116, Y = 140},
}

TradeWins_NpcClass = 249

TradeWins_CommandOpen = "/abrirtradewins"
TradeWins_CommandCancel = "/fimtradewins"

TradeWins_TempoMaximo = 2 -- Tempo máximo em minutos para do evento ser cancelado caso não tenha ganhadores

TradeWins_PremioMoeda = {Nome = "HPoints", Quantidade = 10, Tabela = "CashShopData", Coluna = "WCoinC", Where = "AccountID", Tipo = 0}
TradeWins_PremioPonto = {Quantidade = 1, Tabela = "Character", Coluna = "TradeWins", Where = "Name", Tipo = 1}
TradeWins_PremioPonto2 = {Quantidade = 1, Tabela = "Character", Coluna = "EventosTotal", Where = "Name", Tipo = 1}

TradeWins_Messages = {
    ["Por"] = {
        [1] = "## Evento Trade Wins ##",
        [2] = "## Evento Trade Wins Acabou ##",
        [3] = "Não houve vencedor!",
        [4] = "Vencedor: %s",
        [5] = "Prêmio: %d %s",
        [6] = "Já existe um Trade Wins aberto",
        [7] = "Utilize %s para finalizar",
        [8] = "Não existe um Trade Wins aberto",
        [9] = "Utilize %s para começar",
    },


}
