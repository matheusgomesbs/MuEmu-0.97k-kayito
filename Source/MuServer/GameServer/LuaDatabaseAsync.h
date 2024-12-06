#pragma once

#include "OgocXManager.h"

class CLuaDatabaseAsync {
public:
	CLuaDatabaseAsync();
	~CLuaDatabaseAsync();

#ifdef OLD_LUA
	void RegisterFunction(lua_State* lua);
#else
	void RegisterFunction(sol::state& lua);
#endif
};

extern CLuaDatabaseAsync gLuaDatabaseAsync;