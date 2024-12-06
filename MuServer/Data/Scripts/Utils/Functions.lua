--[[ Arquivo de Funções ]]--

MAX_INDEX = 512
MAX_INDEX_BEFORE = 511
MAX_SECTION = 16
MAX_INVENTORY_RANGE = 75

function GET_ITEM(x , y)
if x == nil or type(x) ~= "number" or x > 15 or x < 0 then
		local tcb = debug.traceback()
		LogAddC(2, "Section inválida")
		LogAddC(2, tcb)
		return 0
	end
	
	if y == nil or type(y) ~= "number" or y > 512 or y < 0 then
		local tcb = debug.traceback()
		LogAddC(2, "Index inválida")
		LogAddC(2, tcb)
		return 0
	end
	local item = x * 512 + y
	return item
end

function Distance(x, x2, y, y2)
	return math.sqrt(2^(math.floor(math.abs(x - x2))) + 2^(math.floor(math.abs(y - y2))))
end

function CountTable(table)
	count = 0
	
	for i, name in ipairs(table) do
		count = count + 1
	end
	
	return count
end

function RemoverTable(Tab, Player)
	for i, name in ipairs(Tab) do 
		if name == Player
		then
			table.remove(Tab, i)
		end
	end
end


function RemoverTableInt(table, identif)
	for i, key in ipairs(table) do
		if key == identif
		then
			table.remove(table, i)
		end
	end
end

function has_key(tab, val)
    for index, value in ipairs (tab) do
        if value == val then
            return true
        end
    end

    return false
end

function InsertKey(tab, key)
	table.insert(tab, key)
end

function RemoveKey(tab, key)
	table.remove(tab, key)
end

function GetRand(Start, End)
	return math.random(Start, End)
end