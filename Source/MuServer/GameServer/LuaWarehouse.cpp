#include "StdAfx.h"
#include "LuaWareHouse.h"
#include "LuaStack.hpp"
#include "User.h"

class WarehouseClass {
public:
	WarehouseClass() {

	};

	WarehouseClass(int aIndex) {
		this->aIndex = aIndex;
	};

	~WarehouseClass() {

	};

	int getIndex(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Warehouse[slot].m_Index;
		}
		else {
			return -1;
		}
	};

	int isItem(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Warehouse[slot].IsItem();
		}
		else {
			return 0;
		}
	};

	int isExc(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Warehouse[slot].IsExcItem();
		}
		else {
			return 0;
		}
	};

	int getLevel(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Warehouse[slot].m_Level;
		}
		else {
			return 0;
		}
	};

	std::string getName(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Warehouse[slot].GetName();
		}
		else {
			return "Not Find";
		}
	};

	int getSection(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return (gObj[this->aIndex].Warehouse[slot].m_Index / 512);
		}
		else {
			return 0;
		}
	};

	int getIndex2(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return (gObj[this->aIndex].Warehouse[slot].m_Index % 512);
		}
		else {
			return 0;
		}
	};

	DWORD getSerial(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return gObj[this->aIndex].Warehouse[slot].m_Serial;
		}
		else {
			return 0;
		}
	};

	int getItemTable(int slot, int type) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			if (type == 1) {
				return gObj[this->aIndex].Warehouse[slot].m_SkillOption;
			}
			else if (type == 2) {
				return gObj[this->aIndex].Warehouse[slot].m_LuckOption;
			}
			else if (type == 3) {
				return gObj[this->aIndex].Warehouse[slot].m_AddOption;
			}
			else if (type == 4) {
				return gObj[this->aIndex].Warehouse[slot].m_ExceOption;
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
				gObj[this->aIndex].Warehouse[slot].m_SkillOption = value;
			}
			else if (type == 2) {
				gObj[this->aIndex].Warehouse[slot].m_LuckOption = value;
			}
			else if (type == 3) {
				gObj[this->aIndex].Warehouse[slot].m_AddOption = value;
			}
			else if (type == 4) {
				gObj[this->aIndex].Warehouse[slot].m_ExceOption = value;
			}
		}
	};

	int getDurability(int slot) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			return (int)gObj[this->aIndex].Warehouse[slot].m_Durability;
		}
		else {
			return 0;
		}
	};

	void setDurability(int slot, int value) const {
		if (OBJECT_USER_RANGE(this->aIndex)) {
			gObj[this->aIndex].Warehouse[slot].m_Durability = (float)value;
		}
	};

	void convertItem(int slot) const {
		auto lpItem = &gObj[this->aIndex].Warehouse[slot];
		
		if (lpItem) {
			lpItem->Convert(lpItem->m_Index, lpItem->m_SkillOption, lpItem->m_LuckOption, lpItem->m_AddOption, lpItem->m_ExceOption);
		}
	};
private:
	int aIndex;
};

#ifdef OLD_LUA
void RegisterWarehouseClass(lua_State * lua)
{
	luaaa::LuaClass<WarehouseClass> luaWarehouse(lua, "Warehouse");
	luaWarehouse.ctor<int>();
	luaWarehouse.fun("getIndex", &WarehouseClass::getIndex);
	luaWarehouse.fun("isItem", &WarehouseClass::isItem);
	luaWarehouse.fun("isExc", &WarehouseClass::isExc);
	luaWarehouse.fun("getLevel", &WarehouseClass::getLevel);
	luaWarehouse.fun("getName", &WarehouseClass::getName);
	luaWarehouse.fun("getSection", &WarehouseClass::getSection);
	luaWarehouse.fun("getIndex2", &WarehouseClass::getIndex2);
	luaWarehouse.fun("getSerial", &WarehouseClass::getSerial);
	luaWarehouse.fun("getItemTable", &WarehouseClass::getItemTable);
	luaWarehouse.fun("setItemTable", &WarehouseClass::setItemTable);
	luaWarehouse.fun("getDurability", &WarehouseClass::getDurability);
	luaWarehouse.fun("setDurability", &WarehouseClass::setDurability);
	luaWarehouse.fun("convertItem", &WarehouseClass::convertItem);
}
#else
void RegisterWarehouseClass(sol::state& lua)
{
	sol::usertype<WarehouseClass> warehouse_type = lua.new_usertype<WarehouseClass>("Warehouse",
		sol::constructors<WarehouseClass(), WarehouseClass(int)>());

	warehouse_type["getIndex"] = &WarehouseClass::getIndex;
	warehouse_type["isItem"] = &WarehouseClass::isItem;
	warehouse_type["isExc"] = &WarehouseClass::isExc;
	warehouse_type["getLevel"] = &WarehouseClass::getLevel;
	warehouse_type["getName"] = &WarehouseClass::getName;
	warehouse_type["getSection"] = &WarehouseClass::getSection;
	warehouse_type["getIndex2"] = &WarehouseClass::getIndex2;
	warehouse_type["getSerial"] = &WarehouseClass::getSerial;
	warehouse_type["getItemTable"] = &WarehouseClass::getItemTable;
	warehouse_type["setItemTable"] = &WarehouseClass::setItemTable;
	warehouse_type["getDurability"] = &WarehouseClass::getDurability;
	warehouse_type["setDurability"] = &WarehouseClass::setDurability;
	warehouse_type["convertItem"] = &WarehouseClass::convertItem;
}
#endif
