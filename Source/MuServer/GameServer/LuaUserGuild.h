#ifndef LUAUSERGUILD_H
#define LUAUSERGUILD_H

#pragma once

#include "OgocX.h"

class CLuaUserGuild
{
public:
	CLuaUserGuild();
	virtual ~CLuaUserGuild();

#ifdef OLD_LUA
	void AddGuild(lua_State* Lua);
#else
	void AddGuild(sol::state& lua);
#endif
};

extern CLuaUserGuild gLuaUserGuild;

#endif