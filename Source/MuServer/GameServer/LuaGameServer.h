#ifndef LUAGAMESERVER_H
#define LUAGAMESERVER_H

#pragma once

#define PATH_GAMESERVER_LUA "Scripts\\GameServer.lua"

#include "OgocX.h"
#include "CriticalSection.h"
#include "Util.h"
#include <functional>

class CLuaGameServer
{
public:
	CLuaGameServer();
	virtual ~CLuaGameServer();

public:
	void Init();
	void InitReload();
	void Reload();

public:
	void GameServer();
	void TimerSystem();
	int PlayerAttack(int aIndex, int TargetIndex, int IsSlap);
	int LevelUpPointAdd(int aIndex, int Type);
	void PlayerMove(int aIndex, int Map, int ax, int ay, int sx, int sy);
	void CharacterSet(int aIndex);
	void EnterCharacter(int aIndex);
	void PlayerDie(int aIndex, int TargetIndex);
	void PlayerLogout(int aIndex, std::string name, std::string account);
	int PlayerDropItem(int aIndex, int px, int py, int pos);
	int NpcTalk(int Npc, int Player);
	void MonsterDie(int aIndex, int TargetIndex);
	int MonsterDieGiveItem(int aIndex, int TargetIndex);
	int PlayerSendTrade(int aIndex, int TargetIndex);
	int PlayerSendParty(int aIndex, int TargetIndex);
	int PlayerTradeOk(int aIndex, int TargetIndex);
	int PlayerTradeXOk(int aIndex, int TargetIndex);
	int PlayerSendTradeX(int aIndex, int TargetIndex);
	void GuildWarProc(std::string Guild1, int GuildPoints1, std::string Guild2, int GuildPoints2);
	int PlayerSellItem(int aIndex, int Position);
	int CharacterMove(int aIndex, int map, int x, int y);
	int PlayerRingEquiped(int aIndex);
	int PlayerRepairItem(int aIndex, int Position);
	int ChatProc(int index, std::string text);
	void RespawnUser(int aIndex);
	int DeleteCharacter(int aIndex, std::string name);
	void PlayerMoveItem(int aIndex, int SlotSource, int SlotTarget, int Type);
	void PlayerVaultOpen(int aIndex);
	void PlayerVaultClose(int aIndex);
	void MonsterReload();
	void ReloadLuaMonster();
	int DeclareWar(int aIndex);
	int PlayerUseItem(int aIndex, int SourceSlot, int TargetSlot);

	int PlayerCanEquipItem(int aIndex, int Slot);

	void CheckCustomChaosBox(int aIndex);
	void GameServerProtocol(int aIndex, BYTE head, std::string packet_name);

	void ReceiveEventReward(int aIndex, int EventType);

	void AutoResetPlayerProc(int aIndex);
	void QueryAsyncProcess(std::string name, std::string param, int aIndex);

#ifdef OLD_LUA
	void ProcessErrorLog(lua_State * lua, std::string func, int nStatus);
#endif
	void ProcessErrorLog(std::string func, std::string error);


public:
	char m_IpAddress[17];
	char m_ServerName[30];

	bool m_Reloading;

private:
	CCriticalSection m_critical;
};

extern CLuaGameServer gLuaGameServer;

#endif