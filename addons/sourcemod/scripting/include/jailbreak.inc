#if defined _jailbreak_included
	#endinput
#endif

#define _jailbreak_included

/**
 * Retrieves whether a Special Day is Active.
 *
 * @noparam
 * @return					Specialday status
 */
native bool gNB_SpecialDay();

/**
 * Retrieves whether a LastRequest is Active.
 *
 * @noparam
 * @return					LastRequest status
 */
native bool gNB_LastRequest();

/**
 * Sets the freeday status of a player.
 *
 * @param					client's id
 * @param					Give client a freeday?
 * @noreturn					
 */
native void gNB_Freeday(int client, bool bStatus);

/**
 * Retrieves client's credits.
 *
 * @param Index				Client's User ID
 * @return					Client's Credits
 */
native int GetClientCredits(int client);

/**
 * Sets client's credits.
 *
 * @param Index				Client's User ID
 * @param Index				Amount to Set Credits
 */
native void SetClientCredits(int client, int iAmount);


/*===============================================================================================================================*/
/********************************************************* [STOCKS] **************************************************************/
/*===============================================================================================================================*/


stock bool IsValidClient(int client)
{
	if (!(0 < client < MaxClients) || !IsClientInGame(client))
		return false;
	return true;		
}

stock void Log(char[] sPath, char[] sMsg, any ...)
{
	char[] sLogFilePath = new char[PLATFORM_MAX_PATH];
	char[] sFormattedMsg = new char[PLATFORM_MAX_PATH];
	BuildPath(Path_SM, sLogFilePath, PLATFORM_MAX_PATH, "logs/%s", sPath);
	VFormat(sFormattedMsg, PLATFORM_MAX_PATH, sMsg, 3);
	LogToFileEx(sLogFilePath, sFormattedMsg);
}

stock void IsValidServer(char[] ServerIP, int Time = 0)
{
	ConVar IP = FindConVar("hostip");
	int[] iSections = new int[4];
	
	iSections[0] = (IP.IntValue >> 24) & 0x000000FF;
	iSections[1] = (IP.IntValue >> 16) & 0x000000FF;
	iSections[2] = (IP.IntValue >> 8) & 0x000000FF;
	iSections[3] = IP.IntValue & 0x000000FF;

	char[] NetIP = new char[20];
	FormatEx(NetIP, 20, "%d.%d.%d.%d", iSections[0], iSections[1], iSections[2], iSections[3]);
	if (!StrEqual(NetIP, ServerIP)) SetFailState("Plugin only works on \"%s:27015\". Contact the author for more information, LenHard` [STEAM_0:1:42296602]", ServerIP);
	
	if (Time > 0) {
		if (GetTime() >= Time) {
			SetFailState("Plugin usage time has expired! Contact the author for more information, LenHard` [STEAM_0:1:42296602]");
		}
	}
}

public SharedPlugin __pl_Jailbreak =
{
	name = "LenHard_Jailbreak",
	file = "Jailbreak.smx",
#if defined REQUIRE_PLUGIN
	required = 1
#else
	required = 0
#endif
};