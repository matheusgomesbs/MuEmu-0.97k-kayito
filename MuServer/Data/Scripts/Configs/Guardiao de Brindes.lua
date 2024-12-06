-----------------------------------------
	-- Script:		Guardiao de Brindes
	-- Criador:		Pedro Borges
	-- Skype:		live:ppborges93
	-- WhatsApp:	+55 51 99507-8287
	-- Servidor:	King
-----------------------------------------
GuardiaoBrindes_Config ={
	Name = "Guardião de Brindes",
	Enabled = true,
	Packet = 0x34,
	Npc = {
		{
			class = 401,
			map = 2,
			x = 209,
			y = 55,
			dir = 3
		},
	},
	
	Position = {
		[GET_ITEM(0,1)] = {X = 330, Y = 70, W = 40, H = 70},
		[GET_ITEM(6,12)] = {X = 330, Y = 80, W = 45, H = 55},
		[GET_ITEM(6,13)] = {X = 330, Y = 85, W = 50, H = 60},
		[GET_ITEM(0,20)] = {X = 330, Y = 65, W = 40, H = 90},
		[GET_ITEM(14,32)] = {X = 340, Y = 90, W = 30, H = 30},
		[GET_ITEM(14,33)] = {X = 340, Y = 90, W = 30, H = 30},
		[GET_ITEM(14,34)] = {X = 340, Y = 90, W = 30, H = 30},
		[GET_ITEM(13,3)] = {X = 340, Y = 100, W = 30, H = 30},
		[GET_ITEM(0,37)] = {X = 340, Y = 100, W = 20, H = 38},
		[GET_ITEM(6,201)] = {X = 340, Y = 85, W = 30, H = 40},
		[GET_ITEM(2,51)] = {X = 340, Y = 85, W = 30, H = 40},
		
		
	
		[GET_ITEM(0, 56)] =   {X = 340, Y = 85, W = 30, H = 40},
		[GET_ITEM(2, 65)] =   {X = 340, Y = 85, W = 30, H = 40},
		[GET_ITEM(5, 53)] =   {X = 340, Y = 85, W = 30, H = 40},
		[GET_ITEM(6, 210)] =  {X = 340, Y = 85, W = 30, H = 40},
		[GET_ITEM(2, 65)] =   {X = 340, Y = 85, W = 30, H = 40},
		[GET_ITEM(7, 211)] =  {X = 340, Y = 85, W = 30, H = 40},
		[GET_ITEM(8, 211)] =  {X = 340, Y = 85, W = 30, H = 40},
		[GET_ITEM(9, 211)] =  {X = 340, Y = 85, W = 30, H = 40},
		[GET_ITEM(10,211)] =  {X = 340, Y = 85, W = 30, H = 40},
		[GET_ITEM(11, 211)] = {X = 340, Y = 85, W = 30, H = 40},
		[GET_ITEM(12, 218)] = {X = 340, Y = 85, W = 30, H = 40},
		[GET_ITEM(12, 219)] = {X = 340, Y = 85, W = 30, H = 40},
		[GET_ITEM(13, 156)] = {X = 340, Y = 85, W = 30, H = 40},
		[GET_ITEM(13, 157)] = {X = 340, Y = 85, W = 30, H = 40},
		
		[GET_ITEM(14, 211)] = {X = 340, Y = 85, W = 30, H = 40},
		[GET_ITEM(14, 209)] = {X = 340, Y = 85, W = 30, H = 40},
		[GET_ITEM(14, 210)] = {X = 340, Y = 85, W = 30, H = 40},
	}
}

return GuardiaoBrindes_Config