--[[System Ranking View]]--

RankingsView = {}

local RANKING_VIEW_SWITCH = 0
local RANKING_VIEW_MINUTES = 5 -- A X minutos vai aparecer no global ranking...
local RANKING_VIEW_INFOS = {
{Ranking_Value = 1, Ranking_Name = "Top 3 Resets", Ranking_Table = "Character", Ranking_Column = "Resets", Ranking_User = "Name", Ranking_Type = "DESC", Ranking_Count = 3},
{Ranking_Value = 2, Ranking_Name = "Top 3 M.Resets", Ranking_Table = "Character", Ranking_Column = "MResets", Ranking_User = "Name", Ranking_Type = "DESC", Ranking_Count = 3},}

--Variáveis do sistema não mexa!
local RANKING_VIEW_COUNTS = 0
local RANKING_VIEW_NEXT = 1

function RankingsView.PrintRankings()
  if RANKING_VIEW_SWITCH == 0
  then
    return
  end

  for i in ipairs(RANKING_VIEW_INFOS) do
    if RANKING_VIEW_INFOS[i].Ranking_Value == RANKING_VIEW_NEXT
    then
      local rank = RANKING_VIEW_INFOS[i]

      local query = string.format("SELECT TOP %d %s, %s FROM %s ORDER BY %s %s", rank.Ranking_Count, rank.Ranking_Column, rank.Ranking_User, rank.Ranking_Table, rank.Ranking_Column, rank.Ranking_Type)
      CreateAsyncQuery('GetRanking',query, RANKING_VIEW_NEXT, 1)
    end
  end

  RANKING_VIEW_NEXT = RANKING_VIEW_NEXT + 1

  if RANKING_VIEW_NEXT > RANKING_VIEW_COUNTS
  then
    RANKING_VIEW_NEXT = 1
  end
end

function RankingsView.QueryAsyncProcess(queryName, identification, aIndex)
	if queryName == 'GetRanking'
	then
		for i in ipairs(RANKING_VIEW_INFOS) do
			if RANKING_VIEW_INFOS[i].Ranking_Value == aIndex
			then
				local rank = RANKING_VIEW_INFOS[i]

        SendMessageGlobal(string.format("==================="), 0)
        SendMessageGlobal(string.format("%s", rank.Ranking_Name), 0)

        for n = 1, rank.Ranking_Count do
          local result = tonumber(QueryAsyncGetValue(identification, rank.Ranking_Column))
          local name = QueryAsyncGetValue(identification, rank.Ranking_User)

          if result ~= nil and name ~= nil
          then
            SendMessageGlobal(string.format("%dº %s - (%d)", n, name, result), 0)
          end
        end

        SendMessageGlobal(string.format("==================="), 0)

        QueryAsyncDelete(identification)
        return 1
			end
		end
	end
end

function RankingsView.Init()
	if RANKING_VIEW_SWITCH == 0
	then
		return
	end

	GameServerFunctions.QueryAsyncProcess(RankingsView.QueryAsyncProcess)
	
	RANKING_VIEW_COUNTS = CountTable(RANKING_VIEW_INFOS)

	Timer.Interval(RANKING_VIEW_MINUTES * 60, RankingsView.PrintRankings)
end

RankingsView.Init()

return RankingsView