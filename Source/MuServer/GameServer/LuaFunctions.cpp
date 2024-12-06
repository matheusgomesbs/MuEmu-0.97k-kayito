#include "StdAfx.h"
#include "LuaFunctions.h"
#include "LuaStack.hpp"
#include "NpcTalk.h"
#include "ServerInfo.h"
#include "BloodCastle.h"
#include "DevilSquare.h"
#include "ItemStack.h"
#include "Message.h"
#include "CommandManager.h"
#include "ScheduleManager.h"
#include "ItemBagManager.h"
#include "timeapi.h"

void FuncLogAdd(std::string str) {
	LogAdd(LOG_BLACK, (char*)str.c_str());
}

void LogAddC(int type, std::string str) {
	if (type == 1) {
		LogAdd(LOG_BLACK, (char*)str.c_str());
	}
	else if (type == 2) {
		LogAddLua(LOG_RED, (char*)str.c_str());
	}
	else if (type == 3) {
		LogAdd(LOG_GREEN, (char*)str.c_str());
	}
	else if (type == 4) {
		LogAdd(LOG_BLUE, (char*)str.c_str());
	}
}

void LogAddTD(std::string str) {
	LogAdd(LOG_BLACK, (char*)str.c_str());
}

void SendMessageUser(std::string str, int aIndex, int type) {
	gNotice.GCNoticeSend2(aIndex, type, 0, 0, 0, 0, 0, (char*)str.c_str());
}

void SendMessageGlobal(std::string str, int type) {
	if (type == 2)
	{
		ChatYellowMessageAll((char*)str.c_str());
	}
	else if (type == 3)
	{
		ChatBlueMessageAll((char*)str.c_str());
	}
	else if (type == 4)
	{
		ChatGreenMessageAll((char*)str.c_str());
	}
	else
	{
		gNotice.GCNoticeSendToAll2(type, 0, 0, 0, 0, 0, (char*)str.c_str());
	}
}

void SendMessageAllServer(std::string str, int type) {
	GJServerMessageInfoSend((char*)str.c_str(), type);
}

void MoneySend(int aIndex) {
	GCMoneySend(aIndex, gObj[aIndex].Money);
}

void LevelUpSend(int aIndex) {
	GCLevelUpSend(&gObj[aIndex]);
	GCNewCharacterInfoSend(&gObj[aIndex]);
}

void PkLevelSend(int aIndex, int Level) {
	GCPKLevelSend(aIndex, Level);
}

int GetIndex(std::string str) {
	return gObjFindIndex((char*)str.c_str());
}

void Teleport(int aIndex, int map, int x, int y) {
	gObjTeleport(aIndex, map, x, y);
}

void TeleportMap(int aIndex, int range) {
	gMap[gObj[aIndex].Map].GetMapRandomPos(&gObj[aIndex].X, &gObj[aIndex].Y, range);
}

void TeleportMapRange(int aIndex, int map, int x, int y, int range) {
	if (MAP_RANGE(map) == 0) {
		return;
	}

	short GetX = x;
	short GetY = y;
	gMap[map].GetMapRandomPos(&GetX, &GetY, range);
	gObjTeleport(aIndex, map, GetX, GetY);
}

void CloseChar(int aIndex, int type) {
	gObjectManager.CharacterGameCloseSet(aIndex, type);
}

void SkillSend(int aIndex, int skill, int TargetIndex, int type) {
	gSkillManager.GCSkillAttackSend(&gObj[aIndex], skill, TargetIndex, type);
}

void ViewportCreate(int aIndex) {
	gObjViewportListProtocolCreate(&gObj[aIndex]);
}

void ViewportDestroy(int aIndex) {
	gObjViewportListProtocolDestroy(&gObj[aIndex]);
}

DWORD GetTick() {
	DWORD time = timeGetTime();
	return time;
}

int GetTickGS() {
	int time = timeGetTime();
	return time;
}

void TrocarBauPlayer(int aIndex, int vaultNumber) {
	LPOBJ lpObj = &gObj[aIndex];

	gCommandManager.CommandWare(lpObj, (char*)vaultNumber);
}

int AddMonster(int map) {
	return gObjAddMonster(map);
}

void SetPositionMonsterLua(int aIndex, int map) {
	gObjSetPosMonster(aIndex, map);
}

void SetMonster(int aIndex, int MonsterClass) {
	gObjSetMonster(aIndex, MonsterClass);
}

void gObjDelLua(int aIndex) {
	gObjDel(aIndex);
}

int MonsterTopHitDamageUser(int aIndex) {
	return gObjMonsterGetTopHitDamageUser(&gObj[aIndex]);
}

void ItemSerialCreate(int aIndex, int map, int x, int y, int ItemIndex, int Level, int dur, int op1, int op2, int op3, int exc) {
	if (!OBJECT_RANGE(aIndex)) {
		return;
	}

	int checkItemIndex = SafeGetItem(ItemIndex);

	if (checkItemIndex == -1) {
		return;
	}

	if (map == 236) {
		map = 235;
	}

	GDCreateItemSend(aIndex, map, (BYTE)x, (BYTE)y, ItemIndex, (BYTE)Level, (BYTE)dur, (BYTE)op1, (BYTE)op2, (BYTE)op3, -1, (BYTE)exc);
}

void ItemSerialCreateComplete(int aIndex, int map, int x, int y, int ItemIndex, int level, int dur, int op1, int op2, int op3, int ownerIndex, int exc, int ValueAncient) {
	if (!OBJECT_RANGE(aIndex)) {
		return;
	}

	int checkItemIndex = SafeGetItem(ItemIndex);

	if (checkItemIndex == -1) {
		return;
	}

	if (map == 236)
	{
		map = 235;
	}

	BYTE ItemExceOption = 0;

	gItemOptionRate.GetItemExceOption(exc, &ItemExceOption);

	gItemOptionRate.MakeExceOption(ItemIndex, ItemExceOption, &ItemExceOption);

	GDCreateItemSend(aIndex, map, (BYTE)x, (BYTE)y, ItemIndex, level, (BYTE)dur, op1, op2, op3, ownerIndex, ItemExceOption);
}

void CreateItemInventory(int aIndex, int ItemIndex, int level, int op1, int op2, int op3, int exc) {
	if (!OBJECT_RANGE(aIndex)) {
		return;
	}

	int checkItemIndex = SafeGetItem(ItemIndex);

	if (checkItemIndex == -1) {
		return;
	}

	BYTE ItemExceOption = 0;

	gItemOptionRate.GetItemExceOption(exc, &ItemExceOption);
	gItemOptionRate.MakeExceOption(ItemIndex, ItemExceOption, &ItemExceOption);

	GDCreateItemSend(aIndex, 235, (BYTE)0, (BYTE)0, ItemIndex, level, (BYTE)0, op1, op2, op3, aIndex, ItemExceOption);
}

void CreateItemMap(int aIndex, int Map, int X, int Y, int ItemIndex, int level, int op1, int op2, int op3, int exc) {
	if (!OBJECT_RANGE(aIndex)) {
		return;
	}

	int checkItemIndex = SafeGetItem(ItemIndex);

	if (checkItemIndex == -1) {
		return;
	}

	BYTE ItemExceOption = 0;

	gItemOptionRate.GetItemExceOption(exc, &ItemExceOption);
	gItemOptionRate.MakeExceOption(ItemIndex, ItemExceOption, &ItemExceOption);

	GDCreateItemSend(aIndex, Map, (BYTE)X, (BYTE)Y, ItemIndex, level, (BYTE)0, op1, op2, op3, aIndex, ItemExceOption);
}

void InventoryDeleteItem(int aIndex, int slot) {
	if (!OBJECT_RANGE(aIndex)) {
		return;
	}

	gItemManager.InventoryDelItem(aIndex, slot);
}

void CreateInventoryItem(int aIndex, int ItemIndex, int level, int dur, int op1, int op2, int op3, int exc) {
	if (!OBJECT_RANGE(aIndex)) {
		return;
	}

	int checkItemIndex = SafeGetItem(ItemIndex);

	if (checkItemIndex == -1) {
		return;
	}

	GDCreateItemSend(aIndex, 250, 0, 0, ItemIndex, level, (BYTE)dur, op1, op2, op3, -1, exc);
}

void SendInventoryDeleteItem(int aIndex, int slot) {
	if (!OBJECT_RANGE(aIndex)) {
		return;
	}

	gItemManager.GCItemDeleteSend(aIndex, slot, 1);
}

void ItemListSend(int aIndex) {
	if (!OBJECT_RANGE(aIndex)) {
		return;
	}

	gItemManager.GCItemListSend(aIndex);
}

void GetWarehouseList(int aIndex, std::string string) {
	if (!OBJECT_RANGE(aIndex)) {
		return;
	}

	gWarehouse.GDWarehouseItemSend(aIndex, (char*)string.c_str());
}

void ChatTargetSend(int aIndex, std::string string, int monster) {
	if (!OBJECT_RANGE(aIndex)) {
		return;
	}

	GCChatTargetSend(&gObj[monster], aIndex, (char*)string.c_str());
}

void SetMapMonster(int aIndex, int map, int x, int y) {
	if (!OBJECT_RANGE(aIndex)) {
		return;
	}

	gObjSetPosMonster(aIndex, map);
}

void CalCharacter(int aIndex) {
	if (!OBJECT_RANGE(aIndex)) {
		return;
	}

	gObjectManager.CharacterCalcAttribute(aIndex);
}

void LifeUpdate(int aIndex) {
	if (!OBJECT_RANGE(aIndex)) {
		return;
	}

	GCLifeSend(aIndex, 0xFE, (int)(gObj[aIndex].MaxLife + gObj[aIndex].AddLife));
}

void ManaUpdate(int aIndex) {
	if (!OBJECT_RANGE(aIndex)) {
		return;
	}

	GCManaSend(aIndex, 0xFE, (int)(gObj[aIndex].MaxMana + gObj[aIndex].AddMana), (gObj[aIndex].MaxBP + gObj[aIndex].AddBP));
}

void NextExpCalc(int aIndex) {
	if (!OBJECT_RANGE(aIndex)) {
		return;
	}

	gObjCalcExperience(&gObj[aIndex]);
}

void SetBP(int aIndex) {
	if (!OBJECT_RANGE(aIndex)) {
		return;
	}

	gObjectManager.CharacterCalcBP(&gObj[aIndex]);
}

void MakePreview(int aIndex) {
	if (!OBJECT_RANGE(aIndex)) {
		return;
	}

	gObjectManager.CharacterMakePreviewCharSet(aIndex);
}

void SendQuestPrize(int aIndex, int reward, int amount) {
	gQuest.GCQuestRewardSend(aIndex, reward, amount);
}

void LuaResetSkills(int aIndex) {
	if (!OBJECT_RANGE(aIndex)) {
		return;
	}

	ResetSkills(&gObj[aIndex]);
}

void ClearViewPort(int aIndex) {
	if (!OBJECT_RANGE(aIndex)) {
		return;
	}

	gObjClearViewport(&gObj[aIndex]);
}

void SendPacketMain(int aIndex, unsigned char* packet, int size) {
	if (!OBJECT_RANGE(aIndex)) {
		return;
	}

	DataSend(aIndex, packet, size);
}

void StateInfoSend(int aIndex, int state, int effect) {
	if (!OBJECT_RANGE(aIndex)) {
		return;
	}

	gEffectManager.GCEffectStateSend(&gObj[aIndex], (BYTE)state, (BYTE)effect);
}

int LevelExperience(int Level) {
	return gLevelExperience[Level - 1];
}

void RefreshCharacter(int aIndex) {
	if (!OBJECT_RANGE(aIndex)) {
		return;
	}

	GCNewCharacterInfoSend(&gObj[aIndex]);
}

void FireWorks(int aIndex, int map, int x, int y) {
	if (aIndex == -1)
	{
		GCFireworksSendCustom(map, x, y);
	}
	else
	{
		GCFireworksSend(&gObj[aIndex], gObj[aIndex].X, gObj[aIndex].Y);
	}
}

int GetMapAttr(int map, int x, int y, int attr) {
	if (MAP_RANGE(map) == 0) {
		return 0;
	}

	return (gMap[map].GetAttr(x, y) & attr);
}

void LuagObjAdd(DWORD ssocket, std::string ipAddr, int aIndex) {
	SOCKET socket;

	if (ssocket == 0)
	{
		socket = INVALID_SOCKET;
	}
	else
	{
		socket = ssocket;
	}

	gObjAdd(socket, (char*)ipAddr.c_str(), aIndex);
}

void CharacterInfoSend(int aIndex, std::string name) {
	if (!OBJECT_RANGE(aIndex)) {
		return;
	}

	GDCharacterInfoSend(aIndex, (char*)name.c_str());
}

void LuagObjSetPosition(int aIndex, int x, int y) {
	if (!OBJECT_RANGE(aIndex)) {
		return;
	}

	gObjSetPosition(aIndex, x, y);
}

void AccountInfoSend(int aIndex, std::string account, std::string pass) {
	if (!OBJECT_RANGE(aIndex)) {
		return;
	}

	GJConnectAccountSend(aIndex, (char*)account.c_str(), (char*)pass.c_str(), "127.0.0.1");
}

void LuaMoveObject(int aIndex) {
	if (!OBJECT_RANGE(aIndex)) {
		return;
	}

	MoveObject(aIndex);
}

int SearchIndex(DWORD ssocket, std::string ipaddr) {
	SOCKET socket;

	if (ssocket == 0)
	{
		socket = INVALID_SOCKET;
	}
	else
	{
		socket = ssocket;
	}

	return gObjAddSearch(socket, (char*)ipaddr.c_str());
}

std::string GetServerName() {
	return "MattZeras";
}

int CheckQuestListState(int Value1, int Value2, int Value3) {
	if (!OBJECT_RANGE(Value1)) {
		return 0;
	}

	return gQuest.CheckQuestListState(&gObj[Value1], Value2, Value3);
}

void AddQuestList(int Value1, int Value2, int Value3) {
	if (!OBJECT_RANGE(Value1)) {
		return;
	}

	gQuest.AddQuestList(&gObj[Value1], Value2, Value3);
}

void InsertQuestReward(int Value1, int Value2) {
	if (!OBJECT_RANGE(Value1)) {
		return;
	}

	gQuestReward.InsertQuestReward(&gObj[Value1], Value2);
}

void LuaGCQuestInfoSend(int Value1) {
	if (!OBJECT_RANGE(Value1)) {
		return;
	}

	gQuest.GCQuestInfoSend(Value1);
}

void ChaosMixSend(int aIndex, int result) {
	if (!OBJECT_RANGE(aIndex)) {
		return;
	}

	gChaosBox.GCChaosMixSend(aIndex, (BYTE)result, 0);
}

void ChaosBoxInit(int aIndex) {
	if (!OBJECT_RANGE(aIndex)) {
		return;
	}

	gChaosBox.ChaosBoxInit(&gObj[aIndex]);
}

void ChaosBoxSend(int aIndex, int type) {
	if (!OBJECT_RANGE(aIndex)) {
		return;
	}

	gChaosBox.GCChaosBoxSend(&gObj[aIndex]);
}

void ClearAllBuff(int aIndex) {
	if (!OBJECT_RANGE(aIndex)) {
		return;
	}

	gEffectManager.ClearAllEffect(&gObj[aIndex]);
}

int CheckBuffPlayer(int aIndex, int effect) {
	if (!OBJECT_RANGE(aIndex)) {
		return 0;
	}

	return gEffectManager.CheckEffect(&gObj[aIndex], effect);
}

int InventoryCheckSpaceByItem(int aIndex, int ItemIndex) {
	if (!OBJECT_RANGE(aIndex)) {
		return 0;
	}

	return gItemManager.CheckItemInventorySpace(&gObj[aIndex], ItemIndex);
}

int InventoryCheckSpaceBySize(int aIndex, int width, int height) {
	if (!OBJECT_RANGE(aIndex)) {
		return 0;
	}

	return gItemManager.CheckItemInventorySpace(&gObj[aIndex], width, height);
}

void ResetQuest(int aIndex) {
	if (!OBJECT_RANGE(aIndex)) {
		return;
	}

	memset(gObj[aIndex].Quest, 0xFF, sizeof(gObj[aIndex].Quest));
}

int gObjIsConnectedGPLua(int aIndex) {
	return gObjIsConnectedGP(aIndex);
}

void SendMessagePlayer(int aIndex, int Type, std::string msg) {
	if (OBJECT_USER_RANGE(aIndex) == 0) {
		return;
	}

	if (Type == 2) {
		ChatYellowMessage(aIndex, (char*)msg.c_str());
	}
	else if (Type == 3) {
		ChatBlueMessage(aIndex, (char*)msg.c_str());
	}
	else if (Type == 4) {
		ChatGreenMessage(aIndex, (char*)msg.c_str());
	}
	else {
		gNotice.GCNoticeSend(aIndex, Type, 0, 0, 0, 0, 0, (char*)msg.c_str());
	}
}

void ReloadChaosMix() {
	gServerInfo.ReadChaosMixInfo();
}

void ReloadCharacter() {
	gServerInfo.ReadCharacterInfo();
}

void ReloadCommon() {
	gServerInfo.ReadCommonInfo();
}

void ReloadCustom() {
	gServerInfo.ReadCustomInfo();
}

void ReloadEvent() {
	gServerInfo.ReadEventInfo();
}

void ReloadEventItemBag() {
	gServerInfo.ReadEventItemBagInfo();
}

void ReloadHack() {
	gServerInfo.ReadHackInfo();
}

void ReloadItem() {
	gServerInfo.ReadItemInfo();
}

void ReloadMonster() {
	gServerInfo.ReloadMonsterInfo();
}

void ReloadMove() {
	gServerInfo.ReadMoveInfo();
}

void ReloadQuest() {
	gServerInfo.ReadQuestInfo();
}

void ReloadShop() {
	gServerInfo.ReadShopInfo();
}

void ReloadSkill() {
	gServerInfo.ReadSkillInfo();
}

void ReloadUtil() {
	gServerInfo.ReadUtilInfo();
}

void ReloadLua() {
	gGameServerReloadLua = timeGetTime();
}

void ReloadLua2() {
	gGameServerReloadLua2 = timeGetTime();
}

void StartBC() {
	gBloodCastle.StartBC();
}

void StartDS() {
	gDevilSquare.StartDS();
}

void DamageSend(int aIndex, int TargetIndex, int reflet, int damage, int type) {
	if (!OBJECT_RANGE(aIndex)) {
		return;
	}

	GCDamageSend(aIndex, TargetIndex, reflet, damage, type);
}

void KillPlayer(int aIndex) {
	if (!OBJECT_USER_RANGE(aIndex)) {
		return;
	}

	gObj[aIndex].KillerType = 0;
	gObj[aIndex].Live = 0;
	gObj[aIndex].State = OBJECT_DYING;
	gObj[aIndex].RegenTime = timeGetTime();
	gObj[aIndex].DieRegen = 1;
	gObj[aIndex].PathCount = 0;
	gObj[aIndex].Teleport = ((gObj[aIndex].Teleport == 1) ? 0 : gObj[aIndex].Teleport);

	GCUserDieSend(&gObj[aIndex], aIndex, 0, aIndex);
}

void AddEffect(int aIndex, int type, int index, int count, int value1, int value2, int value3, int value4) {
	if (!OBJECT_RANGE(aIndex)) {
		return;
	}

	gEffectManager.AddEffect(&gObj[aIndex], type, index, count, value1, value2, value3, value4);
}

void RemoveEffect(int aIndex, int index) {
	if (!OBJECT_RANGE(aIndex)) {
		return;
	}

	gEffectManager.DelEffect(&gObj[aIndex], index);
}

void MoveGate(int aIndex, int gate) {
	if (!OBJECT_USER_RANGE(aIndex)) {
		return;
	}

	gObjMoveGate(aIndex, gate);
}

void DestroyParty(int aIndex) {
	gParty.Destroy(aIndex);
}

int GetMemberCountParty(int index) {
	return gParty.GetMemberCount(index);
}

int CreateParty(int aIndex) {
	return gParty.Create(aIndex);
}

int AddMemberParty(int PartyNumber, int TargetIndex) {
	return gParty.AddMember(PartyNumber, TargetIndex);
}

void GCPartyResultSend(int aIndex, int result) {
	gParty.GCPartyResultSend(aIndex, result);
}

void GCPartyDelMemberSend(int aIndex) {
	gParty.GCPartyDelMemberSend(aIndex);
}

void GCPartyListSend(int aIndex) {
	gParty.GCPartyListSend(aIndex);
}

int IsLeaderParty(int index, int aIndex) {
	return gParty.IsLeader(index, aIndex);
}

int IsMemberParty(int index, int aIndex) {
	return gParty.IsMember(index, aIndex);
}

int IsParty(int index) {
	return gParty.IsParty(index);
}

int GetMemberIndexParty(int index, int number) {
	return gParty.GetMemberIndex(index, number);
}

int GetStackItem(int ItemIndex, int Level) {
	return gItemStack.GetItemMaxStack(ItemIndex, Level);
}

int GetInventoryEmptySlotCount(int aIndex) {
	if (!OBJECT_USER_RANGE(aIndex)) {
		return 0;
	}

	return gItemManager.GetInventoryEmptySlotCount(&gObj[aIndex]);
}

int GetInventoryItemCount(int aIndex, int ItemIndex, int level) {
	if (!OBJECT_USER_RANGE(aIndex)) {
		return 0;
	}

	return gItemManager.GetInventoryItemCount(&gObj[aIndex], ItemIndex, level);
}

void DeleteItemCount(int aIndex, int ItemIndex, int level, int count) {
	if (!OBJECT_USER_RANGE(aIndex)) {
		return;
	}

	gItemManager.DeleteInventoryItemCount(&gObj[aIndex], ItemIndex, level, count);
}

int GetMapObject(int aIndex) {
	if (OBJECT_RANGE(aIndex) == 0) {
		return 0;
	}

	return gObj[aIndex].Map;
}

int GetLanguageObject(int aIndex) {
	if (OBJECT_RANGE(aIndex) == 0) {
		return 0;
	}

	return gObj[aIndex].Lang;
}

std::string GetNameObject(int aIndex) {
	if (OBJECT_RANGE(aIndex) == 0) {
		return 0;
	}

	return gObj[aIndex].Name;
}

std::string GetAccountObject(int aIndex) {
	if (OBJECT_RANGE(aIndex) == 0) {
		return 0;
	}

	return gObj[aIndex].Account;
}

void CommandAddPointAuto(int aIndex, int amount, int type) {
	if (OBJECT_RANGE(aIndex) == 0) {
		return;
	}

	gCommandManager.CommandAddPointAuto(&gObj[aIndex], (char*)amount, type - 1);
}

void CommandAddPointAutoProc(int aIndex) {
	if (OBJECT_RANGE(aIndex) == 0) {
		return;
	}

	gCommandManager.CommandAddPointAutoProc(&gObj[aIndex]);
}

int GetTimeDays(int dayOfWeek, int day, int hour, int minute, int second) {
	CTime ScheduleTime;

	CScheduleManager ScheduleManager;

	ScheduleManager.AddSchedule(-1, -1, day, hour, minute, second, dayOfWeek);

	if (ScheduleManager.GetSchedule(&ScheduleTime) == 0)
	{
		return 0;
	}

	return (int)difftime(ScheduleTime.GetTime(), time(0));
}

void DropEventItemBag(int aIndex, int SpecialValue) {
	if (OBJECT_RANGE(aIndex) == 0) {
		return;
	}

	gItemBagManager.DropItemBySpecialValue(SpecialValue, &gObj[aIndex], gObj[aIndex].Map, gObj[aIndex].X, gObj[aIndex].Y);
}

#ifdef OLD_LUA
using namespace luaaa;

CLuaFunctions gLuaFunctions;

CLuaFunctions::CLuaFunctions()
{
}

CLuaFunctions::~CLuaFunctions()
{
}


void CLuaFunctions::AddFunctions(lua_State * Lua)
{
	if (Lua == NULL)
	{
		return;
	}

	lua_pushcclosure(Lua, this->IncludeLuaOpenExtension, 0);
	lua_setglobal(Lua, "OpenExtension");

	lua_pushcclosure(Lua, this->IncludeLuaOpenExtensionCrypted, 0);
	lua_setglobal(Lua, "OpenProtectExtension");

	lua_pushcclosure(Lua, this->OpenFileLua, 0);
	lua_setglobal(Lua, "OpenFile");

	LuaModule(Lua).fun("LogAdd", &FuncLogAdd);
	LuaModule(Lua).fun("LogAddC", &LogAddC);
	LuaModule(Lua).fun("LogAddTD", &LogAddTD);
	LuaModule(Lua).fun("SendMessage", &SendMessageUser);
	LuaModule(Lua).fun("SendMessageGlobal", &SendMessageGlobal);
	LuaModule(Lua).fun("SendMessageAllServer", &SendMessageAllServer);
	LuaModule(Lua).fun("MoneySend", &MoneySend);
	LuaModule(Lua).fun("LevelUpSend", &LevelUpSend);
	LuaModule(Lua).fun("PkLevelSend", &PkLevelSend);
	LuaModule(Lua).fun("GetIndex", &GetIndex);
	LuaModule(Lua).fun("Teleport", &Teleport);
	LuaModule(Lua).fun("TeleportMap", &TeleportMap);
	LuaModule(Lua).fun("CloseChar", &CloseChar);
	LuaModule(Lua).fun("SkillSend", &SkillSend);
	LuaModule(Lua).fun("ViewportCreate", &ViewportCreate);
	LuaModule(Lua).fun("ViewportDestroy", &ViewportDestroy);
	LuaModule(Lua).fun("GetTick", &GetTick);
	LuaModule(Lua).fun("GetTickGS", &GetTickGS);
	LuaModule(Lua).fun("TrocarBauPlayer", &TrocarBauPlayer);
	LuaModule(Lua).fun("AddMonster", &AddMonster);
	LuaModule(Lua).fun("SetPositionMonster", &SetPositionMonsterLua);
	LuaModule(Lua).fun("SetMonster", &SetMonster);
	LuaModule(Lua).fun("gObjDel", &gObjDelLua);
	LuaModule(Lua).fun("gObjMonsterTopHitDamageUser", &MonsterTopHitDamageUser);
	LuaModule(Lua).fun("ItemSerialCreate", &ItemSerialCreate);
	LuaModule(Lua).fun("ItemSerialCreateComplete", &ItemSerialCreateComplete);
	LuaModule(Lua).fun("CreateItemInventory", &CreateItemInventory);
	LuaModule(Lua).fun("CreateItemMap", &CreateItemMap);
	LuaModule(Lua).fun("InventoryDeleteItem", &InventoryDeleteItem);
	LuaModule(Lua).fun("CreateInventoryItem", &CreateInventoryItem);
	LuaModule(Lua).fun("SendInventoryDeleteItem", &SendInventoryDeleteItem);
	LuaModule(Lua).fun("ItemListSend", &ItemListSend);
	LuaModule(Lua).fun("GetWarehouseList", &GetWarehouseList);
	LuaModule(Lua).fun("ChatTargetSend", &ChatTargetSend);
	LuaModule(Lua).fun("SetMapMonster", &SetMapMonster);
	LuaModule(Lua).fun("CalCharacter", &CalCharacter);
	LuaModule(Lua).fun("LifeUpdate", &LifeUpdate);
	LuaModule(Lua).fun("ManaUpdate", &ManaUpdate);
	LuaModule(Lua).fun("NextExpCalc", &NextExpCalc);
	LuaModule(Lua).fun("SetBP", &SetBP);
	LuaModule(Lua).fun("MakePreview", &MakePreview);
	LuaModule(Lua).fun("SendQuestPrize", &SendQuestPrize);
	LuaModule(Lua).fun("ResetSkills", &LuaResetSkills);
	LuaModule(Lua).fun("ClearViewPort", &ClearViewPort);
	LuaModule(Lua).fun("SendPacketMain", &SendPacketMain);
	LuaModule(Lua).fun("StateInfoSend", &StateInfoSend);
	LuaModule(Lua).fun("LevelExperience", &LevelExperience);
	LuaModule(Lua).fun("RefreshCharacter", &RefreshCharacter);
	LuaModule(Lua).fun("FireWorks", &FireWorks);
	LuaModule(Lua).fun("GetMapAttr", &GetMapAttr);
	LuaModule(Lua).fun("gObjAdd", &LuagObjAdd);
	LuaModule(Lua).fun("CharacterInfoSend", &CharacterInfoSend);
	LuaModule(Lua).fun("gObjSetPosition", &LuagObjSetPosition);
	LuaModule(Lua).fun("AccountInfoSend", &AccountInfoSend);
	LuaModule(Lua).fun("MoveObject", &LuaMoveObject);
	LuaModule(Lua).fun("SearchIndex", &SearchIndex);
	LuaModule(Lua).fun("GetServerName", &GetServerName);
	LuaModule(Lua).fun("CheckQuestListState", &CheckQuestListState);
	LuaModule(Lua).fun("AddQuestList", &AddQuestList);
	LuaModule(Lua).fun("InsertQuestReward", &InsertQuestReward);
	LuaModule(Lua).fun("GCQuestInfoSend", &LuaGCQuestInfoSend);
	LuaModule(Lua).fun("ChaosMixSend", &ChaosMixSend);
	LuaModule(Lua).fun("ChaosBoxInit", &ChaosBoxInit);
	LuaModule(Lua).fun("ChaosBoxSend", &ChaosBoxSend);
	LuaModule(Lua).fun("ClearAllBuff", &ClearAllBuff);
	LuaModule(Lua).fun("CheckBuffPlayer", &CheckBuffPlayer);
	LuaModule(Lua).fun("InventoryCheckSpaceByItem", &InventoryCheckSpaceByItem);
	LuaModule(Lua).fun("InventoryCheckSpaceBySize", &InventoryCheckSpaceBySize);
	LuaModule(Lua).fun("ResetQuest", &ResetQuest);
	LuaModule(Lua).fun("gObjIsConnectedGP", &gObjIsConnectedGPLua);
	LuaModule(Lua).fun("SendMessagePlayer", &SendMessagePlayer);

	LuaModule(Lua).fun("ReloadChaosMix", &ReloadChaosMix);
	LuaModule(Lua).fun("ReloadCharacter", &ReloadCharacter);
	LuaModule(Lua).fun("ReloadCommon", &ReloadCommon);
	LuaModule(Lua).fun("ReloadCustom", &ReloadCustom);
	LuaModule(Lua).fun("ReloadEvent", &ReloadEvent);
	LuaModule(Lua).fun("ReloadEventItemBag", &ReloadEventItemBag);
	LuaModule(Lua).fun("ReloadHack", &ReloadHack);
	LuaModule(Lua).fun("ReloadItem", &ReloadItem);
	LuaModule(Lua).fun("ReloadMonster", &ReloadMonster);
	LuaModule(Lua).fun("ReloadMove", &ReloadMove);
	LuaModule(Lua).fun("ReloadQuest", &ReloadQuest);
	LuaModule(Lua).fun("ReloadShop", &ReloadShop);
	LuaModule(Lua).fun("ReloadSkill", &ReloadSkill);
	LuaModule(Lua).fun("ReloadUtil", &ReloadUtil);
	LuaModule(Lua).fun("ReloadLua", &ReloadLua);
	LuaModule(Lua).fun("ReloadLua2", &ReloadLua2);

	LuaModule(Lua).fun("StartBC", &StartBC);
	LuaModule(Lua).fun("StartDS", &StartDS);

	LuaModule(Lua).fun("DamageSend", &DamageSend);
	LuaModule(Lua).fun("KillPlayer", &KillPlayer);
	LuaModule(Lua).fun("AddEffect", &AddEffect);
	LuaModule(Lua).fun("RemoveEffect", &RemoveEffect);
	LuaModule(Lua).fun("TeleportMapRange", &TeleportMapRange);
	LuaModule(Lua).fun("MoveGate", &MoveGate);

	//Party
	LuaModule(Lua).fun("DestroyParty", &DestroyParty);
	LuaModule(Lua).fun("GetMemberCountParty", &GetMemberCountParty);
	LuaModule(Lua).fun("CreateParty", &CreateParty);
	LuaModule(Lua).fun("AddMemberParty", &AddMemberParty);
	LuaModule(Lua).fun("GCPartyResultSend", &GCPartyResultSend);
	LuaModule(Lua).fun("GCPartyDelMemberSend", &GCPartyDelMemberSend);
	LuaModule(Lua).fun("GCPartyListSend", &GCPartyListSend);
	LuaModule(Lua).fun("IsLeaderParty", &IsLeaderParty);
	LuaModule(Lua).fun("IsMemberParty", &IsMemberParty);
	LuaModule(Lua).fun("IsParty", &IsParty);
	LuaModule(Lua).fun("GetMemberIndexParty", &GetMemberIndexParty);
	//Item
	LuaModule(Lua).fun("GetStackItem", &GetStackItem);
	LuaModule(Lua).fun("GetInventoryEmptySlotCount", &GetInventoryEmptySlotCount);
	LuaModule(Lua).fun("GetInventoryItemCount", &GetInventoryItemCount);
	LuaModule(Lua).fun("DeleteItemCount", &DeleteItemCount);
	LuaModule(Lua).fun("GetMapObject", &GetMapObject);
	LuaModule(Lua).fun("GetLanguageObject", &GetLanguageObject);
	LuaModule(Lua).fun("GetNameObject", &GetNameObject);
	LuaModule(Lua).fun("GetAccountObject", &GetAccountObject);
	LuaModule(Lua).fun("CommandAddPointAuto", &CommandAddPointAuto);
	LuaModule(Lua).fun("CommandAddPointAutoProc", &CommandAddPointAutoProc);
	LuaModule(Lua).fun("GetTimeDays", &GetTimeDays);
	LuaModule(Lua).fun("DropEventItemBag", &DropEventItemBag);
}
#else
void RegisterCallFunctions(sol::state& lua)
{
	lua.set_function("LogAdd", &FuncLogAdd);
	lua.set_function("LogAddC", &LogAddC);
	lua.set_function("LogAddTD", &LogAddTD);
	lua.set_function("SendMessage", &SendMessageUser);
	lua.set_function("SendMessageGlobal", &SendMessageGlobal);
	lua.set_function("SendMessageAllServer", &SendMessageAllServer);
	lua.set_function("MoneySend", &MoneySend);
	lua.set_function("LevelUpSend", &LevelUpSend);
	lua.set_function("PkLevelSend", &PkLevelSend);
	lua.set_function("GetIndex", &GetIndex);
	lua.set_function("Teleport", &Teleport);
	lua.set_function("TeleportMap", &TeleportMap);
	lua.set_function("CloseChar", &CloseChar);
	lua.set_function("SkillSend", &SkillSend);
	lua.set_function("ViewportCreate", &ViewportCreate);
	lua.set_function("ViewportDestroy", &ViewportDestroy);
	lua.set_function("GetTick", &GetTick);
	lua.set_function("GetTickGS", &GetTickGS);
	lua.set_function("TrocarBauPlayer", &TrocarBauPlayer);
	lua.set_function("AddMonster", &AddMonster);
	lua.set_function("SetPositionMonster", &SetPositionMonsterLua);
	lua.set_function("SetMonster", &SetMonster);
	lua.set_function("gObjDel", &gObjDelLua);
	lua.set_function("gObjMonsterTopHitDamageUser", &MonsterTopHitDamageUser);
	lua.set_function("ItemSerialCreate", &ItemSerialCreate);
	lua.set_function("ItemSerialCreateComplete", &ItemSerialCreateComplete);
	lua.set_function("CreateItemInventory", &CreateItemInventory);
	lua.set_function("CreateItemMap", &CreateItemMap);
	lua.set_function("InventoryDeleteItem", &InventoryDeleteItem);
	lua.set_function("CreateInventoryItem", &CreateInventoryItem);
	lua.set_function("SendInventoryDeleteItem", &SendInventoryDeleteItem);
	lua.set_function("ItemListSend", &ItemListSend);
	lua.set_function("GetWarehouseList", &GetWarehouseList);
	lua.set_function("ChatTargetSend", &ChatTargetSend);
	lua.set_function("SetMapMonster", &SetMapMonster);
	lua.set_function("CalCharacter", &CalCharacter);
	lua.set_function("LifeUpdate", &LifeUpdate);
	lua.set_function("ManaUpdate", &ManaUpdate);
	lua.set_function("NextExpCalc", &NextExpCalc);
	lua.set_function("SetBP", &SetBP);
	lua.set_function("MakePreview", &MakePreview);
	lua.set_function("SendQuestPrize", &SendQuestPrize);
	lua.set_function("ResetSkills", &LuaResetSkills);
	lua.set_function("ClearViewPort", &ClearViewPort);
	lua.set_function("SendPacketMain", &SendPacketMain);
	lua.set_function("StateInfoSend", &StateInfoSend);
	lua.set_function("LevelExperience", &LevelExperience);
	lua.set_function("RefreshCharacter", &RefreshCharacter);
	lua.set_function("FireWorks", &FireWorks);
	lua.set_function("GetMapAttr", &GetMapAttr);
	lua.set_function("gObjAdd", &LuagObjAdd);
	lua.set_function("CharacterInfoSend", &CharacterInfoSend);
	lua.set_function("gObjSetPosition", &LuagObjSetPosition);
	lua.set_function("AccountInfoSend", &AccountInfoSend);
	lua.set_function("MoveObject", &LuaMoveObject);
	lua.set_function("SearchIndex", &SearchIndex);
	lua.set_function("GetServerName", &GetServerName);

	lua.set_function("CheckQuestListState", &CheckQuestListState);
	lua.set_function("AddQuestList", &AddQuestList);
	lua.set_function("InsertQuestReward", &InsertQuestReward);
	lua.set_function("GCQuestInfoSend", &LuaGCQuestInfoSend);
	lua.set_function("ChaosMixSend", &ChaosMixSend);
	lua.set_function("ChaosBoxInit", &ChaosBoxInit);
	lua.set_function("ChaosBoxSend", &ChaosBoxSend);
	lua.set_function("ClearAllBuff", &ClearAllBuff);
	lua.set_function("CheckBuffPlayer", &CheckBuffPlayer);
	lua.set_function("InventoryCheckSpaceByItem", &InventoryCheckSpaceByItem);
	lua.set_function("InventoryCheckSpaceBySize", &InventoryCheckSpaceBySize);

	lua.set_function("ResetQuest", &ResetQuest);
	lua.set_function("gObjIsConnectedGP", &gObjIsConnectedGPLua);
	lua.set_function("SendMessagePlayer", &SendMessagePlayer);

	lua.set_function("ReloadChaosMix", &ReloadChaosMix);
	lua.set_function("ReloadCharacter", &ReloadCharacter);
	lua.set_function("ReloadCommon", &ReloadCommon);
	lua.set_function("ReloadCustom", &ReloadCustom);
	lua.set_function("ReloadEvent", &ReloadEvent);
	lua.set_function("ReloadEventItemBag", &ReloadEventItemBag);
	lua.set_function("ReloadHack", &ReloadHack);
	lua.set_function("ReloadItem", &ReloadItem);
	lua.set_function("ReloadMonster", &ReloadMonster);
	lua.set_function("ReloadMove", &ReloadMove);
	lua.set_function("ReloadQuest", &ReloadQuest);
	lua.set_function("ReloadShop", &ReloadShop);
	lua.set_function("ReloadSkill", &ReloadSkill);
	lua.set_function("ReloadUtil", &ReloadUtil);
	lua.set_function("ReloadLua", &ReloadLua);
	lua.set_function("ReloadLua2", &ReloadLua2);

	lua.set_function("StartBC", &StartBC);
	lua.set_function("StartDS", &StartDS);

	lua.set_function("DamageSend", &DamageSend);
	lua.set_function("KillPlayer", &KillPlayer);
	lua.set_function("AddEffect", &AddEffect);
	lua.set_function("RemoveEffect", &RemoveEffect);
	lua.set_function("TeleportMapRange", &TeleportMapRange);
	lua.set_function("MoveGate", &MoveGate);

	//Party
	lua.set_function("DestroyParty", &DestroyParty);
	lua.set_function("GetMemberCountParty", &GetMemberCountParty);
	lua.set_function("CreateParty", &CreateParty);
	lua.set_function("AddMemberParty", &AddMemberParty);
	lua.set_function("GCPartyResultSend", &GCPartyResultSend);
	lua.set_function("GCPartyDelMemberSend", &GCPartyDelMemberSend);
	lua.set_function("GCPartyListSend", &GCPartyListSend);
	lua.set_function("IsLeaderParty", &IsLeaderParty);
	lua.set_function("IsMemberParty", &IsMemberParty);
	lua.set_function("IsParty", &IsParty);
	lua.set_function("GetMemberIndexParty", &GetMemberIndexParty);

	//Item
	lua.set_function("GetStackItem", &GetStackItem);
	lua.set_function("GetInventoryEmptySlotCount", &GetInventoryEmptySlotCount);
	lua.set_function("GetInventoryItemCount", &GetInventoryItemCount);
	lua.set_function("DeleteItemCount", &DeleteItemCount);

	lua.set_function("GetMapObject", &GetMapObject);
	lua.set_function("GetLanguageObject", &GetLanguageObject);
	lua.set_function("GetNameObject", &GetNameObject);
	lua.set_function("GetAccountObject", &GetAccountObject);

	lua.set_function("CommandAddPointAuto", &CommandAddPointAuto);
	lua.set_function("CommandAddPointAutoProc", &CommandAddPointAutoProc);

	lua.set_function("GetTimeDays", &GetTimeDays);

	lua.set_function("DropEventItemBag", &DropEventItemBag);
}
#endif