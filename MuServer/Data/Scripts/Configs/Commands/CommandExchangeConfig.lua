--[[
Commands Config
]]--
EXCHANGE_COMMAND = "/trocar"
EXCHANGE_COMMAND_SWITCH = 0 -- 1 ative 0 desative

EXCHANGE_COMMAND_COIN_TABLE = {}
EXCHANGE_COMMAND_COIN_TABLE[0] = "MEMB_INFO"
EXCHANGE_COMMAND_COIN_TABLE[1] = "MEMB_INFO"
EXCHANGE_COMMAND_COIN_TABLE[2] = "MEMB_INFO"

EXCHANGE_COMMAND_COIN_COLUMN = {}
EXCHANGE_COMMAND_COIN_COLUMN[0] = "Cash"
EXCHANGE_COMMAND_COIN_COLUMN[1] = "Golds"
EXCHANGE_COMMAND_COIN_COLUMN[2] = "Terceira"

EXCHANGE_COMMAND_COIN_WHERE = {}
EXCHANGE_COMMAND_COIN_WHERE[0] = "memb___id"
EXCHANGE_COMMAND_COIN_WHERE[1] = "memb___id"
EXCHANGE_COMMAND_COIN_WHERE[2] = "memb___id"

EXCHANGE_COMMAND_COIN_NAME = {}
EXCHANGE_COMMAND_COIN_NAME[0] = "Cashs"
EXCHANGE_COMMAND_COIN_NAME[1] = "Golds"
EXCHANGE_COMMAND_COIN_NAME[2] = "Qualquer"

--NOTA: PEÇO FAZENDO FAVOR QUE UTILIZEM EM CASO DE JOIAS APENAS MULTIPLOS DE 10 O MÁXIMO É 640 QUE NO CASO 64 JÓIAS + 10 MÍNIMO 10! ISSO É JÓIAS!

--Aqui é onde será requisitado!
--String: Identificação do comando exemplo: /exchange JewelOfSoul10
--Name: Nome do jewel / moeda que será trocado
--TargetName: Nome que será recebido
--Index: Index do item caso seja se não for deixe -1
--Section: Seção do item caso não for deixe -1
--Request: Quantia requisitada de moeda / jewel
--IsJewel: Se for Joia, coloque 1, se for moeda coloque 0
--CoinsType: Tipo da moeda pedido acima só funciona se for trocado moeda por outra coisa...
--Identification: Identificação no EXCHANGE_ITENS
EXCHANGE_COINS_JEWELS = {
{String = "JewelOfSoul10", Name = "Jewel of Soul", TargetName = "Cash", Request = 20, Index = 14, Section = 14, IsJewel = 1, CoinsType = 0, Identification = 1},
{String = "Cash1", Name = "Cash", TargetName = "Jewel Of Soul", Request = 20, Index = -1, Section = -1, IsJewel = 0, CoinsType = 0, Identification = 2},}

--Aqui e onde será trocado...
--Identification: Identificação confirme a configuração acima
--Index: Index do item caso seja se não for deixe -1
--Section: Seção do item caso não for deixe -1
--IsJewel: Caso for jewel coloque 1, se for moeda deixe 0
--Trade: Quantia que vai receber, lembre-se em caso de joias o inventário tem um limite de item... 64 jewels + 10 = 640... só use multiplos de 10 se não não funciona!
--CoinsType: Tipo da moeda das configuradas só funciona se a troca for para moedas
EXCHANGE_ITENS = {{Identification = 1, Index = -1, Section = -1, IsJewel = 0, Trade = 20, CoinsType = 0},
{Identification = 2, Index = 14, Section = 14, IsJewel = 1, Trade = 20, CoinsType = 0},}

--[[
Messager Config
]]--
EXCHANGE_MESSAGES = { }

EXCHANGE_MESSAGES["Por"] = {
[1] = "[Sistema] Você está impossibilitado de utilizar esse comando no momento!",
[2] = "Você precisa de %d %s para trocar por %s",
[3] = "[Sistema] Você não possui %s suficientes!",
[4] = "[Sistema] Você não possui %s suficientes!",
[5] = "Você trocou: %s (%d) por %s (%d)",
[6] = "[Sistema] Para utilizar esse comando deixe seu inventário vazio!",
[7] = "Você trocou: %s (%d) por %s (%d)",
[8] = "Não conseguimos encontrar nenhuma opção de troca!",
}

EXCHANGE_MESSAGES["Eng"] = {
[1] = "[System] You are currently unable to use this command!",
[2] = "You need %d %s to switch to %s",
[3] = "[System] You don't have enough %s!",
[4] = "[System] You don't have enough %s!",
[5] = "You replaced: %s (%d) with %s (%d)",
[6] = "[System] To use this command, leave your inventory empty!",
[7] = "You replaced: %s (%d) with %s (%d)",
[8] = "We couldn't find any exchange options!",
}

EXCHANGE_MESSAGES["Spn"] = {
[1] = "[Sistema] ¡Actualmente no puedes usar este comando!",
[2] = "Necesitas %d %s para cambiar a %s",
[3] = "[Sistema] ¡No tienes suficientes %s!",
[4] = "[Sistema] ¡No tienes suficientes %s!",
[5] = "Reemplazaste: %s ( %d) con %s ( %d)",
[6] = "[Sistema] Para usar este comando, ¡deje su inventario vacío!",
[7] = "Reemplazaste: %s ( %d) con %s ( %d)",
[8] = "¡No pudimos encontrar ninguna opción de intercambio!",
}