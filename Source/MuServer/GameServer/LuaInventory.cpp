#include "StdAfx.h"
#include "LuaInventory.h"
#include "LuaStack.hpp"
#include "User.h"
#include "ServerInfo.h"
#include "Util.h"

class InventoryClass {
public:
	InventoryClass() : aIndex(0) {

	};

	InventoryClass(int aIndex) {
		this->aIndex = aIndex;
	};

	~InventoryClass() {

	};

	int getIndex(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Inventory[slot].m_Index;
		}
		else {
			return -1;
		}
	};

	int isItem(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Inventory[slot].IsItem();
		}
		else {
			return 0;
		}
	};

	int isExc(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Inventory[slot].IsExcItem();
		}
		else {
			return 0;
		}
	};

	int getLevel(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Inventory[slot].m_Level;
		}
		else {
			return 0;
		}
	};

	std::string getName(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Inventory[slot].GetName();
		}
		else {
			return "Not Find";
		}
	};

	int getSection(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return (gObj[this->aIndex].Inventory[slot].m_Index / 512);
		}
		else {
			return 0;
		}
	};

	int getIndex2(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return (gObj[this->aIndex].Inventory[slot].m_Index % 512);
		}
		else {
			return 0;
		}
	};

	DWORD getSerial(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Inventory[slot].m_Serial;
		}
		else {
			return 0;
		}
	};

	int getItemTable(int slot, int type) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			if (type == 1) {
				return gObj[this->aIndex].Inventory[slot].m_SkillOption;
			}
			else if (type == 2) {
				return gObj[this->aIndex].Inventory[slot].m_LuckOption;
			}
			else if (type == 3) {
				return gObj[this->aIndex].Inventory[slot].m_AddOption;
			}
			else if (type == 4) {
				return gObj[this->aIndex].Inventory[slot].m_ExceOption;
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
				gObj[this->aIndex].Inventory[slot].m_SkillOption = value;
			}
			else if (type == 2) {
				gObj[this->aIndex].Inventory[slot].m_LuckOption = value;
			}
			else if (type == 3) {
				gObj[this->aIndex].Inventory[slot].m_AddOption = value;
			}
			else if (type == 4) {
				gObj[this->aIndex].Inventory[slot].m_ExceOption = value;
			}
		}
	};

	int getDurability(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return (int)gObj[this->aIndex].Inventory[slot].m_Durability;
		}
		else {
			return 0;
		}
	};

	void setDurability(int slot, int value) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			gObj[this->aIndex].Inventory[slot].m_Durability = (float)value;
		}
	};

	void convertItem(int slot) const {
		auto lpItem = &gObj[this->aIndex].Inventory[slot];

		if (lpItem) {
			lpItem->Convert(lpItem->m_Index, lpItem->m_SkillOption, lpItem->m_LuckOption, lpItem->m_AddOption, lpItem->m_ExceOption);
		}
	};

private:
	int aIndex;
};

#ifdef OLD_LUA
void RegisterInventoryClass(lua_State * lua)
{
	luaaa::LuaClass<InventoryClass> luaInventory(lua, "Inventory");
	luaInventory.ctor<int>();
	luaInventory.fun("getIndex", &InventoryClass::getIndex);
	luaInventory.fun("isItem", &InventoryClass::isItem);
	luaInventory.fun("isExc", &InventoryClass::isExc);
	luaInventory.fun("getLevel", &InventoryClass::getLevel);
	luaInventory.fun("getName", &InventoryClass::getName);
	luaInventory.fun("getSection", &InventoryClass::getSection);
	luaInventory.fun("getIndex2", &InventoryClass::getIndex2);
	luaInventory.fun("getSerial", &InventoryClass::getSerial);
	luaInventory.fun("getItemTable", &InventoryClass::getItemTable);
	luaInventory.fun("setItemTable", &InventoryClass::setItemTable);
	luaInventory.fun("getDurability", &InventoryClass::getDurability);
	luaInventory.fun("setDurability", &InventoryClass::setDurability);
	luaInventory.fun("convertItem", &InventoryClass::convertItem);
}
#else
void RegisterInventoryClass(sol::state& lua)
{
	sol::usertype<InventoryClass> inventory_type = lua.new_usertype<InventoryClass>("Inventory",
		sol::constructors<InventoryClass(), InventoryClass(int)>());

	inventory_type["getIndex"] = &InventoryClass::getIndex;
	inventory_type["isItem"] = &InventoryClass::isItem;
	inventory_type["isExc"] = &InventoryClass::isExc;
	inventory_type["getLevel"] = &InventoryClass::getLevel;
	inventory_type["getName"] = &InventoryClass::getName;
	inventory_type["getSection"] = &InventoryClass::getSection;
	inventory_type["getIndex2"] = &InventoryClass::getIndex2;
	inventory_type["getSerial"] = &InventoryClass::getSerial;
	inventory_type["getItemTable"] = &InventoryClass::getItemTable;
	inventory_type["setItemTable"] = &InventoryClass::setItemTable;
	inventory_type["getDurability"] = &InventoryClass::getDurability;
	inventory_type["setDurability"] = &InventoryClass::setDurability;
	inventory_type["convertItem"] = &InventoryClass::convertItem;
}
#endif
