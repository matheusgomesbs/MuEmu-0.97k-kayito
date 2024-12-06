#ifndef LUAUSER_H
#define LUAUSER_H

#pragma once

#include "OgocX.h"

#ifdef OLD_LUA
void RegisterUserClass(lua_State* lua);
#else
void RegisterUserClass(sol::state& lua);
#endif
#endif