// CustomDeathMessage.cpp: implementation of the CGate class.//
//////////////////////////////////////////////////////////////////////


#include "stdafx.h"
#include "CommandManager.h"
#include "CustomDeathMessage.h"
#include "Log.h"
#include "ReadScript.h"
#include "Message.h"
#include "Notice.h"
#include "Util.h"


CustomDeathMessage gCustomDeathMessage;
//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////


CustomDeathMessage::CustomDeathMessage() // OK
{
	this->m_CustomDeathMessage.clear();
}


CustomDeathMessage::~CustomDeathMessage() // OK
{


}


void CustomDeathMessage::Load(char* path) // OK
{
	CReadScript* lpReadScript = new CReadScript;


	if (lpReadScript == NULL)
	{
		ErrorMessageBox(READ_SCRIPT_ALLOC_ERROR, path);
		return;
	}


	if (!lpReadScript->Load(path))
	{
		ErrorMessageBox(lpReadScript->GetError());
		delete lpReadScript;
		return;
	}


	this->m_CustomDeathMessage.clear();


	try
	{
		eTokenResult token;

		while (true)
		{
			token = lpReadScript->GetToken();

			if (token == TOKEN_END || token == TOKEN_END_SECTION)
			{
				break;
			}

			CUSTOMDEATHMESSAGE_INFO info;


			info.Index = lpReadScript->GetNumber();


			strcpy_s(info.Text, lpReadScript->GetAsString());


			this->m_CustomDeathMessage.insert(std::pair<int, CUSTOMDEATHMESSAGE_INFO>(info.Index, info));
		}
	}
	catch (...)
	{
		ErrorMessageBox(lpReadScript->GetError());
	}


	delete lpReadScript;
}




void CustomDeathMessage::GetDeathText(LPOBJ lpTarget, LPOBJ lpObj, int index) // OK
{
	CUSTOMDEATHMESSAGE_INFO CustomDM;


	if (this->GetInfo(index, &CustomDM) == 0)
	{
		return;
	}


	GCChatTargetSend(lpTarget, lpObj->Index, CustomDM.Text);
}




bool CustomDeathMessage::GetInfo(int index, CUSTOMDEATHMESSAGE_INFO* lpInfo) // OK
{
	std::map<int, CUSTOMDEATHMESSAGE_INFO>::iterator it = this->m_CustomDeathMessage.find(index);


	if (it == this->m_CustomDeathMessage.end())
	{
		return 0;
	}
	else
	{
		(*lpInfo) = it->second;
		return 1;
	}
}