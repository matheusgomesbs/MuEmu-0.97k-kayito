#ifndef LUA_ELEMENT_SLOT_H
#define LUA_ELEMENT_SLOT_H

#pragma once

#include "OgocX.h"

#if(GAMESERVER_UPDATE==201)
#ifdef OLD_LUA
void RegisterElementSlotClass(lua_State* lua);
#else
void RegisterElementSlotClass(sol::state& lua);
#endif
#endif
#endif