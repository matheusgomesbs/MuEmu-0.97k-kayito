#include "StdAfx.h"
#include "LuaElementSlot.h"
#include "LuaStack.hpp"
#include "User.h"

#if(GAMESERVER_UPDATE==201)
class ElementSlotClass {
public:
	ElementSlotClass() {

	};

	ElementSlotClass(int aIndex) {
		this->aIndex = aIndex;
	};

	~ElementSlotClass() {

	};

	int getIndex(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].ElementSlot[slot].m_Index;
		}
		else {
			return -1;
		}
	};

	int isItem(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].ElementSlot[slot].IsItem();
		}
		else {
			return 0;
		}
	};

	int isExc(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].ElementSlot[slot].IsExtItem();
		}
		else {
			return 0;
		}
	};

	int getLevel(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].ElementSlot[slot].m_Level;
		}
		else {
			return 0;
		}
	};

	std::string getName(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].ElementSlot[slot].GetName();
		}
		else {
			return "Not Find";
		}
	};

	int getSection(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return (gObj[this->aIndex].ElementSlot[slot].m_Index / 512);
		}
		else {
			return 0;
		}
	};

	int getIndex2(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return (gObj[this->aIndex].ElementSlot[slot].m_Index % 512);
		}
		else {
			return 0;
		}
	};

	int getHasLife(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].ElementSlot[slot].IsExtLifeAdd();
		}
		else {
			return 0;
		}
	};

	int getHasMana(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].ElementSlot[slot].IsExtManaAdd();
		}
		else {
			return 0;
		}
	};

	DWORD getSerial(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].ElementSlot[slot].m_Serial;
		}
		else {
			return 0;
		}
	};

	int getItemTable(int slot, int type) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			if (type == 1) {
				return gObj[this->aIndex].ElementSlot[slot].m_NewOption;
			}
			else if (type == 2) {
				return gObj[this->aIndex].ElementSlot[slot].m_Option1;
			}
			else if (type == 3) {
				return gObj[this->aIndex].ElementSlot[slot].m_Option2;
			}
			else if (type == 4) {
				return gObj[this->aIndex].ElementSlot[slot].m_Option3;
			}
			else if (type == 5) {
				return gObj[this->aIndex].ElementSlot[slot].m_SetOption;
			}
			else if (type == 6) {
				return gObj[this->aIndex].ElementSlot[slot].m_JewelOfHarmonyOption;
			}
			else if (type == 7) {
				return gObj[this->aIndex].ElementSlot[slot].m_ItemOptionEx;
			}
#if (GAMESERVER_UPDATE>=401)
			else if (type == 8) {
				return gObj[this->aIndex].ElementSlot[slot].m_SocketOptionBonus;
			}
			else if (type == 9) {
				return gObj[this->aIndex].ElementSlot[slot].m_SocketOption[0];
			}
			else if (type == 10) {
				return gObj[this->aIndex].ElementSlot[slot].m_SocketOption[1];
			}
			else if (type == 11) {
				return gObj[this->aIndex].ElementSlot[slot].m_SocketOption[2];
			}
			else if (type == 12) {
				return gObj[this->aIndex].ElementSlot[slot].m_SocketOption[3];
			}
			else if (type == 13) {
				return gObj[this->aIndex].ElementSlot[slot].m_SocketOption[4];
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
				gObj[this->aIndex].ElementSlot[slot].m_NewOption = value;
			}
			else if (type == 2) {
				gObj[this->aIndex].ElementSlot[slot].m_Option1 = value;
			}
			else if (type == 3) {
				gObj[this->aIndex].ElementSlot[slot].m_Option2 = value;
			}
			else if (type == 4) {
				gObj[this->aIndex].ElementSlot[slot].m_Option3 = value;
			}
			else if (type == 5) {
				gObj[this->aIndex].ElementSlot[slot].m_SetOption = value;
			}
			else if (type == 6) {
				gObj[this->aIndex].ElementSlot[slot].m_JewelOfHarmonyOption = value;
			}
			else if (type == 7) {
				gObj[this->aIndex].ElementSlot[slot].m_ItemOptionEx = value;
			}
#if (GAMESERVER_UPDATE>=401)
			else if (type == 8) {
				gObj[this->aIndex].ElementSlot[slot].m_SocketOptionBonus = value;
			}
			else if (type == 9) {
				gObj[this->aIndex].ElementSlot[slot].m_SocketOption[0] = value;
			}
			else if (type == 10) {
				gObj[this->aIndex].ElementSlot[slot].m_SocketOption[1] = value;
			}
			else if (type == 11) {
				gObj[this->aIndex].ElementSlot[slot].m_SocketOption[2] = value;
			}
			else if (type == 12) {
				gObj[this->aIndex].ElementSlot[slot].m_SocketOption[3] = value;
			}
			else if (type == 13) {
				gObj[this->aIndex].ElementSlot[slot].m_SocketOption[4] = value;
			}
#endif
		}
	};

	int getDurability(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return (int)gObj[this->aIndex].ElementSlot[slot].m_Durability;
		}
		else {
			return 0;
		}
	};

	void setDurability(int slot, int value) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			gObj[this->aIndex].ElementSlot[slot].m_Durability = (float)value;
		}
	};

	void convertItem(int slot) const {
		auto lpItem = &gObj[this->aIndex].ElementSlot[slot];

		if (lpItem) {
			lpItem->Convert(lpItem->m_Index, lpItem->m_Option1, lpItem->m_Option2, lpItem->m_Option3, lpItem->m_NewOption, lpItem->m_SetOption, lpItem->m_JewelOfHarmonyOption, lpItem->m_ItemOptionEx, lpItem->m_SocketOption, lpItem->m_SocketOptionBonus);
		}
	};

private:
	int aIndex;
};

#ifdef OLD_LUA
void RegisterElementSlotClass(lua_State * lua)
{
	luaaa::LuaClass<ElementSlotClass> luaElementSlot(lua, "ElementSlot");
	luaElementSlot.ctor<int>();
	luaElementSlot.fun("getIndex", &ElementSlotClass::getIndex);
	luaElementSlot.fun("isItem", &ElementSlotClass::isItem);
	luaElementSlot.fun("isExc", &ElementSlotClass::isExc);
	luaElementSlot.fun("getLevel", &ElementSlotClass::getLevel);
	luaElementSlot.fun("getName", &ElementSlotClass::getName);
	luaElementSlot.fun("getSection", &ElementSlotClass::getSection);
	luaElementSlot.fun("getIndex2", &ElementSlotClass::getIndex2);
	luaElementSlot.fun("getHasLife", &ElementSlotClass::getHasLife);
	luaElementSlot.fun("getHasMana", &ElementSlotClass::getHasMana);
	luaElementSlot.fun("getSerial", &ElementSlotClass::getSerial);
	luaElementSlot.fun("getItemTable", &ElementSlotClass::getItemTable);
	luaElementSlot.fun("setItemTable", &ElementSlotClass::setItemTable);
	luaElementSlot.fun("getDurability", &ElementSlotClass::getDurability);
	luaElementSlot.fun("setDurability", &ElementSlotClass::setDurability);
	luaElementSlot.fun("convertItem", &ElementSlotClass::convertItem);
}
#else
void RegisterElementSlotClass(sol::state& lua) {
	sol::usertype<ElementSlotClass> elementslot_type = lua.new_usertype<ElementSlotClass>("ElementSlot",
		sol::constructors<ElementSlotClass(), ElementSlotClass(int)>());

	elementslot_type["getIndex"] = &ElementSlotClass::getIndex;
	elementslot_type["isItem"] = &ElementSlotClass::isItem;
	elementslot_type["isExc"] = &ElementSlotClass::isExc;
	elementslot_type["getLevel"] = &ElementSlotClass::getLevel;
	elementslot_type["getName"] = &ElementSlotClass::getName;
	elementslot_type["getSection"] = &ElementSlotClass::getSection;
	elementslot_type["getIndex2"] = &ElementSlotClass::getIndex2;
	elementslot_type["getHasLife"] = &ElementSlotClass::getHasLife;
	elementslot_type["getHasMana"] = &ElementSlotClass::getHasMana;
	elementslot_type["getSerial"] = &ElementSlotClass::getSerial;
	elementslot_type["getItemTable"] = &ElementSlotClass::getItemTable;
	elementslot_type["setItemTable"] = &ElementSlotClass::setItemTable;
	elementslot_type["getDurability"] = &ElementSlotClass::getDurability;
	elementslot_type["setDurability"] = &ElementSlotClass::setDurability;
	elementslot_type["convertItem"] = &ElementSlotClass::convertItem;
}
#endif
#endif
