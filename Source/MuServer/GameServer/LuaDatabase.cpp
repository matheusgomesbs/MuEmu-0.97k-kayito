#include "stdafx.h"
#include "LuaDatabase.h"
#include "LuaStack.hpp"
#include "Util.h"

#ifdef OLD_LUA
void RegisterDatabase(lua_State* lua) {
	luaaa::LuaClass<SQLServer> luaSQL(lua, "SQL");
	luaSQL.fun("connect", &SQLServer::connect);
	luaSQL.fun("exec", &SQLServer::exec);
	luaSQL.fun("execGetInt", &SQLServer::execGetInt);
	luaSQL.fun("execGetStr", &SQLServer::execGetStr);
	luaSQL.fun("fetch", &SQLServer::fetch);
	luaSQL.fun("clear", &SQLServer::clear);
	luaSQL.fun("getInt", &SQLServer::getInt);
	luaSQL.fun("getResult", &SQLServer::getResult);
	luaSQL.fun("getFloat", &SQLServer::getFloat);
	luaSQL.fun("getStr", &SQLServer::getStr);
}
#else
void RegisterDatabase(sol::state& lua) {
	sol::usertype<SQLServer> sqlFunc = lua.new_usertype<SQLServer>("SQL", sol::constructors<SQLServer()>());

	sqlFunc["connect"] = &SQLServer::connect;
	sqlFunc["exec"] = &SQLServer::exec;
	sqlFunc["execGetInt"] = &SQLServer::execGetInt;
	sqlFunc["execGetStr"] = &SQLServer::execGetStr;
	sqlFunc["fetch"] = &SQLServer::fetch;
	sqlFunc["clear"] = &SQLServer::clear;
	sqlFunc["getInt"] = &SQLServer::getInt;
	sqlFunc["getResult"] = &SQLServer::getResult;
	sqlFunc["getFloat"] = &SQLServer::getFloat;
	sqlFunc["getStr"] = &SQLServer::getStr;
}
#endif