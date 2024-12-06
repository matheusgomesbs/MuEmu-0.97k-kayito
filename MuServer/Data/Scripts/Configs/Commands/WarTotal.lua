----------------------------------------------------------------
                -- WAR TOTAL GUILD
				-- DEVELOPER : WAAL
				-- LICENCE   : ALFAMU
----------------------------------------------------------------

-- COMANDO PARA REGISTRAR AS GUILDS ( MÁXIMO 2 )
local WARTOTAL_REGISTER_GUILD = "/registerguilds"

-- COMANDO PARA LIBERAR A LUTA
local WARTOTAL_FREE_PVP = "/liberarwartotal"

-- COMANDO PARA SABER O RESULTADO
local WARTOTAL_RESULT = "/resultadowartotal"

-- COMANDO PARA LIMPAR O EVENTO
local WARTOTAL_CLEAN = "/limparwartotal"

local Guild1 = ''
local Guild2 = ''
local started = false

local GuildWins = ''
local PointsGuildWins = 0

function WarTotal_RegisterGuild(aIndex, Commands)

    local player = User.new(aIndex)
	if player:getAuthority() == 1
	then
		return
	end
	
	local GuildName1 = command:getString(Commands, 1, 0)
	local GuildName2 = command:getString(Commands, 2, 0)
	
	if #GuildName1 == 0 or #GuildName2 == 0
	then
		SendMessage(string.format("[Sistema] Uso: %s <Guild1> <Guild2>", WARTOTAL_REGISTER_GUILD), aIndex, 1)
		return
	end
	
	if #Guild1 == 0 and #Guild2 == 0
	then
		Guild1 = GuildName1
		Guild2 = GuildName2
		
		SendMessage(string.format("[Sistema] Guilds: %s e %s, cadastradas com sucesso!", Guild1, Guild2), aIndex, 1)
		return
	end
	
	SendMessage(string.format("[Sistema] Você ja cadastrou as guilds: %s e %s, continue o evento!", Guild1, Guild2), aIndex, 1)
end

function WarTotal_FreePvP(aIndex, Arguments)

    local player = User.new(aIndex)
	if player:getAuthority() == 1
	then
		return
	end
	
	SendMessageGlobal(string.format("========================"), 0)
	SendMessageGlobal(string.format" ~ WAR TOTAL ~ ", 0)
	SendMessageGlobal(string.format("[G]%s vs [G]%s", Guild1, Guild2), 0)
	SendMessageGlobal(string.format("QUE COMECE A BATALHA!"), 0)
	SendMessageGlobal(string.format("========================"), 0)
	
	started = true
end

function WarTotal_GuildWarProc(GuildName1, GuildPoints1, GuildName2, GuildPoints2)
	if started == false
	then
		return
	end
	
	if GuildName1 ~= Guild1 or GuildName2 ~= Guild2
	then
		if GuildName2 ~= Guild1 or GuildName1 ~= Guild2
		then
			return
		end
	end

	SendMessageGlobal(string.format(" ~ WAR TOTAL ~ "), 0)
	SendMessageGlobal(string.format("========================"), 0)
	SendMessageGlobal(string.format("[G]%s (%d) | (%d) [G]%s", GuildName1, GuildPoints1, GuildPoints2, GuildName2), 0)
	SendMessageGlobal(string.format("========================"), 0)
	
	if GuildPoints1 > 18
	then
		SendMessageGlobal(string.format("========================"), 0)
		SendMessageGlobal(string.format(" ~ WAR TOTAL ~ "), 0)
		SendMessageGlobal(string.format("[G]%s Wins!", GuildName1), 0)
		SendMessageGlobal(string.format("========================"), 0)
		
		started = false
		
		GuildWins = GuildName1
		PointsGuildWins = GuildPoints1
		return
	end
	
	if GuildPoints2 > 18
	then
		SendMessageGlobal(string.format("========================"), 0)
		SendMessageGlobal(string.format(" ~ WAR TOTAL ~ "), 0)
		SendMessageGlobal(string.format("[G]%s Wins!", GuildName2), 0)
		SendMessageGlobal(string.format("========================"), 0)
		
		started = false
		
		GuildWins = GuildName2
		PointsGuildWins = GuildPoints2
	end
end

function WarTotal_CommandResult(aIndex, Arguments)

    local player = User.new(aIndex)
	if player:getAuthority() == 1
	then
		return
	end
	
	if #GuildWins == 0
	then
		SendMessage(string.format("[Sistema] Não possui nenhuma guild como vencedora!"), aIndex, 1)
	end

	SendMessageGlobal(string.format("========================"), 0)
	SendMessageGlobal(string.format(" ~ RESULTADO WAR TOTAL ~ "), 0)
	SendMessageGlobal(string.format("[G] %s (%d) Pontos Wins", GuildWins, PointsGuildWins), 0)
	SendMessageGlobal(string.format("========================"), 0)
end

function WarTotal_CommandFinish(aIndex, Arguments)

    local player = User.new(aIndex)
	if player:getAuthority() == 1
	then
		return
	end
	
	Guild1 = ''
	Guild2 = ''
	started = false
	
	GuildWins = ''
	PointsGuildWins = 0
	
	SendMessage(string.format("[Sistema] Sistema pronto para próximas guilds!"), aIndex, 1)
end

Commands.Register(WARTOTAL_REGISTER_GUILD, WarTotal_RegisterGuild)
Commands.Register(WARTOTAL_FREE_PVP, WarTotal_FreePvP)
Commands.Register(WARTOTAL_RESULT, WarTotal_CommandResult)
Commands.Register(WARTOTAL_CLEAN, WarTotal_CommandFinish)

GameServerFunctions.GuildWarProc(WarTotal_GuildWarProc)