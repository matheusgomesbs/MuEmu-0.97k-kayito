#pragma once

//Lua Debugs Start
#ifndef LUA_USE_ASSERT
#define LUA_USE_ASSERT
#endif

#ifndef LUA_USE_APICHECK
#define LUA_USE_APICHECK
#endif
//Lua Debugs End

extern "C" {
#include <luajit\lua.h>
#include <luajit\lualib.h>
#include <luajit\lauxlib.h>
};

#ifndef OLD_LUA
#define SOL_PRINT_ERRORS 1
#define SOL_LUAJIT 1
#define SOL_ALL_SAFETIES_ON 1
#include <sol/sol.hpp>
#endif

class OgocX 
{
public:
	OgocX();
	~OgocX();

#ifndef OLD_LUA
	static void OpenExtension(std::string file);
	static void OpenProtectedExtension(std::string file);
#endif
	void CreateLua();
	void CloseLua();
	void do_file(std::string string);
	bool Generic_Call(char* func, char* sig, ...);

public:
#ifdef OLD_LUA
	lua_State* m_luaState;
#else
	sol::state lua;
#endif
	bool Loaded;
};