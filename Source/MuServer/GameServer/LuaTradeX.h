#ifndef LUATRADEX_H
#define LUATRADEX_H

#pragma once

#include "OgocX.h"

#if (GAMESERVER_UPDATE==201 || GAMESERVER_UPDATE == 603)
#ifdef OLD_LUA
void RegisterTradeXClass(lua_State* lua);
#else
void RegisterTradeXClass(sol::state& lua);
#endif
#endif
#endif