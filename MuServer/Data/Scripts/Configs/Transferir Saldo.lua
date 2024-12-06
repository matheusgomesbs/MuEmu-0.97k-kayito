
-- true ativa o sistema, false desativa
TransferirSaldo_Ativado = true

TransferirSaldo_Comando = "/transfer" -- /comando nick valor moeda


TransferirSaldo_Config = {}
TransferirSaldo_Config["hcash"] =        {Nome = "HCash",       Tabela = "MEMB_INFO",         Coluna = "cash",            Where = "memb___id", Tipo = 0}
TransferirSaldo_Config["hpoints"] =      {Nome = "HPoints",     Tabela = "MEMB_INFO",         Coluna = "hpoints",         Where = "memb___id", Tipo = 0}
TransferirSaldo_Config["jcpoints"] =     {Nome = "JCPoints",    Tabela = "MEMB_INFO",         Coluna = "jcpoints",        Where = "memb___id", Tipo = 0}
TransferirSaldo_Config["horas"] =        {Nome = "HorasOn",     Tabela = "MEMB_INFO",         Coluna = "MEMB_INFO",       Where = "memb___id", Tipo = 0}
TransferirSaldo_Config["points"] =       {Nome = "EventPoints", Tabela = "CashShopData",      Coluna = "WCoinP",          Where = "AccountID", Tipo = 0}