#ifndef LUACHAOSBOXGENESIS_H
#define LUACHAOSBOXGENESIS_H

#pragma once

#ifdef CHAOS_MACHINE_GENESIS
#include "OgocX.h"

#ifdef OLD_LUA
void RegisterChaosBoxGenesisClass(lua_State* lua);
#else
void RegisterChaosBoxGenesisClass(sol::state& lua);
#endif
#endif

#endif