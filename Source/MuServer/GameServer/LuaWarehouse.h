#ifndef LUAWAREHOUSE_H
#define LUAWAREHOUSE_H

#pragma once

#include "OgocX.h"

#ifdef OLD_LUA
void RegisterWarehouseClass(lua_State* lua);
#else
void RegisterWarehouseClass(sol::state& lua);
#endif
#endif