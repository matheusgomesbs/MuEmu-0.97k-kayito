--[[
declare global var
--]]

command = Command.new()

--[[
Initial System
]]--
OpenExtension('LuaSystem')
OpenExtension('Utils')
OpenExtension('Configs\\Commands')
OpenExtension('Configs')
OpenExtension('Character')
OpenExtension('Systems')
OpenExtension('Commands')
OpenProtectExtension('PCustoms')

function GameServer()
	LogAddC(1,"Lua Carregado com sucesso!")
	
	DataBase.Connect(3, "MuOnline", "sa", "123456")
end