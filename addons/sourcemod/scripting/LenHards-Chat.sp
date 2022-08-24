#include <sourcemod>
#include <basecomm>

#pragma semicolon 1
#pragma newdecls required

char gS_Tag[MAXPLAYERS+1][100];

int gI_Target[MAXPLAYERS+1] = {-1, ...};

public Plugin myinfo =
{
	name = "[CS:GO] Chat Manager",
	author = "LenHard"
}

public void OnPluginStart()
{
	RegAdminCmd("sm_addtag", Cmd_AddTags, ADMFLAG_ROOT, "Opens Tag Adding menu.");
	RegAdminCmd("sm_removetag", Cmd_RemoveTags, ADMFLAG_ROOT, "Opens Tag Removal menu.");
	
	HookUserMessage(GetUserMessageId("SayText2"), OnSayText2, true);
}

public void OnClientPutInServer(int client)
{
	gI_Target[client] = -1;
	gS_Tag[client][0] = '\0';
	
	char[] sSteamId = new char[MAX_NAME_LENGTH];
	GetClientAuthId(client, AuthId_Steam2, sSteamId, MAX_NAME_LENGTH);
	
	char[] sPath = new char[PLATFORM_MAX_PATH];
	BuildPath(Path_SM, sPath, PLATFORM_MAX_PATH, "configs/Tags.cfg");
	
	KeyValues kv = new KeyValues("Tags");
	kv.ImportFromFile(sPath);
 	
	if (kv.JumpToKey(sSteamId, false))
	{
		kv.GetString("Tag", gS_Tag[client], 100);
		FilterColors(gS_Tag[client]);
	}
	delete kv;
}

public Action OnClientSayCommand(int client, const char[] sCmd, const char[] sArgs)
{
	if (IsValidClient(client))
	{
		if (IsChatTrigger())
			return Plugin_Handled;
			
		if (BaseComm_IsClientGagged(client))
		{
			PrintToChat(client, " \x02=================================");
			PrintToChat(client, " \x04Nice Try! You're gagged.");
			PrintToChat(client, " \x10(ノಠ益ಠ)ノ彡\x09┻━┻  \x02YOU MAD?  \x10ლ(ಠ益ಠლ)");
			PrintToChat(client, " \x02=================================");	
			return Plugin_Handled;	
		}
		
		if (IsValidClient(gI_Target[client])) 
		{
			if (strlen(sArgs) < 3)
			{
				PrintToChat(client, "[SM] The name you selected is too short!");
				return Plugin_Handled;
			}
			
			UpdateTag(gI_Target[client], sArgs);
			FormatEx(gS_Tag[gI_Target[client]], 100, sArgs);
			FilterColors(gS_Tag[gI_Target[client]]);
			PrintToChat(client, "[SM] You set \x04%N's\x01 tag to %s", gI_Target[client], gS_Tag[gI_Target[client]]);
			PrintToChat(gI_Target[client], "[SM] \x04%N\x01 has set your Tag to %s", client, gS_Tag[gI_Target[client]]);
			gI_Target[client] = -1;
			return Plugin_Handled;
		}
	}
	return Plugin_Continue;
}

public Action OnSayText2(UserMsg msg_id, Protobuf hUserMsg, const int[] iClients, int iNumClients, bool bReliable, bool bInit)
{
	int client = hUserMsg.ReadInt("ent_idx");

	if (!IsValidClient(client))
		return Plugin_Continue; 
	
	char[] sTranslationName = new char[32];
	hUserMsg.ReadString("msg_name", sTranslationName, 32);
	
	if (sTranslationName[8] == 'N')
		return Plugin_Continue;
		
	bool bTeam = false;
	
	if (sTranslationName[13] == 'T' || sTranslationName[13] == 'C' || sTranslationName[13] == 'S')
		bTeam = true;
	
	char[] sMsg = new char[256];
	char[] sStatus = new char[9];
	char[] sColor = new char[4];
	char[] sString = new char[100];
	
	hUserMsg.ReadString("params", sMsg, 256, 1);
	
	switch (GetClientTeam(client))
	{
		case 1:
		{
			strcopy(sStatus, 9, "\x01*Spec* ");
			strcopy(sColor, 4, "\x03");
		}
		case 2:
		{
			if (!IsPlayerAlive(client))
				strcopy(sStatus, 9, "\x01*DEAD* ");
			strcopy(sColor, 4, "\x09");
		}
		case 3:
		{
			if (!IsPlayerAlive(client))
				strcopy(sStatus, 9, "\x01*DEAD* ");
			strcopy(sColor, 4, "\x0B");	
		}
	}

	if (gS_Tag[client][0] == '\0')
	{
		if (CheckCommandAccess(client, "sm_kick", ADMFLAG_GENERIC))
		{
			if (CheckCommandAccess(client, "sm_rcon", ADMFLAG_ROOT))
				strcopy(sString, 100, "\x02[Owner] ");
			else if (CheckCommandAccess(client, "sm_ban", ADMFLAG_BAN))
				strcopy(sString, 100, "\x04[Admin] ");
			else strcopy(sString, 100, "\x08[Moderator] ");
		}
	}
	else FormatEx(sString, 100, "%s ", gS_Tag[client]);

	char[] sTranslation = new char[256];
	FormatEx(sTranslation, 256, " %s%s%s%N%s\x01: %s", sStatus, sString, sColor, client, (bTeam) ? " \x04(Team)":"", sMsg);

	hUserMsg.SetInt("ent_idx", client);
	hUserMsg.SetBool("chat", true);
	hUserMsg.SetString("msg_name", sTranslation);
	hUserMsg.SetString("params", "", 0);
	hUserMsg.SetString("params", "", 1);
	return Plugin_Changed;
}

public Action Cmd_AddTags(int client, int args)
{
	if (IsValidClient(client))
	{
		char[] sDisplayString = new char[MAX_NAME_LENGTH];
		char[] sInfoString = new char[7];
				
		Menu hMenu = new Menu(Menu_Tags);
		hMenu.SetTitle("Add Tag To\n ");
	
		for (int i = 1; i <= MaxClients; ++i)
		{
			if (IsValidClient(i) && gS_Tag[i][0] == '\0')
			{
				FormatEx(sDisplayString, MAX_NAME_LENGTH, "%N", i);
				FormatEx(sInfoString, 7, "%i", GetClientUserId(i));
				hMenu.AddItem(sInfoString, sDisplayString);
			}
		}
		
		if (hMenu.ItemCount == 0)
		{
			PrintToChat(client, "[SM] There are no players that don't have a Tag!");	
			delete hMenu;
			return Plugin_Handled;
		}
		hMenu.Display(client, MENU_TIME_FOREVER);
	}	
	return Plugin_Handled;	
}

public int Menu_Tags(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client))
			{
				char[] sInfo = new char[7];
				hMenu.GetItem(iParam, sInfo, 7);
				
				int target = GetClientOfUserId(StringToInt(sInfo));
				
				if (IsValidClient(target))
				{
					gI_Target[client] = target;
					PrintToChat(client, "[SM] Type the Tag you want to give to \x04%N", target);	
					PrintToChat(client, "[SM] Include colors by adding brackets with the color name");
					PrintToChat(client, "[SM] \x02{red} \x03{purple} \x04{green} \x06{olive} \x09{yellow} \x0B{blue} \x07{lightred}  \x08{grey} \x01{white} \x10{orange}");						
				}
			}
		}
		case MenuAction_End: delete hMenu;
	}
}

public Action Cmd_RemoveTags(int client, int args)
{
	if (IsValidClient(client))
	{
		char[] sDisplayString = new char[MAX_NAME_LENGTH];
		char[] sInfoString = new char[7];
		
		Menu hMenu = new Menu(Menu_RemoveTags);
		hMenu.SetTitle("Remove Tag From\n ");
	
		for (int i = 1; i <= MaxClients; ++i)
		{
			if (IsValidClient(i) && gS_Tag[i][0] != '\0')
			{				
				FormatEx(sDisplayString, MAX_NAME_LENGTH, "%N", i);
				FormatEx(sInfoString, 7, "%i", GetClientUserId(i));
				hMenu.AddItem(sInfoString, sDisplayString);
			}
		}
		
		if (hMenu.ItemCount == 0)
		{
			PrintToChat(client, "[SM] There are no players that have a Tag!");	
			delete hMenu;
			return Plugin_Handled;
		}
		
		hMenu.Display(client, MENU_TIME_FOREVER);
	}	
	return Plugin_Handled;	
}

public int Menu_RemoveTags(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client))
			{
				char[] sInfo = new char[7];
				hMenu.GetItem(iParam, sInfo, 7);
				
				int target = GetClientOfUserId(StringToInt(sInfo));
				
				if (IsValidClient(target))
				{
					PrintToChat(client, "[SM] You removed \x04%Ns \x01Tag!", target);		
					RemoveTag(target);					
				}
			}
		}
		case MenuAction_End: delete hMenu;
	}
}

void UpdateTag(int client, const char[] sTag)
{
	char[] sSteamId = new char[MAX_NAME_LENGTH];
	GetClientAuthId(client, AuthId_Steam2, sSteamId, MAX_NAME_LENGTH);
	
	char[] sName = new char[MAX_NAME_LENGTH];
	GetClientName(client, sName, MAX_NAME_LENGTH);
	
	char[] sPath = new char[PLATFORM_MAX_PATH];
	BuildPath(Path_SM, sPath, PLATFORM_MAX_PATH, "configs/Tags.cfg");
	
	KeyValues kv = new KeyValues("Tags");
	kv.ImportFromFile(sPath);
	kv.JumpToKey(sSteamId, true);
	kv.SetString("name", sName);
	kv.SetString("tag", sTag);
	kv.Rewind();
	kv.ExportToFile(sPath);
	delete kv;	
}

void RemoveTag(int client)
{
	gS_Tag[client][0] = '\0';
	
	char[] sSteamId = new char[MAX_NAME_LENGTH];
	GetClientAuthId(client, AuthId_Steam2, sSteamId, MAX_NAME_LENGTH);
	
	char[] sPath = new char[PLATFORM_MAX_PATH];
	BuildPath(Path_SM, sPath, PLATFORM_MAX_PATH, "configs/Tags.cfg");
	
	KeyValues kv = new KeyValues("Tags");
	kv.ImportFromFile(sPath);
	
	if (kv.JumpToKey(sSteamId, false))
	{
		kv.DeleteThis();
		kv.Rewind();
		kv.ExportToFile(sPath);
	}
	delete kv;
}

void FilterColors(char[] sString)
{	
	ReplaceString(sString, 128, "{red}", "\x02", false);
	ReplaceString(sString, 128, "{green}", "\x04", false);
	ReplaceString(sString, 128, "{olive}", "\x06", false);
	ReplaceString(sString, 128, "{purple}", "\x03", false);
	ReplaceString(sString, 128, "{yellow}", "\x09", false);
	ReplaceString(sString, 128, "{blue}", "\x0B", false);
	ReplaceString(sString, 128, "{pink}", "\x0E", false);
	ReplaceString(sString, 128, "{grey}", "\x08", false);
	ReplaceString(sString, 128, "{lightred}", "\x07", false);
	ReplaceString(sString, 128, "{white}", "\x01", false);
	ReplaceString(sString, 128, "{orange}", "\x10", false);
}

bool IsValidClient(int client)
{
	if (!(0 < client <= MaxClients) || !IsClientInGame(client) || IsFakeClient(client))
		return false;
	return true;		
}