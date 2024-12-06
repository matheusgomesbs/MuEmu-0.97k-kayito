#ifndef LUAINVENTORY_H
#define LUAINVENTORY_H

#pragma once

#include "OgocX.h"

#ifdef OLD_LUA
void RegisterInventoryClass(lua_State* lua);
#else
void RegisterInventoryClass(sol::state& lua);
#endif
#endif