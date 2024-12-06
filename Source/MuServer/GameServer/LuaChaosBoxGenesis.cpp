#include "StdAfx.h"
#include "LuaChaosBox.h"
#include "LuaStack.hpp"
#include "User.h"
#include "LuaChaosBoxGenesis.h"

#ifdef CHAOS_MACHINE_GENESIS
class ChaosBoxGenesisClass {
public:
	ChaosBoxGenesisClass() : aIndex(-1) {

	};

	ChaosBoxGenesisClass(int aIndex) {
		this->aIndex = aIndex;
	};

	~ChaosBoxGenesisClass() {
		this->aIndex = -1;
	};

	int getIndex(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].ChaosBoxGenesis[slot].m_Index;
		}
		else {
			return -1;
		}
	};

	int isItem(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].ChaosBoxGenesis[slot].IsItem();
		}
		else {
			return 0;
		}
	};

	int isExc(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].ChaosBoxGenesis[slot].IsExtItem();
		}
		else {
			return 0;
		}
	};

	int getLevel(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].ChaosBoxGenesis[slot].m_Level;
		}
		else {
			return 0;
		}
	};

	std::string getName(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].ChaosBoxGenesis[slot].GetName();
		}
		else {
			return "Not Find";
		}
	};

	int getSection(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return (gObj[this->aIndex].ChaosBoxGenesis[slot].m_Index / 512);
		}
		else {
			return 0;
		}
	};

	int getIndex2(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return (gObj[this->aIndex].ChaosBoxGenesis[slot].m_Index % 512);
		}
		else {
			return 0;
		}
	};

	int getHasLife(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].ChaosBoxGenesis[slot].IsExtLifeAdd();
		}
		else {
			return 0;
		}
	};

	int getHasMana(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].ChaosBoxGenesis[slot].IsExtManaAdd();
		}
		else {
			return 0;
		}
	};

	DWORD getSerial(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].ChaosBoxGenesis[slot].m_Serial;
		}
		else {
			return 0;
		}
	};

	DWORD getCounter(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].ChaosBoxGenesis[slot].m_DeathSystemKills;
		}
		else {
			return 0;
		}
	};

	int getItemTable(int slot, int type) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			if (type == 1) {
				return gObj[this->aIndex].ChaosBoxGenesis[slot].m_NewOption;
			}
			else if (type == 2) {
				return gObj[this->aIndex].ChaosBoxGenesis[slot].m_Option1;
			}
			else if (type == 3) {
				return gObj[this->aIndex].ChaosBoxGenesis[slot].m_Option2;
			}
			else if (type == 4) {
				return gObj[this->aIndex].ChaosBoxGenesis[slot].m_Option3;
			}
			else if (type == 5) {
				return gObj[this->aIndex].ChaosBoxGenesis[slot].m_SetOption;
			}
			else if (type == 6) {
				return gObj[this->aIndex].ChaosBoxGenesis[slot].m_JewelOfHarmonyOption;
			}
			else if (type == 7) {
				return gObj[this->aIndex].ChaosBoxGenesis[slot].m_ItemOptionEx;
			}
#if (GAMESERVER_UPDATE>=401)
			else if (type == 8) {
				return gObj[this->aIndex].ChaosBoxGenesis[slot].m_SocketOptionBonus;
			}
			else if (type == 9) {
				return gObj[this->aIndex].ChaosBoxGenesis[slot].m_SocketOption[0];
			}
			else if (type == 10) {
				return gObj[this->aIndex].ChaosBoxGenesis[slot].m_SocketOption[1];
			}
			else if (type == 11) {
				return gObj[this->aIndex].ChaosBoxGenesis[slot].m_SocketOption[2];
			}
			else if (type == 12) {
				return gObj[this->aIndex].ChaosBoxGenesis[slot].m_SocketOption[3];
			}
			else if (type == 13) {
				return gObj[this->aIndex].ChaosBoxGenesis[slot].m_SocketOption[4];
			}
#endif
			else {
				return 0;
			}
		}
		else {
			return 0;
		}
	};

	void setItemTable(int slot, int type, int value) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			if (type == 1) {
				gObj[this->aIndex].ChaosBoxGenesis[slot].m_NewOption = value;
			}
			else if (type == 2) {
				gObj[this->aIndex].ChaosBoxGenesis[slot].m_Option1 = value;
			}
			else if (type == 3) {
				gObj[this->aIndex].ChaosBoxGenesis[slot].m_Option2 = value;
			}
			else if (type == 4) {
				gObj[this->aIndex].ChaosBoxGenesis[slot].m_Option3 = value;
			}
			else if (type == 5) {
				gObj[this->aIndex].ChaosBoxGenesis[slot].m_SetOption = value;
			}
			else if (type == 6) {
				gObj[this->aIndex].ChaosBoxGenesis[slot].m_JewelOfHarmonyOption = value;
			}
			else if (type == 7) {
				gObj[this->aIndex].ChaosBoxGenesis[slot].m_ItemOptionEx = value;
			}
#if (GAMESERVER_UPDATE>=401)
			else if (type == 8) {
				gObj[this->aIndex].ChaosBoxGenesis[slot].m_SocketOptionBonus = value;
			}
			else if (type == 9) {
				gObj[this->aIndex].ChaosBoxGenesis[slot].m_SocketOption[0] = value;
			}
			else if (type == 10) {
				gObj[this->aIndex].ChaosBoxGenesis[slot].m_SocketOption[1] = value;
			}
			else if (type == 11) {
				gObj[this->aIndex].ChaosBoxGenesis[slot].m_SocketOption[2] = value;
			}
			else if (type == 12) {
				gObj[this->aIndex].ChaosBoxGenesis[slot].m_SocketOption[3] = value;
			}
			else if (type == 13) {
				gObj[this->aIndex].ChaosBoxGenesis[slot].m_SocketOption[4] = value;
			}
#endif
		}
	};

	int getDurability(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return (int)gObj[this->aIndex].ChaosBoxGenesis[slot].m_Durability;
		}
		else {
			return 0;
		}
	};

	void setDurability(int slot, int value) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			gObj[this->aIndex].ChaosBoxGenesis[slot].m_Durability = (float)value;
		}
	};

	void convertItem(int slot) const {
		auto lpItem = &gObj[this->aIndex].ChaosBoxGenesis[slot];

		if (lpItem) {
			lpItem->Convert(lpItem->m_Index, lpItem->m_Option1, lpItem->m_Option2, lpItem->m_Option3, lpItem->m_NewOption, lpItem->m_SetOption, lpItem->m_JewelOfHarmonyOption, lpItem->m_ItemOptionEx, lpItem->m_SocketOption, lpItem->m_SocketOptionBonus);
		}
	};

	int getIsPeriodic(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].ChaosBoxGenesis[slot].m_IsPeriodicItem;
		}

		return 0;
	};

	DWORD getPeriodicTime(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].ChaosBoxGenesis[slot].m_PeriodicItemTime;
		}

		return 0;
	};

private:
	int aIndex;
};

#ifdef OLD_LUA
void RegisterChaosBoxGenesisClass(lua_State * lua)
{
	luaaa::LuaClass<ChaosBoxGenesisClass> luaChaosBox(lua, "ChaosBoxGenesis");
	luaChaosBox.ctor<int>();
	luaChaosBox.fun("getIndex", &ChaosBoxGenesisClass::getIndex);
	luaChaosBox.fun("isItem", &ChaosBoxGenesisClass::isItem);
	luaChaosBox.fun("isExc", &ChaosBoxGenesisClass::isExc);
	luaChaosBox.fun("getLevel", &ChaosBoxGenesisClass::getLevel);
	luaChaosBox.fun("getName", &ChaosBoxGenesisClass::getName);
	luaChaosBox.fun("getSection", &ChaosBoxGenesisClass::getSection);
	luaChaosBox.fun("getIndex2", &ChaosBoxGenesisClass::getIndex2);
	luaChaosBox.fun("getHasLife", &ChaosBoxGenesisClass::getHasLife);
	luaChaosBox.fun("getHasMana", &ChaosBoxGenesisClass::getHasMana);
	luaChaosBox.fun("getSerial", &ChaosBoxGenesisClass::getSerial);
	luaChaosBox.fun("getItemTable", &ChaosBoxGenesisClass::getItemTable);
	luaChaosBox.fun("setItemTable", &ChaosBoxGenesisClass::setItemTable);
	luaChaosBox.fun("getDurability", &ChaosBoxGenesisClass::getDurability);
	luaChaosBox.fun("setDurability", &ChaosBoxGenesisClass::setDurability);
	luaChaosBox.fun("convertItem", &ChaosBoxGenesisClass::convertItem);
	luaChaosBox.fun("getIsPeriodic", &ChaosBoxGenesisClass::getIsPeriodic);
	luaChaosBox.fun("getPeriodicTime", &ChaosBoxGenesisClass::getPeriodicTime);

#if (GAMESERVER_UPDATE==603)
	luaChaosBox.fun("getCounter", &ChaosBoxGenesisClass::getCounter);
#else
	luaChaosBox.fun("getKills", &ChaosBoxGenesisClass::getCounter);
#endif
}
#else
void RegisterChaosBoxGenesisClass(sol::state& lua)
{
	sol::usertype<ChaosBoxGenesisClass> chaosboxgenesis_type = lua.new_usertype<ChaosBoxGenesisClass>("ChaosBoxGenesis",
		sol::constructors<ChaosBoxGenesisClass(), ChaosBoxGenesisClass(int)>());

	chaosboxgenesis_type["getIndex"] = &ChaosBoxGenesisClass::getIndex;
	chaosboxgenesis_type["isItem"] = &ChaosBoxGenesisClass::isItem;
	chaosboxgenesis_type["isExc"] = &ChaosBoxGenesisClass::isExc;
	chaosboxgenesis_type["getLevel"] = &ChaosBoxGenesisClass::getLevel;
	chaosboxgenesis_type["getName"] = &ChaosBoxGenesisClass::getName;
	chaosboxgenesis_type["getSection"] = &ChaosBoxGenesisClass::getSection;
	chaosboxgenesis_type["getIndex2"] = &ChaosBoxGenesisClass::getIndex2;
	chaosboxgenesis_type["getHasLife"] = &ChaosBoxGenesisClass::getHasLife;
	chaosboxgenesis_type["getHasMana"] = &ChaosBoxGenesisClass::getHasMana;
	chaosboxgenesis_type["getSerial"] = &ChaosBoxGenesisClass::getSerial;
	chaosboxgenesis_type["getItemTable"] = &ChaosBoxGenesisClass::getItemTable;
	chaosboxgenesis_type["setItemTable"] = &ChaosBoxGenesisClass::setItemTable;
	chaosboxgenesis_type["getDurability"] = &ChaosBoxGenesisClass::getDurability;
	chaosboxgenesis_type["setDurability"] = &ChaosBoxGenesisClass::setDurability;
	chaosboxgenesis_type["convertItem"] = &ChaosBoxGenesisClass::convertItem;
	chaosboxgenesis_type["getIsPeriodic"] = &ChaosBoxGenesisClass::getIsPeriodic;
	chaosboxgenesis_type["getPeriodicTime"] = &ChaosBoxGenesisClass::getPeriodicTime;

#if (GAMESERVER_UPDATE==603)
	chaosboxgenesis_type["getCounter"] = &ChaosBoxGenesisClass::getCounter;
#else
	chaosboxgenesis_type["getKills"] = &ChaosBoxGenesisClass::getCounter;
#endif
}
#endif
#endif