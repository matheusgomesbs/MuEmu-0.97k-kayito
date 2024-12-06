#include "stdafx.h"
#include "LuaGameServer.h"
#include "GameMain.h"
#include "Util.h"
#include "Path.h"
#include "SocketManager.h"
#include "LuaSocket.h"
#include "OgocXManager.h"
#include "QueryManager.h"
#include "Log.h"
#include "QueryAsync.h"
#include "Chrono"

CLuaGameServer gLuaGameServer;

CLuaGameServer::CLuaGameServer() 
{
	this->m_Reloading = true;
}

CLuaGameServer::~CLuaGameServer()
{
}

void CLuaGameServer::Init()
{
	OgocXManager.CreateLua();

	OgocXManager.StartLua();

	gQueryAsync.start();

	this->m_Reloading = false;
}

void CLuaGameServer::InitReload()
{
	CLocker lock(gSocketManager.m_critical);

	OgocXManager.StartLua();

	this->m_Reloading = false;
}

void CLuaGameServer::Reload()
{
	CLocker lock(gSocketManager.m_critical);

	this->m_Reloading = true;

	gSocket.ClearPackets();

	OgocXManager.ResetLua();

	OgocXManager.CreateLua();

	this->InitReload();
}

void CLuaGameServer::GameServer()
{
#ifndef OLD_LUA
	CLocker lock(gSocketManager.m_critical);

	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		this->ProcessErrorLog("GameServer", "Error find State: " + GetCurrentThreadId());
		return;
	}

	if (!Ogoc->Loaded) {
		return;
	}

	sol::stack_guard luasg(Ogoc->lua);

	sol::protected_function gameServer(Ogoc->lua["GameServer"]);
	sol::protected_function_result result = gameServer();

	if (!result.valid()) {
		sol::error err = result;
		this->ProcessErrorLog("GameServer", err.what());
	}
#else
	CLocker lock(gSocketManager.m_critical);

	auto L = OgocXManager.getOgoc();

	if (L == nullptr) {
		return;
	}

	lua_getglobal(L, "GameServer");

	int nStatus = lua_pcall(L, 0, 0, 0);

	this->ProcessErrorLog(L, "GameServer", nStatus);
#endif
}

void CLuaGameServer::TimerSystem()
{
	if (this->m_Reloading)
	{
		return;
	}

#ifndef OLD_LUA
	CLocker lock(gSocketManager.m_critical);

	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		this->ProcessErrorLog("TimerSystem", "Error find State: " + GetCurrentThreadId());
		return;
	}

	if (!Ogoc->Loaded) {
		return;
	}

	sol::stack_guard luasg(Ogoc->lua);

	sol::protected_function timerSystem(Ogoc->lua["TimerSystem"]);
	sol::protected_function_result result = timerSystem();

	if (!result.valid()) {
		sol::error err = result;
		this->ProcessErrorLog("TimerSystem", err.what());
	}

	Ogoc->lua.collect_garbage();
#else
	CLocker lock(gSocketManager.m_critical);

	static long long lastTickTime = std::chrono::duration_cast<std::chrono::milliseconds>(
		std::chrono::steady_clock::now().time_since_epoch())
		.count();

	auto tick = std::chrono::duration_cast<std::chrono::milliseconds>(
		std::chrono::steady_clock::now().time_since_epoch())
		.count();

	if ((tick - lastTickTime) < 900) {
		return;
	}

	lastTickTime = tick;

	auto L = OgocXManager.getOgoc();

	if (L == nullptr) {
		return;
	}

	DWORD m_DelayLua = timeGetTime();

	lua_getglobal(L, "TimerSystem");

	int nStatus = lua_pcall(L, 0, 0, 0);

	this->ProcessErrorLog(L, "TimerSystem", nStatus);

	if ((int)(timeGetTime() - m_DelayLua) >= 20) {
		gLog.Output(LOG_LUA_EVENT, "[TimerSystem] delay %d milliseconds", (timeGetTime() - m_DelayLua));
	}
#endif
}

int CLuaGameServer::PlayerAttack(int aIndex, int TargetIndex, int IsSlap)
{
	if (this->m_Reloading)
	{
		return 0;
	}

#ifndef OLD_LUA
	CLocker lock(gSocketManager.m_critical);

	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		this->ProcessErrorLog("PlayerAttack", "Error find State: " + GetCurrentThreadId());
		return 0;
	}

	if (!Ogoc->Loaded) {
		return 0;
	}

	sol::stack_guard luasg(Ogoc->lua);

	sol::protected_function playerAttack(Ogoc->lua["PlayerAttack"]);
	sol::protected_function_result result = playerAttack(aIndex, TargetIndex);

	if (!result.valid()) {
		sol::error err = result;
		this->ProcessErrorLog("PlayerAttack", err.what());
		return 0;
	}
	else {
		return static_cast<int>(result);
	}
#else
	CLocker lock(gSocketManager.m_critical);

	auto L = OgocXManager.getOgoc();

	if (L == nullptr) {
		return 0;
	}

	DWORD m_DelayLua = timeGetTime();

	lua_getglobal(L, "PlayerAttack");

	lua_pushnumber(L, aIndex);
	lua_pushnumber(L, TargetIndex);

	int nStatus = lua_pcall(L, 2, 1, 0);

	this->ProcessErrorLog(L, "PlayerAttack", nStatus);

	int result = (int)lua_tointeger(L, -1);

	lua_pop(L, 1);

	if ((int)(timeGetTime() - m_DelayLua) >= 20) {
		gLog.Output(LOG_LUA_EVENT, "[PlayerAttack] delay %d milliseconds", (timeGetTime() - m_DelayLua));
	}

	//lua_gc(L, LUA_GCCOLLECT, 0);

	return result;
#endif
}

int CLuaGameServer::LevelUpPointAdd(int aIndex, int Type)
{
	if (this->m_Reloading)
	{
		return 0;
	}

#ifndef OLD_LUA
	CLocker lock(gSocketManager.m_critical);

	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		this->ProcessErrorLog("LevelUpPointAdd", "Error find State: " + GetCurrentThreadId());
		return 0;
	}

	if (!Ogoc->Loaded) {
		return 0;
	}

	sol::stack_guard luasg(Ogoc->lua);

	sol::protected_function levelUpPoint(Ogoc->lua["LevelUpPointAdd"]);
	sol::protected_function_result result = levelUpPoint(aIndex, Type);

	if (!result.valid()) {
		sol::error err = result;
		this->ProcessErrorLog("LevelUpPointAdd", err.what());
		return 0;
	}
	else {
		return static_cast<int>(result);
	}
#else
	CLocker lock(gSocketManager.m_critical);

	auto L = OgocXManager.getOgoc();

	if (L == nullptr) {
		return 0;
	}

	DWORD m_DelayLua = timeGetTime();

	lua_getglobal(L, "LevelUpPointAdd");

	lua_pushnumber(L, aIndex);
	lua_pushnumber(L, Type);

	int nStatus = lua_pcall(L, 2, 1, 0);

	this->ProcessErrorLog(L, "LevelUpPointAdd", nStatus);

	int result = (int)lua_tointeger(L, -1);

	lua_pop(L, 1);

	if ((int)(timeGetTime() - m_DelayLua) >= 20) {
		gLog.Output(LOG_LUA_EVENT, "[LevelUpPointAdd] delay %d milliseconds", (timeGetTime() - m_DelayLua));
	}

	return result;
#endif
}

void CLuaGameServer::PlayerMove(int aIndex, int Map, int ax, int ay, int sx, int sy)
{
	if (this->m_Reloading)
	{
		return;
	}

#ifndef OLD_LUA
	CLocker lock(gSocketManager.m_critical);

	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		this->ProcessErrorLog("PlayerMove", "Error find State: " + GetCurrentThreadId());
		return;
	}

	if (!Ogoc->Loaded) {
		return;
	}

	sol::stack_guard luasg(Ogoc->lua);

	sol::protected_function playerMove(Ogoc->lua["PlayerMove"]);
	sol::protected_function_result result = playerMove(aIndex, Map, ax, ay, sx, sy);

	if (!result.valid()) {
		sol::error err = result;
		this->ProcessErrorLog("PlayerMove", err.what());
	}

	Ogoc->lua.collect_garbage();
#else
	CLocker lock(gSocketManager.m_critical);

	auto L = OgocXManager.getOgoc();

	if (L == nullptr) {
		return;
	}

	DWORD m_DelayLua = timeGetTime();

	lua_getglobal(L, "PlayerMove");

	lua_pushnumber(L, aIndex);
	lua_pushnumber(L, Map);
	lua_pushnumber(L, ax);
	lua_pushnumber(L, ay);
	lua_pushnumber(L, sx);
	lua_pushnumber(L, sy);

	int nStatus = lua_pcall(L, 6, 0, 0);

	this->ProcessErrorLog(L, "PlayerMove", nStatus);

	if ((int)(timeGetTime() - m_DelayLua) >= 20) {
		gLog.Output(LOG_LUA_EVENT, "[PlayerMove] delay %d milliseconds", (timeGetTime() - m_DelayLua));
	}

	//lua_gc(L, LUA_GCCOLLECT, 0);
	//lua_gc(L, LUA_GCCOLLECT, 0);
#endif
}

void CLuaGameServer::CharacterSet(int aIndex)
{
	if (this->m_Reloading)
	{
		return;
	}

#ifndef OLD_LUA
	CLocker lock(gSocketManager.m_critical);

	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		this->ProcessErrorLog("CharacterSet", "Error find State: " + GetCurrentThreadId());
		return;
	}

	if (!Ogoc->Loaded) {
		return;
	}

	sol::stack_guard luasg(Ogoc->lua);

	sol::protected_function characterSet(Ogoc->lua["CharacterSet"]);
	sol::protected_function_result result = characterSet(aIndex);

	if (!result.valid()) {
		sol::error err = result;
		this->ProcessErrorLog("CharacterSet", err.what());
	}
#else
	CLocker lock(gSocketManager.m_critical);

	auto L = OgocXManager.getOgoc();

	if (L == nullptr) {
		return;
	}

	DWORD m_DelayLua = timeGetTime();

	lua_getglobal(L, "CharacterSet");

	lua_pushnumber(L, aIndex);

	int nStatus = lua_pcall(L, 1, 0, 0);

	this->ProcessErrorLog(L, "CharacterSet", nStatus);

	if ((int)(timeGetTime() - m_DelayLua) >= 20) {
		gLog.Output(LOG_LUA_EVENT, "[CharacterSet] delay %d milliseconds", (timeGetTime() - m_DelayLua));
	}

	//lua_gc(L, LUA_GCCOLLECT, 0);
#endif
}

void CLuaGameServer::EnterCharacter(int aIndex)
{
	if (this->m_Reloading)
	{
		return;
	}

#ifndef OLD_LUA
	CLocker lock(gSocketManager.m_critical);

	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		this->ProcessErrorLog("EnterCharacter", "Error find State: " + GetCurrentThreadId());
		return;
	}

	if (!Ogoc->Loaded) {
		return;
	}

	sol::stack_guard luasg(Ogoc->lua);

	sol::protected_function enterCharacter(Ogoc->lua["EnterCharacter"]);
	sol::protected_function_result result = enterCharacter(aIndex);

	if (!result.valid()) {
		sol::error err = result;
		this->ProcessErrorLog("EnterCharacter", err.what());
	}
#else
	CLocker lock(gSocketManager.m_critical);

	auto L = OgocXManager.getOgoc();

	if (L == nullptr) {
		return;
	}

	DWORD m_DelayLua = timeGetTime();

	lua_getglobal(L, "EnterCharacter");

	lua_pushnumber(L, aIndex);

	int nStatus = lua_pcall(L, 1, 0, 0);

	this->ProcessErrorLog(L, "EnterCharacter", nStatus);

	if ((int)(timeGetTime() - m_DelayLua) >= 20) {
		gLog.Output(LOG_LUA_EVENT, "[EnterCharacter] delay %d milliseconds", (timeGetTime() - m_DelayLua));
	}

	//lua_gc(L, LUA_GCCOLLECT, 0);
#endif
}

void CLuaGameServer::PlayerDie(int aIndex, int TargetIndex)
{
	if (this->m_Reloading)
	{
		return;
	}

#ifndef OLD_LUA
	CLocker lock(gSocketManager.m_critical);

	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		this->ProcessErrorLog("PlayerDie", "Error find State: " + GetCurrentThreadId());
		return;
	}

	if (!Ogoc->Loaded) {
		return;
	}

	sol::stack_guard luasg(Ogoc->lua);

	sol::protected_function playerDie(Ogoc->lua["PlayerDie"]);
	sol::protected_function_result result = playerDie(aIndex, TargetIndex);

	if (!result.valid()) {
		sol::error err = result;
		this->ProcessErrorLog("PlayerDie", err.what());
	}
#else
	CLocker lock(gSocketManager.m_critical);

	auto L = OgocXManager.getOgoc();

	if (L == nullptr) {
		return;
	}

	DWORD m_DelayLua = timeGetTime();

	lua_getglobal(L, "PlayerDie");

	lua_pushnumber(L, aIndex);
	lua_pushnumber(L, TargetIndex);

	int nStatus = lua_pcall(L, 2, 0, 0);

	this->ProcessErrorLog(L, "PlayerDie", nStatus);

	if ((int)(timeGetTime() - m_DelayLua) >= 20) {
		gLog.Output(LOG_LUA_EVENT, "[PlayerDie] delay %d milliseconds", (timeGetTime() - m_DelayLua));
	}

	//lua_gc(L, LUA_GCCOLLECT, 0);
#endif
}

void CLuaGameServer::PlayerLogout(int aIndex, std::string name, std::string account)
{
	if (this->m_Reloading)
	{
		return;
	}

#ifndef OLD_LUA
	CLocker lock(gSocketManager.m_critical);

	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		this->ProcessErrorLog("PlayerLogout", "Error find State: " + GetCurrentThreadId());
		return;
	}

	if (!Ogoc->Loaded) {
		return;
	}

	sol::stack_guard luasg(Ogoc->lua);

	sol::protected_function playerLoggout(Ogoc->lua["PlayerLogout"]);
	sol::protected_function_result result = playerLoggout(aIndex, name, account);

	if (!result.valid()) {
		sol::error err = result;
		this->ProcessErrorLog("PlayerLogout", err.what());
	}
#else
	CLocker lock(gSocketManager.m_critical);

	auto L = OgocXManager.getOgoc();

	if (L == nullptr) {
		return;
	}

	DWORD m_DelayLua = timeGetTime();

	lua_getglobal(L, "PlayerLogout");

	lua_pushnumber(L, aIndex);
	lua_pushstring(L, name.c_str());
	lua_pushstring(L, account.c_str());

	int nStatus = lua_pcall(L, 3, 0, 0);

	this->ProcessErrorLog(L, "PlayerLogout", nStatus);

	if ((int)(timeGetTime() - m_DelayLua) >= 20) {
		gLog.Output(LOG_LUA_EVENT, "[PlayerLogout] delay %d milliseconds", (timeGetTime() - m_DelayLua));
	}

	//lua_gc(L, LUA_GCCOLLECT, 0);
#endif
}

int CLuaGameServer::PlayerDropItem(int aIndex, int px, int py, int pos)
{
	if (this->m_Reloading)
	{
		return 0;
	}

#ifndef OLD_LUA
	CLocker lock(gSocketManager.m_critical);

	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		this->ProcessErrorLog("PlayerDropItem", "Error find State: " + GetCurrentThreadId());
		return 0;
	}

	if (!Ogoc->Loaded) {
		return 0;
	}

	sol::stack_guard luasg(Ogoc->lua);

	sol::protected_function playerdropItem(Ogoc->lua["PlayerDropItem"]);
	sol::protected_function_result result = playerdropItem(aIndex, px, py, pos);

	if (!result.valid()) {
		sol::error err = result;
		this->ProcessErrorLog("PlayerDropItem", err.what());
		return 0;
	}
	else {
		return static_cast<int>(result);
	}
#else
	CLocker lock(gSocketManager.m_critical);

	auto L = OgocXManager.getOgoc();

	if (L == nullptr) {
		return 0;
	}

	DWORD m_DelayLua = timeGetTime();

	lua_getglobal(L, "PlayerDropItem");

	lua_pushnumber(L, aIndex);
	lua_pushnumber(L, px);
	lua_pushnumber(L, py);
	lua_pushnumber(L, pos);

	int nStatus = lua_pcall(L, 4, 1, 0);

	this->ProcessErrorLog(L, "PlayerDropItem", nStatus);

	int result = (int)lua_tointeger(L, -1);

	lua_pop(L, 1);

	if ((int)(timeGetTime() - m_DelayLua) >= 20) {
		gLog.Output(LOG_LUA_EVENT, "[PlayerDropItem] delay %d milliseconds", (timeGetTime() - m_DelayLua));
	}

	//lua_gc(L, LUA_GCCOLLECT, 0);

	return result;
#endif
}

int CLuaGameServer::NpcTalk(int Npc, int Player)
{
	if (this->m_Reloading)
	{
		return 0;
	}

#ifndef OLD_LUA
	CLocker lock(gSocketManager.m_critical);

	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		this->ProcessErrorLog("NpcTalk", "Error find State: " + GetCurrentThreadId());
		return 0;
	}

	if (!Ogoc->Loaded) {
		return 0;
	}

	sol::stack_guard luasg(Ogoc->lua);

	sol::protected_function npcTalk(Ogoc->lua["NpcTalk"]);
	sol::protected_function_result result = npcTalk(Npc, Player);

	if (!result.valid()) {
		sol::error err = result;
		this->ProcessErrorLog("NpcTalk", err.what());
		return 0;
	}
	else {
		return static_cast<int>(result);
	}
#else
	CLocker lock(gSocketManager.m_critical);

	auto L = OgocXManager.getOgoc();

	if (L == nullptr) {
		return 0;
	}

	DWORD m_DelayLua = timeGetTime();

	lua_getglobal(L, "NpcTalk");

	lua_pushnumber(L, Npc);
	lua_pushnumber(L, Player);

	int nStatus = lua_pcall(L, 2, 1, 0);

	this->ProcessErrorLog(L, "NpcTalk", nStatus);

	int result = (int)lua_tointeger(L, -1);

	lua_pop(L, 1);

	if ((int)(timeGetTime() - m_DelayLua) >= 20) {
		gLog.Output(LOG_LUA_EVENT, "[NpcTalk] delay %d milliseconds", (timeGetTime() - m_DelayLua));
	}

	//lua_gc(L, LUA_GCCOLLECT, 0);

	return result;
#endif
}

void CLuaGameServer::MonsterDie(int aIndex, int TargetIndex)
{
	if (this->m_Reloading)
	{
		return;
	}

#ifndef OLD_LUA
	CLocker lock(gSocketManager.m_critical);

	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		this->ProcessErrorLog("MonsterDie", "Error find State: " + GetCurrentThreadId());
		return;
	}

	if (!Ogoc->Loaded) {
		return;
	}

	sol::stack_guard luasg(Ogoc->lua);

	sol::protected_function monsterDie(Ogoc->lua["MonsterDie"]);
	sol::protected_function_result result = monsterDie(aIndex, TargetIndex);

	if (!result.valid()) {
		sol::error err = result;
		this->ProcessErrorLog("MonsterDie", err.what());
	}
#else
	CLocker lock(gSocketManager.m_critical);

	auto L = OgocXManager.getOgoc();

	if (L == nullptr) {
		return;
	}

	DWORD m_DelayLua = timeGetTime();

	lua_getglobal(L, "MonsterDie");

	lua_pushnumber(L, aIndex);
	lua_pushnumber(L, TargetIndex);

	int nStatus = lua_pcall(L, 2, 0, 0);

	this->ProcessErrorLog(L, "MonsterDie", nStatus);

	if ((int)(timeGetTime() - m_DelayLua) >= 20) {
		gLog.Output(LOG_LUA_EVENT, "[MonsterDie] delay %d milliseconds", (timeGetTime() - m_DelayLua));
	}

	//lua_gc(L, LUA_GCCOLLECT, 0);
#endif
}

int CLuaGameServer::MonsterDieGiveItem(int aIndex, int TargetIndex)
{
	if (this->m_Reloading)
	{
		return 0;
	}

#ifndef OLD_LUA
	CLocker lock(gSocketManager.m_critical);

	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		this->ProcessErrorLog("MonsterDieGiveItem", "Error find State: " + GetCurrentThreadId());
		return 0;
	}

	if (!Ogoc->Loaded) {
		return 0;
	}

	sol::stack_guard luasg(Ogoc->lua);

	sol::protected_function monsterDieGiveItem(Ogoc->lua["MonsterDieGiveItem"]);
	sol::protected_function_result result = monsterDieGiveItem(aIndex, TargetIndex);

	if (!result.valid()) {
		sol::error err = result;
		this->ProcessErrorLog("MonsterDieGiveItem", err.what());
		return 0;
	}
	else {
		return static_cast<int>(result);
	}
#else
	CLocker lock(gSocketManager.m_critical);

	auto L = OgocXManager.getOgoc();

	if (L == nullptr) {
		return 0;
	}

	DWORD m_DelayLua = timeGetTime();

	lua_getglobal(L, "MonsterDieGiveItem");

	lua_pushnumber(L, aIndex);
	lua_pushnumber(L, TargetIndex);

	int nStatus = lua_pcall(L, 2, 1, 0);

	this->ProcessErrorLog(L, "MonsterDieGiveItem", nStatus);

	int result = (int)lua_tointeger(L, -1);

	lua_pop(L, 1);

	if ((int)(timeGetTime() - m_DelayLua) >= 20) {
		gLog.Output(LOG_LUA_EVENT, "[MonsterDieGiveItem] delay %d milliseconds", (timeGetTime() - m_DelayLua));
	}

	//lua_gc(L, LUA_GCCOLLECT, 0);

	return result;
#endif
}

int CLuaGameServer::PlayerSendTrade(int aIndex, int TargetIndex)
{
	if (this->m_Reloading)
	{
		return 0;
	}

#ifndef OLD_LUA
	CLocker lock(gSocketManager.m_critical);

	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		this->ProcessErrorLog("PlayerSendTrade", "Error find State: " + GetCurrentThreadId());
		return 0;
	}

	if (!Ogoc->Loaded) {
		return 0;
	}

	sol::stack_guard luasg(Ogoc->lua);

	sol::protected_function playerSendTrade(Ogoc->lua["PlayerSendTrade"]);
	sol::protected_function_result result = playerSendTrade(aIndex, TargetIndex);

	if (!result.valid()) {
		sol::error err = result;
		this->ProcessErrorLog("PlayerSendTrade", err.what());
		return 0;
	}
	else {
		return static_cast<int>(result);
	}
#else
	CLocker lock(gSocketManager.m_critical);

	auto L = OgocXManager.getOgoc();

	if (L == nullptr) {
		return 0;
	}

	DWORD m_DelayLua = timeGetTime();

	lua_getglobal(L, "PlayerSendTrade");

	lua_pushnumber(L, aIndex);
	lua_pushnumber(L, TargetIndex);

	int nStatus = lua_pcall(L, 2, 1, 0);

	this->ProcessErrorLog(L, "PlayerSendTrade", nStatus);

	int result = (int)lua_tointeger(L, -1);

	lua_pop(L, 1);

	if ((int)(timeGetTime() - m_DelayLua) >= 20) {
		gLog.Output(LOG_LUA_EVENT, "[PlayerSendTrade] delay %d milliseconds", (timeGetTime() - m_DelayLua));
	}

	//lua_gc(L, LUA_GCCOLLECT, 0);

	return result;
#endif
}

int CLuaGameServer::PlayerSendParty(int aIndex, int TargetIndex)
{
	if (this->m_Reloading)
	{
		return 0;
	}

#ifndef OLD_LUA
	CLocker lock(gSocketManager.m_critical);

	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		this->ProcessErrorLog("PlayerSendParty", "Error find State: " + GetCurrentThreadId());
		return 0;
	}

	if (!Ogoc->Loaded) {
		return 0;
	}

	sol::stack_guard luasg(Ogoc->lua);

	sol::protected_function playerSendParty(Ogoc->lua["PlayerSendParty"]);
	sol::protected_function_result result = playerSendParty(aIndex, TargetIndex);

	if (!result.valid()) {
		sol::error err = result;
		this->ProcessErrorLog("PlayerSendParty", err.what());
		return 0;
	}
	else {
		return static_cast<int>(result);
	}
#else
	CLocker lock(gSocketManager.m_critical);

	auto L = OgocXManager.getOgoc();

	if (L == nullptr) {
		return 0;
	}

	DWORD m_DelayLua = timeGetTime();

	lua_getglobal(L, "PlayerSendParty");

	lua_pushnumber(L, aIndex);
	lua_pushnumber(L, TargetIndex);

	int nStatus = lua_pcall(L, 2, 1, 0);

	this->ProcessErrorLog(L, "PlayerSendParty", nStatus);

	int result = (int)lua_tointeger(L, -1);

	lua_pop(L, 1);

	if ((int)(timeGetTime() - m_DelayLua) >= 20) {
		gLog.Output(LOG_LUA_EVENT, "[PlayerSendParty] delay %d milliseconds", (timeGetTime() - m_DelayLua));
	}

	//lua_gc(L, LUA_GCCOLLECT, 0);

	return result;
#endif
}

int CLuaGameServer::PlayerTradeOk(int aIndex, int TargetIndex)
{
	if (this->m_Reloading)
	{
		return 0;
	}

#ifndef OLD_LUA
	CLocker lock(gSocketManager.m_critical);

	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		this->ProcessErrorLog("PlayerTradeOk", "Error find State: " + GetCurrentThreadId());
		return 0;
	}

	if (!Ogoc->Loaded) {
		return 0;
	}

	sol::stack_guard luasg(Ogoc->lua);

	sol::protected_function playerTradeOk(Ogoc->lua["PlayerTradeOk"]);
	sol::protected_function_result result = playerTradeOk(aIndex, TargetIndex);

	if (!result.valid()) {
		sol::error err = result;
		this->ProcessErrorLog("PlayerTradeOk", err.what());
		return 0;
	}
	else {
		return static_cast<int>(result);
	}
#else
	CLocker lock(gSocketManager.m_critical);

	auto L = OgocXManager.getOgoc();

	if (L == nullptr) {
		return 0;
	}

	DWORD m_DelayLua = timeGetTime();

	lua_getglobal(L, "PlayerTradeOk");

	lua_pushnumber(L, aIndex);
	lua_pushnumber(L, TargetIndex);

	int nStatus = lua_pcall(L, 2, 1, 0);

	this->ProcessErrorLog(L, "PlayerTradeOk", nStatus);

	int result = (int)lua_tointeger(L, -1);

	lua_pop(L, 1);

	if ((int)(timeGetTime() - m_DelayLua) >= 20) {
		gLog.Output(LOG_LUA_EVENT, "[PlayerTradeOk] delay %d milliseconds", (timeGetTime() - m_DelayLua));
	}

	//lua_gc(L, LUA_GCCOLLECT, 0);

	return result;
#endif
}

int CLuaGameServer::PlayerTradeXOk(int aIndex, int TargetIndex)
{
	if (this->m_Reloading)
	{
		return 0;
	}

#ifndef OLD_LUA
	CLocker lock(gSocketManager.m_critical);

	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		this->ProcessErrorLog("PlayerTradeXOk", "Error find State: " + GetCurrentThreadId());
		return 0;
	}

	if (!Ogoc->Loaded) {
		return 0;
	}

	sol::stack_guard luasg(Ogoc->lua);

	sol::protected_function playerTradeXOk(Ogoc->lua["PlayerTradeXOk"]);
	sol::protected_function_result result = playerTradeXOk(aIndex, TargetIndex);

	if (!result.valid()) {
		sol::error err = result;
		this->ProcessErrorLog("PlayerTradeXOk", err.what());
		return 0;
	}
	else {
		return static_cast<int>(result);
	}
#else
	CLocker lock(gSocketManager.m_critical);

	auto L = OgocXManager.getOgoc();

	if (L == nullptr) {
		return 0;
	}

	DWORD m_DelayLua = timeGetTime();

	lua_getglobal(L, "PlayerTradeXOk");

	lua_pushnumber(L, aIndex);
	lua_pushnumber(L, TargetIndex);

	int nStatus = lua_pcall(L, 2, 1, 0);

	this->ProcessErrorLog(L, "PlayerTradeXOk", nStatus);

	int result = (int)lua_tointeger(L, -1);

	lua_pop(L, 1);

	if ((int)(timeGetTime() - m_DelayLua) >= 20) {
		gLog.Output(LOG_LUA_EVENT, "[PlayerTradeXOk] delay %d milliseconds", (timeGetTime() - m_DelayLua));
	}

	//lua_gc(L, LUA_GCCOLLECT, 0);

	return result;
#endif
}

int CLuaGameServer::PlayerSendTradeX(int aIndex, int TargetIndex)
{
	if (this->m_Reloading)
	{
		return 0;
	}

#ifndef OLD_LUA
	CLocker lock(gSocketManager.m_critical);

	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		this->ProcessErrorLog("PlayerSendTradeX", "Error find State: " + GetCurrentThreadId());
		return 0;
	}

	if (!Ogoc->Loaded) {
		return 0;
	}

	sol::stack_guard luasg(Ogoc->lua);

	sol::protected_function playerSendTradeX(Ogoc->lua["PlayerSendTradeX"]);
	sol::protected_function_result result = playerSendTradeX(aIndex, TargetIndex);

	if (!result.valid()) {
		sol::error err = result;
		this->ProcessErrorLog("PlayerSendTradeX", err.what());
		return 0;
	}
	else {
		return static_cast<int>(result);
	}
#else
	CLocker lock(gSocketManager.m_critical);

	auto L = OgocXManager.getOgoc();

	if (L == nullptr) {
		return 0;
	}

	DWORD m_DelayLua = timeGetTime();

	lua_getglobal(L, "PlayerSendTradeX");

	lua_pushnumber(L, aIndex);
	lua_pushnumber(L, TargetIndex);

	int nStatus = lua_pcall(L, 2, 1, 0);

	this->ProcessErrorLog(L, "PlayerSendTradeX", nStatus);

	int result = (int)lua_tointeger(L, -1);

	lua_pop(L, 1);

	if ((int)(timeGetTime() - m_DelayLua) >= 20) {
		gLog.Output(LOG_LUA_EVENT, "[PlayerSendTradeX] delay %d milliseconds", (timeGetTime() - m_DelayLua));
	}

	//lua_gc(L, LUA_GCCOLLECT, 0);

	return result;
#endif
}

void CLuaGameServer::GuildWarProc(std::string Guild1, int GuildPoints1, std::string Guild2, int GuildPoints2)
{
	if (this->m_Reloading)
	{
		return;
	}

#ifndef OLD_LUA
	CLocker lock(gSocketManager.m_critical);

	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		this->ProcessErrorLog("GuildWarProc", "Error find State: " + GetCurrentThreadId());
		return;
	}

	if (!Ogoc->Loaded) {
		return;
	}

	sol::stack_guard luasg(Ogoc->lua);

	sol::protected_function guildWarProc(Ogoc->lua["GuildWarProc"]);
	sol::protected_function_result result = guildWarProc(Guild1, GuildPoints1, Guild2, GuildPoints2);

	if (!result.valid()) {
		sol::error err = result;
		this->ProcessErrorLog("GuildWarProc", err.what());
	}
#else
	CLocker lock(gSocketManager.m_critical);

	auto L = OgocXManager.getOgoc();

	if (L == nullptr) {
		return;
	}

	DWORD m_DelayLua = timeGetTime();

	lua_getglobal(L, "GuildWarProc");

	lua_pushstring(L, Guild1.c_str());
	lua_pushnumber(L, GuildPoints1);

	lua_pushstring(L, Guild2.c_str());
	lua_pushnumber(L, GuildPoints2);

	int nStatus = lua_pcall(L, 4, 0, 0);

	this->ProcessErrorLog(L, "GuildWarProc", nStatus);

	if ((int)(timeGetTime() - m_DelayLua) >= 20) {
		gLog.Output(LOG_LUA_EVENT, "[GuildWarProc] delay %d milliseconds", (timeGetTime() - m_DelayLua));
	}

	//lua_gc(L, LUA_GCCOLLECT, 0);
#endif
}

int CLuaGameServer::PlayerSellItem(int aIndex, int Position)
{
	if (this->m_Reloading)
	{
		return 0;
	}

#ifndef OLD_LUA
	CLocker lock(gSocketManager.m_critical);

	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		this->ProcessErrorLog("PlayerSellItem", "Error find State: " + GetCurrentThreadId());
		return 0;
	}

	if (!Ogoc->Loaded) {
		return 0;
	}

	sol::stack_guard luasg(Ogoc->lua);

	sol::protected_function playerSellItem(Ogoc->lua["PlayerSellItem"]);
	sol::protected_function_result result = playerSellItem(aIndex, Position);

	if (!result.valid()) {
		sol::error err = result;
		this->ProcessErrorLog("PlayerSellItem", err.what());
		return 0;
	}
	else {
		return static_cast<int>(result);
	}
#else
	CLocker lock(gSocketManager.m_critical);

	auto L = OgocXManager.getOgoc();

	if (L == nullptr) {
		return 0;
	}

	DWORD m_DelayLua = timeGetTime();

	lua_getglobal(L, "PlayerSellItem");

	lua_pushnumber(L, aIndex);
	lua_pushnumber(L, Position);

	int nStatus = lua_pcall(L, 2, 1, 0);

	this->ProcessErrorLog(L, "PlayerSellItem", nStatus);

	int result = (int)lua_tointeger(L, -1);

	lua_pop(L, 1);

	if ((int)(timeGetTime() - m_DelayLua) >= 20) {
		gLog.Output(LOG_LUA_EVENT, "[PlayerSellItem] delay %d milliseconds", (timeGetTime() - m_DelayLua));
	}

	//lua_gc(L, LUA_GCCOLLECT, 0);

	return result;
#endif
}

int CLuaGameServer::CharacterMove(int aIndex, int map, int x, int y)
{
	if (this->m_Reloading)
	{
		return 0;
	}

#ifndef OLD_LUA
	CLocker lock(gSocketManager.m_critical);

	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		this->ProcessErrorLog("CharacterMove", "Error find State: " + GetCurrentThreadId());
		return 0;
	}

	if (!Ogoc->Loaded) {
		return 0;
	}

	sol::stack_guard luasg(Ogoc->lua);

	sol::protected_function characterMove(Ogoc->lua["CharacterMove"]);
	sol::protected_function_result result = characterMove(aIndex, map, x, y);

	if (!result.valid()) {
		sol::error err = result;
		this->ProcessErrorLog("CharacterMove", err.what());
		return 0;
	}
	else {
		return static_cast<int>(result);
	}
#else
	CLocker lock(gSocketManager.m_critical);

	auto L = OgocXManager.getOgoc();

	if (L == nullptr) {
		return 0;
	}

	DWORD m_DelayLua = timeGetTime();

	lua_getglobal(L, "CharacterMove");

	lua_pushnumber(L, aIndex);
	lua_pushnumber(L, map);
	lua_pushnumber(L, x);
	lua_pushnumber(L, y);

	int nStatus = lua_pcall(L, 4, 1, 0);

	this->ProcessErrorLog(L, "CharacterMove", nStatus);

	int result = (int)lua_tointeger(L, -1);

	lua_pop(L, 1);

	if ((int)(timeGetTime() - m_DelayLua) >= 20) {
		gLog.Output(LOG_LUA_EVENT, "[PlayerSellItem] delay %d milliseconds", (timeGetTime() - m_DelayLua));
	}

	//lua_gc(L, LUA_GCCOLLECT, 0);

	return result;
#endif
}

int CLuaGameServer::PlayerRingEquiped(int aIndex)
{
	if (this->m_Reloading)
	{
		return 0;
	}

#ifndef OLD_LUA
	CLocker lock(gSocketManager.m_critical);

	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		this->ProcessErrorLog("PlayerRingEquiped", "Error find State: " + GetCurrentThreadId());
		return 0;
	}

	if (!Ogoc->Loaded) {
		return 0;
	}

	sol::stack_guard luasg(Ogoc->lua);

	sol::protected_function playerRingEquiped(Ogoc->lua["PlayerRingEquiped"]);
	sol::protected_function_result result = playerRingEquiped(aIndex);

	if (!result.valid()) {
		sol::error err = result;
		this->ProcessErrorLog("PlayerRingEquiped", err.what());
		return 0;
	}
	else {
		return static_cast<int>(result);
	}
#else
	CLocker lock(gSocketManager.m_critical);

	auto L = OgocXManager.getOgoc();

	if (L == nullptr) {
		return 0;
	}

	DWORD m_DelayLua = timeGetTime();

	lua_getglobal(L, "PlayerRingEquiped");

	lua_pushnumber(L, aIndex);

	int nStatus = lua_pcall(L, 1, 1, 0);

	this->ProcessErrorLog(L, "PlayerRingEquiped", nStatus);

	int result = (int)lua_tointeger(L, -1);

	lua_pop(L, 1);

	if ((int)(timeGetTime() - m_DelayLua) >= 20) {
		gLog.Output(LOG_LUA_EVENT, "[PlayerRingEquiped] delay %d milliseconds", (timeGetTime() - m_DelayLua));
	}

	//lua_gc(L, LUA_GCCOLLECT, 0);

	return result;
#endif
}

int CLuaGameServer::PlayerRepairItem(int aIndex, int Position)
{
	if (this->m_Reloading)
	{
		return 0;
	}

#ifndef OLD_LUA
	CLocker lock(gSocketManager.m_critical);

	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		this->ProcessErrorLog("PlayerRepairItem", "Error find State: " + GetCurrentThreadId());
		return 0;
	}

	if (!Ogoc->Loaded) {
		return 0;
	}

	sol::stack_guard luasg(Ogoc->lua);

	sol::protected_function playerRepairItem(Ogoc->lua["PlayerRepairItem"]);
	sol::protected_function_result result = playerRepairItem(aIndex, Position);

	if (!result.valid()) {
		sol::error err = result;
		this->ProcessErrorLog("PlayerRepairItem", err.what());
		return 0;
	}
	else {
		return static_cast<int>(result);
	}
#else
	CLocker lock(gSocketManager.m_critical);

	auto L = OgocXManager.getOgoc();

	if (L == nullptr) {
		return 0;
	}

	DWORD m_DelayLua = timeGetTime();

	lua_getglobal(L, "PlayerRepairItem");

	lua_pushnumber(L, aIndex);
	lua_pushnumber(L, Position);

	int nStatus = lua_pcall(L, 2, 1, 0);

	this->ProcessErrorLog(L, "PlayerRepairItem", nStatus);

	int result = (int)lua_tointeger(L, -1);

	lua_pop(L, 1);

	if ((int)(timeGetTime() - m_DelayLua) >= 20) {
		gLog.Output(LOG_LUA_EVENT, "[PlayerRepairItem] delay %d milliseconds", (timeGetTime() - m_DelayLua));
	}

	//lua_gc(L, LUA_GCCOLLECT, 0);

	return result;
#endif
}

int CLuaGameServer::ChatProc(int index, std::string text)
{
	if (this->m_Reloading)
	{
		return 0;
	}

#ifndef OLD_LUA
	CLocker lock(gSocketManager.m_critical);

	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		this->ProcessErrorLog("ChatProc", "Error find State: " + GetCurrentThreadId());
		return 0;
	}

	if (!Ogoc->Loaded) {
		return 0;
	}

	sol::stack_guard luasg(Ogoc->lua);

	sol::protected_function playerRepairItem(Ogoc->lua["ChatProc"]);
	sol::protected_function_result result = playerRepairItem(index, text);

	if (!result.valid()) {
		sol::error err = result;
		this->ProcessErrorLog("ChatProc", err.what());
		return 0;
	}
	else {
		return static_cast<int>(result);
	}
#else
	CLocker lock(gSocketManager.m_critical);

	auto L = OgocXManager.getOgoc();

	if (L == nullptr) {
		return 0;
	}

	DWORD m_DelayLua = timeGetTime();

	lua_getglobal(L, "ChatProc");

	lua_pushnumber(L, index);
	lua_pushstring(L, text.c_str());

	int nStatus = lua_pcall(L, 2, 1, 0);

	this->ProcessErrorLog(L, "ChatProc", nStatus);

	int result = (int)lua_tointeger(L, -1);

	lua_pop(L, 1);

	if ((int)(timeGetTime() - m_DelayLua) >= 20) {
		gLog.Output(LOG_LUA_EVENT, "[ChatProc] delay %d milliseconds", (timeGetTime() - m_DelayLua));
	}

	//lua_gc(L, LUA_GCCOLLECT, 0);
	//lua_gc(L, LUA_GCCOLLECT, 0);

	return result;
#endif
}

void CLuaGameServer::RespawnUser(int aIndex)
{
	if (this->m_Reloading)
	{
		return;
	}

#ifndef OLD_LUA
	CLocker lock(gSocketManager.m_critical);

	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		this->ProcessErrorLog("RespawnUser", "Error find State: " + GetCurrentThreadId());
		return;
	}

	if (!Ogoc->Loaded) {
		return;
	}

	sol::stack_guard luasg(Ogoc->lua);

	sol::protected_function respawnUser(Ogoc->lua["RespawnUser"]);
	sol::protected_function_result result = respawnUser(aIndex);

	if (!result.valid()) {
		sol::error err = result;
		this->ProcessErrorLog("RespawnUser", err.what());
	}
#else
	CLocker lock(gSocketManager.m_critical);

	auto L = OgocXManager.getOgoc();

	if (L == nullptr) {
		return;
	}

	DWORD m_DelayLua = timeGetTime();

	lua_getglobal(L, "RespawnUser");

	lua_pushnumber(L, aIndex);

	int nStatus = lua_pcall(L, 1, 0, 0);

	this->ProcessErrorLog(L, "RespawnUser", nStatus);

	if ((int)(timeGetTime() - m_DelayLua) >= 20) {
		gLog.Output(LOG_LUA_EVENT, "[RespawnUser] delay %d milliseconds", (timeGetTime() - m_DelayLua));
	}

	//lua_gc(L, LUA_GCCOLLECT, 0);
#endif
}

int CLuaGameServer::DeleteCharacter(int aIndex, std::string name)
{
	if (this->m_Reloading)
	{
		return 0;
	}

#ifndef OLD_LUA
	CLocker lock(gSocketManager.m_critical);

	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		this->ProcessErrorLog("DeleteCharacter", "Error find State: " + GetCurrentThreadId());
		return 0;
	}

	if (!Ogoc->Loaded) {
		return 0;
	}

	sol::stack_guard luasg(Ogoc->lua);

	sol::protected_function deleteCharacter(Ogoc->lua["DeleteCharacter"]);
	sol::protected_function_result result = deleteCharacter(aIndex);

	if (!result.valid()) {
		sol::error err = result;
		this->ProcessErrorLog("DeleteCharacter", err.what());
		return 0;
	}
	else {
		return static_cast<int>(result);
	}
#else
	CLocker lock(gSocketManager.m_critical);

	auto L = OgocXManager.getOgoc();

	if (L == nullptr) {
		return 0;
	}

	DWORD m_DelayLua = timeGetTime();

	lua_getglobal(L, "DeleteCharacter");

	lua_pushnumber(L, aIndex);
	lua_pushstring(L, name.c_str());

	int nStatus = lua_pcall(L, 2, 1, 0);

	this->ProcessErrorLog(L, "DeleteCharacter", nStatus);

	int result = (int)lua_tointeger(L, -1);

	lua_pop(L, 1);

	if ((int)(timeGetTime() - m_DelayLua) >= 20) {
		gLog.Output(LOG_LUA_EVENT, "[DeleteCharacter] delay %d milliseconds", (timeGetTime() - m_DelayLua));
	}

	//lua_gc(L, LUA_GCCOLLECT, 0);

	return result;
#endif
}

void CLuaGameServer::PlayerMoveItem(int aIndex, int SlotSource, int SlotTarget, int Type)
{
	if (this->m_Reloading)
	{
		return;
	}

#ifndef OLD_LUA
	CLocker lock(gSocketManager.m_critical);

	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		this->ProcessErrorLog("PlayerMoveItem", "Error find State: " + GetCurrentThreadId());
		return;
	}

	if (!Ogoc->Loaded) {
		return;
	}

	sol::stack_guard luasg(Ogoc->lua);

	sol::protected_function playerMoveItem(Ogoc->lua["PlayerMoveItem"]);
	sol::protected_function_result result = playerMoveItem(aIndex, SlotSource, SlotTarget, Type);

	if (!result.valid()) {
		sol::error err = result;
		this->ProcessErrorLog("PlayerMoveItem", err.what());
	}
#else
	CLocker lock(gSocketManager.m_critical);

	auto L = OgocXManager.getOgoc();

	if (L == nullptr) {
		return;
	}

	DWORD m_DelayLua = timeGetTime();

	lua_getglobal(L, "PlayerMoveItem");

	lua_pushnumber(L, aIndex);
	lua_pushnumber(L, SlotSource);
	lua_pushnumber(L, SlotTarget);
	lua_pushnumber(L, Type);

	int nStatus = lua_pcall(L, 4, 0, 0);

	this->ProcessErrorLog(L, "PlayerMoveItem", nStatus);

	if ((int)(timeGetTime() - m_DelayLua) >= 20) {
		gLog.Output(LOG_LUA_EVENT, "[PlayerMoveItem] delay %d milliseconds", (timeGetTime() - m_DelayLua));
	}

	//lua_gc(L, LUA_GCCOLLECT, 0);
#endif
}

void CLuaGameServer::PlayerVaultOpen(int aIndex)
{
	if (this->m_Reloading)
	{
		return;
	}

#ifndef OLD_LUA
	CLocker lock(gSocketManager.m_critical);

	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		this->ProcessErrorLog("PlayerVaultOpen", "Error find State: " + GetCurrentThreadId());
		return;
	}

	if (!Ogoc->Loaded) {
		return;
	}

	sol::stack_guard luasg(Ogoc->lua);

	sol::protected_function playerVaultOpen(Ogoc->lua["PlayerVaultOpen"]);
	sol::protected_function_result result = playerVaultOpen(aIndex);

	if (!result.valid()) {
		sol::error err = result;
		this->ProcessErrorLog("PlayerVaultOpen", err.what());
	}
#else
	CLocker lock(gSocketManager.m_critical);

	auto L = OgocXManager.getOgoc();

	if (L == nullptr) {
		return;
	}

	DWORD m_DelayLua = timeGetTime();

	lua_getglobal(L, "PlayerVaultOpen");

	lua_pushnumber(L, aIndex);

	int nStatus = lua_pcall(L, 1, 0, 0);

	this->ProcessErrorLog(L, "PlayerVaultOpen", nStatus);

	if ((int)(timeGetTime() - m_DelayLua) >= 20) {
		gLog.Output(LOG_LUA_EVENT, "[PlayerVaultOpen] delay %d milliseconds", (timeGetTime() - m_DelayLua));
	}

	//lua_gc(L, LUA_GCCOLLECT, 0);
#endif
}

void CLuaGameServer::PlayerVaultClose(int aIndex)
{
	if (this->m_Reloading)
	{
		return;
	}

#ifndef OLD_LUA
	CLocker lock(gSocketManager.m_critical);

	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		this->ProcessErrorLog("PlayerVaultClose", "Error find State: " + GetCurrentThreadId());
		return;
	}

	if (!Ogoc->Loaded) {
		return;
	}

	sol::stack_guard luasg(Ogoc->lua);

	sol::protected_function playerVaultClose(Ogoc->lua["PlayerVaultClose"]);
	sol::protected_function_result result = playerVaultClose(aIndex);

	if (!result.valid()) {
		sol::error err = result;
		this->ProcessErrorLog("PlayerVaultClose", err.what());
	}
#else
	CLocker lock(gSocketManager.m_critical);

	auto L = OgocXManager.getOgoc();

	if (L == nullptr) {
		return;
	}

	DWORD m_DelayLua = timeGetTime();

	lua_getglobal(L, "PlayerVaultClose");

	lua_pushnumber(L, aIndex);

	int nStatus = lua_pcall(L, 1, 0, 0);

	this->ProcessErrorLog(L, "PlayerVaultClose", nStatus);

	if ((int)(timeGetTime() - m_DelayLua) >= 20) {
		gLog.Output(LOG_LUA_EVENT, "[PlayerVaultClose] delay %d milliseconds", (timeGetTime() - m_DelayLua));
	}

	//lua_gc(L, LUA_GCCOLLECT, 0);
#endif
}

void CLuaGameServer::MonsterReload()
{
	if (this->m_Reloading)
	{
		return;
	}

#ifndef OLD_LUA
	CLocker lock(gSocketManager.m_critical);

	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		this->ProcessErrorLog("MonsterReload", "Error find State: " + GetCurrentThreadId());
		return;
	}

	if (!Ogoc->Loaded) {
		return;
	}

	sol::stack_guard luasg(Ogoc->lua);

	sol::protected_function monsterReload(Ogoc->lua["MonsterReload"]);
	sol::protected_function_result result = monsterReload();

	if (!result.valid()) {
		sol::error err = result;
		this->ProcessErrorLog("MonsterReload", err.what());
	}
#else
	CLocker lock(gSocketManager.m_critical);

	auto L = OgocXManager.getOgoc();

	if (L == nullptr) {
		return;
	}

	DWORD m_DelayLua = timeGetTime();

	lua_getglobal(L, "MonsterReload");

	int nStatus = lua_pcall(L, 0, 0, 0);

	this->ProcessErrorLog(L, "MonsterReload", nStatus);

	if ((int)(timeGetTime() - m_DelayLua) >= 20) {
		gLog.Output(LOG_LUA_EVENT, "[MonsterReload] delay %d milliseconds", (timeGetTime() - m_DelayLua));
	}

	//lua_gc(L, LUA_GCCOLLECT, 0);
#endif
}

void CLuaGameServer::ReloadLuaMonster()
{
	if (this->m_Reloading)
	{
		return;
	}

#ifndef OLD_LUA
	CLocker lock(gSocketManager.m_critical);

	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		this->ProcessErrorLog("ReloadLuaMonster", "Error find State: " + GetCurrentThreadId());
		return;
	}

	if (!Ogoc->Loaded) {
		return;
	}

	sol::stack_guard luasg(Ogoc->lua);

	sol::protected_function reloadLuaMonster(Ogoc->lua["ReloadLuaMonster"]);
	sol::protected_function_result result = reloadLuaMonster();

	if (!result.valid()) {
		sol::error err = result;
		this->ProcessErrorLog("ReloadLuaMonster", err.what());
	}
#else
	CLocker lock(gSocketManager.m_critical);

	auto L = OgocXManager.getOgoc();

	if (L == nullptr) {
		return;
	}

	DWORD m_DelayLua = timeGetTime();

	lua_getglobal(L, "ReloadLuaMonster");

	int nStatus = lua_pcall(L, 0, 0, 0);

	this->ProcessErrorLog(L, "ReloadLuaMonster", nStatus);

	if ((int)(timeGetTime() - m_DelayLua) >= 20) {
		gLog.Output(LOG_LUA_EVENT, "[ReloadLuaMonster] delay %d milliseconds", (timeGetTime() - m_DelayLua));
	}

	//lua_gc(L, LUA_GCCOLLECT, 0);
#endif
}

int CLuaGameServer::DeclareWar(int aIndex)
{
	if (this->m_Reloading)
	{
		return 0;
	}

#ifndef OLD_LUA
	CLocker lock(gSocketManager.m_critical);

	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		this->ProcessErrorLog("DeclareWar", "Error find State: " + GetCurrentThreadId());
		return 0;
	}

	if (!Ogoc->Loaded) {
		return 0;
	}

	sol::stack_guard luasg(Ogoc->lua);

	sol::protected_function declareWar(Ogoc->lua["DeclareWar"]);
	sol::protected_function_result result = declareWar(aIndex);

	if (!result.valid()) {
		sol::error err = result;
		this->ProcessErrorLog("DeclareWar", err.what());
		return 0;
	}
	else {
		return static_cast<int>(result);
	}
#else
	CLocker lock(gSocketManager.m_critical);

	auto L = OgocXManager.getOgoc();

	if (L == nullptr) {
		return 0;
	}

	DWORD m_DelayLua = timeGetTime();

	lua_getglobal(L, "DeclareWar");

	lua_pushnumber(L, aIndex);

	int nStatus = lua_pcall(L, 1, 1, 0);

	this->ProcessErrorLog(L, "DeclareWar", nStatus);

	int result = (int)lua_tointeger(L, -1);

	lua_pop(L, 1);

	if ((int)(timeGetTime() - m_DelayLua) >= 20) {
		gLog.Output(LOG_LUA_EVENT, "[DeclareWar] delay %d milliseconds", (timeGetTime() - m_DelayLua));
	}

	//lua_gc(L, LUA_GCCOLLECT, 0);

	return result;
#endif
}

int CLuaGameServer::PlayerUseItem(int aIndex, int SourceSlot, int TargetSlot)
{
	if (this->m_Reloading)
	{
		return 0;
	}

#ifndef OLD_LUA
	CLocker lock(gSocketManager.m_critical);

	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		this->ProcessErrorLog("PlayerUseItem", "Error find State: " + GetCurrentThreadId());
		return 0;
	}

	if (!Ogoc->Loaded) {
		return 0;
	}

	sol::stack_guard luasg(Ogoc->lua);

	sol::protected_function playerUserItem(Ogoc->lua["PlayerUseItem"]);
	sol::protected_function_result result = playerUserItem(aIndex, SourceSlot, TargetSlot);

	if (!result.valid()) {
		sol::error err = result;
		this->ProcessErrorLog("PlayerUseItem", err.what());
		return 0;
	}
	else {
		return static_cast<int>(result);
	}
#else
	CLocker lock(gSocketManager.m_critical);

	auto L = OgocXManager.getOgoc();

	if (L == nullptr) {
		return 0;
	}

	DWORD m_DelayLua = timeGetTime();

	lua_getglobal(L, "PlayerUseItem");

	lua_pushnumber(L, aIndex);
	lua_pushnumber(L, SourceSlot);
	lua_pushnumber(L, TargetSlot);

	int nStatus = lua_pcall(L, 3, 1, 0);

	this->ProcessErrorLog(L, "PlayerUseItem", nStatus);

	int result = (int)lua_tointeger(L, -1);

	lua_pop(L, 1);

	if ((int)(timeGetTime() - m_DelayLua) >= 20) {
		gLog.Output(LOG_LUA_EVENT, "[PlayerUseItem] delay %d milliseconds", (timeGetTime() - m_DelayLua));
	}

	//lua_gc(L, LUA_GCCOLLECT, 0);

	return result;
#endif
}

int CLuaGameServer::PlayerCanEquipItem(int aIndex, int TargetSlot)
{
	if (this->m_Reloading)
	{
		return 0;
	}

#ifndef OLD_LUA
	CLocker lock(gSocketManager.m_critical);

	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		this->ProcessErrorLog("PlayerCanEquipItem", "Error find State: " + GetCurrentThreadId());
		return 0;
	}

	if (!Ogoc->Loaded) {
		return 0;
	}

	sol::stack_guard luasg(Ogoc->lua);

	sol::protected_function playerCanEquipItem(Ogoc->lua["PlayerCanEquipItem"]);
	sol::protected_function_result result = playerCanEquipItem(aIndex, TargetSlot);

	if (!result.valid()) {
		sol::error err = result;
		this->ProcessErrorLog("PlayerCanEquipItem", err.what());
		return 0;
	}
	else {
		return static_cast<int>(result);
	}
#else
	CLocker lock(gSocketManager.m_critical);

	auto L = OgocXManager.getOgoc();

	if (L == nullptr) {
		return 0;
	}

	DWORD m_DelayLua = timeGetTime();

	lua_getglobal(L, "PlayerCanEquipItem");

	lua_pushnumber(L, aIndex);
	lua_pushnumber(L, TargetSlot);

	int nStatus = lua_pcall(L, 3, 1, 0);

	this->ProcessErrorLog(L, "PlayerCanEquipItem", nStatus);

	int result = (int)lua_tointeger(L, -1);

	lua_pop(L, 1);

	if ((int)(timeGetTime() - m_DelayLua) >= 20) {
		gLog.Output(LOG_LUA_EVENT, "[PlayerCanEquipItem] delay %d milliseconds", (timeGetTime() - m_DelayLua));
	}

	//lua_gc(L, LUA_GCCOLLECT, 0);

	return result;
#endif
}

void CLuaGameServer::CheckCustomChaosBox(int aIndex)
{
	if (this->m_Reloading)
	{
		return;
	}

#ifndef OLD_LUA
	CLocker lock(gSocketManager.m_critical);

	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		this->ProcessErrorLog("CheckCustomChaosBox", "Error find State: " + GetCurrentThreadId());
		return;
	}

	if (!Ogoc->Loaded) {
		return;
	}

	sol::stack_guard luasg(Ogoc->lua);

	sol::protected_function checkCustomChaosBox(Ogoc->lua["CheckCustomChaosBox"]);
	sol::protected_function_result result = checkCustomChaosBox(aIndex);

	if (!result.valid()) {
		sol::error err = result;
		this->ProcessErrorLog("CheckCustomChaosBox", err.what());
	}
#else
	CLocker lock(gSocketManager.m_critical);

	auto L = OgocXManager.getOgoc();

	if (L == nullptr) {
		return;
	}

	DWORD m_DelayLua = timeGetTime();

	lua_getglobal(L, "CheckCustomChaosBox");

	lua_pushnumber(L, aIndex);

	int nStatus = lua_pcall(L, 1, 0, 0);

	this->ProcessErrorLog(L, "CheckCustomChaosBox", nStatus);

	if ((int)(timeGetTime() - m_DelayLua) >= 20) {
		gLog.Output(LOG_LUA_EVENT, "[CheckCustomChaosBox] delay %d milliseconds", (timeGetTime() - m_DelayLua));
	}

	//lua_gc(L, LUA_GCCOLLECT, 0);
#endif
}

void CLuaGameServer::GameServerProtocol(int aIndex, BYTE head, std::string packet_name)
{
	if (this->m_Reloading)
	{
		return;
	}

#ifndef OLD_LUA
	CLocker lock(gSocketManager.m_critical);

	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		this->ProcessErrorLog("GameServerProtocol", "Error find State: " + GetCurrentThreadId());
		return;
	}

	if (!Ogoc->Loaded) {
		return;
	}

	sol::stack_guard luasg(Ogoc->lua);

	sol::protected_function gameServerProtocol(Ogoc->lua["GameServerProtocol"]);
	sol::protected_function_result result = gameServerProtocol(aIndex, head, packet_name);

	if (!result.valid()) {
		sol::error err = result;
		this->ProcessErrorLog("GameServerProtocol", err.what());
	}
#else
	CLocker lock(gSocketManager.m_critical);

	auto L = OgocXManager.getOgoc();

	if (L == nullptr) {
		return;
	}

	DWORD m_DelayLua = timeGetTime();

	lua_getglobal(L, "GameServerProtocol");

	lua_pushnumber(L, aIndex);
	lua_pushnumber(L, head);
	lua_pushstring(L, packet_name.c_str());

	int nStatus = lua_pcall(L, 3, 0, 0);

	this->ProcessErrorLog(L, "GameServerProtocol", nStatus);

	if ((int)(timeGetTime() - m_DelayLua) >= 20) {
		gLog.Output(LOG_LUA_EVENT, "[GameServerProtocol] delay %d milliseconds", (timeGetTime() - m_DelayLua));
	}

	//lua_gc(L, LUA_GCCOLLECT, 0);
#endif
}

void CLuaGameServer::ReceiveEventReward(int aIndex, int EventType)
{
	if (this->m_Reloading)
	{
		return;
	}

#ifndef OLD_LUA
	CLocker lock(gSocketManager.m_critical);

	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		this->ProcessErrorLog("ReceiveEventReward", "Error find State: " + GetCurrentThreadId());
		return;
	}

	if (!Ogoc->Loaded) {
		return;
	}

	sol::stack_guard luasg(Ogoc->lua);

	sol::protected_function receiveEventReward(Ogoc->lua["ReceiveEventReward"]);
	sol::protected_function_result result = receiveEventReward(aIndex, EventType);

	if (!result.valid()) {
		sol::error err = result;
		this->ProcessErrorLog("ReceiveEventReward", err.what());
	}
#else
	CLocker lock(gSocketManager.m_critical);

	auto L = OgocXManager.getOgoc();

	if (L == nullptr) {
		return;
	}

	DWORD m_DelayLua = timeGetTime();

	lua_getglobal(L, "ReceiveEventReward");

	lua_pushnumber(L, aIndex);
	lua_pushnumber(L, EventType);

	int nStatus = lua_pcall(L, 2, 0, 0);

	this->ProcessErrorLog(L, "ReceiveEventReward", nStatus);

	if ((int)(timeGetTime() - m_DelayLua) >= 20) {
		gLog.Output(LOG_LUA_EVENT, "[ReceiveEventReward] delay %d milliseconds", (timeGetTime() - m_DelayLua));
	}

	//lua_gc(L, LUA_GCCOLLECT, 0);
#endif
}

void CLuaGameServer::AutoResetPlayerProc(int aIndex)
{
#ifndef OLD_LUA
	CLocker lock(gSocketManager.m_critical);

	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		this->ProcessErrorLog("AutoResetPlayerProc", "Error find State: " + GetCurrentThreadId());
		return;
	}

	if (!Ogoc->Loaded) {
		return;
	}

	sol::stack_guard luasg(Ogoc->lua);

	sol::protected_function autoResetPlayerProc(Ogoc->lua["AutoResetPlayerProc"]);
	sol::protected_function_result result = autoResetPlayerProc(aIndex);

	if (!result.valid()) {
		sol::error err = result;
		this->ProcessErrorLog("AutoResetPlayerProc", err.what());
	}
#else
	CLocker lock(gSocketManager.m_critical);

	auto L = OgocXManager.getOgoc();

	if (L == nullptr) {
		return;
	}

	DWORD m_DelayLua = timeGetTime();

	lua_getglobal(L, "AutoResetPlayerProc");

	lua_pushnumber(L, aIndex);

	int nStatus = lua_pcall(L, 1, 0, 0);

	this->ProcessErrorLog(L, "AutoResetPlayerProc", nStatus);

	if ((int)(timeGetTime() - m_DelayLua) >= 20) {
		gLog.Output(LOG_LUA_EVENT, "[AutoResetPlayerProc] delay %d milliseconds", (timeGetTime() - m_DelayLua));
	}
#endif
}

void CLuaGameServer::QueryAsyncProcess(std::string name, std::string param, int aIndex)
{
#ifndef OLD_LUA
	CLocker lock(gSocketManager.m_critical);

	auto Ogoc = OgocXManager.getOgoc();

	if (Ogoc == nullptr) {
		this->ProcessErrorLog("QueryAsyncProcess", "Error find State: " + GetCurrentThreadId());
		return;
	}

	if (!Ogoc->Loaded) {
		return;
	}

	sol::stack_guard luasg(Ogoc->lua);

	sol::protected_function queryAsyncProcess(Ogoc->lua["QueryAsyncProcess"]);
	sol::protected_function_result result = queryAsyncProcess(name, param, aIndex);

	if (!result.valid()) {
		sol::error err = result;
		this->ProcessErrorLog("QueryAsyncProcess", err.what());

		std::map<std::string, QueryJobsResult>::iterator job = gQueryAsync.m_jobsResult.find(param);

		if (job != gQueryAsync.m_jobsResult.end()) {
			gQueryAsync.m_jobsResult.erase(job);
		}
	}

#else
	CLocker lock(gSocketManager.m_critical);

	auto L = OgocXManager.getOgoc();

	if (L == nullptr) {
		return;
	}

	DWORD m_DelayLua = timeGetTime();

	lua_getglobal(L, "QueryAsyncProcess");

	lua_pushstring(L, name.c_str());
	lua_pushstring(L, param.c_str());
	lua_pushinteger(L, aIndex);

	int nStatus = lua_pcall(L, 3, 0, 0);

	if (nStatus != 0) {
		std::map<std::string, QueryJobsResult>::iterator job = gQueryAsync.m_jobsResult.find(param);

		if (job != gQueryAsync.m_jobsResult.end()) {
			gQueryAsync.m_jobsResult.erase(job);
		}
	}

	this->ProcessErrorLog(L, "QueryAsyncProcess", nStatus);

	if ((int)(timeGetTime() - m_DelayLua) >= 20) {
		gLog.Output(LOG_LUA_EVENT, "[QueryAsyncProcess-2][%s] delay %d milliseconds", name.c_str(), (timeGetTime() - m_DelayLua));
	}

	//lua_gc(L, LUA_GCCOLLECT, 0);
#endif
}

#ifdef OLD_LUA
void CLuaGameServer::ProcessErrorLog(lua_State * L, std::string func, int nStatus)
{
	if (nStatus != 0)
	{
		std::string szError = luaL_checklstring(L, -1, 0);
		szError = "[" + func + "] error: " + szError;
		LogAddLua(LOG_RED, (char*)szError.c_str());
		lua_pop(L, 1);
	}
}
#endif

void CLuaGameServer::ProcessErrorLog(std::string func, std::string error)
{
	if (error.empty()) {
		return;
	}

	std::string szError = "[" + func + "] error: ";
	szError = szError + error;
	LogAddLua(LOG_RED, (char*)szError.c_str());
}