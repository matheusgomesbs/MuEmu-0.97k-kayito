AuthorizarionAccount = {}

AUTORIZATION_ACCOUNT = {}
AUTORIZATION_ACCOUNT["king10"] = {_checkChar = true, _char = "LOTUS"}

function AuthorizarionAccount.CheckAuth(aIndex, command)

	local auth = false
	local player = User.new(aIndex)
	local login = player:getAccountID()
	local name = player:getName()

	if AUTORIZATION_ACCOUNT[login] ~= nil then 
		if AUTORIZATION_ACCOUNT[login]._checkChar then 
			if name == AUTORIZATION_ACCOUNT[login]._char then 
				auth = true
			end
		else 
			auth = true
		end
	end

	if auth then
		LogAddC(2, string.format("[Authorized] %s utilizou o comando %s", name, command))
	else 
		LogAddC(2, string.format("[Not Authorized] %s utilizou o comando %s", name, command))
	end

	return auth
end

return AuthorizarionAccount