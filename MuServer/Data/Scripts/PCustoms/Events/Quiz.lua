Quiz = {}

Quiz.Running = false
Quiz.QuizData = {}

function Quiz.Init()
	

	if not Quiz_Config.Ativado then return end
	
	Commands.Register(Quiz_Config.ComandoResposta, Quiz.Answer)
	Commands.Register(Quiz_Config.ComandoAbrir, Quiz.Open)
	Commands.Register(Quiz_Config.ComandoCancelar, Quiz.Cancelar)
	
	for i in ipairs(Quiz_Config.Cron) do
		if Quiz_Config.Cron[i].DiaSemana ~= -1
		then
			Schedule.SetDayOfWeek(Quiz_Config.Cron[i].DiaSemana, Quiz_Config.Cron[i].Hora, Quiz_Config.Cron[i].Minuto, Quiz.Open, -1)
		elseif Quiz_Config.Cron[i].Dia ~= -1
		then
			Schedule.SetDayAndHourAndMinute(Quiz_Config.Cron[i].Dia, Quiz_Config.Cron[i].Hora, Quiz_Config.Cron[i].Minuto, Quiz.Open , -1)
		else
			Schedule.SetHourAndMinute(Quiz_Config.Cron[i].Hora, Quiz_Config.Cron[i].Minuto, Quiz.Open , -1)
		end
	end
end

function Quiz.Cancelar(aIndex)
	local p = User.new(aIndex)
	if p:getAuthority() == 1 then return end

	Quiz.End()
end

function Quiz.Open(aIndex)	
	if Quiz.Running then return end
	
	if aIndex ~= -1 then
		local p = User.new(aIndex)
		if p:getAuthority() == 1 then return end
	end
	
	Quiz.Running = true
	
	math.randomseed(os.clock()*os.time()*GetTick())
	local keyMensagem = math.random(1, #Quiz_Config.Perguntas)
	Quiz.QuizData = Quiz_Config.Perguntas[keyMensagem]
	
	Message.SendMessageGlobalMultLang(Quiz_Config.Mensagens, 1, 0)
	SendMessageGlobal(string.format(" "), 0)
	Quiz.GlobalPergunta(Quiz.QuizData.Pergunta)
	SendMessageGlobal(string.format(" "), 0)
	Message.SendMessageGlobalMultLangArgs(Quiz_Config.Mensagens, 2, 0, Quiz_Config.ComandoResposta)
	SendMessageGlobal(string.format("========================="), 0)
	
	Timer.TimeOut(Quiz_Config.TimeOut * 60, Quiz.End)
end

function Quiz.Answer(aIndex, Arguments)	
	if not Quiz.Running then return end
	
	local resposta = string.sub(string.lower(command:getString(Arguments, 1, 1)),2)
	local p = User.new(aIndex)
	
	SendMessageGlobal(string.format(POST_STRING, p:getName(), command:getString(Arguments, 1, 1)), POST_COLOR)

	local lang = p:getLanguage()
	
	if resposta == string.lower(Quiz.QuizData.Resposta[lang]) then
		Quiz.Running = false
		SendMessage(Quiz_Config.Mensagens[lang][6], aIndex, 1)
		Message.SendMessageGlobalMultLang(Quiz_Config.Mensagens, 1, 0)
		SendMessageGlobal(string.format(" "), 0)
		Message.SendMessageGlobalMultLangArgs(Quiz_Config.Mensagens, 3, 0, p:getName())
		Quiz.GlobalResposta(Quiz_Config.Mensagens, Quiz.QuizData.Resposta)
		SendMessageGlobal(string.format(" "), 0)
		SendMessageGlobal(string.format("========================="), 0)

		local player = {[0] = p:getAccountID(), [1] = p:getName()}

		for i in ipairs(Quiz_Config.Premio) do
			local query = string.format("UPDATE %s SET %s=%s+%d WHERE %s = '%s'",
					Quiz_Config.Premio[i].Tabela,
                    Quiz_Config.Premio[i].Coluna,
                    Quiz_Config.Premio[i].Coluna,
                    Quiz_Config.Premio[i].Quantidade,
                    Quiz_Config.Premio[i].Where,
                    player[Quiz_Config.Premio[i].Tipo]
                )
            CreateAsyncQuery('SetAddValueOwner', query, -1, 0)
		end

		SendMessage(Quiz_Config.Mensagens[lang][8], aIndex, 1)

		Quiz.QuizData = {}
		return
	else
		SendMessage(Quiz_Config.Mensagens[lang][5], aIndex, 1)
		return
	end
end

function Quiz.End()
	if Quiz.Running then
		Quiz.Running = false
		Quiz.QuizData = {}
		Message.SendMessageGlobalMultLang(Quiz_Config.Mensagens, 1, 0)
		SendMessageGlobal(string.format(" "), 0)
		Message.SendMessageGlobalMultLang(Quiz_Config.Mensagens, 7, 0)
		SendMessageGlobal(string.format(" "), 0)
		SendMessageGlobal(string.format("========================="), 0)
		return
	end
	
	return
end

function Quiz.GlobalPergunta(messageSource)
	for i = OBJECT_START_USER, MAX_OBJECT
	do
		if gObjIsConnectedGP(i) == 0
		then
			goto continue
		end

		SendMessagePlayer(i, 0, messageSource[GetLanguageObject(i)])
		
		::continue::
	end
	
	collectgarbage()
end

function Quiz.GlobalResposta(messageSource, messageSource2)
	for i = OBJECT_START_USER, MAX_OBJECT
	do
		if gObjIsConnectedGP(i) == 0
		then
			goto continue
		end

		SendMessagePlayer(i, 0,string.format(messageSource[GetLanguageObject(i)][4], messageSource2[GetLanguageObject(i)]))
		
		::continue::
	end
	
	collectgarbage()
end
Quiz.Init()

return Quiz