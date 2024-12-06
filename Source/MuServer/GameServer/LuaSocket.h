#pragma once

#include <map>
#include <string>

#include "Protocol.h"
#include "OgocX.h"

class PMSG_CUSTOM_SOCKET_RECV
{
public:
	PMSG_CUSTOM_SOCKET_RECV() {
		this->Release();
	};
	~PMSG_CUSTOM_SOCKET_RECV() {
		this->Release();
	};

	void Release() {
		std::memset(this->m_PacketName, 0, sizeof(this->m_PacketName));
		std::memset(this->m_Packet, 0, sizeof(this->m_Packet));
		this->m_Size = 0;
		this->m_SizeGeting = 0;
	};
public:
	PSWMSG_HEAD header; // 0xFE
	char m_PacketName[100];
	BYTE m_Packet[5000];
	int m_Size;
	int m_SizeGeting;
};

class PMSG_CUSTOM_SOCKET_SEND
{
public:
	PMSG_CUSTOM_SOCKET_SEND() {
		this->Release();
	};
	~PMSG_CUSTOM_SOCKET_SEND() {
		this->Release();
	};

	void Release() {
		std::memset(this->m_PacketName, 0, sizeof(this->m_PacketName));
		std::memset(this->m_Packet, 0, sizeof(this->m_Packet));
		this->m_Size = 0;
		this->m_SizeGeting = 0;
	};

public:
	PSWMSG_HEAD header; // 0xFE
	char m_PacketName[100];
	BYTE m_Packet[5000];
	int m_Size;
	int m_SizeGeting;
};

class CSocket {
public:
	CSocket();
	virtual ~CSocket();

	void RecvPacketCustomSocket(int aIndex, PMSG_CUSTOM_SOCKET_RECV * lpMsg, BYTE* packet, BYTE head, int size);
#ifndef OLD_LUA
	void SetGlobalFunctions(sol::state& lua);
#else
	void SetGlobalFunctions(lua_State * Lua);
#endif
	void ClearPackets();

public:
	std::map<std::string, PMSG_CUSTOM_SOCKET_RECV> m_Sockets;


};

extern CSocket gSocket;