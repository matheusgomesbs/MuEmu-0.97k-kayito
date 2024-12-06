#ifndef LUACHAOSBOX_H
#define LUACHAOSBOX_H

#pragma once

#include "OgocX.h"

#ifdef OLD_LUA
void RegisterChaosBoxClass(lua_State* lua);
#else
void RegisterChaosBoxClass(sol::state& lua);
#endif

#endif