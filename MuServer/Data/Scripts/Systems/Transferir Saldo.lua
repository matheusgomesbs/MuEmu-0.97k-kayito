TransferirSaldo = {}

function TransferirSaldo.Init()	
	if TransferirSaldo_Ativado then
		Commands.Register(TransferirSaldo_Comando, TransferirSaldo.Comando)
	end
end

function TransferirSaldo.Comando(aIndex, Arguments)
	local p = User.new(aIndex)
	local ONome = p:getName()
	local OAcc = p:getAccountID()
	
	local DNome = command:getString(Arguments, 1, 0)
	local valor = command:getNumber(Arguments, 2)
	local moeda = string.lower(command:getString(Arguments, 3, 0))
	
	local DIndex = GetIndex(DNome)
	
	if DIndex == -1 then
		SendMessage(string.format(" %s não existe ou está offline", DNome), aIndex, 1)
		return
	end
	
	local d = User.new(DIndex)
	
	if TransferirSaldo_Config[moeda] == nil then
		SendMessage(string.format(" Moeda inválida"), aIndex, 1)
		return
	end
	
	if valor == nil or valor <= 0 then
		SendMessage(string.format(" O valor deve ser maior que 0"), aIndex, 1)
		return
	end
	
	local tipo = ""
	local tipo2 = ""
	if TransferirSaldo_Config[moeda].Tipo == 0 then
		tipo = OAcc
		tipo2 = d:getAccountID()
	else
		tipo = ONome
		tipo2 = DNome
	end
	
	local saldo = DataBase.GetValue(TransferirSaldo_Config[moeda].Tabela, TransferirSaldo_Config[moeda].Coluna, TransferirSaldo_Config[moeda].Where, tipo)

	if saldo < valor then
		SendMessage(string.format(" Saldo insuficiente "), aIndex, 1)
		return
	end
	
	DataBase.SetDecreaseValue(TransferirSaldo_Config[moeda].Tabela, TransferirSaldo_Config[moeda].Coluna, valor, TransferirSaldo_Config[moeda].Where, tipo)
	DataBase.SetAddValue(TransferirSaldo_Config[moeda].Tabela, TransferirSaldo_Config[moeda].Coluna, valor, TransferirSaldo_Config[moeda].Where, tipo2)
	
	SendMessage(string.format(" %d %s tranferido(s) para %s ", valor, TransferirSaldo_Config[moeda].Nome, DNome), aIndex, 1)
	SendMessage(string.format(" %s transferiu %d %s para você ", ONome, valor, TransferirSaldo_Config[moeda].Nome), DIndex, 1)
	return
end

TransferirSaldo.Init()

return TransferirSaldo