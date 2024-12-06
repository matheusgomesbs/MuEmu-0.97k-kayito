#include "stdafx.h"
#include "OgocX.h"
#include "OgocXManager.h"
#include "Util.h"
#include "LuaCommands.h"
#include "LuaDatabase.h"
#include "LuaUser.h"
#include "LuaFunctions.h"
#include "LuaInventory.h"
#include "LuaWarehouse.h"
#include "LuaTradeX.h"
#include "LuaTrade.h"
#include "LuaChaosBox.h"
#include "LuaChaosBoxGenesis.h"
#include "LuaElementSlot.h"
#include "LuaUserGuild.h"
#include "MuLuaFileProtect.h"
#include "LuaSocket.h"
#include "LuaDatabaseAsync.h"
#include "Log.h"

OgocX::OgocX() : 
	Loaded(false)
#ifdef OLD_LUA
	, m_luaState(nullptr)
#else
	, lua()
#endif
{

}

OgocX::~OgocX()
{
	this->CloseLua();
}

#ifndef OLD_LUA
void OgocX::OpenExtension(std::string folder) {
	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		return;
	}

	char path_name[MAX_PATH] = { 0 };
	sprintf_s(path_name, gPath.GetFullPath("Scripts\\%s\\"), folder.c_str());

	char name[MAX_PATH] = { 0 };
	char wildcard_path[MAX_PATH];

	wsprintf(wildcard_path, "%s*.lua", path_name);

	WIN32_FIND_DATA data;

	HANDLE file = FindFirstFile(wildcard_path, &data);

	if (file == INVALID_HANDLE_VALUE)
	{
		return;
	}

	do
	{
		if ((data.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) == 0)
		{
			if (_strcmpi("CharacterStatus.lua", data.cFileName) == 0)
			{
				continue;
			}

			sprintf_s(name, "%s%s", path_name, data.cFileName);

			auto file_load = Ogoc->lua.load_file(name);
			sol::protected_function_result file_result = file_load();

			if (!file_result.valid()) {
				sol::error err = file_result;
				std::string what = err.what();
				ErrorMessageBox("Error load file: %s", what.c_str());
				return;
			}
		}
	} while (FindNextFile(file, &data) != 0);
}

void OgocX::OpenProtectedExtension(std::string folder)
{
	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		return;
	}

	char path_name[MAX_PATH] = { 0 };
	sprintf_s(path_name, gPath.GetFullPath("Scripts\\%s\\"), folder.c_str());

	char name[MAX_PATH] = { 0 };
	char wildcard_path[MAX_PATH];

	wsprintf(wildcard_path, "%s*.lua", folder);

	WIN32_FIND_DATA data;

	HANDLE file = FindFirstFile(wildcard_path, &data);

	if (file == INVALID_HANDLE_VALUE)
	{
		return;
	}

	static CCriticalSection m_critical;

	do
	{
		if ((data.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) == 0)
		{
			if (_strcmpi("CharacterStatus.lua", data.cFileName) == 0)
			{
				continue;
			}

			m_critical.lock();

			sprintf_s(name, "%s\\%s", folder, data.cFileName);

			gFileProtect.ConvertMainFilePath((char*)name);

			auto file_load = Ogoc->lua.load_file(name);

			sol::protected_function_result file_result = file_load();

			if (!file_result.valid()) {
				gFileProtect.DeleteTemporaryFile();
				m_critical.unlock();

				sol::error err = file_result;
				std::string what = err.what();
				ErrorMessageBox("Error load file: %s", what.c_str());
				return;
			}

			gFileProtect.DeleteTemporaryFile();

			m_critical.unlock();
		}
	} while (FindNextFile(file, &data) != 0);
}
#endif

void OgocX::CreateLua()
{
#ifndef OLD_LUA
	this->lua.open_libraries(sol::lib::base,
		sol::lib::package,
		sol::lib::coroutine,
		sol::lib::string,
		sol::lib::os,
		sol::lib::math,
		sol::lib::table,
		sol::lib::debug,
		sol::lib::bit32,
		sol::lib::io,
		sol::lib::ffi,
		sol::lib::jit,
		sol::lib::utf8);

	this->lua.set_function("OpenExtension", &this->OpenExtension);
	this->lua.set_function("OpenProtectExtension", &this->OpenProtectedExtension);

	RegisterCallFunctions(this->lua);
	RegisterCommandsClas(this->lua);
	RegisterDatabase(this->lua);
	RegisterUserClass(this->lua);
	RegisterInventoryClass(this->lua);
	RegisterChaosBoxClass(this->lua);
	RegisterTradeClass(this->lua);
#if (GAMESERVER_UPDATE==201 || GAMESERVER_UPDATE == 603)
	RegisterTradeXClass(this->lua);
#endif
#if (GAMESERVER_UPDATE==201)
	RegisterElementSlotClass(this->lua);
#endif
#ifdef CHAOS_MACHINE_GENESIS
	RegisterChaosBoxGenesisClass(this->lua);
#endif
	RegisterWarehouseClass(this->lua);

	gLuaDatabaseAsync.RegisterFunction(this->lua);

	gLuaUserGuild.AddGuild(this->lua);
	gSocket.SetGlobalFunctions(this->lua);
#else
	this->m_luaState = luaL_newstate();

	if (this->m_luaState == nullptr) {
		return;
	}

	luaL_openlibs(this->m_luaState);

	gLuaFunctions.AddFunctions(this->m_luaState);
	gLuaUserGuild.AddGuild(this->m_luaState);
	gSocket.SetGlobalFunctions(this->m_luaState);
	RegisterDatabase(this->m_luaState);
	RegisterInventoryClass(this->m_luaState);
	RegisterChaosBoxClass(this->m_luaState);
	RegisterTradeClass(this->m_luaState);
#if (GAMESERVER_UPDATE==201 || GAMESERVER_UPDATE == 603)
	RegisterTradeXClass(this->m_luaState);
#endif
#if (GAMESERVER_UPDATE==201)
	RegisterElementSlotClass(this->m_luaState);
#endif
#ifdef CHAOS_MACHINE_GENESIS
	RegisterChaosBoxGenesisClass(this->m_luaState);
#endif
	RegisterWarehouseClass(this->m_luaState);
	RegisterUserClass(this->m_luaState);
	RegisterCommandsClas(this->m_luaState);

	gLuaDatabaseAsync.RegisterFunction(this->m_luaState);

	lua_gc(this->m_luaState, LUA_GCCOLLECT, 0);
#endif
}

void OgocX::CloseLua()
{
#ifdef OLD_LUA
	if (this->m_luaState)
	{
		lua_close(this->m_luaState);
		this->m_luaState = nullptr;
	}
#endif
}

void OgocX::do_file(std::string string)
{
#ifdef OLD_LUA
	if (this->m_luaState == nullptr)
	{
		return;
	}

	// Carrega o arquivo Lua
	if (luaL_loadfile(this->m_luaState, string.c_str()))
	{
		ErrorMessageBox("Error loading Lua file: %s\n", lua_tostring(this->m_luaState, -1));
		lua_pop(this->m_luaState, 1);  // Remove a mensagem de erro da pilha
		return;
	}

	// Executa o script Lua
	INT iState = lua_pcall(this->m_luaState, 0, LUA_MULTRET, 0);

	if (iState)
	{
		ErrorMessageBox("Error executing Lua script: %s (State = %d)\n", lua_tostring(this->m_luaState, -1), iState);
		lua_pop(this->m_luaState, 1);  // Remove a mensagem de erro da pilha
		return;
	}
#else
	auto file_load = this->lua.load_file(string);

	sol::protected_function_result file_result = file_load();

	if (!file_result.valid()) {
		sol::error err = file_result;
		std::string what = err.what();
		ErrorMessageBox("Error load file: %s", what.c_str());
		return;
	}

	this->Loaded = true;
#endif
}

bool OgocX::Generic_Call(char* func, char* sig, ...)
{
#ifdef OLD_LUA
	if (this->m_luaState == nullptr)
	{
		return false;
	}

	va_list	VA_LIST;
	int nArg = 0;

	va_start(VA_LIST, sig);
	lua_getglobal(this->m_luaState, func);

	char buffer[512];
	memset(buffer, 0, sizeof(buffer));

	while (*sig)
	{
		switch (*sig++)
		{
		case 'd':
		{
			lua_pushnumber(this->m_luaState, va_arg(VA_LIST, double));
		} break;

		case 'i':
		{
			lua_pushnumber(this->m_luaState, va_arg(VA_LIST, int));
		} break;

		case 's':
		{
			char* pszString = va_arg(VA_LIST, char*);
			lua_pushlstring(this->m_luaState, pszString, strlen(pszString));
		} break;

		case 'w':
		{
			lua_pushnumber(this->m_luaState, va_arg(VA_LIST, unsigned int));
		} break;

		case 'l':
		{
			lua_pushinteger(this->m_luaState, va_arg(VA_LIST, unsigned long long));
		} break;

		case 'j':
		{
			lua_pushnumber(this->m_luaState, va_arg(VA_LIST, unsigned long));
		} break;

		case 'f':
		{
			lua_pushnumber(this->m_luaState, va_arg(VA_LIST, float));
		} break;

		case '>':
		{
			goto endwhile;
		}

		default:
		{
			sprintf_s(buffer, "GameServerCALL error running function '%s': '%s'", func, lua_tolstring(this->m_luaState, -1, 0));
			gLog.Output(LOG_LUA, buffer);
			return false;
		}
		}

		nArg++;
		luaL_checkstack(this->m_luaState, 1, "too many arguments");

	} endwhile:

	int nRes = strlen(sig);

	int nStatus = lua_pcall(this->m_luaState, nArg, nRes, 0);

	if (nStatus != 0)
	{
		gLuaGameServer.ProcessErrorLog(this->m_luaState, func, nStatus);
		return false;
	}

	int nRetValCnt = nRes;
	nRes = -nRes;

	while (*sig)
	{
		switch (*sig++)
		{
		case 'd':
		{
			if (!lua_isnumber(this->m_luaState, nRes))
			{
				return false;
			}
			*va_arg(VA_LIST, double*) = lua_tonumber(this->m_luaState, nRes);

		} break;

		case 'i':
		{
			if (!lua_isnumber(this->m_luaState, nRes))
			{
				return false;
			}

			*va_arg(VA_LIST, int*) = (int)lua_tointeger(this->m_luaState, nRes);
		} break;

		case 's':
		{
			if (!lua_isstring(this->m_luaState, nRes))
			{
				return false;
			}

			*va_arg(VA_LIST, const char**) = lua_tostring(this->m_luaState, nRes);
		} break;

		case 'w':
		{
			if (!lua_isnumber(this->m_luaState, nRes))
			{
				return false;
			}

			*va_arg(VA_LIST, unsigned int*) = (unsigned int)lua_tointeger(this->m_luaState, nRes);
		} break;

		case 'l':
		{
			if (!lua_isnumber(this->m_luaState, nRes))
			{
				return false;
			}

			*va_arg(VA_LIST, unsigned long long*) = (unsigned long long)lua_tointeger(this->m_luaState, nRes);
		} break;

		case 'f':
		{
			if (!lua_isnumber(this->m_luaState, nRes))
			{
				return false;
			}
			*va_arg(VA_LIST, float*) = (float)lua_tonumber(this->m_luaState, nRes);

		} break;

		case 'j':
		{
			if (!lua_isnumber(this->m_luaState, nRes))
			{
				return false;
			}
			*va_arg(VA_LIST, unsigned long*) = (unsigned long)lua_tointeger(this->m_luaState, nRes);

		} break;

		default:
		{
			return false;
		} break;

		}

		nRes++;
	}

	va_end(VA_LIST);

	if (nRetValCnt)
	{
		lua_pop(this->m_luaState, nRetValCnt);
	}

#endif

	return true;
}
