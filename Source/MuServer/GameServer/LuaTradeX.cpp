#include "StdAfx.h"
#include "luaTradeX.h"
#include "LuaStack.hpp"
#include "User.h"

#if (GAMESERVER_UPDATE==201 || GAMESERVER_UPDATE == 603)
class TradeXClass {
public:
	TradeXClass() {

	};

	TradeXClass(int aIndex) {
		this->aIndex = aIndex;
	};

	~TradeXClass() {

	};

	int getIndex(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].TradeX[slot].m_Index;
		}
		else {
			return -1;
		}
	};

	int isItem(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].TradeX[slot].IsItem();
		}
		else {
			return 0;
		}
	};

	int isExc(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].TradeX[slot].IsExtItem();
		}
		else {
			return 0;
		}
	};

	int getLevel(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].TradeX[slot].m_Level;
		}
		else {
			return 0;
		}
	};

	std::string getName(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].TradeX[slot].GetName();
		}
		else {
			return "Not Find";
		}
	};

	int getSection(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return (gObj[this->aIndex].TradeX[slot].m_Index / 512);
		}
		else {
			return 0;
		}
	};

	int getIndex2(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return (gObj[this->aIndex].TradeX[slot].m_Index % 512);
		}
		else {
			return 0;
		}
	};

	int getHasLife(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].TradeX[slot].IsExtLifeAdd();
		}
		else {
			return 0;
		}
	};

	int getHasMana(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].TradeX[slot].IsExtManaAdd();
		}
		else {
			return 0;
		}
	};

	DWORD getSerial(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].TradeX[slot].m_Serial;
		}
		else {
			return 0;
		}
	};

	DWORD getCounter(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].TradeX[slot].m_DeathSystemKills;
		}
		else {
			return 0;
		}
	};

	int getItemTable(int slot, int type) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			if (type == 1) {
				return gObj[this->aIndex].TradeX[slot].m_NewOption;
			}
			else if (type == 2) {
				return gObj[this->aIndex].TradeX[slot].m_Option1;
			}
			else if (type == 3) {
				return gObj[this->aIndex].TradeX[slot].m_Option2;
			}
			else if (type == 4) {
				return gObj[this->aIndex].TradeX[slot].m_Option3;
			}
			else if (type == 5) {
				return gObj[this->aIndex].TradeX[slot].m_SetOption;
			}
			else if (type == 6) {
				return gObj[this->aIndex].TradeX[slot].m_JewelOfHarmonyOption;
			}
			else if (type == 7) {
				return gObj[this->aIndex].TradeX[slot].m_ItemOptionEx;
			}
#if (GAMESERVER_UPDATE>=401)
			else if (type == 8) {
				return gObj[this->aIndex].TradeX[slot].m_SocketOptionBonus;
			}
			else if (type == 9) {
				return gObj[this->aIndex].TradeX[slot].m_SocketOption[0];
			}
			else if (type == 10) {
				return gObj[this->aIndex].TradeX[slot].m_SocketOption[1];
			}
			else if (type == 11) {
				return gObj[this->aIndex].TradeX[slot].m_SocketOption[2];
			}
			else if (type == 12) {
				return gObj[this->aIndex].TradeX[slot].m_SocketOption[3];
			}
			else if (type == 13) {
				return gObj[this->aIndex].TradeX[slot].m_SocketOption[4];
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
				gObj[this->aIndex].TradeX[slot].m_NewOption = value;
			}
			else if (type == 2) {
				gObj[this->aIndex].TradeX[slot].m_Option1 = value;
			}
			else if (type == 3) {
				gObj[this->aIndex].TradeX[slot].m_Option2 = value;
			}
			else if (type == 4) {
				gObj[this->aIndex].TradeX[slot].m_Option3 = value;
			}
			else if (type == 5) {
				gObj[this->aIndex].TradeX[slot].m_SetOption = value;
			}
			else if (type == 6) {
				gObj[this->aIndex].TradeX[slot].m_JewelOfHarmonyOption = value;
			}
			else if (type == 7) {
				gObj[this->aIndex].TradeX[slot].m_ItemOptionEx = value;
			}
#if (GAMESERVER_UPDATE>=401)
			else if (type == 8) {
				gObj[this->aIndex].TradeX[slot].m_SocketOptionBonus = value;
			}
			else if (type == 9) {
				gObj[this->aIndex].TradeX[slot].m_SocketOption[0] = value;
			}
			else if (type == 10) {
				gObj[this->aIndex].TradeX[slot].m_SocketOption[1] = value;
			}
			else if (type == 11) {
				gObj[this->aIndex].TradeX[slot].m_SocketOption[2] = value;
			}
			else if (type == 12) {
				gObj[this->aIndex].TradeX[slot].m_SocketOption[3] = value;
			}
			else if (type == 13) {
				gObj[this->aIndex].TradeX[slot].m_SocketOption[4] = value;
			}
#endif
		}
	};

	int getCoinsRate() const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].CoinsRate;
		}
		else {
			return 0;
		}
	};

	void setCoinsRate(int value) const {
		gObj[this->aIndex].CoinsRate = value;
	};

	int getCoinsExchange(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].CoinsExchange;
		}
		else {
			return 0;
		}
	};

	void setCoinsExchange(int value) const {
		gObj[this->aIndex].CoinsExchange = value;
	};

	int getDurability(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return (int)gObj[this->aIndex].TradeX[slot].m_Durability;
		}
		else {
			return 0;
		}
	};

	void setDurability(int slot, int value) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			gObj[this->aIndex].TradeX[slot].m_Durability = (float)value;
		}
	};

	void convertItem(int slot) const {
		auto lpItem = &gObj[this->aIndex].TradeX[slot];

		if (lpItem) {
			lpItem->Convert(lpItem->m_Index, lpItem->m_Option1, lpItem->m_Option2, lpItem->m_Option3, lpItem->m_NewOption, lpItem->m_SetOption, lpItem->m_JewelOfHarmonyOption, lpItem->m_ItemOptionEx, lpItem->m_SocketOption, lpItem->m_SocketOptionBonus);
		}
	};

	int getIsPeriodic(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].TradeX[slot].m_IsPeriodicItem;
		}

		return 0;
	};

	DWORD getPeriodicTime(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].TradeX[slot].m_PeriodicItemTime;
		}

		return 0;
	};

private:
	int aIndex;
};

#ifdef OLD_LUA
void RegisterTradeXClass(lua_State * lua)
{
	luaaa::LuaClass<TradeXClass> luaTradeX(lua, "TradeX");
	luaTradeX.ctor<int>();
	luaTradeX.fun("getIndex", &TradeXClass::getIndex);
	luaTradeX.fun("isItem", &TradeXClass::isItem);
	luaTradeX.fun("isExc", &TradeXClass::isExc);
	luaTradeX.fun("getLevel", &TradeXClass::getLevel);
	luaTradeX.fun("getName", &TradeXClass::getName);
	luaTradeX.fun("getSection", &TradeXClass::getSection);
	luaTradeX.fun("getIndex2", &TradeXClass::getIndex2);
	luaTradeX.fun("getHasLife", &TradeXClass::getHasLife);
	luaTradeX.fun("getHasMana", &TradeXClass::getHasMana);
	luaTradeX.fun("getSerial", &TradeXClass::getSerial);
	luaTradeX.fun("getItemTable", &TradeXClass::getItemTable);
	luaTradeX.fun("setItemTable", &TradeXClass::setItemTable);
	luaTradeX.fun("getCoinsRate", &TradeXClass::getCoinsRate);
	luaTradeX.fun("setCoinsRate", &TradeXClass::setCoinsRate);
	luaTradeX.fun("getCoinsExchange", &TradeXClass::getCoinsExchange);
	luaTradeX.fun("setCoinsExchange", &TradeXClass::setCoinsExchange);
	luaTradeX.fun("getDurability", &TradeXClass::getDurability);
	luaTradeX.fun("setDurability", &TradeXClass::setDurability);
	luaTradeX.fun("convertItem", &TradeXClass::convertItem);
	luaTradeX.fun("getIsPeriodic", &TradeXClass::getIsPeriodic);
	luaTradeX.fun("getPeriodicTime", &TradeXClass::getPeriodicTime);

#if (GAMESERVER_UPDATE==603)
	luaTradeX.fun("getCounter", &TradeXClass::getCounter);
#else
	luaTradeX.fun("getKills", &TradeXClass::getCounter);
#endif
}
#else
void RegisterTradeXClass(sol::state& lua)
{
	sol::usertype<TradeXClass> tradex_type = lua.new_usertype<TradeXClass>("TradeX",
		sol::constructors<TradeXClass(), TradeXClass(int)>());

	tradex_type["getIndex"] = &TradeXClass::getIndex;
	tradex_type["isItem"] = &TradeXClass::isItem;
	tradex_type["isExc"] = &TradeXClass::isExc;
	tradex_type["getLevel"] = &TradeXClass::getLevel;
	tradex_type["getName"] = &TradeXClass::getName;
	tradex_type["getSection"] = &TradeXClass::getSection;
	tradex_type["getIndex2"] = &TradeXClass::getIndex2;
	tradex_type["getHasLife"] = &TradeXClass::getHasLife;
	tradex_type["getHasMana"] = &TradeXClass::getHasMana;
	tradex_type["getSerial"] = &TradeXClass::getSerial;
	tradex_type["getItemTable"] = &TradeXClass::getItemTable;
	tradex_type["setItemTable"] = &TradeXClass::setItemTable;
	tradex_type["getCoinsRate"] = &TradeXClass::getCoinsRate;
	tradex_type["setCoinsRate"] = &TradeXClass::setCoinsRate;
	tradex_type["getCoinsExchange"] = &TradeXClass::getCoinsExchange;
	tradex_type["setCoinsExchange"] = &TradeXClass::setCoinsExchange;
	tradex_type["getDurability"] = &TradeXClass::getDurability;
	tradex_type["setDurability"] = &TradeXClass::setDurability;
	tradex_type["convertItem"] = &TradeXClass::convertItem;
	tradex_type["getIsPeriodic"] = &TradeXClass::getIsPeriodic;
	tradex_type["getPeriodicTime"] = &TradeXClass::getPeriodicTime;

#if (GAMESERVER_UPDATE==603)
	tradex_type["getCounter"] = &TradeXClass::getCounter;
#else
	tradex_type["getKills"] = &TradeXClass::getCounter;
#endif
}
#endif
#endif