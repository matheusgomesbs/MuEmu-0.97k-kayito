#pragma once

#include "OgocX.h"
#include "Path.h"
#include "Util.h"
#include "LuaGameServer.h"
#include "CriticalSection.h"

class COgocXManager {
public:
	COgocXManager() : Ogoc(nullptr) {
		
	};

	~COgocXManager() {
		this->ResetLua();
	};

	void ResetLua() {
		if (this->Ogoc) {
			this->Ogoc->CloseLua();
			delete Ogoc;
			this->Ogoc = nullptr;
		}
	}

	void CreateLua() {
		this->Ogoc = new OgocX();

		this->Ogoc->Loaded = false;

		this->Ogoc->CreateLua();
	};

#ifndef OLD_LUA
	OgocX* getOgoc() {
		return this->Ogoc;
	}
#else
	lua_State* getOgoc() {
		if (this->Ogoc == nullptr) {
			return nullptr;
		}

		return this->Ogoc->m_luaState;
	};
#endif

	void StartLua() {
		this->Ogoc->do_file(gPath.GetFullPath("Scripts\\GameServer.lua"));

		gLuaGameServer.GameServer();
	}

public:
	inline std::size_t getMemoryUsed() {
		if (this->Ogoc == nullptr) {
			return 0;
		}

#ifndef OLD_LUA
		return this->Ogoc->lua.memory_used();
#else
		std::size_t kb = static_cast<std::size_t>(lua_gc(this->Ogoc->m_luaState, LUA_GCCOUNT, 0));
		kb *= 1024;
		kb += static_cast<std::size_t>(lua_gc(this->Ogoc->m_luaState, LUA_GCCOUNTB, 0));
		return kb;
#endif
	}

public:
	OgocX* Ogoc;
};

extern COgocXManager OgocXManager;