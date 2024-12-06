#include "StdAfx.h"
#include "LuaUser.h"
#include "LuaStack.hpp"
#include "Util.h"
#include "User.h"
#include "Guild.h"
#include "PlayerCache.h"

class UserClass {
public:
	UserClass() : aIndex(-1) {

	};

	UserClass(int aIndex) {
		if (OBJECT_RANGE(aIndex)) {
			this->aIndex = aIndex;
		}
		else {
			this->aIndex = 0;
		}
	};

	~UserClass() {

	};

	int luaGetIndex() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Index;
		}
		else {
			return 0;
		}
	}

	std::string luaGetAccountID() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Account;
		}
		else {
			return "not found";
		}
	};

	std::string luaGetName() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Name;
		}
		else {
			return "not found";
		}
	};

	void luaSetName(const std::string& name) const {
		if (OBJECT_RANGE(this->aIndex)) {
			std::memcpy(&gObj[aIndex].Name, name.c_str(), sizeof(gObj[aIndex].Name));
		}
	};

	int luaGetConnected() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Connected;
		}
		else {
			return 0;
		}
	};

	void luaSetConnected(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].Connected = value;
		}
	};

	int luaGetLive() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Live;
		}
		else {
			return 0;
		}
	};

	void luaSetLive(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].Live = value;
		}
	};

	int luaGetType() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Type;
		}
		else {
			return 0;
		}
	};

	void luaSetType(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].Type = value;
		}
	};

	int luaGetClass() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Class;
		}
		else {
			return 0;
		}
	};

	void luaSetClass(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].Class = value;
		}
	};

	int luaGetDbClass() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].DBClass;
		}
		else {
			return 0;
		}
	};

	void luaSetDbClass(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].DBClass = value;
		}
	};

	int luaGetChangeUP() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].ChangeUp;
		}
		else {
			return 0;
		}
	};

	void luaSetChangeUP(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].ChangeUp = value;
		}
	};

	int luaGetLevel() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Level;
		}
		else {
			return 0;
		}
	};

	void luaSetLevel(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].Level = value;
		}
	};

	int luaGetLevelUpPoint() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].LevelUpPoint;
		}
		else {
			return 0;
		}
	};

	void luaSetLevelUpPoint(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].LevelUpPoint = value;
		}
	};

	int luaGetMoney() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Money;
		}
		else {
			return 0;
		}
	};

	void luaSetMoney(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].Money = value;
		}
	};

	int luaGetStrength() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Strength;
		}
		else {
			return 0;
		}
	};

	void luaSetStrength(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].Strength = value;
		}
	};

	int luaGetDexterity() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Dexterity;
		}
		else {
			return 0;
		}
	};

	void luaSetDexterity(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].Dexterity = value;
		}
	};

	int luaGetVitality() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Vitality;
		}
		else {
			return 0;
		}
	};

	void luaSetVitality(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].Vitality = value;
		}
	};

	int luaGetEnergy() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Energy;
		}
		else {
			return 0;
		}
	};

	void luaSetEnergy(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].Energy = value;
		}
	};

	int luaGetPKCount() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].PKCount;
		}
		else {
			return 0;
		}
	};

	void luaSetPKCount(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].PKCount = value;
		}
	};

	int luaGetPKLevel() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].PKLevel;
		}
		else {
			return 0;
		}
	};

	void luaSetPKLevel(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].PKLevel = value;
		}
	};

	int luaGetPKTime() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].PKTime;
		}
		else {
			return 0;
		}
	};

	void luaSetPKTime(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].PKTime = value;
		}
	};

	int luaGetX() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].X;
		}
		else {
			return 0;
		}
	};

	void luaSetX(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].X = value;
		}
	};

	int luaGetY() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Y;
		}
		else {
			return 0;
		}
	};

	void luaSetY(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].Y = value;
		}
	};

	int luaGetTX() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].TX;
		}
		else {
			return 0;
		}
	};

	void luaSetTX(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].TX = value;
		}
	};

	int luaGetTY() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].TY;
		}
		else {
			return 0;
		}
	};

	void luaSetTY(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].TY = value;
		}
	};

	int luaGetMTX() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].MTX;
		}
		else {
			return 0;
		}
	};

	void luaSetMTX(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].MTX = value;
		}
	};

	int luaGetMTY() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].MTY;
		}
		else {
			return 0;
		}
	};

	void luaSetMTY(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].MTY = value;
		}
	};

	int luaGetMapNumber() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Map;
		}
		else {
			return 0;
		}
	};

	void luaSetMapNumber(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].Map = value;
		}
	};

	int luaGetAuthority() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Authority;
		}
		else {
			return 0;
		}
	};

	void luaSetAuthority(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].Authority = value;
		}
	};

	int luaGetAuthorityCode() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].AuthorityCode;
		}
		else {
			return 0;
		}
	};

	void luaSetAuthorityCode(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].AuthorityCode = value;
		}
	};

	int luaGetSkin() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Change;
		}
		else {
			return 0;
		}
	};

	void luaSetSkin(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].Change = value;
		}
	};

	int luaGetExp() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Experience;
		}
		else {
			return 0;
		}
	};

	void luaSetExp(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].Experience = value;
		}
	};

	int luaGetTargetState(int slot) const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].VpPlayer[slot].state;
		}
		else {
			return 0;
		}
	};

	void luaSetTargetState(int slot, int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].VpPlayer[slot].state = value;
		}
	};

	int luaGetTargetNumber(int slot) const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].VpPlayer[slot].index;
		}
		else {
			return 0;
		}
	};

	void luaSetTargetNumber(int slot, int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].VpPlayer[slot].index = value;
		}
	};

	int luaGetTargetType(int slot) const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].VpPlayer[slot].type;
		}
		else {
			return 0;
		}
	};

	void luaSetTargetType(int slot, int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].VpPlayer[slot].type = value;
		}
	};

	int luaGetInterfaceUse() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Interface.use;
		}
		else {
			return 0;
		}
	};

	void luaSetInterfaceUse(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].Interface.use = value;
		}
	};

	int luaGetInterfaceState() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Interface.state;
		}
		else {
			return 0;
		}
	};

	void luaSetInterfaceState(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].Interface.state = value;
		}
	};

	int luaGetInterfaceType() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Interface.type;
		}
		else {
			return 0;
		}
	};

	void luaSetInterfaceType(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].Interface.type = value;
		}
	};

	int luaGetDefense() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Defense;
		}
		else {
			return 0;
		}
	};

	void luaSetDefense(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].Defense = value;
		}
	};

	int luaGetSuccessBlock() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].DefenseSuccessRate;
		}
		else {
			return 0;
		}
	};

	void luaSetSuccessBlock(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].DefenseSuccessRate = value;
		}
	};

	int luaGetState() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].State;
		}
		else {
			return 0;
		}
	};

	void luaSetState(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].State = value;
		}
	};

	int luaGetDieRegen() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].DieRegen;
		}
		else {
			return 0;
		}
	};

	void luaSetDieRegen(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].DieRegen = value;
		}
	};

	int luaGetTeleport() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Teleport;
		}
		else {
			return 0;
		}
	};

	void luaSetTeleport(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].Teleport = value;
		}
	};

	int luaGetTargetShopNumber() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].TargetShopNumber;
		}
		else {
			return 0;
		}
	};

	void luaSetTargetShopNumber(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].TargetShopNumber = value;
		}
	};

	int luaGetReqWarehouseOpen() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].ReqWarehouseOpen;
		}
		else {
			return 0;
		}
	};

	void luaSetReqWarehouseOpen(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].ReqWarehouseOpen = value;
		}
	};

	int luaGetWarehouseCount() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].WarehouseCount;
		}
		else {
			return 0;
		}
	};

	void luaSetWarehouseCount(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].WarehouseCount = value;
		}
	};

	int luaGetDir() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Dir;
		}
		else {
			return 0;
		}
	};

	void luaSetDir(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].Dir = value;
		}
	};

	int luaGetNextExp() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].NextExperience;
		}
		else {
			return 0;
		}
	};

	void luaSetNextExp(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].NextExperience = value;
		}
	};

	int luaGetLife() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return (int)gObj[this->aIndex].Life;
		}
		else {
			return 0;
		}
	};

	void luaSetLife(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].Life = (float)value;
		}
	};

	int luaGetMana() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return (int)gObj[this->aIndex].Mana;
		}
		else {
			return 0;
		}
	};

	void luaSetMana(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].Mana = (float)value;
		}
	};

	int luaGetMaxLife() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return (int)gObj[this->aIndex].MaxLife;
		}
		else {
			return 0;
		}
	};

	void luaSetMaxLife(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].MaxLife = (float)value;
		}
	};

	int luaGetMaxMana() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return (int)gObj[this->aIndex].MaxMana;
		}
		else {
			return 0;
		}
	};

	void luaSetMaxMana(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].MaxMana = (float)value;
		}
	};

	int luaGetBP() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return (int)gObj[this->aIndex].BP;
		}
		else {
			return 0;
		}
	};

	void luaSetBP(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].BP = value;
		}
	};

	int luaGetMaxBP() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return (int)gObj[this->aIndex].MaxBP;
		}
		else {
			return 0;
		}
	};

	void luaSetMaxBP(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].MaxBP = value;
		}
	};

	int luaGetVitalityToLife() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return (int)gObj[this->aIndex].VitalityToLife;
		}
		else {
			return 0;
		}
	};

	void luaSetVitalityToLife(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].VitalityToLife = (float)value;
		}
	};

	int luaGetEnergyToMana() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return (int)gObj[this->aIndex].EnergyToMana;
		}
		else {
			return 0;
		}
	};

	void luaSetEnergyToMana(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].EnergyToMana = (float)value;
		}
	};

	int luaGetOption() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Option;
		}
		else {
			return 0;
		}
	};

	void luaSetOption(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].Option = value;
		}
	};

	int luaGetAddLife() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].AddLife;
		}
		else {
			return 0;
		}
	};

	void luaSetAddLife(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].AddLife = value;
		}
	};

	int luaGetAddMana() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].AddMana;
		}
		else {
			return 0;
		}
	};

	void luaSetAddMana(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].AddMana = value;
		}
	};

	int luaGetAddBP() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].AddBP;
		}
		else {
			return 0;
		}
	};

	void luaSetAddBP(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].AddBP = value;
		}
	};

	int luaGetAttackSpeed() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].PhysiSpeed;
		}
		else {
			return 0;
		}
	};

	void luaSetAttackSpeed(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].PhysiSpeed = value;
		}
	};

	int luaGetMagicSpeed() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].MagicSpeed;
		}
		else {
			return 0;
		}
	};

	void luaSetMagicSpeed(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].MagicSpeed = value;
		}
	};

	int luaGetMagicDamageMin() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].MagicDamageMin;
		}
		else {
			return 0;
		}
	};

	void luaSetMagicDamageMin(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].MagicDamageMin = value;
		}
	};

	int luaGetMagicDamageMax() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].MagicDamageMax;
		}
		else {
			return 0;
		}
	};

	void luaSetMagicDamageMax(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].MagicDamageMax = value;
		}
	};

	int luaGetAttackDamageMinLeft() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].PhysiDamageMinLeft;
		}
		else {
			return 0;
		}
	};

	void luaSetAttackDamageMinLeft(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].PhysiDamageMinLeft = value;
		}
	};

	int luaGetAttackDamageMaxLeft() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].PhysiDamageMaxLeft;
		}
		else {
			return 0;
		}
	};

	void luaSetAttackDamageMaxLeft(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].PhysiDamageMaxLeft = value;
		}
	};

	int luaGetAttackDamageMinRight() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].PhysiDamageMinRight;
		}
		else {
			return 0;
		}
	};

	void luaSetAttackDamageMinRight(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].PhysiDamageMinRight = value;
		}
	};

	int luaGetAttackDamageMaxRight() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].PhysiDamageMaxRight;
		}
		else {
			return 0;
		}
	};

	void luaSetAttackDamageMaxRight(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].PhysiDamageMaxRight = value;
		}
	};

	int luaGetRegenTime() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].RegenTime;
		}
		else {
			return 0;
		}
	};

	void luaSetRegenTime(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].RegenTime = value;
		}
	};

	int luaGetViewSkillState() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].ViewSkillState;
		}
		else {
			return 0;
		}
	};

	void luaSetViewSkillState(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].ViewSkillState = value;
		}
	};

	int luaGetGetRegen() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].RegenOk;
		}
		else {
			return 0;
		}
	};

	void luaSetGetRegen(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].RegenOk = value;
		}
	};

	int luaGetMagicSkill() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Skill->m_index;
		}
		else {
			return 0;
		}
	};

	void luaSetMagicSkill(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].Skill->m_index = value;
		}
	};

	int luaGetKillerType() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].KillerType;
		}
		else {
			return 0;
		}
	};

	void luaSetKillerType(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].KillerType = value;
		}
	};

	int luaGetConnectCheckTime() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].ConnectTickCount;
		}
		else {
			return 0;
		}
	};

	void luaSetConnectCheckTime(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].ConnectTickCount = value;
		}
	};

	int luaGetCheckSumTime() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].CheckSumTime;
		}
		else {
			return 0;
		}
	};

	void luaSetCheckSumTime(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].CheckSumTime = value;
		}
	};

	int luaGetPathCount() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].PathCount;
		}
		else {
			return 0;
		}
	};

	void luaSetPathCount(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].PathCount = value;
		}
	};

	int luaGetRegenMapNumber() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].RegenMapNumber;
		}
		else {
			return 0;
		}
	};

	void luaSetRegenMapNumber(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].RegenMapNumber = value;
		}
	};

	int luaGetRegenMapX() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].RegenMapX;
		}
		else {
			return 0;
		}
	};

	void luaSetRegenMapX(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].RegenMapX = value;
		}
	};

	int luaGetRegenMapY() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].RegenMapY;
		}
		else {
			return 0;
		}
	};

	void luaSetRegenMapY(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].RegenMapY = value;
		}
	};

	int luaGetPathCur() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].PathCur;
		}
		else {
			return 0;
		}
	};

	void luaSetPathCur(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].PathCur = value;
		}
	};

	int luaGetPathX(int path) const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].PathX[path];
		}
		else {
			return 0;
		}
	};

	void luaSetPathX(int path, int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].PathX[path] = value;
		}
	};

	int luaGetPathY(int path) const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].PathY[path];
		}
		else {
			return 0;
		}
	};

	void luaSetPathY(int path, int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].PathY[path] = value;
		}
	};

	int luaGetPathDir(int path) const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].PathDir[path];
		}
		else {
			return 0;
		}
	};

	void luaSetPathDir(int path, int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].PathDir[path] = value;
		}
	};

	int luaGetTradeTarget() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].TargetNumber;
		}
		else {
			return 0;
		}
	};

	void luaSetTradeTarget(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].TargetNumber = value;
		}
	};

	int luaGetVip() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].AccountLevel;
		}
		else {
			return 0;
		}
	};

	void luaSetVip(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].AccountLevel = value;
		}
	};

	int luaGetReset() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Reset;
		}
		else {
			return 0;
		}
	};

	void luaSetReset(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].Reset = value;
		}
	};

	int luaGetMasterReset() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].GrandReset;
		}
		else {
			return 0;
		}
	};

	void luaSetMasterReset(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].GrandReset = value;
		}
	};

	int luaGetLoginMessageSend() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].LoginMessageSend;
		}
		else {
			return 0;
		}
	};

	void luaSetLoginMessageSend(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].LoginMessageSend = value;
		}
	};

	int luaGetLoginMessageCount() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].LoginMessageCount;
		}
		else {
			return 0;
		}
	};

	void luaSetLoginMessageCount(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].LoginMessageCount = value;
		}
	};

	int luaGetSendQuestInfo() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].SendQuestInfo;
		}
		else {
			return 0;
		}
	};

	void luaSetSendQuestInfo(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].SendQuestInfo = value;
		}
	};

	int luaGetExpRate() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].ExperienceRate;
		}
		else {
			return 0;
		}
	};

	void luaSetExpRate(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].ExperienceRate = value;
		}
	};


	int getLanguage() {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Lang;
		}

		return 0;
	}

	int getChatLimitTime() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].ChatLimitTime;
		}
		else {
			return 0;
		}
	};

	void setChatLimitTime(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].ChatLimitTime = value;
		}
	};

	int getGuildNumber() const {
		if (!OBJECT_RANGE(this->aIndex)) {
			return -1;
		}

		return gObj[this->aIndex].GuildNumber;
	};

	std::string getGuildName() const {
		if (!OBJECT_RANGE(this->aIndex)) {
			return "Not find";
		}

		return gObj[this->aIndex].GuildName;
	};

	int getGuildWarDeclareState() const {
		if (OBJECT_USER_RANGE(this->aIndex) == 0) {
			return 0;
		}

		if (gObj[this->aIndex].Guild == nullptr) {
			return 0;
		}

		return gObj[this->aIndex].Guild->WarDeclareState;
	};

	int getGuildWarState() const {
		if (OBJECT_USER_RANGE(this->aIndex) == 0) {
			return 0;
		}

		if (gObj[this->aIndex].Guild == nullptr) {
			return 0;
		}

		return gObj[this->aIndex].Guild->WarState;
	};

	int getGuildWarType() const {
		if (OBJECT_USER_RANGE(this->aIndex) == 0) {
			return 0;
		}

		if (gObj[this->aIndex].Guild == nullptr) {
			return 0;
		}

		return gObj[this->aIndex].Guild->WarType;
	};

	int getGuildTotalScore() const {
		if (OBJECT_USER_RANGE(this->aIndex) == 0) {
			return 0;
		}

		if (gObj[this->aIndex].Guild == nullptr) {
			return 0;
		}

		return gObj[this->aIndex].Guild->GuildScore;
	};

	int getPartyNumber() const {
		if (OBJECT_USER_RANGE(this->aIndex) == 0) {
			return 0;
		}

		return gObj[this->aIndex].PartyNumber;
	};

	void setPartyNumber(int value) const {
		if (OBJECT_USER_RANGE(this->aIndex) == 0) {
			return;
		}

		gObj[this->aIndex].PartyNumber = value;
	};

	int getSummonIndex() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].SummonIndex;
		}
		else {
			return 0;
		}
	};

	void setSummonIndex(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].SummonIndex = value;
		}
	};

	int getAutoResetEnable() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].AutoResetEnable;
		}
		else {
			return 0;
		}
	};

	void setAutoResetEnable(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].AutoResetEnable = value;
		}
	};

	int getAutoResetStats(int key) const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].AutoResetStats[key];
		}
		else {
			return 0;
		}
	};

	void setAutoResetStats(int key, int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].AutoResetStats[key] = value;
		}
	};

	int getAutoAddPointCount() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].AutoAddPointCount;
		}
		else {
			return 0;
		}
	};

	void setAutoAddPointCount(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].AutoAddPointCount = value;
		}
	};

	int getAutoAddPointStats(int key) const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].AutoAddPointStats[key];
		}
		else {
			return 0;
		}
	};

	void setAutoAddPointStats(int key, int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].AutoAddPointStats[key] = value;
		}
	};

	int getCacheInt(std::string key) {
		if (OBJECT_RANGE(this->aIndex)) {
			return gPlayerCache[this->aIndex].m_cacheInt[key];
		}

		return -1;
	};

	void setCacheInt(std::string key, int value) {
		if (OBJECT_RANGE(this->aIndex)) {
			gPlayerCache[this->aIndex].m_cacheInt[key] = value;
		}
	};

	void clearCacheInt(std::string key) {
		if (OBJECT_RANGE(this->aIndex)) {
			gPlayerCache[this->aIndex].m_cacheInt.erase(key);
		}
	};

	std::string getCacheStr(std::string key) {
		if (OBJECT_RANGE(this->aIndex)) {
			return gPlayerCache[this->aIndex].m_cacheStr[key];
		}

		return "nil";
	};

	void setCacheStr(std::string key, std::string value) {
		if (OBJECT_RANGE(this->aIndex)) {
			gPlayerCache[this->aIndex].m_cacheStr[key] = value;
		}
	};

	void clearCacheStr(std::string key) {
		if (OBJECT_RANGE(this->aIndex)) {
			gPlayerCache[this->aIndex].m_cacheStr.erase(key);
		}
	};

#if (GAMESERVER_UPDATE>=401)
	int getCoin1() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Coin1;
		}
		else {
			return 0;
		}
	};

	void setCoin1(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].Coin1 = value;
		}
	};

	int getCoin2() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Coin2;
		}
		else {
			return 0;
		}
	};

	void setCoin2(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].Coin2 = value;
		}
	};

	int getCoin3() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Coin3;
		}
		else {
			return 0;
		}
	};

	void setCoin3(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].Coin3 = value;
		}
	};

	int getCashShopTransaction(int key) const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].CashShopTransaction[key];
		}
		else {
			return 0;
		}
	};

	void setCashShopTransaction(int key, int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].CashShopTransaction[key] = value;
		}
	};
#endif

#if (GAMESERVER_UPDATE>=600)
	int getInMuHelperOffline() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].m_OfflineMode;
		}
		else {
			return 0;
		}
	};

	void setInMuHelperOffline(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].m_OfflineMode = value;
		}
	};

	int getInOffAttack() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].AttackCustom;
		}
		else {
			return 0;
		}
	};

	void setInOffAttack(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].AttackCustom = value;
		}
	};

	int getInOffStore() const {
		if (OBJECT_RANGE(this->aIndex)) {
			return gObj[this->aIndex].PShopCustomOffline;
		}
		else {
			return 0;
		}
	};

	void setInOffStore(int value) const {
		if (OBJECT_RANGE(this->aIndex)) {
			gObj[this->aIndex].PShopCustomOffline = value;
		}
	};
#endif

private:
	int aIndex;
};

#ifdef OLD_LUA
void RegisterUserClass(lua_State* lua) {
	luaaa::LuaClass<UserClass> luaUser(lua, "User");
	luaUser.ctor<int>();
	luaUser.fun("getIndex", &UserClass::luaGetIndex);
	luaUser.fun("getAccountID", &UserClass::luaGetAccountID);
	luaUser.fun("getName", &UserClass::luaGetName);
	luaUser.fun("setName", &UserClass::luaSetName);
	luaUser.fun("getConnected", &UserClass::luaGetConnected);
	luaUser.fun("setConnected", &UserClass::luaSetConnected);
	luaUser.fun("getLive", &UserClass::luaGetLive);
	luaUser.fun("setLive", &UserClass::luaSetLive);
	luaUser.fun("getType", &UserClass::luaGetType);
	luaUser.fun("setType", &UserClass::luaSetType);
	luaUser.fun("getClass", &UserClass::luaGetClass);
	luaUser.fun("setClass", &UserClass::luaSetClass);
	luaUser.fun("getDbClass", &UserClass::luaGetDbClass);
	luaUser.fun("setDbClass", &UserClass::luaSetDbClass);
	luaUser.fun("getChangeUP", &UserClass::luaGetChangeUP);
	luaUser.fun("setChangeUP", &UserClass::luaSetChangeUP);
	luaUser.fun("getLevel", &UserClass::luaGetLevel);
	luaUser.fun("setLevel", &UserClass::luaSetLevel);
	luaUser.fun("getLevelUpPoint", &UserClass::luaGetLevelUpPoint);
	luaUser.fun("setLevelUpPoint", &UserClass::luaSetLevelUpPoint);
	luaUser.fun("getMoney", &UserClass::luaGetMoney);
	luaUser.fun("setMoney", &UserClass::luaSetMoney);
	luaUser.fun("getStrength", &UserClass::luaGetStrength);
	luaUser.fun("setStrength", &UserClass::luaSetStrength);
	luaUser.fun("getDexterity", &UserClass::luaGetDexterity);
	luaUser.fun("setDexterity", &UserClass::luaSetDexterity);
	luaUser.fun("getVitality", &UserClass::luaGetVitality);
	luaUser.fun("setVitality", &UserClass::luaSetVitality);
	luaUser.fun("getEnergy", &UserClass::luaGetEnergy);
	luaUser.fun("setEnergy", &UserClass::luaSetEnergy);
	luaUser.fun("getPKCount", &UserClass::luaGetPKCount);
	luaUser.fun("setPKCount", &UserClass::luaSetPKCount);
	luaUser.fun("getPKLevel", &UserClass::luaGetPKLevel);
	luaUser.fun("setPKLevel", &UserClass::luaSetPKLevel);
	luaUser.fun("getPKTime", &UserClass::luaGetPKTime);
	luaUser.fun("setPKTime", &UserClass::luaSetPKTime);
	luaUser.fun("getX", &UserClass::luaGetX);
	luaUser.fun("setX", &UserClass::luaSetX);
	luaUser.fun("getY", &UserClass::luaGetY);
	luaUser.fun("setY", &UserClass::luaSetY);
	luaUser.fun("getTX", &UserClass::luaGetTX);
	luaUser.fun("setTX", &UserClass::luaSetTX);
	luaUser.fun("getTY", &UserClass::luaGetTY);
	luaUser.fun("setTY", &UserClass::luaSetTY);
	luaUser.fun("getMTX", &UserClass::luaGetMTX);
	luaUser.fun("setMTX", &UserClass::luaSetMTX);
	luaUser.fun("getMTY", &UserClass::luaGetMTY);
	luaUser.fun("setMTY", &UserClass::luaSetMTY);
	luaUser.fun("getMapNumber", &UserClass::luaGetMapNumber);
	luaUser.fun("setMapNumber", &UserClass::luaSetMapNumber);
	luaUser.fun("getAuthority", &UserClass::luaGetAuthority);
	luaUser.fun("setAuthority", &UserClass::luaSetAuthority);
	luaUser.fun("getAuthorityCode", &UserClass::luaGetAuthorityCode);
	luaUser.fun("setAuthorityCode", &UserClass::luaSetAuthorityCode);
	luaUser.fun("getSkin", &UserClass::luaGetSkin);
	luaUser.fun("setSkin", &UserClass::luaSetSkin);
	luaUser.fun("getExp", &UserClass::luaGetExp);
	luaUser.fun("setExp", &UserClass::luaSetExp);
	luaUser.fun("getTargetState", &UserClass::luaGetTargetState);
	luaUser.fun("setTargetState", &UserClass::luaSetTargetState);
	luaUser.fun("getTargetNumber", &UserClass::luaGetTargetNumber);
	luaUser.fun("setTargetNumber", &UserClass::luaSetTargetNumber);
	luaUser.fun("getTargetType", &UserClass::luaGetTargetType);
	luaUser.fun("setTargetType", &UserClass::luaSetTargetType);
	luaUser.fun("getInterfaceUse", &UserClass::luaGetInterfaceUse);
	luaUser.fun("setInterfaceUse", &UserClass::luaSetInterfaceUse);
	luaUser.fun("getInterfaceState", &UserClass::luaGetInterfaceState);
	luaUser.fun("setInterfaceState", &UserClass::luaSetInterfaceState);
	luaUser.fun("getInterfaceType", &UserClass::luaGetInterfaceType);
	luaUser.fun("setInterfaceType", &UserClass::luaSetInterfaceType);
	luaUser.fun("getDefense", &UserClass::luaGetDefense);
	luaUser.fun("setDefense", &UserClass::luaSetDefense);
	luaUser.fun("getSuccessBlock", &UserClass::luaGetSuccessBlock);
	luaUser.fun("setSuccessBlock", &UserClass::luaSetSuccessBlock);
	luaUser.fun("getState", &UserClass::luaGetState);
	luaUser.fun("setState", &UserClass::luaSetState);
	luaUser.fun("getDieRegen", &UserClass::luaGetDieRegen);
	luaUser.fun("setDieRegen", &UserClass::luaSetDieRegen);
	luaUser.fun("getTeleport", &UserClass::luaGetTeleport);
	luaUser.fun("setTeleport", &UserClass::luaSetTeleport);
	luaUser.fun("getTargetShopNumber", &UserClass::luaGetTargetShopNumber);
	luaUser.fun("setTargetShopNumber", &UserClass::luaSetTargetShopNumber);
	luaUser.fun("getReqWarehouseOpen", &UserClass::luaGetReqWarehouseOpen);
	luaUser.fun("setReqWarehouseOpen", &UserClass::luaSetReqWarehouseOpen);
	luaUser.fun("getWarehouseCount", &UserClass::luaGetWarehouseCount);
	luaUser.fun("setWarehouseCount", &UserClass::luaSetWarehouseCount);
	luaUser.fun("getDir", &UserClass::luaGetDir);
	luaUser.fun("setDir", &UserClass::luaSetDir);
	luaUser.fun("getNextExp", &UserClass::luaGetNextExp);
	luaUser.fun("setNextExp", &UserClass::luaSetNextExp);
	luaUser.fun("getLife", &UserClass::luaGetLife);
	luaUser.fun("setLife", &UserClass::luaSetLife);
	luaUser.fun("getMana", &UserClass::luaGetMana);
	luaUser.fun("setMana", &UserClass::luaSetMana);
	luaUser.fun("getMaxLife", &UserClass::luaGetMaxLife);
	luaUser.fun("setMaxLife", &UserClass::luaSetMaxLife);
	luaUser.fun("getMaxMana", &UserClass::luaGetMaxMana);
	luaUser.fun("setMaxMana", &UserClass::luaSetMaxMana);
	luaUser.fun("getBP", &UserClass::luaGetBP);
	luaUser.fun("setBP", &UserClass::luaSetBP);
	luaUser.fun("getMaxBP", &UserClass::luaGetMaxBP);
	luaUser.fun("setMaxBP", &UserClass::luaSetMaxBP);
	luaUser.fun("getVitalityToLife", &UserClass::luaGetVitalityToLife);
	luaUser.fun("setVitalityToLife", &UserClass::luaSetVitalityToLife);
	luaUser.fun("getEnergyToMana", &UserClass::luaGetEnergyToMana);
	luaUser.fun("setEnergyToMana", &UserClass::luaSetEnergyToMana);
	luaUser.fun("getOption", &UserClass::luaGetOption);
	luaUser.fun("setOption", &UserClass::luaSetOption);
	luaUser.fun("getAddLife", &UserClass::luaGetAddLife);
	luaUser.fun("setAddLife", &UserClass::luaSetAddLife);
	luaUser.fun("getAddMana", &UserClass::luaGetAddMana);
	luaUser.fun("setAddMana", &UserClass::luaSetAddMana);
	luaUser.fun("getAddBP", &UserClass::luaGetAddBP);
	luaUser.fun("setAddBP", &UserClass::luaSetAddBP);
	luaUser.fun("getAttackSpeed", &UserClass::luaGetAttackSpeed);
	luaUser.fun("setAttackSpeed", &UserClass::luaSetAttackSpeed);
	luaUser.fun("getMagicSpeed", &UserClass::luaGetMagicSpeed);
	luaUser.fun("setMagicSpeed", &UserClass::luaSetMagicSpeed);
	luaUser.fun("getMagicDamageMin", &UserClass::luaGetMagicDamageMin);
	luaUser.fun("setMagicDamageMin", &UserClass::luaSetMagicDamageMin);
	luaUser.fun("getMagicDamageMax", &UserClass::luaGetMagicDamageMax);
	luaUser.fun("setMagicDamageMax", &UserClass::luaSetMagicDamageMax);
	luaUser.fun("getAttackDamageMinLeft", &UserClass::luaGetAttackDamageMinLeft);
	luaUser.fun("setAttackDamageMinLeft", &UserClass::luaSetAttackDamageMinLeft);
	luaUser.fun("getAttackDamageMaxLeft", &UserClass::luaGetAttackDamageMaxLeft);
	luaUser.fun("setAttackDamageMaxLeft", &UserClass::luaSetAttackDamageMaxLeft);
	luaUser.fun("getAttackDamageMinRight", &UserClass::luaGetAttackDamageMinRight);
	luaUser.fun("setAttackDamageMinRight", &UserClass::luaSetAttackDamageMinRight);
	luaUser.fun("getAttackDamageMaxRight", &UserClass::luaGetAttackDamageMaxRight);
	luaUser.fun("setAttackDamageMaxRight", &UserClass::luaSetAttackDamageMaxRight);
	luaUser.fun("getRegenTime", &UserClass::luaGetRegenTime);
	luaUser.fun("setRegenTime", &UserClass::luaSetRegenTime);
	luaUser.fun("getViewSkillState", &UserClass::luaGetViewSkillState);
	luaUser.fun("setViewSkillState", &UserClass::luaSetViewSkillState);
	luaUser.fun("getGetRegen", &UserClass::luaGetGetRegen);
	luaUser.fun("setGetRegen", &UserClass::luaSetGetRegen);
	luaUser.fun("getMagicSkill", &UserClass::luaGetMagicSkill);
	luaUser.fun("setMagicSkill", &UserClass::luaSetMagicSkill);
	luaUser.fun("getKillerType", &UserClass::luaGetKillerType);
	luaUser.fun("setKillerType", &UserClass::luaSetKillerType);
	luaUser.fun("getConnectCheckTime", &UserClass::luaGetConnectCheckTime);
	luaUser.fun("setConnectCheckTime", &UserClass::luaSetConnectCheckTime);
	luaUser.fun("getCheckSumTime", &UserClass::luaGetCheckSumTime);
	luaUser.fun("setCheckSumTime", &UserClass::luaSetCheckSumTime);
	luaUser.fun("getPathCount", &UserClass::luaGetPathCount);
	luaUser.fun("setPathCount", &UserClass::luaSetPathCount);
	luaUser.fun("getRegenMapNumber", &UserClass::luaGetRegenMapNumber);
	luaUser.fun("setRegenMapNumber", &UserClass::luaSetRegenMapNumber);
	luaUser.fun("getRegenMapX", &UserClass::luaGetRegenMapX);
	luaUser.fun("setRegenMapX", &UserClass::luaSetRegenMapX);
	luaUser.fun("getRegenMapY", &UserClass::luaGetRegenMapY);
	luaUser.fun("setRegenMapY", &UserClass::luaSetRegenMapY);
	luaUser.fun("getPathCur", &UserClass::luaGetPathCur);
	luaUser.fun("setPathCur", &UserClass::luaSetPathCur);
	luaUser.fun("getPathX", &UserClass::luaGetPathX);
	luaUser.fun("setPathX", &UserClass::luaSetPathX);
	luaUser.fun("getPathY", &UserClass::luaGetPathY);
	luaUser.fun("setPathY", &UserClass::luaSetPathY);
	luaUser.fun("getPathDir", &UserClass::luaGetPathDir);
	luaUser.fun("setPathDir", &UserClass::luaSetPathDir);
	luaUser.fun("getTradeTarget", &UserClass::luaGetTradeTarget);
	luaUser.fun("setTradeTarget", &UserClass::luaSetTradeTarget);
	luaUser.fun("getVip", &UserClass::luaGetVip);
	luaUser.fun("setVip", &UserClass::luaSetVip);
	luaUser.fun("getReset", &UserClass::luaGetReset);
	luaUser.fun("setReset", &UserClass::luaSetReset);
	luaUser.fun("getMasterReset", &UserClass::luaGetMasterReset);
	luaUser.fun("setMasterReset", &UserClass::luaSetMasterReset);
	luaUser.fun("getLoginMessageSend", &UserClass::luaGetLoginMessageSend);
	luaUser.fun("setLoginMessageSend", &UserClass::luaSetLoginMessageSend);
	luaUser.fun("getLoginMessageCount", &UserClass::luaGetLoginMessageCount);
	luaUser.fun("setLoginMessageCount", &UserClass::luaSetLoginMessageCount);
	luaUser.fun("getSendQuestInfo", &UserClass::luaGetSendQuestInfo);
	luaUser.fun("setSendQuestInfo", &UserClass::luaSetSendQuestInfo);
	luaUser.fun("getExpRate", &UserClass::luaGetExpRate);
	luaUser.fun("setExpRate", &UserClass::luaSetExpRate);
	luaUser.fun("getLanguage", &UserClass::getLanguage);
	luaUser.fun("getChatLimitTime", &UserClass::getChatLimitTime);
	luaUser.fun("setChatLimitTime", &UserClass::setChatLimitTime);
	//Guild
	luaUser.fun("getGuildNumber", &UserClass::getGuildNumber);
	luaUser.fun("getGuildName", &UserClass::getGuildName);
	luaUser.fun("getGuildWarDeclareState", &UserClass::getGuildWarDeclareState);
	luaUser.fun("getGuildWarState", &UserClass::getGuildWarState);
	luaUser.fun("getGuildWarType", &UserClass::getGuildWarType);
	luaUser.fun("getGuildTotalScore", &UserClass::getGuildTotalScore);
	//Party
	luaUser.fun("getPartyNumber", &UserClass::getPartyNumber);
	luaUser.fun("setPartyNumber", &UserClass::setPartyNumber);

	luaUser.fun("getSummonIndex", &UserClass::getSummonIndex);
	luaUser.fun("setSummonIndex", &UserClass::setSummonIndex);

	//Auto Reset and auto add point
	luaUser.fun("getAutoResetEnable", &UserClass::getAutoResetEnable);
	luaUser.fun("setAutoResetEnable", &UserClass::setAutoResetEnable);

	luaUser.fun("getAutoResetStats", &UserClass::getAutoResetStats);
	luaUser.fun("setAutoResetStats", &UserClass::setAutoResetStats);

	luaUser.fun("getAutoAddPointCount", &UserClass::getAutoAddPointCount);
	luaUser.fun("setAutoAddPointCount", &UserClass::setAutoAddPointCount);

	luaUser.fun("getAutoAddPointStats", &UserClass::getAutoAddPointStats);
	luaUser.fun("setAutoAddPointStats", &UserClass::setAutoAddPointStats);

	//cache player
	luaUser.fun("getCacheInt", &UserClass::getCacheInt);
	luaUser.fun("setCacheInt", &UserClass::setCacheInt);
	luaUser.fun("clearCacheInt", &UserClass::clearCacheInt);

	luaUser.fun("getCacheStr", &UserClass::getCacheStr);
	luaUser.fun("setCacheStr", &UserClass::setCacheStr);
	luaUser.fun("clearCacheStr", &UserClass::clearCacheStr);
}
#else
void RegisterUserClass(sol::state& lua)
{
	sol::usertype<UserClass> user_type = lua.new_usertype<UserClass>("User",
		sol::constructors<UserClass(), UserClass(int)>());

	user_type["getIndex"] = &UserClass::luaGetIndex;
	user_type["getAccountID"] = &UserClass::luaGetAccountID;
	user_type["getName"] = &UserClass::luaGetName;
	user_type["setName"] = &UserClass::luaSetName;
	user_type["getConnected"] = &UserClass::luaGetConnected;
	user_type["setConnected"] = &UserClass::luaSetConnected;
	user_type["getLive"] = &UserClass::luaGetLive;
	user_type["setLive"] = &UserClass::luaSetLive;
	user_type["getType"] = &UserClass::luaGetType;
	user_type["setType"] = &UserClass::luaSetType;
	user_type["getClass"] = &UserClass::luaGetClass;
	user_type["setClass"] = &UserClass::luaSetClass;
	user_type["getDbClass"] = &UserClass::luaGetDbClass;
	user_type["setDbClass"] = &UserClass::luaSetDbClass;
	user_type["getChangeUP"] = &UserClass::luaGetChangeUP;
	user_type["setChangeUP"] = &UserClass::luaSetChangeUP;
	user_type["getLevel"] = &UserClass::luaGetLevel;
	user_type["setLevel"] = &UserClass::luaSetLevel;
	user_type["getLevelUpPoint"] = &UserClass::luaGetLevelUpPoint;
	user_type["setLevelUpPoint"] = &UserClass::luaSetLevelUpPoint;
	user_type["getMoney"] = &UserClass::luaGetMoney;
	user_type["setMoney"] = &UserClass::luaSetMoney;
	user_type["getStrength"] = &UserClass::luaGetStrength;
	user_type["setStrength"] = &UserClass::luaSetStrength;
	user_type["getDexterity"] = &UserClass::luaGetDexterity;
	user_type["setDexterity"] = &UserClass::luaSetDexterity;
	user_type["getVitality"] = &UserClass::luaGetVitality;
	user_type["setVitality"] = &UserClass::luaSetVitality;
	user_type["getEnergy"] = &UserClass::luaGetEnergy;
	user_type["setEnergy"] = &UserClass::luaSetEnergy;
	user_type["getPKCount"] = &UserClass::luaGetPKCount;
	user_type["setPKCount"] = &UserClass::luaSetPKCount;
	user_type["getPKLevel"] = &UserClass::luaGetPKLevel;
	user_type["setPKLevel"] = &UserClass::luaSetPKLevel;
	user_type["getPKTime"] = &UserClass::luaGetPKTime;
	user_type["setPKTime"] = &UserClass::luaSetPKTime;
	user_type["getX"] = &UserClass::luaGetX;
	user_type["setX"] = &UserClass::luaSetX;
	user_type["getY"] = &UserClass::luaGetY;
	user_type["setY"] = &UserClass::luaSetY;
	user_type["getTX"] = &UserClass::luaGetTX;
	user_type["setTX"] = &UserClass::luaSetTX;
	user_type["getTY"] = &UserClass::luaGetTY;
	user_type["setTY"] = &UserClass::luaSetTY;
	user_type["getMTX"] = &UserClass::luaGetMTX;
	user_type["setMTX"] = &UserClass::luaSetMTX;
	user_type["getMTY"] = &UserClass::luaGetMTY;
	user_type["setMTY"] = &UserClass::luaSetMTY;
	user_type["getMapNumber"] = &UserClass::luaGetMapNumber;
	user_type["setMapNumber"] = &UserClass::luaSetMapNumber;
	user_type["getAuthority"] = &UserClass::luaGetAuthority;
	user_type["setAuthority"] = &UserClass::luaSetAuthority;
	user_type["getAuthorityCode"] = &UserClass::luaGetAuthorityCode;
	user_type["setAuthorityCode"] = &UserClass::luaSetAuthorityCode;
	user_type["getSkin"] = &UserClass::luaGetSkin;
	user_type["setSkin"] = &UserClass::luaSetSkin;
	user_type["getExp"] = &UserClass::luaGetExp;
	user_type["setExp"] = &UserClass::luaSetExp;
	user_type["getTargetState"] = &UserClass::luaGetTargetState;
	user_type["setTargetState"] = &UserClass::luaSetTargetState;
	user_type["getTargetNumber"] = &UserClass::luaGetTargetNumber;
	user_type["setTargetNumber"] = &UserClass::luaSetTargetNumber;
	user_type["getTargetType"] = &UserClass::luaGetTargetType;
	user_type["setTargetType"] = &UserClass::luaSetTargetType;
	user_type["getInterfaceUse"] = &UserClass::luaGetInterfaceUse;
	user_type["setInterfaceUse"] = &UserClass::luaSetInterfaceUse;
	user_type["getInterfaceState"] = &UserClass::luaGetInterfaceState;
	user_type["setInterfaceState"] = &UserClass::luaSetInterfaceState;
	user_type["getInterfaceType"] = &UserClass::luaGetInterfaceType;
	user_type["setInterfaceType"] = &UserClass::luaSetInterfaceType;
	user_type["getDefense"] = &UserClass::luaGetDefense;
	user_type["setDefense"] = &UserClass::luaSetDefense;
	user_type["getSuccessBlock"] = &UserClass::luaGetSuccessBlock;
	user_type["setSuccessBlock"] = &UserClass::luaSetSuccessBlock;
	user_type["getState"] = &UserClass::luaGetState;
	user_type["setState"] = &UserClass::luaSetState;
	user_type["getDieRegen"] = &UserClass::luaGetDieRegen;
	user_type["setDieRegen"] = &UserClass::luaSetDieRegen;
	user_type["getTeleport"] = &UserClass::luaGetTeleport;
	user_type["setTeleport"] = &UserClass::luaSetTeleport;
	user_type["getTargetShopNumber"] = &UserClass::luaGetTargetShopNumber;
	user_type["setTargetShopNumber"] = &UserClass::luaSetTargetShopNumber;
	user_type["getReqWarehouseOpen"] = &UserClass::luaGetReqWarehouseOpen;
	user_type["setReqWarehouseOpen"] = &UserClass::luaSetReqWarehouseOpen;
	user_type["getWarehouseCount"] = &UserClass::luaGetWarehouseCount;
	user_type["setWarehouseCount"] = &UserClass::luaSetWarehouseCount;
	user_type["getDir"] = &UserClass::luaGetDir;
	user_type["setDir"] = &UserClass::luaSetDir;
	user_type["getNextExp"] = &UserClass::luaGetNextExp;
	user_type["setNextExp"] = &UserClass::luaSetNextExp;
	user_type["getLife"] = &UserClass::luaGetLife;
	user_type["setLife"] = &UserClass::luaSetLife;
	user_type["getMana"] = &UserClass::luaGetMana;
	user_type["setMana"] = &UserClass::luaSetMana;
	user_type["getMaxLife"] = &UserClass::luaGetMaxLife;
	user_type["setMaxLife"] = &UserClass::luaSetMaxLife;
	user_type["getMaxMana"] = &UserClass::luaGetMaxMana;
	user_type["setMaxMana"] = &UserClass::luaSetMaxMana;
	user_type["getBP"] = &UserClass::luaGetBP;
	user_type["setBP"] = &UserClass::luaSetBP;
	user_type["getMaxBP"] = &UserClass::luaGetMaxBP;
	user_type["setMaxBP"] = &UserClass::luaSetMaxBP;
	user_type["getVitalityToLife"] = &UserClass::luaGetVitalityToLife;
	user_type["setVitalityToLife"] = &UserClass::luaSetVitalityToLife;
	user_type["getEnergyToMana"] = &UserClass::luaGetEnergyToMana;
	user_type["setEnergyToMana"] = &UserClass::luaSetEnergyToMana;
	user_type["getOption"] = &UserClass::luaGetOption;
	user_type["setOption"] = &UserClass::luaSetOption;
	user_type["getAddLife"] = &UserClass::luaGetAddLife;
	user_type["setAddLife"] = &UserClass::luaSetAddLife;
	user_type["getAddMana"] = &UserClass::luaGetAddMana;
	user_type["setAddMana"] = &UserClass::luaSetAddMana;
	user_type["getAddBP"] = &UserClass::luaGetAddBP;
	user_type["setAddBP"] = &UserClass::luaSetAddBP;
	user_type["getAttackSpeed"] = &UserClass::luaGetAttackSpeed;
	user_type["setAttackSpeed"] = &UserClass::luaSetAttackSpeed;
	user_type["getMagicSpeed"] = &UserClass::luaGetMagicSpeed;
	user_type["setMagicSpeed"] = &UserClass::luaSetMagicSpeed;
	user_type["getMagicDamageMin"] = &UserClass::luaGetMagicDamageMin;
	user_type["setMagicDamageMin"] = &UserClass::luaSetMagicDamageMin;
	user_type["getMagicDamageMax"] = &UserClass::luaGetMagicDamageMax;
	user_type["setMagicDamageMax"] = &UserClass::luaSetMagicDamageMax;
	user_type["getAttackDamageMinLeft"] = &UserClass::luaGetAttackDamageMinLeft;
	user_type["setAttackDamageMinLeft"] = &UserClass::luaSetAttackDamageMinLeft;
	user_type["getAttackDamageMaxLeft"] = &UserClass::luaGetAttackDamageMaxLeft;
	user_type["setAttackDamageMaxLeft"] = &UserClass::luaSetAttackDamageMaxLeft;
	user_type["getAttackDamageMinRight"] = &UserClass::luaGetAttackDamageMinRight;
	user_type["setAttackDamageMinRight"] = &UserClass::luaSetAttackDamageMinRight;
	user_type["getAttackDamageMaxRight"] = &UserClass::luaGetAttackDamageMaxRight;
	user_type["setAttackDamageMaxRight"] = &UserClass::luaSetAttackDamageMaxRight;
	user_type["getRegenTime"] = &UserClass::luaGetRegenTime;
	user_type["setRegenTime"] = &UserClass::luaSetRegenTime;
	user_type["getViewSkillState"] = &UserClass::luaGetViewSkillState;
	user_type["setViewSkillState"] = &UserClass::luaSetViewSkillState;
	user_type["getGetRegen"] = &UserClass::luaGetGetRegen;
	user_type["setGetRegen"] = &UserClass::luaSetGetRegen;
	user_type["getMagicSkill"] = &UserClass::luaGetMagicSkill;
	user_type["setMagicSkill"] = &UserClass::luaSetMagicSkill;
	user_type["getKillerType"] = &UserClass::luaGetKillerType;
	user_type["setKillerType"] = &UserClass::luaSetKillerType;
	user_type["getConnectCheckTime"] = &UserClass::luaGetConnectCheckTime;
	user_type["setConnectCheckTime"] = &UserClass::luaSetConnectCheckTime;
	user_type["getCheckSumTime"] = &UserClass::luaGetCheckSumTime;
	user_type["setCheckSumTime"] = &UserClass::luaSetCheckSumTime;
	user_type["getPathCount"] = &UserClass::luaGetPathCount;
	user_type["setPathCount"] = &UserClass::luaSetPathCount;
	user_type["getRegenMapNumber"] = &UserClass::luaGetRegenMapNumber;
	user_type["setRegenMapNumber"] = &UserClass::luaSetRegenMapNumber;
	user_type["getRegenMapX"] = &UserClass::luaGetRegenMapX;
	user_type["setRegenMapX"] = &UserClass::luaSetRegenMapX;
	user_type["getRegenMapY"] = &UserClass::luaGetRegenMapY;
	user_type["setRegenMapY"] = &UserClass::luaSetRegenMapY;
	user_type["getPathCur"] = &UserClass::luaGetPathCur;
	user_type["setPathCur"] = &UserClass::luaSetPathCur;
	user_type["getPathX"] = &UserClass::luaGetPathX;
	user_type["setPathX"] = &UserClass::luaSetPathX;
	user_type["getPathY"] = &UserClass::luaGetPathY;
	user_type["setPathY"] = &UserClass::luaSetPathY;
	user_type["getPathDir"] = &UserClass::luaGetPathDir;
	user_type["setPathDir"] = &UserClass::luaSetPathDir;
	user_type["getTradeTarget"] = &UserClass::luaGetTradeTarget;
	user_type["setTradeTarget"] = &UserClass::luaSetTradeTarget;
	user_type["getVip"] = &UserClass::luaGetVip;
	user_type["setVip"] = &UserClass::luaSetVip;
	user_type["getReset"] = &UserClass::luaGetReset;
	user_type["setReset"] = &UserClass::luaSetReset;
	user_type["getMasterReset"] = &UserClass::luaGetMasterReset;
	user_type["setMasterReset"] = &UserClass::luaSetMasterReset;
	user_type["getLoginMessageSend"] = &UserClass::luaGetLoginMessageSend;
	user_type["setLoginMessageSend"] = &UserClass::luaSetLoginMessageSend;
	user_type["getLoginMessageCount"] = &UserClass::luaGetLoginMessageCount;
	user_type["setLoginMessageCount"] = &UserClass::luaSetLoginMessageCount;
	user_type["getSendQuestInfo"] = &UserClass::luaGetSendQuestInfo;
	user_type["setSendQuestInfo"] = &UserClass::luaSetSendQuestInfo;
	user_type["getExpRate"] = &UserClass::luaGetExpRate;
	user_type["setExpRate"] = &UserClass::luaSetExpRate;
	user_type["getLanguage"] = &UserClass::getLanguage;
	user_type["getChatLimitTime"] = &UserClass::getChatLimitTime;
	user_type["setChatLimitTime"] = &UserClass::setChatLimitTime;

	//Guild
	user_type["getGuildNumber"] = &UserClass::getGuildNumber;
	user_type["getGuildName"] = &UserClass::getGuildName;
	user_type["getGuildWarDeclareState"] = &UserClass::getGuildWarDeclareState;
	user_type["getGuildWarState"] = &UserClass::getGuildWarState;
	user_type["getGuildWarType"] = &UserClass::getGuildWarType;
	user_type["getGuildTotalScore"] = &UserClass::getGuildTotalScore;

	//Party
	user_type["getPartyNumber"] = &UserClass::getPartyNumber;
	user_type["setPartyNumber"] = &UserClass::setPartyNumber;

	user_type["getSummonIndex"] = &UserClass::getSummonIndex;
	user_type["setSummonIndex"] = &UserClass::setSummonIndex;

	//Auto Reset and auto add point
	user_type["getAutoResetEnable"] = &UserClass::getAutoResetEnable;
	user_type["setAutoResetEnable"] = &UserClass::setAutoResetEnable;

	user_type["getAutoResetStats"] = &UserClass::getAutoResetStats;
	user_type["setAutoResetStats"] = &UserClass::setAutoResetStats;

	user_type["getAutoAddPointCount"] = &UserClass::getAutoAddPointCount;
	user_type["setAutoAddPointCount"] = &UserClass::setAutoAddPointCount;

	user_type["getAutoAddPointStats"] = &UserClass::getAutoAddPointStats;
	user_type["setAutoAddPointStats"] = &UserClass::setAutoAddPointStats;

	//cache player
	user_type["getCacheInt"] = &UserClass::getCacheInt;
	user_type["setCacheInt"] = &UserClass::setCacheInt;
	user_type["clearCacheInt"] = &UserClass::clearCacheInt;

	user_type["getCacheStr"] = &UserClass::getCacheStr;
	user_type["setCacheStr"] = &UserClass::setCacheStr;
	user_type["clearCacheStr"] = &UserClass::clearCacheStr;
}
#endif