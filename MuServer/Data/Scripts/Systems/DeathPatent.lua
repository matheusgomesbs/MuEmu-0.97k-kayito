DeathPatent = {}

local DEATH_PATENT_SWITCH = 1

local DEATH_PATENT_INFO = {

-- SWORD OF DEATH 

{Attack = GET_ITEM(0, 51), UseRingPendant = false, Ring01 = GET_ITEM(13, 157), Ring02 = GET_ITEM(13, 157), Pendant = GET_ITEM(13, 158)},
{Attack = GET_ITEM(0, 51), UseRingPendant = false, Ring01 = GET_ITEM(13, 148), Ring02 = GET_ITEM(13, 148), Pendant = GET_ITEM(13, 146)},
{Attack = GET_ITEM(0, 51), UseRingPendant = false, Ring01 = GET_ITEM(13, 149), Ring02 = GET_ITEM(13, 149), Pendant = GET_ITEM(13, 150)},
{Attack = GET_ITEM(0, 51), UseRingPendant = false, Ring01 = GET_ITEM(13, 151), Ring02 = GET_ITEM(13, 151), Pendant = GET_ITEM(13, 152)},
{Attack = GET_ITEM(0, 51), UseRingPendant = false, Ring01 = GET_ITEM(13, 153), Ring02 = GET_ITEM(13, 153), Pendant = GET_ITEM(13, 154)},
{Attack = GET_ITEM(0, 51), UseRingPendant = false, Ring01 = GET_ITEM(13, 155), Ring02 = GET_ITEM(13, 155), Pendant = GET_ITEM(13, 156)},
{Attack = GET_ITEM(0, 51), UseRingPendant = false, Ring01 = GET_ITEM(13, 159), Ring02 = GET_ITEM(13, 159), Pendant = GET_ITEM(13, 160)},
{Attack = GET_ITEM(0, 51), UseRingPendant = false, Ring01 = GET_ITEM(13, 162), Ring02 = GET_ITEM(13, 162), Pendant = GET_ITEM(13, 161)},
{Attack = GET_ITEM(0, 51), UseRingPendant = false, Ring01 = GET_ITEM(13, 170), Ring02 = GET_ITEM(13, 170), Pendant = GET_ITEM(13, 163)},
{Attack = GET_ITEM(0, 51), UseRingPendant = false, Ring01 = GET_ITEM(13, 171), Ring02 = GET_ITEM(13, 171), Pendant = GET_ITEM(13, 172)},

-- SWORD OF HEAT 

{Attack = GET_ITEM(0, 53), UseRingPendant = false, Ring01 = GET_ITEM(13, 157), Ring02 = GET_ITEM(13, 157), Pendant = GET_ITEM(13, 158)},
{Attack = GET_ITEM(0, 53), UseRingPendant = false, Ring01 = GET_ITEM(13, 148), Ring02 = GET_ITEM(13, 148), Pendant = GET_ITEM(13, 146)},
{Attack = GET_ITEM(0, 53), UseRingPendant = false, Ring01 = GET_ITEM(13, 149), Ring02 = GET_ITEM(13, 149), Pendant = GET_ITEM(13, 150)},
{Attack = GET_ITEM(0, 53), UseRingPendant = false, Ring01 = GET_ITEM(13, 151), Ring02 = GET_ITEM(13, 151), Pendant = GET_ITEM(13, 152)},
{Attack = GET_ITEM(0, 53), UseRingPendant = false, Ring01 = GET_ITEM(13, 153), Ring02 = GET_ITEM(13, 153), Pendant = GET_ITEM(13, 154)},
{Attack = GET_ITEM(0, 53), UseRingPendant = false, Ring01 = GET_ITEM(13, 155), Ring02 = GET_ITEM(13, 155), Pendant = GET_ITEM(13, 156)},
{Attack = GET_ITEM(0, 53), UseRingPendant = false, Ring01 = GET_ITEM(13, 159), Ring02 = GET_ITEM(13, 159), Pendant = GET_ITEM(13, 160)},
{Attack = GET_ITEM(0, 53), UseRingPendant = false, Ring01 = GET_ITEM(13, 162), Ring02 = GET_ITEM(13, 162), Pendant = GET_ITEM(13, 161)},
{Attack = GET_ITEM(0, 53), UseRingPendant = false, Ring01 = GET_ITEM(13, 170), Ring02 = GET_ITEM(13, 170), Pendant = GET_ITEM(13, 163)},
{Attack = GET_ITEM(0, 53), UseRingPendant = false, Ring01 = GET_ITEM(13, 171), Ring02 = GET_ITEM(13, 171), Pendant = GET_ITEM(13, 172)},

-- SWORD OF EVOLUTION 

{Attack = GET_ITEM(0, 58), UseRingPendant = false, Ring01 = GET_ITEM(13, 157), Ring02 = GET_ITEM(13, 157), Pendant = GET_ITEM(13, 158)},
{Attack = GET_ITEM(0, 58), UseRingPendant = false, Ring01 = GET_ITEM(13, 148), Ring02 = GET_ITEM(13, 148), Pendant = GET_ITEM(13, 146)},
{Attack = GET_ITEM(0, 58), UseRingPendant = false, Ring01 = GET_ITEM(13, 149), Ring02 = GET_ITEM(13, 149), Pendant = GET_ITEM(13, 150)},
{Attack = GET_ITEM(0, 58), UseRingPendant = false, Ring01 = GET_ITEM(13, 151), Ring02 = GET_ITEM(13, 151), Pendant = GET_ITEM(13, 152)},
{Attack = GET_ITEM(0, 58), UseRingPendant = false, Ring01 = GET_ITEM(13, 153), Ring02 = GET_ITEM(13, 153), Pendant = GET_ITEM(13, 154)},
{Attack = GET_ITEM(0, 58), UseRingPendant = false, Ring01 = GET_ITEM(13, 155), Ring02 = GET_ITEM(13, 155), Pendant = GET_ITEM(13, 156)},
{Attack = GET_ITEM(0, 58), UseRingPendant = false, Ring01 = GET_ITEM(13, 159), Ring02 = GET_ITEM(13, 159), Pendant = GET_ITEM(13, 160)},
{Attack = GET_ITEM(0, 58), UseRingPendant = false, Ring01 = GET_ITEM(13, 162), Ring02 = GET_ITEM(13, 162), Pendant = GET_ITEM(13, 161)},
{Attack = GET_ITEM(0, 58), UseRingPendant = false, Ring01 = GET_ITEM(13, 170), Ring02 = GET_ITEM(13, 170), Pendant = GET_ITEM(13, 163)},
{Attack = GET_ITEM(0, 58), UseRingPendant = false, Ring01 = GET_ITEM(13, 171), Ring02 = GET_ITEM(13, 171), Pendant = GET_ITEM(13, 172)},

-- SWORD OF HOLLY NIGHT 

{Attack = GET_ITEM(0, 50), UseRingPendant = false, Ring01 = GET_ITEM(13, 157), Ring02 = GET_ITEM(13, 157), Pendant = GET_ITEM(13, 158)},
{Attack = GET_ITEM(0, 50), UseRingPendant = false, Ring01 = GET_ITEM(13, 148), Ring02 = GET_ITEM(13, 148), Pendant = GET_ITEM(13, 146)},
{Attack = GET_ITEM(0, 50), UseRingPendant = false, Ring01 = GET_ITEM(13, 149), Ring02 = GET_ITEM(13, 149), Pendant = GET_ITEM(13, 150)},
{Attack = GET_ITEM(0, 50), UseRingPendant = false, Ring01 = GET_ITEM(13, 151), Ring02 = GET_ITEM(13, 151), Pendant = GET_ITEM(13, 152)},
{Attack = GET_ITEM(0, 50), UseRingPendant = false, Ring01 = GET_ITEM(13, 153), Ring02 = GET_ITEM(13, 153), Pendant = GET_ITEM(13, 154)},
{Attack = GET_ITEM(0, 50), UseRingPendant = false, Ring01 = GET_ITEM(13, 155), Ring02 = GET_ITEM(13, 155), Pendant = GET_ITEM(13, 156)},
{Attack = GET_ITEM(0, 50), UseRingPendant = false, Ring01 = GET_ITEM(13, 159), Ring02 = GET_ITEM(13, 159), Pendant = GET_ITEM(13, 160)},
{Attack = GET_ITEM(0, 50), UseRingPendant = false, Ring01 = GET_ITEM(13, 162), Ring02 = GET_ITEM(13, 162), Pendant = GET_ITEM(13, 161)},
{Attack = GET_ITEM(0, 50), UseRingPendant = false, Ring01 = GET_ITEM(13, 170), Ring02 = GET_ITEM(13, 170), Pendant = GET_ITEM(13, 163)},
{Attack = GET_ITEM(0, 50), UseRingPendant = false, Ring01 = GET_ITEM(13, 171), Ring02 = GET_ITEM(13, 171), Pendant = GET_ITEM(13, 172)},

-- SWORD OF SNOW BLACK

{Attack = GET_ITEM(0, 38), UseRingPendant = false, Ring01 = GET_ITEM(13, 157), Ring02 = GET_ITEM(13, 157), Pendant = GET_ITEM(13, 158)},
{Attack = GET_ITEM(0, 38), UseRingPendant = false, Ring01 = GET_ITEM(13, 148), Ring02 = GET_ITEM(13, 148), Pendant = GET_ITEM(13, 146)},
{Attack = GET_ITEM(0, 38), UseRingPendant = false, Ring01 = GET_ITEM(13, 149), Ring02 = GET_ITEM(13, 149), Pendant = GET_ITEM(13, 150)},
{Attack = GET_ITEM(0, 38), UseRingPendant = false, Ring01 = GET_ITEM(13, 151), Ring02 = GET_ITEM(13, 151), Pendant = GET_ITEM(13, 152)},
{Attack = GET_ITEM(0, 38), UseRingPendant = false, Ring01 = GET_ITEM(13, 153), Ring02 = GET_ITEM(13, 153), Pendant = GET_ITEM(13, 154)},
{Attack = GET_ITEM(0, 38), UseRingPendant = false, Ring01 = GET_ITEM(13, 155), Ring02 = GET_ITEM(13, 155), Pendant = GET_ITEM(13, 156)},
{Attack = GET_ITEM(0, 38), UseRingPendant = false, Ring01 = GET_ITEM(13, 159), Ring02 = GET_ITEM(13, 159), Pendant = GET_ITEM(13, 160)},
{Attack = GET_ITEM(0, 38), UseRingPendant = false, Ring01 = GET_ITEM(13, 162), Ring02 = GET_ITEM(13, 162), Pendant = GET_ITEM(13, 161)},
{Attack = GET_ITEM(0, 38), UseRingPendant = false, Ring01 = GET_ITEM(13, 170), Ring02 = GET_ITEM(13, 170), Pendant = GET_ITEM(13, 163)},
{Attack = GET_ITEM(0, 38), UseRingPendant = false, Ring01 = GET_ITEM(13, 171), Ring02 = GET_ITEM(13, 171), Pendant = GET_ITEM(13, 172)},

-- SWORD OF LIGHT GRIFFIN

{Attack = GET_ITEM(0, 39), UseRingPendant = false, Ring01 = GET_ITEM(13, 157), Ring02 = GET_ITEM(13, 157), Pendant = GET_ITEM(13, 158)},
{Attack = GET_ITEM(0, 39), UseRingPendant = false, Ring01 = GET_ITEM(13, 148), Ring02 = GET_ITEM(13, 148), Pendant = GET_ITEM(13, 146)},
{Attack = GET_ITEM(0, 39), UseRingPendant = false, Ring01 = GET_ITEM(13, 149), Ring02 = GET_ITEM(13, 149), Pendant = GET_ITEM(13, 150)},
{Attack = GET_ITEM(0, 39), UseRingPendant = false, Ring01 = GET_ITEM(13, 151), Ring02 = GET_ITEM(13, 151), Pendant = GET_ITEM(13, 152)},
{Attack = GET_ITEM(0, 39), UseRingPendant = false, Ring01 = GET_ITEM(13, 153), Ring02 = GET_ITEM(13, 153), Pendant = GET_ITEM(13, 154)},
{Attack = GET_ITEM(0, 39), UseRingPendant = false, Ring01 = GET_ITEM(13, 155), Ring02 = GET_ITEM(13, 155), Pendant = GET_ITEM(13, 156)},
{Attack = GET_ITEM(0, 39), UseRingPendant = false, Ring01 = GET_ITEM(13, 159), Ring02 = GET_ITEM(13, 159), Pendant = GET_ITEM(13, 160)},
{Attack = GET_ITEM(0, 39), UseRingPendant = false, Ring01 = GET_ITEM(13, 162), Ring02 = GET_ITEM(13, 162), Pendant = GET_ITEM(13, 161)},
{Attack = GET_ITEM(0, 39), UseRingPendant = false, Ring01 = GET_ITEM(13, 170), Ring02 = GET_ITEM(13, 170), Pendant = GET_ITEM(13, 163)},
{Attack = GET_ITEM(0, 39), UseRingPendant = false, Ring01 = GET_ITEM(13, 171), Ring02 = GET_ITEM(13, 171), Pendant = GET_ITEM(13, 172)},


-- SWORD OF 01-X

{Attack = GET_ITEM(0, 62), UseRingPendant = false, Ring01 = GET_ITEM(13, 157), Ring02 = GET_ITEM(13, 157), Pendant = GET_ITEM(13, 158)},
{Attack = GET_ITEM(0, 62), UseRingPendant = false, Ring01 = GET_ITEM(13, 148), Ring02 = GET_ITEM(13, 148), Pendant = GET_ITEM(13, 146)},
{Attack = GET_ITEM(0, 62), UseRingPendant = false, Ring01 = GET_ITEM(13, 149), Ring02 = GET_ITEM(13, 149), Pendant = GET_ITEM(13, 150)},
{Attack = GET_ITEM(0, 62), UseRingPendant = false, Ring01 = GET_ITEM(13, 151), Ring02 = GET_ITEM(13, 151), Pendant = GET_ITEM(13, 152)},
{Attack = GET_ITEM(0, 62), UseRingPendant = false, Ring01 = GET_ITEM(13, 153), Ring02 = GET_ITEM(13, 153), Pendant = GET_ITEM(13, 154)},
{Attack = GET_ITEM(0, 62), UseRingPendant = false, Ring01 = GET_ITEM(13, 155), Ring02 = GET_ITEM(13, 155), Pendant = GET_ITEM(13, 156)},
{Attack = GET_ITEM(0, 62), UseRingPendant = false, Ring01 = GET_ITEM(13, 159), Ring02 = GET_ITEM(13, 159), Pendant = GET_ITEM(13, 160)},
{Attack = GET_ITEM(0, 62), UseRingPendant = false, Ring01 = GET_ITEM(13, 162), Ring02 = GET_ITEM(13, 162), Pendant = GET_ITEM(13, 161)},
{Attack = GET_ITEM(0, 62), UseRingPendant = false, Ring01 = GET_ITEM(13, 170), Ring02 = GET_ITEM(13, 170), Pendant = GET_ITEM(13, 163)},
{Attack = GET_ITEM(0, 62), UseRingPendant = false, Ring01 = GET_ITEM(13, 171), Ring02 = GET_ITEM(13, 171), Pendant = GET_ITEM(13, 172)},


-- SWORD SCARY

{Attack = GET_ITEM(0, 63), UseRingPendant = false, Ring01 = GET_ITEM(13, 157), Ring02 = GET_ITEM(13, 157), Pendant = GET_ITEM(13, 158)},
{Attack = GET_ITEM(0, 63), UseRingPendant = false, Ring01 = GET_ITEM(13, 148), Ring02 = GET_ITEM(13, 148), Pendant = GET_ITEM(13, 146)},
{Attack = GET_ITEM(0, 63), UseRingPendant = false, Ring01 = GET_ITEM(13, 149), Ring02 = GET_ITEM(13, 149), Pendant = GET_ITEM(13, 150)},
{Attack = GET_ITEM(0, 63), UseRingPendant = false, Ring01 = GET_ITEM(13, 151), Ring02 = GET_ITEM(13, 151), Pendant = GET_ITEM(13, 152)},
{Attack = GET_ITEM(0, 63), UseRingPendant = false, Ring01 = GET_ITEM(13, 153), Ring02 = GET_ITEM(13, 153), Pendant = GET_ITEM(13, 154)},
{Attack = GET_ITEM(0, 63), UseRingPendant = false, Ring01 = GET_ITEM(13, 155), Ring02 = GET_ITEM(13, 155), Pendant = GET_ITEM(13, 156)},
{Attack = GET_ITEM(0, 63), UseRingPendant = false, Ring01 = GET_ITEM(13, 159), Ring02 = GET_ITEM(13, 159), Pendant = GET_ITEM(13, 160)},
{Attack = GET_ITEM(0, 63), UseRingPendant = false, Ring01 = GET_ITEM(13, 162), Ring02 = GET_ITEM(13, 162), Pendant = GET_ITEM(13, 161)},
{Attack = GET_ITEM(0, 63), UseRingPendant = false, Ring01 = GET_ITEM(13, 170), Ring02 = GET_ITEM(13, 170), Pendant = GET_ITEM(13, 163)},
{Attack = GET_ITEM(0, 63), UseRingPendant = false, Ring01 = GET_ITEM(13, 171), Ring02 = GET_ITEM(13, 171), Pendant = GET_ITEM(13, 172)},


-- SWORD WAR

{Attack = GET_ITEM(0, 64), UseRingPendant = false, Ring01 = GET_ITEM(13, 157), Ring02 = GET_ITEM(13, 157), Pendant = GET_ITEM(13, 158)},
{Attack = GET_ITEM(0, 64), UseRingPendant = false, Ring01 = GET_ITEM(13, 148), Ring02 = GET_ITEM(13, 148), Pendant = GET_ITEM(13, 146)},
{Attack = GET_ITEM(0, 64), UseRingPendant = false, Ring01 = GET_ITEM(13, 149), Ring02 = GET_ITEM(13, 149), Pendant = GET_ITEM(13, 150)},
{Attack = GET_ITEM(0, 64), UseRingPendant = false, Ring01 = GET_ITEM(13, 151), Ring02 = GET_ITEM(13, 151), Pendant = GET_ITEM(13, 152)},
{Attack = GET_ITEM(0, 64), UseRingPendant = false, Ring01 = GET_ITEM(13, 153), Ring02 = GET_ITEM(13, 153), Pendant = GET_ITEM(13, 154)},
{Attack = GET_ITEM(0, 64), UseRingPendant = false, Ring01 = GET_ITEM(13, 155), Ring02 = GET_ITEM(13, 155), Pendant = GET_ITEM(13, 156)},
{Attack = GET_ITEM(0, 64), UseRingPendant = false, Ring01 = GET_ITEM(13, 159), Ring02 = GET_ITEM(13, 159), Pendant = GET_ITEM(13, 160)},
{Attack = GET_ITEM(0, 64), UseRingPendant = false, Ring01 = GET_ITEM(13, 162), Ring02 = GET_ITEM(13, 162), Pendant = GET_ITEM(13, 161)},
{Attack = GET_ITEM(0, 64), UseRingPendant = false, Ring01 = GET_ITEM(13, 170), Ring02 = GET_ITEM(13, 170), Pendant = GET_ITEM(13, 163)},
{Attack = GET_ITEM(0, 64), UseRingPendant = false, Ring01 = GET_ITEM(13, 171), Ring02 = GET_ITEM(13, 171), Pendant = GET_ITEM(13, 172)},


-- SWORD STEEL

{Attack = GET_ITEM(0, 65), UseRingPendant = false, Ring01 = GET_ITEM(13, 157), Ring02 = GET_ITEM(13, 157), Pendant = GET_ITEM(13, 158)},
{Attack = GET_ITEM(0, 65), UseRingPendant = false, Ring01 = GET_ITEM(13, 148), Ring02 = GET_ITEM(13, 148), Pendant = GET_ITEM(13, 146)},
{Attack = GET_ITEM(0, 65), UseRingPendant = false, Ring01 = GET_ITEM(13, 149), Ring02 = GET_ITEM(13, 149), Pendant = GET_ITEM(13, 150)},
{Attack = GET_ITEM(0, 65), UseRingPendant = false, Ring01 = GET_ITEM(13, 151), Ring02 = GET_ITEM(13, 151), Pendant = GET_ITEM(13, 152)},
{Attack = GET_ITEM(0, 65), UseRingPendant = false, Ring01 = GET_ITEM(13, 153), Ring02 = GET_ITEM(13, 153), Pendant = GET_ITEM(13, 154)},
{Attack = GET_ITEM(0, 65), UseRingPendant = false, Ring01 = GET_ITEM(13, 155), Ring02 = GET_ITEM(13, 155), Pendant = GET_ITEM(13, 156)},
{Attack = GET_ITEM(0, 65), UseRingPendant = false, Ring01 = GET_ITEM(13, 159), Ring02 = GET_ITEM(13, 159), Pendant = GET_ITEM(13, 160)},
{Attack = GET_ITEM(0, 65), UseRingPendant = false, Ring01 = GET_ITEM(13, 162), Ring02 = GET_ITEM(13, 162), Pendant = GET_ITEM(13, 161)},
{Attack = GET_ITEM(0, 65), UseRingPendant = false, Ring01 = GET_ITEM(13, 170), Ring02 = GET_ITEM(13, 170), Pendant = GET_ITEM(13, 163)},
{Attack = GET_ITEM(0, 65), UseRingPendant = false, Ring01 = GET_ITEM(13, 171), Ring02 = GET_ITEM(13, 171), Pendant = GET_ITEM(13, 172)},


-- DEATH RELIC

{Attack = GET_ITEM(0, 90), UseRingPendant = false, Ring01 = GET_ITEM(13, 157), Ring02 = GET_ITEM(13, 157), Pendant = GET_ITEM(13, 158)},
{Attack = GET_ITEM(0, 90), UseRingPendant = false, Ring01 = GET_ITEM(13, 148), Ring02 = GET_ITEM(13, 148), Pendant = GET_ITEM(13, 146)},
{Attack = GET_ITEM(0, 90), UseRingPendant = false, Ring01 = GET_ITEM(13, 149), Ring02 = GET_ITEM(13, 149), Pendant = GET_ITEM(13, 150)},
{Attack = GET_ITEM(0, 90), UseRingPendant = false, Ring01 = GET_ITEM(13, 151), Ring02 = GET_ITEM(13, 151), Pendant = GET_ITEM(13, 152)},
{Attack = GET_ITEM(0, 90), UseRingPendant = false, Ring01 = GET_ITEM(13, 153), Ring02 = GET_ITEM(13, 153), Pendant = GET_ITEM(13, 154)},
{Attack = GET_ITEM(0, 90), UseRingPendant = false, Ring01 = GET_ITEM(13, 155), Ring02 = GET_ITEM(13, 155), Pendant = GET_ITEM(13, 156)},
{Attack = GET_ITEM(0, 90), UseRingPendant = false, Ring01 = GET_ITEM(13, 159), Ring02 = GET_ITEM(13, 159), Pendant = GET_ITEM(13, 160)},
{Attack = GET_ITEM(0, 90), UseRingPendant = false, Ring01 = GET_ITEM(13, 162), Ring02 = GET_ITEM(13, 162), Pendant = GET_ITEM(13, 161)},
{Attack = GET_ITEM(0, 90), UseRingPendant = false, Ring01 = GET_ITEM(13, 170), Ring02 = GET_ITEM(13, 170), Pendant = GET_ITEM(13, 163)},
{Attack = GET_ITEM(0, 90), UseRingPendant = false, Ring01 = GET_ITEM(13, 171), Ring02 = GET_ITEM(13, 171), Pendant = GET_ITEM(13, 172)},
{Attack = GET_ITEM(0, 90), UseRingPendant = false, Ring01 = GET_ITEM(13, 173), Ring02 = GET_ITEM(13, 173), Pendant = GET_ITEM(13, 174)},
{Attack = GET_ITEM(0, 90), UseRingPendant = false, Ring01 = GET_ITEM(13, 175), Ring02 = GET_ITEM(13, 175), Pendant = GET_ITEM(13, 176)},
{Attack = GET_ITEM(0, 90), UseRingPendant = false, Ring01 = GET_ITEM(13, 179), Ring02 = GET_ITEM(13, 179), Pendant = GET_ITEM(13, 180)},
{Attack = GET_ITEM(0, 90), UseRingPendant = false, Ring01 = GET_ITEM(15, 403), Ring02 = GET_ITEM(15, 403), Pendant = GET_ITEM(15, 404)},
{Attack = GET_ITEM(0, 90), UseRingPendant = false, Ring01 = GET_ITEM(15, 405), Ring02 = GET_ITEM(15, 405), Pendant = GET_ITEM(15, 406)},
{Attack = GET_ITEM(0, 90), UseRingPendant = false, Ring01 = GET_ITEM(15, 407), Ring02 = GET_ITEM(15, 407), Pendant = GET_ITEM(15, 408)},



{Attack = GET_ITEM(0, 91), UseRingPendant = false, Ring01 = GET_ITEM(13, 157), Ring02 = GET_ITEM(13, 157), Pendant = GET_ITEM(13, 158)},
{Attack = GET_ITEM(0, 91), UseRingPendant = false, Ring01 = GET_ITEM(13, 148), Ring02 = GET_ITEM(13, 148), Pendant = GET_ITEM(13, 146)},
{Attack = GET_ITEM(0, 91), UseRingPendant = false, Ring01 = GET_ITEM(13, 149), Ring02 = GET_ITEM(13, 149), Pendant = GET_ITEM(13, 150)},
{Attack = GET_ITEM(0, 91), UseRingPendant = false, Ring01 = GET_ITEM(13, 151), Ring02 = GET_ITEM(13, 151), Pendant = GET_ITEM(13, 152)},
{Attack = GET_ITEM(0, 91), UseRingPendant = false, Ring01 = GET_ITEM(13, 153), Ring02 = GET_ITEM(13, 153), Pendant = GET_ITEM(13, 154)},
{Attack = GET_ITEM(0, 91), UseRingPendant = false, Ring01 = GET_ITEM(13, 155), Ring02 = GET_ITEM(13, 155), Pendant = GET_ITEM(13, 156)},
{Attack = GET_ITEM(0, 91), UseRingPendant = false, Ring01 = GET_ITEM(13, 159), Ring02 = GET_ITEM(13, 159), Pendant = GET_ITEM(13, 160)},
{Attack = GET_ITEM(0, 91), UseRingPendant = false, Ring01 = GET_ITEM(13, 162), Ring02 = GET_ITEM(13, 162), Pendant = GET_ITEM(13, 161)},
{Attack = GET_ITEM(0, 91), UseRingPendant = false, Ring01 = GET_ITEM(13, 170), Ring02 = GET_ITEM(13, 170), Pendant = GET_ITEM(13, 163)},
{Attack = GET_ITEM(0, 91), UseRingPendant = false, Ring01 = GET_ITEM(13, 171), Ring02 = GET_ITEM(13, 171), Pendant = GET_ITEM(13, 172)},
{Attack = GET_ITEM(0, 91), UseRingPendant = false, Ring01 = GET_ITEM(13, 173), Ring02 = GET_ITEM(13, 173), Pendant = GET_ITEM(13, 174)},
{Attack = GET_ITEM(0, 91), UseRingPendant = false, Ring01 = GET_ITEM(13, 175), Ring02 = GET_ITEM(13, 175), Pendant = GET_ITEM(13, 176)},
{Attack = GET_ITEM(0, 91), UseRingPendant = false, Ring01 = GET_ITEM(13, 179), Ring02 = GET_ITEM(13, 179), Pendant = GET_ITEM(13, 180)},
{Attack = GET_ITEM(0, 91), UseRingPendant = false, Ring01 = GET_ITEM(15, 403), Ring02 = GET_ITEM(15, 403), Pendant = GET_ITEM(15, 404)},
{Attack = GET_ITEM(0, 91), UseRingPendant = false, Ring01 = GET_ITEM(15, 405), Ring02 = GET_ITEM(15, 405), Pendant = GET_ITEM(15, 406)},
{Attack = GET_ITEM(0, 91), UseRingPendant = false, Ring01 = GET_ITEM(15, 407), Ring02 = GET_ITEM(15, 407), Pendant = GET_ITEM(15, 408)},


{Attack = GET_ITEM(0, 92), UseRingPendant = false, Ring01 = GET_ITEM(13, 157), Ring02 = GET_ITEM(13, 157), Pendant = GET_ITEM(13, 158)},
{Attack = GET_ITEM(0, 92), UseRingPendant = false, Ring01 = GET_ITEM(13, 148), Ring02 = GET_ITEM(13, 148), Pendant = GET_ITEM(13, 146)},
{Attack = GET_ITEM(0, 92), UseRingPendant = false, Ring01 = GET_ITEM(13, 149), Ring02 = GET_ITEM(13, 149), Pendant = GET_ITEM(13, 150)},
{Attack = GET_ITEM(0, 92), UseRingPendant = false, Ring01 = GET_ITEM(13, 151), Ring02 = GET_ITEM(13, 151), Pendant = GET_ITEM(13, 152)},
{Attack = GET_ITEM(0, 92), UseRingPendant = false, Ring01 = GET_ITEM(13, 153), Ring02 = GET_ITEM(13, 153), Pendant = GET_ITEM(13, 154)},
{Attack = GET_ITEM(0, 92), UseRingPendant = false, Ring01 = GET_ITEM(13, 155), Ring02 = GET_ITEM(13, 155), Pendant = GET_ITEM(13, 156)},
{Attack = GET_ITEM(0, 92), UseRingPendant = false, Ring01 = GET_ITEM(13, 159), Ring02 = GET_ITEM(13, 159), Pendant = GET_ITEM(13, 160)},
{Attack = GET_ITEM(0, 92), UseRingPendant = false, Ring01 = GET_ITEM(13, 162), Ring02 = GET_ITEM(13, 162), Pendant = GET_ITEM(13, 161)},
{Attack = GET_ITEM(0, 92), UseRingPendant = false, Ring01 = GET_ITEM(13, 170), Ring02 = GET_ITEM(13, 170), Pendant = GET_ITEM(13, 163)},
{Attack = GET_ITEM(0, 92), UseRingPendant = false, Ring01 = GET_ITEM(13, 171), Ring02 = GET_ITEM(13, 171), Pendant = GET_ITEM(13, 172)},
{Attack = GET_ITEM(0, 92), UseRingPendant = false, Ring01 = GET_ITEM(13, 173), Ring02 = GET_ITEM(13, 173), Pendant = GET_ITEM(13, 174)},
{Attack = GET_ITEM(0, 92), UseRingPendant = false, Ring01 = GET_ITEM(13, 175), Ring02 = GET_ITEM(13, 175), Pendant = GET_ITEM(13, 176)},
{Attack = GET_ITEM(0, 92), UseRingPendant = false, Ring01 = GET_ITEM(13, 179), Ring02 = GET_ITEM(13, 179), Pendant = GET_ITEM(13, 180)},
{Attack = GET_ITEM(0, 92), UseRingPendant = false, Ring01 = GET_ITEM(15, 403), Ring02 = GET_ITEM(15, 403), Pendant = GET_ITEM(15, 404)},
{Attack = GET_ITEM(0, 92), UseRingPendant = false, Ring01 = GET_ITEM(15, 405), Ring02 = GET_ITEM(15, 405), Pendant = GET_ITEM(15, 406)},
{Attack = GET_ITEM(0, 92), UseRingPendant = false, Ring01 = GET_ITEM(15, 407), Ring02 = GET_ITEM(15, 407), Pendant = GET_ITEM(15, 408)},


{Attack = GET_ITEM(0, 93), UseRingPendant = false, Ring01 = GET_ITEM(13, 157), Ring02 = GET_ITEM(13, 157), Pendant = GET_ITEM(13, 158)},
{Attack = GET_ITEM(0, 93), UseRingPendant = false, Ring01 = GET_ITEM(13, 148), Ring02 = GET_ITEM(13, 148), Pendant = GET_ITEM(13, 146)},
{Attack = GET_ITEM(0, 93), UseRingPendant = false, Ring01 = GET_ITEM(13, 149), Ring02 = GET_ITEM(13, 149), Pendant = GET_ITEM(13, 150)},
{Attack = GET_ITEM(0, 93), UseRingPendant = false, Ring01 = GET_ITEM(13, 151), Ring02 = GET_ITEM(13, 151), Pendant = GET_ITEM(13, 152)},
{Attack = GET_ITEM(0, 93), UseRingPendant = false, Ring01 = GET_ITEM(13, 153), Ring02 = GET_ITEM(13, 153), Pendant = GET_ITEM(13, 154)},
{Attack = GET_ITEM(0, 93), UseRingPendant = false, Ring01 = GET_ITEM(13, 155), Ring02 = GET_ITEM(13, 155), Pendant = GET_ITEM(13, 156)},
{Attack = GET_ITEM(0, 93), UseRingPendant = false, Ring01 = GET_ITEM(13, 159), Ring02 = GET_ITEM(13, 159), Pendant = GET_ITEM(13, 160)},
{Attack = GET_ITEM(0, 93), UseRingPendant = false, Ring01 = GET_ITEM(13, 162), Ring02 = GET_ITEM(13, 162), Pendant = GET_ITEM(13, 161)},
{Attack = GET_ITEM(0, 93), UseRingPendant = false, Ring01 = GET_ITEM(13, 170), Ring02 = GET_ITEM(13, 170), Pendant = GET_ITEM(13, 163)},
{Attack = GET_ITEM(0, 93), UseRingPendant = false, Ring01 = GET_ITEM(13, 171), Ring02 = GET_ITEM(13, 171), Pendant = GET_ITEM(13, 172)},
{Attack = GET_ITEM(0, 93), UseRingPendant = false, Ring01 = GET_ITEM(13, 173), Ring02 = GET_ITEM(13, 173), Pendant = GET_ITEM(13, 174)},
{Attack = GET_ITEM(0, 93), UseRingPendant = false, Ring01 = GET_ITEM(13, 175), Ring02 = GET_ITEM(13, 175), Pendant = GET_ITEM(13, 176)},
{Attack = GET_ITEM(0, 93), UseRingPendant = false, Ring01 = GET_ITEM(13, 179), Ring02 = GET_ITEM(13, 179), Pendant = GET_ITEM(13, 180)},
{Attack = GET_ITEM(0, 93), UseRingPendant = false, Ring01 = GET_ITEM(15, 403), Ring02 = GET_ITEM(15, 403), Pendant = GET_ITEM(15, 404)},
{Attack = GET_ITEM(0, 93), UseRingPendant = false, Ring01 = GET_ITEM(15, 405), Ring02 = GET_ITEM(15, 405), Pendant = GET_ITEM(15, 406)},
{Attack = GET_ITEM(0, 93), UseRingPendant = false, Ring01 = GET_ITEM(15, 407), Ring02 = GET_ITEM(15, 407), Pendant = GET_ITEM(15, 408)},


{Attack = GET_ITEM(0, 100), UseRingPendant = false, Ring01 = GET_ITEM(15, 407), Ring02 = GET_ITEM(15, 407), Pendant = GET_ITEM(15, 408)},
{Attack = GET_ITEM(0, 101), UseRingPendant = false, Ring01 = GET_ITEM(15, 407), Ring02 = GET_ITEM(15, 407), Pendant = GET_ITEM(15, 408)},
{Attack = GET_ITEM(0, 102), UseRingPendant = false, Ring01 = GET_ITEM(15, 407), Ring02 = GET_ITEM(15, 407), Pendant = GET_ITEM(15, 408)},
{Attack = GET_ITEM(0, 103), UseRingPendant = false, Ring01 = GET_ITEM(15, 407), Ring02 = GET_ITEM(15, 407), Pendant = GET_ITEM(15, 408)},
{Attack = GET_ITEM(0, 104), UseRingPendant = false, Ring01 = GET_ITEM(15, 407), Ring02 = GET_ITEM(15, 407), Pendant = GET_ITEM(15, 408)},
{Attack = GET_ITEM(0, 105), UseRingPendant = false, Ring01 = GET_ITEM(15, 407), Ring02 = GET_ITEM(15, 407), Pendant = GET_ITEM(15, 408)},
{Attack = GET_ITEM(0, 106), UseRingPendant = false, Ring01 = GET_ITEM(15, 407), Ring02 = GET_ITEM(15, 407), Pendant = GET_ITEM(15, 408)},
{Attack = GET_ITEM(0, 114), UseRingPendant = false, Ring01 = GET_ITEM(15, 407), Ring02 = GET_ITEM(15, 407), Pendant = GET_ITEM(15, 408)},
{Attack = GET_ITEM(0, 115), UseRingPendant = false, Ring01 = GET_ITEM(15, 407), Ring02 = GET_ITEM(15, 407), Pendant = GET_ITEM(15, 408)},
{Attack = GET_ITEM(0, 116), UseRingPendant = false, Ring01 = GET_ITEM(15, 407), Ring02 = GET_ITEM(15, 407), Pendant = GET_ITEM(15, 408)},


{Attack = GET_ITEM(0, 118), UseRingPendant = false, Ring01 = GET_ITEM(15, 407), Ring02 = GET_ITEM(15, 407), Pendant = GET_ITEM(15, 408)},

{Attack = GET_ITEM(0, 97), UseRingPendant = false, Ring01 = GET_ITEM(15, 407), Ring02 = GET_ITEM(15, 407), Pendant = GET_ITEM(15, 408)},
{Attack = GET_ITEM(0, 98), UseRingPendant = false, Ring01 = GET_ITEM(15, 407), Ring02 = GET_ITEM(15, 407), Pendant = GET_ITEM(15, 408)},
{Attack = GET_ITEM(0, 99), UseRingPendant = false, Ring01 = GET_ITEM(15, 407), Ring02 = GET_ITEM(15, 407), Pendant = GET_ITEM(15, 408)},

{Attack = GET_ITEM(0, 162), UseRingPendant = false, Ring01 = GET_ITEM(15, 407), Ring02 = GET_ITEM(15, 407), Pendant = GET_ITEM(15, 408)},
{Attack = GET_ITEM(0, 163), UseRingPendant = false, Ring01 = GET_ITEM(15, 407), Ring02 = GET_ITEM(15, 407), Pendant = GET_ITEM(15, 408)},

{Attack = GET_ITEM(0, 164), UseRingPendant = false, Ring01 = GET_ITEM(15, 407), Ring02 = GET_ITEM(15, 407), Pendant = GET_ITEM(15, 408)},
{Attack = GET_ITEM(0, 165), UseRingPendant = false, Ring01 = GET_ITEM(15, 407), Ring02 = GET_ITEM(15, 407), Pendant = GET_ITEM(15, 408)},
{Attack = GET_ITEM(0, 166), UseRingPendant = false, Ring01 = GET_ITEM(15, 407), Ring02 = GET_ITEM(15, 407), Pendant = GET_ITEM(15, 408)},
{Attack = GET_ITEM(0, 144), UseRingPendant = false, Ring01 = GET_ITEM(15, 407), Ring02 = GET_ITEM(15, 407), Pendant = GET_ITEM(15, 408)},
{Attack = GET_ITEM(0, 145), UseRingPendant = false, Ring01 = GET_ITEM(15, 407), Ring02 = GET_ITEM(15, 407), Pendant = GET_ITEM(15, 408)},
{Attack = GET_ITEM(0, 132), UseRingPendant = false, Ring01 = GET_ITEM(15, 407), Ring02 = GET_ITEM(15, 407), Pendant = GET_ITEM(15, 408)},
{Attack = GET_ITEM(0, 133), UseRingPendant = false, Ring01 = GET_ITEM(15, 407), Ring02 = GET_ITEM(15, 407), Pendant = GET_ITEM(15, 408)},
{Attack = GET_ITEM(0, 146), UseRingPendant = false, Ring01 = GET_ITEM(15, 407), Ring02 = GET_ITEM(15, 407), Pendant = GET_ITEM(15, 408)},
{Attack = GET_ITEM(0, 147), UseRingPendant = false, Ring01 = GET_ITEM(15, 407), Ring02 = GET_ITEM(15, 407), Pendant = GET_ITEM(15, 408)},
{Attack = GET_ITEM(0, 157), UseRingPendant = false, Ring01 = GET_ITEM(15, 407), Ring02 = GET_ITEM(15, 407), Pendant = GET_ITEM(15, 408)},
{Attack = GET_ITEM(0, 158), UseRingPendant = false, Ring01 = GET_ITEM(15, 407), Ring02 = GET_ITEM(15, 407), Pendant = GET_ITEM(15, 408)},
{Attack = GET_ITEM(0, 167), UseRingPendant = false, Ring01 = GET_ITEM(15, 407), Ring02 = GET_ITEM(15, 407), Pendant = GET_ITEM(15, 408)},
{Attack = GET_ITEM(0, 168), UseRingPendant = false, Ring01 = GET_ITEM(15, 407), Ring02 = GET_ITEM(15, 407), Pendant = GET_ITEM(15, 408)},

{Attack = GET_ITEM(0, 117), UseRingPendant = false, Ring01 = GET_ITEM(15, 407), Ring02 = GET_ITEM(15, 407), Pendant = GET_ITEM(15, 408)},
{Attack = GET_ITEM(0, 118), UseRingPendant = false, Ring01 = GET_ITEM(15, 407), Ring02 = GET_ITEM(15, 407), Pendant = GET_ITEM(15, 408)},


}

local DEATH_PATENT_RANKING = {

{MinDeaths = 10,       MaxDeaths =   200,     Top = 12, PatentNumber = 1, PatentName = "Hitador",                 PatentType = 0},
{MinDeaths = 201,     MaxDeaths =   400,     Top = 11, PatentNumber = 2, PatentName = "Sanguinario",              PatentType = 0},
{MinDeaths = 401,     MaxDeaths =   600,     Top = 10, PatentNumber = 3, PatentName = "Assassino",                PatentType = 0},
{MinDeaths = 601,     MaxDeaths =   800,     Top = 9,  PatentNumber = 4, PatentName = "Algoz",                    PatentType = 0},
{MinDeaths = 801,     MaxDeaths =   1000,    Top = 8,  PatentNumber = 5, PatentName = "Carrasco",                 PatentType = 0},
{MinDeaths = 1001,    MaxDeaths =   1200,    Top = 7,  PatentNumber = 6, PatentName = "Ceifador Bronze",          PatentType = 0},
{MinDeaths = 1201,    MaxDeaths =   1400,    Top = 6,  PatentNumber = 7, PatentName = "Ceifador Prata",           PatentType = 0},
{MinDeaths = 1401,    MaxDeaths =   1600,    Top = 5,  PatentNumber = 8, PatentName = "Ceifador Ouro",            PatentType = 0},
{MinDeaths = 1601,    MaxDeaths =   1800,    Top = 4,  PatentNumber = 9, PatentName = "Ceifador Platina",         PatentType = 0},
{MinDeaths = 1801,    MaxDeaths =   2000,    Top = 3,  PatentNumber = 10, PatentName = "Ceifador Diamante",       PatentType = 0},
{MinDeaths = 2001,    MaxDeaths =   2200,    Top = 2,  PatentNumber = 11, PatentName = "Senhor da Morte",         PatentType = 0},
{MinDeaths = 2201,    MaxDeaths =   2400,    Top = 1,  PatentNumber = 12, PatentName = "Principe da Morte",       PatentType = 0},
{MinDeaths = 2401,    MaxDeaths =   3000,    Top = 1,  PatentNumber = 13, PatentName = "Rei da Morte",            PatentType = 1},
}

local DEATH_PATENT_PLAYER = {}

function DeathPatent.GetSerialTop1()
	local Query = string.format("SELECT Top 1 m_Serial as Serial FROM DeathSystem ORDER BY Deaths DESC")
	ret = db:exec(Query)
	
	if ret == 0
	then
		LogAddC(2,string.format("Não foi possível executar a query: %s", Query))
		db:clear()
		return 0
	end
	
	nRet = db:fetch()
	if nRet == SQL_NO_DATA
	then
		LogAddC(2,string.format("Não foi possível executar a query: %s", Query))
		db:clear()
		return 0
	end
	
	local val = db:getInt('Serial')
	db:clear()
	return val
end

function DeathPatent.CheckPlayerItem(aIndex)
	if DEATH_PATENT_SWITCH == 0 then
		return 0
	end

	local pInv = Inventory.new(aIndex)

	local Attack = pInv:getIndex(240)
	local Attack = pInv:getIndex(0)
	local Ring01 = pInv:getIndex(10)
	local Ring02 = pInv:getIndex(11)
	local Pendant = pInv:getIndex(9)

	for n in ipairs(DEATH_PATENT_INFO) do
		local dados = DEATH_PATENT_INFO[n]
		if dados.Attack == Attack then
			if dados.UseRingPendant then
				if dados.Ring01 == Ring01 then
					if dados.Ring02 == Ring02 then
						if dados.Pendant == Pendant then
							return 1
						end
					end
				end
			else
				return 1
			end
		end
	end

	return 0
end

function DeathPatent.GetPatentPlayer(aIndex)
	if DeathPatent.CheckPlayerItem(aIndex) == 0
	then
		return
	end
	
	local pInv = Inventory.new(aIndex)
	local player = User.new(aIndex)

	local Deaths = 0
	local Attack = pInv:getIndex(240)
	local Attack = pInv:getIndex(0)
	local AttackSerial = pInv:getSerial(0)
	local SerialTop1 = DeathPatent.GetSerialTop1()
	
	for n in ipairs(DEATH_PATENT_INFO) do
		local dados = DEATH_PATENT_INFO[n]
		
		if dados.Attack == Attack
		then
			Deaths = DataBase.GetValue('DeathSystem', 'Deaths', 'm_Serial', AttackSerial)
		end
	end
	
	local Changed = 0

	for n in ipairs(DEATH_PATENT_RANKING) do
		local dados = DEATH_PATENT_RANKING[n]
		if SerialTop1 == AttackSerial
		then
			if dados.Top == 1
			then
				if player:getPatent() ~= dados.PatentNumber
				then
					player:setPatent(dados.PatentNumber)
					player:setPatentType(dados.PatentType)
					ViewportCreate(aIndex)
					SendMessage(string.format("Ranking da Morte: [%s]", dados.PatentName), aIndex, 1)
					Changed = 1
				end
			end
		else
			if Deaths >= dados.MinDeaths and Deaths <= dados.MaxDeaths
			then
				if player:getPatent(aIndex) ~= dados.PatentNumber
				then
					player:setPatent(dados.PatentNumber)
					player:setPatentType(dados.PatentType)
					ViewportCreate(aIndex)
					SendMessage(string.format("Ranking da Morte: [%s]", dados.PatentName), aIndex, 1)
					Changed = 1
			end
		end
	end
end
	
	if Changed == 1
	then
		DEATH_PATENT_PLAYER[aIndex] = aIndex
	end
end

function DeathPatent.UpdatePatentUsers()
	for i = 13000, 13999 do
		local player = User.new(i)
		if player:getConnected() == 3
		then
			DeathPatent.GetPatentPlayer(i)
		end

		player = nil
	end
end

function DeathPatent.PlayerLogout(aIndex, Name, Account)
	if DEATH_PATENT_PLAYER[aIndex]
	then
		DEATH_PATENT_PLAYER[aIndex] = nil
	end
end

function DeathPatent.EnterCharacter(aIndex)
	DeathPatent.GetPatentPlayer(aIndex)
end

function DeathPatent.DeletePatent(aIndex)
	local player = User.new(aIndex)

	for n in ipairs(DEATH_PATENT_RANKING) do
		local dados = DEATH_PATENT_RANKING[n]
		if dados.PatentNumber == player:getPatent()
		then
			player:setPatent(-1)
			ViewportCreate(aIndex)
			return
		end
	end
end

function DeathPatent.UpdateAnotherPatent(aIndex)
	--Aqui adiciona as outras patentes que precisa dar update...
	ViewportCreate(aIndex)
end

function DeathPatent.PlayerMoveItem(aIndex, SourceSlot, TargetSlot, Type)
	if Type == 0 or Type == 2 or Type == 5
	then
		local Changed = 0
		
		if SourceSlot >= 0 and SourceSlot < 12
		then
			if DEATH_PATENT_PLAYER[aIndex]
			then
				DeathPatent.DeletePatent(aIndex)
				DEATH_PATENT_PLAYER[aIndex] = nil
				Changed = 1
			end
		end
		
		if TargetSlot >= 0 and TargetSlot < 12
		then
			DeathPatent.GetPatentPlayer(aIndex)
		end
		
		if Changed == 1
		then
			Timer.TimeOut(100, DeathPatent.UpdateAnotherPatent, aIndex)
		end
	end
end

GameServerFunctions.PlayerLogout(DeathPatent.PlayerLogout)
GameServerFunctions.PlayerMoveItem(DeathPatent.PlayerMoveItem)
GameServerFunctions.EnterCharacter(DeathPatent.EnterCharacter)

return DeathPatent