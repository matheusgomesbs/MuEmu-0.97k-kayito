#include "StdAfx.h"
#include "LuaTrade.h"
#include "LuaStack.hpp"
#include "User.h"

class TradeClass {
public:
	TradeClass() {

	};

	TradeClass(int aIndex) {
		this->aIndex = aIndex;
	};

	~TradeClass() {

	};

	int getIndex(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Trade[slot].m_Index;
		}
		else {
			return -1;
		}
	};

	int isItem(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Trade[slot].IsItem();
		}
		else {
			return 0;
		}
	};

	int isExc(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Trade[slot].IsExcItem();
		}
		else {
			return 0;
		}
	};

	int getLevel(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Trade[slot].m_Level;
		}
		else {
			return 0;
		}
	};

	std::string getName(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Trade[slot].GetName();
		}
		else {
			return "Not Find";
		}
	};

	int getSection(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return (gObj[this->aIndex].Trade[slot].m_Index / 512);
		}
		else {
			return 0;
		}
	};

	int getIndex2(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return (gObj[this->aIndex].Trade[slot].m_Index % 512);
		}
		else {
			return 0;
		}
	};

	DWORD getSerial(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Trade[slot].m_Serial;
		}
		else {
			return 0;
		}
	};

	int getItemTable(int slot, int type) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			if (type == 1) {
				return gObj[this->aIndex].Trade[slot].m_SkillOption;
			}
			else if (type == 2) {
				return gObj[this->aIndex].Trade[slot].m_LuckOption;
			}
			else if (type == 3) {
				return gObj[this->aIndex].Trade[slot].m_AddOption;
			}
			else if (type == 4) {
				return gObj[this->aIndex].Trade[slot].m_ExceOption;
			}
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
				gObj[this->aIndex].Trade[slot].m_SkillOption = value;
			}
			else if (type == 2) {
				gObj[this->aIndex].Trade[slot].m_LuckOption = value;
			}
			else if (type == 3) {
				gObj[this->aIndex].Trade[slot].m_AddOption = value;
			}
			else if (type == 4) {
				gObj[this->aIndex].Trade[slot].m_ExceOption = value;
			}
		}
	};

	int getDurability(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return (int)gObj[this->aIndex].Trade[slot].m_Durability;
		}
		else {
			return 0;
		}
	};

	void setDurability(int slot, int value) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			gObj[this->aIndex].Trade[slot].m_Durability = (float)value;
		}
	};

	void convertItem(int slot) const {
		auto lpItem = &gObj[this->aIndex].Trade[slot];

		if (lpItem) {
			lpItem->Convert(lpItem->m_Index, lpItem->m_SkillOption, lpItem->m_LuckOption, lpItem->m_AddOption, lpItem->m_ExceOption);
		}
	};

private:
	int aIndex;
};

#ifdef OLD_LUA
void RegisterTradeClass(lua_State * lua)
{
	luaaa::LuaClass<TradeClass> luaTrade(lua, "Trade");
	luaTrade.ctor<int>();
	luaTrade.fun("getIndex", &TradeClass::getIndex);
	luaTrade.fun("isItem", &TradeClass::isItem);
	luaTrade.fun("isExc", &TradeClass::isExc);
	luaTrade.fun("getLevel", &TradeClass::getLevel);
	luaTrade.fun("getName", &TradeClass::getName);
	luaTrade.fun("getSection", &TradeClass::getSection);
	luaTrade.fun("getIndex2", &TradeClass::getIndex2);
	luaTrade.fun("getSerial", &TradeClass::getSerial);
	luaTrade.fun("getItemTable", &TradeClass::getItemTable);
	luaTrade.fun("setItemTable", &TradeClass::setItemTable);
	luaTrade.fun("getDurability", &TradeClass::getDurability);
	luaTrade.fun("setDurability", &TradeClass::setDurability);
	luaTrade.fun("convertItem", &TradeClass::convertItem);
}
#else
void RegisterTradeClass(sol::state& lua)
{
	sol::usertype<TradeClass> trade_type = lua.new_usertype<TradeClass>("Trade",
		sol::constructors<TradeClass(), TradeClass(int)>());

	trade_type["getIndex"] = &TradeClass::getIndex;
	trade_type["isItem"] = &TradeClass::isItem;
	trade_type["isExc"] = &TradeClass::isExc;
	trade_type["getLevel"] = &TradeClass::getLevel;
	trade_type["getName"] = &TradeClass::getName;
	trade_type["getSection"] = &TradeClass::getSection;
	trade_type["getIndex2"] = &TradeClass::getIndex2;
	trade_type["getSerial"] = &TradeClass::getSerial;
	trade_type["getItemTable"] = &TradeClass::getItemTable;
	trade_type["setItemTable"] = &TradeClass::setItemTable;
	trade_type["getDurability"] = &TradeClass::getDurability;
	trade_type["setDurability"] = &TradeClass::setDurability;
	trade_type["convertItem"] = &TradeClass::convertItem;
}
#endif
