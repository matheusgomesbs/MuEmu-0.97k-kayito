WarKill_Config = {
    Ativado = true,

    Comando = {
        Abrir = "/abrirwarkill",
        Iniciar = "/iniciarwarkill",
        Cancelar = "/cancelarwarkill",
        Ir = "/warkill",
        Premiar = "/premiarwarkill"
    },

    Local = {
        -- Area onde o evento ocorre
        Area = {
            Mapa = 1,
            Inicio = {
                X = 11,
                Y = 176
            },
            Fim = {
                X = 29,
                Y = 194
            }
        },

        -- Local para onde os players são movidos ao entrar no evento
        Move = {
            Mapa = 1,
            X = 20,
            Y = 185
        }
    },

    -- Quantidade mínima de guilds para o evento acontecer
    MinimoGuilds = 2,

    -- Duração do evento em minutos
    Tempo = 5,

    -- true é necessario o GM estar no evento, false não é necessario
    GMObrigatorio = true,

    Premio = {
        -- Pontos de evento ganhos pela guild vencedora
        Guild = {
            [1] = {
                Quantidade = 3,
                Tabela = "Character",
                Coluna = "WarKill",
                Where = "Name"
            },
            [2] = {
                Quantidade = 2,
                Tabela = "Character",
                Coluna = "WarKill",
                Where = "Name"
            },
            [3] = {
                Quantidade = 1,
                Tabela = "Character",
                Coluna = "WarKill",
                Where = "Name"
            },
        },

        -- Moeda ganha pelo GM da guild vencedora (se participar)
        GM = {
            [1] = {
                Quantidade = 50,
                Nome = "EventPoints",
                Tabela = "CashShopData",
                Coluna = "WCoinP",
                Where = "AccountID",
                Tipo = 0
            },
            [2] = {
                Quantidade = 25,
                Nome = "EventPoints",
                Tabela = "CashShopData",
                Coluna = "WCoinP",
                Where = "AccountID",
                Tipo = 0
            },
            [3] = {
                Quantidade = 15,
                Nome = "EventPoints",
                Tabela = "CashShopData",
                Coluna = "WCoinP",
                Where = "AccountID",
                Tipo = 0
            },
        },

        -- Moeda ganha pelos membros da guild vencedora (somente os que participaram)
        Membro = {
            [1] = {
                Quantidade = 50,
                Nome = "EventPoints",
                Tabela = "CashShopData",
                Coluna = "WCoinP",
                Where = "AccountID",
                Tipo = 0
            },
            [2] = {
                Quantidade = 30,
                Nome = "EventPoints",
                Tabela = "CashShopData",
                Coluna = "WCoinP",
                Where = "AccountID",
                Tipo = 0
            },
            [3] = {
                Quantidade = 15,
                Nome = "EventPoints",
                Tabela = "CashShopData",
                Coluna = "WCoinP",
                Where = "AccountID",
                Tipo = 0
            },
        }
    },

    Pontos = {
        -- Pontos perdidos se morrer no evento (dobra se morrer pra alguem da sua propria guild)
        PerdeAoMorrer = {
            GM = 2,
            Membro = 1,
        },

        -- Pontos ganhos ao matar no evento
        GanhaAoMatar = {
            GM = 4,
            Membro = 2
        }
    },

    ContadorDeMortes = {
        -- [IndexDoItem] = {Mortes_Ganhas_Ao_Matar, Mortes_Perdidas_Ao_Morre}
        [GET_ITEM(0, 20)] = {GanhaAoMatar = 1, PerdeAoMorrer = 0},
    },

    Message = {
        ["Eng"] = {
            [1] = {Text = "Já existe um War Kill ativo, utilize %s para cancelar", Color = 1},
            [2] = {Text = "Utilize %s <tempo>", Color = 1},
            [3] = {Text = "Digite %s para participar", Color = 0},
            [4] = {Text = "Evento fecha em %d segundo(s)", Color = 0},
            [5] = {Text = "%s fechado", Color = 0},
            [6] = {Text = "Aguarde o próximo evento", Color = 0},
            [7] = {Text = "Não existe um War Kill ativo, utilize %s", Color = 1},
            [8] = {Text = "War Kill cancelado", Color = 1},
            [9] = {Text = "Você precisa estar em uma guild para participar", Color = 1},
            [10] = {Text = "Você foi movido para o evento", Color = 1},
            [11] = {Text = "Evento cancelado, não há o mínimo de guilds", Color = 1},
            [12] = {Text = "Já existe um War Kill iniciado", Color = 1},
            [13] = {Text = "Evento Iniciado!", Color = 0},
            [14] = {Text = "Você saiu do evento", Color = 1},
            [15] = {Text = "Evento finalizado, utilize %s ou %s", Color = 1},
            [16] = {Text = "<~ Guild Vencedora ~>", Color = 0},
            [17] = {Text = "Pontos: %d", Color = 0},
            [18] = {Text = "Evento Finalizado!", Color = 0},
            [19] = {Text = "Evento Finalizado, utilize %s", Color = 1},
            [20] = {Text = "Aguarde o inicio do evento", Color = 1},
            [21] = {Text = "[%s]%s Matou [%s]%s", Color = 0},
            [22] = {Text = "Sua Guild perdeu %d ponto(s)", Color = 1},
            [23] = {Text = "Sua Guild ganhou %d ponto(s)", Color = 1},
            [24] = {Text = "Você recebeu %d %s de premiação", Color = 1},
            [25] = {Text = "Aguarde o evento terminar ou use %s", Color = 1},
            [26] = {Text = "Seu GM não estava participando do evento", Color = 1},
            [27] = {Text = "GUILD [%s] DESCLASSIFICADA!", Color = 0},
            [28] = {Text = "Use %s para iniciar o evento", Color = 1},
        },

        ["Por"] = {
            [1] = {Text = "Já existe um War Kill ativo, utilize %s para cancelar", Color = 1},
            [2] = {Text = "Utilize %s <tempo>", Color = 1},
            [3] = {Text = "Digite %s para participar", Color = 0},
            [4] = {Text = "Evento fecha em %d segundo(s)", Color = 0},
            [5] = {Text = "%s fechado", Color = 0},
            [6] = {Text = "Aguarde o próximo evento", Color = 0},
            [7] = {Text = "Não existe um War Kill ativo, utilize %s", Color = 1},
            [8] = {Text = "War Kill cancelado", Color = 1},
            [9] = {Text = "Você precisa estar em uma guild para participar", Color = 1},
            [10] = {Text = "Você foi movido para o evento", Color = 1},
            [11] = {Text = "Evento cancelado, não há o mínimo de guilds", Color = 1},
            [12] = {Text = "Já existe um War Kill iniciado", Color = 1},
            [13] = {Text = "Evento Iniciado!", Color = 0},
            [14] = {Text = "Você saiu do evento", Color = 1},
            [15] = {Text = "Evento finalizado, utilize %s ou %s", Color = 1},
            [16] = {Text = "<~ Guild Vencedora ~>", Color = 0},
            [17] = {Text = "Pontos: %d", Color = 0},
            [18] = {Text = "Evento Finalizado!", Color = 0},
            [19] = {Text = "Evento Finalizado, utilize %s", Color = 1},
            [20] = {Text = "Aguarde o inicio do evento", Color = 1},
            [21] = {Text = "[%s]%s Matou [%s]%s", Color = 0},
            [22] = {Text = "Sua Guild perdeu %d ponto(s)", Color = 1},
            [23] = {Text = "Sua Guild ganhou %d ponto(s)", Color = 1},
            [24] = {Text = "Você recebeu %d %s de premiação", Color = 1},
            [25] = {Text = "Aguarde o evento terminar ou use %s", Color = 1},
            [26] = {Text = "Seu GM não estava participando do evento", Color = 1},
            [27] = {Text = "GUILD [%s] DESCLASSIFICADA!", Color = 0},
            [28] = {Text = "Use %s para iniciar o evento", Color = 1},
        },

        ["Spn"] = {
            [1] = {Text = "Já existe um War Kill ativo, utilize %s para cancelar", Color = 1},
            [2] = {Text = "Utilize %s <tempo>", Color = 1},
            [3] = {Text = "Digite %s para participar", Color = 0},
            [4] = {Text = "Evento fecha em %d segundo(s)", Color = 0},
            [5] = {Text = "%s fechado", Color = 0},
            [6] = {Text = "Aguarde o próximo evento", Color = 0},
            [7] = {Text = "Não existe um War Kill ativo, utilize %s", Color = 1},
            [8] = {Text = "War Kill cancelado", Color = 1},
            [9] = {Text = "Você precisa estar em uma guild para participar", Color = 1},
            [10] = {Text = "Você foi movido para o evento", Color = 1},
            [11] = {Text = "Evento cancelado, não há o mínimo de guilds", Color = 1},
            [12] = {Text = "Já existe um War Kill iniciado", Color = 1},
            [13] = {Text = "Evento Iniciado!", Color = 0},
            [14] = {Text = "Você saiu do evento", Color = 1},
            [15] = {Text = "Evento finalizado, utilize %s ou %s", Color = 1},
            [16] = {Text = "<~ Guild Vencedora ~>", Color = 0},
            [17] = {Text = "Pontos: %d", Color = 0},
            [18] = {Text = "Evento Finalizado!", Color = 0},
            [19] = {Text = "Evento Finalizado, utilize %s", Color = 1},
            [20] = {Text = "Aguarde o inicio do evento", Color = 1},
            [21] = {Text = "[%s]%s Matou [%s]%s", Color = 0},
            [22] = {Text = "Sua Guild perdeu %d ponto(s)", Color = 1},
            [23] = {Text = "Sua Guild ganhou %d ponto(s)", Color = 1},
            [24] = {Text = "Você recebeu %d %s de premiação", Color = 1},
            [25] = {Text = "Aguarde o evento terminar ou use %s", Color = 1},
            [26] = {Text = "Seu GM não estava participando do evento", Color = 1},
            [27] = {Text = "GUILD [%s] DESCLASSIFICADA!", Color = 0},
            [28] = {Text = "Use %s para iniciar o evento", Color = 1},
        },
    }

}

return WarKill_Config