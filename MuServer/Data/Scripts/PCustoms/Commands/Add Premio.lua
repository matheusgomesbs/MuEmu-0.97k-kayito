AddPremio = {}

function AddPremio.Comando(aIndex, Arguments)
	local player = User.new(aIndex)
	local aNick = player:getName()

	if AddPremio_NivelPermissao[aNick] == nil then return end
	
	local pacote = string.lower(command:getString(Arguments, 1, 0))

	if pacote == nil or string.len(pacote) <= 0 then
		SendMessage(string.format("O pacote informado é inválido"), aIndex, 1)
		return
	end
	
	if AddPremio_Config[pacote] == nil then
		SendMessage(string.format(" %s não existe", pacote), aIndex, 1)
		return
	end
	
	if AddPremio_Config[pacote].NivelPermissao < AddPremio_NivelPermissao[aNick] then
		SendMessage(string.format("Você não tem permissão para adicionar esse pacote"), aIndex, 1)
		return
	end
	
	local bNick = command:getString(Arguments, 2, 0)
	
	if bNick == nil or string.len(bNick) <= 0 then
		SendMessage(string.format("O nick informado é inválido"), aIndex, 1)
		return
	end
	 
	local ret = db:exec(string.format("SELECT AccountID FROM Character WHERE Name = '%s'", bNick))
	
	if ret == 0 then
		db:clear()
		SendMessage(string.format("O nick informado é inválido"), aIndex, 1)
		return
	end
	
	if db:fetch() == 100 then
		SendMessage(string.format("Não foi possível localizar o personagem %s", bNick), aIndex, 1)
		return
	end
	
	local Acc = db:getStr("AccountID")
	db:clear()
	
	local Codigo = GuardiaoBrindes.GerarCodigo()
	if Codigo == "-1" then
		SendMessage("Erro no sistema, contate o administrador", aIndex, 1)
		return
	end

	GuardiaoBrindes.RegistrarCodigo(AddPremio_Config[pacote].Nome, Acc, Codigo, AddPremio_Config[pacote].TemValidade, AddPremio_Config[pacote].Dias)
	GuardiaoBrindes.RegistrarItens(Codigo, AddPremio_Itens[AddPremio_Config[pacote].IdPremio])
	
	SendMessageGlobal(string.format("%s adicionou %s para %s", aNick, AddPremio_Config[pacote].Nome, bNick), 0)
	LogAddC(4, string.format("%s adicionou %s para %s", aNick, AddPremio_Config[pacote].Nome, bNick))
	
	return
end

function AddPremio.Init()
	if AddPremio_Ativado then
		Commands.Register(AddPremio_Comando, AddPremio.Comando)
	end
end

AddPremio.Init()

return AddPremio

