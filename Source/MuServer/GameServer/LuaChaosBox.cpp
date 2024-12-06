#include "StdAfx.h"
#include "LuaChaosBox.h"
#include "LuaStack.hpp"
#include "User.h"
#include "ItemStack.h"

class ChaosBoxClass {
public:
	ChaosBoxClass() {

	};

	ChaosBoxClass(int aIndex) {
		this->aIndex = aIndex;
	};

	~ChaosBoxClass() {

	};

	int getIndex(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].ChaosBox[slot].m_Index;
		}
		else {
			return -1;
		}
	};

	int isItem(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].ChaosBox[slot].IsItem();
		}
		else {
			return 0;
		}
	};

	int isExc(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].ChaosBox[slot].IsExcItem();
		}
		else {
			return 0;
		}
	};

	int getLevel(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].ChaosBox[slot].m_Level;
		}
		else {
			return 0;
		}
	};

	std::string getName(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].ChaosBox[slot].GetName();
		}
		else {
			return "Not Find";
		}
	};

	int getSection(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return (gObj[this->aIndex].ChaosBox[slot].m_Index / 512);
		}
		else {
			return 0;
		}
	};

	int getIndex2(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return (gObj[this->aIndex].ChaosBox[slot].m_Index % 512);
		}
		else {
			return 0;
		}
	};

	DWORD getSerial(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].ChaosBox[slot].m_Serial;
		}
		else {
			return 0;
		}
	};

	int getItemTable(int slot, int type) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			if (type == 1) {
				return gObj[this->aIndex].ChaosBox[slot].m_SkillOption;
			}
			else if (type == 2) {
				return gObj[this->aIndex].ChaosBox[slot].m_LuckOption;
			}
			else if (type == 3) {
				return gObj[this->aIndex].ChaosBox[slot].m_AddOption;
			}
			else if (type == 4) {
				return gObj[this->aIndex].ChaosBox[slot].m_ExceOption;
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
				gObj[this->aIndex].ChaosBox[slot].m_SkillOption = value;
			}
			else if (type == 2) {
				gObj[this->aIndex].ChaosBox[slot].m_LuckOption = value;
			}
			else if (type == 3) {
				gObj[this->aIndex].ChaosBox[slot].m_AddOption = value;
			}
			else if (type == 4) {
				gObj[this->aIndex].ChaosBox[slot].m_ExceOption = value;
			}
		}
	};

	int getDurability(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return (int)gObj[this->aIndex].ChaosBox[slot].m_Durability;
		}
		else {
			return 0;
		}
	};

	void setDurability(int slot, int value) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			gObj[this->aIndex].ChaosBox[slot].m_Durability = (float)value;
		}
	};

	void convertItem(int slot) const {
		auto lpItem = &gObj[this->aIndex].ChaosBox[slot];

		if (lpItem) {
			lpItem->Convert(lpItem->m_Index, lpItem->m_SkillOption, lpItem->m_LuckOption, lpItem->m_AddOption, lpItem->m_ExceOption);
		}
	};

private:
	int aIndex;
};

#ifdef OLD_LUA
void RegisterChaosBoxClass(lua_State * lua)
{
	luaaa::LuaClass<ChaosBoxClass> luaChaosBox(lua, "ChaosBox");
	luaChaosBox.ctor<int>();
	luaChaosBox.fun("getIndex", &ChaosBoxClass::getIndex);
	luaChaosBox.fun("isItem", &ChaosBoxClass::isItem);
	luaChaosBox.fun("isExc", &ChaosBoxClass::isExc);
	luaChaosBox.fun("getLevel", &ChaosBoxClass::getLevel);
	luaChaosBox.fun("getName", &ChaosBoxClass::getName);
	luaChaosBox.fun("getSection", &ChaosBoxClass::getSection);
	luaChaosBox.fun("getIndex2", &ChaosBoxClass::getIndex2);
	luaChaosBox.fun("getSerial", &ChaosBoxClass::getSerial);
	luaChaosBox.fun("getItemTable", &ChaosBoxClass::getItemTable);
	luaChaosBox.fun("setItemTable", &ChaosBoxClass::setItemTable);
	luaChaosBox.fun("getDurability", &ChaosBoxClass::getDurability);
	luaChaosBox.fun("setDurability", &ChaosBoxClass::setDurability);
	luaChaosBox.fun("convertItem", &ChaosBoxClass::convertItem);
}
#else
void RegisterChaosBoxClass(sol::state& lua)
{
	sol::usertype<ChaosBoxClass> chaosbox_type = lua.new_usertype<ChaosBoxClass>("ChaosBox",
		sol::constructors<ChaosBoxClass(), ChaosBoxClass(int)>());

	chaosbox_type["getIndex"] = &ChaosBoxClass::getIndex;
	chaosbox_type["isItem"] = &ChaosBoxClass::isItem;
	chaosbox_type["isExc"] = &ChaosBoxClass::isExc;
	chaosbox_type["getLevel"] = &ChaosBoxClass::getLevel;
	chaosbox_type["getName"] = &ChaosBoxClass::getName;
	chaosbox_type["getSection"] = &ChaosBoxClass::getSection;
	chaosbox_type["getIndex2"] = &ChaosBoxClass::getIndex2;
	chaosbox_type["getSerial"] = &ChaosBoxClass::getSerial;
	chaosbox_type["getItemTable"] = &ChaosBoxClass::getItemTable;
	chaosbox_type["setItemTable"] = &ChaosBoxClass::setItemTable;
	chaosbox_type["getDurability"] = &ChaosBoxClass::getDurability;
	chaosbox_type["setDurability"] = &ChaosBoxClass::setDurability;
	chaosbox_type["convertItem"] = &ChaosBoxClass::convertItem;
}
#endif
