#ifndef LUATRADE_H
#define LUATRADE_H

#pragma once

#include "OgocX.h"

#ifdef OLD_LUA
void RegisterTradeClass(lua_State* lua);
#else
void RegisterTradeClass(sol::state& lua);
#endif

#endif