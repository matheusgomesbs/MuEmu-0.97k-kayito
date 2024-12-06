#include "stdafx.h"
#include "LuaCommands.h"
#include "LuaStack.hpp"
#include "CommandManager.h"
#include "Util.h"

#ifdef OLD_LUA
void RegisterCommandsClas(lua_State* lua) {
	luaaa::LuaClass<CommandsClass> luaCommands(lua, "Command");
	luaCommands.fun("getNumber", &CommandsClass::getNumber);
	luaCommands.fun("getString", &CommandsClass::getString);
}
#else
void RegisterCommandsClas(sol::state& lua) {
	sol::usertype<CommandsClass> command_type = lua.new_usertype<CommandsClass>("Command", sol::constructors<CommandsClass()>());

	command_type["getNumber"] = &CommandsClass::getNumber;
	command_type["getString"] = &CommandsClass::getString;
}
#endif