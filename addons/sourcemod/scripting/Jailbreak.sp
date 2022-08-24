#include <sourcemod>
#include <sdkhooks>
#include <sdktools>
#include <cstrike>
#include <smartjaildoors>
#include <CustomPlayerSkins>
#include <clientprefs>
#include <geoip>
#include <jailbreak>

#undef REQUIRE_PLUGIN
#include <adminmenu>
#include <basecomm>

#pragma semicolon 1
#pragma newdecls required

// Gangs
#define GANGRANK_OWNER 				2
#define GANGRANK_ADMIN 				1
#define GANGRANK_NORMAL				0
#define MAXGANGNAME					20
#define MAXGANGSIZE					4
#define GANG_CREATE_PRICE			100
#define GANG_RENAME_PRICE			10000
#define UPGRADE_HEALTH_MAX			10
#define UPGRADE_HEALTH_PRICE		1000
#define UPGRADE_DAMAGE_MAX			10
#define UPGRADE_DAMAGE_PRICE		4500
#define UPGRADE_EVADE_MAX			10
#define UPGRADE_EVADE_PRICE			4500
#define UPGRADE_EVADE_CHANCE		70
#define UPGRADE_GRAVITY_MAX			15
#define UPGRADE_GRAVITY_PRICE		4500
#define UPGRADE_STEALING_MAX		5
#define UPGRADE_STEALING_PRICE		4500
#define UPGRADE_DROP_MAX			10
#define UPGRADE_DROP_PRICE			4500
#define UPGRADE_DROP_CHANCE			70
#define UPGRADE_SPEED_MAX			10
#define UPGRADE_SPEED_PRICE			4500
#define UPGRADE_SIZE_MAX			4
#define UPGRADE_SIZE_PRICE			4500

// Shop
#define SHOP_TASER_PRICE			300	
#define SHOP_TAGRENADE_PRICE		150
#define SHOP_HEAL_PRICE				100	
#define SHOP_ARMOR_PRICE			50	
#define SHOP_CLUSTER_PRICE			100	
#define SHOP_CLUSTER_LIMIT			3
#define SHOP_JIHAD_PRICE			235	
#define SHOP_JIHAD_LIMIT			3
#define SHOP_LIGHTS_PRICE			400	
#define SHOP_LIGHTS_LIMIT			1
#define SHOP_EMP_PRICE				600	
#define SHOP_EMP_LIMIT				1
#define SHOP_DISGUISE_PRICE			300	
#define SHOP_DISGUISE_LIMIT			1
#define SHOP_INVISIBILITY_PRICE		500	
#define SHOP_INVISIBILITY_LIMIT		1
#define SHOP_INVISIBLITY_ALPHA		11
#define SHOP_INVISIBILITY_INTERVAL	30.0
#define SHOP_DEAGLE_PRICE			1000	
#define SHOP_DEAGLE_LIMIT			1
#define SHOP_FOOTSTEPS_PRICE		200	
#define SHOP_PARACHUTE_PRICE		200
#define SHOP_PARACHUTE_SPEED		100.0
#define SHOP_PARACHUTE_MODEL		"models/parachute/parachute_carbon.mdl"
#define SHOP_HOOK_PRICE				200
#define SHOP_HOOK_SPEED				700.0

// Credits
#define CREDITS_TRANSFER_FEE		0.3
#define CREDITS_ROUND_WIN			8
#define CREDITS_BOX_COMMON			6

// Ball  
#define BALL_PLAYER_DISTANCE 		35.0
#define BALL_KICK_DISTANCE			50.0
#define BALL_KICK_POWER				550.0
#define BALL_HOLD_HEIGHT 			15
#define BALL_KICK_HEIGHT_ADDITION 	22
#define BALL_RADIUS 				15.0
#define MAXZONELIMIT 				2

// Glow
#define COLOR_RED					1
#define COLOR_BLUE					2
#define	COLOR_GREEN					3
#define	COLOR_PURPLE				4
#define COLOR_PINK					5

// Lastrequest
#define SHOT4SHOTWEAPON_DEAGLE 		0
#define SHOT4SHOTWEAPON_AK47 		1
#define SHOT4SHOTWEAPON_M4A4 		2
#define SHOT4SHOTWEAPON_SCOUT 		3
#define SHOT4SHOTWEAPON_NEGEV 		4
#define SHOT4SHOTWEAPON_MAG7 		5
#define NOSCOPEWEAPON_AWP			0
#define NOSCOPEWEAPON_SCOUT			1
#define NOSCOPEWEAPON_SCAR			2
#define NOSCOPEWEAPON_G3SG1			3
#define MAXKEYLIMIT					7
#define REBELRAMBOHEALTH			100
#define REBELMINPLAYERS				3

// Paint
#define PAINTLIFETIME				25.0

// Special Days
#define SPECIALDAYMINPLAYERS		0
#define SPECIALDAYDELAY				1

// Chat Tags
#define JB_TAG						" \x04[Jailbreak] \x01"
#define GANG_TAG 					" \x03[Gangs]\x01"
#define SHOP_TAG 					" \x02[Black Market] \x01"
#define CASINO_TAG 					" \x07[Casino]\x01"

// Models
#define MODEL_PRISONER1				"models/player/custom_player/kuristaja/jailbreak/prisoner1/prisoner1.mdl"
#define MODEL_PRISONER1_ARMS		"models/player/custom_player/kuristaja/jailbreak/prisoner1/prisoner1_arms.mdl"
#define MODEL_PRISONER2				"models/player/custom_player/kuristaja/jailbreak/prisoner2/prisoner2.mdl"
#define MODEL_PRISONER2_ARMS		"models/player/custom_player/kuristaja/jailbreak/prisoner2/prisoner2_arms.mdl"
#define MODEL_PRISONER3				"models/player/custom_player/kuristaja/jailbreak/prisoner3/prisoner3.mdl"
#define MODEL_PRISONER3_ARMS		"models/player/custom_player/kuristaja/jailbreak/prisoner3/prisoner3_arms.mdl"
#define MODEL_PRISONER4				"models/player/custom_player/kuristaja/jailbreak/prisoner4/prisoner4.mdl"
#define MODEL_PRISONER4_ARMS		"models/player/custom_player/kuristaja/jailbreak/prisoner4/prisoner4_arms.mdl"
#define MODEL_PRISONER5				"models/player/custom_player/kuristaja/jailbreak/prisoner5/prisoner5.mdl"
#define MODEL_PRISONER5_ARMS		"models/player/custom_player/kuristaja/jailbreak/prisoner5/prisoner5_arms.mdl"
#define MODEL_PRISONER6				"models/player/custom_player/kuristaja/jailbreak/prisoner6/prisoner6.mdl"
#define MODEL_PRISONER6_ARMS		"models/player/custom_player/kuristaja/jailbreak/prisoner6/prisoner6_arms.mdl"
#define MODEL_PRISONER7				"models/player/custom_player/kuristaja/jailbreak/prisoner7/prisoner7.mdl"
#define MODEL_PRISONER7_ARMS		"models/player/custom_player/kuristaja/jailbreak/prisoner7/prisoner7_arms.mdl"

#define MODEL_GUARD1				"models/player/custom_player/kuristaja/jailbreak/guard1/guard1.mdl"
#define MODEL_GUARD1_ARMS			"models/player/custom_player/kuristaja/jailbreak/guard1/guard1_arms.mdl"
#define MODEL_GUARD2				"models/player/custom_player/kuristaja/jailbreak/guard2/guard2.mdl"
#define MODEL_GUARD2_ARMS			"models/player/custom_player/kuristaja/jailbreak/guard2/guard2_arms.mdl"
#define MODEL_GUARD3				"models/player/custom_player/kuristaja/jailbreak/guard3/guard3.mdl"
#define MODEL_GUARD3_ARMS			"models/player/custom_player/kuristaja/jailbreak/guard3/guard3_arms.mdl"
#define MODEL_GUARD4				"models/player/custom_player/kuristaja/jailbreak/guard4/guard4.mdl"
#define MODEL_GUARD4_ARMS			"models/player/custom_player/kuristaja/jailbreak/guard4/guard4_arms.mdl"
#define MODEL_GUARD5				"models/player/custom_player/kuristaja/jailbreak/guard5/guard5.mdl"
#define MODEL_GUARD5_ARMS			"models/player/custom_player/kuristaja/jailbreak/guard5/guard5_arms.mdl"

// Sounds
#define SOUND_SHOP_BOOM				"*lenhard/jailbreak/boom.mp3"
#define SOUND_SHOP_JIHAD			"*lenhard/jailbreak/jihad.mp3"

#define SOUND_BOX_PICKUP			"*lenhard/jailbreak/item_box.mp3"
#define SOUND_BOX_MONEY1			"*lenhard/jailbreak/item_box_money1.mp3"
#define SOUND_BOX_MONEY2			"*lenhard/jailbreak/item_box_money2.mp3"

#define SOUND_BOUNTY_ACHIEVED		"*lenhard/jailbreak/bountyhunter.mp3"

#define SOUND_GANG_EVADE			"*lenhard/jailbreak/evade.mp3"

#define SOUND_BALL_BOUNCE			"*knastjunkies/bounce.mp3"
#define SOUND_BALL_GOAL				"*lenhard/jailbreak/soccergoal2.mp3"

#define SOUND_HOOK_HIT				"*lenhard/jailbreak/hook_hit.mp3"
#define SOUND_HOOK_HITPLAYER		"*lenhard/jailbreak/hook_hitbody.mp3"
#define SOUND_HOOK_MISS				"*lenhard/jailbreak/hook_miss.mp3"

#define SOUND_C4_1					"*lenhard/jailbreak/c4_beep1.mp3"
#define SOUND_C4_2					"*lenhard/jailbreak/c4_beep2.mp3"
#define SOUND_C4_3					"*lenhard/jailbreak/c4_beep3.mp3"
#define SOUND_C4_4					"*lenhard/jailbreak/c4_beep4.mp3"
#define SOUND_C4_5					"*lenhard/jailbreak/c4_beep5.mp3"

#define SOUND_SD_CHAMBER			"*lenhard/jailbreak/oitc.mp3"
#define SOUND_SD_SCOUTZKNIVEZ 		"*lenhard/jailbreak/scoutzknivez.mp3"
#define SOUND_SD_SOLOWIN			"*lenhard/jailbreak/solowin.mp3"
#define SOUND_SD_SOLOLOSE			"*lenhard/jailbreak/sololose.mp3"
#define SOUND_SD_LOSELEVEL			"*lenhard/jailbreak/loselevel.mp3"
#define SOUND_SD_LEVELUP			"*lenhard/jailbreak/levelup.mp3"
#define SOUND_SD_KNIFELEVEL			"*lenhard/jailbreak/knifelevel.mp3"
#define SOUND_SD_GAINPOINT			"*lenhard/jailbreak/gainpoint.mp3"
#define SOUND_SD_FORCEPUSH			"*lenhard/jailbreak/forcepush.mp3"
#define SOUND_SD_NADEDAY			"*lenhard/jailbreak/nadewar.mp3"
#define SOUND_SD_KNIFEDAY			"*lenhard/jailbreak/knifebattle.mp3"
#define SOUND_SD_JEDI				"*lenhard/jailbreak/jedi.mp3"
#define SOUND_SD_SHARK				"*lenhard/jailbreak/shark.mp3"
#define SOUND_SD_NIGHTCRAWLER		"*lenhard/jailbreak/nightcrawler.mp3"
#define SOUND_SD_TRIGGER			"*lenhard/jailbreak/triggerdiscipline.mp3"
#define SOUND_SD_GUNGAME			"*lenhard/jailbreak/gungame.mp3"
#define SOUND_SD_TELEPORT			"*lenhard/jailbreak/teleport.mp3"
#define SOUND_SD_GANGWAR			"*lenhard/jailbreak/gangwar.mp3"

#define SOUND_LR_RAMBO				"*lenhard/jailbreak/rambo.mp3"
#define SOUND_LR_BOOM				"*lenhard/jailbreak/boom.mp3"
#define SOUND_LR_CORRECT			"*lenhard/jailbreak/lrcorrect.mp3"
#define SOUND_LR_WRONG				"*lenhard/jailbreak/lrwrong.mp3"

#define SOUND_MG_WHISTLE			"*lenhard/jailbreak/whistle.mp3"
#define SOUND_MG_ON					"*lenhard/jailbreak/mgon.mp3"

#define SOUND_PRISONERS_WIN			"*lenhard/jailbreak/prisonerswin.mp3"
#define SOUND_GUARDS_WIN			"*lenhard/jailbreak/guardswin.mp3"

enum LastRequest
{
	LASTREQUEST_INVALID = -1,
	LASTREQUEST_KNIFE,
	LASTREQUEST_SHOT4SHOT,
	LASTREQUEST_NADE,
	LASTREQUEST_NOSCOPE,
	LASTREQUEST_SHOTGUN,
	LASTREQUEST_GUNTOSS,
	LASTREQUEST_RACE,
	LASTREQUEST_HEADSHOT,
	LASTREQUEST_KEYS,
	LASTREQUEST_TYPING,
	LASTREQUEST_REBEL
};

enum SpecialDay
{
	SPECIALDAY_INVALID = -1,
	SPECIALDAY_KNIFE,
	SPECIALDAY_KILLCONFIRM,
	SPECIALDAY_GANG,
	SPECIALDAY_NOSCOPE,
	SPECIALDAY_SCOUTZKNIVEZ,
	SPECIALDAY_ONEINACHAMBER,
	SPECIALDAY_NADE,
	SPECIALDAY_HEADSHOT ,
	SPECIALDAY_JEDI,
	SPECIALDAY_SHARK,
	SPECIALDAY_NIGHTCRAWLER,
	SPECIALDAY_COCKTAIL,
	SPECIALDAY_TRIGGER,
	SPECIALDAY_GUNGAME,
	SPECIALDAY_VOTE
};

LastRequest gH_LastRequest = LASTREQUEST_INVALID;
SpecialDay gH_SpecialDay = SPECIALDAY_INVALID;

ArrayList gA_Buttons;
ArrayList gA_ButtonMode;
ArrayList gA_ButtonName;
ArrayList gA_Entities;
ArrayList gA_EntityNames;
ArrayList gA_SpawnLocation;

bool gB_GunMenu[MAXPLAYERS + 1];
bool gB_GuardMenu[MAXPLAYERS + 1];
bool gB_Freeday[MAXPLAYERS + 1];
bool gB_FreedayNext[MAXPLAYERS + 1];
bool gB_Paint[MAXPLAYERS + 1];
bool gB_PlayerSteps[MAXPLAYERS + 1];
bool gB_SetName[MAXPLAYERS + 1];
bool gB_Loaded[MAXPLAYERS + 1];
bool gB_HasGang[MAXPLAYERS + 1];
bool gB_Rename[MAXPLAYERS + 1];
bool gB_Health[MAXPLAYERS + 1];
bool gB_Armor[MAXPLAYERS + 1];
bool gB_Nade[MAXPLAYERS + 1];
bool gB_ClusterNade[MAXPLAYERS + 1];
bool gB_TANade[MAXPLAYERS + 1];
bool gB_Disguise[MAXPLAYERS + 1];
bool gB_Jihad[MAXPLAYERS + 1];
bool gB_Invisiblity[MAXPLAYERS + 1];
bool gB_Parachute[MAXPLAYERS + 1];
bool gB_Taser[MAXPLAYERS + 1];
bool gB_Deag[MAXPLAYERS + 1];
bool gB_Light[MAXPLAYERS + 1];
bool gB_EMP[MAXPLAYERS + 1];
bool gB_GangInvitation[MAXPLAYERS + 1];
bool gB_ParachuteOpened[MAXPLAYERS + 1];
bool gB_Hooking[MAXPLAYERS + 1];
bool gB_Hooked[MAXPLAYERS + 1];
bool gB_Hook[MAXPLAYERS + 1];
bool gB_FreeDay;
bool gB_Cells;
bool gB_Shove;
bool gB_KnifeDuel;
bool gB_Expired;
bool gB_TickingTimeBomb;
bool gB_Math;
bool gB_Ratio;
bool gB_LastRequest_Available;
bool gB_FreeForAll;
bool gB_DeathBall;
bool gB_Late;
bool gB_BaseComm;
bool gB_BallSpawnExists;

char gS_GangName[MAXPLAYERS + 1][MAX_NAME_LENGTH];
char gS_InvitedBy[MAXPLAYERS + 1][MAX_NAME_LENGTH];
char gS_SteamID[MAXPLAYERS + 1][MAX_NAME_LENGTH];
char gS_TypingPhrase[300];
char gS_Map[100];

ConVar gCV_Block;
ConVar gCV_FriendlyFire;
ConVar gCV_InfiniteAmmo;
ConVar gCV_Gravity;
ConVar gCV_Footsteps;
ConVar gCV_Respawn;
ConVar gCV_Radar;
ConVar gCV_HeadshotOnly;
ConVar gCV_SelfDamage;

Database gD_Database;

float gF_RevivePosition[MAXPLAYERS + 1][3];
float gF_HookLocation[MAXPLAYERS + 1][3];
float gF_Laser[MAXPLAYERS + 1][3];
float gF_Pushed[MAXPLAYERS + 1];
float gF_MakerPos[3];
float gF_BallSpawnOrigin[3];
float gF_ZonePoint1[MAXZONELIMIT][3];
float gF_ZonePoint2[MAXZONELIMIT][3];
float gF_CagePosition[3];
 
int gI_ClientBan[MAXPLAYERS + 1] 			= {-1, ...};
int gI_PrimaryWeapon[MAXPLAYERS + 1] 		= {-1, ...};
int gI_SecondaryWeapon[MAXPLAYERS + 1] 		= {-1, ...};
int gI_ClientVote[MAXPLAYERS + 1] 	 		= {-1, ...};
int gI_CheckHealth[MAXPLAYERS+1]			= {-1, ...};
int gI_Rank[MAXPLAYERS + 1] 				= {-1, ...};
int gI_Invitation[MAXPLAYERS + 1] 			= {-1, ...};
int gI_DateJoined[MAXPLAYERS + 1]			= {-1, ...};
int gI_GameMode[MAXPLAYERS + 1] 			= {-1, ...};
int gI_ParachuteEntityRef[MAXPLAYERS + 1] 	= {INVALID_ENT_REFERENCE, ...};
int gI_HookRef[MAXPLAYERS + 1] 				= {INVALID_ENT_REFERENCE, ...};
int gI_HookTarget[MAXPLAYERS + 1] 			= {-1, ...};
int gI_GangSize[MAXPLAYERS + 1];
int gI_Health[MAXPLAYERS + 1];
int gI_Damage[MAXPLAYERS + 1];
int gI_Evade[MAXPLAYERS + 1];
int gI_Gravity[MAXPLAYERS + 1];
int gI_Speed[MAXPLAYERS + 1];
int gI_Stealing[MAXPLAYERS + 1];
int gI_WeaponDrop[MAXPLAYERS + 1];
int gI_Size[MAXPLAYERS + 1];
int gI_TempInt[MAXPLAYERS + 1];
int gI_TempInt2[MAXPLAYERS + 1];
int gI_Credits[MAXPLAYERS + 1];
int gI_BetAmount[MAXPLAYERS + 1];
int gI_Dealer[MAXPLAYERS + 1];
int gI_DealerCard[MAXPLAYERS + 1];
int gI_ClientCards[MAXPLAYERS + 1];
int gI_CasinoWins[MAXPLAYERS + 1];
int gI_CasinoLoses[MAXPLAYERS + 1];
int gI_BountyIndex[MAXPLAYERS + 1];
int gI_BountyTarget[MAXPLAYERS + 1][MAXPLAYERS + 1];
int gI_Bounty[MAXPLAYERS + 1];
int gI_Activity[MAXPLAYERS + 1];
int gI_ClientStatus[MAXPLAYERS + 1];
int gI_ButtonsPressed[MAXPLAYERS + 1];
int gI_LastButtons[MAXPLAYERS + 1];
int gI_HitGroup[MAXPLAYERS + 1][MAXPLAYERS + 1];
int gI_Fuel[MAXPLAYERS + 1];
int gI_LRHealth[MAXPLAYERS + 1];
int gI_GangKills[MAXPLAYERS + 1];
int gI_StatsGuardKills[MAXPLAYERS + 1];
int gI_StatsPrisonerKills[MAXPLAYERS + 1];
int gI_StatsSpecialDayKills[MAXPLAYERS + 1];
int gI_StatsLastRequestKills[MAXPLAYERS + 1];
int gI_StatsPlayTime[MAXPLAYERS + 1];
int gI_PrisonerModel[MAXPLAYERS + 1];
int gI_GuardModel[MAXPLAYERS + 1];
int gI_MovementKeys[MAXKEYLIMIT];
int gI_Sprites[2] = {-1, ...};
int gI_Warden = -1;
int gI_Round = -1;
int gI_Answer = -1;
int gI_Guard = -1;
int gI_Prisoner = -1;
int gI_LastRequestWeapon = -1;
int gI_SpecialDay = -1;
int gI_DayDelay = -1;
int gI_DaySelected = -1;
int gI_Owner = -1;
int gI_Ball = -1;
int gI_GoalZoneCreator = -1;
int gI_Zones = -1;
int gI_TempZone = -1;
int gI_Spawns = -1;
int gI_Cells;
int gI_BallHolder;
int gI_Seconds;
int gI_Freedays;
int gI_JihadCount;
int gI_InvisiblityCount;
int gI_DisguiseCount;
int gI_DeagCount;
int gI_LightCount;
int gI_EMPCount;
int gI_GrenadeCount;

Handle gH_ButtonsReset[MAXPLAYERS + 1];
Handle gH_WeaponsCookie;
Handle gH_GuardCookie;
Handle gH_ModelCookie;

KeyValues gK_GuardBans;

TopMenu gT_TopMenu;

public Plugin myinfo =
{
	name = "[CS:GO] Jailbreak",
	author = "LenHard"
};

public APLRes AskPluginLoad2(Handle hMyself, bool bLate, char[] sError, int iErr_max)
{
	CreateNative("gNB_SpecialDay", Native_SpecialDay);
	CreateNative("gNB_LastRequest", Native_LastRequest);
	CreateNative("gNB_Freeday", Native_Freeday);
	CreateNative("GetClientCredits", Native_GetClientCredits);
	CreateNative("SetClientCredits", Native_SetClientCredits);
	
	MarkNativeAsOptional("gNB_SpecialDay");
	MarkNativeAsOptional("gNB_LastRequest");
	MarkNativeAsOptional("gNB_Freeday");
	MarkNativeAsOptional("GetClientCredits");
	MarkNativeAsOptional("SetClientCredits");
	
	RegPluginLibrary("LenHard_Jailbreak");
	gB_Late = bLate;
	return APLRes_Success;
}

public int Native_SpecialDay(Handle hHandler, int iNumParams)
{
	if (gH_SpecialDay != SPECIALDAY_INVALID)
		return true;
	else
		return false;
}

public int Native_LastRequest(Handle hHandler, int iNumParams)
{
	if (gH_LastRequest != LASTREQUEST_INVALID)
		return true;
	else
		return false;
}

public int Native_Freeday(Handle hHandler, int iNumParams)
{
	int client = GetNativeCell(1);
	gB_Freeday[client] = view_as<bool>(GetNativeCell(2));
}

public int Native_GetClientCredits(Handle hPlugin, int iParams)
{
	int client = GetNativeCell(1);
	return gI_Credits[client];
}

public int Native_SetClientCredits(Handle hPlugin, int iParams)
{
	int client = GetNativeCell(1);
	gI_Credits[client] = GetNativeCell(2);
}


/*===============================================================================================================================*/
/********************************************************* [ONLOADS] *************************************************************/
/*===============================================================================================================================*/


public void OnPluginStart()
{
	IsValidServer("192.223.26.140");
	
	char[] sPath = new char[PLATFORM_MAX_PATH];
	BuildPath(Path_SM, sPath, PLATFORM_MAX_PATH, "configs/jailbreak/");
	
	if (!DirExists(sPath))
	{
		CreateDirectory(sPath, 511);
		if (!DirExists(sPath)) SetFailState("Failed to create directory at /sourcemod/configs/jailbreak/ - Please manually create that path and reload this plugin.");
	}
	
	LoadTranslations("common.phrases");
	
	RegConsoleCmd("buyammo1", Cmd_PreMenu, "Opens Guard/Prisoner/Spectator Menu.");
	RegConsoleCmd("buyammo2", Cmd_PreMenu, "Opens Guard/Prisoner/Spectator Menu.");
	RegConsoleCmd("sm_menu", Cmd_PreMenu, "Opens Guard/Prisoner/Spectator Menu.");
	RegConsoleCmd("sm_open", Cmd_OpenCells, "Opens the cells.");
	RegConsoleCmd("sm_close", Cmd_CloseCells, "Close the cells.");
	RegConsoleCmd("sm_days", Cmd_OpenSpecialDay, "Open Special Days.");
	RegConsoleCmd("sm_mini", Cmd_OpenMiniGames, "Open Mini Games Menu.");
	RegConsoleCmd("sm_fd", Cmd_OpenFreeDay, "Open Freeday Menu.");
	RegConsoleCmd("sm_heal", Cmd_OpenHealMenu, "Open Heal Menu.");
	RegConsoleCmd("sm_glow", Cmd_OpenGlowMenu, "Open Glow Menu.");
	RegConsoleCmd("sm_qrevive", Cmd_OpenReviveMenu, "Open Quick Revive Menu.");
	RegConsoleCmd("sm_tools", Cmd_OpenToolMenu, "Open Tools Menu.");
	RegConsoleCmd("sm_warden", Cmd_TransferWarden, "Transfer Warden.");
	RegConsoleCmd("sm_guns", Cmd_Guns, "Opens Gun Menu.");
	RegConsoleCmd("sm_math", Cmd_Math, "Start a Math challenge.");
	RegConsoleCmd("sm_lr", Cmd_LastRequest, "Opens the Last Request menu.");
	RegConsoleCmd("sm_rules", Cmd_Rules, "Opens Jailbreak Rules.");
	RegConsoleCmd("sm_ball", Cmd_Ball, "Acquire the ball.");
	RegConsoleCmd("sm_reset", Cmd_BallReset, "Reset the ball.");
	RegConsoleCmd("sm_gang", Cmd_GangMenu, "Open the gang menu.");
	RegConsoleCmd("sm_gangs", Cmd_GangMenu, "Open the gang menu.");
	RegConsoleCmd("sm_gsay", Cmd_GangText, "Communicate with other gang members.");
	RegConsoleCmd("sm_donate", Cmd_DonateCredits, "Donate credits to another player.");
	RegConsoleCmd("sm_store", Cmd_Shop, "Open the shop menu.");
	RegConsoleCmd("sm_shop", Cmd_Shop, "Open the shop menu.");
	RegConsoleCmd("sm_credits", Cmd_CheckCredits, "Check other players credits.");
	RegConsoleCmd("sm_casino", Cmd_Casino, "Opens the casino.");
	RegConsoleCmd("sm_bet", Cmd_Casino, "Opens the casino.");
	RegConsoleCmd("sm_stats", Cmd_Stats, "Opens Stats menu.");
	RegConsoleCmd("sm_bounty", Cmd_Bounty, "Opens Bounty menu.");
	
	RegAdminCmd("sm_addguardban", Cmd_AddGuardBan, ADMFLAG_BAN, "Adding Guard ban to offline players.");
	RegAdminCmd("sm_removeguardban", Cmd_RemoveGuardBan, ADMFLAG_UNBAN, "Removes a guardban from offline players.");
	RegAdminCmd("sm_guardban", Cmd_GuardBan, ADMFLAG_BAN, "Guard ban players.");
	RegAdminCmd("sm_unguardban", Cmd_UnGuardBan, ADMFLAG_UNBAN, "Unguard ban players.");
	RegAdminCmd("sm_revive", Cmd_Respawn, ADMFLAG_GENERIC, "Revive players.");
	RegAdminCmd("sm_transfer", Cmd_Transfer, ADMFLAG_GENERIC, "Transfer players.");
	RegAdminCmd("sm_endround", Cmd_EndRound, ADMFLAG_GENERIC, "Ends the round.");
	RegAdminCmd("sm_stack", Cmd_Stack, ADMFLAG_GENERIC, "Stacks a person upon another");
	RegAdminCmd("sm_bury", Cmd_Bury, ADMFLAG_GENERIC, "Burys a player underground.");
	RegAdminCmd("sm_unbury", Cmd_UnBury, ADMFLAG_GENERIC, "Unburys a player from underground.");
	RegAdminCmd("sm_weapon", Cmd_Weapons, ADMFLAG_GENERIC, "Give player(s) a weapon.");
	RegAdminCmd("sm_hp", Cmd_Health, ADMFLAG_GENERIC, "Set player(s) health.");
	RegAdminCmd("sm_exec", Cmd_Exec, ADMFLAG_BAN, "Execute console commands upon player(s)");
	RegAdminCmd("sm_jbmenu", Cmd_JailbreakMenu, ADMFLAG_ROOT, "Opens the jailbreak menu.");
	RegAdminCmd("sm_spawncredits", Cmd_SpawnCredits, ADMFLAG_ROOT, "Spawns credits to player(s).");
	
	AddCommandListener(CL_Block, "coverme");
	AddCommandListener(CL_Block, "takepoint");
	AddCommandListener(CL_Block, "holdpos");
	AddCommandListener(CL_Block, "regroup");
	AddCommandListener(CL_Block, "followme");
	AddCommandListener(CL_Block, "takingfire");
	AddCommandListener(CL_Block, "cheer");
	AddCommandListener(CL_Block, "thanks");
	AddCommandListener(CL_Block, "go");
	AddCommandListener(CL_Block, "fallback");
	AddCommandListener(CL_Block, "sticktog");
	AddCommandListener(CL_Block, "getinpos");
	AddCommandListener(CL_Block, "stormfront");
	AddCommandListener(CL_Block, "report");
	AddCommandListener(CL_Block, "roger");
	AddCommandListener(CL_Block, "enemyspot");
	AddCommandListener(CL_Block, "needbackup");
	AddCommandListener(CL_Block, "sectorclear");
	AddCommandListener(CL_Block, "inposition");
	AddCommandListener(CL_Block, "reportingin");
	AddCommandListener(CL_Block, "getout");
	AddCommandListener(CL_Block, "negative");
	AddCommandListener(CL_Block, "enemydown");
	AddCommandListener(CL_JoinTeam, "jointeam");
	
	AddNormalSoundHook(Event_SoundPlayed);
	
	HookEvent("round_start", Event_RoundStart, EventHookMode_Post);
	HookEvent("round_end", Event_RoundEnd, EventHookMode_Pre);
	HookEvent("player_activate", Event_PlayerActiviate, EventHookMode_Post);
	HookEvent("player_hurt", Event_PlayerHurtPre, EventHookMode_Pre);
	HookEvent("player_hurt", Event_PlayerHurt, EventHookMode_Post);
	HookEvent("player_spawn", Event_PlayerSpawn, EventHookMode_Post);
	HookEvent("player_death", Event_PlayerDeathPre, EventHookMode_Pre);
	HookEvent("player_death", Event_PlayerDeath, EventHookMode_Post);
	HookEvent("player_team", Event_PlayerTeamPre, EventHookMode_Pre); 
	HookEvent("player_team", Event_PlayerTeam, EventHookMode_Post); 
	HookEvent("player_disconnect", Event_PlayerDisconnect, EventHookMode_Pre);
	HookEvent("server_cvar", Event_ServerCvar, EventHookMode_Pre);
	HookEvent("weapon_fire", Event_WeaponFire, EventHookMode_Pre);
	HookEvent("hegrenade_detonate", Event_GrenadeDetonate, EventHookMode_Post);
	HookEvent("molotov_detonate", Event_MolotovDetonate, EventHookMode_Post);
	
	HookUserMessage(GetUserMessageId("TextMsg"), OnTextMsg, true); 
	
	HookEntityOutput("func_button", "OnPressed", Event_ButtonPress);
	
	gCV_Block = FindConVar("mp_solid_teammates");
	gCV_FriendlyFire = FindConVar("mp_teammates_are_enemies");
	gCV_InfiniteAmmo = FindConVar("sv_infinite_ammo");
	gCV_Gravity = FindConVar("sv_gravity");
	gCV_Footsteps = FindConVar("sv_footsteps");
	gCV_Respawn = FindConVar("mp_respawn_on_death_t");
	gCV_Radar = FindConVar("mp_radar_showall");
	gCV_HeadshotOnly = FindConVar("mp_damage_headshot_only");
	gCV_SelfDamage = FindConVar("mp_weapon_self_inflict_amount");
	
	gH_WeaponsCookie = RegClientCookie("Weapons", "Saves the player's weapons", CookieAccess_Protected);
	gH_GuardCookie = RegClientCookie("Guard", "If the player approves the rules", CookieAccess_Protected);
	gH_ModelCookie = RegClientCookie("Models", "Player models.", CookieAccess_Protected);
	
	if (LibraryExists("adminmenu"))
	{
		TopMenu hTopMenu = null;
		
		if ((hTopMenu = GetAdminTopMenu()) != null)
			OnAdminMenuReady(hTopMenu);
	}
	
	gA_Buttons = new ArrayList(50);
	gA_ButtonMode = new ArrayList(50);
	gA_ButtonName = new ArrayList(64);
	gA_Entities = new ArrayList(50);
	gA_EntityNames = new ArrayList(64);
	gA_SpawnLocation = new ArrayList(100);
	
	if (gB_Late)
	{
		OnMapStart();
		
		for (int i = 1; i <= MaxClients; ++i)
		{
			if (IsClientInGame(i))
			{
				OnClientConnected(i);
				OnClientPutInServer(i);	
				OnClientPostAdminCheck(i);
				
				if (AreClientCookiesCached(i))
					OnClientCookiesCached(i);
			}
		}
		
		FindConVar("mp_restartgame").SetInt(1);
		gB_Late = false;
	}
	else LoadSQL();
}

public void OnPluginEnd()
{
	for (int i = 1; i <= MaxClients; ++i)
		if (IsClientInGame(i) && !IsFakeClient(i)) 
			UpdateSQL(i);
}

public void OnAllPluginsLoaded()
{	
	gB_BaseComm = LibraryExists("basecomm");
}

public void OnLibraryAdded(const char[] sName)
{
	if (StrEqual(sName, "adminmenu"))
	{
		TopMenu hTopMenu = null;
		
		if ((hTopMenu = GetAdminTopMenu()) != null)
			OnAdminMenuReady(hTopMenu);
	}
	
	if (StrEqual(sName, "basecomm"))
		gB_BaseComm = true;
}

public void OnLibraryRemoved(const char[] sName)
{
	if (StrEqual(sName, "basecomm"))
		gB_BaseComm = false;
}

public void OnMapStart()
{
	LoadSQL();	
	GetCurrentMap(gS_Map, sizeof(gS_Map));
	ResetMarker();
	
	gI_GoalZoneCreator = -1;
	gI_Owner = -1;
	gI_Warden = -1;
	gI_Round = 0;
	gI_SpecialDay = -1;
	gI_DayDelay = -1;
	gI_Spawns = -1;
	gI_DaySelected = -1;
	gB_FreeForAll = false;

	CreateTimer(0.1, Timer_DrawEverything, INVALID_HANDLE, TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
	CreateTimer(1.1, Timer_PlayTime, INVALID_HANDLE, TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
	
	PrecacheModel("models/chicken/chicken.mdl");
	PrecacheModel("models/player/tm_pirate_variantc.mdl");
	PrecacheModel("models/weapons/t_arms_pirate.mdl");
	PrecacheModel("models/player/tm_anarchist_variantd.mdl");
	PrecacheModel("models/weapons/t_arms_anarchist.mdl");
	
	gI_Sprites[0] = PrecacheModel("materials/sprites/laserbeam.vmt");
	gI_Sprites[1] = PrecacheModel("materials/sprites/halo01.vmt");
	
	FindConVar("mp_give_player_c4").SetInt(0);
	FindConVar("sv_allow_thirdperson").SetInt(1);
	FindConVar("mp_friendlyfire").SetInt(1);
	FindConVar("mp_teamname_1").SetString("Guards");
	FindConVar("mp_teamname_2").SetString("Prisoners");
	FindConVar("sv_noclipspeed").SetFloat(3.0);
	FindConVar("sv_noclipaccelerate").SetInt(3);
	FindConVar("CS_WarnFriendlyDamageInterval").SetString("9999999", true);
	FindConVar("mp_ignore_round_win_conditions").SetInt(1);
	FindConVar("mp_endmatch_votenextmap").SetInt(0);
	
	gA_Buttons.Clear();
	gA_SpawnLocation.Clear();
	gA_ButtonMode.Clear();
	gA_ButtonName.Clear();
	gA_Entities.Clear();
	gA_EntityNames.Clear();

	char[] sPath = new char[PLATFORM_MAX_PATH];

	gK_GuardBans = new KeyValues("GuardBans");
	BuildPath(Path_SM, sPath, PLATFORM_MAX_PATH, "configs/jailbreak/guardbans.cfg");
	gK_GuardBans.ImportFromFile(sPath);

	KeyValues kv = new KeyValues("Triggers");
	BuildPath(Path_SM, sPath, PLATFORM_MAX_PATH, "configs/jailbreak/Triggers.cfg");
	kv.ImportFromFile(sPath);
	
	if (kv.JumpToKey(gS_Map, false))
	{
		char[] sFormat = new char[50];
		
		if (kv.GotoFirstSubKey())
		{
			do
			{
				kv.GetString("entity", sFormat, 50);
				gA_ButtonName.PushString(sFormat);
				gA_Buttons.Push(kv.GetNum("index"));
				gA_ButtonMode.Push(kv.GetNum("mode"));
			}
			while (kv.GotoNextKey());
			kv.Rewind();
		}
	}
	
	kv = new KeyValues("Entities");
	BuildPath(Path_SM, sPath, PLATFORM_MAX_PATH, "configs/jailbreak/Entities.cfg");
	kv.ImportFromFile(sPath);
 
	if (kv.JumpToKey(gS_Map, false))
	{
		char[] sFormat = new char[50];
		
		if (kv.GotoFirstSubKey())
		{
			do 
			{
				kv.GetString("entity", sFormat, 50);
				gA_EntityNames.PushString(sFormat);
				
				kv.GetString("origin", sFormat, 50);
				gA_Entities.PushString(sFormat);
			}
			while (kv.GotoNextKey());
			kv.Rewind();
		}
	}
	
	kv = new KeyValues("Spawns");
	BuildPath(Path_SM, sPath, PLATFORM_MAX_PATH, "configs/jailbreak/ballspawns.cfg");
	kv.ImportFromFile(sPath);

	if (kv.JumpToKey(gS_Map, false))
	{
		gF_BallSpawnOrigin[0] = kv.GetFloat("x");
		gF_BallSpawnOrigin[1] = kv.GetFloat("y");
		gF_BallSpawnOrigin[2] = kv.GetFloat("z");
		
		gB_BallSpawnExists = true;
	}
	kv.Rewind();
	
	kv = new KeyValues("Taser Spawns");
	BuildPath(Path_SM, sPath, PLATFORM_MAX_PATH, "configs/jailbreak/Taserspawns.cfg");
	kv.ImportFromFile(sPath);
 
	if (kv.JumpToKey(gS_Map, false))
	{
		gF_CagePosition[0] = kv.GetFloat("X");
		gF_CagePosition[1] = kv.GetFloat("Y");
		gF_CagePosition[2] = kv.GetFloat("Z");
	}
	kv.Rewind();
	
	kv = new KeyValues("Zones");
	BuildPath(Path_SM, sPath, PLATFORM_MAX_PATH, "configs/jailbreak/goalzones.cfg");
	kv.ImportFromFile(sPath);

	gI_Zones = -1;
	
	for (int i = 0; i < MAXZONELIMIT; ++i)
	{
		for (int i2 = 0; i2 < 3; ++i2)		
		{						
			gF_ZonePoint1[i][i2] = 0.0;
			gF_ZonePoint2[i][i2] = 0.0;
		}
	}
	
	if (kv.JumpToKey(gS_Map, false))
	{
		if (kv.GotoFirstSubKey())
		{
			do 
			{
				++gI_Zones;
				gF_ZonePoint1[gI_Zones][0] = kv.GetFloat("x1");
				gF_ZonePoint1[gI_Zones][1] = kv.GetFloat("y1");
				gF_ZonePoint1[gI_Zones][2] = kv.GetFloat("z1");
				gF_ZonePoint2[gI_Zones][0] = kv.GetFloat("x2");
				gF_ZonePoint2[gI_Zones][1] = kv.GetFloat("y2");
				gF_ZonePoint2[gI_Zones][2] = kv.GetFloat("z2");
			}
			while (kv.GotoNextKey());
			kv.Rewind();
		}
	}
	
	kv = new KeyValues("Spawns");
	BuildPath(Path_SM, sPath, PLATFORM_MAX_PATH, "configs/jailbreak/Spawns.cfg");
	kv.ImportFromFile(sPath);
 
	if (kv.JumpToKey(gS_Map, false))
	{
		char[] sFormat = new char[100];
		
		if (kv.GotoFirstSubKey())
		{
			do 
			{
				++gI_Spawns;
				kv.GetString("location", sFormat, 100);
				gA_SpawnLocation.PushString(sFormat);
 			}
			while (kv.GotoNextKey());
			kv.Rewind();
		}
	}
	delete kv;
}

public void OnMapEnd()
{
	for (int i = 1; i <= MaxClients; ++i)
		if (IsClientInGame(i))
			delete gH_ButtonsReset[i];		
			
	delete gK_GuardBans;
}

public void OnClientConnected(int client)
{
	ResetCasino(client);
	ResetVariables(client, true);
	
	gB_Paint[client] = false;
	gB_PlayerSteps[client] = false;
	gB_Parachute[client] = false;
	gB_Freeday[client] = false;
	gB_FreedayNext[client] = false;

	for (int x = 0; x < 3; ++x)
	{
		gF_Laser[client][x] = 0.0;	
		gF_RevivePosition[client][x] = 0.0;
	}
	
	gI_ClientVote[client] = -1;
	gI_ClientStatus[client] = 0;
	gI_ClientBan[client] = -1;
	gI_Activity[client] = 0;
	gI_Bounty[client] = 0;
	gI_BountyIndex[client] = 0;
	gI_BetAmount[client] = 0;
	gI_LastButtons[client] = 0;
	gI_ButtonsPressed[client] = 0;
	gI_LRHealth[client] = 0;
	gI_StatsGuardKills[client] = 0;
	gI_StatsPrisonerKills[client] = 0;
	gI_StatsSpecialDayKills[client] = 0;
	gI_StatsLastRequestKills[client] = 0;
	gI_StatsPlayTime[client] = 0;
	gI_GangKills[client] = 0;
	gI_PrisonerModel[client] = 0;
	gI_GuardModel[client] = 0;
}

public void OnClientPutInServer(int client) 
{ 	
	if (!IsFakeClient(client))
	{
		CheckBans(client);
		
		SendConVarValue(client, gCV_Footsteps, "0");
		
		SDKHook(client, SDKHook_PostThinkPost, OnPostThinkPost);
		SDKHook(client, SDKHook_OnTakeDamage, OnTakeDamage); 
		SDKHook(client, SDKHook_WeaponCanUse, OnWeaponDecideUse); 
		SDKHook(client, SDKHook_TraceAttack, OnTraceAttack);
		
		if (!gB_Late) 
		{
			char[] sCountry = new char[50];
			char[] sIP = new char[32];
			
			GetClientIP(client, sIP, 32, true);
			
			if (GeoipCountry(sIP, sCountry, 50))
				PrintToChatAll("Player \x03%N \x01has joined from \x04%s", client, sCountry);
			else
				PrintToChatAll("Player \x03%N \x01has joined the server.", client);
		}
	}
}

public void OnClientPostAdminCheck(int client)
{
	if (!IsFakeClient(client))
	{
		LoadSteamID(client);
		
		if (gB_HasGang[client]) {
			PrintToGang(client, false, "%s Gang member \x09%N\x01 has joined the game!", GANG_TAG, client);
		}
	}
}

public void OnClientCookiesCached(int client)
{
    char[] sValue = new char[6];
    GetClientCookie(client, gH_WeaponsCookie, sValue, 6);
    
    if (sValue[0] != '\0')
    {
    	char[][] sBuffer = new char[2][5];
    	ExplodeString(sValue, ";", sBuffer, 2, 5);
    	
    	gI_PrimaryWeapon[client] = StringToInt(sBuffer[0]);
    	gI_SecondaryWeapon[client] = StringToInt(sBuffer[1]);
    	gB_GunMenu[client] = true;
    }
    
    GetClientCookie(client, gH_GuardCookie, sValue, 6);
    
    if (sValue[0] != '\0') {
    	gB_GuardMenu[client] = view_as<bool>(StringToInt(sValue));
    }
    
    GetClientCookie(client, gH_ModelCookie, sValue, 6);
    
    if (sValue[0] != '\0') 
    {
    	char[][] sBuffer = new char[2][5];
    	ExplodeString(sValue, ";", sBuffer, 2, 5);
    	
    	gI_PrisonerModel[client] = StringToInt(sBuffer[0]);
    	gI_GuardModel[client] = StringToInt(sBuffer[1]);
    }
}  

public void OnClientDisconnect(int client)
{
	if (!IsFakeClient(client))
	{
		if (gI_Bounty[client] > 0)
		{
			for (int i = 1; i <= MaxClients; ++i)
			{
				if (i != client && IsClientInGame(i))
				{
					if (gI_BountyTarget[client][i] > 0)
					{
						gI_Credits[i] += gI_BountyTarget[client][i];
						PrintToChat(i, "%s\x03%N\x01 has left! Your bounty has been refunded \x04%i\x01 credits.", JB_TAG, client, gI_BountyTarget[client][i]);
					}
				}
				gI_BountyTarget[client][i] = 0;
			}
		}
		
		gB_GuardMenu[client] = false;
		gB_GunMenu[client] = false;
		gI_PrimaryWeapon[client] = -1;
		gI_SecondaryWeapon[client] = -1;
		
		if (gI_ClientCards[client] > 0 && gI_BetAmount[client] >= 50)
			gI_Credits[client] -= gI_BetAmount[client];
		
		UpdateSQL(client, true);
		
		if (client == gI_BallHolder)
			gI_BallHolder = 0;
		
		if (client == gI_GoalZoneCreator)
			gI_GoalZoneCreator = -1;
		
		if (client == gI_Owner)
			gI_Owner = -1;
		
		if (client == gI_Warden)
		{
			gI_Warden = -1;
			CreateTimer(0.1, Timer_NewWarden, INVALID_HANDLE);
			PrintToChatAll("%sThe Warden (\x0B%N\x01) has left the game!", JB_TAG, client);
			ResetMarker();
		}
		else if (gB_TickingTimeBomb && gI_Prisoner == client)
		{
			gB_TickingTimeBomb = false;
			gI_Prisoner = -1;
			PrintToChatAll("%sTicking Time Bomb is over, due to \x09%N\x01 Disconnecting!", JB_TAG, client);
		}
		
		if (gH_LastRequest != LASTREQUEST_INVALID)
		{
			if (client == gI_Guard)
			{
				gI_LastRequestWeapon = -1;
				gI_Guard = -1;
				
				gH_LastRequest = LASTREQUEST_INVALID;
				PrintToChatAll("%s\x0B%N\x01 has left the game!", JB_TAG, client);
			}
		}
		
		switch (gH_SpecialDay)
		{
			case SPECIALDAY_KILLCONFIRM: 
			{
				gI_Activity[client] = -1;	
				
				int iEnt = -1;
				
				while ((iEnt = FindEntityByClassname(iEnt, "prop_physics_override")) != -1)
				{
					if (GetEntPropEnt(iEnt, Prop_Data, "m_hOwnerEntity") == client)
					{
						AcceptEntityInput(iEnt, "Kill");	
						break;
					}
				}
			}
		}
		RemoveHook(client);
	}
}

public void OnClientDisconnect_Post(int client) {
	RoundEndChecks();
}

public Action OnClientSayCommand(int client, const char[] sCommand, const char[] sText)
{
	if ((gB_SetName[client] || gB_Rename[client]) && sText[0] != '\0')
	{
		if (IsValidClient(client))
		{
			int iLength = strlen(sText);
			
			if (iLength > MAXGANGNAME)
			{
				PrintToChat(client, "%s \x07The name you selected is too long!", GANG_TAG);
				return Plugin_Handled;
			}
			else if (iLength < 3)
			{
				PrintToChat(client, "%s \x07The name you selected is too short!", GANG_TAG);
				return Plugin_Handled;
			}
			
			int iSpace = 1;
			
			for (int i = 0; i < iLength; ++i)
			{			
				if (!IsCharSpace(sText[0]) && IsCharSpace(sText[i]) && iSpace <= 1)
				{
					++iSpace;
					continue;	
				}	
				else if (!IsCharAlpha(sText[i]))
				{
					PrintToChat(client, "%s \07The name cannot contain special characters!", GANG_TAG);
					return Plugin_Handled;
				}
				iSpace--;
			}
						
			DataPack hDatapack = new DataPack();
			hDatapack.WriteCell(GetClientUserId(client));
			hDatapack.WriteString(sText);
			hDatapack.Reset();
	
			char[] sQuery = new char[PLATFORM_MAX_PATH];
			FormatEx(sQuery, PLATFORM_MAX_PATH, "SELECT * FROM gangs_groups WHERE gang=\"%s\"", sText);
			gD_Database.Query(SQL_Callback_CheckName, sQuery, hDatapack);
			return Plugin_Handled;
		}
	}
	else if (IsChatTrigger())
		return Plugin_Handled;
	return Plugin_Continue;
}

public void OnClientSayCommand_Post(int client, const char[] sCmd, const char[] sArgs)
{
	if (gH_LastRequest == LASTREQUEST_TYPING && sCmd[3] != '_')
	{
		if (IsValidClient(client) && IsPlayerAlive(client))
		{			
			if (StrEqual(gS_TypingPhrase, sArgs, false))
			{
				if (client == gI_Guard)
				{
					gS_TypingPhrase[0] = '\0';
					SDKHooks_TakeDamage(gI_Prisoner, gI_Guard, gI_Guard, 500.0);
				}
				else if (client == gI_Prisoner)
				{
					gS_TypingPhrase[0] = '\0';
					SDKHooks_TakeDamage(gI_Guard, gI_Prisoner, gI_Prisoner, 500.0);
				}
			}
		}
	}
	else if (gB_Math && sCmd[3] != '_')
	{
		if (IsValidClient(client) && IsPlayerAlive(client) && GetClientTeam(client) == 2 && StringToInt(sArgs) == gI_Answer)
		{
			gB_Math = false;
			PrintToChatAll("%s\x09%N \x01Won! (Answer: \x04%i\x01)", JB_TAG, client, gI_Answer);
		}
	}
}

public Action CS_OnCSWeaponDrop(int client, int iWeapon)
{
	if (IsValidEdict(iWeapon))
	{
		if (gH_LastRequest == LASTREQUEST_GUNTOSS)
		{
			if (IsValidClient(client) && IsPlayerAlive(client))
			{
				if (client == gI_Guard)
					SetGlow(iWeapon, 0, 0, 255, 255);
				else if (client == gI_Prisoner)
					SetGlow(iWeapon, 255, 0, 0, 255);
			}
		}
		else if (gH_SpecialDay == SPECIALDAY_GUNGAME) {
			return Plugin_Handled;
		}
		else
		{
			if (IsValidClient(client))
			{
				char[] sWeapon = new char[32];
				GetEdictClassname(iWeapon, sWeapon, 32);
				
				if (sWeapon[7] == 't' && sWeapon[8] == 'a')
					return Plugin_Handled;
			}
		}
	}
	return Plugin_Continue;
}


/*===============================================================================================================================*/
/********************************************************* [EVENTS] **************************************************************/
/*===============================================================================================================================*/


public void Event_RoundStart(Event hEvent, const char[] sEventName, bool bDontBroadcast)
{	
	CreateTimer(0.5, Timer_DeleteEntities, INVALID_HANDLE, TIMER_FLAG_NO_MAPCHANGE);
	if (gB_BallSpawnExists) CreateTimer(1.0, Timer_RespawnBall, INVALID_HANDLE, TIMER_FLAG_NO_MAPCHANGE);
	
	Fog(false);
	
	++gI_Round;
	gB_Expired = false;
	gB_Cells = false;
	gI_Cells = 0;
	gI_Warden = -1;
	gI_JihadCount = 0;
	gI_InvisiblityCount = 0;
	gI_DisguiseCount = 0;
	gI_DeagCount = 0;
	gI_LightCount = 0;
	gI_EMPCount = 0;
	gI_GrenadeCount = 0;
	
	gCV_Block.SetInt(1);
	gCV_Respawn.SetInt(0);
			
	int ent = -1;
	
	while ((ent = FindEntityByClassname(ent, "func_button")) != -1) {
		SetEntProp(ent, Prop_Data, "m_spawnflags", GetEntProp(ent, Prop_Data, "m_spawnflags")|512);
	}	
	
	ent = -1;
	
	while ((ent = FindEntityByClassname(ent, "func_door")) != -1) {
		SDKHook(ent, SDKHook_TraceAttackPost, OnDoorShot);
	}	
			
	if (GetTeamClientCount(3) == 0)
	{
		PrintToChatAll("%sThere are no \x0BGuards\x01 avaliable!", JB_TAG);
		gCV_Respawn.SetInt(1);
		++gI_Cells;
		Cells(true);

		gI_Round = 0;
		gI_DayDelay = SPECIALDAYDELAY;
		gB_FreeDay = true;
		
		for (int i = 1; i <= MaxClients; ++i)
			if (IsClientInGame(i))
				SetClientListeningFlags(i, VOICE_NORMAL);
	}
	else if (gI_Round == 1 && GetTeamClientCount(2) > 1)
	{
		for (int i = 1; i <= MaxClients; ++i)
		{
			if (IsClientInGame(i))
			{
				PrintToChat(i, "%sFirst Day is an \x09Unrestricted Free day\x01!", JB_TAG);
				PrintCenterText(i, "<font color='#FFFF00'>It's an Unrestricted Freeday!</font>");
				FadePlayer(i, 300, 300, 0x0001, {255, 255, 102, 100});
				
				if (gB_BaseComm)
				{
					if (!BaseComm_IsClientMuted(i))
						SetClientListeningFlags(i, VOICE_NORMAL);
				}
				else SetClientListeningFlags(i, VOICE_NORMAL);
				
				if (GetClientTeam(i) == 2)
					SetGlow(i, 255, 255, 0, 255);
			}
		}
		
		gCV_Radar.SetInt(1);
		++gI_Cells;
		gB_FreeDay = true;
		Cells(true);
		gB_Cells = true;
		CreateTimer(1.0, Timer_TriggerDetection, INVALID_HANDLE, TIMER_FLAG_NO_MAPCHANGE);
	}
	else if (gI_SpecialDay == gI_Round)
	{
		gH_SpecialDay = view_as<SpecialDay>(gI_DaySelected);
		gI_DaySelected = -1;
		gI_SpecialDay = -1;
		EnableSpecialDay(1337);
	}
	else
	{	
		for (int i = 1; i <= MaxClients; ++i)
		{
			if (IsClientInGame(i)) 
			{	
				if (GetClientTeam(i) == 3)
					CS_SetClientClanTag(i, "");
				
				SetEntPropFloat(i, Prop_Send, "m_flLaggedMovementValue", 1.0);
				SetEntityGravity(i, 1.0);
				RemoveHook(i);
				DisableParachute(i);
				gB_Hook[i] = false;
				gB_PlayerSteps[i] = false;
				gB_Parachute[i] = false;
				gB_Health[i] = false;
				gB_Armor[i] = false;
				gB_Nade[i] = false;
				gB_ClusterNade[i] = false;
				gB_TANade[i] = false;
				gB_Disguise[i] = false;
				gB_Jihad[i] = false;
				gB_Invisiblity[i] = false;
				gB_Taser[i] = false;
				gB_Deag[i] = false;
				gB_Light[i] = false;
				gB_EMP[i] = false;	
				gI_Fuel[i] = 0;
				gF_Pushed[i] = 0.0;
				
				for (int x = 0; x < 3; ++x)
					gF_Laser[i][x] = 0.0;	
				
				if (GetClientTeam(i) == 2 && gB_FreedayNext[i])
				{
					gB_FreedayNext[i] = false;
					gB_Freeday[i] = true;
					++gI_Freedays;
					SetGlow(i, 255, 255, 0, 255);
					FadePlayer(i, 300, 300, 0x0001, {255, 255, 0, 100});
					PrintToChatAll("%s\x09%N\x01 has a freeday!", JB_TAG, i);
				}
			}
		}
		
		CreateTimer(60.0, Timer_OpenDoors, gI_Round, TIMER_FLAG_NO_MAPCHANGE);
		CreateTimer(1.2, Timer_Warden, gI_Round, TIMER_FLAG_NO_MAPCHANGE);
		CreateTimer(1.0, Timer_TriggerDetection, INVALID_HANDLE, TIMER_FLAG_NO_MAPCHANGE);
	}
}

public void Event_RoundEnd(Event hEvent, const char[] sEventName, bool bDontBroadcast)
{	
	ResetMarker();
	
	ArrayList aArray = new ArrayList(66);
	
	for (int i = 1; i <= MaxClients; ++i)
	{
		if (IsClientInGame(i) && !IsFakeClient(i))
		{
			aArray.Push(i);
			UpdateSQL(i);
			UnhookGlow(i);
			SetEntityGravity(i, 1.0);
			SetEntPropFloat(i, Prop_Send, "m_flLaggedMovementValue", 1.0);
			SetGlow(i, 255, 255, 255, 255);
			gI_Activity[i] = 0;
			gB_Paint[i] = false;
			SDKUnhook(i, SDKHook_PreThink, OnPreThink);
			
			switch (gH_SpecialDay)
			{
				case SPECIALDAY_SHARK: SDKUnhook(i, SDKHook_OnTakeDamagePost, OnTakeDamagePost); 	
				case SPECIALDAY_NIGHTCRAWLER: SDKUnhook(i, SDKHook_SetTransmit, OnSetTransmit);
			}
		}
	}
	
	int iRound = hEvent.GetInt("winner");
	
	if (iRound != 1)
		hEvent.BroadcastDisabled = true;
	int client;
	
	if (gH_SpecialDay != SPECIALDAY_INVALID)
	{
		gCV_SelfDamage.SetFloat(0.0);	
		gCV_HeadshotOnly.SetInt(0);
		gCV_Gravity.SetInt(800);
		gCV_InfiniteAmmo.SetInt(0);
		gCV_Radar.SetInt(0);
		
		hEvent.BroadcastDisabled = true;
		
		if (gCV_FriendlyFire.BoolValue)
		{
			if (gH_SpecialDay != SPECIALDAY_GUNGAME)
			{			
				for (int i = 0; i < aArray.Length; ++i)
				{
					client = aArray.Get(i);
					
					if (IsPlayerAlive(client))
						ClientCommand(client, "play %s", SOUND_SD_SOLOWIN);
					else
						ClientCommand(client, "play %s", SOUND_SD_SOLOLOSE);
				}
			}
			gCV_FriendlyFire.SetInt(0);
		}
		else
		{
			for (int i = 0; i < aArray.Length; ++i)
			{
				client = aArray.Get(i);
				
				switch (iRound)
				{
					case 2: ClientCommand(client, "play %s", SOUND_PRISONERS_WIN);
					case 3: ClientCommand(client, "play %s", SOUND_GUARDS_WIN);
				}
			}
		}
		gH_SpecialDay = SPECIALDAY_INVALID;
	}
	else
	{
		for (int i = 0; i < aArray.Length; ++i)
		{
			client = aArray.Get(i);
			
			switch (iRound)
			{
				case 2: ClientCommand(client, "play %s", SOUND_PRISONERS_WIN);
				case 3: ClientCommand(client, "play %s", SOUND_GUARDS_WIN);
			}
			
			if (GetClientTeam(client) == iRound)
			{
				switch (iRound)
				{
					case 2:
					{
						if (GetTeamClientCount(3) > 0)
						{
							gI_Credits[client] += CREDITS_ROUND_WIN;
							PrintToChat(client, "%sYou gained \x04%i\x01 credits for taking part in ruling over the prison!", JB_TAG, CREDITS_ROUND_WIN);
						}
					}
					case 3:
					{
						if (GetTeamClientCount(2) > 2)
						{
							gI_Credits[client] += CREDITS_ROUND_WIN;
							PrintToChat(client, "%sYou gained \x04%i\x01 credits for taking part in quelling the rebellion!", JB_TAG, CREDITS_ROUND_WIN);
						}
					}
				}
			}
		}
		gCV_FriendlyFire.SetInt(0);
	}
	delete aArray;
	
	gI_Seconds = 0;
	gI_LastRequestWeapon = -1;
	gI_Freedays = 0;
	gI_Prisoner = -1;
	gI_Guard = -1;
	
	gB_FreeDay = false;
	gB_FreeForAll = false;
	gB_Shove = false;
	gB_DeathBall = false;
	gB_TickingTimeBomb = false;
	gB_KnifeDuel = false;
	gB_Math = false;
	gB_LastRequest_Available = false;

	gH_LastRequest = LASTREQUEST_INVALID;
}

public void Event_PlayerActiviate(Event hEvent, const char[] sEventName, bool bDontBroadcast)
{
	CreateTimer(0.2, Timer_Activate, hEvent.GetInt("userid"));
}

public void Event_PlayerHurtPre(Event hEvent, const char[] sEventName, bool bDontBroadcast)
{
	int attacker = GetClientOfUserId(hEvent.GetInt("attacker"));
	
	if (IsValidClient(attacker))
	{
		int victim = GetClientOfUserId(hEvent.GetInt("userid"));
		
		if (victim != attacker && IsValidClient(victim))
		{
			char[] sWeaponName = new char[32];
			hEvent.GetString("weapon", sWeaponName, 32);
			
			if (StrContains(sWeaponName, "knife") != -1)
			{
				float Position[3], Angles[3];
				
				GetClientEyePosition(attacker, Position); 
				GetClientEyeAngles(attacker, Angles); 
				
				TR_TraceRayFilter(Position, Angles, MASK_SHOT, RayType_Infinite, Trace_HitVictimOnly, victim); 
			     
				int HitGroup = TR_GetHitGroup(); 
				
				hEvent.SetInt("hitgroup", HitGroup);	
				
				if (HitGroup == 1)
					hEvent.SetBool("headshot", true);
					
				gI_HitGroup[victim][attacker] = HitGroup;
			}
		}
	}
}

public void Event_PlayerHurt(Event hEvent, const char[] sEventName, bool bDontBroadcast)
{
	int attacker = GetClientOfUserId(hEvent.GetInt("attacker"));
	
	if (IsValidClient(attacker))
	{
		int victim = GetClientOfUserId(hEvent.GetInt("userid"));
		
		if (victim != attacker && IsValidClient(victim))
		{
			int iDamage = hEvent.GetInt("dmg_health");
			
			SetHudTextParams(0.44, -0.47, 2.0, 202, 51, 51, 255);
			ShowHudText(victim, 3, "%i", iDamage);
			
			SetHudTextParams(0.48, -0.44, 2.0, 30, 144, 255, 255);
			ShowHudText(attacker, 4, "%i", iDamage);
		}
	}
}

public void Event_PlayerSpawn(Event hEvent, const char[] sEventName, bool bDontBroadcast)
{
	int client = GetClientOfUserId(hEvent.GetInt("userid"));
	
	if (IsValidClient(client))
	{
		int iTeam = GetClientTeam(client);
		
		switch (iTeam)
		{
			case 2:
			{
				switch (gI_PrisonerModel[client])
				{
					case 0: 
					{
						SetEntityModel(client, MODEL_PRISONER1);
						SetEntPropString(client, Prop_Send, "m_szArmsModel", MODEL_PRISONER1_ARMS);
					}
					case 1: 
					{
						SetEntityModel(client, MODEL_PRISONER2);
						SetEntPropString(client, Prop_Send, "m_szArmsModel", MODEL_PRISONER2_ARMS);
					}
					case 2: 
					{
						SetEntityModel(client, MODEL_PRISONER3);
						SetEntPropString(client, Prop_Send, "m_szArmsModel", MODEL_PRISONER3_ARMS);
					}
					case 3: 
					{
						SetEntityModel(client, MODEL_PRISONER4);
						SetEntPropString(client, Prop_Send, "m_szArmsModel", MODEL_PRISONER4_ARMS);
					}
					case 4: 
					{
						SetEntityModel(client, MODEL_PRISONER5);
						SetEntPropString(client, Prop_Send, "m_szArmsModel", MODEL_PRISONER5_ARMS);
					}
					case 5: 
					{
						SetEntityModel(client, MODEL_PRISONER6);
						SetEntPropString(client, Prop_Send, "m_szArmsModel", MODEL_PRISONER6_ARMS);
					}
					case 6: 
					{
						SetEntityModel(client, MODEL_PRISONER7);
						SetEntPropString(client, Prop_Send, "m_szArmsModel", MODEL_PRISONER7_ARMS);
					}
				}
			}
			case 3:
			{
				switch (gI_GuardModel[client])
				{
					case 0: 
					{
						SetEntityModel(client, MODEL_GUARD1);
						SetEntPropString(client, Prop_Send, "m_szArmsModel", MODEL_GUARD1_ARMS);
					}
					case 1: 
					{
						SetEntityModel(client, MODEL_GUARD2);
						SetEntPropString(client, Prop_Send, "m_szArmsModel", MODEL_GUARD2_ARMS);
					}
					case 2: 
					{
						SetEntityModel(client, MODEL_GUARD3);
						SetEntPropString(client, Prop_Send, "m_szArmsModel", MODEL_GUARD3_ARMS);
					}
					case 3: 
					{
						SetEntityModel(client, MODEL_GUARD4);
						SetEntPropString(client, Prop_Send, "m_szArmsModel", MODEL_GUARD4_ARMS);
					}
					case 4: 
					{
						SetEntityModel(client, MODEL_GUARD5);
						SetEntPropString(client, Prop_Send, "m_szArmsModel", MODEL_GUARD5_ARMS);
					}
				}
			}
		}
		
		if (gH_SpecialDay == SPECIALDAY_INVALID)
		{
			if (gB_HasGang[client])
			{
				if (iTeam < 3)
					CS_SetClientClanTag(client, gS_GangName[client]); 
				
				if (gI_Health[client] > 0)
				{
					SetEntProp(client, Prop_Data, "m_iMaxHealth", gI_Health[client] + 100);  
					SetEntProp(client, Prop_Send, "m_iHealth", gI_Health[client] + 100);
				}
				
				if (gI_Gravity[client] > 0)
					SetEntityGravity(client, (1.0 - (gI_Gravity[client] * 0.01)));
				
				if (gI_Speed[client] > 0)
					SetEntPropFloat(client, Prop_Send, "m_flLaggedMovementValue", (1 + (gI_Speed[client] * 0.01)));
			}
			
			if (0 < gI_ClientBan[client] < GetTime())
			{
				gI_ClientBan[client] = -1;
				RemoveGuardBan(client);
			}
			
			switch (iTeam)
			{
				case 2:
				{
					if (!CheckCommandAccess(client, "sm_kick", ADMFLAG_CUSTOM1) && !gB_FreeDay)
						SetClientListeningFlags(client, VOICE_MUTED);
				}
				case 3:
				{
					SetClientListeningFlags(client, VOICE_NORMAL);
					CreateTimer(0.1, Timer_GiveGuns, GetClientUserId(client));
					
					if (gI_ClientBan[client] != -1)
					{
						ChangeClientTeam(client, 2);
						PrintToChat(client, "[SM] You are banned from joining the \x0BGuards\x01 Team!");
					}
				}
			}
			
			gB_Hook[client] = false;
			gB_Parachute[client] = false;
			gB_PlayerSteps[client] = false;
			gB_Freeday[client] = false;
			gI_ClientStatus[client] = 0;
			SetGlow(client, 255, 255, 255, 255);	
			
			char[] sName = new char[MAX_NAME_LENGTH];
			CS_GetClientClanTag(client, sName, MAX_NAME_LENGTH);
				
			if (client != gI_Warden && StrEqual(sName, "[Warden]"))
				CS_SetClientClanTag(client, "");
			
			RemoveAllWeapons(client);
			GivePlayerItem(client, "weapon_knife");
		}
		else
		{
			char[] sFormat = new char[100];
			char[][] sBuffer = new char[3][100];
			
			float[][] fLocation = new float[(gI_Spawns+1 <= 0)? 1:gI_Spawns+1][3];
			float fPos[3];
			
			bool bSpawn = false;
			
			if (gI_Spawns >= GetTeamClientCount(2) + GetTeamClientCount(3))
			{
				bSpawn = true;
				
				for (int i = 0; i < gI_Spawns; ++i)
				{
					gA_SpawnLocation.GetString(i, sFormat, 100);
					ExplodeString(sFormat, ";", sBuffer, 3, 100);
					
					fLocation[i][0] = StringToFloat(sBuffer[0]);
					fLocation[i][1] = StringToFloat(sBuffer[1]);
					fLocation[i][2] = StringToFloat(sBuffer[2]);
				}
			}
			
			switch (gH_SpecialDay)
			{
				case SPECIALDAY_GUNGAME:
				{
					switch (gI_Activity[client])
					{
						case 0, 1: GivePlayerItem(client, "weapon_glock");
						case 2, 3: GivePlayerItem(client, "weapon_hkp2000");
						case 4, 5: GivePlayerItem(client, "weapon_p250");
						case 6, 7: GivePlayerItem(client, "weapon_nova");
						case 8, 9: GivePlayerItem(client, "weapon_mp7");
						case 10, 11: GivePlayerItem(client, "weapon_ak47");
						case 12, 13: GivePlayerItem(client, "weapon_m4a1");
						case 14, 15: GivePlayerItem(client, "weapon_negev");
						case 16, 17: GivePlayerItem(client, "weapon_ssg08");
						case 18, 19: 
						{
							int iWeapon = GivePlayerItem(client, "weapon_awp");
							SetEntProp(iWeapon, Prop_Send, "m_iClip1", 1);
						}
					}
					
					if (bSpawn)
					{
						int iRandom = GetRandomInt(0, gI_Spawns);
						
						fPos[0] = fLocation[iRandom][0];
						fPos[1] = fLocation[iRandom][1];
						fPos[2] = fLocation[iRandom][2];
						TeleportEntity(client, fPos, NULL_VECTOR, NULL_VECTOR);
					}
				}
				case SPECIALDAY_KNIFE:
				{
					if (bSpawn)
					{
						int iRandom = GetRandomInt(0, gI_Spawns);
						
						fPos[0] = fLocation[iRandom][0];
						fPos[1] = fLocation[iRandom][1];
						fPos[2] = fLocation[iRandom][2];
						TeleportEntity(client, fPos, NULL_VECTOR, NULL_VECTOR);
					}	
				}
				case SPECIALDAY_KILLCONFIRM:
				{
					if (bSpawn)
					{
						int iRandom = GetRandomInt(0, gI_Spawns);
						
						fPos[0] = fLocation[iRandom][0];
						fPos[1] = fLocation[iRandom][1];
						fPos[2] = fLocation[iRandom][2];
						TeleportEntity(client, fPos, NULL_VECTOR, NULL_VECTOR);
					}	
					
					GivePlayerItem(client, "weapon_ak47");
					GivePlayerItem(client, "weapon_deagle");			
					gB_Hook[client] = true;					
				}
			}
		}
	}
}

public void Event_PlayerDeathPre(Event hEvent, const char[] sEventName, bool bDontBroadcast)
{	
	if (gH_SpecialDay == SPECIALDAY_INVALID && gH_LastRequest == LASTREQUEST_INVALID)
	{
		int client = GetClientOfUserId(hEvent.GetInt("userid"));
		
		if (IsValidClient(client))
		{
			GetClientAbsOrigin(client, gF_RevivePosition[client]);
			
			int attacker = GetClientOfUserId(hEvent.GetInt("attacker"));
			
			if (IsValidClient(attacker)) 
			{
				if (GetClientTeam(client) != 3)
				{
					if (client != attacker)
					{
						char[] sWeaponName = new char[32];
						hEvent.GetString("weapon", sWeaponName, 32);
						
						if (StrContains(sWeaponName, "knife") != -1)
						{
							if (gI_HitGroup[client][attacker] == 1)
								hEvent.SetBool("headshot", true);
						}	
					}
				}
				else hEvent.SetInt("attacker", hEvent.GetInt("userid"));
			}
		}
	}
	else
	{
		int client = GetClientOfUserId(hEvent.GetInt("userid"));
		
		if (IsValidClient(client))
		{
			int attacker = GetClientOfUserId(hEvent.GetInt("attacker"));
			
			if (attacker != client && IsValidClient(attacker)) 
			{
				char[] sWeaponName = new char[32];
				hEvent.GetString("weapon", sWeaponName, 32);

				if (StrContains(sWeaponName, "knife") != -1)
				{
					if (gI_HitGroup[client][attacker] == 1)
						hEvent.SetBool("headshot", true);
				}	
			}
		}	
	}
}

public void Event_PlayerDeath(Event hEvent, const char[] sEventName, bool bDontBroadcast)
{
	int client = GetClientOfUserId(hEvent.GetInt("userid"));
	
	if (IsValidClient(client))
	{		
		RemoveHook(client);
		DisableParachute(client);
		
		int attacker = GetClientOfUserId(hEvent.GetInt("attacker"));

		if (client == gI_Owner)
			gI_Owner = -1;
			
		if (client == gI_GoalZoneCreator)
			gI_GoalZoneCreator = -1;
			
		if (client == gI_BallHolder)
			gI_BallHolder = 0;
		
		bool bValid;
		
		if (attacker != client && IsValidClient(attacker))
		{
			bValid = true;
			
			if (gI_Bounty[client] > 0)
			{
				float fFee = gI_Bounty[client] * CREDITS_TRANSFER_FEE;
				
				bool bAdmin;
				
				if (CheckCommandAccess(client, "sm_kick", ADMFLAG_GENERIC))
				{
					fFee /= 2;
					bAdmin = true;
				}
				
				int iFee = RoundToCeil(fFee);
				
				EmitSoundToAll(SOUND_BOUNTY_ACHIEVED, attacker, SNDCHAN_BODY);
				PrintToChatAll("%s\x03%N\x01 has collected \x04%i\x01 credits from \x02%N\x01's bounty. (%s Fee: \x07%i\x01)", JB_TAG, attacker, gI_Bounty[client], client, (bAdmin)? "VIP":"Transfer", iFee);
				gI_Credits[attacker] += gI_Bounty[client] - iFee;
				gI_Bounty[client] = 0;
				
				for (int i = 1; i <= MaxClients; ++i)
					gI_BountyTarget[client][i] = 0;	
			}
		}
		
		if (gH_SpecialDay != SPECIALDAY_INVALID)
		{			
			if (bValid)
			{
				++gI_StatsSpecialDayKills[attacker];
				++gI_GangKills[attacker];
			}
			
			switch (gH_SpecialDay)
			{
				case SPECIALDAY_ONEINACHAMBER:
				{
					if (bValid && IsPlayerAlive(attacker))
					{
						RemoveAllWeapons(attacker);
						GivePlayerItem(attacker, "weapon_knife");
						int iWeapon = GivePlayerItem(attacker, "weapon_deagle");
						SetEntProp(iWeapon, Prop_Send, "m_iClip1", 1);
						SetEntProp(iWeapon, Prop_Send, "m_iPrimaryReserveAmmoCount", 0);
					}
				}
				case SPECIALDAY_KNIFE:
				{
					if (bValid)
					{
						char[] sFormat = new char[50];
						FormatEx(sFormat, 50, "*lenhard/jailbreak/duke%i.mp3", GetRandomInt(1, 3));
						EmitSoundToAll(sFormat, attacker);
					}
					--gI_Activity[client];
					
					if (gI_Activity[client] > 0)
						CreateTimer(1.0, Timer_Respawn, GetClientUserId(client), TIMER_FLAG_NO_MAPCHANGE);	
				}
				case SPECIALDAY_KILLCONFIRM:
				{
					if (bValid)
					{
						CreateTimer(0.1, Timer_Tag, GetClientUserId(client));
						gF_Pushed[client] = GetGameTime() + 5.0;
						CreateTimer(5.0, Timer_Respawn, GetClientUserId(client), TIMER_FLAG_NO_MAPCHANGE);			
					}
				}
				case SPECIALDAY_TRIGGER:
				{
					if (bValid)
					{
						int iHealth = GetClientHealth(attacker) + 25;
						
						if (iHealth < 100)
							SetEntityHealth(attacker, iHealth);
						else
							SetEntityHealth(attacker, 100);
					}	
				}
				case SPECIALDAY_GUNGAME:
				{
					if (bValid)
					{
						char[] sWeapon = new char[32];
						int iWeapon = GetEntPropEnt(attacker, Prop_Send, "m_hActiveWeapon");
						
						if (iWeapon != -1)
						    GetEntityClassname(iWeapon, sWeapon, 32);
						
						bool bKnifed = false;
						
						if (sWeapon[7] == 'k' && sWeapon[8] == 'n')
						{
							if (gI_Activity[attacker] >= 20)
							{
								CS_TerminateRound(3.0, CSRoundEnd_Draw, true);
								ClientCommand(attacker, "play %s", SOUND_SD_SOLOWIN);			
								PrintToChatAll("%s%s%N\x01 has won the match!", JB_TAG, (GetClientTeam(attacker) == 2)? "\x09":"\x0B", attacker);
								
								for (int i = 1; i <= MaxClients; ++i)
									if (IsClientInGame(i) && i != attacker)
										ClientCommand(i, "play %s", SOUND_SD_SOLOLOSE);	
								return;
							}
							
							bKnifed = true;
							
							PrintToChat(attacker, "%sYou have stole a level from %s%N", JB_TAG, (GetClientTeam(client) == 2)? "\x09":"\x0B", client);
							PrintToChat(client, "%s%s%N\x01 has stole a level from You!", JB_TAG, (GetClientTeam(attacker) == 2)? "\x09":"\x0B", attacker);
							
							if (gI_Activity[client] > 1)
								gI_Activity[client] -= 2;
							
							if (gI_Activity[attacker] <= 18)
								gI_Activity[attacker] += 2;
							else
								gI_Activity[attacker] += 1;
								
							ClientCommand(client, "play %s", SOUND_SD_LOSELEVEL);
						}
						else ++gI_Activity[attacker];
						
						switch (gI_Activity[attacker])
						{
							case 2:
							{
								RemoveAllWeapons(attacker);
								GivePlayerItem(attacker, "weapon_knife");
								ClientCommand(attacker, "play %s", SOUND_SD_LEVELUP);
								GivePlayerItem(attacker, "weapon_hkp2000");
							}
							case 3:
							{
								if (bKnifed)
								{
									RemoveAllWeapons(attacker);
									GivePlayerItem(attacker, "weapon_knife");
									ClientCommand(attacker, "play %s", SOUND_SD_LEVELUP);
									GivePlayerItem(attacker, "weapon_hkp2000");	
								}
							}
							case 4:
							{
								RemoveAllWeapons(attacker);
								GivePlayerItem(attacker, "weapon_knife");
								ClientCommand(attacker, "play %s", SOUND_SD_LEVELUP);
								GivePlayerItem(attacker, "weapon_p250");
							}
							case 5:
							{
								if (bKnifed)
								{
									RemoveAllWeapons(attacker);
									GivePlayerItem(attacker, "weapon_knife");
									ClientCommand(attacker, "play %s", SOUND_SD_LEVELUP);
									GivePlayerItem(attacker, "weapon_p250");	
								}
							}
							case 6:
							{
								RemoveAllWeapons(attacker);
								GivePlayerItem(attacker, "weapon_knife");
								ClientCommand(attacker, "play %s", SOUND_SD_LEVELUP);
								GivePlayerItem(attacker, "weapon_nova");
							}
							case 7:
							{
								if (bKnifed)
								{
									RemoveAllWeapons(attacker);
									GivePlayerItem(attacker, "weapon_knife");
									ClientCommand(attacker, "play %s", SOUND_SD_LEVELUP);
									GivePlayerItem(attacker, "weapon_nova");	
								}
							}
							case 8:
							{
								RemoveAllWeapons(attacker);
								GivePlayerItem(attacker, "weapon_knife");
								ClientCommand(attacker, "play %s", SOUND_SD_LEVELUP);
								GivePlayerItem(attacker, "weapon_mp7");
							}
							case 9:
							{
								if (bKnifed)
								{
									RemoveAllWeapons(attacker);
									GivePlayerItem(attacker, "weapon_knife");
									ClientCommand(attacker, "play %s", SOUND_SD_LEVELUP);
									GivePlayerItem(attacker, "weapon_mp7");	
								}
							}
							case 10:
							{
								RemoveAllWeapons(attacker);
								GivePlayerItem(attacker, "weapon_knife");
								ClientCommand(attacker, "play %s", SOUND_SD_LEVELUP);
								GivePlayerItem(attacker, "weapon_ak47");
							}
							case 11:
							{
								if (bKnifed)
								{
									RemoveAllWeapons(attacker);
									GivePlayerItem(attacker, "weapon_knife");
									ClientCommand(attacker, "play %s", SOUND_SD_LEVELUP);
									GivePlayerItem(attacker, "weapon_ak47");	
								}
							}
							case 12:
							{
								RemoveAllWeapons(attacker);
								GivePlayerItem(attacker, "weapon_knife");
								ClientCommand(attacker, "play %s", SOUND_SD_LEVELUP);
								GivePlayerItem(attacker, "weapon_m4a1");
							}
							case 13:
							{
								if (bKnifed)
								{
									RemoveAllWeapons(attacker);
									GivePlayerItem(attacker, "weapon_knife");
									ClientCommand(attacker, "play %s", SOUND_SD_LEVELUP);
									GivePlayerItem(attacker, "weapon_m4a1");	
								}
							}
							case 14:
							{
								RemoveAllWeapons(attacker);
								GivePlayerItem(attacker, "weapon_knife");
								ClientCommand(attacker, "play %s", SOUND_SD_LEVELUP);
								GivePlayerItem(attacker, "weapon_negev");	
							}
							case 15:
							{
								if (bKnifed)
								{
									RemoveAllWeapons(attacker);
									GivePlayerItem(attacker, "weapon_knife");
									ClientCommand(attacker, "play %s", SOUND_SD_LEVELUP);
									GivePlayerItem(attacker, "weapon_negev");	
								}
							}
							case 16:
							{
								RemoveAllWeapons(attacker);
								GivePlayerItem(attacker, "weapon_knife");
								ClientCommand(attacker, "play %s", SOUND_SD_LEVELUP);
								GivePlayerItem(attacker, "weapon_ssg08");
							}
							case 17:
							{
								if (bKnifed)
								{
									RemoveAllWeapons(attacker);
									GivePlayerItem(attacker, "weapon_knife");
									ClientCommand(attacker, "play %s", SOUND_SD_LEVELUP);
									GivePlayerItem(attacker, "weapon_ssg08");	
								}
							}
							case 18:
							{
								RemoveAllWeapons(attacker);
								GivePlayerItem(attacker, "weapon_knife");
								ClientCommand(attacker, "play %s", SOUND_SD_LEVELUP);
								int iWeapon2 = GivePlayerItem(attacker, "weapon_awp");
								SetEntProp(iWeapon2, Prop_Send, "m_iClip1", 1);
							}
							case 19:
							{
								if (bKnifed)
								{
									RemoveAllWeapons(attacker);
									GivePlayerItem(attacker, "weapon_knife");
									ClientCommand(attacker, "play %s", SOUND_SD_LEVELUP);
									int iWeapon2 = GivePlayerItem(attacker, "weapon_awp");
									SetEntProp(iWeapon2, Prop_Send, "m_iClip1", 1);
								}
							}
							case 20, 21:
							{
								RemoveAllWeapons(attacker);
								GivePlayerItem(attacker, "weapon_knife");
								
								for (int i = 1; i <= MaxClients; ++i)
								{
									if (IsClientInGame(i))
									{
										ClientCommand(i, "play %s", SOUND_SD_KNIFELEVEL);
										PrintToChat(i, "%s%s%N\x01 is on the knife level!", JB_TAG, (GetClientTeam(attacker) == 2)? "\x09":"\x0B", attacker);
									}
								}
							}
							default: ClientCommand(attacker, "play %s", SOUND_SD_GAINPOINT);
						}
					}
					CreateTimer(1.0, Timer_Respawn, GetClientUserId(client), TIMER_FLAG_NO_MAPCHANGE);	
				}
			}
		}
		else
		{		
			CreateTimer(0.4, Timer_Box, GetClientUserId(client));
			
			gB_Paint[client] = false;
			
			if (client == gI_Warden)
			{
				gI_Warden = -1;
				CS_SetClientClanTag(client, ""); 
				CreateTimer(0.1, Timer_NewWarden, INVALID_HANDLE);
				ResetMarker();
			}
			else if (gB_KnifeDuel)
			{
				if (GetClientTeam(client) == 2 && gI_ClientStatus[client] > 0)
				{
					gB_KnifeDuel = false;
					gCV_FriendlyFire.SetInt(0);	
					
					for (int i = 1; i <= MaxClients; ++i)
					{
						if (IsClientInGame(i) && gI_ClientStatus[i] > 0)
						{
							gI_ClientStatus[i] = 0;
							SetGlow(i, 255, 255, 255, 255);
						}
					}
				}
			}
			
			if (gB_TickingTimeBomb && gI_Prisoner == client)
			{
				gB_TickingTimeBomb = false;
				gI_Prisoner = -1;
			}
			
			if (!CheckCommandAccess(client, "sm_kick", ADMFLAG_CUSTOM1) && !gB_FreeDay)
				SetClientListeningFlags(client, VOICE_MUTED);	
			
			if (gH_LastRequest != LASTREQUEST_INVALID)
			{
				if (client == gI_Prisoner)
				{									
					if (bValid) 
					{
						++gI_GangKills[attacker];
						++gI_StatsLastRequestKills[attacker];
						PrintToChatAll("%s\x09%N \x01has lost to \x0B%N\x01!", JB_TAG, gI_Prisoner, gI_Guard);
					}
				}
				else if (client == gI_Guard)
				{
					if (gH_LastRequest == LASTREQUEST_HEADSHOT)
					{
						gCV_InfiniteAmmo.SetInt(0);
						gCV_HeadshotOnly.SetInt(0);
					}
					
					gH_LastRequest = LASTREQUEST_INVALID;
					
					if (bValid) 
					{
						++gI_GangKills[attacker];
						++gI_StatsLastRequestKills[attacker];
						PrintToChatAll("%s\x0B%N \x01has lost to \x09%N\x01!", JB_TAG, gI_Guard, gI_Prisoner);
					}
					
					UnhookGlow(gI_Guard);
					UnhookGlow(gI_Prisoner);
					RemoveAllWeapons(gI_Prisoner);
					GivePlayerItem(gI_Prisoner, "weapon_knife");
					SetEntityHealth(gI_Prisoner, 100);
					SetEntityGravity(gI_Prisoner, 1.0);
					SetEntPropFloat(gI_Prisoner, Prop_Data, "m_flLaggedMovementValue", 1.0);
					
					if (GetPlayerAliveCount(3) > 0 && GetPlayerAliveCount(2) == 1)
						LastRequestMenu(gI_Prisoner, gI_LRHealth[gI_Prisoner]);
					
					gI_Guard = -1;
					gI_Prisoner = -1;
				}
			}
			else 
			{
				if (bValid)
				{
					++gI_GangKills[attacker];
					switch (GetClientTeam(attacker))
					{
						case 2: ++gI_StatsPrisonerKills[attacker];	
						case 3: ++gI_StatsGuardKills[attacker];	
					}
				}
				
				if (!gB_LastRequest_Available && GetPlayerAliveCount(2) == 1 && GetPlayerAliveCount(3) > 0)
				{
					gB_TickingTimeBomb = false;
					gB_KnifeDuel = false;
					gB_Math = false;
					
					for (int i = 1; i <= MaxClients; ++i)
					{
						if (IsClientInGame(i) && IsPlayerAlive(i))
						{
							if (gB_BaseComm)
							{
								if (!BaseComm_IsClientMuted(i))
									SetClientListeningFlags(i, VOICE_NORMAL);
							}
							else SetClientListeningFlags(i, VOICE_NORMAL);
								
							PrintToChat(i, "%sLastrequest is now available!", JB_TAG);
							
							if (GetClientTeam(i) == 2) 
							{
								LastRequestMenu(i, gI_LRHealth[i]);
								gB_Freeday[i] = false;
								
								if (GetTeamClientCount(2) > 2)
								{
									PrintToChat(i, "%sYou earned \x0420\x01 credits for reaching Last Request!", JB_TAG);
									gI_Credits[client] += 20;
								}
							}
							else if (gI_Warden == i)
							{
								gI_Warden = -1;
								CS_SetClientClanTag(i, ""); 
							}
						}
					}
					
					ResetMarker();
					gB_LastRequest_Available = true;
				}
				else gB_FreedayNext[client] = false;
			}
		}
	}
	
	if (gI_Round > 0)
		RoundEndChecks();
}

public void Event_PlayerTeamPre(Event hEvent, const char[] sEventName, bool bDontBroadcast) 
{ 
	hEvent.BroadcastDisabled = true;
	
	int client = GetClientOfUserId(hEvent.GetInt("userid"));
	
	if (IsValidClient(client))
	{
		switch (hEvent.GetInt("oldteam")) 
	    {
	        case 1: 
	        {
	            switch (hEvent.GetInt("team")) 
	            {
					case 2: PrintToChatAll("%sPlayer \x03%N \x01joined \x09Prisoners", JB_TAG, client);
					case 3: PrintToChatAll("%sPlayer \x03%N \x01joined \x0BGuards", JB_TAG, client);
				} 
			} 
			case 2: 
			{ 
				switch (hEvent.GetInt("team")) 
				{ 
					case 1: PrintToChatAll("%sPlayer \x09%N \x01joined \x03Spectators", JB_TAG, client);
					case 3: PrintToChatAll("%sPlayer \x09%N \x01joined \x0BGuards", JB_TAG, client);
				} 
			} 
			case 3: 
			{ 
				switch (hEvent.GetInt("team")) 
				{ 
					case 1: PrintToChatAll("%sPlayer \x0B%N \x01joined \x03Spectators", JB_TAG, client);
					case 2: PrintToChatAll("%sPlayer \x0B%N \x01joined \x09Prisoners", JB_TAG, client);
				} 
			}
	    } 
	}
} 

public void Event_PlayerTeam(Event hEvent, const char[] sEventName, bool bDontBroadcast) 
{ 
	CheckRatio();
	RoundEndChecks();
}

public void Event_PlayerDisconnect(Event hEvent, const char[] sEventName, bool bDontBroadcast) 
{
	hEvent.BroadcastDisabled = true;
	
	int client = GetClientOfUserId(hEvent.GetInt("userid"));
	
	if (IsValidClient(client))
	{
		char[] sReason = new char[100];
		hEvent.GetString("reason", sReason, 100);
		PrintToChatAll("Player %s%N\x01 has disconnected [\x04%s\x01]", (GetClientTeam(client) == 3)? "\x0B":(GetClientTeam(client) == 2)? "\x09":"\x03", client, sReason);
	}
}

public void Event_WeaponFire(Event hEvent, const char[] sEventName, bool bDontBroadcast)
{
	if (gH_SpecialDay == SPECIALDAY_INVALID)
	{
		int client = GetClientOfUserId(hEvent.GetInt("userid"));

		if (IsValidClient(client))
		{
			if (gH_LastRequest == LASTREQUEST_SHOT4SHOT)
			{			
				char[] sWeapon = new char[MAX_NAME_LENGTH]; 
				hEvent.GetString("weapon", sWeapon, MAX_NAME_LENGTH);
				
				int iWeapon = -1;
				
				switch (gI_LastRequestWeapon)
				{
					case SHOT4SHOTWEAPON_DEAGLE:
					{
						if (sWeapon[7] == 'd' && sWeapon[8] == 'e')
						{
							if (client == gI_Guard)
								iWeapon = GetPlayerWeaponSlot(gI_Prisoner, CS_SLOT_SECONDARY);
							else if (client == gI_Prisoner)
								iWeapon = GetPlayerWeaponSlot(gI_Guard, CS_SLOT_SECONDARY);
						}
					}
					case SHOT4SHOTWEAPON_AK47:
					{
						if (sWeapon[7] == 'a' && sWeapon[8] == 'k')
						{
							if (client == gI_Guard)
								iWeapon = GetPlayerWeaponSlot(gI_Prisoner, CS_SLOT_PRIMARY);
							else if (client == gI_Prisoner)
								iWeapon = GetPlayerWeaponSlot(gI_Guard, CS_SLOT_PRIMARY);
						}
					}
					case SHOT4SHOTWEAPON_M4A4:
					{
						if (sWeapon[7] == 'm' && sWeapon[8] == '4')
						{
							if (client == gI_Guard)
								iWeapon = GetPlayerWeaponSlot(gI_Prisoner, CS_SLOT_PRIMARY);
							else if (client == gI_Prisoner)
								iWeapon = GetPlayerWeaponSlot(gI_Guard, CS_SLOT_PRIMARY);
						}
					}
					case SHOT4SHOTWEAPON_SCOUT:
					{
						if (sWeapon[7] == 's' && sWeapon[8] == 's')
						{
							if (client == gI_Guard)
								iWeapon = GetPlayerWeaponSlot(gI_Prisoner, CS_SLOT_PRIMARY);
							else if (client == gI_Prisoner)
								iWeapon = GetPlayerWeaponSlot(gI_Guard, CS_SLOT_PRIMARY);
						}
					}
					case SHOT4SHOTWEAPON_NEGEV:
					{
						if (sWeapon[7] == 'n' && sWeapon[8] == 'e')
						{
							if (client == gI_Guard)
								iWeapon = GetPlayerWeaponSlot(gI_Prisoner, CS_SLOT_PRIMARY);
							else if (client == gI_Prisoner)
								iWeapon = GetPlayerWeaponSlot(gI_Guard, CS_SLOT_PRIMARY);
						}
					}
					case SHOT4SHOTWEAPON_MAG7:
					{
						if (sWeapon[7] == 'm' && sWeapon[8] == 'a')
						{
							if (client == gI_Guard)
								iWeapon = GetPlayerWeaponSlot(gI_Prisoner, CS_SLOT_PRIMARY);
							else if (client == gI_Prisoner)
								iWeapon = GetPlayerWeaponSlot(gI_Guard, CS_SLOT_PRIMARY);
						}
					}
				}
				if (iWeapon != -1) SetEntProp(iWeapon, Prop_Send, "m_iClip1", 1);
			}
			else
			{
				if (GetClientTeam(client) == 3)
				{
					char[] sWeapon = new char[MAX_NAME_LENGTH]; 
					hEvent.GetString("weapon", sWeapon, MAX_NAME_LENGTH);
					
					if (sWeapon[7] == 't' && sWeapon[8] == 'a')
						SetEntPropFloat(client, Prop_Send, "m_flNextAttack", GetGameTime()+0.85); 
				}
			}
		}
	}
}

public void Event_MolotovDetonate(Event hEvent, const char[] sEventName, bool bDontBroadcast)
{
	if (gH_SpecialDay == SPECIALDAY_COCKTAIL)
	{
		int client = GetClientOfUserId(hEvent.GetInt("userid"));
		
		if (IsValidClient(client) && IsPlayerAlive(client))
		{
			int iMolotov = GivePlayerItem(client, "weapon_molotov");
			
			if (iMolotov != INVALID_ENT_REFERENCE) 
			{
				SetEntPropEnt(client, Prop_Data, "m_hActiveWeapon", iMolotov);
				ChangeEdictState(client, FindDataMapInfo(client, "m_hActiveWeapon"));
			}
		}
	}
}

public void Event_GrenadeDetonate(Event hEvent, const char[] sEventName, bool bDontBroadcast)
{
	if (gH_SpecialDay == SPECIALDAY_NADE || gH_LastRequest == LASTREQUEST_NADE)
	{
		int client = GetClientOfUserId(hEvent.GetInt("userid"));
		
		if (IsValidClient(client) && IsPlayerAlive(client))
		{
			int iGrenade = GivePlayerItem(client, "weapon_hegrenade");
			
			if (iGrenade != INVALID_ENT_REFERENCE) 
			{
				SetEntPropEnt(client, Prop_Data, "m_hActiveWeapon", iGrenade);
				ChangeEdictState(client, FindDataMapInfo(client, "m_hActiveWeapon"));
			}
		}
	}
}

public Action Event_ButtonPress(const char[] sOutput, int iCaller, int iActivator, float fDelay) 
{ 
    if (IsValidEntity(iCaller) && IsValidClient(iActivator))
    { 
		int iMode;

		for (int i = 0; i < gA_Buttons.Length; ++i)
		{		
			if (gA_Buttons.Get(i) == iCaller)
			{
				iMode = gA_ButtonMode.Get(i);
				break;
			}
		}
		
		switch (iMode)
		{
			case 1:
			{
		    	if (gH_SpecialDay == SPECIALDAY_INVALID && gH_LastRequest == LASTREQUEST_INVALID)
		    	{
			    	switch (GetClientTeam(iActivator))
			    	{
			    		case 2:
						{
							char[] sWeapon = new char[32];
							int iWeapon = GetEntPropEnt(iActivator, Prop_Send, "m_hActiveWeapon");
							
							if (iWeapon != -1)
							    GetEntityClassname(iWeapon, sWeapon, 32);
							
							if (sWeapon[7] != 'k' && sWeapon[8] != 'n')
								return Plugin_Handled;
							
							if (gB_Cells)
								Cells(false);
							else
								Cells(true);
							
							gB_Cells = !gB_Cells;
							
							if (gI_Cells == 0)
							{
								gB_FreeDay = true;
								
								for (int i = 1; i <= MaxClients; ++i)
								{
									if (IsClientInGame(i))
									{
										PrintToChat(i, "%s\x09%N\x01 has %s\x01 the cells!", JB_TAG, iActivator, (gB_Cells)? "\x04opened":"\x02closed"); 
										PrintToChat(i, "%s\x09Prisoners\x01 opened cells before the \x0BGuards\x01 did!", JB_TAG);
										PrintCenterText(i, "<font color='#FFFF00'>It's an Unrestricted Freeday!</font>");
										
										if (gB_BaseComm)
										{
											if (!BaseComm_IsClientMuted(i))
												SetClientListeningFlags(i, VOICE_NORMAL);
										}
										else SetClientListeningFlags(i, VOICE_NORMAL);
										
										if (IsPlayerAlive(i))
										{
											FadePlayer(i, 300, 300, 0x0001, {255, 255, 102, 100});
											
											if (GetClientTeam(i) == 2)
												SetGlow(i, 255, 255, 0, 255);	
										}
									}
								}
							}
							else PrintToChatAll("%s\x09%N\x01 has %s\x01 the cells!", JB_TAG, iActivator, (gB_Cells)? "\x04opened":"\x02closed"); 
						}
						case 3:
						{
							++gI_Cells;
							
							if (gB_Cells)
								Cells(false);
							else
								Cells(true);
							
							gB_Cells = !gB_Cells;
							PrintToChatAll("%s\x0B%N \x01has %s \x01the cells!", JB_TAG, iActivator, (gB_Cells) ? "\x04opened":"\x02closed");
						}
			    	}
			    }
			    else 
			    {
			    	if (!gB_Cells)
			    	{
			    		gB_Cells = true;
			    		Cells(true);
			    	}
			    }
			}
			case 2: 
			{
				if (gH_SpecialDay != SPECIALDAY_INVALID || GetClientTeam(iActivator) == 2)
					return Plugin_Handled;
			}
		}
    	
    	
		char[] sName = new char[64];
		GetEntPropString(iCaller, Prop_Data, "m_iName", sName, 64);
		
		if (sName[0] == '\0')
			FormatEx(sName, 64, "%i", iCaller);
		
		for (int i = 1; i <= MaxClients; ++i)
			if (IsClientInGame(i)) 
				PrintToConsole(i, "[Jailbreak] %N has pressed \"%s\"", iActivator, sName);
    }
    return Plugin_Continue;
}

public Action Event_OnOpen(const char[] sOutput, int iCaller, int iActivator, float fDelay) 
{
   	gB_Cells = true;
   	gB_Expired = true;
}

public Action Event_OnClose(const char[] sOutput, int iCaller, int iActivator, float fDelay) {
	gB_Cells = false;
}
	
public Action Event_ServerCvar(Event hEvent, const char[] sEventName, bool bDontBroadcast)
{
	hEvent.BroadcastDisabled = true;
	return Plugin_Handled;
}

public Action Event_SoundPlayed(int clients[64], int &numClients, char sample[PLATFORM_MAX_PATH], int &entity, int &channel, float &volume, int &level, int &pitch, int &flags)
{	
	if (gI_Ball == entity && StrEqual(sample, "~)weapons/hegrenade/he_bounce-1.wav"))
	{
		EmitSoundToAll(SOUND_BALL_BOUNCE, entity, channel);
		return Plugin_Handled;
	}
	
	if (0 < entity <= MaxClients)
	{
		if (StrContains(sample, "footsteps") != -1)
		{
			if (StrContains(sample, "new/suit_") != -1)
				return Plugin_Stop;
			
			if (!gB_PlayerSteps[entity])
			{				            
				numClients = 0;
	
				for (int i = 1; i <= MaxClients; ++i)
	            {
					if (IsClientInGame(i))
						clients[numClients++] = i;
				}
				EmitSound(clients, numClients, sample, entity, channel);
			}
			return Plugin_Stop;
		}
	}
	return Plugin_Continue;
}

public Action OnTextMsg(UserMsg msg_id, Protobuf hUserMsg, const int[] iClients, int iNumClients, bool bReliable, bool bInit)
{
	if (!bReliable || hUserMsg.ReadInt("msg_dst") != 3) 
		return Plugin_Continue; 
        
	char[] sBuffer = new char[PLATFORM_MAX_PATH]; 
	hUserMsg.ReadString("params", sBuffer, PLATFORM_MAX_PATH, 0); 

	if (sBuffer[0] == '[' && sBuffer[1] == 'S' && sBuffer[2] == 'M' && sBuffer[3] == ']') 
    { 
		DataPack hPack = new DataPack(); 
		RequestFrame(Frame_Output, hPack); 
		hPack.WriteCell(iNumClients); 
        
		for (int i = 0; i < iNumClients; ++i) 
			hPack.WriteCell(iClients[i]); 
        
		hPack.WriteCell(strlen(sBuffer)); 
		hPack.WriteString(sBuffer); 
		hPack.Reset(); 
		return Plugin_Handled; 
	}

	if (StrContains(sBuffer, "#Chat_SavePlayer_") != -1)
		return Plugin_Handled;
	return Plugin_Continue; 
} 


/*===============================================================================================================================*/
/********************************************************* [SDKTOOLS] ************************************************************/
/*===============================================================================================================================*/


public void OnPostThinkPost(int client)
{
	if (GetClientTeam(client) == 2) SetEntProp(client, Prop_Send, "m_iAddonBits", 0);
}

public Action OnTraceAttack(int victim, int &attacker, int &inflictor, float &damage, int &damagetype, int &weapon, float damageForce[3], float damagePosition[3], int damagecustom)
{	
	bool bCheck;
	
	if (gB_Shove || gH_SpecialDay == SPECIALDAY_JEDI)
	{
		if (attacker != victim && IsValidClient(victim) && IsValidClient(attacker))
		{
			bCheck = true;
			
			if (gB_Shove)
			{
				if (GetClientTeam(attacker) == 2)
				{
					float Push[3], fAngles[3];
					GetClientEyeAngles(attacker, fAngles);
	
					Push[0] = (1100.0 * Cosine(DegToRad(fAngles[1])));
					Push[1] = (1100.0 * Sine(DegToRad(fAngles[1])));
					Push[2] = (-1100.0 * Sine(DegToRad(fAngles[0])));
						
					TeleportEntity(victim, NULL_VECTOR, NULL_VECTOR, Push);
				}
			}
			else
			{
				switch (gH_SpecialDay)
				{
					case SPECIALDAY_JEDI:
					{
						float fVelocity[3];
						GetEntPropVector(victim, Prop_Data, "m_vecVelocity", fVelocity);
						fVelocity[2] = 600.0;
						TeleportEntity(victim, NULL_VECTOR, NULL_VECTOR, fVelocity);
					}
				}
			}
		}
	}
	
	if (bCheck || (attacker != victim && IsValidClient(attacker) && IsValidClient(victim)))
	{
		float fPosition[3], fAngles[3];
		GetClientEyePosition(attacker, fPosition); 
		GetClientEyeAngles(attacker, fAngles); 
		
		TR_TraceRayFilter(fPosition, fAngles, MASK_SHOT, RayType_Infinite, Trace_HitVictimOnly, victim); 
	     
		if (TR_GetHitGroup() == 1)
		{
			char[] sClassname = new char[32];
			GetClientWeapon(attacker, sClassname, 32);
			
			if (StrEqual(sClassname, "weapon_knife"))
			{
				damage *= 2.0;
				return Plugin_Changed;
			}
		}
	}
	return Plugin_Continue;
}

public Action OnPreThink(int client)
{
	if (IsValidClient(client))
	{
		if (gH_SpecialDay == SPECIALDAY_NIGHTCRAWLER)
		{
			if (GetClientTeam(client) == 3)
			{
				int iButtons = GetClientButtons(client);
				
				if (iButtons & IN_USE && IsInterference(client, 15.0))
				{
					if (iButtons & IN_FORWARD)
					{
						float fVel[3];
						VelocityByAim(client, fVel, 240.0);
						TeleportEntity(client, NULL_VECTOR, NULL_VECTOR, fVel);
					}
				}
			}
		}
		else 
		{
			int iWeapon = GetPlayerWeaponSlot(client, CS_SLOT_PRIMARY);
			
			if (IsValidEdict(iWeapon))
			{
				char[] sWeapon = new char[MAX_NAME_LENGTH];
				GetEdictClassname(iWeapon, sWeapon, MAX_NAME_LENGTH);
				
				if (sWeapon[7] == 's' && sWeapon[8] == 's' || sWeapon[7] == 'a' && sWeapon[8] == 'w' || sWeapon[7] == 's' && sWeapon[8] == 'c' || sWeapon[7] == 'g' && sWeapon[8] == '3')
					SetEntPropFloat(iWeapon, Prop_Send, "m_flNextSecondaryAttack", GetGameTime() + 1.0);
			}
		}
	}
}

public void OnBoxTouch(int iBox, int client)
{
	if (IsValidEntity(iBox) && IsValidClient(client))
	{	
		int iColor[4];
		GetEntityRenderColor(iBox, iColor[0], iColor[1], iColor[2], iColor[3]);
		AcceptEntityInput(iBox, "Kill");
		
		if (gH_SpecialDay == SPECIALDAY_INVALID)
		{		
			if (iColor[0] != 0)
			{
				if (iColor[0] != 255) // Ultra Rare 0.5%
				{
					int iCredits = GetRandomInt(100, 500);
					PrintToChatAll("%s%s%N\x01 found \x04%i\x01 random credits!", JB_TAG, (GetClientTeam(client) == 2)? "\x09":"\x0B", client, iCredits);
					gI_Credits[client] += iCredits;
					EmitSoundToAll(SOUND_BOX_MONEY1, client, SNDCHAN_BODY);
				}
				else
				{
					if (iColor[1] == 0) // Rare 1.0%
					{
						switch (GetRandomInt(1, 3))
						{
							case 1: // Freeday Pass
							{
								if (GetClientTeam(client) == 2)
								{
									if (gH_LastRequest == LASTREQUEST_INVALID)
									{	
										PrintToChatAll("%s\x09%N\x01 has found a \x09Freeday Pass", JB_TAG, client);	
										gB_Freeday[client] = true;
										SetGlow(client, 255, 255, 0, 255);
										FadePlayer(client, 300, 300, 0x0001, {255, 255, 0, 100});
									}
									else PrintToChat(client, "%sYou have found a \x09Freeday Pass\x01, but it's Lastrequest! Sorry :(", JB_TAG);	
								}
								else PrintToChatAll("%s\x0B%N\x01 have destroyed a \x02Freeday Pass", JB_TAG, client);	
							}
							case 2: // Death
							{
								float fOrigin[3]; 
								GetClientAbsOrigin(client, fOrigin);
								EmitAmbientSound("weapons/hegrenade/explode4.wav", fOrigin, client);
								ForcePlayerSuicide(client);	
							}
							case 3: // Weapons
							{
								if (GetClientTeam(client) == 2)
								{
									switch (GetRandomInt(1, 3))
									{
										case 1:
										{			
											GivePlayerItem(client, "weapon_glock");
											PrintToChat(client, "%sYou have found a \x02Glock", JB_TAG);		
										}
										case 2: 
										{
											GivePlayerItem(client, "weapon_elite");
											PrintToChat(client, "%sYou have found \x02Berettas", JB_TAG);		
										}
										case 3:
										{
											GivePlayerItem(client, "weapon_taser");
											PrintToChat(client, "%sYou have found a \x02Taser", JB_TAG);									
										}
									}
								}
								else PrintToChatAll("%s\x0B%N\x01 have destroyed a \x02Weapon Box", JB_TAG, client);	
							}
							case 4: // Grenades
							{
								switch (GetRandomInt(1, 3))
								{
									case 1:
									{			
										GivePlayerItem(client, "weapon_hegrenade");
										PrintToChat(client, "%sYou have found a \x02Grenade", JB_TAG);		
									}
									case 2: 
									{
										GivePlayerItem(client, "weapon_flashbang");
										PrintToChat(client, "%sYou have found \x02Flashbang", JB_TAG);		
									}
									case 3:
									{
										GivePlayerItem(client, "weapon_molotov");
										PrintToChat(client, "%sYou have found a \x02Molotov", JB_TAG);									
									}
									case 4:
									{
										GivePlayerItem(client, "weapon_decoy");
										PrintToChat(client, "%sYou have found a \x02Decoy", JB_TAG);		
									}
								}	
							}
						}
					}
					else // Legendary 0.1%
					{
						int iCredits = GetRandomInt(500, 2000);
						PrintToChatAll("%s%s%N\x01 found \x04%i\x01 credits from a \x09Treasure box", JB_TAG, (GetClientTeam(client) == 2)? "\x09":"\x0B", client, iCredits);
						gI_Credits[client] += iCredits;
						EmitSoundToAll(SOUND_BOX_MONEY2, client, SNDCHAN_BODY);
					}
				}
			}
			else
			{
				if (iColor[2] != 0) // Common 94%
				{	
					int iTotal = CREDITS_BOX_COMMON + gI_Stealing[client];
					
					if (GetClientTeam(client) == 3)
					{
						PrintToChat(client, "%sYou found \x04%i\x01 credits!", JB_TAG, iTotal / 2);
						gI_Credits[client] += iTotal / 2;
					}
					else
					{
						PrintToChat(client, "%sYou found \x04%i\x01 credits!", JB_TAG, iTotal);
						gI_Credits[client] += iTotal;
					}
				}
				else // Uncommon 5.0%
				{
					switch (GetRandomInt(1, 2))
					{
						case 1: // Health 
						{
							SetEntityHealth(client, 255);
							PrintToChat(client, "%sYou found a \x04Lucky Sandwich", JB_TAG, client);
						}
						case 2: // Gravity
						{
							SetEntityGravity(client, 0.3);
							PrintToChatAll("%s%s%N\x01 found \x04Low Gravity", JB_TAG, (GetClientTeam(client) == 2)? "\x09":"\x0B", client);
						}
					}
				}
			}
			EmitSoundToAll(SOUND_BOX_PICKUP, client, SNDCHAN_BODY);
		}
		else PrintToChat(client, "%sYou can't collect boxes on special days!", JB_TAG);
	}
}

public void OnTagTouch(int iTag, int client)
{
	if (IsValidEntity(iTag) && IsValidClient(client) && IsPlayerAlive(client))
	{	
		int iOwner = GetEntPropEnt(iTag, Prop_Data, "m_hOwnerEntity");
		AcceptEntityInput(iTag, "Kill");
		
		if (IsValidClient(iOwner))
		{
			gI_Activity[iOwner] = -1;
			gF_Pushed[iOwner] = 0.0;
			PrintToChat(iOwner, "%s\x03%N\x01 has picked up your tag!", JB_TAG, client);
			PrintToChat(client, "%sYou picked up \x03%N\x01's tag!", JB_TAG, iOwner);
		}
		
		int iHealth = GetClientHealth(client);
		
		if (iHealth < 100)
		{
			iHealth += 50;
			
			if (iHealth > 100)
				SetEntProp(client, Prop_Send, "m_iHealth", 100);
			else
				SetEntProp(client, Prop_Send, "m_iHealth", iHealth);
		}
		RoundEndChecks();
	}
}

public Action OnSetTransmit_GlowSkin(int iSkin, int client)
{
	if (IsValidClient(client) && IsPlayerAlive(client))
	{
		for (int i = 1; i <= MaxClients; ++i)
			if (IsClientInGame(i) && CPS_HasSkin(i) && EntRefToEntIndex(CPS_GetSkin(i)) != iSkin)
				return Plugin_Continue;
	}
	return Plugin_Handled;
}

public Action OnDoorShot(int victim, int &attacker, int &inflictor, float &damage, int &damagetype) 
{
	if (gH_SpecialDay != SPECIALDAY_INVALID || gH_LastRequest != LASTREQUEST_INVALID || gCV_Respawn.BoolValue)
	{
		if (IsValidEdict(victim))
			AcceptEntityInput(victim, "Open");	
	}
}

public Action OnTakeDamage(int victim, int &attacker, int &inflictor, float &damage, int &damagetype) 
{
	if (victim != attacker && IsValidClient(victim))
	{
		if (gH_SpecialDay != SPECIALDAY_INVALID)
		{
			if (gI_Seconds > 0)
				return Plugin_Handled;
				
			switch (gH_SpecialDay)
			{
				case SPECIALDAY_JEDI:
				{
					if (IsValidClient(attacker))
						return Plugin_Handled;
				}
				case SPECIALDAY_GANG:
				{
					if (IsValidClient(attacker) && gI_ClientStatus[attacker] == gI_ClientStatus[victim])
						return Plugin_Handled;					
				}
				case SPECIALDAY_SHARK:
				{
					if (IsValidClient(attacker) && GetClientTeam(victim) == 3 && GetClientTeam(attacker) == 2)
					{
						SetEntityMoveType(victim, MOVETYPE_WALK);
						return Plugin_Continue;
					}
				}
				case SPECIALDAY_NIGHTCRAWLER:
				{
					if (GetClientTeam(victim) == 3)
					{
						if (damagetype & DMG_FALL)
							return Plugin_Handled;
						
						if (IsValidClient(attacker) && GetClientTeam(attacker) == 2)
						{
							gB_PlayerSteps[victim] = false;
							CreateTimer(2.0, Timer_NightCrawler, GetClientUserId(victim), TIMER_FLAG_NO_MAPCHANGE);
							return Plugin_Continue;
						}
					}
				}
				case SPECIALDAY_COCKTAIL:
				{
					if (IsValidClient(attacker))
					{
						IgniteEntity(victim, 2.0);
						return Plugin_Continue;			
					}	
				}
			}
		}
		else 
		{
			if (gH_LastRequest == LASTREQUEST_INVALID && IsValidClient(attacker))
			{
				if (gB_TickingTimeBomb)
				{
					if (attacker == gI_Prisoner && GetClientTeam(victim) == 2)
					{
						SetGlow(attacker, 255, 255, 255, 255);
						SetGlow(victim, 255, 0, 0, 255);
						gI_Prisoner = victim;
						FadePlayer(gI_Prisoner, 300, 300, 0x0001, {255, 0, 0, 100});
						PrintCenterTextAll("<font color='#f45942'>%N</font> has the bomb!", gI_Prisoner);				
					}
				}
				
				if (gCV_FriendlyFire.BoolValue)
				{
					if (GetClientTeam(attacker) == 3 && GetClientTeam(victim) == 3) {
						return Plugin_Handled;
					}
					else if (gB_KnifeDuel && GetClientTeam(attacker) == 2 && GetClientTeam(victim) == 2)
					{
						if (gI_ClientStatus[attacker] == gI_ClientStatus[victim] || gI_ClientStatus[attacker] <= 0 || gI_ClientStatus[victim] <= 0)
							return Plugin_Handled;
					}
				}
				
				if (damagetype == 4352 && gF_CagePosition[0] != 0.0 && GetClientTeam(attacker) == 3 && GetClientTeam(victim) == 2)
				{
					TeleportEntity(victim, gF_CagePosition, NULL_VECTOR, NULL_VECTOR);
					return Plugin_Handled;	
				}
				
				if (gB_HasGang[victim])
				{
					if (gI_Evade[victim] > 0)
					{
						if (GetRandomInt(1, UPGRADE_EVADE_CHANCE) <= gI_Evade[victim])
						{
							EmitSoundToAll(SOUND_GANG_EVADE, victim, SNDCHAN_BODY);
							damage = 0.0;
							return Plugin_Changed;
						}
					}
				}
				
				if (gB_HasGang[attacker])
				{			
					damage += gI_Damage[attacker] * 1.3;
					
					if (gI_WeaponDrop[attacker] > 0 && damagetype & DMG_SLASH)
					{
						if (GetRandomInt(1, UPGRADE_DROP_CHANCE) <= gI_WeaponDrop[attacker])
						{
							int iWeapon = GetEntPropEnt(victim, Prop_Send, "m_hActiveWeapon");
							
							if (iWeapon != -1) 
							{
								if (iWeapon != GetPlayerWeaponSlot(victim, CS_SLOT_KNIFE) && iWeapon != GetPlayerWeaponSlot(victim, CS_SLOT_GRENADE))
									CS_DropWeapon(victim, iWeapon, true);
							}
						}
					}
					return Plugin_Changed;
				}
			}
		}
	}
	return Plugin_Continue;
}  

public Action OnTakeDamagePost(int victim, int attacker)
{
	if (gH_SpecialDay == SPECIALDAY_SHARK)
	{
		if (IsValidClient(victim) && IsPlayerAlive(victim) && GetClientTeam(victim) == 3 && GetEntityMoveType(victim) != MOVETYPE_NOCLIP)
			SetEntityMoveType(victim, MOVETYPE_NOCLIP);
	}
}

public Action OnWeaponDecideUse(int client, int iWeapon)
{
	if (gH_SpecialDay != SPECIALDAY_INVALID)
	{		
		if (IsValidEdict(iWeapon) && IsValidClient(client) && IsPlayerAlive(client))
		{
			if (gI_Seconds > 0)
				return Plugin_Handled;
			
			char[] sWeapon = new char[MAX_NAME_LENGTH];
			GetEdictClassname(iWeapon, sWeapon, MAX_NAME_LENGTH);
			
			switch (gH_SpecialDay)
			{
				case SPECIALDAY_KNIFE, SPECIALDAY_JEDI:
				{
					if (sWeapon[7] != 'k' && sWeapon[8] != 'n')
						return Plugin_Handled;
				}
				case SPECIALDAY_NADE:
				{
					if (sWeapon[7] != 'h' && sWeapon[8] != 'e')
						return Plugin_Handled;		
				}
				case SPECIALDAY_COCKTAIL:
				{
					if (sWeapon[7] != 'm' && sWeapon[8] != 'o')
						return Plugin_Handled;		
				}
				case SPECIALDAY_GANG:
				{
					if (sWeapon[7] != 'k' && sWeapon[8] != 'n' && sWeapon[7] != 't' && sWeapon[8] != 'e' && sWeapon[7] != 'm' && sWeapon[8] != 'a')
						return Plugin_Handled;	
				}
				case SPECIALDAY_SCOUTZKNIVEZ:
				{
					if (sWeapon[7] != 'k' && sWeapon[8] != 'n' && sWeapon[7] != 's' && sWeapon[8] != 's')
						return Plugin_Handled;	
				}
				case SPECIALDAY_NOSCOPE:
				{
					if (sWeapon[7] != 'k' && sWeapon[8] != 'n' && sWeapon[7] != 'a' && sWeapon[8] != 'w')
						return Plugin_Handled;	
				}
				case SPECIALDAY_ONEINACHAMBER, SPECIALDAY_HEADSHOT:
				{
					if (sWeapon[7] != 'k' && sWeapon[8] != 'n' && sWeapon[7] != 'd' && sWeapon[8] != 'e')
						return Plugin_Handled;	
				}
				case SPECIALDAY_NIGHTCRAWLER:
				{
					switch (GetClientTeam(client))
					{
						case 3:
						{
							if (sWeapon[7] != 'k' && sWeapon[8] != 'n')
								return Plugin_Handled;	
						}
						case 2:
						{
							if (sWeapon[7] != 'k' && sWeapon[8] != 'n' && sWeapon[7] != 'd' && sWeapon[8] != 'e' && sWeapon[7] != 'm' && sWeapon[8] != '4')
								return Plugin_Handled;	
						}
					}
				}
				case SPECIALDAY_SHARK:
				{
					switch (GetClientTeam(client))
					{
						case 3:
						{
							if (sWeapon[7] != 'k' && sWeapon[8] != 'n')
								return Plugin_Handled;	
						}
						case 2:
						{
							if (sWeapon[7] != 'k' && sWeapon[8] != 'n' && sWeapon[7] != 'a' && sWeapon[8] != 'w')
								return Plugin_Handled;	
						}
					}
				}
				case SPECIALDAY_TRIGGER:
				{
					if (sWeapon[7] != 'k' && sWeapon[8] != 'n' && sWeapon[7] != 'h' && sWeapon[8] != 'k')
						return Plugin_Handled;	
				}
				case SPECIALDAY_GUNGAME:
				{
					switch (gI_Activity[client])
					{
						case 0, 1: 
						{
							if (sWeapon[7] != 'k' && sWeapon[8] != 'n' && sWeapon[7] != 'g' && sWeapon[8] != 'l')
								return Plugin_Handled;	
						}
						case 2, 3: 
						{
							if (sWeapon[7] != 'k' && sWeapon[8] != 'n' && sWeapon[7] != 'h' && sWeapon[8] != 'k')
								return Plugin_Handled;	
						}
						case 4, 5: 
						{
							if (sWeapon[7] != 'k' && sWeapon[8] != 'n' && sWeapon[7] != 'p' && sWeapon[8] != '2')
								return Plugin_Handled;	
						}
						case 6, 7: 
						{
							if (sWeapon[7] != 'k' && sWeapon[8] != 'n' && sWeapon[7] != 'n' && sWeapon[8] != 'o')
								return Plugin_Handled;	
						}
						case 8, 9:
						{
							if (sWeapon[7] != 'k' && sWeapon[8] != 'n' && sWeapon[7] != 'm' && sWeapon[8] != 'p')
								return Plugin_Handled;	
						}
						case 10, 11: 
						{
							if (sWeapon[7] != 'k' && sWeapon[8] != 'n' && sWeapon[7] != 'a' && sWeapon[8] != 'k')
								return Plugin_Handled;	
						}
						case 12, 13: 
						{
							if (sWeapon[7] != 'k' && sWeapon[8] != 'n' && sWeapon[7] != 'm' && sWeapon[8] != '4')
								return Plugin_Handled;	
						}
						case 14, 15: 
						{
							if (sWeapon[7] != 'k' && sWeapon[8] != 'n' && sWeapon[7] != 'n' && sWeapon[8] != 'e')
								return Plugin_Handled;	
						}
						case 16, 17: 
						{
							if (sWeapon[7] != 'k' && sWeapon[8] != 'n' && sWeapon[7] != 's' && sWeapon[8] != 's')
								return Plugin_Handled;	
						}
						case 18, 19: 
						{
							if (sWeapon[7] != 'k' && sWeapon[8] != 'n' && sWeapon[7] != 'a' && sWeapon[8] != 'w')
								return Plugin_Handled;	
						}
						case 20:
						{
							if (sWeapon[7] != 'k' && sWeapon[8] != 'n')
								return Plugin_Handled;	
						}
					}	
				}
			}
		}
	}
	else if (gH_LastRequest != LASTREQUEST_INVALID)
	{
		if (IsValidClient(client) && IsPlayerAlive(client) && IsValidEdict(iWeapon) && (client == gI_Prisoner || client == gI_Guard))
		{
			char[] sWeapon = new char[MAX_NAME_LENGTH];
			GetEdictClassname(iWeapon, sWeapon, MAX_NAME_LENGTH);
			
			switch (gH_LastRequest)
			{
				case LASTREQUEST_KNIFE:
				{
					if (sWeapon[7] != 'k' && sWeapon[8] != 'n')
						return Plugin_Handled;				
				}
				case LASTREQUEST_NADE:
				{
					if (sWeapon[7] != 'h' && sWeapon[8] != 'e')
						return Plugin_Handled;		
				}
				case LASTREQUEST_NOSCOPE:
				{					
					switch (gI_LastRequestWeapon)
					{
						case NOSCOPEWEAPON_AWP:					
						{
							if (sWeapon[7] != 'k' && sWeapon[8] != 'n' && sWeapon[7] != 'a' && sWeapon[8] != 'w')
								return Plugin_Handled;	
						}
						case NOSCOPEWEAPON_SCOUT:
						{
							if (sWeapon[7] != 'k' && sWeapon[8] != 'n' && sWeapon[7] != 's' && sWeapon[8] != 's')
								return Plugin_Handled;	
						}
						case NOSCOPEWEAPON_SCAR:
						{
							if (sWeapon[7] != 'k' && sWeapon[8] != 'n' && sWeapon[7] != 's' && sWeapon[8] != 'c')
								return Plugin_Handled;	
						}
						case NOSCOPEWEAPON_G3SG1:
						{
							if (sWeapon[7] != 'k' && sWeapon[8] != 'n' && sWeapon[7] != 'g' && sWeapon[8] != '3')
								return Plugin_Handled;	
						}
					}
				}
				case LASTREQUEST_SHOT4SHOT:
				{
					switch (gI_LastRequestWeapon)
					{
						case SHOT4SHOTWEAPON_DEAGLE:
						{
							if (sWeapon[7] != 'k' && sWeapon[8] != 'n' && sWeapon[7] != 'd' && sWeapon[8] != 'e')
								return Plugin_Handled;	
						}
						case SHOT4SHOTWEAPON_AK47:
						{
							if (sWeapon[7] != 'k' && sWeapon[8] != 'n' && sWeapon[7] != 'a' && sWeapon[8] != 'k')
								return Plugin_Handled;	
						}
						case SHOT4SHOTWEAPON_M4A4:
						{
							if (sWeapon[7] != 'k' && sWeapon[8] != 'n' && sWeapon[7] != 'm' && sWeapon[8] != '4')
								return Plugin_Handled;	
						}
						case SHOT4SHOTWEAPON_SCOUT:
						{
							if (sWeapon[7] != 'k' && sWeapon[8] != 'n' && sWeapon[7] != 's' && sWeapon[8] != 's')
								return Plugin_Handled;	
						}
						case SHOT4SHOTWEAPON_NEGEV:
						{
							if (sWeapon[7] != 'k' && sWeapon[8] != 'n' && sWeapon[7] != 'n' && sWeapon[8] != 'e')
								return Plugin_Handled;	
						}
						case SHOT4SHOTWEAPON_MAG7:
						{
							if (sWeapon[7] != 'k' && sWeapon[8] != 'n' && sWeapon[7] != 'm' && sWeapon[8] != 'a')
								return Plugin_Handled;	
						}
					}
				}
				case LASTREQUEST_SHOTGUN:
				{
					if (sWeapon[7] != 'k' && sWeapon[8] != 'n' && sWeapon[7] != 'n' && sWeapon[8] != 'o')
						return Plugin_Handled;		
				}
				case LASTREQUEST_HEADSHOT:
				{
					if (sWeapon[7] != 'k' && sWeapon[8] != 'n' && sWeapon[7] != 'd' && sWeapon[8] != 'e')
						return Plugin_Handled;		
				}
			}
		}
	}
	return Plugin_Continue;
}

public Action OnBallHolderHurt(int victim, int &attacker, int &inflictor, float &damage, int &damagetype, int &ammotype, int hitbox, int hitgroup) 
{ 
	if (victim == gI_BallHolder && IsValidClient(attacker) && IsValidClient(victim) && victim != attacker)
		KickBall(victim, BALL_KICK_POWER);
} 

public Action OnPlayerRunCmd(int client, int &buttons, int &impulse, float vel[3])
{		
	if (IsPlayerAlive(client))
	{				
		CheckHook(client, buttons);
		CheckParachute(client, buttons);
		
		if (gB_Jihad[client] && buttons & IN_USE)
		{    		
			char[] sWeapon = new char[MAX_NAME_LENGTH];
			GetClientWeapon(client, sWeapon, MAX_NAME_LENGTH);
			
			if (sWeapon[7] == 'c' && sWeapon[8] == '4')
			{
				RemoveAllWeapons(client);
				EmitSoundToAll(SOUND_SHOP_JIHAD, client);
				CreateTimer(2.3, Timer_Bomb, GetClientUserId(client), TIMER_FLAG_NO_MAPCHANGE);
			}
		}
		
		if (client == gI_BallHolder && IsValidEdict(gI_Ball))
		{
			if (buttons & IN_USE) {
				KickBall(client, BALL_KICK_POWER);
			}
			else
			{
				float fOrigin[3];
				
				if (GetClientFrontBallOrigin(client, BALL_PLAYER_DISTANCE, BALL_HOLD_HEIGHT, fOrigin))
					TeleportEntity(gI_Ball, fOrigin, NULL_VECTOR, view_as<float>({0.0, 0.0, 100.0}));
				else
					RespawnBall();
			}
		}
		
		if (gB_Freeday[client])
		{
			float fOrigin[3];
			GetClientAbsOrigin(client, fOrigin);
			fOrigin[2] += 5.0;
			TE_SetupBeamRingPoint(fOrigin, 55.0, 55.1, gI_Sprites[0], gI_Sprites[1], 0, 10, 0.1, 1.0, 0.0, {255, 255, 0, 255}, 0, 0);
			TE_SendToAll();
		}
		
		switch (gH_SpecialDay)
		{
			case SPECIALDAY_NIGHTCRAWLER:
			{
				switch (GetClientTeam(client))
				{
					case 2:
					{
						float fOrigin[3], fPosition[3];
						int target = GetPlayerAimTarget(client, fPosition);
						GetClientEyePosition(client, fOrigin);
						
						fOrigin[2] -= 1;

						if (IsValidClient(target) && GetClientTeam(target) == 3)
							TE_SetupBeamPoints(fOrigin, fPosition, gI_Sprites[0], 0, 0, 0, 0.1, 0.4, 0.4, 1, 0.0, {255, 0, 0, 200}, 0);
						else 
							TE_SetupBeamPoints(fOrigin, fPosition, gI_Sprites[0], 0, 0, 0, 0.1, 0.4, 0.4, 1, 0.0, {0, 255, 0, 200}, 0);
						TE_SendToAll();
					}
					case 3:
					{
						if (gI_Activity[client] > 0)
						{
							if ((buttons & IN_USE))
							{
								if (!(gI_LastButtons[client] & IN_USE))
								{
									++gI_ButtonsPressed[client];
						
									if (gI_ButtonsPressed[client] == 1)
									{
										delete gH_ButtonsReset[client];
										gH_ButtonsReset[client] = CreateTimer(0.2, Timer_ResetButtons, GetClientUserId(client));
									}
									else if (gI_ButtonsPressed[client] == 2)
									{
										gI_ButtonsPressed[client] = -1;
										float vOrigin[3]; GetClientAim(client, vOrigin);
										TeleportEntity(client, vOrigin, NULL_VECTOR, NULL_VECTOR);
										gI_Activity[client]--;
										EmitSoundToAll(SOUND_SD_TELEPORT, client);
										FadePlayer(client, 500, 300, 0x0001, {130, 47, 225, 70});
										PrintCenterText(client, "You have Teleported!");
										PrintToChat(client, "%sYou have \x04%i\x01 more Teleports!", JB_TAG, gI_Activity[client]);
									}
								}
							}
							else if ((gI_LastButtons[client] & IN_USE) && gI_ButtonsPressed[client] == -1)
								gI_ButtonsPressed[client] = 0;
							
							gI_LastButtons[client] = buttons;	
						}
					}
				}
				return Plugin_Continue;
			}
			case SPECIALDAY_JEDI:
			{
				if (gI_Seconds < 1)
				{
					if (GetEntityMoveType(client) == MOVETYPE_LADDER)
					{
						SetEntityMoveType(client, MOVETYPE_WALK);
						vel[0] = -vel[0];
						vel[1] = -vel[1];
						TeleportEntity(client, NULL_VECTOR, NULL_VECTOR, vel);
					}
					
					float fTime = GetGameTime();
					
					if (gF_Pushed[client] >= fTime)
					{
						PrintCenterText(client, "Wait <font color='#46c42d'>%.02f</font> seconds to be able to push again!", gF_Pushed[client] - fTime);
						return Plugin_Continue;
					}
					
					if (buttons & IN_USE)
					{	
						int target = GetPlayerAimTarget(client);
						
						if (IsValidClient(target))
						{						
							float Push[3], fAngles[3];
							GetClientEyeAngles(client, fAngles);
								
							Push[0] = (5000.0 * Cosine(DegToRad(fAngles[1])));
							Push[1] = (5000.0 * Sine(DegToRad(fAngles[1])));
							Push[2] = (-5000.0 * Sine(DegToRad(fAngles[0])));
							
							PrintToChat(target, "%s\x02%N\x01 has pushed you!", JB_TAG, client);
							PrintToChat(client, "%sYou pushed \x02%N\x01!", JB_TAG, target);
							TeleportEntity(target, NULL_VECTOR, NULL_VECTOR, Push);
						}
						gF_Pushed[client] = fTime + 3.0;
						EmitSoundToAll(SOUND_SD_FORCEPUSH, client);
					}
				}
				return Plugin_Continue;
			}
		}
		
		if (gH_LastRequest == LASTREQUEST_KEYS)
		{
			if ((client == gI_Prisoner || client == gI_Guard) && buttons != 0)
			{
				if (!(buttons & gI_MovementKeys[gI_Activity[client]]))
				{
					if (gI_Activity[client] >= 1 && gI_ClientStatus[client] != buttons)
					{
						ClientCommand(client, "play %s", SOUND_LR_WRONG);
						gI_Activity[client] = 0;
					}
				}
				else 
				{
					++gI_Activity[client];
					ClientCommand(client, "play %s", SOUND_LR_CORRECT);
				}
				
				gI_ClientStatus[client] = buttons;
				
				if (gI_Activity[client] == MAXKEYLIMIT)
				{
					if (client == gI_Prisoner)
						SDKHooks_TakeDamage(gI_Guard, gI_Prisoner, gI_Prisoner, 500.0);
					else
						SDKHooks_TakeDamage(gI_Prisoner, gI_Guard, gI_Guard, 500.0);
					
					gI_Activity[client] = 0;
				}
			}
		}
		else
		{
			if (gI_Warden == client)
			{
				if ((buttons & IN_USE))
				{
					if (!(gI_LastButtons[client] & IN_USE))
					{
						++gI_ButtonsPressed[client];
			
						if (gI_ButtonsPressed[client] == 1)
						{
							delete gH_ButtonsReset[client];
							gH_ButtonsReset[client] = CreateTimer(0.2, Timer_ResetButtons, GetClientUserId(client));
						}
						else if (gI_ButtonsPressed[client] == 2)
						{
							gI_ButtonsPressed[client] = -1;
							GetPlayerEyeViewPoint(client, gF_MakerPos);
							gF_MakerPos[2] += 7.0;
						}
					}
				}
				else if ((gI_LastButtons[client] & IN_USE) && gI_ButtonsPressed[client] == -1)
					gI_ButtonsPressed[client] = 0;
				
				gI_LastButtons[client] = buttons;	
			}
		}
	}
	else if (gH_SpecialDay == SPECIALDAY_KILLCONFIRM)
	{
		if (gI_Activity[client] != -1)
		{
			float fTime = GetGameTime();
			
			if (gF_Pushed[client] >= fTime) {
				PrintCenterText(client, "Respawning in <font color='#46c42d'>%.02f</font> seconds", gF_Pushed[client] - fTime);
			}
		}
		return Plugin_Continue;
	}
	return Plugin_Continue;
}

public Action OnSetTransmit(int entity, int client)
{
	if (client != entity && IsValidClient(entity) && gB_PlayerSteps[entity] && IsValidClient(client) && GetClientTeam(client) == 2 && IsPlayerAlive(client))
		return Plugin_Handled;
	return Plugin_Continue;
}

public void OnEntityCreated(int iEntity, const char[] classname)
{
	if (gH_SpecialDay == SPECIALDAY_NADE || gH_LastRequest == LASTREQUEST_NADE)
	{
		if (StrEqual(classname, "hegrenade_projectile"))
			SDKHook(iEntity, SDKHook_SpawnPost, OnEntitySpawned);
	}
	else
	{
		if (StrEqual(classname, "hegrenade_projectile"))	
			SDKHook(iEntity, SDKHook_SpawnPost, OnEntitySpawned);
	}
}

public void OnEntitySpawned(int iEntity)
{
	if (IsValidEntity(iEntity))
	{
		if (gH_SpecialDay == SPECIALDAY_NADE || gH_LastRequest == LASTREQUEST_NADE)
		{			
			TE_SetupBeamFollow(iEntity, gI_Sprites[0], 0, 4.0, 2.2, 2.2, 1, {255, 0, 0, 255}); 
			TE_SendToAll();
		}
		else RequestFrame(Frame_ClusterThink, iEntity);
	}
}

public Action OnBallHit(int victim, int &attacker, int &inflictor, float &damage, int &damagetype, int &ammotype, int hitbox, int hitgroup) 
{ 
	if (IsValidEntity(victim) && IsValidClient(attacker))
	{
		float Push[3], fAngles[3], fOrigin[3], fVelocity[3];
		GetClientEyeAngles(attacker, fAngles);
		
		GetEntPropVector(victim, Prop_Data, "m_vecOrigin", fOrigin);
		GetEntPropVector(victim, Prop_Data, "m_vecVelocity", fVelocity);
		
		Push[0] = ((damage*1.5 + BALL_KICK_POWER) * Cosine(DegToRad(fAngles[1])));
		Push[1] = ((damage*1.5 + BALL_KICK_POWER) * Sine(DegToRad(fAngles[1])));
		Push[2] = (-(damage*1.5 + BALL_KICK_POWER) * Sine(DegToRad(fAngles[0])));
		
		gI_BallHolder = 0;
		
		if (fVelocity[0] == 0.0)
		{
			DestroyBall();
			CreateBall();
			
			if (IsValidEntity(gI_Ball))
				TeleportEntity(gI_Ball, fOrigin, NULL_VECTOR, Push);	
		}
		else TeleportEntity(gI_Ball, fOrigin, NULL_VECTOR, Push);	
	}
}

public void OnBallTouch(int ball, int entity)
{
	if (IsValidEntity(ball))
	{
		if (gI_Zones >= 0)
		{
			float vPoints[8][MAXZONELIMIT][3];
			
			for (int i = 0; i <= gI_Zones; i++)
			{
				vPoints[0][i] = gF_ZonePoint1[i];
				vPoints[7][i] = gF_ZonePoint2[i];
			}
			
			float fBallPos[3];
			GetEntPropVector(ball, Prop_Send, "m_vecOrigin", fBallPos);
			fBallPos[2] += 5.0;
			
			if (!gB_DeathBall && IsInsideZone(vPoints, fBallPos)) 
			{
				EmitAmbientSound(SOUND_BALL_GOAL, fBallPos, ball);
				TE_SetupBeamRingPoint(fBallPos, 10.0, 400.0, gI_Sprites[0], 0, 0, 15, 1.0, 7.0, 0.0, {66, 188, 244, 255}, 10, 0);
				TE_SendToAll();
				RespawnBall();
			}
			else
			{
				if (entity != gI_BallHolder && IsValidClient(entity) && IsPlayerAlive(entity))
				{
					if (IsValidClient(gI_BallHolder))
						SDKUnhook(gI_BallHolder, SDKHook_TraceAttack, OnBallHolderHurt);
					
					if (gB_DeathBall && GetClientTeam(entity) == 2)
						ForcePlayerSuicide(entity);	
					else 
					{
						gI_BallHolder = entity;
						SDKHook(entity, SDKHook_TraceAttack, OnBallHolderHurt);
					}
				}
			}
		}
		else
		{
			if (entity != gI_BallHolder && IsValidClient(entity) && IsPlayerAlive(entity))
			{
				if (IsValidClient(gI_BallHolder))
					SDKUnhook(gI_BallHolder, SDKHook_TraceAttack, OnBallHolderHurt);
				
				if (gB_DeathBall && GetClientTeam(entity) == 2)
					ForcePlayerSuicide(entity);	
				else 
				{
					gI_BallHolder = entity;
					SDKHook(entity, SDKHook_TraceAttack, OnBallHolderHurt);
				}
			}
		}
	}
}


/*===============================================================================================================================*/
/********************************************************* [COMMANDS] ************************************************************/
/*===============================================================================================================================*/


public Action Cmd_TransferWarden(int client, int args)
{
	if (Checker(client, true, 3, true, true))
		OpenTransferWardenMenu(client);
	return Plugin_Handled;
}

public Action Cmd_LastRequest(int client, int args)
{
	if (!Checker(client, true, 2, false))
		return Plugin_Handled;
	
	else if (GetPlayerAliveCount(2) > 1)
	{
		PrintToChat(client, "%sToo many \x09Prisoners \x01alive!", JB_TAG);
		return Plugin_Handled;
	}
	else if (GetPlayerAliveCount(3) == 0)
	{
		PrintToChat(client, "%sNo \x0BGuards \x01alive to do Lastrequest with!", JB_TAG);
		return Plugin_Handled;
	}
	
	gI_LastRequestWeapon = -1;
	gH_LastRequest = LASTREQUEST_INVALID;
	
	LastRequestMenu(client, gI_LRHealth[client]);
	return Plugin_Handled;
}

public Action Cmd_Guns(int client, int args)
{
	if (Checker(client, true, 3, false))
	{
		if (gB_Expired && (gI_PrimaryWeapon[client] != -1 || gI_SecondaryWeapon[client] != -1))
		{
			PrintToChat(client, "%sThe gunmenu usage time has expired!", JB_TAG);
			return Plugin_Handled;
		}
		OpenGunsMenu(client, false);
	}
	return Plugin_Handled;
}

public Action Cmd_Math(int client, int args)
{
	if (Checker(client, true, 3, false, false))
	{	
		int iFirstNumber = GetRandomInt(0, 100);
		int iSecondNumber = GetRandomInt(1, 100);
		int iSign = GetRandomInt(0, 1);
			
		PrintToChatAll("%s\x0B%N \x01has started a math challenge!", JB_TAG, client);
		PrintToChatAll("%sEquation: \x04%i %s %i", JB_TAG, iFirstNumber, (iSign == 0)? "+":"-", iSecondNumber);
			
		switch (iSign)
		{
			case 0: gI_Answer = (iFirstNumber + iSecondNumber);
			case 1: gI_Answer = (iFirstNumber - iSecondNumber);
		}
		
		gB_Math = true;
		DataPack hPack = new DataPack();
		CreateDataTimer(30.0, Timer_MathExpired, hPack, TIMER_FLAG_NO_MAPCHANGE);
		hPack.WriteCell(gI_Round);
		hPack.WriteCell(gI_Answer);
		hPack.Reset();
	}
	return Plugin_Handled;
}

public Action Cmd_OpenCells(int client, int args)
{
	if (Checker(client, true, 3, false))
	{
		if (!gB_Cells)
		{
			gB_Cells = true;
			++gI_Cells;
			Cells(true);
			PrintToChatAll("%s\x0B%N \x01has \x04opened\x01 the cells!", JB_TAG, client);
		}
		else PrintToChat(client, "%sThe cells are already opened!", JB_TAG);
	}
	return Plugin_Handled;
}

public Action Cmd_CloseCells(int client, int args)
{
	if (Checker(client, true, 3, false, true))
	{
		if (gB_Cells)
		{
			gB_Cells = false;
			Cells(false);
			PrintToChatAll("%s\x0B%N \x01has \x02closed\x01 the cells!", JB_TAG, client);
		}
		else PrintToChat(client, "%sThe cells are already closed!", JB_TAG);
	}
	return Plugin_Handled;
}

public Action Cmd_PreMenu(int client, int args)
{
	if (IsValidClient(client))
	{
		switch (GetClientTeam(client))
		{
			case 1: OpenSpectatorMenu(client);
			case 2: OpenPrisonerMenu(client);
			case 3: OpenGuardsMenu(client);
		}
	}
	return Plugin_Handled;
}

public Action Cmd_OpenMiniGames(int client, int args)
{
	if (Checker(client, true, 3, true))
		OpenMiniGamesMenu(client);
	return Plugin_Handled;
}

public Action Cmd_OpenSpecialDay(int client, int args)
{
	if (Checker(client, true, 3, true))
	{
		if (GetPlayerAliveCount(2) < SPECIALDAYMINPLAYERS)
		{
			PrintToChat(client, "%sThere must be at least \x04%i \x09Prisoners \x01alive!", JB_TAG, SPECIALDAYMINPLAYERS);
			return Plugin_Handled;
		}
		else if (gB_Expired)
		{
			PrintToChat(client, "%sSpecial Day usage time has expired!", JB_TAG);
			return Plugin_Handled;
		}
		else if (gI_Freedays > 0)
		{
			PrintToChat(client, "%sA prisoner has a freeday!", JB_TAG);
			return Plugin_Handled;
		}
		else if (gI_DayDelay > gI_Round)
		{
			PrintToChat(client, "%sNext Special Day avaliable in \x04%i\x01 Round%s!", JB_TAG, gI_DayDelay - gI_Round, (gI_DayDelay - gI_Round > 1)? "s":"");
			return Plugin_Handled;	
		}
		
		OpenDayMenu(client);
	}
	return Plugin_Handled;
}

public Action Cmd_OpenFreeDay(int client, int args)
{
	if (Checker(client, true, 3, false, false))
		OpenFreeDayMenu(client);
	return Plugin_Handled;
}

public Action Cmd_OpenHealMenu(int client, int args)
{
	if (Checker(client, true, 3, false, false))
		OpenHealMenu(client, gI_LRHealth[client]);
	return Plugin_Handled;
}

public Action Cmd_OpenGlowMenu(int client, int args)
{
	if (Checker(client, true, 3, false, true))
	{
		if (args == 0)
		{
			OpenGlowMenu(client);
			return Plugin_Handled;
		}
		
		char[] sCmd = new char[32];
		GetCmdArgString(sCmd, 32);
		
		int iParam;
		
		if (StrEqual(sCmd, "red", false))
			iParam = 2;
		else if (StrEqual(sCmd, "blue", false))
			iParam = 3;
		else if (StrEqual(sCmd, "green", false))
			iParam = 4;
		else if (StrEqual(sCmd, "purple", false))
			iParam = 5;
		else if (StrEqual(sCmd, "pink", false))
			iParam = 6;
		else iParam = 1;
			
		int target = GetPlayerAimTarget(client);
			
		if (!IsValidClient(target))
		{
			PrintToChat(client, "%sAim at a \x09Prisoner\x01 to glow them!", JB_TAG);
			OpenGlowMenu(client);
			return Plugin_Handled;
		}
		else if (GetClientTeam(target) != 2)
		{
			PrintToChat(client, "%sMust be a \x09Prisoner\x01!", JB_TAG);
			OpenGlowMenu(client);
			return Plugin_Handled;
		}	
		else if (iParam > 1 && gB_Freeday[target])
		{
			PrintToChat(client, "%sThat \x09Prisoner\x01 has a Freeday!", JB_TAG);
			OpenGlowMenu(client);
			return Plugin_Handled;
		}
		else if (gI_ClientStatus[target] == iParam)
		{
			PrintToChat(client, "%sThat \x09Prisoner\x01 is already glowing %s", JB_TAG, (iParam == 1)? "Default":(iParam == 2)? "\x02Red":(iParam == 3)? "\x0BBlue":(iParam == 4)? "\x04Green":(iParam == 5)? "\x03Purple":"\x0EPink");
			OpenGlowMenu(client);
			return Plugin_Handled;
		}
		
		switch (iParam)
		{
			case 1:
			{								
				SetGlow(target, 255, 255, 255, 255);
				
				if (gB_Freeday[target])
				{
					PrintToChatAll("%s\x0B%N \x01has removed \x09%N\x01's Freeday!", JB_TAG, client, target);
					PrintToChat(target, "%sYour freeday has been removed!", JB_TAG);
					gB_Freeday[target] = false;
					gI_Freedays--;
				}
				else 
				{
					PrintToChatAll("%s\x0B%N \x01has unglowed \x09%N!", JB_TAG, client, target);
					PrintToChat(target, "%sYou are glowing the default color!", JB_TAG);
				}
			}		
			case 2:
			{
				SetGlow(target, 255, 0, 0, 255);
				FadePlayer(target, 300, 300, 0x0001, {255, 0, 0, 100});
				PrintToChatAll("%s\x0B%N \x01has glowed \x09%N \x02Red\x01!", JB_TAG, client, target);
				PrintToChat(target, "%sYou are glowing \x02Red\x01!", JB_TAG);
			}
			case 3:
			{
				SetGlow(target, 0, 0, 255, 255);
				FadePlayer(target, 300, 300, 0x0001, {0, 0, 255, 100});
				PrintToChatAll("%s\x0B%N \x01has glowed \x09%N \x0BBlue\x01!", JB_TAG, client, target);
				PrintToChat(target, "%sYou are glowing \x0BBlue\x01!", JB_TAG);
			}
			case 4:
			{				
				SetGlow(target, 0, 255, 0, 255);
				FadePlayer(target, 300, 300, 0x0001, {0, 255, 0, 100});
				PrintToChatAll("%s\x0B%N \x01has glowed \x09%N \x04Green\x01!", JB_TAG, client, target);
				PrintToChat(target, "%sYou are glowing \x04Green\x01!", JB_TAG);
			}
			case 5:
			{				
				SetGlow(target, 255, 0, 255, 255);
				FadePlayer(target, 300, 300, 0x0001, {255, 0, 255, 100});
				PrintToChatAll("%s\x0B%N \x01has glowed \x09%N \x03Purple\x01!", JB_TAG, client, target);
				PrintToChat(target, "%sYou are glowing \x03Purple\x01!", JB_TAG);
			}
			case 6:
			{				
				SetGlow(target, 255, 0, 127, 255);
				FadePlayer(target, 300, 300, 0x0001, {255, 0, 127, 100});
				PrintToChatAll("%s\x0B%N \x01has glowed \x09%N \x0EPink\x01!", JB_TAG, client, target);
				PrintToChat(target, "%sYou are glowing \x0EPink\x01!", JB_TAG);
			}
		}
		gI_ClientStatus[target] = iParam;
	}
	return Plugin_Handled;
}

public Action Cmd_OpenReviveMenu(int client, int args)
{
	if (Checker(client, true, 3, false, false))
		OpenReviveMenu(client, false);
	return Plugin_Handled;
}

public Action Cmd_OpenToolMenu(int client, int args)
{
	if (Checker(client, true, 3, false, false))
		OpenToolsMenu(client);
	return Plugin_Handled;
}

public Action Cmd_Rules(int client, int args)
{
	if (IsValidClient(client))
	{		
		char[] sRules = new char[400];
		FormatEx(sRules, 400, "http://cola-team.com/franug/redirect.php?web=%s&fullsize=1", "https://www.girlgam3rs.com/index.php?page=5");
		ShowMOTDPanel(client, "Jailbreak Rules", sRules, MOTDPANEL_TYPE_URL);
	}
	return Plugin_Handled;
}

public Action Cmd_Ball(int client, int args)
{
	if (Checker(client, true, 3, false, false))
	{		
		if (gB_BallSpawnExists)
		{
			gI_BallHolder = client;
			PrintToChatAll("%s\x0B%N\x01 has acquired the ball!", JB_TAG, client);
		}
		else PrintToChat(client, "%sThere is no ball available!", JB_TAG);
	}
	return Plugin_Handled;
}

public Action Cmd_BallReset(int client, int args)
{
	if (Checker(client, true, 3, false, false))
	{		
		if (gB_BallSpawnExists)
		{
			RespawnBall();
			PrintToChatAll("%s\x0B%N\x01 has reset the ball!", JB_TAG, client);
		}
		else PrintToChat(client, "%sThere is no ball available!", JB_TAG);
	}
	return Plugin_Handled;
}

public Action Cmd_GangMenu(int client, int args)
{
	if (IsValidClient(client))
	{
		if (GetClientTeam(client) != 2)
		{
			PrintToChat(client, "%s You must be a \x09Prisoner \x01to use this!", GANG_TAG);
			return Plugin_Handled;
		}
		StartOpeningGangMenu(client);
	}
	return Plugin_Handled;
}

public Action Cmd_Shop(int client, int iArgs)
{
	if (Checker(client, true, 2))	
		OpenStoreMenu(client);
	return Plugin_Handled;
}

public Action Cmd_GangText(int client, int args)
{
	if (IsValidClient(client))
	{
		if (GetClientTeam(client) != 2)
		{
			PrintToChat(client, "%s You must be a \x09Prisoner \x01to use this!", GANG_TAG);
			return Plugin_Handled;
		}
		else if (!gB_HasGang[client])
		{
			PrintToChat(client, "%s You must be in a Gang to use this!", GANG_TAG);
			return Plugin_Handled;
		}
		
		char[] sText = new char[200];
		GetCmdArgString(sText, 200);
		
		if (sText[0] != '\0')
		{
			char[] sRank = new char[9];
			char[] sColor = new char[4];
			
			switch (gI_Rank[client])
			{
				case GANGRANK_OWNER:
				{
					strcopy(sColor, 4, "\x02");
					strcopy(sRank, 9, "[Boss]");
				}
				case GANGRANK_ADMIN:
				{
					strcopy(sColor, 4, "\x04");
					strcopy(sRank, 9, "[OG]");
				}
				case GANGRANK_NORMAL: 
				{
					strcopy(sColor, 4, "\x0B");
					strcopy(sRank, 9, "[Member]");	
				}
			}
			PrintToGang(client, true, " \x03(%s) %s%s \x09%N\x01: %s", gS_GangName[client], sColor, sRank, client, sText);
			LogMessage("(%s) %s %L: %s", gS_GangName[client], sRank, client, sText);
		}
		else PrintToChat(client, "[SM] Usage: sm_gsay <text>");
	}
	return Plugin_Handled;
}

public Action Cmd_CheckCredits(int client, int iArgs)
{
	if (IsValidClient(client))
		OpenCreditsMenu(client);
	return Plugin_Handled;
}

public Action Cmd_DonateCredits(int client, int args)
{
	if (IsValidClient(client))
	{
		if (args < 2)
		{
			PrintToChat(client, "[SM] Usage: sm_donate <userid|name> <amount>");
			return Plugin_Handled;	
		}
				
		char[] sArg = new char[50];
		GetCmdArg(1, sArg, 50);
		
		char[] target_name = new char[MAX_TARGET_LENGTH];
		int target_list[MAXPLAYERS], target_count;
		bool tn_is_ml;
		
		if ((target_count = ProcessTargetString(sArg, client, target_list, MAXPLAYERS, COMMAND_FILTER_NO_IMMUNITY, target_name, MAX_TARGET_LENGTH, tn_is_ml)) <= 0)
		{
			ReplyToTargetError(client, target_count);
			return Plugin_Handled;
		}
		
		GetCmdArg(2, sArg, 50);
		
		int iAmount = StringToInt(sArg);
				
		if (iAmount < 1)
		{
			PrintToChat(client, "[SM] Must be a valid amount!");
			return Plugin_Handled;	
		}
		else if (iAmount > gI_Credits[client] || gI_Credits[client] < target_count * iAmount)
		{
			PrintToChat(client, "[SM] Insufficient funds!", GANG_TAG);
			return Plugin_Handled;	
		}
		
		float fFee = iAmount * CREDITS_TRANSFER_FEE;
		
		bool bAdmin = false;
		
		if (CheckCommandAccess(client, "sm_kick", ADMFLAG_GENERIC))
		{
			fFee /= 2;
			bAdmin = true;
		}
		
		int iFee = RoundToCeil(fFee);
		
		for (int i = 0; i < target_count; ++i)
		{
			if (target_list[i] != client)
			{
				gI_Credits[client] -= iAmount;
				gI_Credits[target_list[i]] += iAmount - iFee;
			}
		}
								
		if (tn_is_ml)
		{
			ShowActivity2(client, "[SM] ", "donated \x04%i\x01 Credits to %t. (%s Fee: \x07%i\x01)", iAmount, target_name, (bAdmin)? "VIP":"Transfer", iFee);
			LogMessage("%L transfered %i credits to %t. (%s Fee: %i)", client, iAmount, target_name, (bAdmin)? "VIP":"Transfer", iFee);
		}
		else
		{
			ShowActivity2(client, "[SM] ", "donated \x04%i\x01 Credits to %s. (%s Fee: \x07%i\x01)", iAmount, target_name, (bAdmin)? "VIP":"Transfer", iFee);		
			LogMessage("%L transfered %i credits to %s. (%s Fee: %i)", client, iAmount, target_name, (bAdmin)? "VIP":"Transfer", iFee);
		}	
	}
	return Plugin_Handled;
}

public Action Cmd_Bounty(int client, int args)
{
	if (IsValidClient(client))
		OpenBountyMenu(client);
	return Plugin_Handled;
}

public Action Cmd_Stats(int client, int args)
{
	if (IsValidClient(client))
		OpenSettingsMenu(client);
	return Plugin_Handled;
}

public Action Cmd_Casino(int client, int args)
{
	if (IsValidClient(client))
	{
		switch (gI_GameMode[client])
		{
			case 0:
			{
				if (gI_ClientCards[client] < 21 && gI_ClientCards[client] > 0)
				{
					OpenBlackJack(client);	
					return Plugin_Handled;
				}
			}
			case 1:
			{
				if (gI_Dealer[client] > 0 && gI_DealerCard[client] > 0)
				{
					OpenRedDog(client);	
					return Plugin_Handled;
				}
			}
		}
		
		ResetCasino(client);
		OpenCasinoMenu(client);
	}
	return Plugin_Handled;	
}


/*===============================================================================================================================*/
/********************************************************* [ADMIN CMDS] **********************************************************/
/*===============================================================================================================================*/


public Action Cmd_AddGuardBan(int client, int args)
{
	if (IsValidClient(client))
	{
		if (args < 1)
		{
			ReplyToCommand(client, "[SM] Usage: sm_addguardban <steamid>");
			return Plugin_Handled;
		}
		
		char[] sFormat = new char[MAX_NAME_LENGTH];
		GetCmdArgString(sFormat, MAX_NAME_LENGTH);
		
		if (StrContains(sFormat, "STEAM_") == -1 || strlen(sFormat) < 12 || strlen(sFormat) > 22)
		{
			ReplyToCommand(client, "[SM] Steam ID is invalid!");
			return Plugin_Handled;
		}
		else if (CheckSteamId(sFormat))
		{
			ReplyToCommand(client, "[SM] This Steam ID is already banned!");
			return Plugin_Handled;	
		}
		
		PrintToChatAll("[SM] \x04%N \x01has Guard Banned \x07%s", client, sFormat);
		UpdateBans(0, -2, client, sFormat);
		LogAction(client, -1, "%L Added %s to the Guardbanned list!", client, sFormat);
	}		
	return Plugin_Handled;
}

public Action Cmd_GuardBan(int client, int args)
{	
	if (IsValidClient(client))
	{
		if (args < 2)
		{
			ReplyToCommand(client, "[SM] Usage: sm_guardban <userid|name> <time>");
			return Plugin_Handled;
		}
		
		char[] sFormat = new char[PLATFORM_MAX_PATH];
		GetCmdArg(1, sFormat, PLATFORM_MAX_PATH);
		int target = FindTarget(client, sFormat, true, true);
		
		if (IsValidClient(target))
		{
			if (gI_ClientBan[target] != -1)
			{
				PrintToChat(client, "[SM] This player is already banned!");
				return Plugin_Handled;
			}
			
			GetCmdArg(2, sFormat, PLATFORM_MAX_PATH);
			int Time = StringToInt(sFormat);
			
			if (Time < 0)
			{
				PrintToChat(client, "[SM] You must choose a number that is \x040 \x01or Higher!");
				return Plugin_Handled;
			}
			else if (Time == 0)
			{
				PrintToChatAll("[SM] \x04%N \x01has banned \x07%N \x01permanently from joining Guards team!", client, target);
				gI_ClientBan[target] = -2;
				UpdateBans(target, gI_ClientBan[target], client);
				LogAction(client, -1, "%L Guard banned %L permanently!", client, target);
				
				if (GetClientTeam(target) == 3)
					ChangeClientTeam(target, 2);	
				return Plugin_Handled;
			}
			
			SecondsToTime(Time, sFormat);
			PrintToChatAll("[SM] \x04%N \x01has banned \x07%N \x01from joining Guards team for \x04%s", client, target, sFormat);
			gI_ClientBan[target] = GetTime() + Time;
			UpdateBans(target, gI_ClientBan[target], client);
			LogAction(client, -1, "%L Guardbanned %L for %s!", client, target, sFormat);
			
			if (GetClientTeam(target) == 3)
				ChangeClientTeam(target, 2);	
		}
	}
	return Plugin_Handled;
}

public Action Cmd_RemoveGuardBan(int client, int args)
{
	if (IsValidClient(client))
	{
		if (args < 1)
		{
			ReplyToCommand(client, "[SM] Usage: sm_removeguardban <steamid>");
			return Plugin_Handled;
		}
		
		char[] sFormat = new char[MAX_NAME_LENGTH];
		GetCmdArgString(sFormat, MAX_NAME_LENGTH);
		
		if (StrContains(sFormat, "STEAM_") == -1)
		{
			ReplyToCommand(client, "[SM] Steam ID is invalid!");
			return Plugin_Handled;
		}
		else if (!CheckSteamId(sFormat))
		{
			ReplyToCommand(client, "[SM] This Steam ID is not banned!");
			return Plugin_Handled;	
		}
		
		RemoveGuardBan(1337, sFormat);
		PrintToChatAll("%s\x03%N\x01 has unbanned \x07%s\x01!", JB_TAG, client, sFormat);
		LogAction(client, -1, "%L Removed %s from the guardban list!", client, sFormat);
	}		
	return Plugin_Handled;
}

public Action Cmd_UnGuardBan(int client, int args)
{
	if (IsValidClient(client))
	{
		if (args < 1)
		{
			ReplyToCommand(client, "[SM] Usage: sm_unguardban <userid|name>");
			return Plugin_Handled;
		}
		
		char[] sTargetName = new char[MAX_NAME_LENGTH];
		GetCmdArg(1, sTargetName, MAX_NAME_LENGTH);
		
		int target = FindTarget(client, sTargetName, true, true);
		
		if (IsValidClient(target))
		{
			if (gI_ClientBan[target] == -1)
			{
				PrintToChat(client, "[SM] This player is not banned!");
				return Plugin_Handled;
			}
			
			gI_ClientBan[target] = -1;
			RemoveGuardBan(target);
			PrintToChatAll("[SM] \x04%N \x01have unbanned \x07%N \x01from the Guard Team!", client, target);
			LogAction(client, -1, "%L Unguard banned %L!", client, target);
		}
	}
	return Plugin_Handled;
}

public Action Cmd_Respawn(int client, int args)
{
	if (IsValidClient(client))
	{
		if (args < 1)
		{
			ReplyToCommand(client, "[SM] Usage: sm_revive <userid|name>");
			return Plugin_Handled;
		}
	
		char[] sArg = new char[MAX_NAME_LENGTH];
		GetCmdArg(1, sArg, MAX_NAME_LENGTH);
		
		char[] target_name = new char[MAX_TARGET_LENGTH];
		int target_list[MAXPLAYERS], target_count;
		bool tn_is_ml;
		
		if ((target_count = ProcessTargetString(sArg, client, target_list, MAXPLAYERS, COMMAND_FILTER_CONNECTED, target_name, MAX_TARGET_LENGTH, tn_is_ml)) <= 0)
		{
			ReplyToTargetError(client, target_count);
			return Plugin_Handled;
		}
		
		for (int i = 0; i < target_count; ++i)
			CS_RespawnPlayer(target_list[i]);
										
		if (tn_is_ml)
		{
			ShowActivity2(client, "[SM] ", "Revived %t!", target_name);
			LogAction(client, -1, "%L Revived %t!", client, target_name);
		}
		else
		{
			ShowActivity2(client, "[SM] ", "Revived %s!", target_name);
			LogAction(client, -1, "%L Revived %s!", client, target_name);
		}
	}
	return Plugin_Handled;
}

public Action Cmd_Transfer(int client, int args)
{
	if (IsValidClient(client))
	{
		if (args < 2)
		{
			ReplyToCommand(client, "[SM] Usage: sm_transfer <userid|name> [\x0Bg\x01/\x09p\x01/\x03s\x01]");
			return Plugin_Handled;
		}
		
		char[] sArg1 = new char[MAX_NAME_LENGTH];
		char[] sArg2 = new char[10];
		
		GetCmdArg(1, sArg1, MAX_NAME_LENGTH);
		GetCmdArg(2, sArg2, 10);
		
		int target = FindTarget(client, sArg1, true, true);
		
		if (IsValidClient(target))
		{
			int iTeam = GetClientTeam(target);
			
			if (sArg2[0] == 'g')
			{
				if (iTeam == 3)
				{
					ReplyToCommand(client, "[SM] \x0B%N \x01is already a \x0BGuard\x01!", target);
					return Plugin_Handled;
				}
				
				ChangeClientTeam(target, 3);
				ShowActivity2(client, "[SM] ", "transfered %s%N\x01 to \x0BGuard\x01!", (iTeam == 2)? "\x09":"\x03", target);
				LogAction(client, -1, "%L has transfered %L to Guard!", client, target);
			}
			else if (sArg2[0] == 'p')
			{
				if (iTeam == 2)
				{
					ReplyToCommand(client, "[SM] \x09%N \x01is already a \x09Prisoner\x01!", target);
					return Plugin_Handled;
				}
				
				ChangeClientTeam(target, 2);
				ShowActivity2(client, "[SM] ", "transfered %s%N\x01 to \x09Prisoner\x01!", (iTeam == 3)? "\x0B":"\x03", target);
				LogAction(client, -1, "%L has transfered %L to Prisoner!", client, target);
			}
			else if (sArg2[0] == 's')
			{
				if (iTeam == 1)
				{
					ReplyToCommand(client, "[SM] \x04%N\x01 is already a \x03Spectator\x01!", target);
					return Plugin_Handled;
				}
				
				ChangeClientTeam(target, 1);
				ShowActivity2(client, "[SM] ", "transfered %s%N\x01 to \x03Spectator\x01!", (iTeam == 2)? "\x09":"\x0B", target);
				LogAction(client, -1, "%L has transfered %L to Spectator!", client, target);
			}
			else ReplyToCommand(client, "[SM] Invalid Team Prefix! [\x0Bg\x01/\x09p\x01/\x03s\x01]");
		}
	}
	return Plugin_Handled;
}

public Action Cmd_EndRound(int client, int args)
{
	if (IsValidClient(client))
	{
		CS_TerminateRound(5.0, CSRoundEnd_Draw, true);
		ShowActivity2(client, "[SM] ", "terminated the round!");
		LogAction(client, -1, "%L has terminated the round!", client);
	}
	return Plugin_Handled;
}

public Action Cmd_Stack(int client, int args)
{
	if (IsValidClient(client))
	{
		if (args < 2)
		{
			ReplyToCommand(client, "[SM] Usage: sm_stack <userid|name> <userid|name>");
			return Plugin_Handled;
		}
		
		char[] sArg = new char[MAX_NAME_LENGTH];
		GetCmdArg(1, sArg, MAX_NAME_LENGTH);
		
		int target = FindTarget(client, sArg, true, true);
		
		if (IsValidClient(target))
		{
			if (!IsPlayerAlive(target))
			{
				ReplyToCommand(client, "[SM] The first player isn't alive.");
				return Plugin_Handled;	
			}
			
			GetCmdArg(2, sArg, MAX_NAME_LENGTH);
			
			int target2 = FindTarget(client, sArg, true, false);
			
			if (IsValidClient(target2))
			{
				if (!IsPlayerAlive(target))
				{
					ReplyToCommand(client, "[SM] The second player isn't alive.");
					return Plugin_Handled;	
				}
				else if (target == target2)
				{
					ReplyToCommand(client, "[SM] You cannot stack the same person.");
					return Plugin_Handled;	
				}
				
				float fPos[3]; 
				GetClientAbsOrigin(target2, fPos);
				fPos[2] += 77.0;
				TeleportEntity(target, fPos, NULL_VECTOR, NULL_VECTOR); 
				ShowActivity2(client, "[SM] ", "stacked %s%N\x01 on top of %s%N", (GetClientTeam(target) == 2)? "\x09":"\x0B", target, (GetClientTeam(target2) == 2)? "\x09":"\x0B", target2);
				LogAction(client, -1, "%L stacked %L ontop of %L!", client, target, target2);
			}
			else ReplyToCommand(client, "[SM] The second player isn't valid.");
		}
		else ReplyToCommand(client, "[SM] The first player isn't valid.");
	}
	return Plugin_Handled;
}

public Action Cmd_Bury(int client, int args)
{
	if (IsValidClient(client))
	{
		if (args < 1)
		{
			ReplyToCommand(client, "[SM] Usage: sm_bury <userid|name>");
			return Plugin_Handled;
		}
	
		char[] sArg = new char[MAX_NAME_LENGTH];
		GetCmdArg(1, sArg, MAX_NAME_LENGTH);
		
		char[] target_name = new char[MAX_TARGET_LENGTH];
		int target_list[MAXPLAYERS], target_count;
		bool tn_is_ml;
		
		if ((target_count = ProcessTargetString(sArg, client, target_list, MAXPLAYERS, COMMAND_FILTER_CONNECTED|COMMAND_FILTER_ALIVE, target_name, MAX_TARGET_LENGTH, tn_is_ml)) <= 0)
		{
			ReplyToTargetError(client, target_count);
			return Plugin_Handled;
		}
		
		float fOrigin[3];
		
		for (int i = 0; i < target_count; ++i)
		{
			GetClientAbsOrigin(target_list[i], fOrigin);
			fOrigin[2] -= 40;
			TeleportEntity(target_list[i], fOrigin, NULL_VECTOR, NULL_VECTOR);			
		}
										
		if (tn_is_ml)
		{
			ShowActivity2(client, "[SM] ", "Buried %t!", target_name);
			LogAction(client, -1, "%L Buried %t!", client, target_name);
		}
		else
		{
			ShowActivity2(client, "[SM] ", "Buried %s!", target_name);
			LogAction(client, -1, "%L Buried %s!", client, target_name);
		}
	}
	return Plugin_Handled;
}

public Action Cmd_UnBury(int client, int args)
{
	if (IsValidClient(client))
	{
		if (args < 1)
		{
			ReplyToCommand(client, "[SM] Usage: sm_unbury <userid|name>");
			return Plugin_Handled;
		}
	
		char[] sArg = new char[MAX_NAME_LENGTH];
		GetCmdArg(1, sArg, MAX_NAME_LENGTH);
		
		char[] target_name = new char[MAX_TARGET_LENGTH];
		int target_list[MAXPLAYERS], target_count;
		bool tn_is_ml;
		
		if ((target_count = ProcessTargetString(sArg, client, target_list, MAXPLAYERS, COMMAND_FILTER_CONNECTED|COMMAND_FILTER_ALIVE, target_name, MAX_TARGET_LENGTH, tn_is_ml)) <= 0)
		{
			ReplyToTargetError(client, target_count);
			return Plugin_Handled;
		}
		
		float fOrigin[3];
		
		for (int i = 0; i < target_count; ++i)
		{
			GetClientAbsOrigin(target_list[i], fOrigin);
			fOrigin[2] += 40;
			TeleportEntity(target_list[i], fOrigin, NULL_VECTOR, NULL_VECTOR);			
		}
										
		if (tn_is_ml)
		{
			ShowActivity2(client, "[SM] ", "Unburied %t!", target_name);
			LogAction(client, -1, "%L Unburied %t!", client, target_name);	
		}
		else
		{
			ShowActivity2(client, "[SM] ", "Unburied %s!", target_name);
			LogAction(client, -1, "%L Unburied %s!", client, target_name);	
		}
	}
	return Plugin_Handled;
}

public Action Cmd_Weapons(int client, int args)
{
	if (IsValidClient(client))
	{
		if (args < 1)
		{
			ReplyToCommand(client, "[SM] Usage: sm_weapon <userid|name> [weapon]");
			return Plugin_Handled;
		}
	
		char[] sArg = new char[MAX_NAME_LENGTH];
		GetCmdArg(1, sArg, MAX_NAME_LENGTH);
		
		char[] target_name = new char[MAX_TARGET_LENGTH];
		int target_list[MAXPLAYERS], target_count;
		bool tn_is_ml;
		
		if ((target_count = ProcessTargetString(sArg, client, target_list, MAXPLAYERS, COMMAND_FILTER_CONNECTED|COMMAND_FILTER_ALIVE, target_name, MAX_TARGET_LENGTH, tn_is_ml)) <= 0)
		{
			ReplyToTargetError(client, target_count);
			return Plugin_Handled;
		}
		
		char[] sBuffer = new char[32];
		GetCmdArg(2, sArg, MAX_NAME_LENGTH);
		
		if (StrContains(sArg, "weapon_", false) != -1)
		{
			strcopy(sBuffer, 32, sArg);
			BreakString(sArg[7], sArg, 32);
		}
		else FormatEx(sBuffer, 32, "weapon_%s", sArg);
		
		char sWeapons[][] = 
		{
			"weapon_ak47", "weapon_aug", "weapon_bizon", "weapon_deagle", "weapon_decoy", "weapon_elite", "weapon_famas", "weapon_fiveseven", "weapon_flashbang",
			"weapon_g3sg1", "weapon_galilar", "weapon_glock", "weapon_hegrenade", "weapon_hkp2000", "weapon_incgrenade", "weapon_knife", "weapon_m249", "weapon_m4a1",
			"weapon_mac10", "weapon_mag7", "weapon_molotov", "weapon_mp7", "weapon_mp9", "weapon_negev", "weapon_nova", "weapon_p250", "weapon_p90", "weapon_sawedoff",
			"weapon_scar20", "weapon_sg556", "weapon_smokegrenade", "weapon_ssg08", "weapon_taser", "weapon_tec9", "weapon_ump45", "weapon_xm1014", "weapon_tagrenade", "weapon_healthshot"
		};
		
		bool bValid = false;
		
		for (int i = 0; i < sizeof(sWeapons); ++i)
		{
			if (StrEqual(sWeapons[i], sBuffer))
			{
				bValid = true;
				break;		
			}
		}
		
		if (!bValid)
		{
			ReplyToCommand(client, "[SM] The weapon isn't valid.");
			return Plugin_Handled;
		}
		
		for (int i = 0; i < target_count; ++i)
			GivePlayerItem(target_list[i], sBuffer);			
										
		if (tn_is_ml)
		{
			ShowActivity2(client, "[SM] ", "gave %t \x04%s", target_name, sArg);
			LogAction(client, -1, "%L gave %t %s", client, target_name, sBuffer);	
		}
		else
		{
			ShowActivity2(client, "[SM] ", "gave %s \x04%s", target_name, sArg);
			LogAction(client, -1, "%L gave %s %s", client, target_name, sBuffer);	
		}
	}
	return Plugin_Handled;
}

public Action Cmd_Health(int client, int args)
{
	if (IsValidClient(client))
	{
		if (args < 1)
		{
			ReplyToCommand(client, "[SM] Usage: sm_hp <userid|name> <amount>");
			return Plugin_Handled;
		}
	
		char[] sArg = new char[MAX_NAME_LENGTH];
		GetCmdArg(1, sArg, MAX_NAME_LENGTH);
		
		char[] target_name = new char[MAX_TARGET_LENGTH];
		int target_list[MAXPLAYERS], target_count;
		bool tn_is_ml;
		
		if ((target_count = ProcessTargetString(sArg, client, target_list, MAXPLAYERS, COMMAND_FILTER_CONNECTED|COMMAND_FILTER_ALIVE, target_name, MAX_TARGET_LENGTH, tn_is_ml)) <= 0)
		{
			ReplyToTargetError(client, target_count);
			return Plugin_Handled;
		}
		
		GetCmdArg(2, sArg, MAX_NAME_LENGTH);
		int iAmount = StringToInt(sArg);
		
		if (iAmount <= 0)
		{
			ReplyToCommand(client, "[SM] Invalid health amount!");
			return Plugin_Handled;	
		}
		
		for (int i = 0; i < target_count; ++i)
			SetEntityHealth(target_list[i], iAmount);			
		
		if (tn_is_ml)
		{
			ShowActivity2(client, "[SM] ", "set %t to \x04%i\x01 health!", target_name, iAmount);
			LogAction(client, -1, "%L set %t to %i health!", client, target_name, iAmount);	
		}
		else
		{
			ShowActivity2(client, "[SM] ", "set %s to \x04%i\x01 health!", target_name, iAmount);
			LogAction(client, -1, "%L set %s to %i health!", client, target_name, iAmount);
		}
	}
	return Plugin_Handled;
}

public Action Cmd_Exec(int client, int args)
{
	if (IsValidClient(client))
	{
		if (args < 1)
		{
			ReplyToCommand(client, "[SM] Usage: sm_exec <userid|name> <command>");
			return Plugin_Handled;
		}
	
		char[] sArg = new char[MAX_NAME_LENGTH];
		GetCmdArg(1, sArg, MAX_NAME_LENGTH);
		
		char[] target_name = new char[MAX_TARGET_LENGTH];
		int target_list[MAXPLAYERS], target_count;
		bool tn_is_ml;
		
		if ((target_count = ProcessTargetString(sArg, client, target_list, MAXPLAYERS, COMMAND_FILTER_CONNECTED|COMMAND_FILTER_ALIVE, target_name, MAX_TARGET_LENGTH, tn_is_ml)) <= 0)
		{
			ReplyToTargetError(client, target_count);
			return Plugin_Handled;
		}
		
		char[] sFormat = new char[256];
		GetCmdArgString(sFormat, 256);
		int iStart = BreakString(sFormat, sArg, 256);
		
		for (int i = 0; i < target_count; ++i)
			FakeClientCommandEx(target_list[i], sFormat[iStart]);			
										
		if (tn_is_ml)
		{
			ShowActivity2(client, "[SM] ", "excuted \x04%s\x01 on %t", sFormat[iStart], target_name);
			LogAction(client, -1, "%L excuted '%s' on %t", client, sFormat[iStart], target_name);	
		}
		else
		{
			ShowActivity2(client, "[SM] ", "excuted \x04%s\x01 on %s", sFormat[iStart], target_name);
			LogAction(client, -1, "%L excuted '%s' on %s", client, sFormat[iStart], target_name);
		}
	}
	return Plugin_Handled;
}

public Action Cmd_JailbreakMenu(int client, int args)
{
	if (IsValidClient(client))
	{
		if (IsPlayerAlive(client))		
		{
			if (gI_Owner != -1 && gI_Owner != client || gI_GoalZoneCreator != -1 && gI_GoalZoneCreator != client)
			{
				PrintToChat(client, "[SM] Only one person can access this menu at a time!");
				return Plugin_Handled;
			}
			
			gI_Owner = client;
			JailbreakMenu(client);
		}
		else PrintToChat(client, "[SM] You must be alive to access the menu!");
	}
	return Plugin_Handled;
}

public Action Cmd_SpawnCredits(int client, int args)
{
	if (IsValidClient(client))
	{
		if (args < 2)
		{
			PrintToChat(client, "[SM] Usage: sm_spawncredits <userid|name> <amount>");
			return Plugin_Handled;	
		}
				
		char[] sArg = new char[MAX_NAME_LENGTH];
		GetCmdArg(1, sArg, MAX_NAME_LENGTH);
		
		char[] target_name = new char[MAX_TARGET_LENGTH];
		int target_list[MAXPLAYERS], target_count;
		bool tn_is_ml;
		
		if ((target_count = ProcessTargetString(sArg, client, target_list, MAXPLAYERS, COMMAND_FILTER_CONNECTED, target_name, MAX_TARGET_LENGTH, tn_is_ml)) <= 0)
		{
			ReplyToTargetError(client, target_count);
			return Plugin_Handled;
		}
		
		GetCmdArg(2, sArg, MAX_NAME_LENGTH);
		
		int iAmount = StringToInt(sArg);
		
		bool bNegative = (iAmount < 0);
		
		if (bNegative)
			iAmount *= -1;
		
		for (int i = 0; i < target_count; ++i)
		{
			if (bNegative)
				gI_Credits[target_list[i]] -= iAmount;
			else if (iAmount == 0)
				gI_Credits[target_list[i]] = 0;
			else
				gI_Credits[target_list[i]] += iAmount;
		}
					
		if (tn_is_ml)
		{
			if (iAmount == 0)
			{
				ShowActivity2(client, "[SM] ", "has reset %t credits!", target_name);
				LogMessage("%L has reset %t credits!", client, target_name);
			}
			else
			{
				ShowActivity2(client, "[SM] ", "%s \x04%i\x01 Credits %s %t!", (bNegative)? "removed":"gave", iAmount, (bNegative)? "from":"to", target_name);
				LogMessage("%L %s %i Credits %s %t!", client, (bNegative)? "removed":"gave", iAmount, (bNegative)? "from":"to", target_name);
			}
		}
		else
		{
			if (iAmount == 0)
			{
				ShowActivity2(client, "[SM] ", "has reset %s's credits!", target_name);
				LogMessage("%L has reset %s's credits!", client, target_name);
			}
			else
			{
				ShowActivity2(client, "[SM] ", "%s \x04%i\x01 Credits %s %s!", (bNegative)? "removed":"gave", iAmount, (bNegative)? "from":"to", target_name);
				LogMessage("%L %s %i Credits %s %s!", client, (bNegative)? "removed":"gave", iAmount, (bNegative)? "from":"to", target_name);
			}
		}			
	}
	return Plugin_Handled;
}


/*===============================================================================================================================*/
/********************************************************* [LISTENERS] ***********************************************************/
/*===============================================================================================================================*/


public Action CL_JoinTeam(int client, char[] sCommand, int args)  
{	
	if (IsValidClient(client))
	{
		char[] sJoining = new char[5];
		GetCmdArg(1, sJoining, 5);
		
		int iTeam = StringToInt(sJoining);
		
		if (GetClientTeam(client) == iTeam)
			return Plugin_Handled;
		
		switch (iTeam)
		{
			case 3:
			{				
				switch (gI_ClientBan[client])
				{
					case -1: {}
					case -2: 
					{
						PrintToChat(client, "[SM] You are banned from joining the \x0BGuard's\x01 Team!");
						PrintToChat(client, "[SM] [Time left: \x02Forever\x01]");
						ClientCommand(client, "play buttons/button11.wav");
						return Plugin_Handled;
					}	
					default: 
					{
						char[] sBuffer = new char[70];
						int iTimeLeft = gI_ClientBan[client];
						int iBan = iTimeLeft - GetTime();
						
						if (iBan < 1)
						{
							RemoveGuardBan(client);
							PrintToChat(client, "[SM] You are now unbanned! Becareful not to try to break the rules!");
							return Plugin_Continue;
						}
						
						SecondsToTime(iBan, sBuffer);
						PrintToChat(client, "[SM] You are banned from joining the \x0BGuard's\x01 Team!");
						PrintToChat(client, "[SM] [Time left: \x04%s\x01]", sBuffer);
						ClientCommand(client, "play buttons/button11.wav");
						return Plugin_Handled;
					}
				}
				
				CheckRatio();
				
				if (gB_Ratio)
				{
					PrintToChat(client, "%sYou cannot become a \x0BGuard\x01 due to Ratio!", JB_TAG);
					ClientCommand(client, "play buttons/button11.wav");
					return Plugin_Handled;
				}
				else 
				{
					SecurityCheck(client);
					return Plugin_Handled;
				}
			}
			case 1, 2:
			{
				if (client == gI_Warden)
				{
					gI_Warden = -1;
					CS_SetClientClanTag(client, "");
					CreateTimer(0.1, Timer_NewWarden, INVALID_HANDLE);
				}
				
				if (IsPlayerAlive(client))
					ForcePlayerSuicide(client);
					
				ChangeClientTeam(client, iTeam);
				return Plugin_Handled;
			}
		}
	}
	return Plugin_Continue;
}

public Action CL_Block(int client, char[] sCommand, int args)  {
	return Plugin_Handled;
}


/*===============================================================================================================================*/
/********************************************************* [ADMIN-MENU] **********************************************************/
/*===============================================================================================================================*/


public void OnAdminMenuReady(Handle hMenu)
{
	TopMenu hTopMenu = TopMenu.FromHandle(hMenu);

	if (hTopMenu != gT_TopMenu)
	{
		gT_TopMenu = hTopMenu;
		
		TopMenuObject hCommands = gT_TopMenu.AddCategory("Jailbreak Commands", CategoryHandler);
		
		if (hCommands != INVALID_TOPMENUOBJECT)
		{
			gT_TopMenu.AddItem("sm_guardban", AdminMenu_Guardbans, hCommands, "sm_ban", ADMFLAG_BAN);
			gT_TopMenu.AddItem("sm_unguardban", AdminMenu_UnGuardbans, hCommands, "sm_unban", ADMFLAG_UNBAN);
			gT_TopMenu.AddItem("sm_jbmenu", AdminMenu_Jailbreak, hCommands, "sm_rcon", ADMFLAG_ROOT);
		}
	}
}

public void CategoryHandler(TopMenu hTopMenu, TopMenuAction hAction, TopMenuObject hObject, int client, char[] sBuffer, int iMaxlength)
{
	switch (hAction)
	{
		case TopMenuAction_DisplayTitle: strcopy(sBuffer, iMaxlength, "Jailbreak Commands:");
		case TopMenuAction_DisplayOption: strcopy(sBuffer, iMaxlength, "Jailbreak Commands");
	}
}

public int AdminMenu_Jailbreak(TopMenu hTopMenu, TopMenuAction hAction, TopMenuObject hObject, int client, char[] sBuffer, int iMaxlength)
{
	switch (hAction)
	{
		case TopMenuAction_DisplayOption: strcopy(sBuffer, iMaxlength, "Jailbreak Menu");
		case TopMenuAction_SelectOption: JailbreakMenu(client, true);
	}
}

public int AdminMenu_Guardbans(TopMenu hTopMenu, TopMenuAction hAction, TopMenuObject hObject, int client, char[] sBuffer, int iMaxlength)
{
	switch (hAction)
	{
		case TopMenuAction_DisplayOption: strcopy(sBuffer, iMaxlength, "Guardban Menu");
		case TopMenuAction_SelectOption: GuardBansMenu(client);
	}
}

public int AdminMenu_UnGuardbans(TopMenu hTopMenu, TopMenuAction hAction, TopMenuObject hObject, int client, char[] sBuffer, int iMaxlength)
{
	switch (hAction)
	{
		case TopMenuAction_DisplayOption: strcopy(sBuffer, iMaxlength, "Unguardban Menu");
		case TopMenuAction_SelectOption: UnGuardBansMenu(client);
	}
}


/*===============================================================================================================================*/
/********************************************************* [MENUS] ***************************************************************/
/*===============================================================================================================================*/


void LastRequestMenu(int client, int iHealth)
{
	Menu hMenu = new Menu(Menu_LastRequest);
	hMenu.SetTitle("[Jailbreak] Lastrequest Menu\n ");
	
	switch (iHealth)
	{
		case 0: hMenu.AddItem("1", "Health: [35] 100 250 500\n ");
		case 1: hMenu.AddItem("2", "Health: 35 [100] 250 500\n ");
		case 2: hMenu.AddItem("3", "Health: 35 100 [250] 500\n ");
		case 3: hMenu.AddItem("0", "Health: 35 100 250 [500]\n ");
	}
	
	char[] sHP = new char[5];
	IntToString(iHealth, sHP, 5);
	
	hMenu.AddItem(sHP, "Knife Fight");
	hMenu.AddItem(sHP, "Shot 4 Shot");
	hMenu.AddItem(sHP, "Nade War");
	hMenu.AddItem(sHP, "No Scope Battle");
	hMenu.AddItem(sHP, "Shotgun Battle");
	hMenu.AddItem(sHP, "Gun Toss");
	hMenu.AddItem(sHP, "Race");
	hMenu.AddItem(sHP, "Headshot Only");
	hMenu.AddItem(sHP, "Key Combo");
	hMenu.AddItem(sHP, "Typing Contest");
	hMenu.AddItem(sHP, "Rebel");
	hMenu.ExitButton = false;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_LastRequest(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			int iGuards, iPrisoners;
			
			for (int i = 1; i <= MaxClients; ++i)
			{
				if (IsClientInGame(i) && IsPlayerAlive(i))
				{
					switch (GetClientTeam(i))
					{
						case 2: ++iPrisoners;
						case 3: ++iGuards;						
					}
				}
			}
			
			if (IsValidClient(client) && IsPlayerAlive(client) && iGuards > 0 && iPrisoners == 1)
			{
				char[] sInfo = new char[5];
				hMenu.GetItem(iParam, sInfo, 5);
				
				if (iParam == 0)
				{
					LastRequestMenu(client, StringToInt(sInfo));
					return;
				}
				
				gI_LRHealth[client] = StringToInt(sInfo);
				
				gH_LastRequest = view_as<LastRequest>(iParam - 1);
				
				switch (gH_LastRequest)
				{
					case LASTREQUEST_KNIFE, LASTREQUEST_GUNTOSS, LASTREQUEST_NADE, LASTREQUEST_SHOTGUN, LASTREQUEST_HEADSHOT, LASTREQUEST_KEYS, LASTREQUEST_TYPING, LASTREQUEST_RACE: SelectGuardMenu(client);
					case LASTREQUEST_NOSCOPE: NoScopeMenu(client);
					case LASTREQUEST_SHOT4SHOT: Shot4ShotMenu(client);
					case LASTREQUEST_REBEL:
					{
						if (iGuards >= REBELMINPLAYERS)
						{
							PrintToChat(client, "%sOnce you rebel there is no going back!", JB_TAG);
							RebelMenu(client);
						}
						else 
						{
							PrintToChat(client, "%sThere must be at least \x04%i \x0BGuards\x01 alive!", JB_TAG, REBELMINPLAYERS);
							LastRequestMenu(client, gI_LRHealth[client]);
						}
					}
				}
			}
		}
		case MenuAction_End: delete hMenu;
	}
}

void NoScopeMenu(int client)
{
	Menu hMenu = new Menu(Menu_NoScope);
	hMenu.SetTitle("[Jailbreak] No Scope Menu\n ");
	hMenu.AddItem("", "Awp");
	hMenu.AddItem("", "Scout");
	hMenu.AddItem("", "SCAR20 (Auto)");
	hMenu.AddItem("", "G3SG1 (Auto)");
	hMenu.ExitBackButton = true;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_NoScope(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client) && IsPlayerAlive(client) && GetPlayerAliveCount(2) == 1)
			{
				gI_LastRequestWeapon = iParam;
				SelectGuardMenu(client);
			}
		}	
		case MenuAction_Cancel: 
		{
			if (IsValidClient(client) && IsPlayerAlive(client) && GetPlayerAliveCount(2) == 1)
			{
				gI_LastRequestWeapon = -1;
				gH_LastRequest = LASTREQUEST_INVALID;
				LastRequestMenu(client, gI_LRHealth[client]);
			}
		}
		case MenuAction_End: delete hMenu;
	}
}

void Shot4ShotMenu(int client)
{
	Menu hMenu = new Menu(Menu_Shot4Shot);
	hMenu.SetTitle("[Jailbreak] Shot 4 Shot Menu\n ");
	hMenu.AddItem("", "Deagle");
	hMenu.AddItem("", "Ak-47");
	hMenu.AddItem("", "M4A4");
	hMenu.AddItem("", "SSG08 (Scout)");
	hMenu.AddItem("", "Negev");
	hMenu.AddItem("", "Mag-7");
	hMenu.ExitBackButton = true;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_Shot4Shot(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client) && IsPlayerAlive(client) && GetPlayerAliveCount(2) == 1)
			{
				gI_LastRequestWeapon = iParam;
				SelectGuardMenu(client);
			}
		}
		case MenuAction_Cancel: 
		{
			if (IsValidClient(client) && IsPlayerAlive(client) && GetPlayerAliveCount(2) == 1)
			{
				gI_LastRequestWeapon = -1;
				gH_LastRequest = LASTREQUEST_INVALID;
				LastRequestMenu(client, gI_LRHealth[client]);
			}
		}
		case MenuAction_End: delete hMenu;
	}
}

void RebelMenu(int client)
{
	int iPrisoners = GetTeamClientCount(2);
	
	Menu hMenu = new Menu(Menu_Rebel);
	hMenu.SetTitle("[Jailbreak] Rebel Menu\n ");
	hMenu.AddItem("", "Rambo");
	hMenu.AddItem("", "Suicide Bomber");
	hMenu.AddItem("", "Deagle Dude");
	hMenu.AddItem("", "Crazy Dude");
	hMenu.AddItem("", "Freeday Next Round", (iPrisoners >= 3)? ITEMDRAW_DEFAULT:ITEMDRAW_DISABLED);
	hMenu.AddItem("", "Special Day", (iPrisoners >= 3)? ITEMDRAW_DEFAULT:ITEMDRAW_DISABLED);
	hMenu.ExitBackButton = true;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_Rebel(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			int iPrisoners, iGuards, iPlayer;
			
			ArrayList aArray = new ArrayList(66);
			
			for (int i = 1; i <= MaxClients; ++i)
			{
				if (IsClientInGame(i))
				{
					aArray.Push(i);
					
					if (IsPlayerAlive(i))
					{
						switch (GetClientTeam(i))
						{
							case 2: ++iPrisoners;
							case 3: ++iGuards;
						}
					}
				}
			}
			
			if (IsValidClient(client) && IsPlayerAlive(client) && iPrisoners == 1 && iGuards >= REBELMINPLAYERS)
			{
				switch (iParam)
				{
					case 0:
					{
						RemoveAllWeapons(client);
						
						PrintToChat(client, "%sKill all of the \x0BGuards\x01 before they kill you!", JB_TAG);
						GivePlayerItem(client, "weapon_knife");
						GivePlayerItem(client, "weapon_m249");
						
						int iHealth = (iGuards * REBELRAMBOHEALTH);
						SetEntityHealth(client, iHealth);
						SetGlow(client, 255, 0, 0, 255);
						
						for (int i = 0; i < aArray.Length; ++i)
						{
							iPlayer = aArray.Get(i);
							
							PrintToChat(iPlayer, "%s\x09%N\x01 has chose to \x02Rebel\x01! \x10[Kill him on Sight]", JB_TAG, client);
							PrintCenterText(iPlayer, "<font color='#ff3300'>%N</font> has chosen to rebel!", client);
							ClientCommand(iPlayer, "play %s", SOUND_LR_RAMBO);
						}
						gH_LastRequest = LASTREQUEST_REBEL;
					}
					case 1:
					{			
						CreateTimer(0.1, Timer_Jihad, GetClientUserId(client));
						
						for (int i = 0; i < aArray.Length; ++i)
						{
							iPlayer = aArray.Get(i);
							
							PrintToChat(iPlayer, "%s\x09%N\x01 has decided to suicide bomb!", JB_TAG, client);
							PrintCenterText(iPlayer, "<font color='#ff3300'>%N</font> has chosen to rebel!", client);
						}
						gH_LastRequest = LASTREQUEST_REBEL;
					}
					case 2:
					{
						RemoveAllWeapons(client);
						PrintToChat(client, "%sKill all of the \x0BGuards\x01 before they kill you!", JB_TAG);
						GivePlayerItem(client, "weapon_knife");
						GivePlayerItem(client, "weapon_deagle");
						
						int iHealth = (iGuards * (REBELRAMBOHEALTH * 2));
						SetEntityHealth(client, iHealth);
						SetGlow(client, 255, 0, 0, 255);
						
						for (int i = 0; i < aArray.Length; ++i)
						{
							iPlayer = aArray.Get(i);
							
							PrintToChat(iPlayer, "%s\x09%N\x01 has chose to \x02Rebel\x01! \x10[Kill him on Sight]", JB_TAG, client);	
							PrintCenterText(iPlayer, "<font color='#ff3300'>%N</font> has chosen to rebel!", client);
						}
						gH_LastRequest = LASTREQUEST_REBEL;						
					}
					case 3:
					{
						RemoveAllWeapons(client);
						PrintToChat(client, "%sKill all of the \x0BGuards\x01 before they kill you!", JB_TAG);
						GivePlayerItem(client, "weapon_knife");
						GivePlayerItem(client, "weapon_ak47");
						SetEntityHealth(client, 1);				
						SetGlow(client, 255, 255, 255, 13);	

						for (int i = 0; i < aArray.Length; ++i)
						{
							iPlayer = aArray.Get(i);
							
							PrintToChat(iPlayer, "%s\x09%N\x01 has chose to \x02Rebel\x01! \x10[Kill him on Sight]", JB_TAG, client);	
							PrintCenterText(iPlayer, "<font color='#ff3300'>%N</font> has chosen to rebel!", client);
						}
						gH_LastRequest = LASTREQUEST_REBEL;						
					}
					case 4:
					{
						for (int i = 0; i < aArray.Length; ++i)
						{
							iPlayer = aArray.Get(i);
							
							PrintToChat(iPlayer, "%s\x09%N\x01 has chosen to recieve a freeday next round! \x010[Kill him on Sight]", JB_TAG, client);	
							PrintCenterText(iPlayer, "<font color='#ff3300'>%N</font> has chosen to rebel!", client);
						}
						gB_FreedayNext[client] = true;
						gH_LastRequest = LASTREQUEST_REBEL;
					}
					case 5:
					{
						Menu hMenu2 = new Menu(Menu_RebelSpecialDay);
						hMenu2.SetTitle("[Jailbreak] Special Days\n ");
						hMenu2.AddItem("", "Knife Battle");
						hMenu2.AddItem("", "Kill Confirmed");
						hMenu2.AddItem("", "Gang War");
						hMenu2.AddItem("", "No Scope");
						hMenu2.AddItem("", "Scoutzknivez");
						hMenu2.AddItem("", "One in a Chamber");
						hMenu2.AddItem("", "Nade War");
						hMenu2.AddItem("", "Headshot");
						hMenu2.AddItem("", "Jedi");
						hMenu2.AddItem("", "Shark");
						hMenu2.AddItem("", "NightCrawler");
						hMenu2.AddItem("", "Cocktail Party");
						hMenu2.AddItem("", "Trigger Discipline");
						hMenu2.AddItem("", "Gun Game");
						hMenu2.ExitBackButton = true;
						hMenu2.ExitButton = false;
						hMenu2.Display(client, MENU_TIME_FOREVER);
					}
				}
			}
			delete aArray;
		}
		case MenuAction_Cancel: 
		{
			if (IsValidClient(client) && IsPlayerAlive(client) && GetPlayerAliveCount(2) == 1)
			{
				gI_LastRequestWeapon = -1;
				gH_LastRequest = LASTREQUEST_INVALID;
				RebelMenu(client);
			}
		}
		case MenuAction_End: delete hMenu;
	}
}

public int Menu_RebelSpecialDay(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			int iPrisoners, iGuards, iPlayer;
			
			ArrayList aArray = new ArrayList(66);
			
			for (int i = 1; i <= MaxClients; ++i)
			{
				if (IsClientInGame(i))
				{
					aArray.Push(i);
					
					if (IsPlayerAlive(i))
					{
						switch (GetClientTeam(i))
						{
							case 2: ++iPrisoners;
							case 3: ++iGuards;
						}
					}
				}
			}
			
			if (IsValidClient(client) && IsPlayerAlive(client) && iPrisoners == 1 && iGuards >= REBELMINPLAYERS)
			{
				gI_DaySelected = iParam;
				gI_SpecialDay = gI_Round + 1;
				
				for (int i = 0; i < aArray.Length; ++i)
				{
					iPlayer = aArray.Get(i);
					
					PrintToChat(iPlayer, "%s\x09%N\x01 has picked a Special Day for next round! \x10[Kill him on Sight]", JB_TAG, client);
					PrintCenterText(iPlayer, "<font color='#ff3300'>%N</font> has chosen to rebel!", client);
				}
				gH_LastRequest = LASTREQUEST_REBEL;
			}
			delete aArray;
		}
		case MenuAction_Cancel: 
		{
			if (IsValidClient(client) && IsPlayerAlive(client) && GetPlayerAliveCount(2) == 1)
			{
				gI_LastRequestWeapon = -1;
				gH_LastRequest = LASTREQUEST_INVALID;
				LastRequestMenu(client, gI_LRHealth[client]);
			}
		}
		case MenuAction_End: delete hMenu;
	}
}

void SelectGuardMenu(int client)
{
	Menu hMenu = new Menu(Menu_SelectGuard);
	hMenu.SetTitle("[Jailbreak] Select a Guard\n ");
	
	char[] sDisplayString = new char[MAX_NAME_LENGTH];
	char[] sInfoString = new char[5];

	for (int i = 1; i <= MaxClients; ++i)
	{
		if (IsClientInGame(i) && IsPlayerAlive(i) && GetClientTeam(i) == 3)
		{			
			FormatEx(sDisplayString, MAX_NAME_LENGTH, "%N", i);
			FormatEx(sInfoString, 5, "%i", GetClientUserId(i));
			hMenu.AddItem(sInfoString, sDisplayString);
		}
	}
	
	if (hMenu.ItemCount == 0) 
	{
		PrintToChat(client, "%sThere are no \x0BGuards\x01 to Select!", JB_TAG);
		delete hMenu;
		return;
	}
	
	hMenu.ExitBackButton = true;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_SelectGuard(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			int iPrisoners, iGuards;
			
			for (int i = 1; i <= MaxClients; ++i)
			{
				if (IsClientInGame(i))
				{
					if (IsPlayerAlive(i))
					{
						switch (GetClientTeam(i))
						{
							case 2: ++iPrisoners;
							case 3: ++iGuards;
						}
					}
				}
			}
			
			if (IsValidClient(client) && IsPlayerAlive(client) && iPrisoners == 1 && iGuards > 0)
			{
				char[] sInfo = new char[MAX_NAME_LENGTH];
				hMenu.GetItem(iParam, sInfo, MAX_NAME_LENGTH);
				
				gI_Guard = GetClientOfUserId(StringToInt(sInfo));
				gI_Prisoner = client;
				
				if (IsValidClient(gI_Guard) && IsPlayerAlive(gI_Guard))
				{		
					gI_Seconds = 5;
					CreateTimer(1.0, Timer_Countdown, gI_Round, TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);					

					SetGlow(client, 255, 255, 255, 255);
					SetGlow(gI_Guard, 255, 255, 255, 255);
					
					gB_DeathBall = false;
					gB_TickingTimeBomb = false;
					gB_Shove = false;
					gB_Cells = true;
					
					++gI_Cells;
					Cells(true);
					
					SetupGlowSkin(gI_Prisoner, 255, 0, 0);
					SetupGlowSkin(gI_Guard, 0, 0, 255);
					
					PrintToChatAll("%s\x09%N\x01 has challenged \x0B%N\x01 in Lastrequest!", JB_TAG, gI_Prisoner, gI_Guard);
				}
			}
		}
		case MenuAction_Cancel: 
		{
			if (IsValidClient(client) && IsPlayerAlive(client) && GetPlayerAliveCount(2) == 1)
			{
				gI_LastRequestWeapon = -1;
				gH_LastRequest = LASTREQUEST_INVALID;
				LastRequestMenu(client, gI_LRHealth[client]);
			}
		}
		case MenuAction_End: delete hMenu;
	}
}

void GuardBansMenu(int client)
{
	Menu hMenu = new Menu(Menu_Bans);
	hMenu.SetTitle("Guardbans Menu\n ");

	char[] sDisplayString = new char[MAX_NAME_LENGTH];
	char[] sInfoString = new char[5];

	for (int i = 1; i <= MaxClients; ++i)
	{
		if (IsClientInGame(i) && i != client && !CheckCommandAccess(i, "sm_ban", ADMFLAG_BAN) && gI_ClientBan[i] == -1)
		{	
			FormatEx(sDisplayString, MAX_NAME_LENGTH, "%N", i);
			FormatEx(sInfoString, 5, "%i", GetClientUserId(i));
			hMenu.AddItem(sInfoString, sDisplayString);
		}
	}
	
	if (hMenu.ItemCount == 0) 
	{
		PrintToChat(client, "[SM] There are no Players to Select!");
		delete hMenu;
		gT_TopMenu.Display(client, TopMenuPosition_LastCategory);
		return;
	}
	
	hMenu.ExitBackButton = true;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_Bans(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client))
			{
				char[] sInfo = new char[MAX_NAME_LENGTH];
				hMenu.GetItem(iParam, sInfo, MAX_NAME_LENGTH);
				
				int target = GetClientOfUserId(StringToInt(sInfo));
				
				if (IsValidClient(target))
				{
					Menu hMenu2 = new Menu(Menu_Time);
					hMenu2.SetTitle("[Guardbans] %N\n ", target);
					hMenu2.AddItem(sInfo, "Permanently");
					hMenu2.AddItem(sInfo, "30 Minutes");
					hMenu2.AddItem(sInfo, "One Hour");
					hMenu2.AddItem(sInfo, "One Day");
					hMenu2.AddItem(sInfo, "One Week");
					hMenu2.AddItem(sInfo, "One Month");
					hMenu2.Display(client, MENU_TIME_FOREVER);
				}
			}
		}
		case MenuAction_Cancel: if (iParam == MenuCancel_ExitBack && gT_TopMenu != null && IsValidClient(client)) gT_TopMenu.Display(client, TopMenuPosition_LastCategory);
		case MenuAction_End: delete hMenu;
	}
}

public int Menu_Time(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client))
			{
				char[] sInfo = new char[MAX_NAME_LENGTH];
				hMenu.GetItem(iParam, sInfo, MAX_NAME_LENGTH);
				
				int target = GetClientOfUserId(StringToInt(sInfo));
				
				if (IsValidClient(target))
				{
					int Time;
					
					switch (iParam)
					{
						case 0: Time = -2;
						case 1: Time = 1800;
						case 2: Time = 3600;
						case 3: Time = 86400;
						case 4: Time = 604800;
						case 5: Time = 2629746;
					}
					
					SecondsToTime(Time, sInfo);
					PrintToChatAll("[SM] \x04%N \x01has banned \x07%N \x01from joining \x0BGuards\x01 team for \x02%s", client, target, sInfo);
					LogAction(client, -1, "%L Guard banned %L for %s", client, target, sInfo);
					gI_ClientBan[target] = GetTime() + Time;
					UpdateBans(target, gI_ClientBan[target], client);
					
					if (GetClientTeam(target) == 3)
						ChangeClientTeam(target, 2);	
				}
			}
		}
		case MenuAction_End: delete hMenu;
	}
}

void UnGuardBansMenu(int client)
{
	Menu hMenu = new Menu(Menu_UnGuardBans);
	hMenu.SetTitle("UnGuardban Menu\n ");

	char[] sDisplayString = new char[MAX_NAME_LENGTH];
	char[] sInfoString = new char[5];

	for (int i = 1; i <= MaxClients; ++i)
	{
		if (IsClientInGame(i) && gI_ClientBan[i] != -1)
		{			
			FormatEx(sDisplayString, MAX_NAME_LENGTH, "%N", i);
			FormatEx(sInfoString, 5, "%i", GetClientUserId(i));
			hMenu.AddItem(sInfoString, sDisplayString);
		}
	}
	
	if (hMenu.ItemCount == 0) 
	{
		PrintToChat(client, "[SM] There are no Players to Select!");
		delete hMenu;
		gT_TopMenu.Display(client, TopMenuPosition_LastCategory);
		return;
	}
	
	hMenu.ExitBackButton = true;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_UnGuardBans(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client))
			{
				char[] sInfo = new char[MAX_NAME_LENGTH];
				hMenu.GetItem(iParam, sInfo, MAX_NAME_LENGTH);
				
				int target = GetClientOfUserId(StringToInt(sInfo));
				
				if (IsValidClient(target))
				{
					gI_ClientBan[target] = -1;
					RemoveGuardBan(target);
					PrintToChatAll("[SM] \x04%N \x01has unbanned \x07%N \x01from the \x0BGuard\x01 Team!", client, target);
					LogAction(client, -1, "%L Unguard banned %L!", client, target);
				}
			}
		}
		case MenuAction_Cancel: if (iParam == MenuCancel_ExitBack && gT_TopMenu != null && IsValidClient(client)) gT_TopMenu.Display(client, TopMenuPosition_LastCategory);
		case MenuAction_End: delete hMenu;
	}
}

void SecurityCheck(int client)
{
	if (!gB_GuardMenu[client])
	{
		Menu hMenu = new Menu(Menu_SecurityCheck);
		hMenu.SetTitle("[Jailbreak] Security Check\n ");
		hMenu.AddItem("", "By becoming a guard you will be expected to know the rules", ITEMDRAW_DISABLED);
		hMenu.AddItem("", "If caught not following the rules it will result in a Guard Ban", ITEMDRAW_DISABLED);
		hMenu.AddItem("", "Yes, I do Understand");
		hMenu.AddItem("", "No, I'm Good");
		hMenu.ExitButton = false;
		hMenu.Display(client, MENU_TIME_FOREVER);	
	}
	else ChangeClientTeam(client, 3);
}

public int Menu_SecurityCheck(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client) && iParam == 2)
			{
				ChangeClientTeam(client, 3);
				SetClientCookie(client, gH_GuardCookie, "1");
				gB_GuardMenu[client] = true;
			}
		}
		case MenuAction_End: delete hMenu;
	}
}

void OpenGuardsMenu(int client)
{	
	Menu hMenu = new Menu(Menu_Guards);
	hMenu.SetTitle("[Jailbreak] Guards Menu\n ");
	hMenu.AddItem("", "Gun Menu");
	hMenu.AddItem("", "Cell Doors");
	hMenu.AddItem("", "Warden Menu");
	hMenu.AddItem("", "Tools Menu");
	hMenu.AddItem("", "Reset Ball\n ");
	hMenu.AddItem("", "Bounty");
	hMenu.AddItem("", "Casino");
	hMenu.AddItem("", "Settings & Stats");
	SetMenuPagination(hMenu, MENU_NO_PAGINATION);
	hMenu.ExitButton = true;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_Guards(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (Checker(client, false, 3, false))
			{				
				switch (iParam)
				{
					case 0:
					{
						if (!IsPlayerAlive(client))
						{
							PrintToChat(client, "%sYou must be alive to access this menu!", JB_TAG);	
							OpenGuardsMenu(client);
						}
						else if (gB_Expired && (gI_PrimaryWeapon[client] != -1 || gI_SecondaryWeapon[client] != -1))
						{
							PrintToChat(client, "%sThe gunmenu usage time has expired!", JB_TAG);	
							OpenGuardsMenu(client);
						}
						else OpenGunsMenu(client, true);
					}
					case 1:
					{
						if (!IsPlayerAlive(client))
						{
							PrintToChat(client, "%sYou must be alive to access this menu!", JB_TAG);	
							OpenGuardsMenu(client);
						}
						else
						{
							if (gB_Cells)
								Cells(false);
							else
								Cells(true);
							
							++gI_Cells;
							gB_Cells = !gB_Cells;
							PrintToChatAll("%s\x0B%N \x01has %s \x01the cells!", JB_TAG, client, (gB_Cells) ? "\x04opened":"\x02closed");
							OpenGuardsMenu(client);
						}
					}
					case 2: 
					{
						if (client != gI_Warden)
						{
							PrintToChat(client, "%sYou must be Warden to access this menu!", JB_TAG);
							OpenGuardsMenu(client);
						}
						else
						{
							if (!IsPlayerAlive(client))
							{
								PrintToChat(client, "%sYou must be alive!", JB_TAG);
								OpenGuardsMenu(client);
							}
							else OpenWardenMenu(client);
						}
					}
					case 3: OpenToolsMenu(client);
					case 4: 
					{
						if (IsPlayerAlive(client))
						{
							RespawnBall();
							PrintToChatAll("%s\x0B%N\x01 has reset the ball!", JB_TAG, client);
						}
						else PrintToChat(client, "%sYou must be alive to access this menu!", JB_TAG);	
						OpenGuardsMenu(client);
					}
					case 5: OpenBountyMenu(client);
					case 6: OpenCasinoMenu(client);
					case 7: OpenSettingsMenu(client);
				}
			}
		}
		case MenuAction_End: delete hMenu;
	}
}

void OpenGunsMenu(int client, bool bBackButton)
{
	Menu hMenu = new Menu(Menu_Guns);
	hMenu.SetTitle("[Jailbreak] Gunmenu\n ");
	hMenu.AddItem("", "New Weapons");
	hMenu.AddItem("", "Last Weapons", (gI_PrimaryWeapon[client] == -1 || gI_SecondaryWeapon[client] == -1) ? ITEMDRAW_DISABLED:ITEMDRAW_DEFAULT);
	hMenu.AddItem("", "Same Weapons Everytime", (gI_PrimaryWeapon[client] == -1 || gI_SecondaryWeapon[client] == -1) ? ITEMDRAW_DISABLED:ITEMDRAW_DEFAULT);
	hMenu.ExitBackButton = bBackButton;
	hMenu.ExitButton = false;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_Guns(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (Checker(client, true, 3, false))
			{
				switch (iParam)
				{
					case 0: 
					{
						SetClientCookie(client, gH_WeaponsCookie, "");
						OpenPrimaryWeaponsMenu(client);
					}
					case 1: GiveWeapons(client);
					case 2:
					{
						GiveWeapons(client);
						gB_GunMenu[client] = true;
						PrintToChat(client, "%sTo reopen the gunmenu type \x04!guns\x01!", JB_TAG);
						
						char[] sValue = new char[6];
						FormatEx(sValue, 6, "%i;%i", gI_PrimaryWeapon[client], gI_SecondaryWeapon[client]);
						SetClientCookie(client, gH_WeaponsCookie, sValue);
					}
				}
			}
		}
		case MenuAction_Cancel: if (iParam == MenuCancel_ExitBack && Checker(client, false, 3, false)) OpenGuardsMenu(client);
		case MenuAction_End: delete hMenu;
	}
}

void OpenPrimaryWeaponsMenu(int client)
{
	Menu hMenu = new Menu(Menu_PrimaryWeapons);
	hMenu.SetTitle("Primary Weapons\n ");
	hMenu.AddItem("", "Ak-47");
	hMenu.AddItem("", "M4A4");
	hMenu.AddItem("", "M4A4-S");
	hMenu.AddItem("", "AWP");
	hMenu.AddItem("", "Aug");
	hMenu.AddItem("", "SG556");
	hMenu.AddItem("", "Famas");
	hMenu.AddItem("", "Galil-AR");
	hMenu.AddItem("", "Scout");
	hMenu.AddItem("", "P90");
	hMenu.AddItem("", "Ump-45");
	hMenu.AddItem("", "Mac-10");
	hMenu.AddItem("", "MP9");
	hMenu.AddItem("", "MP7");
	hMenu.AddItem("", "Bizon");
	hMenu.AddItem("", "Nova");
	hMenu.AddItem("", "Mag-7");
	hMenu.AddItem("", "Sawed-Off");
	hMenu.AddItem("", "XM1041");
	hMenu.ExitBackButton = true;
	hMenu.ExitButton = false;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_PrimaryWeapons(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (Checker(client, true, 3, false))
			{
				RemoveAllWeapons(client);
				
				switch (iParam)
				{
					case 0: GivePlayerItem(client, "weapon_ak47");
					case 1: GivePlayerItem(client, "weapon_m4a1");
					case 2: GivePlayerItem(client, "weapon_m4a1_silencer");
					case 3: GivePlayerItem(client, "weapon_awp");
					case 4: GivePlayerItem(client, "weapon_aug");
					case 5: GivePlayerItem(client, "weapon_sg556");
					case 6: GivePlayerItem(client, "weapon_famas");
					case 7: GivePlayerItem(client, "weapon_galilar");
					case 8: GivePlayerItem(client, "weapon_ssg08");
					case 9: GivePlayerItem(client, "weapon_p90");
					case 10: GivePlayerItem(client, "weapon_ump45");
					case 11: GivePlayerItem(client, "weapon_mac10");
					case 12: GivePlayerItem(client, "weapon_mp9");
					case 13: GivePlayerItem(client, "weapon_mp7");
					case 14: GivePlayerItem(client, "weapon_bizon");
					case 15: GivePlayerItem(client, "weapon_nova");
					case 16: GivePlayerItem(client, "weapon_mag7");
					case 17: GivePlayerItem(client, "weapon_sawedoff");
					case 18: GivePlayerItem(client, "weapon_xm1014");
				}
					
				gI_PrimaryWeapon[client] = iParam;
				gB_GunMenu[client] = false;
				
				GivePlayerItem(client, "weapon_knife");
				GivePlayerItem(client, "item_assaultsuit");
				GivePlayerItem(client, "weapon_tagrenade");
				GivePlayerItem(client, "weapon_healthshot");
				
				if (gF_CagePosition[0] != 0.0)
				{
					int iWeapon = GivePlayerItem(client, "weapon_taser");
					SetEntProp(iWeapon, Prop_Send, "m_iClip1", 230);
				}
				OpenSecondaryWeaponsMenu(client);
			}
		}
		case MenuAction_Cancel:
		{
			if (Checker(client, true, 3, false) && !gB_Expired)
			{
				gI_PrimaryWeapon[client] = -1;
				gI_SecondaryWeapon[client] = -1;
				OpenGunsMenu(client, false);
			}
		}
		case MenuAction_End: delete hMenu;
	}
}

void OpenSecondaryWeaponsMenu(int client)
{
	Menu hMenu = new Menu(Menu_SecondaryWeapons);
	hMenu.SetTitle("Secondary Weapons\n ");
	hMenu.AddItem("", "Deagle");
	hMenu.AddItem("", "Revolver");
	hMenu.AddItem("", "Tec-9");
	hMenu.AddItem("", "Five-Seven");
	hMenu.AddItem("", "CZ-75");
	hMenu.AddItem("", "Elite");
	hMenu.AddItem("", "P250");
	hMenu.AddItem("", "USP-s");
	hMenu.AddItem("", "P2000");
	hMenu.AddItem("", "Glock");
	hMenu.ExitBackButton = true;
	hMenu.ExitButton = false;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_SecondaryWeapons(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (Checker(client, true, 3, false))
			{
				switch (iParam)
				{
					case 0: GivePlayerItem(client, "weapon_deagle");
					case 1: GivePlayerItem(client, "weapon_revolver");
					case 2: GivePlayerItem(client, "weapon_tec9");
					case 3: GivePlayerItem(client, "weapon_fiveseven");
					case 4: GivePlayerItem(client, "weapon_cz75a");
					case 5: GivePlayerItem(client, "weapon_elite");
					case 6: GivePlayerItem(client, "weapon_p250");
					case 7: GivePlayerItem(client, "weapon_usp_silencer");
					case 8: GivePlayerItem(client, "weapon_hkp2000");
					case 9: GivePlayerItem(client, "weapon_glock");
				}	
				gI_SecondaryWeapon[client] = iParam;
			}
		}
		case MenuAction_Cancel:
		{
			if (Checker(client, true, 3, false) && !gB_Expired)
			{
				gI_PrimaryWeapon[client] = -1;
				gI_SecondaryWeapon[client] = -1;
				OpenPrimaryWeaponsMenu(client);
			}
		}		
		case MenuAction_End: delete hMenu;
	}
}

void OpenToolsMenu(int client)
{	
	Menu hMenu = new Menu(Menu_Tools);
	hMenu.SetTitle("[Jailbreak] Tools Menu\n ");
	hMenu.AddItem("", "Freeday");
	hMenu.AddItem("", "Quick Revive");
	hMenu.AddItem("", "Heal");
	hMenu.AddItem("", "Glow");
	hMenu.AddItem("", "Math Trivia");
	hMenu.AddItem("", "Random Select");
	hMenu.ExitBackButton = true;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_Tools(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (Checker(client, true, 3, false, false))
			{
				switch (iParam)
				{
					case 0: OpenFreeDayMenu(client);
					case 1:	OpenReviveMenu(client, true);
					case 2:	OpenHealMenu(client, gI_LRHealth[client]);
					case 3: OpenGlowMenu(client);
					case 4:
					{				
						Cmd_Math(client, 0);
						OpenToolsMenu(client);
					}
					case 5: 
					{
						int target = GetRandomClient(2);
						
						if (IsValidClient(target)) 
						{
							PrintToChatAll("%s\x0B%N \x01randomly selected \x09%N", JB_TAG, client, target);
							PrintToChat(target, "%s\x0EYou were randomly selected.", JB_TAG);
							FadePlayer(target, 300, 300, 0x0001, {0, 255, 0, 100});
						}
						else PrintToChat(client, "%sThere are no \x09Prisoners \x01to Select!", JB_TAG);	
						OpenToolsMenu(client);
					}
				}
			}
		}
		
		case MenuAction_Cancel: if (iParam == MenuCancel_ExitBack && Checker(client, false, 3, false)) OpenGuardsMenu(client);
		case MenuAction_End: delete hMenu;
	}
}

void OpenFreeDayMenu(int client)
{
	Menu hMenu = new Menu(Menu_Freeday);
	
	hMenu.SetTitle("[Jailbreak] Freeday Menu\n ");
	hMenu.AddItem("", "Remove Freedays");
	
	char[] sDisplayString = new char[MAX_NAME_LENGTH];
	char[] sInfoString = new char[5];
	
	for (int i = 1; i <= MaxClients; ++i)
	{
		if (IsClientInGame(i) && GetClientTeam(i) == 2 && !gB_Freeday[i] && !gB_FreedayNext[i])
		{
			FormatEx(sDisplayString, MAX_NAME_LENGTH, "%N", i);
			FormatEx(sInfoString, 5, "%i", GetClientUserId(i));	
			hMenu.AddItem(sInfoString, sDisplayString);
		}
	}
	
	hMenu.ExitBackButton = true;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_Freeday(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (Checker(client, true, 3, false, false))
			{	
				if (iParam == 0)
				{
					OpenUnfreedayMenu(client);
					return;
				}
				
				char[] sInfo = new char[MAX_NAME_LENGTH];
				hMenu.GetItem(iParam, sInfo, MAX_NAME_LENGTH);
				
				int target = GetClientOfUserId(StringToInt(sInfo));
				
				if (IsValidClient(target))
				{
					if (IsPlayerAlive(target))
					{			
						++gI_Freedays;
						gB_Freeday[target] = true;
						SetGlow(target, 255, 255, 0, 255);
						FadePlayer(target, 300, 300, 0x0001, {255, 255, 0, 100});
						PrintToChatAll("%s\x0B%N \x01has given a freeday to \x09%N", JB_TAG, client, target);
						PrintToChat(target, "%sYou have a freeday!", JB_TAG);
					}
					else 
					{
						gB_FreedayNext[target] = true;
						PrintToChatAll("%s\x0B%N \x01has assigned a freeday to \x09%N\x01 next round!", JB_TAG, client, target);
					}
				}
				OpenFreeDayMenu(client);
			}
		}
		case MenuAction_Cancel: if (iParam == MenuCancel_ExitBack && Checker(client, true, 3, false)) OpenToolsMenu(client);
		case MenuAction_End: delete hMenu;
	}
}

void OpenUnfreedayMenu(int client)
{
	Menu hMenu = new Menu(Menu_UnFreeday);
	hMenu.SetTitle("[Jailbreak] Remove Freedays\n ");

	char[] sDisplayString = new char[MAX_NAME_LENGTH];
	char[] sInfoString = new char[5];

	for (int i = 1; i <= MaxClients; ++i)
	{
		if (IsClientInGame(i) && IsPlayerAlive(i) && (gB_Freeday[i] || gB_FreedayNext[i]))
		{
			FormatEx(sDisplayString, MAX_NAME_LENGTH, "%N", i);
			FormatEx(sInfoString, 5, "%i", GetClientUserId(i));
			hMenu.AddItem(sInfoString, sDisplayString);
		}
	}
	
	if (hMenu.ItemCount == 0) 
	{
		PrintToChat(client, "%sThere are no \x09Prisoners\x01 to Select!", JB_TAG);
		delete hMenu;
		OpenFreeDayMenu(client);
		return;
	}
	
	hMenu.ExitBackButton = true;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_UnFreeday(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (Checker(client, true, 3, false, false))
			{
				char[] sInfo = new char[MAX_NAME_LENGTH];
				hMenu.GetItem(iParam, sInfo, MAX_NAME_LENGTH);
				
				int target = GetClientOfUserId(StringToInt(sInfo));		
	
				if (IsValidClient(target))
				{
					if (IsPlayerAlive(target))
					{
						gI_Freedays--;
						gB_Freeday[target] = false;
						SetGlow(target, 255, 255, 255, 255);
						FadePlayer(target, 300, 300, 0x0001, {0, 0, 0, 100});
						PrintToChatAll("%s\x0B%N \x01has removed \x09%N\x01's Freeday!", JB_TAG, client, target);
						PrintToChat(target, "%sYour freeday has been removed!", JB_TAG);
					}
					else
					{
						gB_FreedayNext[target] = false;	
						PrintToChatAll("%s\x0B%N \x01has removed \x09%N\x01's Freeday for next round!", JB_TAG, client, target);
					}
				}
				OpenUnfreedayMenu(client);
			}
		}
		
		case MenuAction_Cancel: if (iParam == MenuCancel_ExitBack && Checker(client, true, 3, false)) OpenFreeDayMenu(client);
		case MenuAction_End: delete hMenu;
	}
}

void OpenReviveMenu(int client, bool bBackButton)
{
	Menu hMenu = new Menu(Menu_Revive);
	hMenu.SetTitle("[Jailbreak] Revive Menu\n ");
	
	char[] sDisplayString = new char[MAX_NAME_LENGTH];
	char[] sInfoString = new char[5];
	
	for (int i = 1; i <= MaxClients; ++i)
	{
		if (IsClientInGame(i) && !IsPlayerAlive(i) && GetClientTeam(i) == 2)
		{
			FormatEx(sDisplayString, MAX_NAME_LENGTH, "%N", i);
			FormatEx(sInfoString, 5, "%i", GetClientUserId(i));	
			hMenu.AddItem(sInfoString, sDisplayString);
		}
	}
	
	if (hMenu.ItemCount == 0) 
	{
		PrintToChat(client, "%sThere are no \x09Prisoners\x01 to Select!", JB_TAG);
		delete hMenu;
		if (bBackButton) OpenToolsMenu(client);
		return;
	}
	
	hMenu.ExitBackButton = bBackButton;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_Revive(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (Checker(client, true, 3, false, false))
			{
				char[] sInfo = new char[MAX_NAME_LENGTH];
				hMenu.GetItem(iParam, sInfo, MAX_NAME_LENGTH);
				
				int target = GetClientOfUserId(StringToInt(sInfo));		
	
				if (IsValidClient(target))
				{
					if (!IsPlayerAlive(target))
					{
						CS_RespawnPlayer(target);
						TeleportEntity(target, gF_RevivePosition[target], NULL_VECTOR, NULL_VECTOR);
						PrintToChatAll("%s\x0B%N \x01has quick revived \x09%N", JB_TAG, client, target);
					}
					else PrintToChat(client, "%s\x09%N\x01 is already alive!", JB_TAG, target);
				}
				OpenReviveMenu(client, true);
			}
		}
		
		case MenuAction_Cancel: if (iParam == MenuCancel_ExitBack && Checker(client, true, 3, false)) OpenToolsMenu(client);
		case MenuAction_End: delete hMenu;
	}
}

void OpenHealMenu(int client, int iHealth)
{
	Menu hMenu = new Menu(Menu_Heal);
	hMenu.SetTitle("[Jailbreak] Heal Menu\n ");
	
	switch (iHealth)
	{
		case 0: hMenu.AddItem("1", "Health: [35] 100 250 500");
		case 1: hMenu.AddItem("2", "Health: 35 [100] 250 500");
		case 2: hMenu.AddItem("3", "Health: 35 100 [250] 500");
		case 3: hMenu.AddItem("0", "Health: 35 100 250 [500]");
	}
	
	hMenu.AddItem("", "[Heal All Prisoners]\n ");
	
	char[] sDisplayString = new char[MAX_NAME_LENGTH];
	char[] sInfoString = new char[5];
	
	for (int i = 1; i <= MaxClients; ++i)
	{
		if (IsClientInGame(i) && IsPlayerAlive(i) && GetClientTeam(i) == 2)
		{
			FormatEx(sDisplayString, MAX_NAME_LENGTH, "%N", i);
			FormatEx(sInfoString, 5, "%i", GetClientUserId(i));
			hMenu.AddItem(sInfoString, sDisplayString);
		}
	}
	
	if (hMenu.ItemCount == 2) 
	{
		PrintToChat(client, "%sThere are no \x09Prisoners\x01 to Select!", JB_TAG);
		delete hMenu;
		OpenToolsMenu(client);
		return;
	}
	
	hMenu.ExitBackButton = true;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_Heal(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (Checker(client, true, 3, false, false))
			{
				char[] sInfo = new char[MAX_NAME_LENGTH];
				hMenu.GetItem(iParam, sInfo, MAX_NAME_LENGTH);
				
				if (iParam == 0) {
					gI_LRHealth[client] = StringToInt(sInfo);
				}
				else if (iParam == 1)
				{
					for (int i = 1; i <= MaxClients; ++i)
					{
						if (IsClientInGame(i) && GetClientTeam(i) == 2 && IsPlayerAlive(i))
						{
							switch (gI_LRHealth[client])
							{
								case 0: SetEntProp(i, Prop_Send, "m_iHealth", 35);
								case 1: SetEntProp(i, Prop_Send, "m_iHealth", GetEntProp(i, Prop_Data, "m_iMaxHealth"));
								case 2: SetEntProp(i, Prop_Send, "m_iHealth", 250);
								case 3: SetEntProp(i, Prop_Send, "m_iHealth", 500);
							}
						}
					}
					PrintToChatAll("%s\x0B%N \x01healed [\x04%i \x01HP] \x09All Prisoners\x01!", JB_TAG, client, (gI_LRHealth[client] == 3)? 500:(gI_LRHealth[client] == 2)? 250:(gI_LRHealth[client] == 1)? 100:35);
					return;
				}
				else
				{					
					int target = GetClientOfUserId(StringToInt(sInfo));
					
					if (IsValidClient(target) && IsPlayerAlive(target))
					{
						switch (gI_LRHealth[client])
						{
							case 0: 
							{
								SetEntProp(target, Prop_Send, "m_iHealth", 35);
								PrintToChatAll("%s\x0B%N \x01healed [\x04%i \x01HP] \x09%N\x01!", JB_TAG, client, 35, target);
							}
							case 1: 
							{
								SetEntProp(target, Prop_Send, "m_iHealth", GetEntProp(target, Prop_Data, "m_iMaxHealth"));
								PrintToChatAll("%s\x0B%N \x01healed [\x04%i \x01HP] \x09%N\x01!", JB_TAG, client, 100, target);
							}
							case 2: 
							{
								SetEntProp(target, Prop_Send, "m_iHealth", 250);
								PrintToChatAll("%s\x0B%N \x01healed [\x04%i \x01HP] \x09%N\x01!", JB_TAG, client, 250, target);
							}
							case 3: 
							{
								SetEntProp(target, Prop_Send, "m_iHealth", 500);
								PrintToChatAll("%s\x0B%N \x01healed [\x04%i \x01HP] \x09%N\x01!", JB_TAG, client, 500, target);
							}
						}
					}
				}
				OpenHealMenu(client, gI_LRHealth[client]);
			}
		}
		
		case MenuAction_Cancel: if (iParam == MenuCancel_ExitBack && Checker(client, true, 3, false)) OpenToolsMenu(client);
		case MenuAction_End: delete hMenu;
	}
}

void OpenGlowMenu(int client)
{
	Menu hMenu = new Menu(Menu_Glow);
	hMenu.SetTitle("[Jailbreak] Glow Menu\n ");
	hMenu.AddItem("", "Team Split");
	hMenu.AddItem("", "Unglow");
	hMenu.AddItem("", "Red");
	hMenu.AddItem("", "Blue");
	hMenu.AddItem("", "Green");
	hMenu.AddItem("", "Purple");
	hMenu.AddItem("", "Pink");
	hMenu.ExitBackButton = true;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_Glow(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (Checker(client, true, 3, false, true))
			{
				if (iParam == 0)
				{
					if (GetPlayerAliveCount(2) - gI_Freedays <= 1)
					{
						PrintToChat(client, "%sThere aren't enough \x09prisoners\x01 to make teams!", JB_TAG);
						OpenGlowMenu(client);
					}
					else OpenTeamSpliting(client);
					return;
				}
				
				int target = GetPlayerAimTarget(client);
					
				if (!IsValidClient(target))
				{
					PrintToChat(client, "%sAim at a \x09Prisoner\x01 to glow them!", JB_TAG);
					OpenGlowMenu(client);
					return;
				}
				else if (GetClientTeam(target) != 2)
				{
					PrintToChat(client, "%sMust be a \x09Prisoner\x01!", JB_TAG);
					OpenGlowMenu(client);
					return;
				}	
				else if (iParam > 1 && gB_Freeday[target])
				{
					PrintToChat(client, "%sThat \x09Prisoner\x01 has a Freeday!", JB_TAG);
					OpenGlowMenu(client);
					return;
				}
				else if (gI_ClientStatus[target] == iParam)
				{
					PrintToChat(client, "%sThat \x09Prisoner\x01 is already glowing %s", JB_TAG, (iParam == 1)? "Default":(iParam == 2)? "\x02Red":(iParam == 3)? "\x0BBlue":(iParam == 4)? "\x04Green":(iParam == 5)? "\x03Purple":"\x0EPink");
					OpenGlowMenu(client);
					return;
				}
				
				switch (iParam)
				{
					case 1:
					{								
						SetGlow(target, 255, 255, 255, 255);
						
						if (gB_Freeday[target])
						{
							PrintToChatAll("%s\x0B%N \x01has removed \x09%N\x01's Freeday!", JB_TAG, client, target);
							PrintToChat(target, "%sYour freeday has been removed!", JB_TAG);
							gB_Freeday[target] = false;
							gI_Freedays--;
						}
						else 
						{
							PrintToChatAll("%s\x0B%N \x01has unglowed \x09%N!", JB_TAG, client, target);
							PrintToChat(target, "%sYou are glowing the default color!", JB_TAG);
						}
					}		
					case 2:
					{
						SetGlow(target, 255, 0, 0, 255);
						FadePlayer(target, 300, 300, 0x0001, {255, 0, 0, 100});
						PrintToChatAll("%s\x0B%N \x01has glowed \x09%N \x02Red\x01!", JB_TAG, client, target);
						PrintToChat(target, "%sYou are glowing \x02Red\x01!", JB_TAG);
					}
					case 3:
					{
						SetGlow(target, 0, 0, 255, 255);
						FadePlayer(target, 300, 300, 0x0001, {0, 0, 255, 100});
						PrintToChatAll("%s\x0B%N \x01has glowed \x09%N \x0BBlue\x01!", JB_TAG, client, target);
						PrintToChat(target, "%sYou are glowing \x0BBlue\x01!", JB_TAG);
					}
					case 4:
					{				
						SetGlow(target, 0, 255, 0, 255);
						FadePlayer(target, 300, 300, 0x0001, {0, 255, 0, 100});
						PrintToChatAll("%s\x0B%N \x01has glowed \x09%N \x04Green\x01!", JB_TAG, client, target);
						PrintToChat(target, "%sYou are glowing \x04Green\x01!", JB_TAG);
					}
					case 5:
					{				
						SetGlow(target, 255, 0, 255, 255);
						FadePlayer(target, 300, 300, 0x0001, {255, 0, 255, 100});
						PrintToChatAll("%s\x0B%N \x01has glowed \x09%N \x03Purple\x01!", JB_TAG, client, target);
						PrintToChat(target, "%sYou are glowing \x03Purple\x01!", JB_TAG);
					}
					case 6:
					{				
						SetGlow(target, 255, 0, 127, 255);
						FadePlayer(target, 300, 300, 0x0001, {255, 0, 127, 100});
						PrintToChatAll("%s\x0B%N \x01has glowed \x09%N \x0EPink\x01!", JB_TAG, client, target);
						PrintToChat(target, "%sYou are glowing \x0EPink\x01!", JB_TAG);
					}
				}
				gI_ClientStatus[target] = iParam;
				OpenGlowMenu(client);
			}
		}
		
		case MenuAction_Cancel: if (iParam == MenuCancel_ExitBack && Checker(client, true, 3, false)) OpenToolsMenu(client);
		case MenuAction_End: delete hMenu;
	}
}

void OpenTeamSpliting(int client)
{	
	int iPlayers = GetPlayerAliveCount(2);
	
	Menu hMenu = new Menu(Menu_TeamSplit);
	hMenu.SetTitle("[Jailbreak] Team Split\n ");
	hMenu.AddItem("", "Two Teams", (iPlayers - gI_Freedays < 2) ? ITEMDRAW_DISABLED:ITEMDRAW_DEFAULT);
	hMenu.AddItem("", "Three Teams", (iPlayers - gI_Freedays < 3) ? ITEMDRAW_DISABLED:ITEMDRAW_DEFAULT);
	hMenu.AddItem("", "Four Teams", (iPlayers - gI_Freedays < 4) ? ITEMDRAW_DISABLED:ITEMDRAW_DEFAULT);
	hMenu.ExitBackButton = true;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_TeamSplit(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (Checker(client, true, 3, false, true))
			{
				switch (iParam)
				{
					case 0: 
					{
						if (GetPlayerAliveCount(2) >= 2)
						{
							bool bFlip = view_as<bool>(GetRandomInt(0,1));
							
							for (int i = 1; i <= MaxClients; ++i)
							{
								if (IsClientInGame(i) && IsPlayerAlive(i) && GetClientTeam(i) == 2 && !gB_Freeday[i])
								{
									switch (bFlip)
									{
										case true:
										{
											bFlip = false;
											gI_ClientStatus[i] = COLOR_RED;
											SetGlow(i, 255, 0, 0, 255);
											FadePlayer(i, 300, 300, 0x0001, {255, 0, 0, 100});
											PrintToChat(i, "%sYou are on the \x02Red\x01 Team!", JB_TAG);
										}
										case false:
										{
											bFlip = true;
											gI_ClientStatus[i] = COLOR_BLUE;
											SetGlow(i, 0, 0, 255, 255);
											FadePlayer(i, 300, 300, 0x0001, {0, 0, 255, 100});
											PrintToChat(i, "%sYou are on the \x0BBlue\x01 Team!", JB_TAG);
										}
									}
								}
							}
						}
					}
					case 1:
					{
						if (GetPlayerAliveCount(2) >= 3)
						{
							int iTeam = 0;
							int iRed = 0;
							int iBlue = 0;
							int iGreen = 0;
							
							for (int i = 1; i <= MaxClients; ++i)
							{
								if (IsClientInGame(i) && IsPlayerAlive(i) && GetClientTeam(i) == 2 && !gB_Freeday[i])
								{
									++iTeam;
									
									switch (iTeam)
									{
										case 1:
										{
											++iRed;
											gI_ClientStatus[i] = COLOR_RED;
											SetGlow(i, 255, 0, 0, 255);
											FadePlayer(i, 300, 300, 0x0001, {255, 0, 0, 100});
											PrintToChat(i, "%sYou are on the \x02Red\x01 Team!", JB_TAG);
										}
										case 2:
										{
											++iBlue;
											gI_ClientStatus[i] = COLOR_BLUE;
											SetGlow(i, 0, 0, 255, 255);
											FadePlayer(i, 300, 300, 0x0001, {0, 0, 255, 100});
											PrintToChat(i, "%sYou are on the \x0BBlue\x01 Team!", JB_TAG);
										}
										case 3:
										{
											++iGreen;
											iTeam = 0;	
											gI_ClientStatus[i] = COLOR_GREEN;
											SetGlow(i, 0, 255, 0, 255);
											FadePlayer(i, 300, 300, 0x0001, {0, 255, 0, 100});
											PrintToChat(i, "%sYou are on the \x04Green\x01 Team!", JB_TAG);
										}
									}
								}
							}	
						}
					}
					case 2: 
					{
						if (GetPlayerAliveCount(2) >= 4)
						{
							int iTeam = 0;
							int iRed = 0;
							int iBlue = 0;
							int iGreen = 0;
							int iPurple = 0;
							
							for (int i = 1; i <= MaxClients; ++i)
							{
								if (IsClientInGame(i) && IsPlayerAlive(i) && GetClientTeam(i) == 2 && !gB_Freeday[i])
								{
									++iTeam;
									
									switch (iTeam)
									{
										case 1:
										{
											++iRed;
											gI_ClientStatus[i] = COLOR_RED;
											SetGlow(i, 255, 0, 0, 255);
											FadePlayer(i, 300, 300, 0x0001, {255, 0, 0, 100});
											PrintToChat(i, "%sYou are on the \x02Red\x01 Team!", JB_TAG);
										}
										case 2:
										{
											++iBlue;
											gI_ClientStatus[i] = COLOR_BLUE;
											SetGlow(i, 0, 0, 255, 255);
											FadePlayer(i, 300, 300, 0x0001, {0, 0, 255, 100});
											PrintToChat(i, "%sYou are on the \x0BBlue\x01 Team!", JB_TAG);
										}
										case 3:
										{
											++iGreen;
											gI_ClientStatus[i] = COLOR_GREEN;
											SetGlow(i, 0, 255, 0, 255);
											FadePlayer(i, 300, 300, 0x0001, {0, 255, 0, 100});
											PrintToChat(i, "%sYou are on the \x04Green\x01 Team!", JB_TAG);
										}
										case 4:
										{
											++iPurple;
											iTeam = 0;	
											gI_ClientStatus[i] = COLOR_PURPLE;
											SetGlow(i, 255, 0, 255, 255);
											FadePlayer(i, 300, 300, 0x0001, {255, 0, 255, 100});
											PrintToChat(i, "%sYou are on the \x03Purple\x01 Team!", JB_TAG);
										}
									}
								}
							}	
						}
					}
				}
				PrintToChatAll("%s\x0B%N\x01 has split the \x09Prisoners\x01 into \x04%i\x01 Teams!", JB_TAG, client, iParam + 2);
				OpenToolsMenu(client);
			}
		}
		case MenuAction_Cancel: if (iParam == MenuCancel_ExitBack && Checker(client, true, 3, false)) OpenGlowMenu(client);
		case MenuAction_End: delete hMenu;
	}
}

void OpenWardenMenu(int client)
{
	Menu hMenu = new Menu(Menu_Warden);
	hMenu.SetTitle("[Jailbreak] Warden Menu\n ");
	hMenu.AddItem("", "Transfer Warden");
	hMenu.AddItem("", "Voice Activation");
	hMenu.AddItem("", "Paint Privilege");
	hMenu.AddItem("", "Mini Games");
	hMenu.AddItem("", "Free Day");
	hMenu.AddItem("", "Special Days");
	hMenu.ExitBackButton = true;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_Warden(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (Checker(client, true, 3, true))
			{
				switch (iParam)
				{
					case 0: OpenTransferWardenMenu(client);
					case 1: OpenVoiceMenu(client);
					case 2: OpenPaintMenu(client);
					case 3: OpenMiniGamesMenu(client);
					case 4: 
					{
						if (gB_Expired)
						{
							PrintToChat(client, "%sThe cells are already opened!", JB_TAG);
							OpenWardenMenu(client);
							return;	
						}
						else if (gI_Freedays > 0)
						{
							PrintToChat(client, "%sThere is a player with a \x09Freeday\x01!", JB_TAG);
							OpenWardenMenu(client);
							return;	
						}
						
						gB_FreeDay = true;
						gB_Cells = true;
						++gI_Cells;
						Cells(true);
						gCV_Radar.SetInt(1);
				
						for (int i = 1; i <= MaxClients; ++i)
						{
							if (IsClientInGame(i))
							{
								PrintToChat(i, "%s\x0B%N\x01 has started a \x09Freeday\x01!", JB_TAG, client);
								PrintCenterText(i, "<font color='#FFFF00'>It's a Freeday!</font>");
								
								if (gB_BaseComm)
								{
									if (!BaseComm_IsClientMuted(i))
										SetClientListeningFlags(i, VOICE_NORMAL);
								}
								else SetClientListeningFlags(i, VOICE_NORMAL);
								
								if (IsPlayerAlive(i))
								{
									FadePlayer(i, 300, 300, 0x0001, {255, 255, 102, 100});
									
									if (GetClientTeam(i) == 2)
										SetGlow(i, 255, 255, 0, 255);		
								}									
							}
						}
					}
					case 5:
					{
						if (GetPlayerAliveCount(2) < SPECIALDAYMINPLAYERS)
						{
							PrintToChat(client, "%sThere must be at least \x04%i \x09Prisoner \x01alive!", JB_TAG, SPECIALDAYMINPLAYERS);
							OpenWardenMenu(client);
						}
						else if (gI_DayDelay > gI_Round)
						{
							PrintToChat(client, "%sNext Special Day avaliable in \x04%i\x01 Round%s!", JB_TAG, gI_DayDelay - gI_Round, (gI_DayDelay - gI_Round > 1)? "s":"");
							OpenWardenMenu(client);
						}
						else if (gB_Expired)
						{
							PrintToChat(client, "%sThe cells are already opened!", JB_TAG);
							OpenWardenMenu(client);
							return;	
						}
						else if (gI_Freedays > 0)
						{
							PrintToChat(client, "%sThere is a player with a \x09Freeday\x01!", JB_TAG);
							OpenWardenMenu(client);
							return;	
						}
						else OpenDayMenu(client);
					}
				}
			}
		}
		case MenuAction_Cancel: if (iParam == MenuCancel_ExitBack && Checker(client, false, 3, false)) OpenGuardsMenu(client);
		case MenuAction_End: delete hMenu;
	}
}

void OpenTransferWardenMenu(int client)
{
	Menu hMenu = new Menu(Menu_TransferWarden);
	hMenu.SetTitle("[Jailbreak] Warden Transfer\n ");

	char[] sDisplayString = new char[MAX_NAME_LENGTH];
	char[] sInfoString = new char[5];

	for (int i = 1; i <= MaxClients; ++i)
	{
		if (IsClientInGame(i) && IsPlayerAlive(i) && GetClientTeam(i) == 3 && i != client)
		{
			FormatEx(sDisplayString, MAX_NAME_LENGTH, "%N", i);
			FormatEx(sInfoString, 5, "%i", GetClientUserId(i));
			hMenu.AddItem(sInfoString, sDisplayString);
		}
	}
	
	if (hMenu.ItemCount == 0) 
	{
		PrintToChat(client, "%sThere are no \x0BGuards\x01 to Select!", JB_TAG);
		delete hMenu;
		OpenWardenMenu(client);
		return;
	}
	hMenu.ExitBackButton = true;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_TransferWarden(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (Checker(client, true, 3, true))
			{
				char[] sInfo = new char[MAX_NAME_LENGTH];
				hMenu.GetItem(iParam, sInfo, MAX_NAME_LENGTH);
				
				int target = GetClientOfUserId(StringToInt(sInfo));
				
				if (IsValidClient(target) && IsPlayerAlive(target) && GetClientTeam(target) == 3)
				{
					gB_Paint[client] = false;
					SetGlow(client, 255, 255, 255, 255);
					gI_Warden = target;
					SetGlow(target, 0, 0, 255, 255);
					gB_Paint[target] = true;
					FadePlayer(target, 300, 300, 0x0001, {0, 0, 255, 100});
					CS_SetClientClanTag(client, "");
					CS_SetClientClanTag(target, "[Warden]"); 
					PrintToChatAll("%s\x0B%N \x01gave \x0B%N\x01 Warden!", JB_TAG, client, target);
					PrintCenterText(target, "You are the <font color='#0066ff'>Warden</font>!");
				}
			}
		}
		case MenuAction_Cancel: if (iParam == MenuCancel_ExitBack && Checker(client, true, 3, true)) OpenWardenMenu(client);
		case MenuAction_End: delete hMenu;
	}
}

void OpenVoiceMenu(int client)
{
	Menu hMenu = new Menu(Menu_Voice);
	hMenu.SetTitle("[Jailbreak] Voice Menu\n ");
	hMenu.AddItem("", "Allow All");
	hMenu.AddItem("", "Mute All");
	
	char[] sDisplayString = new char[MAX_NAME_LENGTH];
	char[] sInfoString = new char[5];
	
	for (int i = 1; i <= MaxClients; ++i)
	{
		if (IsClientInGame(i) && IsPlayerAlive(i) && GetClientTeam(i) == 2)
		{
			FormatEx(sDisplayString, MAX_NAME_LENGTH, "%N [%s]", i, (GetClientListeningFlags(i) == VOICE_MUTED)? "Muted":"Allowed");
			FormatEx(sInfoString, 5, "%i", GetClientUserId(i));
			hMenu.AddItem(sInfoString, sDisplayString, (CheckCommandAccess(i, "sm_ban", ADMFLAG_BAN))? ITEMDRAW_DISABLED:ITEMDRAW_DEFAULT);
		}
	}
	
	if (hMenu.ItemCount == 2) 
	{
		PrintToChat(client, "%sThere are no \x09Prisoners\x01 to Select!", JB_TAG);
		delete hMenu;
		OpenWardenMenu(client);
		return;
	}

	hMenu.ExitBackButton = true;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_Voice(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (Checker(client, true, 3, true))
			{			
				switch (iParam)
				{		
					case 0:
					{
						for (int i = 1; i <= MaxClients; ++i)
						{
							if (IsClientInGame(i) && IsPlayerAlive(i) && GetClientTeam(i) == 2)
							{
								if (gB_BaseComm)
								{
									if (!BaseComm_IsClientMuted(i))
										SetClientListeningFlags(i, VOICE_NORMAL);
								}
								else SetClientListeningFlags(i, VOICE_NORMAL);
							}
						}
						
						PrintToChatAll("%s\x0B%N \x01has \x04gave\x01 all \x09Prisoners\x01 the power to speak!", JB_TAG, client);
						return;	
					}
					case 1:
					{
						for (int i = 1; i <= MaxClients; ++i)
						{
							if (IsClientInGame(i) && IsPlayerAlive(i) && GetClientTeam(i) == 2 && !CheckCommandAccess(i, "sm_kick", ADMFLAG_CUSTOM1))
								SetClientListeningFlags(i, VOICE_MUTED);
						}
						
						PrintToChatAll("%s\x0B%N \x01has \x02muted\x01 all \x09Prisoners\x01!", JB_TAG, client);
						return;
					}
				}
				
				char[] sInfo = new char[MAX_NAME_LENGTH];
				hMenu.GetItem(iParam, sInfo, MAX_NAME_LENGTH);
				
				int target = GetClientOfUserId(StringToInt(sInfo));
				
				if (IsValidClient(target) && IsPlayerAlive(target))
				{	
					switch (GetClientListeningFlags(target))
					{
						case VOICE_NORMAL:
						{
							SetClientListeningFlags(target, VOICE_MUTED);
							PrintToChat(target, "%sYou are \x02not allowed\x01 speak anymore!", JB_TAG);
							PrintToChatAll("%s\x0B%N \x01has \x02removed \x09%N\x01 the power to speak!", JB_TAG, client, target);
						}
						case VOICE_MUTED:
						{
							SetClientListeningFlags(target, VOICE_NORMAL);
							PrintToChat(target, "%sYou are \x04allowed\x01 to speak!", JB_TAG);
							PrintToChatAll("%s\x0B%N \x01has \x04gave \x09%N\x01 the power to speak!", JB_TAG, client, target);
						}
					}
				}
				OpenVoiceMenu(client);
			}
		}
		case MenuAction_Cancel: if (iParam == MenuCancel_ExitBack && Checker(client, true, 3, true)) OpenWardenMenu(client);
		case MenuAction_End: delete hMenu;
	}
}

void OpenPaintMenu(int client)
{
	Menu hMenu = new Menu(Menu_Paint);
	hMenu.SetTitle("[Jailbreak] Paint Privilege\n ");

	char[] sDisplayString = new char[MAX_NAME_LENGTH];
	char[] sInfoString = new char[5];

	for (int i = 1; i <= MaxClients; ++i)
	{
		if (IsClientInGame(i) && IsPlayerAlive(i) && i != client)
		{			
			FormatEx(sDisplayString, MAX_NAME_LENGTH + 7, "%N [%s]", i, (gB_Paint[i])? "Yes":"No");
			FormatEx(sInfoString, 5, "%i", GetClientUserId(i));
			hMenu.AddItem(sInfoString, sDisplayString);
		}
	}
	
	if (hMenu.ItemCount == 0) 
	{
		PrintToChat(client, "%sThere are no Players to Select!", JB_TAG);
		delete hMenu;
		OpenWardenMenu(client);
		return;
	}
	hMenu.ExitBackButton = true;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_Paint(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (Checker(client, true, 3, true))
			{
				char[] sInfo = new char[MAX_NAME_LENGTH];
				hMenu.GetItem(iParam, sInfo, MAX_NAME_LENGTH);
				
				int target = GetClientOfUserId(StringToInt(sInfo));
				
				if (IsValidClient(target) && IsPlayerAlive(target))
				{
					gB_Paint[target] = !gB_Paint[target];
					
					if (gB_Paint[target])
						PrintToChatAll("%s\x0B%N \x01has \x06gave \x09%N\x01 Paint Privilege!", JB_TAG, client, target);
					else 
						PrintToChatAll("%s\x0B%N \x01has \x02removed \x09%Ns\x01 Paint Privilege!", JB_TAG, client, target);
				}
				
				OpenPaintMenu(client);
			}
		}
		
		case MenuAction_Cancel: if (iParam == MenuCancel_ExitBack && Checker(client, true, 3, true)) OpenWardenMenu(client);
		case MenuAction_End: delete hMenu;
	}
}

void OpenMiniGamesMenu(int client)
{
	char[] sFormat = new char[50];
	Menu hMenu = new Menu(Menu_MiniGames);
	
	int iPlayers = GetPlayerAliveCount(2);
	hMenu.SetTitle("[Jailbreak] Mini Games\n ");
	
	FormatEx(sFormat, 50, "FriendlyFire [%s]", (gCV_FriendlyFire.BoolValue)? "Enabled":"Disabled");
	hMenu.AddItem("", sFormat);
	
	FormatEx(sFormat, 50, "Collision [%s]", (gCV_Block.BoolValue)? "Enabled":"Disabled");
	hMenu.AddItem("", sFormat);
	
	FormatEx(sFormat, 50, "Bump & Shove [%s]", (gB_Shove)? "Enabled":"Disabled");
	hMenu.AddItem("", sFormat);
	
	FormatEx(sFormat, 50, "Death Ball [%s]", (gB_DeathBall)? "Enabled":"Disabled");
	hMenu.AddItem("", sFormat);
	
	hMenu.AddItem("", "Knife Duel", (iPlayers - gI_Freedays < 2)? ITEMDRAW_DISABLED:ITEMDRAW_DEFAULT);
	hMenu.AddItem("", "Ticking Time Bomb", (iPlayers - gI_Freedays < 2)? ITEMDRAW_DISABLED:ITEMDRAW_DEFAULT);
	hMenu.ExitBackButton = true;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_MiniGames(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (Checker(client, true, 3, true))
			{
				switch (iParam)
				{
					case 0:
					{				
						gCV_FriendlyFire.BoolValue = !gCV_FriendlyFire.BoolValue;
						
						for (int i = 1; i <= MaxClients; ++i)
						{
							if (IsClientInGame(i))
							{
								PrintToChat(i, "%s\x0B%N \x01has %s \x01Friendly Fire!", JB_TAG, client, (gCV_FriendlyFire.BoolValue)? "\x04Enabled":"\x02Disabled");
								ClientCommand(i, "play %s", (gCV_FriendlyFire.BoolValue)? SOUND_MG_ON:SOUND_MG_WHISTLE);
							}
						}
					}
					case 1:
					{
						gCV_Block.BoolValue = !gCV_Block.BoolValue;
						
						for (int i = 1; i <= MaxClients; ++i)
						{
							if (IsClientInGame(i))
							{
								PrintToChat(i, "%s\x0B%N \x01has %s \x01Team Collision!", JB_TAG, client, (gCV_Block.BoolValue)? "\x04Enabled":"\x02Disabled");
								ClientCommand(i, "play %s", (gCV_Block.BoolValue)? SOUND_MG_ON:SOUND_MG_WHISTLE);
									
							}
						}
					}
					case 2:
					{		
						gB_Shove = !gB_Shove;						

						for (int i = 1; i <= MaxClients; ++i)
						{
							if (IsClientInGame(i))
							{
								PrintToChat(i, "%s\x0B%N \x01has %s \x01Bump & Shove!", JB_TAG, client, (!gB_Shove) ? "\x02Disabled":"\x04Enabled");
								ClientCommand(i, "play %s", (gB_Shove)? SOUND_MG_ON:SOUND_MG_WHISTLE);
							}
						}
					}
					case 3:
					{
						gB_DeathBall = !gB_DeathBall;	

						if (gB_DeathBall)
							gI_BallHolder = client;	
							
						for (int i = 1; i <= MaxClients; ++i)
						{
							if (IsClientInGame(i))
							{
								PrintToChat(i, "%s\x0B%N \x01has %s \x01Death Ball!", JB_TAG, client, (!gB_DeathBall) ? "\x02Disabled":"\x04Enabled");
								ClientCommand(i, "play %s", (gB_DeathBall)? SOUND_MG_ON:SOUND_MG_WHISTLE);
							}
						}
					}
					case 4: 
					{
						if (gB_KnifeDuel)
						{
							gB_KnifeDuel = false;
							gCV_FriendlyFire.SetInt(0);
							
							for (int i = 1; i <= MaxClients; ++i)
							{
								if (IsClientInGame(i))
								{
									PrintToChat(i, "%s\x0B%N\x01 has \x02ended\x01 the Knife duel!", JB_TAG, client);
									ClientCommand(i, "play %s", SOUND_MG_WHISTLE);
									
									if (GetClientTeam(i) == 2 && !gB_Freeday[i])
									{
										SetGlow(i, 255, 255, 255, 255);
										gI_ClientStatus[i] = -1;
									}
								}
							}
						}
						else
						{
							if (GetPlayerAliveCount(2) - gI_Freedays >= 2)
							{
								bool bPlayers = false;
								
								int iPlayer = -1;
								int iPlayer2 = -1;
								
								for (int i = 1; i <= MaxClients; ++i)
								{
									if (IsClientInGame(i))
									{
										PrintToChat(i, "%s\x0B%N\x01 has \x04started\x01 a Knife duel!", JB_TAG, client);
										ClientCommand(i, "play %s", SOUND_MG_ON);
										
										if (IsPlayerAlive(i) && GetClientTeam(i) == 2 && !gB_Freeday[i])
										{
											if (bPlayers)
											{
												gI_ClientStatus[i] = COLOR_RED;
												SetGlow(i, 255, 0, 0, 255);
												iPlayer = i;
												FadePlayer(i, 300, 300, 0x0001, {255, 0, 0, 100});
												break;
											}
											else
											{
												bPlayers = true;
												gI_ClientStatus[i] = COLOR_BLUE;
												SetGlow(i, 0, 0, 255, 255);
												iPlayer2 = i;
												FadePlayer(i, 300, 300, 0x0001, {0, 0, 255, 100});
											}
										}
									}
								}
								gB_KnifeDuel = true;
								gCV_FriendlyFire.SetInt(1);
								PrintToChatAll("%sKnife Duel: \x09%N\x01 vs \x09%N", JB_TAG, iPlayer, iPlayer2);
								
								DataPack hPack = new DataPack(); 								
								CreateDataTimer(0.1, Timer_KnifeDuel, hPack, TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
								hPack.WriteCell(GetClientUserId(iPlayer)); 
								hPack.WriteCell(GetClientUserId(iPlayer2)); 
								hPack.Reset(); 
							}
							else PrintToChat(client, "%sNot enough \x09Prisoners\x01 alive to start a knife duel!", JB_TAG);
						}
					}
					case 5: 
					{
						if (gB_TickingTimeBomb)
						{
							gB_TickingTimeBomb = false;
							gI_Prisoner = -1;
							
							for (int i = 1; i <= MaxClients; ++i)
							{
								if (IsClientInGame(i))
								{
									PrintToChat(i, "%s\x0B%N\x01 has \x02ended\x01 the Ticking Time Bomb!", JB_TAG, client);
									ClientCommand(i, "play %s", SOUND_MG_WHISTLE);
									
									if (IsPlayerAlive(i) && GetClientTeam(i) == 2 && !gB_Freeday[i])
										SetGlow(i, 255, 255, 255, 255);
								}
							}
						}
						else 
						{
							if (GetPlayerAliveCount(2) - gI_Freedays >= 2)
							{
								gI_Prisoner = GetRandomClient(2);
								gB_TickingTimeBomb = true;
								
								for (int i = 1; i <= MaxClients; ++i)
								{
									if (IsClientInGame(i))
									{
										PrintToChat(i, "%s\x0B%N\x01 has started a Ticking Time Bomb!", JB_TAG, client);
										ClientCommand(i, "play %s", SOUND_MG_ON);
										
										if (IsPlayerAlive(i) && GetClientTeam(i) == 2 && !gB_Freeday[i])
											SetGlow(i, 255, 255, 255, 255);
									}
								}
								
								PrintCenterTextAll("<font color='#f45942'>%N</font> has the bomb!", gI_Prisoner);
								SetGlow(gI_Prisoner, 255, 0, 0, 255);
								FadePlayer(gI_Prisoner, 300, 300, 0x0001, {255, 0, 0, 100});
								CreateTimer(1.0, Timer_TickingTimeBombInterval, GetGameTime() + 10, TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
								EmitSoundToAll(SOUND_C4_1, gI_Prisoner, SNDCHAN_BODY);
							}
							else PrintToChat(client, "%sNot enough \x09Prisoners\x01 alive to start a Ticking Time Bomb!", JB_TAG);
						}
					}
				}
				OpenMiniGamesMenu(client);
			}
		}
		case MenuAction_Cancel: if (iParam == MenuCancel_ExitBack && Checker(client, true, 3, true)) OpenWardenMenu(client);
		case MenuAction_End: delete hMenu;
	}
} 

void OpenDayMenu(int client)
{
	Menu hMenu = new Menu(Menu_Day);
	hMenu.SetTitle("[Jailbreak] Special Days\n ");
	hMenu.AddItem("", "Knife Battle");
	hMenu.AddItem("", "Kill Confirmed");
	hMenu.AddItem("", "Gang War");
	hMenu.AddItem("", "No Scope");
	hMenu.AddItem("", "Scoutzknivez");
	hMenu.AddItem("", "One in a Chamber");
	hMenu.AddItem("", "Nade War");
	hMenu.AddItem("", "Headshot");
	hMenu.AddItem("", "Jedi");
	hMenu.AddItem("", "Shark");
	hMenu.AddItem("", "NightCrawler");
	hMenu.AddItem("", "Cocktail Party");
	hMenu.AddItem("", "Trigger Discipline");
	hMenu.AddItem("", "Gun Game");
	hMenu.AddItem("", "Special Day Vote");
	hMenu.ExitBackButton = true;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_Day(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (Checker(client, true, 3, true, true) && !gB_Expired && gI_Freedays == 0 && gI_DayDelay <= gI_Round)
			{
				gH_SpecialDay = view_as<SpecialDay>(iParam);
				EnableSpecialDay(client);
			}
		}
		case MenuAction_Cancel: if (iParam == MenuCancel_ExitBack && Checker(client, true, 3, true)) OpenWardenMenu(client);
		case MenuAction_End: delete hMenu;
	}
}

public int Menu_VotingDay(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	if (hAction == MenuAction_Select && IsValidClient(client))
	{
		char[] sInfo = new char[MAX_NAME_LENGTH];
		hMenu.GetItem(iParam, sInfo, MAX_NAME_LENGTH);
		PrintToChat(client, "%sYou have voted for \x0C%s", JB_TAG, sInfo);
		gI_ClientVote[client] = iParam;
	}
}

void OpenPrisonerMenu(int client)
{
	Menu hMenu = new Menu(Menu_PrisonerMenu);
	hMenu.SetTitle("[Jailbreak] Prisoners Menu\n ");
	hMenu.AddItem("", "Black Market");
	hMenu.AddItem("", "Last Request");
	hMenu.AddItem("", "Gangs");
	hMenu.AddItem("", "Bounty");
	hMenu.AddItem("", "Casino");
	hMenu.AddItem("", "Settings & Stats");
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_PrisonerMenu(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client) && GetClientTeam(client) == 2)
			{
				switch (iParam)
				{
					case 0: OpenStoreMenu(client);
					case 1: Cmd_LastRequest(client, 0);
					case 2: StartOpeningGangMenu(client);
					case 3: OpenBountyMenu(client);
					case 4:	OpenCasinoMenu(client);
					case 5:	OpenSettingsMenu(client);
				}
			}
		}
		case MenuAction_End: delete hMenu;
	}
}

void OpenSpectatorMenu(int client)
{
	Menu hMenu = new Menu(Menu_Spectator);
	hMenu.SetTitle("[Jailbreak] Spectators Menu\n ");
	hMenu.AddItem("", "Bounty");
	hMenu.AddItem("", "Casino");
	hMenu.AddItem("", "Settings & Stats\n ");
	hMenu.AddItem("", "Join Prisoners");
	hMenu.AddItem("", "Join Guards");
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_Spectator(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client) && GetClientTeam(client) == 1)
			{
				switch (iParam)
				{
					case 0: OpenBountyMenu(client);
					case 1:	OpenCasinoMenu(client);
					case 2:	OpenSettingsMenu(client);
					case 3: ChangeClientTeam(client, 2);
					case 4:
					{
						switch (gI_ClientBan[client])
						{
							case -1: {}
							case -2: 
							{
								PrintToChat(client, "[SM] You are banned from joining the \x0BGuard's\x01 Team!");
								PrintToChat(client, "[SM] [Time left: \x02Forever\x01]");
								ClientCommand(client, "play buttons/button11.wav");
								OpenSpectatorMenu(client);
								return;
							}	
							default: 
							{
								char[] sBuffer = new char[70];
								int iTimeLeft = gI_ClientBan[client];
								int iBan = iTimeLeft - GetTime();
								
								if (iBan < 1)
								{
									RemoveGuardBan(client);
									PrintToChat(client, "[SM] You are now unbanned! Becareful not to try to break the rules!");
								}
								else
								{
									SecondsToTime(iBan, sBuffer);
									PrintToChat(client, "[SM] You are banned from joining the \x0BGuard's\x01 Team!");
									PrintToChat(client, "[SM] [Time left: \x04%s\x01]", sBuffer);
									ClientCommand(client, "play buttons/button11.wav");
									OpenSpectatorMenu(client);
									return;
								}
							}
						}
						
						if (gB_Ratio)
						{
							PrintToChat(client, "%sYou cannot become a \x0BGuard\x01 due to Ratio!", JB_TAG);
							ClientCommand(client, "play buttons/button11.wav");
							OpenSpectatorMenu(client);
						}
						else SecurityCheck(client);
					}
					case 5: Cmd_Rules(client, 0);
				}
			}
		}
		case MenuAction_End: delete hMenu;
	}
}

void JailbreakMenu(int client, bool bBackButton = false)
{
	Menu hMenu = new Menu(Menu_Jailbreak);
	hMenu.SetTitle("Jailbreak Menu\n ");
	hMenu.AddItem("", "Ball Menu");
	hMenu.AddItem("", "Celldoor Button");
	hMenu.AddItem("", "Guard Only Buttons");
	hMenu.AddItem("", "Jail Door Status");
	hMenu.AddItem("", "Smart Jail Doors");
	hMenu.AddItem("", "Entity Terminator");
	hMenu.AddItem("", "Taser Spawn");
	hMenu.AddItem("", "Special Day Spawns");
	hMenu.ExitBackButton = bBackButton;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_Jailbreak(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client))
			{
				if (IsPlayerAlive(client))
				{
					switch(iParam)
					{
						case 0: BallMenu(client);
						case 1: EntityMenu(client, "0");
						case 2: EntityMenu(client, "1");
						case 3: EntityMenu(client, "3");
						case 4: FakeClientCommandEx(client, "sm_sjd");
						case 5: EntityMenu(client, "2");
						case 6: OpenTaserTeleportMenu(client);
						case 7: OpenSpecialDaySpawnsMenu(client);
					}
				}
				else PrintToChat(client, "[SM] You must be alive!");
			}
		}
		case MenuAction_Cancel: if (iParam == MenuCancel_ExitBack && gT_TopMenu != null && IsValidClient(client)) gT_TopMenu.Display(client, TopMenuPosition_LastCategory);
		case MenuAction_End: delete hMenu;
	}
}

void BallMenu(int client)
{
	Menu hMenu = new Menu(Menu_Ball);
	hMenu.SetTitle("Ball Menu\n ");
	hMenu.AddItem("", "Remove Ball");
	hMenu.AddItem("", "Add Ball");
	hMenu.AddItem("", "Reset Ball");
	hMenu.AddItem("", "Add Goal Zone");
	hMenu.AddItem("", "Display Zones");
	hMenu.AddItem("", "Delete Zones", (gI_Zones > -1) ? ITEMDRAW_DEFAULT:ITEMDRAW_DISABLED);
	hMenu.ExitBackButton = true;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_Ball(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client) && IsPlayerAlive(client))
			{
				switch(iParam)
				{
					case 0:
					{
						if (gB_BallSpawnExists)
						{						
							KeyValues kv = new KeyValues("Spawns");
							char[] sPath = new char[PLATFORM_MAX_PATH];
							BuildPath(Path_SM, sPath, PLATFORM_MAX_PATH, "configs/jailbreak/ballspawns.cfg");
							kv.ImportFromFile(sPath);
							
							if (kv.JumpToKey(gS_Map, false))
							{
								kv.DeleteThis();
								kv.Rewind();
								kv.ExportToFile(sPath);
								
								DestroyBall();
								gI_BallHolder = 0;
								gB_BallSpawnExists = false;
								PrintToChat(client, "[SM] The Ball has been removed.");
							}
							else PrintToChat(client, "[SM] The Ball Spawn file failed to open...");
							delete kv;
						}
						else PrintToChat(client, "[SM] There is no Ball to remove.");
					}
					case 1:
					{		
						if (gB_BallSpawnExists)									
							DestroyBall();
	
						gI_BallHolder = 0;
						gB_BallSpawnExists = false;
						
						KeyValues kv = new KeyValues("Spawns");
						char[] sPath = new char[PLATFORM_MAX_PATH];
						BuildPath(Path_SM, sPath, PLATFORM_MAX_PATH, "configs/jailbreak/ballspawns.cfg");
						kv.ImportFromFile(sPath);
						
						if (kv.JumpToKey(gS_Map, true))
						{
							float fOrigin[3];
							GetPlayerEyeViewPoint(client, fOrigin);
							fOrigin[2] += 20.0;
							
							kv.SetFloat("x", fOrigin[0]);
							kv.SetFloat("y", fOrigin[1]);
							kv.SetFloat("z", fOrigin[2]);
							
							gF_BallSpawnOrigin = fOrigin;
							gB_BallSpawnExists = true;
					
							RespawnBall();
							PrintToChat(client, "[SM] The Ball has been added.");
							kv.Rewind();
							kv.ExportToFile(sPath);
						}
						else PrintToChat(client, "[SM] The Ball file failed to open...");
						delete kv;
					}
					case 2:
					{
						if (gB_BallSpawnExists)
						{
							RespawnBall();
							PrintToChat(client, "[SM] The Ball has been resetted.");
						}
						else PrintToChat(client, "[SM] There is no Ball to reset.");
					}
					case 3:
					{
						if (gI_Zones + 1 < MAXZONELIMIT)
						{
							gI_TempZone = gI_Zones + 1;
							
							for (int i = 0; i < 3; ++i)		
							{						
								gF_ZonePoint1[gI_TempZone][i] = 0.0;
								gF_ZonePoint2[gI_TempZone][i] = 0.0;
							}
							
							CreateTimer(0.1, Timer_GoalZoneBuilding, INVALID_HANDLE, TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
							PrintToChat(client, "[SM] Press & Hold \x04MOUSE1\x01 or \x04MOUSE2\x01 to place zone points!");	
							PrintToChat(client, "[SM] Press \x04E\x01 to stop the zone from moving!");
						}
						else PrintToChat(client, "[SM] The Goal Zones limit has been reached!");
					}
					case 4:
					{
						if (gI_Zones > -1)
						{
							PrintToChat(client, "[SM] All the Existing Goal Zones are now visible!");
							CreateTimer(1.0, Timer_DrawEveryZone, GetClientUserId(client), TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
						}
						else PrintToChat(client, "[SM] There are no Goal Zones spawned on this map!");						
					}
					case 5:
					{
						if (gI_Zones > -1)
						{
							Menu hMenu2 = new Menu(Menu_DeleteZones);
							hMenu2.SetTitle("Goal Zone Deletion\n ");
							
							char[] sFormat = new char[32];
							
							for (int i = 0; i <= gI_Zones; ++i)
							{
								FormatEx(sFormat, 32, "Zone %i", i);
								hMenu2.AddItem("", sFormat);								
							}
							
							if (hMenu2.ItemCount == 0) 
							{
								PrintToChat(client, "[SM] There are no Zones to delete!");
								delete hMenu2;
								BallMenu(client);
								return;
							}
							
							hMenu2.ExitBackButton = true;
							hMenu2.Display(client, MENU_TIME_FOREVER);
							return;
						}
						else PrintToChat(client, "[SM] There are no Goal Zones spawned on this map!");						
					}
				}
				BallMenu(client);
			}
		}
		case MenuAction_Cancel:
		{
			if (iParam == MenuCancel_ExitBack && IsValidClient(client))
			{
				if (IsPlayerAlive(client))				
					JailbreakMenu(client);
				else
					PrintToChat(client, "[SM] You must be alive to access the menu!");
			}
		}
		case MenuAction_End: delete hMenu;
	}
}

void OpenZoneMenu(int client, int iPage = 0)
{
	Menu hMenu = new Menu(Menu_Zones);
	hMenu.SetTitle("Goal Zone Edit\n ");

	hMenu.AddItem("", "Create Zone");
	hMenu.AddItem("", "Cancel Zone");

	hMenu.AddItem("", "Point 1 | X axis +5.0");
	hMenu.AddItem("", "Point 1 | X axis -5.0");

	hMenu.AddItem("", "Point 1 | Y axis +5.0");
	hMenu.AddItem("", "Point 1 | Y axis -5.0");

	hMenu.AddItem("", "Point 1 | Z axis +5.0");
	hMenu.AddItem("", "Point 1 | Z axis -5.0");

	hMenu.AddItem("", "Point 2 | X axis +5.0");
	hMenu.AddItem("", "Point 2 | X axis -5.0");

	hMenu.AddItem("", "Point 2 | Y axis +5.0");
	hMenu.AddItem("", "Point 2 | Y axis -5.0");

	hMenu.AddItem("", "Point 2 | Z axis +5.0");
	hMenu.AddItem("", "Point 2 | Z axis -5.0");
	
	hMenu.ExitButton = false;
	hMenu.DisplayAt(client, iPage, MENU_TIME_FOREVER);
}

public int Menu_Zones(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client))
			{
				switch (iParam)
				{
					case 0: 
					{
						KeyValues kv = new KeyValues("Zones");
						char[] sPath = new char[PLATFORM_MAX_PATH];
						BuildPath(Path_SM, sPath, PLATFORM_MAX_PATH, "configs/jailbreak/goalzones.cfg");
						kv.ImportFromFile(sPath);
						
						if (kv.JumpToKey(gS_Map, true))
						{	
							char[] sFormat = new char[100];							
							FormatEx(sFormat, 100, "Zone %i", gI_TempZone);
							
							if (kv.JumpToKey(sFormat, true))		
							{							
								kv.SetFloat("x1", gF_ZonePoint1[gI_TempZone][0]);
								kv.SetFloat("y1", gF_ZonePoint1[gI_TempZone][1]);
								kv.SetFloat("z1", gF_ZonePoint1[gI_TempZone][2]);
								kv.SetFloat("x2", gF_ZonePoint2[gI_TempZone][0]);
								kv.SetFloat("y2", gF_ZonePoint2[gI_TempZone][1]);
								kv.SetFloat("z2", gF_ZonePoint2[gI_TempZone][2]);
								kv.Rewind();
								kv.ExportToFile(sPath);
								
								++gI_Zones;
								PrintToChat(client, "[SM] The Goal Zone has successfully been created!");
							}
							else PrintToChat(client, "[SM] The Goal Zone failed to save...");
						}
						else PrintToChat(client, "[SM] The Goal Zone file failed to be open...");
						delete kv;
						
						gI_GoalZoneCreator = -1;
					}
					case 1: 
					{
						gI_GoalZoneCreator = -1;		
						
						for (int i = 0; i < 3; ++i)
						{
							gF_ZonePoint1[gI_TempZone][i] = 0.0;
							gF_ZonePoint2[gI_TempZone][i] = 0.0;											
						}

						PrintToChat(client, "[SM] You canceled the goal zone!");	
						return;						
					}
					case 2:
					{
						gF_ZonePoint1[gI_TempZone][0] += 5.0;
						PrintToChat(client, "\x03X\x01 axis \x0A(point 1) \x04increased\x01 by \x035 units");
					}
					case 3:
					{
						gF_ZonePoint1[gI_TempZone][0] -= 5.0;
						PrintToChat(client, "\x03X\x01 axis \x0A(point 1) \x02reduced\x01 by \x035 units");
					}
					case 4:
					{
						gF_ZonePoint1[gI_TempZone][1] += 5.0;
						PrintToChat(client, "\x03Y\x01 axis \x0A(point 1) \x04increased\x01 by \x035 units");
					}
					case 5:
					{
						gF_ZonePoint1[gI_TempZone][1] -= 5.0;
						PrintToChat(client, "\x03Y\x01 axis \x0A(point 1) \x02reduced\x01 by \x035 units");
					}
					case 6:
					{
						gF_ZonePoint1[gI_TempZone][2] += 5.0;
						PrintToChat(client, "\x03Z\x01 axis \x0A(point 1) \x04increased\x01 by \x035 units");
					}
					case 7:
					{
						gF_ZonePoint1[gI_TempZone][2] -= 5.0;
						PrintToChat(client, "\x03Z\x01 axis \x0A(point 1) \x02reduced\x01 by \x035 units");
					}
					case 8:
					{
						gF_ZonePoint2[gI_TempZone][0] += 5.0;
						PrintToChat(client, "\x03X\x01 axis \x0A(point 2) \x04increased\x01 by \x035 units");
					}
					case 9:
					{
						gF_ZonePoint2[gI_TempZone][0] -= 5.0;
						PrintToChat(client, "\x03X\x01 axis \x0A(point 2) \x02reduced\x01 by \x035 units");
					}
					case 10:
					{
						gF_ZonePoint2[gI_TempZone][1] += 5.0;
						PrintToChat(client, "\x03Y\x01 axis \x0A(point 2) \x04increased\x01 by \x035 units");
					}
					case 11:
					{
						gF_ZonePoint2[gI_TempZone][1] -= 5.0;
						PrintToChat(client, "\x03Y\x01 axis \x0A(point 2) \x02reduced\x01 by \x035 units");
					}
					case 12:
					{
						gF_ZonePoint2[gI_TempZone][2] += 5.0;
						PrintToChat(client, "\x03Z\x01 axis \x0A(point 2) \x04increased\x01 by \x035 units");
					}
					case 13:
					{
						gF_ZonePoint2[gI_TempZone][2] -= 5.0;
						PrintToChat(client, "\x03Z\x01 axis \x0A(point 2) \x02reduced\x01 by \x035 units");
					}
				}
				OpenZoneMenu(client, GetMenuSelectionPosition());
			}
		}
		case MenuAction_End: delete hMenu;
	}
}

public int Menu_DeleteZones(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client))
			{
				KeyValues kv = new KeyValues("Zones");
				
				char[] sPath = new char[PLATFORM_MAX_PATH];
				BuildPath(Path_SM, sPath, PLATFORM_MAX_PATH, "configs/jailbreak/goalzones.cfg");
				kv.ImportFromFile(sPath);
				
				if (kv.JumpToKey(gS_Map, false))
				{
					char[] sFormat = new char[10];
					FormatEx(sFormat, 10, "Zone %i", iParam);
					
					if (kv.JumpToKey(sFormat, false))
					{
						kv.DeleteThis();
						kv.GoBack();
						PrintToChat(client, "%s You have successfully deleted \x02Zone %i", JB_TAG, iParam);
						
						switch (iParam)
						{
							case 0:
							{
								for (int i = 0; i < 3; ++i)		
								{						
									gF_ZonePoint1[0][i] = gF_ZonePoint1[1][i];
									gF_ZonePoint2[0][i] = gF_ZonePoint2[1][i];
									gF_ZonePoint1[1][i] = 0.0;
									gF_ZonePoint2[1][i] = 0.0;
								}
							}
							case 1:
							{	
								for (int i = 0; i < 3; ++i)		
								{						
									gF_ZonePoint1[1][i] = 0.0;
									gF_ZonePoint2[1][i] = 0.0;
								}
							}
						}
						gI_Zones--;
					}
					else PrintToChat(client, "%s The deletion failed...", JB_TAG);

					if (kv.JumpToKey("Zone 1", false))
						kv.SetSectionName("Zone 0");
					
					kv.Rewind();
					kv.ExportToFile(sPath);
				}
				else PrintToChat(client, "[SM] The Goal Zones file failed to open...");
				delete kv;
				BallMenu(client);
			}
		}
		case MenuAction_Cancel:
		{
			if (iParam == MenuCancel_ExitBack && IsValidClient(client))
			{
				if (IsPlayerAlive(client))				
					BallMenu(client);
				else
					PrintToChat(client, "[SM] You must be alive to access the menu!");
			}
		}
		case MenuAction_End: delete hMenu;
	}
}

void EntityMenu(int client, char[] sUsage)
{
	Menu hMenu = new Menu(Menu_Entity);
	
	switch (StringToInt(sUsage))
	{
		case 0: hMenu.SetTitle("Cell Door Buttons\n ");
		case 1: hMenu.SetTitle("Guard Only Buttons\n ");
		case 2: hMenu.SetTitle("Entity Terminator\n ");
		case 3: hMenu.SetTitle("Jail Door Status\n ");
	}
	
	hMenu.AddItem(sUsage, "Add Entity");
	hMenu.AddItem(sUsage, "Remove Entity");
	hMenu.ExitBackButton = true;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_Entity(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client) && IsPlayerAlive(client))
			{
				char[] sInfo = new char[3];
				hMenu.GetItem(iParam, sInfo, 3);
				
				switch (iParam)
				{
					case 0: 
					{
						switch (StringToInt(sInfo))
						{
							case 0:
							{
								CreateTimer(0.1, Timer_EntityDetection, 0, TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
								PrintToChat(client, "[SM] Aim and Press \x04E\x01 to Save the cell door button!");
							}
							case 1:
							{
								CreateTimer(0.1, Timer_EntityDetection, 1, TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
								PrintToChat(client, "[SM] Aim and Press \x04E\x01 to Save \x0BGuard Only\x01 buttons!");
							}
							case 2:
							{
								CreateTimer(0.1, Timer_EntityDetection, 2, TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
								PrintToChat(client, "[SM] Aim and Press \x04E\x01 to Delete an entity!");
							}
							case 3:
							{
								CreateTimer(0.1, Timer_EntityDetection, 3, TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
								PrintToChat(client, "[SM] Aim and Press \x04E\x01 to Save \x0BCell Door(s)\x01!");
								PrintToChat(client, "[SM] This will allow to properly detect the door's status!");
							}
						}
						
						gI_Owner = client;
						StopMenu(client);
					}
					case 1: RemoveEntityMenu(client, sInfo);
				}
			}
		}
		case MenuAction_Cancel:
		{
			if (iParam == MenuCancel_ExitBack && IsValidClient(client))
			{
				if (IsPlayerAlive(client))				
					JailbreakMenu(client);
				else
					PrintToChat(client, "[SM] You must be alive to access the menu!");
			}
		}
		case MenuAction_End: delete hMenu;
	}
}

void StopMenu(int client)
{
	Menu hMenu = new Menu(Menu_Stop);
	hMenu.SetTitle("Control Menu\n ");
	hMenu.AddItem("", "Aim and Press E on the object to save it", ITEMDRAW_DISABLED);
	hMenu.AddItem("", "Stop Detecting");
	hMenu.ExitButton = false;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_Stop(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client) && IsPlayerAlive(client) && gI_Owner == client && iParam == 1)
			{
				gI_Owner = -1;
				PrintToChat(client, "[SM] You have \x02Stopped\x01 the detection of entities!");
				JailbreakMenu(client);
			}
		}
		case MenuAction_Cancel: gI_Owner = -1;
		case MenuAction_End: delete hMenu;
	}
}

void RemoveEntityMenu(int client, char[] sUsage)
{
	Menu hMenu = new Menu(Menu_RemoveEntity);
	hMenu.SetTitle("Deletion Menu\n ");
	
	char[] sBuffer = new char[45];
	char[] sFormat = new char[50];
	char[] sPath = new char[PLATFORM_MAX_PATH];
	
	int iUsage = StringToInt(sUsage);
	
	switch (iUsage)
	{
		case 0, 1, 3:
		{
			KeyValues kv = new KeyValues("Triggers");
			BuildPath(Path_SM, sPath, PLATFORM_MAX_PATH, "configs/jailbreak/Triggers.cfg");
			kv.ImportFromFile(sPath);
			
			if (kv.JumpToKey(gS_Map, false))
			{ 
				if (kv.GotoFirstSubKey())
				{
					do
					{
						switch (iUsage)
						{
							case 0:
							{
								if (kv.GetNum("mode") != 1)
									continue;								
							}
							case 1:
							{
								if (kv.GetNum("mode") != 2)
									continue;
							}
							case 3:
							{
								if (kv.GetNum("mode") > 0)
									continue;
							}
						}
							
						kv.GetSectionName(sBuffer, 20);
						FormatEx(sFormat, 22, "%s;%s", sBuffer, sUsage);
						hMenu.AddItem(sFormat, sBuffer);
					}
					while (kv.GotoNextKey());
					kv.Rewind();
				}
				else PrintToChat(client, "[SM] There are no entities to delete!");
			}
			else PrintToChat(client, "[SM] The Triggers file failed to open or there's no data...");
			delete kv;
		}
		case 2:
		{
			KeyValues kv = new KeyValues("Entities");
			BuildPath(Path_SM, sPath, PLATFORM_MAX_PATH, "configs/jailbreak/Entities.cfg");
			kv.ImportFromFile(sPath);
			
			if (kv.JumpToKey(gS_Map, false))
			{ 
				if (kv.GotoFirstSubKey())
				{
					do
					{
						kv.GetSectionName(sBuffer, 20);
						FormatEx(sFormat, 22, "%s;%s", sBuffer, sUsage);
						hMenu.AddItem(sFormat, sBuffer);
					}
					while (kv.GotoNextKey());
					kv.Rewind();
				}
				else PrintToChat(client, "[SM] There are no entities to delete!");
			}
			else PrintToChat(client, "[SM] The Entities file failed to open or there's no data...");
			delete kv;	
		}
	}
	
	if (hMenu.ItemCount == 0)
	{
		PrintToChat(client, "[SM] There are no entities available!");
		delete hMenu;
		JailbreakMenu(client);
		return;
	}
	
	hMenu.ExitBackButton = true;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_RemoveEntity(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client))
			{
				char[] sInfo = new char[45];
				hMenu.GetItem(iParam, sInfo, 45);
				
				char[][] sBuffer = new char[2][50];
				ExplodeString(sInfo, ";", sBuffer, 2, 50);
				
				char[] sPath = new char[PLATFORM_MAX_PATH];
				
				switch (StringToInt(sBuffer[1]))
				{
					case 0, 1, 3: 
					{
						KeyValues kv = new KeyValues("Triggers");
						
						BuildPath(Path_SM, sPath, PLATFORM_MAX_PATH, "configs/jailbreak/Triggers.cfg");
						kv.ImportFromFile(sPath);
						
						if (kv.JumpToKey(gS_Map, false))
						{
							if (kv.JumpToKey(sBuffer[0], false))
							{
								kv.DeleteThis();
								kv.Rewind();
								kv.ExportToFile(sPath);
								PrintToChat(client, "[SM] You successfully removed \x02%s", sBuffer[0]);
							}
							else PrintToChat(client, "[SM] The Entity already has been removed...");
						}
						else PrintToChat(client, "[SM] The Triggers file failed to open...");
						delete kv;
					}
					case 2: 
					{
						KeyValues kv = new KeyValues("Entities");
						BuildPath(Path_SM, sPath, PLATFORM_MAX_PATH, "configs/jailbreak/Entities.cfg");
						kv.ImportFromFile(sPath);
						
						if (kv.JumpToKey(gS_Map, false))
						{
							if (kv.JumpToKey(sBuffer[0], false))
							{
								kv.DeleteThis();
								kv.Rewind();
								kv.ExportToFile(sPath);
								PrintToChat(client, "[SM] You successfully removed \x02%s", sBuffer[0]);
							}
							else PrintToChat(client, "[SM] The Entity is already deleted...");
						}
						else PrintToChat(client, "[SM] The Entities file failed to open...");
						delete kv;
					}
				}
				RemoveEntityMenu(client, sBuffer[1]);
			}
		}
		case MenuAction_Cancel:
		{
			if (iParam == MenuCancel_ExitBack && IsValidClient(client))
			{
				if (IsPlayerAlive(client))				
					JailbreakMenu(client);
				else
					PrintToChat(client, "[SM] You must be alive to access the menu!");
			}
		}
		case MenuAction_End: delete hMenu;
	}
}

void OpenTaserTeleportMenu(int client)
{
	Menu hMenu = new Menu(Menu_TaserTeleport);
	hMenu.SetTitle("[Jailbreak] Taser Teleport\n ");
	hMenu.AddItem("", "Add Spawn");
	hMenu.AddItem("", "Delete Spawn", (gF_CagePosition[0] != 0.0)? ITEMDRAW_DEFAULT:ITEMDRAW_DISABLED);
	hMenu.AddItem("", "Display Spawn", (gF_CagePosition[0] != 0.0)? ITEMDRAW_DEFAULT:ITEMDRAW_DISABLED);
	hMenu.ExitBackButton = true;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_TaserTeleport(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client) && IsPlayerAlive(client))
			{
				char[] sPath = new char[PLATFORM_MAX_PATH];
				
				switch (iParam)
				{
					case 0:
					{
						GetPlayerEyeViewPoint(client, gF_CagePosition);
						gF_CagePosition[2] += 20.0;
						
						KeyValues kv = new KeyValues("Taser Spawns");
						BuildPath(Path_SM, sPath, PLATFORM_MAX_PATH, "configs/jailbreak/Taserspawns.cfg");
						kv.ImportFromFile(sPath);

						if (kv.JumpToKey(gS_Map, true))
						{
							kv.SetFloat("X", gF_CagePosition[0]);
							kv.SetFloat("Y", gF_CagePosition[1]);
							kv.SetFloat("Z", gF_CagePosition[2]);
							kv.Rewind();
							kv.ExportToFile(sPath);
							PrintToChat(client, "[SM] You spawned a valid point!");
						}
						else PrintToChat(client, "[SM] The Taser Spawn file failed to open...");
						delete kv;	
					}
					case 1:
					{
						KeyValues kv = new KeyValues("Taser Spawns");
						BuildPath(Path_SM, sPath, PLATFORM_MAX_PATH, "configs/jailbreak/Taserspawns.cfg");
						kv.ImportFromFile(sPath);
						
						if (kv.JumpToKey(gS_Map, false))
						{
							kv.DeleteThis();
							kv.Rewind();
							kv.ExportToFile(sPath);
							
							for (int i = 0; i < 3; i++)
								gF_CagePosition[i] = 0.0;
							
							PrintToChat(client, "[SM] You have deleted the taser spawn point!");
						}
						else PrintToChat(client, "[SM] The Taser Spawns file failed to open...");
						delete kv;
					}
					case 2:
					{
						if (gF_CagePosition[0] != 0.0)
						{
							TE_SetupBeamRingPoint(gF_CagePosition, 150.0, 150.1, gI_Sprites[0], gI_Sprites[1], 0, 10, 20.0, 7.0, 0.0, {255, 0, 255, 255}, 0, 0);
							TE_SendToClient(client);
							PrintToChat(client, "[SM] The location has been marked!");
						}
						else PrintToChat(client, "[SM] There is no cage spawn available!");
					}
				}
			}
		}
		case MenuAction_Cancel:
		{
			if (iParam == MenuCancel_ExitBack && IsValidClient(client))
			{
				if (IsPlayerAlive(client))				
					JailbreakMenu(client);
				else
					PrintToChat(client, "[SM] You must be alive to access the menu!");
			}
		}
		case MenuAction_End: delete hMenu;
	}	
}

void OpenSpecialDaySpawnsMenu(int client)
{
	Menu hMenu = new Menu(Menu_Spawns);
	hMenu.SetTitle("Spawns Menu\n ");
	hMenu.AddItem("", "Add Spawn");
	hMenu.AddItem("", "Display Spawns", (gI_Spawns > -1) ? ITEMDRAW_DEFAULT:ITEMDRAW_DISABLED);
	hMenu.AddItem("", "Delete Spawns", (gI_Spawns > -1) ? ITEMDRAW_DEFAULT:ITEMDRAW_DISABLED);
	hMenu.ExitBackButton = true;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_Spawns(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client) && IsPlayerAlive(client))
			{
				switch(iParam)
				{
					case 0:
					{
						if (gI_Spawns + 1 < MAXPLAYERS+1)
						{													
							++gI_Spawns;
							
							float vOrigin[3];
							GetClientAbsOrigin(client, vOrigin);
							vOrigin[2] += 15.0;
							
							char[] sFormat = new char[100];
							FormatEx(sFormat, 100, "%f;%f;%f", vOrigin[0], vOrigin[1], vOrigin[2]);
							gA_SpawnLocation.PushString(sFormat);
							
							char[] sBuffer = new char[30];
							FormatEx(sBuffer, 30, "Spawn %i", gI_Spawns);
							
							KeyValues kv = new KeyValues("Spawns");
							
							char[] sPath = new char[PLATFORM_MAX_PATH];
							BuildPath(Path_SM, sPath, PLATFORM_MAX_PATH, "configs/jailbreak/spawns.cfg");
							kv.ImportFromFile(sPath);

							if (kv.JumpToKey(gS_Map, true))
							{
								if (kv.JumpToKey(sBuffer, true))
								{
									kv.SetString("location", sFormat);
									kv.Rewind();
									kv.ExportToFile(sPath);
									PrintToChat(client, "[SM] You added a Special day spawn! (Your current location)");	
								}
								else PrintToChat(client, "[SM] The Spawn failed to save...");
							}
							else PrintToChat(client, "[SM] The Spawns file failed to open...");
							delete kv;	
						}
						else PrintToChat(client, "[SM] The Spawn limit has been reached!");
					}
					case 1:
					{
						if (gI_Spawns > -1)
						{
							PrintToChat(client, "[SM] All the spawns are now visible!");
							
							char[] sFormat = new char[100];
							char[][] sBuffer = new char[3][100];
							
							float fLocation[3];
							
							for (int i = 0; i <= gI_Spawns; ++i)
							{
								gA_SpawnLocation.GetString(i, sFormat, 100);
								ExplodeString(sFormat, ";", sBuffer, 3, 100);
								
								fLocation[0] = StringToFloat(sBuffer[0]);
								fLocation[1] = StringToFloat(sBuffer[1]);
								fLocation[2] = StringToFloat(sBuffer[2]);
								
								TE_SetupBeamRingPoint(fLocation, 50.0, 50.1, gI_Sprites[0], gI_Sprites[1], 0, 10, 20.0, 7.0, 0.0, {0, 255, 255, 255}, 0, 0);
								TE_SendToClient(client);
							}
						}
						else PrintToChat(client, "[SM] There are no Spawns on this map!");						
					}
					case 2:
					{
						if (gI_Spawns > -1)
						{
							Menu hMenu2 = new Menu(Menu_DeleteSpawns);
							hMenu2.SetTitle("Spawn Deletion\n ");
							
							char[] sFormat = new char[32];
							
							for (int i = 0; i <= gI_Spawns; ++i)
							{
								FormatEx(sFormat, 32, "Spawn %i", i);
								hMenu2.AddItem("", sFormat);								
							}
							
							if (hMenu2.ItemCount == 0) 
							{
								PrintToChat(client, "[SM] There are no Spawns to delete!");
								delete hMenu2;
								OpenSpecialDaySpawnsMenu(client);
								return;
							}
							hMenu2.ExitBackButton = true;
							hMenu2.Display(client, MENU_TIME_FOREVER);
							return;
						}
						else PrintToChat(client, "[SM] There are no Spawns on this map!");						
					}
				}
				OpenSpecialDaySpawnsMenu(client);
			}
		}
		case MenuAction_Cancel:
		{
			if (iParam == MenuCancel_ExitBack && IsValidClient(client))
			{
				if (IsPlayerAlive(client))				
					JailbreakMenu(client);
				else
					PrintToChat(client, "[SM] You must be alive to access the menu!");
			}
		}
		case MenuAction_End: delete hMenu;
	}
}

public int Menu_DeleteSpawns(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client))
			{
				KeyValues kv = new KeyValues("Spawns");
				
				char[] sPath = new char[PLATFORM_MAX_PATH];
				BuildPath(Path_SM, sPath, PLATFORM_MAX_PATH, "configs/jailbreak/spawns.cfg");
				kv.ImportFromFile(sPath);
				
				if (kv.JumpToKey(gS_Map, false))
				{
					char[] sFormat = new char[100];
					FormatEx(sFormat, 100, "Spawn %i", iParam);
					
					if (kv.JumpToKey(sFormat, false))
					{
						kv.DeleteThis();
						kv.Rewind();
						kv.ExportToFile(sPath);
						
						gA_SpawnLocation.Erase(iParam);
						gI_Spawns--;
						
						PrintToChat(client, "[SM] You have successfully deleted \x02Spawn %i", iParam);
					}
					else PrintToChat(client, "[SM] The deletion failed...");
				}
				else PrintToChat(client, "[SM] The Spawns file failed to open...");
				delete kv;
				OpenSpecialDaySpawnsMenu(client);
			}
		}
		case MenuAction_Cancel:
		{
			if (iParam == MenuCancel_ExitBack && IsValidClient(client))
			{
				if (IsPlayerAlive(client))				
					OpenSpecialDaySpawnsMenu(client);
				else
					PrintToChat(client, "[SM] You must be alive to access the menu!");
			}
		}
		case MenuAction_End: delete hMenu;
	}
}

void OpenStoreMenu(int client, int iPage = 0)
{
	char[] sDisplayBuffer = new char[50];
	
	Menu hMenu = new Menu(Menu_Store);
	hMenu.SetTitle("[Black Market]\nCredits: %i\n ", gI_Credits[client]);
	
	FormatEx(sDisplayBuffer, 50, "Armor\nCost: %i", SHOP_ARMOR_PRICE);
	hMenu.AddItem("", sDisplayBuffer);
	
	FormatEx(sDisplayBuffer, 50, "Heal Shot\nCost: %i", SHOP_HEAL_PRICE);
	hMenu.AddItem("", sDisplayBuffer);
	
	FormatEx(sDisplayBuffer, 50, "Tactical Grenade\nCost: %i", SHOP_TAGRENADE_PRICE);
	hMenu.AddItem("", sDisplayBuffer);
	
	FormatEx(sDisplayBuffer, 50, "Cluster Grenade [%i/%i]\nCost: %i", gI_GrenadeCount, SHOP_CLUSTER_LIMIT, SHOP_CLUSTER_PRICE);
	hMenu.AddItem("", sDisplayBuffer);
	
	FormatEx(sDisplayBuffer, 50, "Silent Footsteps\nCost: %i", SHOP_FOOTSTEPS_PRICE);
	hMenu.AddItem("", sDisplayBuffer);
	
	FormatEx(sDisplayBuffer, 50, "Hook [Rebel]\nCost: %i", SHOP_HOOK_PRICE);
	hMenu.AddItem("", sDisplayBuffer);
	
	FormatEx(sDisplayBuffer, 50, "Parachute\nCost: %i", SHOP_PARACHUTE_PRICE);
	hMenu.AddItem("", sDisplayBuffer);

	FormatEx(sDisplayBuffer, 50, "EMP [%i/%i]\nCost: %i", gI_EMPCount, SHOP_EMP_LIMIT, SHOP_EMP_PRICE);
	hMenu.AddItem("", sDisplayBuffer);

	FormatEx(sDisplayBuffer, 50, "Lights [%i/%i]\nCost: %i", gI_LightCount, SHOP_LIGHTS_LIMIT, SHOP_LIGHTS_PRICE);
	hMenu.AddItem("", sDisplayBuffer);
	
	FormatEx(sDisplayBuffer, 50, "Taser [Rebel]\nCost: %i", SHOP_TASER_PRICE);
	hMenu.AddItem("", sDisplayBuffer);
	
	FormatEx(sDisplayBuffer, 50, "One Deag [Rebel] (%i/%i)\nCost: %i", gI_DeagCount, SHOP_DEAGLE_LIMIT, SHOP_DEAGLE_PRICE);
	hMenu.AddItem("", sDisplayBuffer);

	FormatEx(sDisplayBuffer, 50, "Disguise [Rebel] (%i/%i)\nCost: %i", gI_DisguiseCount, SHOP_DISGUISE_LIMIT, SHOP_DISGUISE_PRICE);
	hMenu.AddItem("", sDisplayBuffer);
	
	FormatEx(sDisplayBuffer, 50, "Jihad [Rebel] (%i/%i)\nCost: %i", gI_JihadCount, SHOP_JIHAD_LIMIT, SHOP_JIHAD_PRICE);
	hMenu.AddItem("", sDisplayBuffer);
	
	FormatEx(sDisplayBuffer, 50, "Invisiblity [Rebel] (%i/%i)\nCost: %i", gI_InvisiblityCount, SHOP_INVISIBILITY_LIMIT, SHOP_INVISIBILITY_PRICE);
	hMenu.AddItem("", sDisplayBuffer);

	SetMenuPagination(hMenu, 4);
	hMenu.ExitBackButton = true;
	hMenu.DisplayAt(client, iPage, MENU_TIME_FOREVER);
}

public int Menu_Store(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client) && IsPlayerAlive(client) && GetClientTeam(client) == 2 && gH_SpecialDay == SPECIALDAY_INVALID && gH_LastRequest == LASTREQUEST_INVALID) 
			{		
				switch (iParam)
				{
					case 0:
					{	
						if (gI_Credits[client] < SHOP_ARMOR_PRICE)
						{
							PrintToChat(client, "%s You don't have enough credits!", SHOP_TAG);
							OpenStoreMenu(client, GetMenuSelectionPosition());
							return;	
						}
						
						if (!gB_Armor[client])
						{
							gB_Armor[client] = true;
							gI_Credits[client] -= SHOP_ARMOR_PRICE;
							
							GivePlayerItem( client, "item_assaultsuit");
							PrintToChat(client, "%s You have bought \x04Armor\x01!", SHOP_TAG);
						}
						else PrintToChat(client, "%s You already bought this Item!", SHOP_TAG);
					}
					case 1:
					{	
						if (gI_Credits[client] < SHOP_HEAL_PRICE)
						{
							PrintToChat(client, "%s You don't have enough credits!", SHOP_TAG);
							OpenStoreMenu(client, GetMenuSelectionPosition());
							return;	
						}
					
						if (!gB_Health[client])
						{
							gB_Health[client] = true;
							gI_Credits[client] -= SHOP_HEAL_PRICE;
							
							GivePlayerItem(client, "weapon_healthshot");
							PrintToChat(client, "%s You have bought \x04Heal Shot\x01!", SHOP_TAG);
						}
						else PrintToChat(client, "%s You already bought this Item!", SHOP_TAG);
					}
					case 2:
					{		
						if (gI_Credits[client] < SHOP_TAGRENADE_PRICE)
						{
							PrintToChat(client, "%s You don't have enough credits!", SHOP_TAG);
							OpenStoreMenu(client, GetMenuSelectionPosition());
							return;	
						}
					
						if (!gB_TANade[client])
						{
							gB_TANade[client] = true;
							gI_Credits[client] -= SHOP_TAGRENADE_PRICE;
							GivePlayerItem(client, "weapon_tagrenade");
							PrintToChat(client, "%s You have bought a \x04Tactical Grenade\x01!", SHOP_TAG);
						}
						else PrintToChat(client, "%s You already bought this Item!", SHOP_TAG);
					}
					case 3:
					{	
						if (gI_Credits[client] < SHOP_CLUSTER_PRICE)
						{
							PrintToChat(client, "%s You don't have enough credits!", SHOP_TAG);
							OpenStoreMenu(client, GetMenuSelectionPosition());
							return;	
						}
						else if (gI_GrenadeCount >= SHOP_CLUSTER_LIMIT)
						{
							PrintToChat(client, "%s The \x04Cluster Grenade\x01 limit has been reached!", SHOP_TAG);
							OpenStoreMenu(client, GetMenuSelectionPosition());
							return;
						}
					
						if (!gB_Nade[client])
						{
							++gI_GrenadeCount;
							gB_Nade[client] = true;
							gB_ClusterNade[client] = true;
							gI_Credits[client] -= SHOP_CLUSTER_PRICE;
							
							GivePlayerItem(client, "weapon_hegrenade");
							PrintToChat(client, "%s You have bought a \x04Cluster Grenade\x01!", SHOP_TAG);
						}
						else PrintToChat(client, "%s You already bought this Item!", SHOP_TAG);
					}
					case 4:
					{	
						if (gI_Credits[client] < SHOP_FOOTSTEPS_PRICE)
						{
							PrintToChat(client, "%s You don't have enough credits!", SHOP_TAG);
							OpenStoreMenu(client, GetMenuSelectionPosition());
							return;	
						}
						
						if (!gB_PlayerSteps[client])
						{
							gB_PlayerSteps[client] = true;
							gI_Credits[client] -= SHOP_FOOTSTEPS_PRICE;
							PrintToChat(client, "%s You have bought \x04Silent Footsteps\x01!", SHOP_TAG);
						}
						else PrintToChat(client, "%s You already bought this Item!", SHOP_TAG);
					}
					case 5:
					{	
						if (gI_Credits[client] < SHOP_HOOK_PRICE)
						{
							PrintToChat(client, "%s You don't have enough credits!", SHOP_TAG);
							OpenStoreMenu(client, GetMenuSelectionPosition());
							return;	
						}
						
						if (!gB_Hook[client])
						{
							gB_Hook[client] = true;
							gI_Credits[client] -= SHOP_HOOK_PRICE;
							PrintToChat(client, "%s You have bought a \x04Hook\x01!", SHOP_TAG);
						}
						else PrintToChat(client, "%s You already bought this Item!", SHOP_TAG);
					}
					case 6:
					{	
						if (gI_Credits[client] < SHOP_PARACHUTE_PRICE)
						{
							PrintToChat(client, "%s You don't have enough credits!", SHOP_TAG);
							OpenStoreMenu(client, GetMenuSelectionPosition());
							return;	
						}
						
						if (!gB_Parachute[client])
						{
							gB_Parachute[client] = true;
							gI_Credits[client] -= SHOP_PARACHUTE_PRICE;
							PrintToChat(client, "%s You have bought \x04Parachute\x01!", SHOP_TAG);
						}
						else PrintToChat(client, "%s You already bought this Item!", SHOP_TAG);
					}
					case 7:
					{	
						if (gI_Credits[client] < SHOP_EMP_PRICE)
						{
							PrintToChat(client, "%s You don't have enough credits!", SHOP_TAG);
							OpenStoreMenu(client, GetMenuSelectionPosition());
							return;	
						}
						else if (gI_EMPCount >= SHOP_EMP_LIMIT)
						{
							PrintToChat(client, "%s The \x04EMP\x01 limit has be reached!", SHOP_TAG);
							OpenStoreMenu(client, GetMenuSelectionPosition());
							return;
						}
						
						if (!gB_EMP[client])
						{
							gB_EMP[client] = true;
							gI_Credits[client] -= SHOP_EMP_PRICE;
							++gI_EMPCount;
							
							PrintCenterTextAll("<font size=\"24\"><font color='#FF1A00'>%N</font> has EMP'd!</font>", client);
							CreateTimer(5.0, Timer_Notify, 0, TIMER_FLAG_NO_MAPCHANGE);
							for (int i = 1; i <= MaxClients; ++i) if (IsClientInGame(i) && IsPlayerAlive(i) && GetClientTeam(i) == 3)
							{
								FadePlayer(i, 300, 300, 0x0001, {0, 0, 0, 100});
								SetEntProp(i, Prop_Send, "m_iHideHUD", (1<<2));
							}
						}
						else PrintToChat(client, "%s You already bought this Item!", SHOP_TAG);
					}
					case 8:
					{
						if (gI_Credits[client] < SHOP_LIGHTS_PRICE)
						{
							PrintToChat(client, "%s You don't have enough credits!", SHOP_TAG);
							OpenStoreMenu(client, GetMenuSelectionPosition());
							return;	
						}
						else if (gI_LightCount >= SHOP_LIGHTS_LIMIT)
						{
							PrintToChat(client, "%s The \x04Lights\x01 limit has be reached!", SHOP_TAG);
							OpenStoreMenu(client, GetMenuSelectionPosition());
							return;
						}
						
						if (!gB_Light[client])
						{
							gB_Light[client] = true;
							gI_Credits[client] -= SHOP_LIGHTS_PRICE;
							++gI_LightCount;
							
							PrintCenterTextAll("<font size=\"24\"><font color='#FF1A00'>%N</font> has cut the power!</font>", client);
							CreateTimer(7.0, Timer_Notify, 1, TIMER_FLAG_NO_MAPCHANGE);
							
							for (int i = 1; i <= MaxClients; ++i) if (IsClientInGame(i)) FadePlayer(i, 100, 3850, 0x0009, {0, 0, 0, 255});
						}
						else PrintToChat(client, "%s You already bought this Item!", SHOP_TAG);
					}
					case 9:
					{			
						if (gI_Credits[client] < SHOP_TASER_PRICE)
						{
							PrintToChat(client, "%s You don't have enough credits!", SHOP_TAG);
							OpenStoreMenu(client, GetMenuSelectionPosition());
							return;	
						}

						if (!gB_Taser[client])
						{
							gB_Taser[client] = true;
							gI_Credits[client] -= SHOP_TASER_PRICE;
							PrintToChat(client, "%s You have bought \x04Zeus\x01!", SHOP_TAG);
							GivePlayerItem(client, "weapon_taser");
						}
						else PrintToChat(client, "%s You already bought this Item!", SHOP_TAG);
					}
					case 10:
					{			
						if (gI_Credits[client] < SHOP_DEAGLE_PRICE)
						{
							PrintToChat(client, "%s You don't have enough credits!", SHOP_TAG);
							OpenStoreMenu(client, GetMenuSelectionPosition());
							return;	
						}
						else if (gI_DeagCount >= SHOP_DEAGLE_LIMIT)
						{
							PrintToChat(client, "%s The \x04One Deag\x01 limit has been reached!", SHOP_TAG);
							OpenStoreMenu(client, GetMenuSelectionPosition());
							return;
						}

						if (!gB_Deag[client])
						{
							gB_Deag[client] = true;
							gI_Credits[client] -= SHOP_DEAGLE_PRICE;
							++gI_DeagCount;
							
							PrintToChat(client, "%s You have bought \x04One Deag\x01!", SHOP_TAG);
							
							int iWeapon = GivePlayerItem(client, "weapon_deagle");
							SetEntData(iWeapon, FindSendPropInfo("CBaseCombatWeapon", "m_iClip1"), 1);
							SetEntProp(iWeapon, Prop_Send, "m_iPrimaryReserveAmmoCount", 0);
						}
						else PrintToChat(client, "%s You already bought this Item!", SHOP_TAG);
					}
					case 11:
					{	
						if (gI_Credits[client] < SHOP_DISGUISE_PRICE)
						{
							PrintToChat(client, "%s You don't have enough credits!", SHOP_TAG);
							OpenStoreMenu(client, GetMenuSelectionPosition());
							return;	
						}
						else if (gI_DisguiseCount >= SHOP_DISGUISE_LIMIT)
						{
							PrintToChat(client, "%s The \x04Disguise\x01 limit has been reached!", SHOP_TAG);
							OpenStoreMenu(client, GetMenuSelectionPosition());
							return;
						}
						
						if (!gB_Disguise[client])
						{
							gB_Disguise[client] = true;
							gI_Credits[client] -= SHOP_DISGUISE_PRICE;
							++gI_DisguiseCount;
							
							switch (gI_GuardModel[client])
							{
								case 0: 
								{
									SetEntityModel(client, MODEL_GUARD1);
									SetEntPropString(client, Prop_Send, "m_szArmsModel", MODEL_GUARD1_ARMS);
								}
								case 1: 
								{
									SetEntityModel(client, MODEL_GUARD2);
									SetEntPropString(client, Prop_Send, "m_szArmsModel", MODEL_GUARD2_ARMS);
								}
								case 2: 
								{
									SetEntityModel(client, MODEL_GUARD3);
									SetEntPropString(client, Prop_Send, "m_szArmsModel", MODEL_GUARD3_ARMS);
								}
								case 3: 
								{
									SetEntityModel(client, MODEL_GUARD4);
									SetEntPropString(client, Prop_Send, "m_szArmsModel", MODEL_GUARD4_ARMS);
								}
								case 4: 
								{
									SetEntityModel(client, MODEL_GUARD5);
									SetEntPropString(client, Prop_Send, "m_szArmsModel", MODEL_GUARD5_ARMS);
								}
							}
							PrintToChat(client, "%s You have bought \x04Disguise\x01!", SHOP_TAG);
						}
						else PrintToChat(client, "%s You already bought this Item!", SHOP_TAG);
					}
					case 12:
					{
						if (gI_Credits[client] < SHOP_JIHAD_PRICE)
						{
							PrintToChat(client, "%s You don't have enough credits!", SHOP_TAG);
							OpenStoreMenu(client, GetMenuSelectionPosition());
							return;	
						}
						else if (gI_JihadCount >= SHOP_JIHAD_LIMIT)
						{
							PrintToChat(client, "%s The \x04Jihad\x01 limit has been reached!", SHOP_TAG);
							OpenStoreMenu(client, GetMenuSelectionPosition());
							return;
						}
						
						if (!gB_Jihad[client])
						{
							gB_Jihad[client] = true;
							gI_Credits[client] -= SHOP_JIHAD_PRICE;
							++gI_JihadCount;
							
							GivePlayerItem(client, "weapon_c4");
							PrintToChat(client, "%s You have bought \x04Jihad\x01!", SHOP_TAG);
							PrintToChat(client, "%s Press \x04E \x01with the C4 out to Jihad!", SHOP_TAG);
						}
						else PrintToChat(client, "%s You already bought this Item!", SHOP_TAG);
					}
					case 13:
					{
						if (gI_Credits[client] < SHOP_INVISIBILITY_PRICE)
						{
							PrintToChat(client, "%s You don't have enough credits!", SHOP_TAG);
							OpenStoreMenu(client, GetMenuSelectionPosition());
							return;	
						}
						else if (gI_InvisiblityCount >= SHOP_INVISIBILITY_LIMIT)
						{
							PrintToChat(client, "%s The \x04Invisiblity\x01 limit has been reached!", SHOP_TAG);
							OpenStoreMenu(client, GetMenuSelectionPosition());
							return;
						}
						
						if (!gB_Invisiblity[client])
						{
							gB_Invisiblity[client] = true;
							gI_Credits[client] -= SHOP_INVISIBILITY_PRICE;
							++gI_InvisiblityCount;
							
							SetGlow(client, 255, 255, 255, SHOP_INVISIBLITY_ALPHA);
							PrintToChat(client, "%s You have bought \x04Invisiblity\x01!", SHOP_TAG);
							CreateTimer(SHOP_INVISIBILITY_INTERVAL, Timer_Invisiblity, GetClientUserId(client), TIMER_FLAG_NO_MAPCHANGE);
						}
						else PrintToChat(client, "%s You already bought this Item!", SHOP_TAG);
					}
				}
			}
		}
		case MenuAction_Cancel: if (iParam == MenuCancel_ExitBack) Cmd_PreMenu(client, 0);
		case MenuAction_End: delete hMenu;
	}
}

void OpenBountyMenu(int client)
{
	Menu hMenu = new Menu(Menu_Bounty);
	hMenu.SetTitle("[Jailbreak] Bounty Menu\n ");
	
	switch (gI_BountyIndex[client])
	{
		case 0:	hMenu.AddItem("0", "Bounty: [100] 250 500 1000\n ");
		case 1:	hMenu.AddItem("1", "Bounty: 100 [250] 500 1000\n ");
		case 2:	hMenu.AddItem("2", "Bounty: 100 250 [500] 1000\n ");
		case 3:	hMenu.AddItem("3", "Bounty: 100 250 500 [1000]\n ");
	}
	
	char[] sInfoString = new char[7];
	char[] sDisplayString = new char[MAX_NAME_LENGTH];

	for (int i = 1; i <= MaxClients; ++i)
	{
		if (i != client && IsClientInGame(i))
		{
			FormatEx(sInfoString, 7, "%i", GetClientUserId(i));
			FormatEx(sDisplayString, MAX_NAME_LENGTH, "%N", i);
			hMenu.AddItem(sInfoString, sDisplayString);
		}
	}

	hMenu.ExitBackButton = true;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_Bounty(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client))
			{
				if (iParam == 0)
				{
					char[] sInfo = new char[2];
					hMenu.GetItem(iParam, sInfo, 2);
					
					if (StringToInt(sInfo) == 3)
						gI_BountyIndex[client] = 0;						
					else 
						++gI_BountyIndex[client];		
				}
				else
				{
					char[] sInfo = new char[7];
					hMenu.GetItem(iParam, sInfo, 7);
					
					int target = GetClientOfUserId(StringToInt(sInfo));
					
					if (IsValidClient(target))
					{
						switch (gI_BountyIndex[client])
						{
							case 0: 
							{
								if (gI_Credits[client] >= 100)
								{
									gI_Bounty[target] += 100;
									gI_Credits[client] -= 100;
									gI_BountyTarget[target][client] += 100;
									PrintToChatAll("%s\x03%N\x01 has put \x04%i\x01 credits bounty on \x02%N", JB_TAG, client, 100, target);
								}
								else PrintToChat(client, "%sInsufficient funds.", JB_TAG);	
							}
							case 1: 
							{
								if (gI_Credits[client] >= 250)
								{
									gI_Bounty[target] += 250;
									gI_Credits[client] -= 250;
									gI_BountyTarget[target][client] += 250;
									PrintToChatAll("%s\x03%N\x01 has put \x04%i\x01 credits bounty on \x02%N", JB_TAG, client, 250, target);
								}
								else PrintToChat(client, "%sInsufficient funds.", JB_TAG);	
							}
							case 2: 
							{
								if (gI_Credits[client] >= 500)
								{
									gI_Bounty[target] += 500;
									gI_Credits[client] -= 500;
									gI_BountyTarget[target][client] += 500;
									PrintToChatAll("%s\x03%N\x01 has put \x04%i\x01 credits bounty on \x02%N", JB_TAG, client, 500, target);
								}
								else PrintToChat(client, "%sInsufficient funds.", JB_TAG);	
							}
							case 3: 
							{
								if (gI_Credits[client] >= 1000)
								{
									gI_Bounty[target] += 1000;
									gI_Credits[client] -= 1000;
									gI_BountyTarget[target][client] += 1000;
									PrintToChatAll("%s\x03%N\x01 has put \x04%i\x01 credits bounty on \x02%N", JB_TAG, client, 1000, target);
								}
								else PrintToChat(client, "%sInsufficient funds.", JB_TAG);	
							}
						}
					}
				}
				OpenBountyMenu(client);
			}
		}
		case MenuAction_Cancel: if (iParam == MenuCancel_ExitBack) Cmd_PreMenu(client, 0);
		case MenuAction_End: delete hMenu;
	}
}

void OpenCasinoMenu(int client)
{
	Menu hMenu = new Menu(Menu_Casino);
	hMenu.SetTitle("Welcome to the Casino\nCredits: %i\nBet: %i\n ", gI_Credits[client], gI_BetAmount[client]);
	hMenu.AddItem("", "+100");
	hMenu.AddItem("", "+1000");
	hMenu.AddItem("", "+10000\n ");
	hMenu.AddItem("", "-100");
	hMenu.AddItem("", "-1000");
	hMenu.AddItem("", "-10000\n ");
	hMenu.AddItem("", "Black Jack");
	hMenu.AddItem("", "Red Dog");
	
	SetMenuPagination(hMenu, MENU_NO_PAGINATION);
	hMenu.ExitButton = true;
	hMenu.Display(client, MENU_TIME_FOREVER);	
}

public int Menu_Casino(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client))
			{
				switch (iParam)
				{
					case 0: gI_BetAmount[client] += 100;
					case 1: gI_BetAmount[client] += 1000;
					case 2: gI_BetAmount[client] += 10000;
					case 3: gI_BetAmount[client] -= 100;
					case 4: gI_BetAmount[client] -= 1000;
					case 5: gI_BetAmount[client] -= 10000;
					case 6:
					{
						if (0 < gI_BetAmount[client] <= gI_Credits[client])
						{
							gI_GameMode[client] = 0;
							OpenBlackJack(client);
							return;
						}
						else PrintToChat(client, "%s Insufficient funds", CASINO_TAG);
						OpenCasinoMenu(client);
					}
					case 7: 
					{
						if (0 < gI_BetAmount[client] <= gI_Credits[client])
						{
							gI_GameMode[client] = 1;
							OpenRedDog(client);
							return;
						}
						else PrintToChat(client, "%s Insufficient funds", CASINO_TAG);
						OpenCasinoMenu(client);
					}
				}
				
				if (gI_BetAmount[client] > gI_Credits[client])
					gI_BetAmount[client] = gI_Credits[client];
				else if (gI_BetAmount[client] < 0)
					gI_BetAmount[client] = 0;
				OpenCasinoMenu(client);
			}
		}
		case MenuAction_End: delete hMenu;
	}
}

void OpenBlackJack(int client)
{
	if (gI_ClientCards[client] <= 0)
	{
		gI_ClientCards[client] += GetRandomInt(0, 5) + GetRandomInt(1, 5) + GetRandomInt(0, 5) + GetRandomInt(1, 5);
		gI_Dealer[client] += (GetRandomInt(1, 5) + GetRandomInt(0, 5));
		gI_DealerCard[client] = gI_Dealer[client];
		gI_Dealer[client] += (GetRandomInt(1, 5) + GetRandomInt(0, 5));
	}
	
	Menu hMenu = new Menu(Menu_BlackJack);
	hMenu.SetTitle("[Casino] Black Jack\nCredits: %i\nBetting: %i\n ", gI_Credits[client], gI_BetAmount[client]);
	
	char[] sInfo = new char[MAX_NAME_LENGTH];
	
	FormatEx(sInfo, MAX_NAME_LENGTH, "Dealer: %i + (?)", gI_Dealer[client] - gI_DealerCard[client]);
	hMenu.AddItem("", sInfo, ITEMDRAW_DISABLED);
	
	FormatEx(sInfo, MAX_NAME_LENGTH, "You: %i", gI_ClientCards[client]);
	hMenu.AddItem("", sInfo, ITEMDRAW_DISABLED);
	hMenu.AddItem("", "Hit");
	hMenu.AddItem("", "Stay");
	hMenu.ExitButton = false;
	hMenu.Display(client, MENU_TIME_FOREVER);	
}

public int Menu_BlackJack(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client))
			{
				if (gI_BetAmount[client] > gI_Credits[client])
				{
					PrintToChat(client, "%s You don't have enough credits!", CASINO_TAG);
					ResetCasino(client);
					return;
				}
				
				bool bStay = false;
				int iLost = -1;
				
				switch (iParam)
				{
					case 2: 
					{
						gI_ClientCards[client] += (GetRandomInt(0, 5) + GetRandomInt(1, 5));
						
						if (gI_ClientCards[client] <= 21)
						{
							if (gI_Dealer[client] > 16) 
								PrintToChat(client, "%s The Dealer has decided to Stay.", CASINO_TAG);
							else
								gI_Dealer[client] += (GetRandomInt(1, 5) + GetRandomInt(0, 5));
						}
					}
					case 3: 
					{
						bStay = true;
						
						if (gI_Dealer[client] <= 16)
						{
							gI_Dealer[client] += (GetRandomInt(0, 5) + GetRandomInt(1, 5));
							
							if (gI_Dealer[client] <= 16)
							{
								gI_Dealer[client] += (GetRandomInt(0, 5) + GetRandomInt(1, 5));
								
								if (gI_Dealer[client] <= 16)
									gI_Dealer[client] += (GetRandomInt(0, 5) + GetRandomInt(1, 5));
							}
						}
					}	
				}
				
				if (gI_ClientCards[client] == 21 && gI_Dealer[client] == 21)
				{
					PrintToChat(client, "%s Dealer: \x04%i", CASINO_TAG, gI_Dealer[client]);
					PrintToChat(client, "%s You: \x04%i", CASINO_TAG, gI_ClientCards[client]);
					PrintToChat(client, "%s You Tied with the dealer!", CASINO_TAG);
					LogMessage("[Casino] %L has tied in BlackJack. [Dealer: %i | %N: %i]", client, gI_Dealer[client], client, gI_ClientCards[client]);
					ResetCasino(client);
					OpenCasinoMenu(client);
					return;
				}
				else if (bStay)
				{
					if (gI_ClientCards[client] == gI_Dealer[client])
					{
						PrintToChat(client, "%s Dealer: \x04%i", CASINO_TAG, gI_Dealer[client]);
						PrintToChat(client, "%s You: \x04%i", CASINO_TAG, gI_ClientCards[client]);
						PrintToChat(client, "%s You Tied with the dealer!", CASINO_TAG);
						LogMessage("[Casino] %L has tied in BlackJack. [Dealer: %i | %N: %i]", client, gI_Dealer[client], client, gI_ClientCards[client]);
						ResetCasino(client);
						OpenCasinoMenu(client);
						return;
					}
					else if (gI_ClientCards[client] < gI_Dealer[client] <= 21)
						iLost = 1;
					else
						iLost = 0;
				}
				else if (gI_ClientCards[client] > 21 || gI_Dealer[client] == 21)
					iLost = 1;
				else if (gI_ClientCards[client] == 21)
					iLost = 2;
				else if (gI_Dealer[client] > 21) {
					iLost = 0;
				}
				
				switch (iLost)
				{
					case 0:
					{
						PrintToChat(client, "%s Dealer: \x04%i", CASINO_TAG, gI_Dealer[client]);
						PrintToChat(client, "%s You: \x04%i", CASINO_TAG, gI_ClientCards[client]);
						PrintToChat(client, "%s You Won \x04%i\x01 Credits!", CASINO_TAG, gI_BetAmount[client]);
						LogMessage("[Casino] %L has won %i credits in BlackJack. [Dealer: %i | %N: %i]", client, gI_BetAmount[client], gI_Dealer[client], client, gI_ClientCards[client]);
						
						if (gI_BetAmount[client] >= 1000)
							PrintToChatAll("%s \x0B%N\x01 Has Won \x04%i\x01 Credits in BlackJack!", CASINO_TAG, client, gI_BetAmount[client]);	
						
						gI_CasinoWins[client] += gI_BetAmount[client];
						gI_Credits[client] += gI_BetAmount[client];	
						ResetCasino(client);
						OpenCasinoMenu(client);
						return;
					}
					case 1:
					{
						PrintToChat(client, "%s Dealer: \x04%i", CASINO_TAG, gI_Dealer[client]);
						PrintToChat(client, "%s You: \x04%i", CASINO_TAG, gI_ClientCards[client]);
						PrintToChat(client, "%s You Lost \x04%i\x01 Credits!", CASINO_TAG, gI_BetAmount[client]);
						LogMessage("[Casino] %L has lost %i credits in BlackJack. [Dealer: %i | %N: %i]", client, gI_BetAmount[client], gI_Dealer[client], client, gI_ClientCards[client]);
						
						if (gI_BetAmount[client] >= 1000)
							PrintToChatAll("%s \x0B%N\x01 Has Lost \x04%i\x01 Credits in BlackJack!", CASINO_TAG, client, gI_BetAmount[client]);	
						
						gI_CasinoLoses[client] += gI_BetAmount[client];
						gI_Credits[client] -= gI_BetAmount[client];
						ResetCasino(client);
						if (gI_Credits[client] > 0)
							OpenCasinoMenu(client);
						return;
					}
					case 2:
					{
						int iTotal = RoundToNearest(gI_BetAmount[client] * 1.5);
						PrintToChat(client, "%s Dealer: \x04%i", CASINO_TAG, gI_Dealer[client]);
						PrintToChat(client, "%s You: \x04%i", CASINO_TAG, gI_ClientCards[client]);
						PrintToChat(client, "%s You Won \x04%i\x01 Credits!", CASINO_TAG, iTotal);
						LogMessage("[Casino] %L has won %i credits in BlackJack. (BlackJack Bonus) [Dealer: %i | %N: %i]", client, iTotal, gI_Dealer[client], client, gI_ClientCards[client]);
						
						if (iTotal >= 1000)
							PrintToChatAll("%s \x0B%N\x01 has Won \x04%i\x01 Credits in BlackJack!", CASINO_TAG, client, iTotal);	
							
						gI_CasinoWins[client] += iTotal;
						gI_Credits[client] += iTotal;	
						ResetCasino(client);
						OpenCasinoMenu(client);
						return;	
					}
				}
				OpenBlackJack(client);
			}
		}
		case MenuAction_End: delete hMenu;
	}
}

void OpenRedDog(int client)
{
	Menu hMenu = new Menu(Menu_RedDog);
	hMenu.SetTitle("[Casino] Red Dog\nCredits: %i\nBetting: %i\n ", gI_Credits[client], gI_BetAmount[client]);

	if (gI_Dealer[client] <= 0)
	{
		gI_Dealer[client] = (GetRandomInt(1, 8) + GetRandomInt(0, 5));
		gI_DealerCard[client] = (GetRandomInt(1, 8) + GetRandomInt(0, 5));
	}
	
	char[] sInfo = new char[MAX_NAME_LENGTH];
	FormatEx(sInfo, MAX_NAME_LENGTH, "Cards: %i - %i", gI_Dealer[client], gI_DealerCard[client]);
	hMenu.AddItem("", sInfo, ITEMDRAW_DISABLED);
	
	int iSpread = gI_Dealer[client] - gI_DealerCard[client];
	
	if (iSpread < 0)
		iSpread *= -1;
	
	if (0 <= iSpread <= 1)
	{			
		PrintToChat(client, "%s Wager was returned due to cards being [\x04%i\x01 - \x04%i\x01]", CASINO_TAG, gI_Dealer[client], gI_DealerCard[client]);	
		ResetCasino(client);
		
		if (gI_Credits[client] > 0)
			OpenCasinoMenu(client);
			
		delete hMenu;	
		return;
	}
	
	switch (iSpread)
	{
		case 1: iSpread = 5;
		case 2: iSpread = 4;
		case 3: iSpread = 2;
		default: iSpread = 1;			
	}
	
	FormatEx(sInfo, MAX_NAME_LENGTH, "Payout: %i:1", iSpread);
	hMenu.AddItem("", sInfo, ITEMDRAW_DISABLED);
	hMenu.AddItem("", "Ride", (gI_BetAmount[client] * 2 <= gI_Credits[client]) ? ITEMDRAW_DEFAULT:ITEMDRAW_DISABLED);
	hMenu.AddItem("", "Stand");
	hMenu.ExitButton = false;
	hMenu.Display(client, MENU_TIME_FOREVER);	
}

public int Menu_RedDog(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client))
			{
				if (gI_BetAmount[client] > gI_Credits[client])
				{
					PrintToChat(client, "%s You don't have enough credits!", CASINO_TAG);
					ResetCasino(client);
					return;
				}
				
				int iSpread = 1;
				
				if (iParam == 2 && gI_BetAmount[client] * 2 <= gI_Credits[client])
				{
					gI_BetAmount[client] *= 2;
					
					iSpread = gI_Dealer[client] - gI_DealerCard[client];
					
					if (iSpread < 0)
						iSpread *= -1;
					
					switch (iSpread)
					{
						case 1: iSpread = 5;
						case 2: iSpread = 4;
						case 3: iSpread = 2;
						default: iSpread = 1;			
					}
				}
				
				int iCard = GetRandomInt(1, 13);
				
				PrintToChat(client, "%s Cards: \x04%i\x01 - \x04%i", CASINO_TAG, gI_Dealer[client], gI_DealerCard[client]);
				PrintToChat(client, "%s Card: \x04%i", CASINO_TAG, iCard);
				
				if (gI_Dealer[client] <= iCard >= gI_DealerCard[client] || gI_Dealer[client] >= iCard <= gI_DealerCard[client])
				{
					gI_CasinoLoses[client] += gI_BetAmount[client];
					gI_Credits[client] -= gI_BetAmount[client];
					PrintToChat(client, "%s You Lost \x04%i\x01 Credits!", CASINO_TAG, gI_BetAmount[client]);
					LogMessage("[Casino] %L has lost %i credits in Red Dog. [Cards: %i - (%i) - %i]", client, gI_BetAmount[client], gI_Dealer[client], iCard, gI_DealerCard[client]);
					if (gI_BetAmount[client] >= 1000) PrintToChatAll("%s \x0B%N\x01 has Lost \x04%i\x01 Credits in Red Dog!", CASINO_TAG, client, gI_BetAmount[client]);	
				}
				else
				{
					gI_CasinoWins[client] += gI_BetAmount[client] * iSpread;
					gI_Credits[client] += gI_BetAmount[client] * iSpread;
					PrintToChat(client, "%s You Won \x04%i\x01 Credits!", CASINO_TAG, gI_BetAmount[client] * iSpread);
					LogMessage("[Casino] %L has lost %i credits in Red Dog. [Cards: %i - (%i) - %i]", client, gI_BetAmount[client] * iSpread, gI_Dealer[client], iCard, gI_DealerCard[client]);
					if (gI_BetAmount[client] >= 1000) PrintToChatAll("%s \x0B%N\x01 has Won \x04%i\x01 Credits in Red Dog!", CASINO_TAG, client, gI_BetAmount[client] * iSpread);	
				}
				ResetCasino(client);
				
				if (gI_Credits[client] > 0)
					OpenCasinoMenu(client);
			}
		}
		case MenuAction_End: delete hMenu;
	}
}

void OpenSettingsMenu(int client)
{
	Menu hMenu = new Menu(Menu_Settings);
	hMenu.SetTitle("[Jailbreak] Settings & Stats\n ");
	
	switch (gI_PrisonerModel[client])
	{
		case 0: hMenu.AddItem("", "Prisoner: [Big Bobba]");
		case 1: hMenu.AddItem("", "Prisoner: [Mokujin]");
		case 2: hMenu.AddItem("", "Prisoner: [Skin Head]");
		case 3: hMenu.AddItem("", "Prisoner: [Burrito]");
		case 4: hMenu.AddItem("", "Prisoner: [Dishwasher]");
		case 5: hMenu.AddItem("", "Prisoner: [Burnt Stick]");
		case 6: hMenu.AddItem("", "Prisoner: [Ching Chong]");
	}
	
	switch (gI_GuardModel[client])
	{
		case 0: hMenu.AddItem("", "Guard: [Skinny Penis]\n ");
		case 1: hMenu.AddItem("", "Guard: [Shoot on Sight]\n ");
		case 2: hMenu.AddItem("", "Guard: [Dick Head]\n ");
		case 3: hMenu.AddItem("", "Guard: [Officer Kitchen]\n ");
		case 4: hMenu.AddItem("", "Guard: [Pinhead]\n ");
	}	
	
	hMenu.AddItem("", "View My Stats");
	hMenu.AddItem("", "Top 10 Players");
	hMenu.AddItem("", "Top 10 Richest");
	hMenu.AddItem("", "Top 10 Gangs\n ");
	hMenu.AddItem("", "Credit Status");
	hMenu.AddItem("", "View Rule Book");
	SetMenuPagination(hMenu, MENU_NO_PAGINATION);
	hMenu.ExitButton = true;
	hMenu.Display(client, MENU_TIME_FOREVER);	
}

public int Menu_Settings(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client))
			{
				switch (iParam)
				{
					case 0: PrisonerModels(client);
					case 1: GuardModels(client);
					case 2: OpenStatsMenu(client);
					case 3: gD_Database.Query(SQL_Callback_TopPlayers, "SELECT `steamid`, `player` FROM `jailbreak_stats` ORDER BY `guard` DESC, `prisoner` DESC, `special` DESC, `lastrequest` DESC", GetClientUserId(client));
					case 4: gD_Database.Query(SQL_Callback_Top10Richest, "SELECT `steamid`, `player` FROM `jailbreak_credits` ORDER BY `credits` DESC", GetClientUserId(client));
					case 5: gD_Database.Query(SQL_Callback_TopMenu, "SELECT * FROM `gangs_groups` ORDER BY `kills` DESC", GetClientUserId(client));
					case 6: OpenCreditsMenu(client, true);
					case 7: Cmd_Rules(client, 0);
				}
			}
		}
		case MenuAction_End: delete hMenu;
	}
}

void PrisonerModels(int client)
{
	Menu hMenu = new Menu(Menu_PrisonerModels);
	hMenu.SetTitle("[Jailbreak] Prisoner Character\n ");
	hMenu.AddItem("", "Big Bobba");
	hMenu.AddItem("", "Mokujin");
	hMenu.AddItem("", "Skin Head");
	hMenu.AddItem("", "Burrito");
	hMenu.AddItem("", "Dishwasher");
	hMenu.AddItem("", "Burnt Stick");
	hMenu.AddItem("", "Ching Chong");
	hMenu.ExitBackButton = true;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_PrisonerModels(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client))
			{
				gI_PrisonerModel[client] = iParam;
				
				char[] sValue = new char[6];
				FormatEx(sValue, 6, "%i;%i", gI_PrisonerModel[client], gI_GuardModel[client]);
				SetClientCookie(client, gH_ModelCookie, sValue);
				
				PrintToChat(client, "%sYou'll see the changes next round!", JB_TAG);
			}
		}
		case MenuAction_Cancel: if (iParam == MenuCancel_ExitBack) OpenSettingsMenu(client);
		case MenuAction_End: delete hMenu;
	}
}

void GuardModels(int client)
{
	Menu hMenu = new Menu(Menu_GuardModels);
	hMenu.SetTitle("[Jailbreak] Guard Character\n ");
	hMenu.AddItem("", "Skinny Penis");
	hMenu.AddItem("", "Shoot on Sight");
	hMenu.AddItem("", "Dick Head");
	hMenu.AddItem("", "Officer Kitchen");
	hMenu.AddItem("", "Pinhead");
	hMenu.ExitBackButton = true;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_GuardModels(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client))
			{
				gI_GuardModel[client] = iParam;
				
				char[] sValue = new char[6];
				FormatEx(sValue, 6, "%i;%i", gI_PrisonerModel[client], gI_GuardModel[client]);
				SetClientCookie(client, gH_ModelCookie, sValue);
				
				PrintToChat(client, "%sYou'll see the changes next round!", JB_TAG);
			}
		}
		case MenuAction_Cancel: if (iParam == MenuCancel_ExitBack) OpenSettingsMenu(client);
		case MenuAction_End: delete hMenu;
	}
}

void OpenStatsMenu(int client)
{
	char[] sDisplayString = new char[MAX_NAME_LENGTH];

	Menu hMenu = new Menu(Menu_Stats);
	hMenu.SetTitle("[Jailbreak] My Stats\n ");
	
	FormatEx(sDisplayString, MAX_NAME_LENGTH, "Kills: %i", gI_StatsGuardKills[client] + gI_StatsPrisonerKills[client] + gI_StatsSpecialDayKills[client] + gI_StatsLastRequestKills[client]);
	hMenu.AddItem("", sDisplayString, ITEMDRAW_DISABLED);

	FormatEx(sDisplayString, MAX_NAME_LENGTH, "Guard Kills: %i", gI_StatsGuardKills[client]);
	hMenu.AddItem("", sDisplayString, ITEMDRAW_DISABLED);
	
	FormatEx(sDisplayString, MAX_NAME_LENGTH, "Prisoner Kills: %i", gI_StatsPrisonerKills[client]);
	hMenu.AddItem("", sDisplayString, ITEMDRAW_DISABLED);
	
	FormatEx(sDisplayString, MAX_NAME_LENGTH, "Special Day Kills: %i", gI_StatsSpecialDayKills[client]);
	hMenu.AddItem("", sDisplayString, ITEMDRAW_DISABLED);
	
	FormatEx(sDisplayString, MAX_NAME_LENGTH, "Lastrequest Kills: %i", gI_StatsLastRequestKills[client]);
	hMenu.AddItem("", sDisplayString, ITEMDRAW_DISABLED);
	
	char[] sTime = new char[30];
	SecondsToTime(gI_StatsPlayTime[client], sTime);
	FormatEx(sDisplayString, MAX_NAME_LENGTH, "Playtime: %s", sTime);
	hMenu.AddItem("", sDisplayString, ITEMDRAW_DISABLED);

	hMenu.ExitBackButton = true;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_Stats(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Cancel: if (iParam == MenuCancel_ExitBack) OpenSettingsMenu(client);
		case MenuAction_End: delete hMenu;
	}
}

void OpenCreditsMenu(int client, int iPage = 0)
{
	char[] sDisplayString = new char[MAX_NAME_LENGTH];
	char[] sInfoString = new char[7];

	Menu hMenu = new Menu(Menu_Credits);
	hMenu.SetTitle("[Jailbreak] Credits\nYour Credits: %i\n ", gI_Credits[client]);

	for (int i = 1; i <= MaxClients; ++i)
	{
		if (IsClientInGame(i) && i != client)
		{			
			FormatEx(sDisplayString, MAX_NAME_LENGTH, "%N", i);
			FormatEx(sInfoString, 7, "%i", GetClientUserId(i));
			hMenu.AddItem(sInfoString, sDisplayString);
		}
	}
	
	if (hMenu.ItemCount == 0) 
	{
		PrintToChat(client, "%sCurrent Credits: \x04%i", JB_TAG, gI_Credits[client]);
		delete hMenu;
		OpenSettingsMenu(client);
		return;
	}
	
	hMenu.ExitBackButton = true;
	hMenu.DisplayAt(client, iPage, MENU_TIME_FOREVER);
}

public int Menu_Credits(Menu hMenu, MenuAction hAction, int client, int iParam)
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
					PrintToChat(client, "%s\x0E%N\x01 has \x04%i\x01 credits!", JB_TAG, target, gI_Credits[target]);
				OpenCreditsMenu(client, GetMenuSelectionPosition());
			}
		}
		case MenuAction_Cancel: if (iParam == MenuCancel_ExitBack) OpenSettingsMenu(client);
		case MenuAction_End: delete hMenu;
	}
}


/*===============================================================================================================================*/
/********************************************************* [TIMERS] **************************************************************/
/*===============================================================================================================================*/


public Action Timer_Activate(Handle hTimer, int iUserid)
{
	int client = GetClientOfUserId(iUserid);
	
	if (IsValidClient(client)) 
	{
		ChangeClientTeam(client, 2);
		
		if (!CheckCommandAccess(client, "sm_kick", ADMFLAG_CUSTOM1) && !gB_FreeDay)
			SetClientListeningFlags(client, VOICE_MUTED);	
	}
}

public Action Timer_DeleteEntities(Handle hTimer)
{	
	int iSize = gA_Entities.Length;
	
	if (iSize > 0)
	{
		char[] sName = new char[50];
		char[] sOrigin = new char[50];
		char[][] sBuffer = new char[2][50];
		
		float fOrigin[3];
		
		int iEntity = -1;
		
		bool bFound;
		
		for (int i = 0; i < iSize; ++i)
		{
			gA_EntityNames.GetString(i, sName, 50);
			gA_Entities.GetString(i, sOrigin, 50);
			ExplodeString(sOrigin, ";", sBuffer, 2, 50);
			
			while ((iEntity = FindEntityByClassname(iEntity, sName)) != -1) 
			{
				GetEntPropVector(iEntity, Prop_Send, "m_vecOrigin", fOrigin);
				
				for (int x = 0; x < 2; ++x)
				{
					if (fOrigin[x] != StringToFloat(sBuffer[x])) 
					{
						bFound = false;
						break;	
					}
					else bFound = true;
				}
				
				if (bFound) 
				{
					AcceptEntityInput(iEntity, "Kill");
					break;	
				}
			}
			iEntity = -1;
		}
	}
}

public Action Timer_RespawnBall(Handle hTimer)
{
	RespawnBall();	
}

public Action Timer_GoalZoneBuilding(Handle hTimer)
{
	if (!IsValidClient(gI_GoalZoneCreator) || !IsPlayerAlive(gI_GoalZoneCreator))
	{
		gI_GoalZoneCreator = -1;
		return Plugin_Stop;
	}
	
	float vPoints[8][3];
	
	if (GetClientButtons(gI_GoalZoneCreator) & IN_ATTACK)
	{
		float vOrigin[3];
		GetClientAbsOrigin(gI_GoalZoneCreator, vOrigin);
		gF_ZonePoint1[gI_TempZone] = vOrigin;
	}
	else if (GetClientButtons(gI_GoalZoneCreator) & IN_ATTACK2)
	{
		float vOrigin[3];
		GetClientAbsOrigin(gI_GoalZoneCreator, vOrigin);
		vOrigin[2] += 100.0;
		
		vPoints[0] = gF_ZonePoint1[gI_TempZone];
		vPoints[7] = vOrigin;
		gF_ZonePoint2[gI_TempZone] = vOrigin;
	}
	else if (GetClientButtons(gI_GoalZoneCreator) & IN_USE)
	{
		vPoints[0] = gF_ZonePoint1[gI_TempZone];
		vPoints[7] = gF_ZonePoint2[gI_TempZone];
		OpenZoneMenu(gI_GoalZoneCreator);
	}
	else 
	{
		vPoints[0] = gF_ZonePoint1[gI_TempZone];
		vPoints[7] = gF_ZonePoint2[gI_TempZone];	
	}
	
	for (int i = 1; i < 7; i++)
	{
		for (int j = 0; j < 3; j++)
		{
			vPoints[i][j] = vPoints[((i >> (2-j)) & 1) * 7][j];
		}
	}

	for (int i = 0, i2 = 3; i2 >= 0; i += i2--)
	{
		for (int j = 1; j <= 7; j += (j/2)+1)
		{
			if (j != 7-i)
			{
				TE_SetupBeamPoints(vPoints[i], vPoints[j], gI_Sprites[0], 0, 0, 0, 0.1, 5.0, 5.0, 0, 0.0, {255, 255, 255, 255}, 0);
				TE_SendToClient(gI_GoalZoneCreator);
			}
		}
	}
	return Plugin_Continue;
}

public Action Timer_DrawEveryZone(Handle hTimer, int iUserid)
{
	int client = GetClientOfUserId(iUserid);
	
	if (!IsValidClient(client) || !IsPlayerAlive(client))
		return Plugin_Stop;
	
	float vPoints[8][MAXZONELIMIT][3];
	
	for (int i = 0; i < MAXZONELIMIT; i++)
	{
		vPoints[0][i] = gF_ZonePoint1[i];
		vPoints[7][i] = gF_ZonePoint2[i];
	}
	
	for (int i = 1; i < 7; i++)
	{
		for (int j = 0; j < 3; j++)
		{
			for (int i2 = 0; i2 < MAXZONELIMIT; i2++)
			{
				vPoints[i][i2][j] = vPoints[((i >> (2-j)) & 1) * 7][i2][j];
			}
		}
	}

	for (int i = 0, i2 = 3; i2 >= 0; i += i2--)
	{
		for (int j = 1; j <= 7; j += (j/2)+1)
		{
			if (j != 7-i)
			{
				for (int i3 = 0; i3 < MAXZONELIMIT; i3++)
				{
					TE_SetupBeamPoints(vPoints[i][i3], vPoints[j][i3], gI_Sprites[0], 0, 0, 0, 1.0, 5.0, 5.0, 0, 0.0, {255, 255, 255, 255}, 0);
					TE_SendToClient(client);
				}
			}
		}
	}
	return Plugin_Continue;
}

public Action Timer_TriggerDetection(Handle hTimer)
{
	char[] sEntity = new char[50];
	
	int iEntity = -1;
	
	for (int i = 0; i < gA_Buttons.Length; ++i)
	{		
		iEntity = gA_Buttons.Get(i);

		if (IsValidEntity(iEntity)) 
		{
			GetEntityClassname(iEntity, sEntity, 50);
			
			if (StrEqual(sEntity, "func_door"))
			{
				HookSingleEntityOutput(iEntity, "OnFullyOpen", Event_OnOpen);	
				HookSingleEntityOutput(iEntity, "OnFullyClosed", Event_OnClose);	
			}
		}
	}
}

public Action Timer_EntityDetection(Handle hTimer, any iData)
{
	if (!IsValidClient(gI_Owner) || !IsPlayerAlive(gI_Owner))
	{
		gI_Owner = -1;
		return Plugin_Stop;	
	}
		
	int target = GetClientAimTarget(gI_Owner, false);
	
	if (IsValidEntity(target) && !(0 < target <= MaxClients))
	{
		char[] sEntity = new char[50];
		char[] sName = new char[100];
		char[] sEntityName = new char[64];
		GetEntPropString(target, Prop_Data, "m_iName", sEntityName, 64);
		GetEntityClassname(target, sName, 50);
		
		bool bName = false;
		
		if (sEntityName[0] != '\0')
		{
			bName = true;
			PrintHintText(gI_Owner, "<font color='#D83333'>%s</font> [<font color='#9FFF33'>%i</font>]: <font color='#c842f4'>%s</font>", sName, target, sEntityName);
		}
		else PrintHintText(gI_Owner, "<font color='#D83333'>%s</font> [<font color='#9FFF33'>%i</font>]", sName, target);
		
		if (GetClientButtons(gI_Owner) & IN_USE)
		{		
			char[] sPath = new char[PLATFORM_MAX_PATH];
			
			switch (iData)
			{			
				case 0:
				{
					if (!StrEqual(sName, "func_button"))
					{
						PrintToChat(gI_Owner, "[SM] You can only save \x02func_button\x01 entities!");
						return Plugin_Continue;	
					}
					
					if (bName)
					{
						LogAction(gI_Owner, -1, "%L saved the entity '%s [%i]: %s' (Mode 1) to the Triggers.cfg file!", gI_Owner, sName, target, sEntityName);
						PrintToChat(gI_Owner, "[SM] You saved the entity \x02%s \x01[\x04%i\x01]: \x0E%s", sName, target, sEntityName);
					}
					else
					{
						LogAction(gI_Owner, -1, "%L saved the entity '%s [%i]' (Mode 1) to the Triggers.cfg file!", gI_Owner, sName, target);
						PrintToChat(gI_Owner, "[SM] You saved the entity \x02%s \x01[\x04%i\x01]", sName, target);
					}
					
					strcopy(sEntity, 50, sName);
					Format(sName, 50, "%s [%i]", sName, target);
					
					KeyValues kv = new KeyValues("Triggers");
					
					BuildPath(Path_SM, sPath, PLATFORM_MAX_PATH, "configs/jailbreak/Triggers.cfg");
					kv.ImportFromFile(sPath);
					kv.JumpToKey(gS_Map, true);
					kv.JumpToKey(sName, true);
					if (bName) kv.SetString("name", sEntityName);
					kv.SetString("entity", sEntity);
					kv.SetNum("index", target);
					kv.SetNum("mode", 1);
					kv.Rewind();
					kv.ExportToFile(sPath);
					delete kv;	
					
					gA_ButtonName.PushString(sEntity);
					gA_Buttons.Push(target);
				}
				case 1:
				{
					if (!StrEqual(sName, "func_button"))
					{
						PrintToChat(gI_Owner, "[SM] You can only save \x02func_button\x01 entities!");
						return Plugin_Continue;	
					}
					
					if (bName)
					{
						LogAction(gI_Owner, -1, "%L saved the entity '%s [%i]: %s' (Mode 2) to the Triggers.cfg file!", gI_Owner, sName, target, sEntityName);
						PrintToChat(gI_Owner, "[SM] You saved the entity \x02%s \x01[\x04%i\x01]: \x0E%s", sName, target, sEntityName);
					}
					else
					{
						LogAction(gI_Owner, -1, "%L saved the entity '%s [%i]' (Mode 2) to the Triggers.cfg file!", gI_Owner, sName, target);
						PrintToChat(gI_Owner, "[SM] You saved the entity \x02%s \x01[\x04%i\x01]", sName, target);
					}
					
					strcopy(sEntity, 50, sName);
					Format(sName, 50, "%s [%i]", sName, target);
					
					KeyValues kv = new KeyValues("Triggers");
					BuildPath(Path_SM, sPath, PLATFORM_MAX_PATH, "configs/jailbreak/Triggers.cfg");
					kv.ImportFromFile(sPath);
					kv.JumpToKey(gS_Map, true);
					kv.JumpToKey(sName, true);
					if (bName) kv.SetString("name", sEntityName);
					kv.SetString("entity", sEntity);
					kv.SetNum("index", target);
					kv.SetNum("mode", 2);
					kv.Rewind();
					kv.ExportToFile(sPath);
					delete kv;	
					
					gA_ButtonName.PushString(sEntity);
					gA_Buttons.Push(target);
				}
				case 2:
				{
					if (bName)
					{
						LogAction(gI_Owner, -1, "%L deleted and saved the entity '%s [%i]: %s' to the Entities.cfg file!", gI_Owner, sName, target, sEntityName);
						PrintToChat(gI_Owner, "[SM] You deleted the entity \x02%s \x01[\x04%i\x01]: \x0E%s", sName, target, sEntityName);
					}
					else
					{
						LogAction(gI_Owner, -1, "%L deleted and saved the entity '%s [%i]' to the Entities.cfg file!", gI_Owner, sName, target);
						PrintToChat(gI_Owner, "[SM] You deleted the entity \x02%s \x01[\x04%i\x01]", sName, target);
					}
					
					float fOrigin[3];
					GetEntPropVector(target, Prop_Send, "m_vecOrigin", fOrigin);
					
					strcopy(sEntity, 50, sName);
					Format(sName, 100, "%s [%.02f, %.02f]", sName, fOrigin[0], fOrigin[1]);
					
					KeyValues kv = new KeyValues("Entities");
					BuildPath(Path_SM, sPath, PLATFORM_MAX_PATH, "configs/jailbreak/Entities.cfg");
					kv.ImportFromFile(sPath);
					kv.JumpToKey(gS_Map, true);
					kv.JumpToKey(sName, true);
					if (bName) kv.SetString("name", sEntityName);
					kv.SetString("entity", sEntity);
					
					FormatEx(sName, 100, "%f;%f", fOrigin[0], fOrigin[1]);
					kv.SetString("origin", sName);
					kv.Rewind();
					kv.ExportToFile(sPath);
					delete kv;	
					
					gA_EntityNames.PushString(sEntity);
					gA_Entities.PushString(sName);
					AcceptEntityInput(target, "Kill");
				}
				case 3:
				{
					if (!StrEqual(sName, "func_door"))
					{
						PrintToChat(gI_Owner, "[SM] You can only save \x02func_door\x01 entities!");
						return Plugin_Continue;	
					}
					
					if (bName)
					{
						LogAction(gI_Owner, -1, "%L saved the entity '%s [%i]: %s' to the Triggers.cfg file!", gI_Owner, sName, target, sEntityName);
						PrintToChat(gI_Owner, "[SM] You saved the entity \x02%s \x01[\x04%i\x01]: \x0E%s", sName, target, sEntityName);
					}
					else
					{
						LogAction(gI_Owner, -1, "%L saved the entity '%s [%i]' to the Triggers.cfg file!", gI_Owner, sName, target);
						PrintToChat(gI_Owner, "[SM] You saved the entity \x02%s \x01[\x04%i\x01]", sName, target);
					}
						
					strcopy(sEntity, 50, sName);
					Format(sName, 50, "%s [%i]", sName, target);
					
					KeyValues kv = new KeyValues("Triggers");
					BuildPath(Path_SM, sPath, PLATFORM_MAX_PATH, "configs/jailbreak/Triggers.cfg");
					kv.ImportFromFile(sPath);
					kv.JumpToKey(gS_Map, true);
					kv.JumpToKey(sName, true);
					if (bName) kv.SetString("name", sEntityName);
					kv.SetString("entity", sEntity);
					kv.SetNum("index", target);
					kv.Rewind();
					kv.ExportToFile(sPath);
					delete kv;	
					
					gA_ButtonName.PushString(sEntity);
					gA_Buttons.Push(target);
				}
			}
		}
	}
	return Plugin_Continue;
}

public Action Timer_Warden(Handle hTimer, int iRound)
{
	if (gI_Warden == -1 && gI_Round == iRound && gH_LastRequest == LASTREQUEST_INVALID)
	{
		int target = GetRandomClient(3);
		
		if (IsValidClient(target))
		{
			gI_Warden = target;
			gB_Paint[target] = true;
			SetGlow(target, 0, 0, 255, 255);
			FadePlayer(target, 300, 300, 0x0001, {0, 0, 255, 100});
			CS_SetClientClanTag(target, "[Warden]");
			PrintToChatAll("%s\x0B%N\x01 is the Warden!", JB_TAG, target);
			PrintCenterText(target, "You are the <font color='#0066ff'>Warden</font>!");
		}
	}
}

public Action Timer_NewWarden(Handle hTimer)
{	
	if (gI_Warden == -1 && gH_SpecialDay == SPECIALDAY_INVALID && gH_LastRequest == LASTREQUEST_INVALID && GetPlayerAliveCount(3) > 0)
	{	
		int iClient[MAXPLAYERS+1] = {-1, ...};
		int iClients = 0;
		
		for (int i = 1; i <= MaxClients; ++i)
		{
			if (IsClientInGame(i)) 
			{
				PrintCenterText(i, "The Warden Died!");
				
				if (IsPlayerAlive(i) && GetClientTeam(i) == 3)
				{
					iClient[iClients] = i;
					++iClients;	
				}
			}
		}	
		
		if (iClients > 0)
		{
			gI_Warden = iClient[GetRandomInt(0, iClients-1)];
			gB_Paint[gI_Warden] = true;
			SetGlow(gI_Warden, 0, 0, 255, 255);
			FadePlayer(gI_Warden, 300, 300, 0x0001, {0, 0, 255, 100});
			CS_SetClientClanTag(gI_Warden, "[Warden]"); 
			PrintToChatAll("%s\x0B%N\x01 is the new Warden!", JB_TAG, gI_Warden);
			PrintCenterText(gI_Warden, "You are the new <font color='#0066ff'>Warden</font>!");
		}
	}
}

public Action Timer_OpenDoors(Handle hTimer, int iRound)
{
	if (iRound == gI_Round)
	{
		gB_Expired = true;
		
		if (gH_LastRequest == LASTREQUEST_INVALID && gH_SpecialDay == SPECIALDAY_INVALID)
		{
			if (gI_Cells == 0)
			{
				gB_FreeDay = true;
				
				for (int i = 1; i <= MaxClients; ++i)
				{
					if (IsClientInGame(i))
					{
						PrintToChat(i, "%sThe \x0BGuards\x01 failed to open the cells!", JB_TAG);
						PrintCenterText(i, "<font color='#FFFF00'>It's an Unrestricted Freeday!</font>");
						
						if (gB_BaseComm)
						{
							if (!BaseComm_IsClientMuted(i))
								SetClientListeningFlags(i, VOICE_NORMAL);
						}
						else SetClientListeningFlags(i, VOICE_NORMAL);
						
						if (IsPlayerAlive(i))
						{
							FadePlayer(i, 300, 300, 0x0001, {255, 255, 102, 100});
							
							if (GetClientTeam(i) == 2)
								SetGlow(i, 255, 255, 0, 255);	
						}
					}
				}
			}
		}
		
		gB_Cells = true;
		++gI_Cells;
		Cells(true);
	}
}

public Action Timer_NightCrawler(Handle hTimer, int iUser)
{
	int client = GetClientOfUserId(iUser);
	
	if (IsValidClient(client) && IsPlayerAlive(client))
		gB_PlayerSteps[client] = true;
}

public Action Timer_Gangs(Handle hTimer)
{
	if (gH_SpecialDay != SPECIALDAY_GANG) 
		return Plugin_Stop;
	
	int iBloods = 0;
	int iCrips = 0;
	
	for (int i = 1; i <= MaxClients; ++i)
	{
		if (IsClientInGame(i) && IsPlayerAlive(i))
		{
			switch (gI_ClientStatus[i])
			{
				case COLOR_BLUE: ++iCrips;
				case COLOR_RED: ++iBloods;				
			}
		}
	}

	if (iBloods == 0 && iCrips == 0)
	{
		CS_TerminateRound(5.0, CSRoundEnd_Draw, true);
		PrintToChatAll("%sBoth \x02Bloods\x01 & \x0BCribs\x01 got smoked!", JB_TAG);
		return Plugin_Stop;
	}
	else if (iCrips == 0)
	{
		if (iBloods > 1)
		{
			bool bFlip = view_as<bool>(GetRandomInt(0,1));
			
			for (int i = 1; i <= MaxClients; ++i)
			{
				if (IsClientInGame(i) && IsPlayerAlive(i))
				{
					switch (bFlip)
					{
						case true: 
						{
							bFlip = false;
							SetGlow(i, 255, 0, 0, 255);
							FadePlayer(i, 300, 300, 0x0001, {255, 0, 0, 100});
							gI_ClientStatus[i] = COLOR_RED;
							PrintCenterText(i, "You're a <font color='#FF0000'>Blood</font> kill them <font color='#0013FE'>Crips</font>!");
							for (int b = 0; b < 3; ++b) PrintToChat(i, "%sYou're a \x02Blood\x01, Kill them \x0BCrips\x01!", JB_TAG);
						}
						case false: 
						{
							bFlip = true;
							SetGlow(i, 0, 0, 255, 255);
							FadePlayer(i, 300, 300, 0x0001, {0, 0, 255, 100});
							gI_ClientStatus[i] = COLOR_BLUE;
							PrintCenterText(i, "You're a <font color='#0013FE'>Crip</font> kill them <font color='#FF0000'>Bloods</font>!");
							for (int b = 0; b < 3; ++b) PrintToChat(i, "%sYou're a \x0BCrip\x01, Kill them \x02Bloods\x01!", JB_TAG);
						}
					}
				}
			}
		}
		else
		{
			CS_TerminateRound(5.0, CSRoundEnd_TerroristWin, true);
			PrintToChatAll("%s\x02Bloods\x01 smoked out the \x0BCrips\x01!", JB_TAG);
			return Plugin_Stop;
		}
	}
	else if (iBloods == 0)
	{
		if (iCrips > 1)
		{
			bool bFlip = view_as<bool>(GetRandomInt(0,1));
			
			for (int i = 1; i <= MaxClients; ++i)
			{
				if (IsClientInGame(i) && IsPlayerAlive(i))
				{
					switch (bFlip)
					{
						case true: 
						{
							bFlip = false;
							SetGlow(i, 255, 0, 0, 255);
							FadePlayer(i, 300, 300, 0x0001, {255, 0, 0, 100});
							gI_ClientStatus[i] = COLOR_RED;
							PrintCenterText(i, "You're a <font color='#FF0000'>Blood</font> kill them <font color='#0013FE'>Crips</font>!");
							for (int b = 0; b < 3; ++b) PrintToChat(i, "%sYou're a \x02Blood\x01, Kill them \x0BCrips\x01!", JB_TAG);
						}
						case false: 
						{
							bFlip = true;
							SetGlow(i, 0, 0, 255, 255);
							FadePlayer(i, 300, 300, 0x0001, {0, 0, 255, 100});
							gI_ClientStatus[i] = COLOR_BLUE;
							PrintCenterText(i, "You're a <font color='#0013FE'>Crip</font> kill them <font color='#FF0000'>Bloods</font>!");
							for (int b = 0; b < 3; ++b) PrintToChat(i, "%sYou're a \x0BCrip\x01, Kill them \x02Bloods\x01!", JB_TAG);
						}
					}
				}
			}
		}
		else
		{
			CS_TerminateRound(5.0, CSRoundEnd_CTWin, true);
			PrintToChatAll("%s\x0BCrips\x01 smoked out the \x02Bloods\x01!", JB_TAG);
			return Plugin_Stop;
		}
	}
	return Plugin_Continue;
}

public Action Timer_CheckHP(Handle hTimer)
{ 
	if (gH_SpecialDay == SPECIALDAY_INVALID) 
		return Plugin_Stop;
	
	for (int i = 1; i <= MaxClients; ++i)
	{
		if (IsClientInGame(i) && IsPlayerAlive(i))
		{
			if (GetClientHealth(i) > gI_CheckHealth[i] > 0)
				SetEntProp(i, Prop_Send, "m_iHealth", gI_CheckHealth[i]);
			gI_CheckHealth[i] = GetClientHealth(i);
		}
	}
	return Plugin_Continue;
}

public Action Timer_PlayTime(Handle hTimer)
{
	for (int i = 1; i <= MaxClients; ++i)
	{
		if (IsClientInGame(i) && GetClientTeam(i) > 1)
			++gI_StatsPlayTime[i];
	}
}

public Action Timer_Box(Handle hTimer, any iUser)
{
	int client = GetClientOfUserId(iUser);
	
	if (IsValidClient(client) && !IsPlayerAlive(client))
	{
		int iEntity = CreateEntityByName("prop_physics_override");
		
		if (IsValidEntity(iEntity))
		{				
			int iBox = GetRandomInt(0, 1000);
			
			int iColor[3];
			
			if (iBox == 999) // 0.1%
			{
				iColor[0] = 255;
				iColor[1] = 255;
				iColor[2] = 0;
			}
			else if (iBox < 5) // 0.5%
			{
				iColor[0] = 153;
				iColor[1] = 0;
				iColor[2] = 76;
			}
			else if (iBox < 15) // 1.0%
			{
				iColor[0] = 255;
				iColor[1] = 0;
				iColor[2] = 0;
			}
			else if (99 < iBox < 150) // 5.0%
			{
				iColor[0] = 0;
				iColor[1] = 255;
				iColor[2] = 0;
			}
			else
			{
				iColor[0] = 0;
				iColor[1] = 255;
				iColor[2] = 255;
			}	
			
			DispatchKeyValue(iEntity, "model", "models/items/cs_gift.mdl");
			DispatchKeyValue(iEntity, "physicsmode", "2");
			DispatchKeyValue(iEntity, "massScale", "1.0");
			DispatchSpawn(iEntity);
			
			SetEntProp(iEntity, Prop_Send, "m_usSolidFlags", 8);
			SetEntProp(iEntity, Prop_Send, "m_CollisionGroup", 1);
	
			SetGlow(iEntity, iColor[0], iColor[1], iColor[2], 255);
			float fOrigin[3]; GetClientAbsOrigin(client, fOrigin);
			fOrigin[2] -= 20;
			TeleportEntity(iEntity, fOrigin, NULL_VECTOR, NULL_VECTOR);
			
			int iRotator = CreateEntityByName("func_rotating");
			DispatchKeyValueVector(iRotator, "origin", fOrigin);
			DispatchKeyValue(iRotator, "maxspeed", "150");
			DispatchKeyValue(iRotator, "friction", "0");
			DispatchKeyValue(iRotator, "dmg", "0");
			DispatchKeyValue(iRotator, "solid", "0");
			DispatchKeyValue(iRotator, "spawnflags", "64");
			DispatchSpawn(iRotator);
			
			SetVariantString("!activator");
			AcceptEntityInput(iEntity, "SetParent", iRotator, iRotator);
			AcceptEntityInput(iRotator, "Start");
			SetEntPropEnt(iEntity, Prop_Send, "m_hEffectEntity", iRotator);
			SDKHook(iEntity, SDKHook_StartTouch, OnBoxTouch);
		}	
	}
}

public Action Timer_Invisiblity(Handle hTimer, any iUserID)
{
	if (gH_SpecialDay == SPECIALDAY_INVALID && gH_LastRequest == LASTREQUEST_INVALID)
	{
	 	int client = GetClientOfUserId(iUserID);
	 	
	 	if (IsValidClient(client) && IsPlayerAlive(client) && GetClientTeam(client) == 2)
	 		SetGlow(client, 255, 255, 255, 255);
	}
}

public Action Timer_RecheckSteamID(Handle hTimer, int iUserID)
{
	int client = GetClientOfUserId(iUserID);
	
	if (IsValidClient(client))
		LoadSteamID(client);
}

public Action Timer_Notify(Handle hTimer, any iData)
{
	if (iData == 0)
	{
		for (int i = 1; i <= MaxClients; ++i)
		{
			if (IsClientInGame(i))
			{
				PrintCenterText(i, "<font size=\"24\">The system is back online!</font>");
				SetEntProp(i, Prop_Send, "m_iHideHUD", GetEntProp(i, Prop_Send, "m_iHideHUD") & ~(1<<2));
			}
		}
	}
	else PrintCenterTextAll("<font size=\"24\">The power has been restored!</font>");
}

public Action Timer_GangInvite(Handle hTimer, int iUser)
{
	int client = GetClientOfUserId(iUser);

	if (IsValidClient(client))
		gB_GangInvitation[client] = false;		
}

public Action Timer_ResetButtons(Handle hTimer, any iUser)
{
	int client = GetClientOfUserId(iUser);
	
	if (IsValidClient(client))
	{
		gI_ButtonsPressed[client] = 0;		
		gH_ButtonsReset[client] = null;
	}
}

public Action Timer_Bomb(Handle hTimer, any iUser)
{
	int client = GetClientOfUserId(iUser);

	if (IsValidClient(client) && IsPlayerAlive(client) && gB_Jihad[client])
	{
		gB_Jihad[client] = false;
		
		float fExplosionPos[3];
		GetClientAbsOrigin(client, fExplosionPos);
		
		for (int i = 1; i <= MaxClients; ++i)
		{
			if (IsClientInGame(i) && IsPlayerAlive(i) && GetClientTeam(i) == 3)
			{
				float fOrigin[3]; 
				GetClientAbsOrigin(i, fOrigin);
				
				int iDamage = RoundToFloor(200.0 - (GetVectorDistance(fOrigin, fExplosionPos) / 2.0));
			
				if (iDamage <= 0)
					continue;
					
				if (GetClientHealth(i) - iDamage <= 0) {
					SDKHooks_TakeDamage(i, client, client, 500.0);
				}
				else
				{
					SetEntityHealth(i, GetClientHealth(i) - iDamage);
					IgniteEntity(i, 5.0);
				}
			}
		}
		
		int entity = CreateEntityByName("env_explosion");
		
		if (IsValidEntity(entity))
		{
			DispatchKeyValue(entity, "rendermode", "5");
			
			if (DispatchSpawn(entity))
			{
				fExplosionPos[2] += 45.0;
				SetEntProp(entity, Prop_Data, "m_iMagnitude", 0);
				TeleportEntity(entity, fExplosionPos, NULL_VECTOR, NULL_VECTOR);
				RequestFrame(Frame_TriggerExplosion, entity);
			}
		}
		EmitAmbientSound(SOUND_SHOP_BOOM, fExplosionPos, client);
		ForcePlayerSuicide(client);	
	}
}

public void Frame_ClusterThink(int iEntity)
{
	if (IsValidEntity(iEntity))
	{
		int client = GetEntPropEnt(iEntity, Prop_Data, "m_hOwnerEntity");
		
		if (IsValidClient(client) && gB_ClusterNade[client])
		{
			gB_ClusterNade[client] = false;
			SetEntProp(iEntity, Prop_Data, "m_nNextThinkTick", -1);
			DataPack hPack = new DataPack();
			CreateDataTimer(1.7, Timer_RemoveGrenade, hPack, TIMER_FLAG_NO_MAPCHANGE);
			hPack.WriteCell(EntIndexToEntRef(iEntity));
			hPack.WriteCell(GetClientUserId(client));
			hPack.Reset();
		}
	}
}

public Action Timer_RemoveGrenade(Handle hTimer, DataPack hPack)
{
	int iEntity = EntRefToEntIndex(hPack.ReadCell());
	int client = GetClientOfUserId(hPack.ReadCell());
	
	if (iEntity != INVALID_ENT_REFERENCE)
	{
		float fVelocity[3];
		GetEntPropVector(iEntity, Prop_Data, "m_vecVelocity", fVelocity);
		fVelocity[2] = 550.0;
		
		float fPos[3];
		GetEntPropVector(iEntity, Prop_Send, "m_vecOrigin", fPos);
		fPos[2] += 5.0;
		
		float fAng[3];
		GetEntPropVector(iEntity, Prop_Data, "m_angRotation", fAng);
		
		if (IsValidClient(client))
		{
			int iGrenade[5];
		
			for (int i = 0; i < sizeof(iGrenade); ++i)
			{
				iGrenade[i] = CreateEntityByName("hegrenade_projectile");
				
				if (IsValidEntity(iGrenade[i]) && DispatchSpawn(iGrenade[i]))
				{
					SetEntProp(iGrenade[i], Prop_Send, "m_nSolidType", 0);
					SetEntPropEnt(iGrenade[i], Prop_Data, "m_hThrower", client);
					SetEntProp(iGrenade[i], Prop_Send, "m_iTeamNum", GetClientTeam(client));  
					
					switch (i)
					{
						case 0:
						{
							fVelocity[0] = 0.0;
							fVelocity[1] = 0.0;
						}
						case 1:
						{
							fVelocity[0] = 50.0;
							fVelocity[1] = 50.0;
						}
						case 2:
						{
							fVelocity[0] = -50.0;
							fVelocity[1] = -50.0;
						}
						case 3:
						{
							fVelocity[0] = -50.0;
							fVelocity[1] = 50.0;
						}
						case 4:
						{
							fVelocity[0] = 50.0;
							fVelocity[1] = -50.0;
						}
					}
						
					TeleportEntity(iGrenade[i], fPos, fAng, fVelocity);	
					
					DataPack hPack2 = new DataPack();
					CreateDataTimer(1.7, Timer_ExplodeGrenades, hPack2, TIMER_FLAG_NO_MAPCHANGE);
					hPack2.WriteCell(EntIndexToEntRef(iGrenade[i]));
					hPack2.WriteCell(GetClientUserId(client));
					hPack2.Reset();
					
					int iColor[4];
					iColor[0] = GetRandomInt(30, 255);
					iColor[1] = GetRandomInt(30, 255);
					iColor[2] = GetRandomInt(30, 255);
					iColor[3] = 255;
					
					TE_SetupBeamFollow(iGrenade[i], gI_Sprites[0], 0, 1.7, 2.2, 2.2, 1, iColor);
					TE_SendToAll();	
				}
			}
		}
		
		AcceptEntityInput(iEntity, "Kill");
	}
}

public Action Timer_ExplodeGrenades(Handle hTimer, DataPack hPack)
{
	int iEntity = EntRefToEntIndex(hPack.ReadCell());
	int client = GetClientOfUserId(hPack.ReadCell());
	
	if (iEntity != INVALID_ENT_REFERENCE)
	{
		float fPos[3];
		GetEntPropVector(iEntity, Prop_Send, "m_vecOrigin", fPos);
		fPos[2] += 5.0;
		
		AcceptEntityInput(iEntity, "Kill");
		
		int entity = CreateEntityByName("env_explosion");
		
		if (IsValidEntity(entity))
		{
			DispatchKeyValue(entity, "rendermode", "5");
			
			if (DispatchSpawn(entity))
			{
				SetEntProp(entity, Prop_Data, "m_iMagnitude", 85);
				SetEntProp(entity, Prop_Data, "m_iRadiusOverride", 390);
				SetEntProp(entity, Prop_Data, "m_iTeamNum", 2);
				
				if (IsValidClient(client)) SetEntPropEnt(entity, Prop_Data, "m_hOwnerEntity", client);
		
				TeleportEntity(entity, fPos, NULL_VECTOR, NULL_VECTOR);
				EmitAmbientSound("weapons/hegrenade/explode4.wav", fPos, entity);
				RequestFrame(Frame_TriggerExplosion, entity);
			}
		}
	}
}

public Action Timer_GiveGuns(Handle hTimer, any UserId)
{
	int client = GetClientOfUserId(UserId);
	
	if (IsValidClient(client) && IsPlayerAlive(client))
	{
		if (gB_GunMenu[client])
			GiveWeapons(client);
		else
			OpenGunsMenu(client, false);
	}	
}

public Action Timer_Countdown(Handle hTimer, int iRound)
{	
	if (gI_Round != iRound || gI_Seconds < 0)
		return Plugin_Stop;
	
	if (gH_SpecialDay != SPECIALDAY_INVALID)
	{
		if (gH_LastRequest != LASTREQUEST_INVALID)
		{
			gH_SpecialDay = SPECIALDAY_INVALID;
			return Plugin_Stop;	
		}
		
		switch (gI_Seconds)
		{
			case 5, 4, 3, 2, 1:
			{
				char[] sCountdown = new char[50];
				FormatEx(sCountdown, 50, "*lenhard/jailbreak/%i.mp3", gI_Seconds); 
				EmitSoundToAll(sCountdown);
			}
		}
		
		char[] sDay = new char[30];
		DayNames(sDay);
		
		SetHudTextParams(-1.0, 0.45, 1.0, 255, 0, 0, 200, 0, 0.0, 0.0, 0.0);
		
		for (int i = 1; i <= MaxClients; ++i)
		{
			if (IsClientInGame(i)) {
				ShowHudText(i, 5, "%s in [%i]", sDay, gI_Seconds);			
			}
		}
		
		if (gI_Seconds == 0) TriggerSpecialDays(); 
		
	}
	else if (gH_LastRequest != LASTREQUEST_INVALID)
	{
		if (IsValidClient(gI_Guard) && IsValidClient(gI_Prisoner))
		{
			char[] sLastrequest = new char[30];
			LastrequestNames(sLastrequest);
			
			SetHudTextParams(-1.0, 0.45, 1.0, 0, 255, 0, 200, 0, 0.0, 0.0, 0.0);
			
			int iHealth;
			
			switch (gI_LRHealth[gI_Prisoner])
			{
				case 0: iHealth = 35;
				case 1: iHealth = 100;
				case 2: iHealth = 250;
				case 3: iHealth = 500;
				default: iHealth = 100;
			}
			
			for (int i = 1; i <= MaxClients; ++i)
			{
				if (IsClientInGame(i)) {
					ShowHudText(i, 5, "%s [%i HP]\nin [%i]", sLastrequest, iHealth, gI_Seconds);		
				}					
			}
			
			if (gI_Seconds == 0) TriggerLastRequest();
			
			char[] sCountdown = new char[50];
			FormatEx(sCountdown, 50, "*lenhard/jailbreak/%i.mp3", gI_Seconds); 
			EmitSoundToAll(sCountdown);
		}
	}
	else return Plugin_Stop;
	gI_Seconds--;
	return Plugin_Continue;
}

public Action Timer_DrawEverything(Handle hTimer)
{
	if (gF_MakerPos[0] != 0.0)
	{
		TE_SetupBeamRingPoint(gF_MakerPos, 200.0, 200.1, gI_Sprites[0], gI_Sprites[1], 0, 0, 0.1, 5.0, 0.0, {0, 0, 255, 255}, 0, 0);
		TE_SendToAll();
	}
	
	if (IsValidEntity(gI_Ball))
	{
		TE_SetupBeamFollow(gI_Ball, gI_Sprites[0], 0, 0.3, 3.3, 3.3, 1, {66, 188, 244, 255});
		TE_SendToAll();	
	}
	
	float fPosition[3];
	
	for (int i = 1; i <= MaxClients; ++i)
	{
		if (IsClientInGame(i))
		{
			if (IsPlayerAlive(i))
			{
				if (gB_Paint[i])
				{
					if (GetClientButtons(i) & IN_USE)
					{
						if (!gF_Laser[i][0] && !gF_Laser[i][1])
							GetPlayerEyeViewPoint(i, gF_Laser[i]);
						GetPlayerEyeViewPoint(i, fPosition);
						
						if (GetVectorDistance(fPosition, gF_Laser[i]) > 6.0)
						{
							switch (GetClientTeam(i))
							{
								case 2: TE_SetupBeamPoints(gF_Laser[i], fPosition, gI_Sprites[0], 0, 0, 0, PAINTLIFETIME, 2.0, 2.0, 10, 0.0, {255, 0, 0, 255}, 0); 
								case 3: TE_SetupBeamPoints(gF_Laser[i], fPosition, gI_Sprites[0], 0, 0, 0, PAINTLIFETIME, 2.0, 2.0, 10, 0.0, {0, 0, 255, 255}, 0); 		
							}
							TE_SendToAll();
							
							for (int x = 0; x < 3; ++x)
								gF_Laser[i][x] = fPosition[x];
			
						}
					}
					else
					{
						for (int x = 0; x < 3; ++x)
							gF_Laser[i][x] = 0.0;	
					}
				}
			} 
		}
	}
}

public Action Timer_FreedayObjective(Handle hTimer, int iRound)
{
	if (iRound == gI_Round && !gB_LastRequest_Available)
	{
		for (int i = 1; i <= MaxClients; ++i)
		{
			if (IsClientInGame(i) && IsPlayerAlive(i) && GetClientTeam(i) == 2)
			{
				PrintToChat(i, "%sYou failed to do your objective!", JB_TAG);	
				ForcePlayerSuicide(i);
			}
		}	
	}
}

public Action Timer_Jihad(Handle hTimer, any iUserID)
{
	int client = GetClientOfUserId(iUserID);
	
	if (IsValidClient(client) && IsPlayerAlive(client))
	{
		float fExplosionPos[3];
		GetClientAbsOrigin(client, fExplosionPos);
		fExplosionPos[2] += 40.0;
		
		int entity = CreateEntityByName("env_explosion");
		
		if (IsValidEntity(entity))
		{
			DispatchKeyValue(entity, "rendermode", "5");
			
			if (DispatchSpawn(entity))
			{
				SetEntProp(entity, Prop_Data, "m_iMagnitude", 200);
				SetEntProp(entity, Prop_Data, "m_iRadiusOverride", 400);
				SetEntProp(entity, Prop_Data, "m_iTeamNum", 2);
				SetEntPropEnt(entity, Prop_Data, "m_hOwnerEntity", client);
		
				TeleportEntity(entity, fExplosionPos, NULL_VECTOR, NULL_VECTOR);
				RequestFrame(Frame_TriggerExplosion, entity);
			}
		}
		EmitAmbientSound(SOUND_LR_BOOM, fExplosionPos, client);	
		ForcePlayerSuicide(client);	
	}
}

public Action Timer_Tag(Handle hTimer, int iUser)
{
	int client = GetClientOfUserId(iUser);
	
	if (IsValidClient(client))
	{
		int iEntity = CreateEntityByName("prop_physics_override");
		
		if (IsValidEntity(iEntity))
		{				
			DispatchKeyValue(iEntity, "model", "models/chicken/chicken.mdl");
			DispatchKeyValue(iEntity, "physicsmode", "2");
			DispatchKeyValue(iEntity, "massScale", "1.0");
			DispatchSpawn(iEntity);
			
			SetEntPropEnt(iEntity, Prop_Data, "m_hOwnerEntity", client);
			SetEntProp(iEntity, Prop_Send, "m_usSolidFlags", 8);
			SetEntProp(iEntity, Prop_Send, "m_CollisionGroup", 1);
	
			float fOrigin[3]; GetClientAbsOrigin(client, fOrigin);
			fOrigin[2] -= 20;
			TeleportEntity(iEntity, fOrigin, NULL_VECTOR, NULL_VECTOR);
			
			int iRotator = CreateEntityByName("func_rotating");
			DispatchKeyValueVector(iRotator, "origin", fOrigin);
			DispatchKeyValue(iRotator, "maxspeed", "150");
			DispatchKeyValue(iRotator, "friction", "0");
			DispatchKeyValue(iRotator, "dmg", "0");
			DispatchKeyValue(iRotator, "solid", "0");
			DispatchKeyValue(iRotator, "spawnflags", "64");
			DispatchSpawn(iRotator);
			
			SetVariantString("!activator");
			AcceptEntityInput(iEntity, "SetParent", iRotator, iRotator);
			AcceptEntityInput(iRotator, "Start");
			SetEntPropEnt(iEntity, Prop_Send, "m_hEffectEntity", iRotator);
			
			SetVariantString("OnUser1 !self:kill::4.5:1");
			AcceptEntityInput(iEntity, "AddOutput");
			AcceptEntityInput(iEntity, "FireUser1");
			SDKHook(iEntity, SDKHook_StartTouch, OnTagTouch);
		}
	}
}

public Action Timer_Respawn(Handle hTimer, int iUser)
{
	int client = GetClientOfUserId(iUser);
	
	if (IsValidClient(client) && !IsPlayerAlive(client))
	{
		switch (gH_SpecialDay)
		{
			case SPECIALDAY_KNIFE:
			{
				if (gI_Activity[client] > 0)
				{
					CS_RespawnPlayer(client);
					gI_CheckHealth[client] = 35;
					SetEntityHealth(client, 35);
					PrintToChat(client, "%sYou have \x04%i\x01 lives left!", JB_TAG, gI_Activity[client]);	
				}
			}
			case SPECIALDAY_GUNGAME, SPECIALDAY_KILLCONFIRM:
			{
				if (gI_Activity[client] != -1)
				{
					gI_CheckHealth[client] = 100;
					CS_RespawnPlayer(client);
				}
			}
		}
	}	
}

public Action Timer_Vote(Handle hTimer, float fTime) 
{
	if (gH_SpecialDay != SPECIALDAY_VOTE)
		return Plugin_Stop;
		
	int iVotes = 0;
	int iNoVote = 0;
	
	ArrayList aArray = new ArrayList(66);
		
	for (int i = 1; i <= MaxClients; ++i)
	{
		if (IsClientInGame(i))
		{
			aArray.Push(i);
			
			if (gI_ClientVote[i] != -1)
				++iVotes;
			else
				++iNoVote;
		}
	}
	
	float fGameTime = GetGameTime();

	if (iNoVote > 0 && fGameTime <= fTime)
	{
		for (int i = 0; i < aArray.Length; ++i) {
			PrintHintText(aArray.Get(i), "<font color='#42f459'>Voted:</font> %i\n<font color='#b23320'>No Vote:</font> %i\n<font color='#2088b2'>Voting Time:</font> %i", iVotes, iNoVote, RoundToNearest(fTime - fGameTime));
		}
	}
	else
	{
		int iPlayers[view_as<int>(SPECIALDAY_VOTE)] = {0, ...};
		int client;
		
		for (int i = 0; i < aArray.Length; ++i)
		{
			client = aArray.Get(i);
			
			if (gI_ClientVote[client] != -1)
			{
				++iPlayers[gI_ClientVote[client]];
				gI_ClientVote[client] = -1;
			}
		}
		
		int iCount;
		int iTemp;
		int iTempDay = -1;
		int iDay = -1;
		int iDayFinish = -1;
		
		for (int i = 0; i < view_as<int>(SPECIALDAY_VOTE); ++i)
		{
			if (iCount > iPlayers[i])
				continue;
				
			if (iCount > 0 && iCount == iPlayers[i])
			{
				iTemp = iPlayers[i];
				iTempDay = i;		
			}
				
			iCount = iPlayers[i];
			iDay = i;
		}
		
		if (iCount == 0)
		{
			iDayFinish = GetRandomInt(0, view_as<int>(SPECIALDAY_VOTE)-1);
			PrintToChatAll("%sNo one voted! Selecting a random Special Day...", JB_TAG);
		}
		else if (iTemp == iCount)
		{
			PrintToChatAll("%sThe vote was a tie! Randomly selecting...", JB_TAG);
			
			if (iTempDay > iDay)
				iDayFinish = GetRandomInt(iDay, iTempDay);
			else
				iDayFinish = GetRandomInt(iTempDay, iDay);
		}
		else iDayFinish = iDay;
		
		gH_SpecialDay = view_as<SpecialDay>(iDayFinish);
		EnableSpecialDay(1337);		
		return Plugin_Stop;	
	}
	return Plugin_Continue;
}

public Action Timer_KnifeDuel(Handle hTimer, DataPack hPack)
{
	if (!gB_KnifeDuel)
		return Plugin_Stop;
	
	int iPlayer = GetClientOfUserId(hPack.ReadCell());	
	int iPlayer2 = GetClientOfUserId(hPack.ReadCell());
	
	hPack.Reset();
	
	if (IsValidClient(iPlayer) && IsPlayerAlive(iPlayer) && IsValidClient(iPlayer2) && IsPlayerAlive(iPlayer2))
	{
		TE_SetupBeamRing(iPlayer, iPlayer2, gI_Sprites[0], gI_Sprites[1], 0, 0, 0.1, 1.0, 0.0, {255,0,255,255}, 0, 0);
		TE_SendToAll();
	}
	else 
	{
		gB_KnifeDuel = false;
		return Plugin_Stop;
	}
	return Plugin_Continue;
}

public void Frame_TriggerExplosion(int entity)
{
	AcceptEntityInput(entity, "explode");
	AcceptEntityInput(entity, "Kill");
}

public Action Timer_TickingTimeBombInterval(Handle hTimer, float fBombTime)
{
	if (!gB_TickingTimeBomb)
		return Plugin_Stop;
	
	if (IsValidClient(gI_Prisoner) && IsPlayerAlive(gI_Prisoner))
	{
		float fTime = fBombTime - GetGameTime(); 
		
		if (fTime <= 0.0)
		{
			gB_TickingTimeBomb = false;
			
			float fPos[3];
			GetClientAbsOrigin(gI_Prisoner, fPos);
			fPos[2] += 40.0;
			ForcePlayerSuicide(gI_Prisoner);
			PrintToChatAll("%s\x09%N\x01 has died from the ticking time bomb!", JB_TAG, gI_Prisoner);
			
			int entity = CreateEntityByName("env_explosion");
			
			if (IsValidEntity(entity))
			{
				DispatchKeyValue(entity, "rendermode", "5");
				
				if (DispatchSpawn(entity))
				{
					SetEntProp(entity, Prop_Data, "m_iMagnitude", 0);
					TeleportEntity(entity, fPos, NULL_VECTOR, NULL_VECTOR);
					EmitAmbientSound("weapons/hegrenade/explode4.wav", fPos, entity);
					RequestFrame(Frame_TriggerExplosion, entity);
				}
			}
			gI_Prisoner = -1;
			return Plugin_Stop;
		}
		else EmitSoundToAll(fTime < 2.0 ? SOUND_C4_5 : (fTime < 3.0 ? SOUND_C4_4 : (fTime < 4.0 ? SOUND_C4_3 : (fTime < 5.0 ? SOUND_C4_2 : SOUND_C4_1))), gI_Prisoner, SNDCHAN_BODY);
	}
	else return Plugin_Stop;
	return Plugin_Continue;
}

public Action Timer_TypingPhrase(Handle hTimer)
{
	if (gH_LastRequest != LASTREQUEST_TYPING && gH_LastRequest != LASTREQUEST_KEYS && (!IsValidClient(gI_Guard) || !IsValidClient(gI_Prisoner)))
		return Plugin_Stop;
	
	SetHudTextParams(-1.0, 0.4, 0.4, 255, 255, 255, 255, 0, 0.0, 0.0, 0.0);
	
	for (int i = 1; i <= MaxClients; ++i)
	{
		if (IsClientInGame(i))
			ShowHudText(i, 1, gS_TypingPhrase);
	}
	return Plugin_Continue;
}

public Action Timer_MathExpired(Handle hTimer, DataPack hPack)
{		
	if (gB_Math && hPack.ReadCell() == gI_Round && hPack.ReadCell() == gI_Answer)
	{
		gB_Math = false;
		PrintToChatAll("%sMath Challenge has expired! (Answer: \x04%i\x01)", JB_TAG, gI_Answer);
	}
}

public void Frame_Output(DataPack hPack) 
{ 
	int playersNum = hPack.ReadCell(); 
	int[] players = new int[playersNum]; 
	int player, players_count; 

	for (int i = 0; i < playersNum; ++i) 
	{ 
		player = hPack.ReadCell(); 

		if (IsClientInGame(player)) 
			players[players_count++] = player; 
	} 

	playersNum = players_count; 

	if (playersNum >= 1) 
	{
		Handle pb = StartMessage("TextMsg", players, playersNum, USERMSG_BLOCKHOOKS); 
		PbSetInt(pb, "msg_dst", 3); 
	
		int buffer_size = hPack.ReadCell() + 15; 
		char[] buffer = new char[buffer_size]; 
		
		hPack.ReadString(buffer, buffer_size);
		Format(buffer, buffer_size, " \x10[Server]\x01%s", buffer[4]);
	
		PbAddString(pb, "params", buffer); 
		PbAddString(pb, "params", NULL_STRING); 
		PbAddString(pb, "params", NULL_STRING); 
		PbAddString(pb, "params", NULL_STRING); 
		PbAddString(pb, "params", NULL_STRING); 
		EndMessage(); 
	}
	delete hPack;
}  


/*===============================================================================================================================*/
/********************************************************* [SQL] *****************************************************************/
/*===============================================================================================================================*/


void LoadSQL()
{
	if (gD_Database != null)
		delete gD_Database;
		
	char[] sError = new char[PLATFORM_MAX_PATH];
	
	if (!(gD_Database = SQL_Connect("gangs", true, sError, PLATFORM_MAX_PATH)))
		SetFailState(sError);
	
	gD_Database.SetCharset("utf8mb4");
	gD_Database.Query(SQL_Error, "CREATE TABLE IF NOT EXISTS `jailbreak_credits` (`id` int(20) NOT NULL AUTO_INCREMENT, `steamid` varchar(32) NOT NULL, `player` varchar(32) NOT NULL, `credits` int(20) NOT NULL, `casinowins` int(20) NOT NULL, `casinoloses` int(20) NOT NULL, PRIMARY KEY (`id`)) AUTO_INCREMENT=1", 1);
	gD_Database.Query(SQL_Error, "CREATE TABLE IF NOT EXISTS `gangs_players` (`id` int(20) NOT NULL AUTO_INCREMENT, `steamid` varchar(32) NOT NULL, `player` varchar(32) NOT NULL, `gang` varchar(32) NOT NULL, `rank` int(1) NOT NULL, `invitedby` varchar(32) NOT NULL, `date` int(32) NOT NULL, PRIMARY KEY (`id`)) AUTO_INCREMENT=1", 1);
	gD_Database.Query(SQL_Error, "CREATE TABLE IF NOT EXISTS `gangs_groups` (`id` int(20) NOT NULL AUTO_INCREMENT, `gang` varchar(32) NOT NULL, `health` int(2) NOT NULL, `damage` int(2) NOT NULL, `gravity` int(2) NOT NULL, `speed` int(2) NOT NULL, `size` int(2) NOT NULL, `evasion` int(2) NOT NULL, `stealing` int(2) NOT NULL, `weapondrop` int(2) NOT NULL, `kills` int(15) NOT NULL, PRIMARY KEY (`id`)) AUTO_INCREMENT=1", 1);
	gD_Database.Query(SQL_Error, "CREATE TABLE IF NOT EXISTS `jailbreak_stats` (`id` int(20) NOT NULL AUTO_INCREMENT, `steamid` varchar(32) NOT NULL, `player` varchar(32) NOT NULL, `guard` int(16) NOT NULL, `prisoner` int(16) NOT NULL, `special` int(16) NOT NULL, `lastrequest` int(16) NOT NULL, `time` int(20) NOT NULL, PRIMARY KEY (`id`)) AUTO_INCREMENT=1", 1);
} 

public void SQL_Error(Database hDatabase, DBResultSet hResults, const char[] sError, int iData)
{
	if (hResults == null) ThrowError(sError);
}

void LoadSteamID(int client)
{
	if (gD_Database == null)
	{
		LoadSQL();
		CreateTimer(5.0, Timer_RecheckSteamID, GetClientUserId(client), TIMER_FLAG_NO_MAPCHANGE);
	}
	else
	{
		if (GetClientAuthId(client, AuthId_Steam2, gS_SteamID[client], MAX_NAME_LENGTH))
		{
			int iUser = GetClientUserId(client);
			
			char[] sQuery = new char[PLATFORM_MAX_PATH];
			FormatEx(sQuery, PLATFORM_MAX_PATH, "SELECT * FROM `jailbreak_stats` WHERE steamid=\"%s\"", gS_SteamID[client]);
			gD_Database.Query(SQLCallback_CheckSQL_Stats, sQuery, iUser);
			
			FormatEx(sQuery, PLATFORM_MAX_PATH, "SELECT * FROM `jailbreak_credits` WHERE steamid=\"%s\"", gS_SteamID[client]);
			gD_Database.Query(SQLCallback_CheckSQL_Credits, sQuery, iUser);
		}
	}
}

public void SQLCallback_CheckSQL_Stats(Database hDatabase, DBResultSet hResults, const char[] sError, int iUserID)
{
	if (hResults == null) 
		ThrowError(sError);
	
	int client = GetClientOfUserId(iUserID);
	
	if (IsValidClient(client))
	{
		char[] sQuery = new char[256];
		
		if (hResults.RowCount == 1)
		{
			hResults.FetchRow();
			gI_StatsGuardKills[client] = hResults.FetchInt(3);
			gI_StatsPrisonerKills[client] = hResults.FetchInt(4);
			gI_StatsSpecialDayKills[client] = hResults.FetchInt(5);
			gI_StatsLastRequestKills[client] = hResults.FetchInt(6);
			gI_StatsPlayTime[client] = hResults.FetchInt(7);
		}
		else
		{
			if (hResults.RowCount > 1)
			{
				gD_Database.Query(SQL_Error, "delete jailbreak_stats from jailbreak_stats inner join (select min(id) minid, steamid from jailbreak_stats group by steamid having count(1) > 1) as duplicates on (duplicates.steamid = jailbreak_stats.steamid and duplicates.minid <> jailbreak_stats.id)", 4);
				CreateTimer(20.0, Timer_RecheckSteamID, GetClientUserId(client), TIMER_FLAG_NO_MAPCHANGE);
			}
			else if (gD_Database == null) 
			{
				LoadSQL();
				CreateTimer(5.0, Timer_RecheckSteamID, GetClientUserId(client), TIMER_FLAG_NO_MAPCHANGE);
			}
			else 
			{
				gB_Loaded[client] = true;
				FormatEx(sQuery, 256, "INSERT INTO `jailbreak_stats` (steamid, player, guard, prisoner, special, lastrequest, time) VALUES (\"%s\", \"%N\", %i, %i, %i, %i, %i)", gS_SteamID[client], client, gI_StatsGuardKills[client], gI_StatsPrisonerKills[client], gI_StatsSpecialDayKills[client], gI_StatsLastRequestKills[client], gI_StatsPlayTime[client]);
				gD_Database.Query(SQL_Error, sQuery);
			}
		}
	}
}

public void SQLCallback_CheckSQL_Credits(Database hDatabase, DBResultSet hResults, const char[] sError, int iUserID)
{
	if (hResults == null) 
		ThrowError(sError);
	
	int client = GetClientOfUserId(iUserID);
	
	if (IsValidClient(client))
	{
		char[] sQuery = new char[256];
		
		if (hResults.RowCount == 1)
		{
			hResults.FetchRow();
			gI_Credits[client] = hResults.FetchInt(3);
			gI_CasinoWins[client] = hResults.FetchInt(4);
			gI_CasinoLoses[client] = hResults.FetchInt(5);
			
			FormatEx(sQuery, 256, "SELECT * FROM `gangs_players` WHERE steamid=\"%s\"", gS_SteamID[client]);
			gD_Database.Query(SQLCallback_CheckSQL_Player, sQuery, GetClientUserId(client));
		}
		else
		{
			if (hResults.RowCount > 1)
			{
				gD_Database.Query(SQL_Error, "delete jailbreak_credits from jailbreak_credits inner join (select min(id) minid, steamid from jailbreak_credits group by steamid having count(1) > 1) as duplicates on (duplicates.steamid = jailbreak_credits.steamid and duplicates.minid <> jailbreak_credits.id)", 4);
				CreateTimer(20.0, Timer_RecheckSteamID, GetClientUserId(client), TIMER_FLAG_NO_MAPCHANGE);
			}
			else if (gD_Database == null) 
			{
				LoadSQL();
				CreateTimer(5.0, Timer_RecheckSteamID, GetClientUserId(client), TIMER_FLAG_NO_MAPCHANGE);
			}
			else 
			{
				gB_Loaded[client] = true;
				FormatEx(sQuery, 256, "INSERT INTO `jailbreak_credits` (steamid, player, credits, casinowins, casinoloses) VALUES (\"%s\", \"%N\", %i, %i, %i)", gS_SteamID[client], client, gI_Credits[client], gI_CasinoWins[client], gI_CasinoLoses[client]);
				gD_Database.Query(SQL_Error, sQuery);
			}
		}
	}
}

public void SQLCallback_CheckSQL_Player(Database hDatabase, DBResultSet hResults, const char[] sError, int iUserID)
{
	if (hResults == null) 
		ThrowError(sError);
	
	int client = GetClientOfUserId(iUserID);
	
	if (IsValidClient(client))
	{
		if (hResults.RowCount == 1)
		{
			hResults.FetchRow();
			hResults.FetchString(3, gS_GangName[client], MAX_NAME_LENGTH);
			gI_Rank[client] = hResults.FetchInt(4);
			hResults.FetchString(5, gS_InvitedBy[client], MAX_NAME_LENGTH);
			gI_DateJoined[client] = hResults.FetchInt(6);
			
			gB_HasGang[client] = true;
			gB_Loaded[client] = true;

			char[] sQuery = new char[PLATFORM_MAX_PATH];
			FormatEx(sQuery, PLATFORM_MAX_PATH, "SELECT * FROM gangs_groups WHERE gang=\"%s\"", gS_GangName[client]);
			gD_Database.Query(SQLCallback_CheckSQL_Groups, sQuery, GetClientUserId(client));
		}
		else
		{
			if (hResults.RowCount > 1)
			{
				gD_Database.Query(SQL_Error, "delete gangs_players from gangs_players inner join (select min(id) minid, steamid from gangs_players group by steamid having count(1) > 1) as duplicates on (duplicates.steamid = gangs_players.steamid and duplicates.minid <> gangs_players.id)", 4);
				CreateTimer(20.0, Timer_RecheckSteamID, GetClientUserId(client), TIMER_FLAG_NO_MAPCHANGE);
			}
			else if (gD_Database == null) 
			{
				LoadSQL();
				CreateTimer(5.0, Timer_RecheckSteamID, GetClientUserId(client), TIMER_FLAG_NO_MAPCHANGE);
			}
			else
			{
				gB_HasGang[client] = false;
				gB_Loaded[client] = true;
			}
		}
	}
}

public void SQLCallback_CheckSQL_Groups(Database hDatabase, DBResultSet hResults, const char[] sError, int iUserID)
{
	if (hResults == null) 
		ThrowError(sError);
	
	int client = GetClientOfUserId(iUserID);
	
	if (IsValidClient(client) && hResults.RowCount == 1)
	{
		hResults.FetchRow();
		gI_Health[client] = hResults.FetchInt(2);
		gI_Damage[client] = hResults.FetchInt(3);
		gI_Gravity[client] = hResults.FetchInt(4);
		gI_Speed[client] = hResults.FetchInt(5);
		gI_Size[client] = hResults.FetchInt(6);
		gI_Evade[client] = hResults.FetchInt(7);
		gI_Stealing[client] = hResults.FetchInt(8);
		gI_WeaponDrop[client] = hResults.FetchInt(9);
	}
}

void StartOpeningGangMenu(int client)
{
	if (gS_GangName[client][0] != '\0')
	{
		char[] sQuery = new char[200];
		FormatEx(sQuery, 200, "SELECT * FROM gangs_players WHERE gang = \"%s\"", gS_GangName[client]);
		gD_Database.Query(SQLCallback_OpenGangMenu, sQuery, GetClientUserId(client));
	}
	else OpenGangsMenu(client);
}

public void SQLCallback_OpenGangMenu(Database hDatabase, DBResultSet hResults, const char[] sError, int iUserID)
{
	if (hResults == null) ThrowError(sError);
	
	int client = GetClientOfUserId(iUserID);
	
	if (IsValidClient(client))
	{
		gI_GangSize[client] = hResults.RowCount;
		OpenGangsMenu(client);
	}
}

void OpenGangsMenu(int client)
{
	char[] sFormat = new char[128];
	
	if (gB_HasGang[client])
		FormatEx(sFormat, 128, "Gangs Menu \nCredits: %i \nCurrent Gang: %s\nSize: %i/%i\n ", gI_Credits[client], gS_GangName[client], gI_GangSize[client], MAXGANGSIZE + gI_Size[client]);
	else
		FormatEx(sFormat, 128, "Gangs Menu \nCredits: %i \nCurrent Gang: N/A\n ", gI_Credits[client]);
	
	Menu hMenu = new Menu(Menu_Gangs);
	hMenu.SetTitle(sFormat);
	
	FormatEx(sFormat, 128, "Create a Gang! [%i Credits]", GANG_CREATE_PRICE);
	hMenu.AddItem("", sFormat, (gB_HasGang[client] || gI_Credits[client] < GANG_CREATE_PRICE)?ITEMDRAW_DISABLED:ITEMDRAW_DEFAULT);
	
	hMenu.AddItem("", "Invite Members", (gB_HasGang[client] && gI_Rank[client] > GANGRANK_NORMAL && gI_GangSize[client] < MAXGANGSIZE + gI_Size[client])?ITEMDRAW_DEFAULT:ITEMDRAW_DISABLED);
	hMenu.AddItem("", "Gang Members", (gB_HasGang[client])?ITEMDRAW_DEFAULT:ITEMDRAW_DISABLED);
	hMenu.AddItem("", "Gang Perks", (gB_HasGang[client])?ITEMDRAW_DEFAULT:ITEMDRAW_DISABLED);
	hMenu.AddItem("", "Gang Settings", (gI_Rank[client] >= GANGRANK_ADMIN)?ITEMDRAW_DEFAULT:ITEMDRAW_DISABLED);
	hMenu.AddItem("", "Gang Exit", (gB_HasGang[client])?ITEMDRAW_DEFAULT:ITEMDRAW_DISABLED);
	hMenu.ExitBackButton = true;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_Gangs(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client) && GetClientTeam(client) == 2)
			{
				switch (iParam)
				{
					case 0: 
					{
						for (int i = 0; i <= 5; ++i) PrintToChat(client, "%s \x06Please type desired gang name in chat!", GANG_TAG);
						gB_SetName[client] = true;
					}
					case 1: OpenInvitationMenu(client);
					case 2: StartOpeningMembersMenu(client);
					case 3: StartOpeningPerkMenu(client);
					case 4: OpenAdministrationMenu(client);
					case 5: OpenLeaveConfirmation(client);
				}
			}
		}
		case MenuAction_Cancel: if (iParam == MenuCancel_ExitBack) Cmd_PreMenu(client, 0);
		case MenuAction_End: delete hMenu;
	}
}

public void SQL_Callback_CheckName(Database hDatabase, DBResultSet hResults, const char[] sError, DataPack hDatapack)
{
	if (hResults == null) ThrowError(sError);
	
	char[] sText = new char[MAX_NAME_LENGTH];
	
	int client = GetClientOfUserId(hDatapack.ReadCell());
	hDatapack.ReadString(sText, MAX_NAME_LENGTH);
	delete hDatapack;

	if (IsValidClient(client))
	{
		if (gB_SetName[client])
		{
			if (hResults.RowCount == 0)
			{
				strcopy(gS_GangName[client], MAX_NAME_LENGTH, sText);
				gB_HasGang[client] = true;
				gI_DateJoined[client] = GetTime();
				gB_HasGang[client] =  true;
				gS_InvitedBy[client] = "N/A";
				gI_Rank[client] = GANGRANK_OWNER;
				gI_GangSize[client] = 1;

				gI_Health[client] = 0;
				gI_Damage[client] = 0;
				gI_Evade[client] = 0;
				gI_Gravity[client] = 0;
				gI_Speed[client] = 0;
				gI_Stealing[client] = 0;
				gI_WeaponDrop[client] = 0;
				gI_Size[client] = 0;
				
				gB_SetName[client] = false;
				gI_Credits[client] -= GANG_CREATE_PRICE;
				
				PrintToChatAll("%s \x09%N\x01 has created a gang called \x02%s", GANG_TAG, client, gS_GangName[client]);
				LogMessage("%L has created the gang '%s'", client, gS_GangName[client]);
				
				UpdateSQL(client);
				StartOpeningGangMenu(client);
			}
			else PrintToChat(client, "%s \x07That name is already used, try again!", GANG_TAG);
		}
		else if (gB_Rename[client])
		{
			if (hResults.RowCount == 0)
			{
				char[] sOldName = new char[MAX_NAME_LENGTH];
				strcopy(sOldName, MAX_NAME_LENGTH, gS_GangName[client]);
				strcopy(gS_GangName[client], MAX_NAME_LENGTH, sText);
				
				for (int i = 1; i <= MaxClients; ++i)
				{
					if (IsClientInGame(i) && StrEqual(gS_GangName[i], sOldName))
						strcopy(gS_GangName[i], MAX_NAME_LENGTH, sText);
				}
				
				char[] sQuery = new char[PLATFORM_MAX_PATH];
				
				FormatEx(sQuery, PLATFORM_MAX_PATH, "UPDATE gangs_players SET gang=\"%s\" WHERE gang=\"%s\"", sText, sOldName);
				gD_Database.Query(SQL_Error, sQuery);

				FormatEx(sQuery, PLATFORM_MAX_PATH, "UPDATE gangs_groups SET gang=\"%s\" WHERE gang=\"%s\"", sText, sOldName);
				gD_Database.Query(SQL_Error, sQuery);

				gI_Credits[client] -= GANG_RENAME_PRICE;

				PrintToChatAll("%s \x09%N\x01 has changed the gang title of \x04%s\x01 to \x04%s", GANG_TAG, client, sOldName, sText);
				LogMessage("[%s] %L has renamed the gang to '%s'!", sOldName, client, sText);
				StartOpeningGangMenu(client);

				gB_Rename[client] = false;
			}
			else PrintToChat(client, "%s \x09That name is already used, try again!", GANG_TAG);
		}
	}
}

void StartOpeningMembersMenu(int client)
{
	if (gS_GangName[client][0] != '\0')
	{
		char[] sQuery = new char[PLATFORM_MAX_PATH];
		FormatEx(sQuery, PLATFORM_MAX_PATH, "SELECT * FROM gangs_players WHERE gang=\"%s\"", gS_GangName[client]);
		gD_Database.Query(SQLCallback_OpenMembersMenu, sQuery, GetClientUserId(client));
	}
}

public void SQLCallback_OpenMembersMenu(Database hDatabase, DBResultSet hResults, const char[] sError, int iUserID)
{
	if (hResults == null) ThrowError(sError);
	
	int client = GetClientOfUserId(iUserID);
	
	if (IsValidClient(client))
	{
		Menu hMenu = new Menu(MemberListMenu_CallBack);
		hMenu.SetTitle("Gang Members\n ");

		while (hResults.FetchRow())
		{
			char[][] a_sTempArray = new char[6][170]; 
			
			hResults.FetchString(1, a_sTempArray[0], 170); 
			hResults.FetchString(2, a_sTempArray[1], 170); 
			hResults.FetchString(5, a_sTempArray[2], 170); 

			char[] sInfoString = new char[128];
			char[] sDisplayString = new char[128];

			FormatEx(sInfoString, 170, "%s;%s;%s;%i;%i", a_sTempArray[0], a_sTempArray[1], a_sTempArray[2], hResults.FetchInt(4), hResults.FetchInt(6));

			switch (hResults.FetchInt(4))
			{
				case GANGRANK_NORMAL: FormatEx(sDisplayString, 170, "%s (Member)", a_sTempArray[1]);
				case GANGRANK_ADMIN: FormatEx(sDisplayString, 170, "%s (OG)", a_sTempArray[1]);
				case GANGRANK_OWNER: FormatEx(sDisplayString, 170, "%s (Boss)", a_sTempArray[1]);
			}
				
			hMenu.AddItem(sInfoString, sDisplayString);
		}
		
		hMenu.ExitBackButton = true;
		hMenu.Display(client, MENU_TIME_FOREVER);
	}
}

public int MemberListMenu_CallBack(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client))
			{
				char[] sInfo = new char[170];
				hMenu.GetItem(iParam, sInfo, 170);
				OpenIndividualMemberMenu(client, sInfo);
			}
		}
		case MenuAction_Cancel: if (iParam == MenuCancel_ExitBack && IsValidClient(client) && GetClientTeam(client) == 2) StartOpeningGangMenu(client);
		case MenuAction_End: delete hMenu;
	}
}

void OpenIndividualMemberMenu(int client, char[] sInfo)
{
	Menu hMenu = new Menu(Menu_MemberStats);
	hMenu.SetTitle("Gang Member Stats\n ");

	char[][] sTempArray = new char[5][170]; 
	char[] sDisplayBuffer = new char[MAX_NAME_LENGTH];

	ExplodeString(sInfo, ";", sTempArray, 5, MAX_NAME_LENGTH);

	FormatEx(sDisplayBuffer, MAX_NAME_LENGTH, "Name: %s", sTempArray[1]);
	hMenu.AddItem("", sDisplayBuffer, ITEMDRAW_DISABLED);

	FormatEx(sDisplayBuffer, MAX_NAME_LENGTH, "Steam ID: %s", sTempArray[0]);
	hMenu.AddItem("", sDisplayBuffer, ITEMDRAW_DISABLED);

	FormatEx(sDisplayBuffer, MAX_NAME_LENGTH, "Invited By: %s", sTempArray[2]);
	hMenu.AddItem("", sDisplayBuffer, ITEMDRAW_DISABLED);

	switch (StringToInt(sTempArray[3]))
	{
		case GANGRANK_NORMAL: strcopy(sDisplayBuffer, MAX_NAME_LENGTH, "Rank: Member");
		case GANGRANK_ADMIN: strcopy(sDisplayBuffer, MAX_NAME_LENGTH, "Rank: OG");
		case GANGRANK_OWNER: strcopy(sDisplayBuffer, MAX_NAME_LENGTH, "Rank: Boss");
	}
		
	hMenu.AddItem("", sDisplayBuffer, ITEMDRAW_DISABLED);

	char[] sFormattedTime = new char[MAX_NAME_LENGTH];
	FormatTime(sFormattedTime, MAX_NAME_LENGTH, "%x", StringToInt(sTempArray[4]));
	
	FormatEx(sDisplayBuffer, MAX_NAME_LENGTH, "Date Joined: %s", sFormattedTime);
	hMenu.AddItem("", sDisplayBuffer, ITEMDRAW_DISABLED);
	
	hMenu.ExitBackButton = true;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_MemberStats(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Cancel: if (iParam == MenuCancel_ExitBack && IsValidClient(client) && GetClientTeam(client) == 2) StartOpeningMembersMenu(client);	
		case MenuAction_End: delete hMenu;
	}
}

void OpenInvitationMenu(int client)
{
	Menu hMenu = new Menu(Menu_Invitation);
	hMenu.SetTitle("Invite Gang Members\n ");

	char[] sInfoString = new char[7];
	char[] sDisplayString = new char[MAX_NAME_LENGTH];

	for (int i = 1; i <= MaxClients; ++i)
	{
		if (IsClientInGame(i) && GetClientTeam(i) == 2 && i != client)
		{			
			FormatEx(sInfoString, 7, "%i", GetClientUserId(i));
			FormatEx(sDisplayString, MAX_NAME_LENGTH, "%N", i);
			
			hMenu.AddItem(sInfoString, sDisplayString, (gB_HasGang[i]) ? ITEMDRAW_DISABLED:ITEMDRAW_DEFAULT);
		}
	}
	
	if (hMenu.ItemCount == 0) 
	{
		PrintToChat(client, "%s There are no players to invite!", GANG_TAG);
		delete hMenu;
		StartOpeningGangMenu(client);
		return;
	}
	
	hMenu.ExitBackButton = true;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_Invitation(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client))
			{
				char[] sInfo = new char[7];
				hMenu.GetItem(iParam, sInfo, 7);
				
				int iUserID = GetClientOfUserId(StringToInt(sInfo));
				
				if (IsValidClient(iUserID))
				{
					gI_Invitation[iUserID] = GetClientUserId(client);
			
					if (gI_GangSize[client] >= MAXGANGSIZE + gI_Size[client])
					{
						PrintToChat(client, "%s Your gang is full!", GANG_TAG);
						return;
					}
					else if (gB_GangInvitation[client])
					{
						PrintToChat(client, "%s Please wait a minute till you can invite again!", GANG_TAG);
						return;
					}
					
					PrintToGang(client, true, "%s\x04%N\x01 sent an invitation to \x09%N\x01!", GANG_TAG, client, iUserID);
					gB_GangInvitation[client] = true;
					CreateTimer(60.0, Timer_GangInvite, GetClientUserId(client), TIMER_FLAG_NO_MAPCHANGE);
					OpenGangInvitationMenu(iUserID);
				}
				StartOpeningGangMenu(client);
			}	
		}
		case MenuAction_Cancel: if (iParam == MenuCancel_ExitBack && IsValidClient(client) && GetClientTeam(client) == 2) StartOpeningGangMenu(client);
		case MenuAction_End: delete hMenu;
	}
}

void OpenGangInvitationMenu(int client)
{
	char[] sDisplayString = new char[64];
	
	Menu hMenu = new Menu(Menu_InvitationMessage);
	hMenu.SetTitle("Gang Invitation\n ");
	
	int target = GetClientOfUserId(gI_Invitation[client]);
	
	FormatEx(sDisplayString, 64, "%N has invited you to their gang!", target);
	hMenu.AddItem("", sDisplayString, ITEMDRAW_DISABLED);

	FormatEx(sDisplayString, 64, "Would you like to join \"%s\"", gS_GangName[target]);
	hMenu.AddItem("", sDisplayString, ITEMDRAW_DISABLED);
	
	hMenu.AddItem("", "Yes, I'd like to join");
	hMenu.AddItem("", "No, I'd like to decline");
	hMenu.ExitButton = false;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_InvitationMessage(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client) && iParam == 2)
			{
				int target = GetClientOfUserId(gI_Invitation[client]);
				
				if (gI_GangSize[target] < MAXGANGSIZE + gI_Size[target])
				{
					gS_GangName[client] = gS_GangName[target];
					gI_DateJoined[client] = GetTime();
					gB_HasGang[client] =  true;
					gB_SetName[client] = false;
					
					gI_Health[client] = gI_Health[target];
					gI_Damage[client] = gI_Damage[target];
					gI_Evade[client] = gI_Evade[target];
					gI_Gravity[client] = gI_Gravity[target];
					gI_Speed[client] = gI_Speed[target];
					gI_Stealing[client] = gI_Stealing[target];
					gI_WeaponDrop[client] = gI_WeaponDrop[target];
					gI_Size[client] = gI_Size[target];
					gI_GangSize[client] = gI_GangSize[target] + 1;
					gI_Rank[client] = GANGRANK_NORMAL;
					
					char[] sName = new char[MAX_NAME_LENGTH];
					GetClientName(target, sName, MAX_NAME_LENGTH);
					strcopy(gS_InvitedBy[client], MAX_NAME_LENGTH, sName); 
			
					UpdateSQL(client);
					PrintToChatAll("%s \x09%N\x01 has joined the gang \x02%s\x01!", GANG_TAG, client, gS_GangName[client]);
				}
				else PrintToChat(client, "%s The gang has reached its size limit!");
			}
		}
		case MenuAction_End: delete hMenu;
	}
}

void StartOpeningPerkMenu(int client)
{
	char[] sQuery = new char[PLATFORM_MAX_PATH];
	FormatEx(sQuery, PLATFORM_MAX_PATH, "SELECT health, damage, gravity, speed, size, evasion, stealing, weapondrop FROM gangs_groups WHERE gang=\"%s\"", gS_GangName[client]);
	gD_Database.Query(SQLCallback_Perks, sQuery, GetClientUserId(client));
}

public void SQLCallback_Perks(Database hDatabase, DBResultSet hResults, const char[] sError, int iUserID)
{
	if (hResults == null)
		ThrowError(sError);
	
	int client = GetClientOfUserId(iUserID);
	
	if (IsValidClient(client))
	{
		Menu hMenu = new Menu(Menu_Perks);
		hMenu.SetTitle("Gang Perks\nCredits: %i\n ", gI_Credits[client]);
		
		if (hResults.RowCount == 1 && hResults.FetchRow())
		{
			gI_Health[client] = hResults.FetchInt(0); 
			gI_Damage[client] = hResults.FetchInt(1); 
			gI_Gravity[client] = hResults.FetchInt(2); 
			gI_Speed[client] = hResults.FetchInt(3); 
			gI_Size[client] = hResults.FetchInt(4);
			gI_Evade[client] = hResults.FetchInt(5);
			gI_Stealing[client] = hResults.FetchInt(6);
			gI_WeaponDrop[client] = hResults.FetchInt(7);
		}
		
		char[] sDisplayBuffer = new char[64];
		FormatEx(sDisplayBuffer, 64, "[%02i/%02i] Health | %i Credits", gI_Health[client], UPGRADE_HEALTH_MAX, UPGRADE_HEALTH_PRICE);
		hMenu.AddItem("", sDisplayBuffer, (gI_Health[client] >= UPGRADE_HEALTH_MAX)?ITEMDRAW_DISABLED:ITEMDRAW_DEFAULT);

		FormatEx(sDisplayBuffer, 64, "[%02i/%02i] Damage | %i Credits", gI_Damage[client], UPGRADE_DAMAGE_MAX, UPGRADE_DAMAGE_PRICE);
		hMenu.AddItem("", sDisplayBuffer, (gI_Damage[client] >= UPGRADE_DAMAGE_MAX)?ITEMDRAW_DISABLED:ITEMDRAW_DEFAULT);
		
		FormatEx(sDisplayBuffer, 64, "[%02i/%02i] Evasion | %i Credits", gI_Evade[client], UPGRADE_EVADE_MAX, UPGRADE_EVADE_PRICE);
		hMenu.AddItem("", sDisplayBuffer, (gI_Evade[client] >= UPGRADE_EVADE_MAX)?ITEMDRAW_DISABLED:ITEMDRAW_DEFAULT);
		
		FormatEx(sDisplayBuffer, 64, "[%02i/%02i] Feathers | %i Credits", gI_Gravity[client], UPGRADE_GRAVITY_MAX, UPGRADE_GRAVITY_PRICE);
		hMenu.AddItem("", sDisplayBuffer, (gI_Gravity[client] >= UPGRADE_GRAVITY_MAX)?ITEMDRAW_DISABLED:ITEMDRAW_DEFAULT);

		FormatEx(sDisplayBuffer, 64, "[%02i/%02i] Stamina | %i Credits", gI_Speed[client], UPGRADE_SPEED_MAX, UPGRADE_SPEED_PRICE);
		hMenu.AddItem("", sDisplayBuffer, (gI_Speed[client] >= UPGRADE_SPEED_MAX)?ITEMDRAW_DISABLED:ITEMDRAW_DEFAULT);

		FormatEx(sDisplayBuffer, 64, "[%02i/%02i] Weapon Drop | %i Credits", gI_WeaponDrop[client], UPGRADE_DROP_MAX, UPGRADE_DROP_PRICE);
		hMenu.AddItem("", sDisplayBuffer, (gI_WeaponDrop[client] >= UPGRADE_DROP_MAX)?ITEMDRAW_DISABLED:ITEMDRAW_DEFAULT);

		FormatEx(sDisplayBuffer, 64, "[%02i/%02i] Stealing | %i Credits", gI_Stealing[client], UPGRADE_STEALING_MAX, UPGRADE_STEALING_PRICE);
		hMenu.AddItem("", sDisplayBuffer, (gI_Stealing[client] >= UPGRADE_STEALING_MAX)?ITEMDRAW_DISABLED:ITEMDRAW_DEFAULT);

		FormatEx(sDisplayBuffer, 64, "[%02i/%02i] Slots | %i Credits", gI_Size[client], UPGRADE_SIZE_MAX, UPGRADE_SIZE_PRICE);
		hMenu.AddItem("", sDisplayBuffer, (gI_Size[client] >= UPGRADE_SIZE_MAX)?ITEMDRAW_DISABLED:ITEMDRAW_DEFAULT);
		
		SetMenuPagination(hMenu, MENU_NO_PAGINATION);
		hMenu.ExitButton = true;
		hMenu.Display(client, MENU_TIME_FOREVER);
	}
}

public int Menu_Perks(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client))
			{
				char[] sQuery = new char[PLATFORM_MAX_PATH];
				char[] sRank = new char[9];
				
				switch (gI_Rank[client])
				{
					case GANGRANK_OWNER: strcopy(sRank, 9, "[Boss]");
					case GANGRANK_ADMIN: strcopy(sRank, 9, "[OG]");
					case GANGRANK_NORMAL: strcopy(sRank, 9, "[Member]");	
				}
				
				switch (iParam)
				{
					case 0:
					{
						if (gI_Credits[client] < UPGRADE_HEALTH_PRICE)
						{
							PrintToChat(client, "%s You don't have enough credits!", GANG_TAG);
							StartOpeningPerkMenu(client);
							return;
						}
						else if (gI_Health[client] >= UPGRADE_HEALTH_MAX)
						{
							PrintToChat(client, "%s It's Maxed out already!", GANG_TAG);
							StartOpeningPerkMenu(client);
							return;
						}
						
						gI_Credits[client] -= UPGRADE_HEALTH_PRICE;
						++gI_Health[client];
						PrintToGang(client, true, "%s \x04%N\x01 has upgraded Health Perk!", GANG_TAG, client);
						FormatEx(sQuery, PLATFORM_MAX_PATH, "UPDATE gangs_groups SET health=%i WHERE gang=\"%s\"", gI_Health[client], gS_GangName[client]);
						LogMessage("(%s) %s %L has upgraded Health Perk!", gS_GangName[client], sRank, client);
					}
					case 1:
					{
						if (gI_Credits[client] < UPGRADE_DAMAGE_PRICE)
						{
							PrintToChat(client, "%s You don't have enough credits!", GANG_TAG);
							StartOpeningPerkMenu(client);
							return;
						}
						else if (gI_Damage[client] >= UPGRADE_DAMAGE_MAX)
						{
							PrintToChat(client, "%s It's Maxed out already!", GANG_TAG);
							StartOpeningPerkMenu(client);
							return;
						}
						
						gI_Credits[client] -= UPGRADE_DAMAGE_PRICE;
						++gI_Damage[client];
						PrintToGang(client, true, "%s \x04%N\x01 has upgraded Damage Perk!", GANG_TAG, client);
						FormatEx(sQuery, PLATFORM_MAX_PATH, "UPDATE gangs_groups SET damage=%i WHERE gang=\"%s\"",  gI_Damage[client], gS_GangName[client]);
						LogMessage("(%s) %s %L has upgraded Damage Perk!", gS_GangName[client], sRank, client);
					}
					case 2:
					{
						if (gI_Credits[client] < UPGRADE_EVADE_PRICE)
						{
							PrintToChat(client, "%s You don't have enough credits!", GANG_TAG);
							StartOpeningPerkMenu(client);
							return;
						}
						else if (gI_Evade[client] >= UPGRADE_EVADE_MAX)
						{
							PrintToChat(client, "%s It's Maxed out already!", GANG_TAG);
							StartOpeningPerkMenu(client);
							return;
						}
						
						gI_Credits[client] -= UPGRADE_EVADE_PRICE;
						++gI_Evade[client];
						PrintToGang(client, true, "%s \x04%N\x01 has upgraded Evade Perk!", GANG_TAG, client);
						FormatEx(sQuery, PLATFORM_MAX_PATH, "UPDATE gangs_groups SET evasion=%i WHERE gang=\"%s\"", gI_Evade[client], gS_GangName[client]);
						LogMessage("(%s) %s %L has upgraded Evade Perk!", gS_GangName[client], sRank, client);
					}
					case 3:
					{
						if (gI_Credits[client] < UPGRADE_GRAVITY_PRICE)
						{
							PrintToChat(client, "%s You don't have enough credits!", GANG_TAG);
							StartOpeningPerkMenu(client);
							return;
						}
						else if (gI_Gravity[client] >= UPGRADE_GRAVITY_MAX)
						{
							PrintToChat(client, "%s It's Maxed out already!", GANG_TAG);
							StartOpeningPerkMenu(client);
							return;
						}
						
						gI_Credits[client] -= UPGRADE_GRAVITY_PRICE;
						++gI_Gravity[client];
						PrintToGang(client, true, "%s \x04%N\x01 has upgraded Gravity Perk!", GANG_TAG, client);
						FormatEx(sQuery, PLATFORM_MAX_PATH, "UPDATE gangs_groups SET gravity=%i WHERE gang=\"%s\"", gI_Gravity[client], gS_GangName[client]);
						LogMessage("(%s) %s %L has upgraded Gravity Perk!", gS_GangName[client], sRank, client);
					}
					case 4:
					{
						if (gI_Credits[client] < UPGRADE_SPEED_PRICE)
						{
							PrintToChat(client, "%s You don't have enough credits!", GANG_TAG);
							StartOpeningPerkMenu(client);
							return;
						}
						else if (gI_Speed[client] >= UPGRADE_SPEED_MAX)
						{
							PrintToChat(client, "%s It's Maxed out already!", GANG_TAG);
							StartOpeningPerkMenu(client);
							return;
						}
						
						gI_Credits[client] -= UPGRADE_SPEED_PRICE;
						++gI_Speed[client];
						PrintToGang(client, true, "%s \x04%N\x01 has upgraded Agility Perk!", GANG_TAG, client);
						FormatEx(sQuery, PLATFORM_MAX_PATH, "UPDATE gangs_groups SET speed=%i WHERE gang=\"%s\"", gI_Speed[client], gS_GangName[client]);
						LogMessage("(%s) %s %L has upgraded Agility Perk!", gS_GangName[client], sRank, client);
					}
					case 5:
					{
						if (gI_Credits[client] < UPGRADE_DROP_PRICE)
						{
							PrintToChat(client, "%s You don't have enough credits!", GANG_TAG);
							StartOpeningPerkMenu(client);
							return;
						}
						else if (gI_WeaponDrop[client] >= UPGRADE_DROP_MAX)
						{
							PrintToChat(client, "%s It's Maxed out already!", GANG_TAG);
							StartOpeningPerkMenu(client);
							return;
						}
						
						gI_Credits[client] -= UPGRADE_DROP_PRICE;
						++gI_WeaponDrop[client];
						PrintToGang(client, true, "%s \x04%N\x01 has upgraded Weapon Drop Perk!", GANG_TAG, client);
						FormatEx(sQuery, PLATFORM_MAX_PATH, "UPDATE gangs_groups SET weapondrop=%i WHERE gang=\"%s\"", gI_WeaponDrop[client], gS_GangName[client]);
						LogMessage("(%s) %s %L has upgraded Weapon Drop Perk!", gS_GangName[client], sRank, client);
					}
					case 6:
					{
						if (gI_Credits[client] < UPGRADE_STEALING_PRICE)
						{
							PrintToChat(client, "%s You don't have enough credits!", GANG_TAG);
							StartOpeningPerkMenu(client);
							return;
						}
						else if (gI_Stealing[client] >= UPGRADE_STEALING_MAX)
						{
							PrintToChat(client, "%s It's Maxed out already!", GANG_TAG);
							StartOpeningPerkMenu(client);
							return;
						}
						
						gI_Credits[client] -= UPGRADE_STEALING_PRICE;
						++gI_Stealing[client];
						PrintToGang(client, true, "%s \x04%N\x01 has upgraded Stealing Perk!", GANG_TAG, client);
						FormatEx(sQuery, PLATFORM_MAX_PATH, "UPDATE gangs_groups SET stealing=%i WHERE gang=\"%s\"", gI_Stealing[client], gS_GangName[client]);
						LogMessage("(%s) %s %L has upgraded Stealing Perk!", gS_GangName[client], sRank, client);
					}
					case 7:
					{
						if (gI_Credits[client] < UPGRADE_SIZE_PRICE)
						{
							PrintToChat(client, "%s You don't have enough credits!", GANG_TAG);
							StartOpeningPerkMenu(client);
							return;
						}
						else if (gI_Size[client] >= UPGRADE_SIZE_MAX)
						{
							PrintToChat(client, "%s It's Maxed out already!", GANG_TAG);
							StartOpeningPerkMenu(client);
							return;
						}
						
						gI_Credits[client] -= UPGRADE_SIZE_PRICE;
						++gI_Size[client];
						PrintToGang(client, true, "%s \x04%N\x01 has upgraded Gang Size Perk!", GANG_TAG, client);
						FormatEx(sQuery, PLATFORM_MAX_PATH, "UPDATE gangs_groups SET size=%i WHERE gang=\"%s\"", gI_Size[client], gS_GangName[client]);
						LogMessage("(%s) %s %L has upgraded Gang Size Perk!", gS_GangName[client], sRank, client);
					}
				}
				gD_Database.Query(SQL_Error, sQuery, GetClientUserId(client));
				StartOpeningPerkMenu(client);
			}
		}
		case MenuAction_End: delete hMenu;
	}
}

void OpenLeaveConfirmation(int client)
{
	Menu hMenu = new Menu(Menu_LeaveGang);
	hMenu.SetTitle("Leave the \"%s\" gang?\n ", gS_GangName[client]);
	hMenu.AddItem("", "Are you sure you want to leave?", ITEMDRAW_DISABLED);
	
	if (gI_Rank[client] == GANGRANK_OWNER) {
		hMenu.AddItem("", "As owner, leaving will disband your gang!", ITEMDRAW_DISABLED);
	}

	hMenu.AddItem("1", "Yes, I'd like to leave!");
	hMenu.AddItem("2", "No, nevermind.");
	hMenu.ExitBackButton = true;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_LeaveGang(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client))
			{
				char[] sInfo = new char[5];
				hMenu.GetItem(iParam, sInfo, 5);
				
				switch (StringToInt(sInfo))
				{
					case 1: RemoveFromGang(client);
					case 2:	StartOpeningGangMenu(client);
				}
			}	
		}
		case MenuAction_Cancel: if (iParam == MenuCancel_ExitBack && IsValidClient(client) && GetClientTeam(client) == 2) StartOpeningGangMenu(client);	
		case MenuAction_End: delete hMenu;
	}
}

void OpenAdministrationMenu(int client)
{
	char[] sDisplayString = new char[MAX_NAME_LENGTH];
	FormatEx(sDisplayString, MAX_NAME_LENGTH, "Rename Gang [%i Credits]", GANG_RENAME_PRICE);
	
	Menu hMenu = new Menu(Menu_Admin);
	hMenu.SetTitle("Gang Administrator Menu\n ");
	hMenu.AddItem("", sDisplayString, (gI_Rank[client] == GANGRANK_OWNER && gI_Credits[client] >= GANG_RENAME_PRICE)?ITEMDRAW_DEFAULT:ITEMDRAW_DISABLED);
	hMenu.AddItem("", "Kick a member", (gI_Rank[client] == GANGRANK_NORMAL)?ITEMDRAW_DISABLED:ITEMDRAW_DEFAULT);
	hMenu.AddItem("", "Promote a member", (gI_Rank[client] == GANGRANK_OWNER)?ITEMDRAW_DEFAULT:ITEMDRAW_DISABLED);
	hMenu.AddItem("", "Disband gang", (gI_Rank[client] == GANGRANK_OWNER)?ITEMDRAW_DEFAULT:ITEMDRAW_DISABLED);
	hMenu.ExitBackButton = true;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_Admin(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client))
			{
				switch (iParam)
				{
					case 0:
					{
						for (int i = 1; i <= 5; ++i) PrintToChat(client, "%s \x06Please type desired gang name in chat!", GANG_TAG);
						gB_Rename[client] = true;
					}
					case 1: OpenAdministrationKickMenu(client);
					case 2:	OpenAdministrationPromotionMenu(client);
					case 3: OpenDisbandMenu(client);
				}
			}
		}
		case MenuAction_Cancel: if (iParam == MenuCancel_ExitBack && IsValidClient(client) && GetClientTeam(client) == 2) StartOpeningGangMenu(client);
		case MenuAction_End: delete hMenu;
	}
}

void OpenAdministrationPromotionMenu(int client)
{
	if (gS_GangName[client][0] != '\0')
	{
		char[] sQuery = new char[PLATFORM_MAX_PATH];
		FormatEx(sQuery, PLATFORM_MAX_PATH, "SELECT * FROM gangs_players WHERE gang=\"%s\"", gS_GangName[client]);
		gD_Database.Query(SQLCallback_AdministrationPromotionMenu, sQuery, GetClientUserId(client));
	}
}

public void SQLCallback_AdministrationPromotionMenu(Database hDatabase, DBResultSet hResults, const char[] sError, int iUserID)
{
	if (hResults == null) 
		ThrowError(sError);
	
	int client = GetClientOfUserId(iUserID);
	
	if (IsValidClient(client))
	{
		Menu hMenu = new Menu(Menu_Promotion);
		hMenu.SetTitle("Promote Gang Member\n ");

		while (hResults.FetchRow())
		{
			char[][] sTempArray = new char[3][128]; 
			hResults.FetchString(1, sTempArray[0], 128); 
			hResults.FetchString(2, sTempArray[1], 128); 
			IntToString(hResults.FetchInt(3), sTempArray[2], 128); 

			char[] sSteamID = new char[MAX_NAME_LENGTH];
			GetClientAuthId(client, AuthId_Steam2, sSteamID, MAX_NAME_LENGTH);

			if (!StrEqual(sSteamID, sTempArray[0]))
			{
				char[] sInfoString = new char[64];
				char[] sDisplayString = new char[64];
				
				FormatEx(sInfoString, 64, "%s;%s;%i", sTempArray[0], sTempArray[1], StringToInt(sTempArray[2]));
				FormatEx(sDisplayString, 64, "%s (%s)", sTempArray[1], sTempArray[0]);
				
				hMenu.AddItem(sInfoString, sDisplayString, (gI_Rank[client] == GANGRANK_OWNER)?ITEMDRAW_DEFAULT:ITEMDRAW_DISABLED);
			}
		}
		
		if (hMenu.ItemCount == 0) 
		{
			PrintToChat(client, "%s There are no gang members to promote!", GANG_TAG);
			delete hMenu;
			OpenAdministrationMenu(client);
			return;
		}
	
		hMenu.ExitBackButton = true;
		hMenu.Display(client, MENU_TIME_FOREVER);
	}
}

public int Menu_Promotion(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client))
			{
				char[] sInfo = new char[MAX_NAME_LENGTH];
				hMenu.GetItem(iParam, sInfo, MAX_NAME_LENGTH);
				OpenPromoteDemoteMenu(client, sInfo);
			}
		}
		case MenuAction_Cancel: if (iParam == MenuCancel_ExitBack && IsValidClient(client) && GetClientTeam(client) == 2) OpenAdministrationMenu(client);
		case MenuAction_End: delete hMenu;
	}
}


void OpenPromoteDemoteMenu(int client, const char[] sInfo)
{
	char[] sInfoString = new char[MAX_NAME_LENGTH];
	char[][] sTempArray = new char[2][MAX_NAME_LENGTH];
	ExplodeString(sInfo, ";", sTempArray, 2, MAX_NAME_LENGTH);

	Menu hMenu = new Menu(Menu_GangRanks);
	hMenu.SetTitle("Gang Members Ranks\n Simply click on the desired rank to set\n ");
	
	FormatEx(sInfoString, MAX_NAME_LENGTH, "%s", sTempArray[0]);
	hMenu.AddItem(sInfoString, "Member", (gI_Rank[client] != GANGRANK_OWNER)?ITEMDRAW_DISABLED:ITEMDRAW_DEFAULT);

	FormatEx(sInfoString, MAX_NAME_LENGTH, "%s", sTempArray[0]);
	hMenu.AddItem(sInfoString, "OG", (gI_Rank[client] != GANGRANK_OWNER)?ITEMDRAW_DISABLED:ITEMDRAW_DEFAULT);

	hMenu.ExitBackButton = true;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_GangRanks(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client))
			{
				char[] sInfo = new char[MAX_NAME_LENGTH];
				hMenu.GetItem(iParam, sInfo, MAX_NAME_LENGTH);
		
				char[] sQuery = new char[PLATFORM_MAX_PATH];
				
				switch (iParam)
				{
					case 0: 
					{
						FormatEx(sQuery, PLATFORM_MAX_PATH, "UPDATE gangs_players SET rank=0 WHERE steamid = \"%s\"", sInfo);
						LogMessage("[%s] %L has modified '%s' rank to Member!", gS_GangName[client], client, sInfo);
					}
					case 1:
					{
						FormatEx(sQuery, PLATFORM_MAX_PATH, "UPDATE gangs_players SET rank=1 WHERE steamid = \"%s\"", sInfo);
						LogMessage("[%s] %L has modified '%s' rank to OG!", gS_GangName[client], client, sInfo);
					}
				}
				gD_Database.Query(SQL_Error, sQuery);
				
				char[] sSteamID = new char[MAX_NAME_LENGTH];
				
				for (int i = 1; i <= MaxClients; ++i)
				{
					if (IsClientInGame(i))
					{
						GetClientAuthId(i, AuthId_Steam2, sSteamID, MAX_NAME_LENGTH);
						
						if (StrEqual(sSteamID, sInfo))
						{
							LoadSteamID(i);
							PrintToGang(i, true, "%s \x02%N\x01 has Modified \x09%N's\x01 Gang Rank!", GANG_TAG, client, i);
							break;
						}
					}
				}
			}
		}
		case MenuAction_Cancel: if (iParam == MenuCancel_ExitBack && IsValidClient(client) && GetClientTeam(client) == 2) OpenAdministrationMenu(client);
		case MenuAction_End: delete hMenu;
	}
}

void OpenDisbandMenu(int client)
{
	Menu hMenu = new Menu(Menu_Disband);
	hMenu.SetTitle("Disband Gang\n ");
	hMenu.AddItem("", "Are you sure you want to disband your gang?", ITEMDRAW_DISABLED);
	hMenu.AddItem("", "This change is PERMANENT", ITEMDRAW_DISABLED);
	hMenu.AddItem("", "Disband The Gang", (gI_Rank[client] != GANGRANK_OWNER)?ITEMDRAW_DISABLED:ITEMDRAW_DEFAULT);
	hMenu.AddItem("", "Don't Disband The Gang", (gI_Rank[client] != GANGRANK_OWNER)?ITEMDRAW_DISABLED:ITEMDRAW_DEFAULT);
	hMenu.ExitBackButton = true;
	hMenu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_Disband(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client) && iParam == 2)
				RemoveFromGang(client);
		}
		case MenuAction_Cancel: if (iParam == MenuCancel_ExitBack && IsValidClient(client) && GetClientTeam(client) == 2) OpenAdministrationMenu(client);
		case MenuAction_End: delete hMenu;
	}
}

void OpenAdministrationKickMenu(int client)
{
	if (gS_GangName[client][0] != '\0')
	{
		char[] sQuery = new char[PLATFORM_MAX_PATH];
		FormatEx(sQuery, PLATFORM_MAX_PATH, "SELECT * FROM gangs_players WHERE gang=\"%s\"", gS_GangName[client]);
		gD_Database.Query(SQLCallback_AdministrationKickMenu, sQuery, GetClientUserId(client));
	}
}

public void SQLCallback_AdministrationKickMenu(Database hDatabase, DBResultSet hResults, const char[] sError, int iUserID)
{
	if (hResults == null)
		ThrowError(sError);
	
	int client = GetClientOfUserId(iUserID);
	
	if (IsValidClient(client))
	{
		Menu hMenu = new Menu(Menu_AdminKick);
		hMenu.SetTitle("Kick Gang Members\n ");

		while (hResults.FetchRow())
		{
			char[][] sTempArray = new char[2][128]; 
			
			hResults.FetchString(1, sTempArray[0], 128); 
			
			if (StrEqual(sTempArray[0], gS_SteamID[client])) 
				continue;
			
			hResults.FetchString(2, sTempArray[1], 128); 

			char[] sInfoString = new char[128];
			char[] sDisplayString = new char[128];

			FormatEx(sInfoString, 128, "%s;%s", sTempArray[0], sTempArray[1]);
			FormatEx(sDisplayString, 128, "%s (%s)", sTempArray[1], sTempArray[0]);
			
			hMenu.AddItem(sInfoString, sDisplayString, (gI_Rank[client] > hResults.FetchInt(4))?ITEMDRAW_DEFAULT:ITEMDRAW_DISABLED);
		}
		
		if (hMenu.ItemCount == 0) 
		{
			PrintToChat(client, "%s There are no gang members to kick!", GANG_TAG);
			delete hMenu;
			OpenAdministrationMenu(client);
			return;
		}
		hMenu.ExitBackButton = true;
		hMenu.Display(client, MENU_TIME_FOREVER);
	}
}

public int Menu_AdminKick(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client))
			{
				char[] sInfo = new char[MAX_NAME_LENGTH];
				hMenu.GetItem(iParam, sInfo, MAX_NAME_LENGTH);
				
				char[][] sTempArray = new char[2][128];
				ExplodeString(sInfo, ";", sTempArray, 2, 128);
				
				char[] sQuery = new char[PLATFORM_MAX_PATH];
				FormatEx(sQuery, PLATFORM_MAX_PATH, "DELETE FROM gangs_players WHERE steamid = \"%s\"", sTempArray[0]);
				gD_Database.Query(SQL_Error, sQuery);
				
				PrintToChatAll("%s \x04%s \x01 has been kicked from the gang \x02%s", GANG_TAG, sTempArray[1], gS_GangName[client]);
				LogMessage("[%s] %L has kicked %s [%s] from the gang!", gS_GangName[client], client, sTempArray[1], sTempArray[0]);
				
				char[] sSteamID = new char[MAX_NAME_LENGTH];
				
				for (int i = 1; i <= MaxClients; ++i)
				{
					if (IsClientInGame(i))
					{
						GetClientAuthId(i, AuthId_Steam2, sSteamID, MAX_NAME_LENGTH);
						
						if (StrEqual(sSteamID, sTempArray[0]))
						{
							ResetVariables(i);
							break;
						}
					}
				}
			}
		}
		case MenuAction_Cancel: if (iParam == MenuCancel_ExitBack && IsValidClient(client) && GetClientTeam(client) == 2) OpenAdministrationMenu(client);	
		case MenuAction_End: delete hMenu;
	}
}

public void SQL_Callback_GangStatistics(Database hDatabase, DBResultSet hResults, const char[] sError, DataPack hPack)
{
	if (hResults == null) 
	{
		delete hPack;
		ThrowError(sError);
	}
	
	hPack.Reset();
	int client = GetClientOfUserId(hPack.ReadCell());
	
	if (IsValidClient(client))
	{
		char[][] sTempArray = new char[2][128]; 
		char[] sFormattedTime = new char[64];
		char[] sDisplayString = new char[64];
		
		hResults.FetchRow();
		hResults.FetchString(3, sTempArray[0], 64);
		hResults.FetchString(2, sTempArray[1], 64);
		
		int iDate = hResults.FetchInt(6);

		Menu hMenu = new Menu(Menu_Void);
		hMenu.SetTitle("Top 10 Gangs\n ");

		FormatEx(sDisplayString, 64, "Gang Name: %s", sTempArray[0]);
		hMenu.AddItem("", sDisplayString, ITEMDRAW_DISABLED);

		FormatEx(sDisplayString, 64, "Gang Rank: %i", gI_TempInt2[client]);
		hMenu.AddItem("", sDisplayString, ITEMDRAW_DISABLED);

		FormatTime(sFormattedTime, 64, "%x", iDate);
		FormatEx(sDisplayString, 64, "Date Created: %s", sFormattedTime);
		hMenu.AddItem("", sDisplayString, ITEMDRAW_DISABLED);

		FormatEx(sDisplayString, 64, "Created By: %s", sTempArray[1]);
		hMenu.AddItem("", sDisplayString, ITEMDRAW_DISABLED);

		FormatEx(sDisplayString, 64, "Gang Kills: %i", gI_TempInt[client]);
		hMenu.AddItem("", sDisplayString, ITEMDRAW_DISABLED);

		FormatEx(sDisplayString, 64, "Health Upgrade: %02i", hPack.ReadCell());
		hMenu.AddItem("", sDisplayString, ITEMDRAW_DISABLED);
		
		FormatEx(sDisplayString, 64, "Damage Upgrade: %02i", hPack.ReadCell());
		hMenu.AddItem("", sDisplayString, ITEMDRAW_DISABLED);

		FormatEx(sDisplayString, 64, "Feathers Upgrade: %02i", hPack.ReadCell());
		hMenu.AddItem("", sDisplayString, ITEMDRAW_DISABLED);
		
		FormatEx(sDisplayString, 64, "Agility Upgrade: %02i", hPack.ReadCell());
		hMenu.AddItem("", sDisplayString, ITEMDRAW_DISABLED);

		FormatEx(sDisplayString, 64, "Size Upgrade: %02i", hPack.ReadCell());
		hMenu.AddItem("", sDisplayString, ITEMDRAW_DISABLED);

		FormatEx(sDisplayString, 64, "Evasion Upgrade: %02i", hPack.ReadCell());
		hMenu.AddItem("", sDisplayString, ITEMDRAW_DISABLED);

		FormatEx(sDisplayString, 64, "Stealing Upgrade: %02i", hPack.ReadCell());
		hMenu.AddItem("", sDisplayString, ITEMDRAW_DISABLED);

		FormatEx(sDisplayString, 64, "Weapon Drop Upgrade: %02i", hPack.ReadCell());
		hMenu.AddItem("", sDisplayString, ITEMDRAW_DISABLED);

		hMenu.ExitBackButton = true;
		hMenu.Display(client, MENU_TIME_FOREVER);
	}
	delete hPack;
}

public int Menu_Void(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Cancel: if (iParam == MenuCancel_ExitBack && IsValidClient(client)) gD_Database.Query(SQL_Callback_TopMenu, "SELECT * FROM `gangs_groups` ORDER BY `kills` DESC", GetClientUserId(client));
		case MenuAction_End: delete hMenu;
	}
}

public void SQLCallback_Credits(Database hDatabase, DBResultSet hResults, const char[] sError, int iUserID)
{
	if (hResults == null) 
		ThrowError(sError);
		
	int client = GetClientOfUserId(iUserID);

	if (IsValidClient(client))
	{
		char[] sQuery = new char[256];
		
		if (hResults.RowCount == 0)
			FormatEx(sQuery, 256, "INSERT INTO `jailbreak_credits` (steamid, player, credits, casinowins, casinoloses) VALUES (\"%s\", \"%N\", %i, %i, %i)", gS_SteamID[client], client, gI_Credits[client], gI_CasinoWins[client], gI_CasinoLoses[client]);
		else
			FormatEx(sQuery, 256, "UPDATE `jailbreak_credits` SET player=\"%N\", credits=%i, casinowins=%i, casinoloses=%i WHERE steamid=\"%s\"", client, gI_Credits[client], gI_CasinoWins[client], gI_CasinoLoses[client], gS_SteamID[client]);
		
		gD_Database.Query(SQL_Error, sQuery);
		
		FormatEx(sQuery, PLATFORM_MAX_PATH, "SELECT `steamid` FROM `jailbreak_stats` WHERE steamid=\"%s\"", gS_SteamID[client]);
		gD_Database.Query(SQLCallback_Stats, sQuery, GetClientUserId(client));
	}
}

public void SQLCallback_Credits2(Database hDatabase, DBResultSet hResults, const char[] sError, DataPack hPack)
{
	if (hResults == null) 
	{
		delete hPack;
		ThrowError(sError);
	}
	
	if (hResults.RowCount == 1)
	{
		char[] sFormat = new char[32];
		hResults.FetchRow();
		hResults.FetchString(0, sFormat, 32);
		
		int iCredits = hPack.ReadCell();
		int iWins = hPack.ReadCell();
		int iLoses = hPack.ReadCell();
		
		char[] sQuery = new char[256];
		FormatEx(sQuery, 256, "UPDATE `jailbreak_credits` SET credits=%i, casinowins=%i, casinoloses=%i WHERE steamid=\"%s\"", iCredits, iWins, iLoses, sFormat);
		gD_Database.Query(SQL_Error, sQuery);
	}
	delete hPack;
}

public void SQLCallback_Stats(Database hDatabase, DBResultSet hResults, const char[] sError, int iUserID)
{
	if (hResults == null) 
		ThrowError(sError);
		
	int client = GetClientOfUserId(iUserID);

	if (IsValidClient(client))
	{
		char[] sQuery = new char[400];
		
		if (hResults.RowCount == 0)
			FormatEx(sQuery, 400, "INSERT INTO `jailbreak_stats` (steamid, player, guard, prisoner, special, lastrequest, time) VALUES (\"%s\", \"%N\", %i, %i, %i, %i, %i)", gS_SteamID[client], client, gI_StatsGuardKills[client], gI_StatsPrisonerKills[client], gI_StatsSpecialDayKills[client], gI_StatsLastRequestKills[client], gI_StatsPlayTime[client]);
		else
			FormatEx(sQuery, 400, "UPDATE `jailbreak_stats` SET player=\"%N\", guard=%i, prisoner=%i, special=%i, lastrequest=%i, time=%i WHERE steamid=\"%s\"", client, gI_StatsGuardKills[client], gI_StatsPrisonerKills[client], gI_StatsSpecialDayKills[client], gI_StatsLastRequestKills[client], gI_StatsPlayTime[client], gS_SteamID[client]);
		gD_Database.Query(SQL_Error, sQuery);
		
		if (gB_HasGang[client])
		{
			FormatEx(sQuery, PLATFORM_MAX_PATH, "SELECT * FROM `gangs_players` WHERE steamid=\"%s\"", gS_SteamID[client]);
			gD_Database.Query(SQLCallback_CheckIfInDatabase_Player, sQuery, GetClientUserId(client));
		}
	}
}

public void SQLCallback_Stats2(Database hDatabase, DBResultSet hResults, const char[] sError, DataPack hPack)
{
	if (hResults == null) 
	{
		delete hPack;
		ThrowError(sError);
	}
	
	if (hResults.RowCount == 1)
	{
		char[] sFormat = new char[32];
		hResults.FetchRow();
		hResults.FetchString(0, sFormat, 32);
		
		int iGuard = hPack.ReadCell();
		int iPrisoner = hPack.ReadCell();
		int iSpecial = hPack.ReadCell();
		int iLastRequest = hPack.ReadCell();
		int iPlayTime = hPack.ReadCell();
		
		char[] sQuery = new char[400];
		FormatEx(sQuery, 400, "UPDATE `jailbreak_stats` SET guard=%i, prisoner=%i, special=%i, lastrequest=%i, time=%i WHERE steamid=\"%s\"", iGuard, iPrisoner, iSpecial, iLastRequest, iPlayTime, sFormat);
		gD_Database.Query(SQL_Error, sQuery);
	}
	delete hPack;
}

public void SQLCallback_GangKills(Database hDatabase, DBResultSet hResults, const char[] sError, DataPack hPack)
{
	if (hResults == null) 
	{
		delete hPack;
		ThrowError(sError);
	}
	
	if (hResults.RowCount == 1)
	{
		hPack.Reset();
		
		char[] sFormat = new char[32];
		hPack.ReadString(sFormat, 32);
		int iKills = hPack.ReadCell();
		
		hResults.FetchRow();
		iKills += hResults.FetchInt(0);
		
		char[] sQuery = new char[256];
		FormatEx(sQuery, 256, "UPDATE `gangs_groups` SET kills=%i WHERE gang=\"%s\"", iKills, sFormat);
		gD_Database.Query(SQL_Error, sQuery);
	}
	delete hPack;
}

public void SQLCallback_CheckIfInDatabase_Player(Database hDatabase, DBResultSet hResults, const char[] sError, int iUserID)
{
	if (hDatabase == null)
		ThrowError(sError);
	
	int client = GetClientOfUserId(iUserID);

	if (IsValidClient(client) && gS_GangName[client][0] != '\0')
	{
		char[] sQuery = new char[300];
		
		if (hResults.RowCount == 0)
			FormatEx(sQuery, 300, "INSERT INTO `gangs_players` (gang, invitedby, rank, date, steamid, player) VALUES(\"%s\", \"%s\", %i, %i, \"%s\", \"%N\")", gS_GangName[client], gS_InvitedBy[client], gI_Rank[client], gI_DateJoined[client], gS_SteamID[client], client);
		else
			FormatEx(sQuery, 300, "UPDATE `gangs_players` SET gang = \"%s\", invitedby = \"%s\", player = \"%N\", rank = %i, date = %i WHERE steamid = \"%s\"", gS_GangName[client], gS_InvitedBy[client], client, gI_Rank[client], gI_DateJoined[client], gS_SteamID[client]);
		gD_Database.Query(SQL_Error, sQuery);
		
		FormatEx(sQuery, 300, "SELECT * FROM `gangs_groups` WHERE gang = \"%s\"", gS_GangName[client]);
		gD_Database.Query(SQL_Check_Groups, sQuery, GetClientUserId(client));
	}
}

public void SQL_Check_Groups(Database hDatabase, DBResultSet hResults, const char[] sError, int iUserID)
{
	if (hDatabase == null)
		ThrowError(sError);
	
	int client = GetClientOfUserId(iUserID);

	if (IsValidClient(client) && gS_GangName[client][0] != '\0')
	{
		char[] sQuery = new char[PLATFORM_MAX_PATH];
		
		if (hResults.RowCount == 0)
			FormatEx(sQuery, PLATFORM_MAX_PATH, "INSERT INTO `gangs_groups` (gang, health, damage, gravity, speed, evasion, stealing, weapondrop) VALUES(\"%s\", %i, %i, %i, %i, %i, %i, %i)", gS_GangName[client], gI_Health[client], gI_Damage[client], gI_Gravity[client], gI_Speed[client], gI_Size[client], gI_Evade[client], gI_Stealing[client], gI_WeaponDrop[client]);
		else
			FormatEx(sQuery, PLATFORM_MAX_PATH, "UPDATE `gangs_groups` SET health=%i,damage=%i,gravity=%i,speed=%i,size=%i,evasion=%i,stealing=%i,weapondrop=%i WHERE gang=\"%s\"", gI_Health[client], gI_Damage[client], gI_Gravity[client], gI_Speed[client], gI_Size[client], gI_Evade[client], gI_Stealing[client], gI_WeaponDrop[client], gS_GangName[client]);
	
		gD_Database.Query(SQL_Error, sQuery);
	}
}

void UpdateSQL(int client, bool bLeave = false)
{
	if (gD_Database != null)
	{
		if (gB_Loaded[client] && gS_SteamID[client][0] != '\0')
		{
			char[] sQuery = new char[PLATFORM_MAX_PATH];		
			FormatEx(sQuery, PLATFORM_MAX_PATH, "SELECT `steamid` FROM `jailbreak_credits` WHERE steamid=\"%s\"", gS_SteamID[client]);
			
			if (bLeave)
			{
				DataPack hPack = new DataPack();
				hPack.WriteCell(gI_Credits[client]);
				hPack.WriteCell(gI_CasinoWins[client]);
				hPack.WriteCell(gI_CasinoLoses[client]);
				hPack.Reset();
				gD_Database.Query(SQLCallback_Credits2, sQuery, hPack);
				
				DataPack hPack2 = new DataPack();
				hPack2.WriteString(gS_SteamID[client]);
				hPack2.WriteCell(gI_StatsGuardKills[client]);
				hPack2.WriteCell(gI_StatsPrisonerKills[client]);
				hPack2.WriteCell(gI_StatsSpecialDayKills[client]);
				hPack2.WriteCell(gI_StatsLastRequestKills[client]);
				hPack2.WriteCell(gI_StatsPlayTime[client]);
				CreateTimer(0.5, Timer_SQLUpdate, hPack2, TIMER_FLAG_NO_MAPCHANGE);
				
				if (gB_HasGang[client]) 
				{
					DataPack hPack3 = new DataPack();
					hPack3.WriteString(gS_GangName[client]);
					hPack3.WriteCell(gI_GangKills[client]);
					CreateTimer(1.0, Timer_SQLUpdate2, hPack3, TIMER_FLAG_NO_MAPCHANGE);
				}
			}
			else gD_Database.Query(SQLCallback_Credits, sQuery, GetClientUserId(client));
		}
		else CreateTimer(0.1, Timer_RecheckSteamID, GetClientUserId(client), TIMER_FLAG_NO_MAPCHANGE);
	}
	else LoadSQL();	
}

public Action Timer_SQLUpdate(Handle hTimer, DataPack hPack)
{
	hPack.Reset();
	char[] sFormat = new char[32];
	hPack.ReadString(sFormat, 32);
	
	char[] sQuery = new char[PLATFORM_MAX_PATH];	
	FormatEx(sQuery, PLATFORM_MAX_PATH, "SELECT `steamid` FROM `jailbreak_stats` WHERE steamid=\"%s\"", sFormat);
	gD_Database.Query(SQLCallback_Stats2, sQuery, hPack);
}

public Action Timer_SQLUpdate2(Handle hTimer, DataPack hPack)
{
	hPack.Reset();
	char[] sFormat = new char[32];
	hPack.ReadString(sFormat, 32);
	
	char[] sQuery = new char[PLATFORM_MAX_PATH];	
	FormatEx(sQuery, PLATFORM_MAX_PATH, "SELECT `kills` FROM `gangs_groups` WHERE gang=\"%s\"", sFormat);
	gD_Database.Query(SQLCallback_GangKills, sQuery, hPack);
}

public void SQL_Callback_TopMenu(Database hDatabase, DBResultSet hResults, const char[] sError, int iUserID)
{
	if (hResults == null) 
		ThrowError(sError);
		
	else if (hResults.RowCount == 0)
		return;
	
	int client = GetClientOfUserId(iUserID);
	
	if (IsValidClient(client))
	{
		Menu hMenu = new Menu(Menu_Top10Gangs);
		hMenu.SetTitle("Top 10 Gangs\n ");
		
		char[] sGangName = new char[50];
		char[] sInfoString = new char[300];
		
		gI_TempInt2[client] = 0;
		int iGangAmmount = 0;
		
		while (hResults.FetchRow())
		{
			if (++iGangAmmount > 10)
				break;
				
			++gI_TempInt2[client];
			
			hResults.FetchString(1, sGangName, 50);
			
			FormatEx(sInfoString, 300, "%i;%s;%i;%i;%i;%i;%i;%i;%i;%i;%i", gI_TempInt2[client], sGangName, hResults.FetchInt(10), hResults.FetchInt(2), hResults.FetchInt(3), hResults.FetchInt(4), hResults.FetchInt(5), hResults.FetchInt(6), hResults.FetchInt(7), hResults.FetchInt(8), hResults.FetchInt(9));
			hMenu.AddItem(sInfoString, sGangName);
		}
		
		if (hMenu.ItemCount == 0)
		{
			PrintToChat(client, "%s There are no gangs available!", GANG_TAG);
			delete hMenu;
			return;
		}
		
		SetMenuPagination(hMenu, 5);
		hMenu.ExitBackButton = true;
		hMenu.Display(client, MENU_TIME_FOREVER);
	}
}

public int Menu_Top10Gangs(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client))
			{
				char[][] sTempArray = new char[11][300];
				char[] sQuery = new char[PLATFORM_MAX_PATH];
				char[] sInfo = new char[300];
				hMenu.GetItem(iParam, sInfo, MAX_NAME_LENGTH);
	
				ExplodeString(sInfo, ";", sTempArray, 11, 50);
				
				gI_TempInt2[client] = StringToInt(sTempArray[0]);
				gI_TempInt[client] = StringToInt(sTempArray[2]);
				
				DataPack hPack = new DataPack();
				hPack.WriteCell(GetClientUserId(client));
				hPack.WriteCell(StringToInt(sTempArray[3]));
				hPack.WriteCell(StringToInt(sTempArray[4]));
				hPack.WriteCell(StringToInt(sTempArray[5]));
				hPack.WriteCell(StringToInt(sTempArray[6]));
				hPack.WriteCell(StringToInt(sTempArray[7]));
				hPack.WriteCell(StringToInt(sTempArray[8]));
				hPack.WriteCell(StringToInt(sTempArray[9]));
				hPack.WriteCell(StringToInt(sTempArray[10]));
				FormatEx(sQuery, PLATFORM_MAX_PATH, "SELECT * FROM `gangs_players` WHERE `gang` = \"%s\" AND `rank` = 2", sTempArray[1]);
				gD_Database.Query(SQL_Callback_GangStatistics, sQuery, hPack);
			}
		}
		case MenuAction_Cancel: if (iParam == MenuCancel_ExitBack) OpenSettingsMenu(client);
		case MenuAction_End: delete hMenu;
	}
}

public void SQL_Callback_TopPlayers(Database hDatabase, DBResultSet hResults, const char[] sError, int iUserID)
{
	if (hResults == null) 
		ThrowError(sError);
	
	else if (hResults.RowCount == 0)
		return;	

	int client = GetClientOfUserId(iUserID);
	
	if (IsValidClient(client))
	{			
		Menu hMenu = new Menu(Menu_TopPlayers);
		hMenu.SetTitle("Top 10 Players\n ");
		
		char[] sName = new char[MAX_NAME_LENGTH];
		char[] sInfoString = new char[128];
		
		gI_TempInt2[client] = 0;
		int iGangAmmount = 0;
		
		while (hResults.FetchRow())
		{
			if (++iGangAmmount > 10)
				break;
				
			++gI_TempInt2[client];
			
			hResults.FetchString(0, sName, MAX_NAME_LENGTH);
			FormatEx(sInfoString, 128, "%i;%s", gI_TempInt2[client], sName);
			hResults.FetchString(1, sName, MAX_NAME_LENGTH);
			hMenu.AddItem(sInfoString, sName);
		}
		
		if (hMenu.ItemCount == 0)
		{
			PrintToChat(client, "%sThere are no stats currently.", JB_TAG);
			delete hMenu;
			return;	
		}
		
		SetMenuPagination(hMenu, 5);
		hMenu.ExitBackButton = true;
		hMenu.Display(client, MENU_TIME_FOREVER);
	}
}

public int Menu_TopPlayers(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client))
			{
				char[][] sTempArray = new char[2][40];
				char[] sQuery = new char[PLATFORM_MAX_PATH];
				char[] sInfo = new char[40];
				hMenu.GetItem(iParam, sInfo, 40);
	
				ExplodeString(sInfo, ";", sTempArray, 2, 40);
	
				gI_TempInt[client] = StringToInt(sTempArray[0]);
				
				FormatEx(sQuery, PLATFORM_MAX_PATH, "SELECT * FROM `jailbreak_stats` WHERE `steamid` = \"%s\"", sTempArray[1]);
				gD_Database.Query(SQL_Callback_TopPlayersMenu, sQuery, GetClientUserId(client));
			}
		}
		case MenuAction_Cancel: if (iParam == MenuCancel_ExitBack) OpenSettingsMenu(client);
		case MenuAction_End: delete hMenu;
	}
}

public void SQL_Callback_TopPlayersMenu(Database hDatabase, DBResultSet hResults, const char[] sError, int iUserID)
{
	if (hResults == null) 
		ThrowError(sError);
	
	else if (hResults.RowCount == 0)
		return;
	
	int client = GetClientOfUserId(iUserID);
	
	if (IsValidClient(client))
	{
		char[][] sTempArray = new char[2][64];
		char[] sDisplayString = new char[64];
		char[] sTime = new char[30];
		
		hResults.FetchRow();
		hResults.FetchString(1, sTempArray[0], MAX_NAME_LENGTH);
		hResults.FetchString(2, sTempArray[1], MAX_NAME_LENGTH);
		
		int iGuard = hResults.FetchInt(3);
		int iPrisoner = hResults.FetchInt(4);
		int iSpecial = hResults.FetchInt(5);
		int iLastRequest = hResults.FetchInt(6);
		
		Menu hMenu = new Menu(Menu_Top10Players);
		hMenu.SetTitle("Top 10 Players\nRank: %i\n ", gI_TempInt[client]);

		FormatEx(sDisplayString, 64, "Name: %s", sTempArray[1]);
		hMenu.AddItem("", sDisplayString, ITEMDRAW_DISABLED);

		FormatEx(sDisplayString, 64, "Steam ID: %s", sTempArray[0]);
		hMenu.AddItem("", sDisplayString, ITEMDRAW_DISABLED);

		FormatEx(sDisplayString, 64, "Kills: %i", iGuard + iPrisoner + iSpecial + iLastRequest);
		hMenu.AddItem("", sDisplayString, ITEMDRAW_DISABLED);
		
		FormatEx(sDisplayString, 64, "Guard Kills: %i", iGuard);
		hMenu.AddItem("", sDisplayString, ITEMDRAW_DISABLED);
		
		FormatEx(sDisplayString, 64, "Prisoner Kills: %i", iPrisoner);
		hMenu.AddItem("", sDisplayString, ITEMDRAW_DISABLED);
		
		FormatEx(sDisplayString, 64, "Special Day Kills: %i", iSpecial);
		hMenu.AddItem("", sDisplayString, ITEMDRAW_DISABLED);

		FormatEx(sDisplayString, 64, "Lastrequest Kills: %i", iLastRequest);
		hMenu.AddItem("", sDisplayString, ITEMDRAW_DISABLED);
		
		SecondsToTime(hResults.FetchInt(7), sTime);
		FormatEx(sDisplayString, 64, "Playtime: %s", sTime);
		hMenu.AddItem("", sDisplayString, ITEMDRAW_DISABLED);

		SetMenuPagination(hMenu, MENU_NO_PAGINATION);
		hMenu.ExitButton = true;
		hMenu.Display(client, MENU_TIME_FOREVER);
	}
}

public int Menu_Top10Players(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	if (hAction == MenuAction_End)
		delete hMenu;
}

public void SQL_Callback_Top10Richest(Database hDatabase, DBResultSet hResults, const char[] sError, int iUserID)
{
	if (hResults == null) ThrowError(sError);
	
	else if (hResults.RowCount == 0)
		return;	

	int client = GetClientOfUserId(iUserID);
	
	if (IsValidClient(client))
	{			
		Menu hMenu = new Menu(Menu_TopRichest);
		hMenu.SetTitle("Top 10 Richest\n ");
		
		char[] sName = new char[MAX_NAME_LENGTH];
		char[] sInfoString = new char[128];
		
		gI_TempInt2[client] = 0;
		int iGangAmmount = 0;
		
		while (hResults.FetchRow())
		{
			if (++iGangAmmount > 10)
				break;
				
			++gI_TempInt2[client];
			
			hResults.FetchString(0, sName, MAX_NAME_LENGTH);
			FormatEx(sInfoString, 128, "%i;%s", gI_TempInt2[client], sName);
			hResults.FetchString(1, sName, MAX_NAME_LENGTH);
			hMenu.AddItem(sInfoString, sName);
		}
		
		if (hMenu.ItemCount == 0)
		{
			PrintToChat(client, "%sThere are no stats currently.", JB_TAG);
			delete hMenu;
			return;	
		}
		
		SetMenuPagination(hMenu, 5);
		hMenu.ExitBackButton = true;
		hMenu.Display(client, MENU_TIME_FOREVER);
	}
}

public int Menu_TopRichest(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client))
			{
				char[][] sTempArray = new char[2][40];
				char[] sQuery = new char[PLATFORM_MAX_PATH];
				char[] sInfo = new char[40];
				hMenu.GetItem(iParam, sInfo, 40);
	
				ExplodeString(sInfo, ";", sTempArray, 2, 40);
	
				gI_TempInt[client] = StringToInt(sTempArray[0]);
				
				FormatEx(sQuery, PLATFORM_MAX_PATH, "SELECT `steamid`, `player`, `credits`, `casinowins`, `casinoloses` FROM `jailbreak_credits` WHERE `steamid` = \"%s\"", sTempArray[1]);
				gD_Database.Query(SQL_Callback_TopRichest, sQuery, GetClientUserId(client));
			}
		}
		case MenuAction_Cancel: if (iParam == MenuCancel_ExitBack) OpenSettingsMenu(client);
		case MenuAction_End: delete hMenu;
	}
}

public void SQL_Callback_TopRichest(Database hDatabase, DBResultSet hResults, const char[] sError, int iUserID)
{
	if (hResults == null) ThrowError(sError);
	
	else if (hResults.RowCount == 0)
		return;
	
	int client = GetClientOfUserId(iUserID);
	
	if (IsValidClient(client))
	{
		char[][] sTempArray = new char[2][64];
		char[] sDisplayString = new char[64];
		
		hResults.FetchRow();
		hResults.FetchString(0, sTempArray[0], MAX_NAME_LENGTH);
		hResults.FetchString(1, sTempArray[1], MAX_NAME_LENGTH);
		
		Menu hMenu = new Menu(Menu_Richest);
		hMenu.SetTitle("Top 10 Richest\nRank: %i\n ", gI_TempInt[client]);

		FormatEx(sDisplayString, 64, "Name: %s", sTempArray[1]);
		hMenu.AddItem("", sDisplayString, ITEMDRAW_DISABLED);

		FormatEx(sDisplayString, 64, "Steam ID: %s", sTempArray[0]);
		hMenu.AddItem("", sDisplayString, ITEMDRAW_DISABLED);

		FormatEx(sDisplayString, 64, "Credits: %i", hResults.FetchInt(2));
		hMenu.AddItem("", sDisplayString, ITEMDRAW_DISABLED);
		
		FormatEx(sDisplayString, 64, "Casino Wins: %i", hResults.FetchInt(3));
		hMenu.AddItem("", sDisplayString, ITEMDRAW_DISABLED);
		
		FormatEx(sDisplayString, 64, "Casino Loses: %i", hResults.FetchInt(4));
		hMenu.AddItem("", sDisplayString, ITEMDRAW_DISABLED);

		hMenu.ExitBackButton = true;
		hMenu.Display(client, MENU_TIME_FOREVER);
	}
}

public int Menu_Richest(Menu hMenu, MenuAction hAction, int client, int iParam)
{
	switch (hAction)
	{
		case MenuAction_Cancel: if (iParam == MenuCancel_ExitBack && IsValidClient(client)) gD_Database.Query(SQL_Callback_Top10Richest, "SELECT `steamid`, `player` FROM `jailbreak_credits` ORDER BY `credits` DESC", GetClientUserId(client));
		case MenuAction_End: delete hMenu;
	}
}


/*===============================================================================================================================*/
/********************************************************* [STOCKS] **************************************************************/
/*===============================================================================================================================*/


void RemoveFromGang(int client)
{
	char[] sQuery = new char[300];
	
	if (gI_Rank[client] == GANGRANK_OWNER)
	{
		FormatEx(sQuery, 300, "DELETE FROM gangs_players WHERE gang = \"%s\"", gS_GangName[client]);
		gD_Database.Query(SQL_Error, sQuery);
		
		FormatEx(sQuery, 300, "DELETE FROM gangs_groups WHERE gang = \"%s\"", gS_GangName[client]);
		gD_Database.Query(SQL_Error, sQuery);
		
		PrintToChatAll("%s \x09%N\x01 has disbanded the gang \x02%s", GANG_TAG, client, gS_GangName[client]);
		LogMessage("[%s] %L has disbanded the gang!", gS_GangName[client], client);
		
		for (int i = 1; i <= MaxClients; ++i)
		{
			if (IsClientInGame(i) && StrEqual(gS_GangName[i], gS_GangName[client]))
				ResetVariables(i);
		}
	}
	else
	{
		FormatEx(sQuery, 128, "DELETE FROM gangs_players WHERE steamid = \"%s\"", gS_SteamID[client]);
		gD_Database.Query(SQL_Error, sQuery);
		
		switch (gI_Rank[client])
		{
			case GANGRANK_OWNER: strcopy(sQuery, 9, "[Boss]");
			case GANGRANK_ADMIN: strcopy(sQuery, 9, "[OG]");
			case GANGRANK_NORMAL: strcopy(sQuery, 9, "[Member]");	
		}
		
		PrintToChatAll("%s \x09%N\x01 has left the gang \x02%s", GANG_TAG, client, gS_GangName[client]);
		LogMessage("(%s) %s %L has left the gang!", gS_GangName[client], sQuery, client);
		ResetVariables(client);
	}
}

void PrintToGang(int client, bool bPrintToClient, const char[] sMsg, any ...)
{
	char[] sFormattedMsg = new char[PLATFORM_MAX_PATH];
	VFormat(sFormattedMsg, PLATFORM_MAX_PATH, sMsg, 4); 

	for (int i = 1; i <= MaxClients; ++i)
	{
		if (IsClientInGame(i) && gB_HasGang[i] && StrEqual(gS_GangName[i], gS_GangName[client]))
		{
			if (bPrintToClient)
				PrintToChat(i, sFormattedMsg);
			else
				if (i != client) PrintToChat(i, sFormattedMsg);
		}
	}
}

void CheckParachute(int client, int buttons)
{
	if (gB_ParachuteOpened[client])
	{
		if (!(buttons & IN_USE))
		{
			DisableParachute(client);
			return;
		}
		
		float fVel[3];
		GetEntPropVector(client, Prop_Data, "m_vecVelocity", fVel);
		
		if (fVel[2] >= 0.0)
		{
			DisableParachute(client);
			return;
		}
		
		if (GetEntityFlags(client) & FL_ONGROUND)
		{
			DisableParachute(client);
			return;
		}
		
		float fOldSpeed = fVel[2];
		
		if (fVel[2] < SHOP_PARACHUTE_SPEED * (-1.0))
			fVel[2] = SHOP_PARACHUTE_SPEED * (-1.0);
		
		if (fOldSpeed != fVel[2])
			TeleportEntity(client, NULL_VECTOR, NULL_VECTOR, fVel);
	}
	else if (gB_Parachute[client])
	{
		if (!(buttons & IN_USE))
			return;
		
		if (GetEntityFlags(client) & FL_ONGROUND)
			return;
		
		float fVel[3];
		GetEntPropVector(client, Prop_Data, "m_vecVelocity", fVel);
		
		if (fVel[2] >= 0.0)
			return;
		
		int iEntity = CreateEntityByName("prop_dynamic_override");
		DispatchKeyValue(iEntity, "model", SHOP_PARACHUTE_MODEL);
		DispatchSpawn(iEntity);
		
		SetEntityMoveType(iEntity, MOVETYPE_NOCLIP);
		
		float fPos[3], fAng[3];
		GetClientAbsOrigin(client, fPos);
		GetClientAbsAngles(client, fAng);
		fAng[0] = 0.0;
		TeleportEntity(iEntity, fPos, fAng, NULL_VECTOR);
		
		char[] sClient = new char[16];
		FormatEx(sClient, 16, "client%d", client);
		DispatchKeyValue(client, "targetname", sClient);
		SetVariantString(sClient);
		AcceptEntityInput(iEntity, "SetParent", iEntity, iEntity, 0);
		
		gI_ParachuteEntityRef[client] = EntIndexToEntRef(iEntity);
		gB_ParachuteOpened[client] = true;
	}
}

void DisableParachute(int client)
{
	int iEntity = EntRefToEntIndex(gI_ParachuteEntityRef[client]);
	
	if (iEntity != INVALID_ENT_REFERENCE)
	{
		AcceptEntityInput(iEntity, "ClearParent");
		AcceptEntityInput(iEntity, "kill");
	}
	
	gB_ParachuteOpened[client] = false;
	gI_ParachuteEntityRef[client] = INVALID_ENT_REFERENCE;
}

void CheckHook(int client, int buttons)
{
	if (gB_Hooking[client])
	{
		if (!(buttons & IN_USE))
		{
			RemoveHook(client);
			return;
		}

		int iEntity = EntRefToEntIndex(gI_HookRef[client]);

		if (iEntity == INVALID_ENT_REFERENCE)
		{
			gB_Hooking[client] = false;
			gB_Hooked[client] = false;
			gI_HookTarget[client] = -1;
			return;			
		}
		
		if (gB_Hooked[client])
		{
			int iTarget = GetClientOfUserId(gI_HookTarget[client]);
			
			float fOrigin[3], fVel[3];
			GetClientEyePosition(client, fOrigin);
			
			if (0 < iTarget <= MaxClients && IsClientInGame(iTarget))
			{
				GetClientEyePosition(iTarget, gF_HookLocation[client]);
				gF_HookLocation[client][2] -= 30;
			}
			else if (GetVectorDistance(fOrigin, gF_HookLocation[client]) < 20)
				SetEntityMoveType(client, MOVETYPE_NONE);
			
			for (int i = 0; i < 3; ++i)
				fVel[i] = fOrigin[i];
			SubtractVectors(gF_HookLocation[client], fVel, fVel);
				
			NormalizeVector(fVel, fVel);
			ScaleVector(fVel, SHOP_HOOK_SPEED);
			TeleportEntity(client, NULL_VECTOR, NULL_VECTOR, fVel);
			TeleportEntity(iEntity, gF_HookLocation[client], NULL_VECTOR, NULL_VECTOR);
			
			fOrigin[2] -= 5;
			TE_SetupBeamPoints(fOrigin, gF_HookLocation[client], gI_Sprites[0], 0, 0, 66, 0.1, 2.0, 2.0, 0, 0.0, {255, 255, 255, 255}, 0);
			TE_SendToAll();
		}
		else
		{
			float fVel[3];
			
			if (CheckCollusion(iEntity, client, fVel))
			{
				SetEntityMoveType(iEntity, MOVETYPE_NOCLIP);
				gB_Hooked[client] = true;
				
				for (int i = 0; i < 3; ++i)
					gF_HookLocation[client][i] = fVel[i];
					
				float fOrigin[3];
				GetClientEyePosition(client, fOrigin);
				SubtractVectors(fVel, fOrigin, fOrigin);
				NormalizeVector(fOrigin, fOrigin);
				ScaleVector(fOrigin, SHOP_HOOK_SPEED);
				
				TeleportEntity(client, NULL_VECTOR, NULL_VECTOR, fOrigin);
				TeleportEntity(iEntity, gF_HookLocation[client], NULL_VECTOR, NULL_VECTOR);
				
				fOrigin[2] -= 5;
				TE_SetupBeamPoints(fOrigin, gF_HookLocation[client], gI_Sprites[0], 0, 0, 66, 0.1, 2.0, 2.0, 0, 0.0, {255, 255, 255, 255}, 0);
				TE_SendToAll();
			}
			else
			{
				float fAng[3], fOrigin[3], fPos[3];
				GetClientEyePosition(client, fOrigin);
				GetEntPropVector(iEntity, Prop_Send, "m_vecOrigin", fPos);
				GetEntPropVector(iEntity, Prop_Data, "m_angRotation", fAng);
				GetAngleVectors(fAng, fVel, NULL_VECTOR, NULL_VECTOR);
				ScaleVector(fVel, 800.0);
				TeleportEntity(iEntity, NULL_VECTOR, fAng, fVel);
				
				fOrigin[2] -= 10;
				TE_SetupBeamPoints(fOrigin, fPos, gI_Sprites[0], 0, 0, 66, 0.1, 2.0, 2.0, 0, 0.0, {255, 255, 255, 255}, 0);
				TE_SendToAll();
			}
		}
	}
	else if (gB_Hook[client])
	{
		if (!(buttons & IN_USE))
			return;
			
		int iEntity = CreateEntityByName("prop_physics_override");
		DispatchKeyValue(iEntity, "model", "models/chicken/chicken.mdl");
		DispatchSpawn(iEntity);
		SetEntProp(iEntity, Prop_Send, "m_CollisionGroup", 2);
		SetEntityRenderMode(iEntity, RENDER_NONE);
		
		float fPos[3], fAng[3], fVel[3];
		GetClientEyePosition(client, fPos);
		GetClientEyeAngles(client, fAng);
		GetAngleVectors(fAng, fVel, NULL_VECTOR, NULL_VECTOR);
		ScaleVector(fVel, 1000.0);
		TeleportEntity(iEntity, fPos, fAng, fVel);
		SetEntityGravity(iEntity, 0.0);
		
		gI_HookRef[client] = EntIndexToEntRef(iEntity);
		gB_Hooking[client] = true;
	}
}

void RemoveHook(int client)
{
	int iEntity = EntRefToEntIndex(gI_HookRef[client]);
	
	if (iEntity != INVALID_ENT_REFERENCE)
		AcceptEntityInput(iEntity, "kill");
	
	gI_HookRef[client] = INVALID_ENT_REFERENCE;
	gI_HookTarget[client] = -1;
	gB_Hooking[client] = false;
	gB_Hooked[client] = false;

	SetEntityMoveType(client, MOVETYPE_WALK);
}

public bool TraceRayFilterEntity(int entity, int mask, any data) 
{
    if (entity == data || EntRefToEntIndex(gI_HookRef[data]) == entity) 
        return false;
    return true;
}  

bool CheckCollusion(int entity, int iPlayer, float fPosition[3])
{
	float fOrigin[3], fAngles[3], fForward[3], fEndPoint[3];
	GetEntPropVector(entity, Prop_Send, "m_vecOrigin", fOrigin);
	GetEntPropVector(entity, Prop_Data, "m_angRotation", fAngles);
	GetAngleVectors(fAngles, fForward, NULL_VECTOR, NULL_VECTOR);
	
	for (int i = 0; i < 3; ++i) {
		fEndPoint[i] = fOrigin[i] + (fForward[i] * 20);
	}
	
	Handle hTrace = TR_TraceRayFilterEx(fOrigin, fEndPoint, MASK_SOLID, RayType_EndPoint, TraceRayFilterEntity, iPlayer);
	
	if (TR_DidHit(hTrace))
	{
		int iEnt = TR_GetEntityIndex(hTrace);
		
		if (!(0 < iEnt <= MaxClients) || !IsClientInGame(iEnt))
		{
			if (TR_PointOutsideWorld(fEndPoint))
			{
				fEndPoint[2] += 3; 
				
				if (TR_PointOutsideWorld(fEndPoint))
				{
					fEndPoint[2] -= 3; 
					
					int iLoop;
					
					bool bSkyBox = true;
					
					while (iLoop < 100)
					{
						for (int i = 0; i < 3; ++i) {
							fEndPoint[i] += (fForward[i] * 20);
						}
						
						if (!TR_PointOutsideWorld(fEndPoint))
						{
							bSkyBox = false;
							break;
						}
						++iLoop;
					}
					
					if (bSkyBox)
					{
						EmitSoundToAll(SOUND_HOOK_MISS, entity, SNDCHAN_ITEM);
						RemoveHook(iPlayer);
						delete hTrace;
						return false;
					}
				}
			}
			EmitSoundToAll(SOUND_HOOK_HIT, entity, SNDCHAN_ITEM);
		}
		else 
		{
			EmitSoundToAll(SOUND_HOOK_HITPLAYER, entity, SNDCHAN_ITEM);
			gI_HookTarget[iPlayer] = GetClientUserId(iEnt);
		}
		TR_GetEndPosition(fPosition, hTrace);
		delete hTrace;
		return true;
	}
	delete hTrace;
	return false;
}

void ResetCasino(int client)
{
	gI_GameMode[client] = -1;
	gI_Dealer[client] = 0;
	gI_DealerCard[client] = 0;
	gI_ClientCards[client] = 0;	
}

void ResetVariables(int client, bool bLeave = false)
{
	if (bLeave)
	{
		gB_PlayerSteps[client] = false;
		gS_SteamID[client][0] = '\0';
		gB_Loaded[client] = false;
		gI_TempInt[client] = 0;
		gI_TempInt2[client] = 0;
		gI_Credits[client] = 0;
		gI_CasinoWins[client] = 0;
		gI_CasinoLoses[client] = 0;
	}
	
	if (gB_HasGang[client])
	{
		gB_GangInvitation[client] = false;
		gI_Rank[client] = -1;
		gI_GangSize[client] = 0;
		gI_Invitation[client] = -1;
		gI_DateJoined[client] = -1;
		gI_Health[client] = 0;
		gI_Damage[client] = 0;
		gI_Evade[client] = 0;
		gI_Gravity[client] = 0;
		gI_Speed[client] = 0;
		gI_Stealing[client] = 0;
		gI_WeaponDrop[client] = 0;
		gI_Size[client] = 0;
		gS_GangName[client][0] = '\0';
		gS_InvitedBy[client][0] = '\0';
		gB_SetName[client] = false;
		gB_HasGang[client] = false;
		gB_Rename[client] = false;
	}
}

bool Checker(int client, bool bAlive, int iTeam = 0, bool bWarden = false, bool bFree = false, bool bSpecialDay = true, bool bLastRequest = true)
{
	if (!IsValidClient(client))
		return false;	
	else if (!IsPlayerAlive(client) && bAlive)
	{
		PrintToChat(client, "%sMust be alive!", JB_TAG);
		return false;
	}
	else if (iTeam > 0 && GetClientTeam(client) != iTeam)
	{
		PrintToChat(client, "%sMust be a %s\x01!", JB_TAG, (iTeam == 1) ? "\x03Spectator": (iTeam == 2) ? "\x09Prisoner":"\x0BGuard");
		return false;
	}
	else if (bSpecialDay && gH_SpecialDay != SPECIALDAY_INVALID)
	{
		PrintToChat(client, "%sSpecial Day in Progress!", JB_TAG);
		return false;
	}
	else if (bLastRequest && gH_LastRequest != LASTREQUEST_INVALID)
	{
		PrintToChat(client, "%sLastrequest is in Progress!", JB_TAG);
		return false;
	}
	else if (bFree && gB_FreeDay)
	{
		PrintToChat(client, "%s\x09Freeday\x01 is currently active!", JB_TAG);
		return false;	
	}
	else if (bWarden && client != gI_Warden)
	{
		PrintToChat(client, "%sMust be the \x0CWarden\x01 to use this command!", JB_TAG);
		return false;
	}
	else return true;
}

void RoundEndChecks()
{
	if (gB_FreeForAll)
	{
		int iPlayers;
		
		if (gH_SpecialDay == SPECIALDAY_KNIFE)
		{
			for (int i = 1; i <= MaxClients; ++i)
			{
				if (IsClientInGame(i) && gI_Activity[i] > 0)
					++iPlayers;
			}
		}
		else if (gH_SpecialDay == SPECIALDAY_KILLCONFIRM)
		{
			for (int i = 1; i <= MaxClients; ++i)
			{
				if (IsClientInGame(i) && gI_Activity[i] != -1)
					++iPlayers;
			}
		}
		else if (gH_SpecialDay == SPECIALDAY_GUNGAME)
		{
			if (GetClientCount(true) == 1)
				CS_TerminateRound(5.0, CSRoundEnd_Draw, true);
			return;
		}
		else
		{
			for (int i = 1; i <= MaxClients; ++i)
			{
				if (IsClientInGame(i) && IsPlayerAlive(i))
					++iPlayers;
			}
		}
		
		if (iPlayers < 2)
			CS_TerminateRound(5.0, CSRoundEnd_TerroristWin, true);
	}
	else
	{
		int iGuards, iPrisoners;
		
		for (int i = 1; i <= MaxClients; ++i)
		{
			if (IsClientInGame(i) && IsPlayerAlive(i))
			{
				switch (GetClientTeam(i))
				{
					case 2: ++iPrisoners;
					case 3: ++iGuards;					
				}
			}
		}
		
		if (iGuards == 0)
		{
			if (iPrisoners > 0)
			{
				CS_TerminateRound(5.0, CSRoundEnd_TerroristWin, true);
				SetTeamScore(2, GetTeamScore(2) + 1);
			}
			else CS_TerminateRound(5.0, CSRoundEnd_Draw, true);
		}
		else
		{
			if (iPrisoners == 0)
			{
				CS_TerminateRound(5.0, CSRoundEnd_CTWin, true);
				SetTeamScore(3, GetTeamScore(3) + 1);
			}
		}
	}
}

void UpdateBans(int client, int iTime, int iAdmin, char[] sSteamId = "")
{
	char[] sName = new char[100];
	char[] sInfo = new char[MAX_NAME_LENGTH];
	strcopy(sName, MAX_NAME_LENGTH, "N/A");
	
	if (client != 0)
	{
		GetClientAuthId(client, AuthId_Steam2, sInfo, MAX_NAME_LENGTH);
		GetClientName(client, sName, 100);
	}
	else strcopy(sInfo, MAX_NAME_LENGTH, sSteamId);
	
	char[] sDate = new char[100];
	FormatTime(sDate, 100, NULL_STRING);
	
	char[] sTime = new char[70];
	SecondsToTime((iTime - GetTime()), sTime);	

	gK_GuardBans.JumpToKey(sInfo, true);
	gK_GuardBans.SetString("name", sName);
	gK_GuardBans.SetString("date", sDate);
	
	if (iTime == -2)
		gK_GuardBans.SetString("length", "Forever");
	else
		gK_GuardBans.SetString("length", sTime);
	
	FormatEx(sTime, MAX_NAME_LENGTH, "%i", iTime);
	gK_GuardBans.SetString("time-stamp", sTime);
	
	GetClientName(iAdmin, sName, 100);
	GetClientAuthId(iAdmin, AuthId_Steam2, sInfo, MAX_NAME_LENGTH);
	Format(sName, 100, "%s [%s]", sName, sInfo);
	
	gK_GuardBans.SetString("banned by", sName);
	gK_GuardBans.Rewind();
	
	char[] sPath = new char[PLATFORM_MAX_PATH];
	BuildPath(Path_SM, sPath, PLATFORM_MAX_PATH, "configs/jailbreak/guardbans.cfg");
	gK_GuardBans.ImportFromFile(sPath);
}

void CheckBans(int client)
{
	char[] sSteamId = new char[MAX_NAME_LENGTH];
	GetClientAuthId(client, AuthId_Steam2, sSteamId, MAX_NAME_LENGTH);
 
	if (gK_GuardBans.JumpToKey(sSteamId, false))
	{
		char[] sLength = new char[MAX_NAME_LENGTH];
		gK_GuardBans.GetString("length", sLength, MAX_NAME_LENGTH);
		
		if (StrEqual(sLength, "Forever"))
		{
			gI_ClientBan[client] = -2;
			gK_GuardBans.Rewind();
			return;
		}	
		
		gK_GuardBans.GetString("time-stamp", sLength, MAX_NAME_LENGTH);
		gI_ClientBan[client] = StringToInt(sLength);
		
		if (gI_ClientBan[client] < GetTime())
			RemoveGuardBan(client);	
	}
	gK_GuardBans.Rewind();
}

bool CheckSteamId(char[] sSteamId)
{
	if (gK_GuardBans.JumpToKey(sSteamId, false))
	{
		gK_GuardBans.Rewind();
		return true;
	}
	gK_GuardBans.Rewind();
	return false;	
}

void RemoveGuardBan(int client, char[] sSteam = "")
{
	char[] sSteamId = new char[MAX_NAME_LENGTH];
	
	if (client != 1337)
	{
		gI_ClientBan[client] = -1;
		GetClientAuthId(client, AuthId_Steam2, sSteamId, MAX_NAME_LENGTH);
		SetClientCookie(client, gH_GuardCookie, "0");
		gB_GuardMenu[client] = false;
	}
	else strcopy(sSteamId, MAX_NAME_LENGTH, sSteam);

	if (!gK_GuardBans.JumpToKey(sSteamId, false))
	{
		gK_GuardBans.Rewind();
		return;
	}	
	gK_GuardBans.DeleteThis();
	gK_GuardBans.Rewind();
	
	char[] sPath = new char[PLATFORM_MAX_PATH];
	BuildPath(Path_SM, sPath, PLATFORM_MAX_PATH, "configs/jailbreak/guardbans.cfg");
	gK_GuardBans.ExportToFile(sPath);
}

void SecondsToTime(int iLength, char[] sBuffer)
{	
	if (iLength == -2)
	{
		strcopy(sBuffer, 70, "Forever");
		return;
	}
	
	int iDays, iHours, iMinutes, iTime;
	
	iTime = RoundToFloor(float(iLength));
	
	if (iTime >= 86400)
	{
		iDays = RoundToFloor(float(iTime / 86400));
		iTime %= 86400;
    }
    
	if (iTime >= 3600)
	{
		iHours = RoundToFloor(float(iTime / 3600));
		iTime %= 3600;
    }
    
	if (iTime >= 60)
	{
		iMinutes = RoundToFloor(float(iTime / 60));
		iTime %= 60;
    }
	FormatEx(sBuffer, 70, "%02i:%02i:%02i:%02i", iDays, iHours, iMinutes, iTime);
}

void GiveWeapons(int client)
{
	RemoveAllWeapons(client);
	GivePlayerItem(client, "weapon_knife");
	
	GivePlayerItem(client, "item_assaultsuit");
	GivePlayerItem(client, "weapon_tagrenade");
	GivePlayerItem(client, "weapon_healthshot");
	
	if (gF_CagePosition[0] != 0.0)
	{
		int iWeapon = GivePlayerItem(client, "weapon_taser");
		SetEntProp(iWeapon, Prop_Send, "m_iClip1", 230);
	}
	
	switch (gI_PrimaryWeapon[client])
	{
		case 0: GivePlayerItem(client, "weapon_ak47");
		case 1: GivePlayerItem(client, "weapon_m4a1");
		case 2: GivePlayerItem(client, "weapon_m4a1_silencer");
		case 3: GivePlayerItem(client, "weapon_awp");
		case 4: GivePlayerItem(client, "weapon_aug");
		case 5: GivePlayerItem(client, "weapon_sg556");
		case 6: GivePlayerItem(client, "weapon_famas");
		case 7: GivePlayerItem(client, "weapon_galilar");
		case 8: GivePlayerItem(client, "weapon_ssg08");
		case 9: GivePlayerItem(client, "weapon_p90");
		case 10: GivePlayerItem(client, "weapon_ump45");
		case 11: GivePlayerItem(client, "weapon_mac10");
		case 12: GivePlayerItem(client, "weapon_mp9");
		case 13: GivePlayerItem(client, "weapon_mp7");
		case 14: GivePlayerItem(client, "weapon_bizon");
		case 15: GivePlayerItem(client, "weapon_nova");
		case 16: GivePlayerItem(client, "weapon_mag7");
		case 17: GivePlayerItem(client, "weapon_sawedoff");
		case 18: GivePlayerItem(client, "weapon_xm1014");
	}
	
	switch (gI_SecondaryWeapon[client])
	{
		case 0: GivePlayerItem(client, "weapon_deagle");
		case 1: GivePlayerItem(client, "weapon_revolver");
		case 2: GivePlayerItem(client, "weapon_tec9");
		case 3: GivePlayerItem(client, "weapon_fiveseven");
		case 4: GivePlayerItem(client, "weapon_cz75a");
		case 5: GivePlayerItem(client, "weapon_elite");
		case 6: GivePlayerItem(client, "weapon_p250");
		case 7: GivePlayerItem(client, "weapon_usp_silencer");
		case 8: GivePlayerItem(client, "weapon_hkp2000");
		case 9: GivePlayerItem(client, "weapon_glock");
	}
}

void EnableSpecialDay(int client)
{
	if (client == 1337) {}
	else if (!IsValidClient(client) && IsPlayerAlive(client) || GetClientTeam(client) != 3)
		return;
				
	++gI_Cells;
	
	if (gI_Warden != -1)
	{
		CS_SetClientClanTag(gI_Warden, "");
		gI_Warden = -1;
	}
	
	gI_DayDelay = gI_Round + SPECIALDAYDELAY;
	
	ResetMarker();
	Cells(true);
	
	gB_Cells = true;
	gB_Math = false;
	gB_DeathBall = false;
	gB_TickingTimeBomb = false;
	gB_KnifeDuel = false;
	gB_Shove = false;
	gB_FreeForAll = false;
	gCV_FriendlyFire.SetInt(0);
	
	if (gI_Spawns >= GetTeamClientCount(2) + GetTeamClientCount(3))
		gI_Seconds = 10;
	else
		gI_Seconds = 15;
	
	for (int i = 1; i <= MaxClients; ++i)
	{
		if (IsClientInGame(i))
		{
			if (GetClientTeam(i) > 1 && !IsPlayerAlive(i))
				CS_RespawnPlayer(i);
			
			gB_Paint[i] = false;
			gB_Freeday[i] = false;
			
			gI_CheckHealth[i] = 100;
			SetEntityGravity(i, 1.0);
			SetEntityHealth(i, 100);
			SetEntPropFloat(i, Prop_Data, "m_flLaggedMovementValue", 1.0);
			GivePlayerItem(i, "item_assaultsuit");
			SetGlow(i, 255, 255, 255, 255);
			RemoveAllWeapons(i);
			
			if (gB_BaseComm)
			{
				if (!BaseComm_IsClientMuted(i))
					SetClientListeningFlags(i, VOICE_NORMAL);
			}
			else SetClientListeningFlags(i, VOICE_NORMAL);
			
			if (client != 1337)
				PrintToChat(i, "%s\x0B%N \x01has started a \x04Special Day %s\x01!", JB_TAG, client, (gH_SpecialDay != SPECIALDAY_VOTE)? "":"Vote");
			else
				PrintToChat(i, "%sSpecial Day is now starting...", JB_TAG);
		}
	}
	
	if (gH_SpecialDay != SPECIALDAY_VOTE)
	{
		int ent = -1;
		
		while ((ent = FindEntityByClassname(ent, "weapon_*")) != -1)
			AcceptEntityInput(ent, "Kill");
		
		gCV_Radar.SetInt(0);
		
		switch (gH_SpecialDay)
		{
			case SPECIALDAY_GANG: gCV_FriendlyFire.SetInt(1);
			case SPECIALDAY_ONEINACHAMBER, SPECIALDAY_NADE, SPECIALDAY_KNIFE, SPECIALDAY_KILLCONFIRM, SPECIALDAY_COCKTAIL, SPECIALDAY_JEDI:
			{
				gB_FreeForAll = true;
				gCV_FriendlyFire.SetInt(1);
			}
			case SPECIALDAY_NOSCOPE, SPECIALDAY_SCOUTZKNIVEZ, SPECIALDAY_GUNGAME:
			{
				gB_FreeForAll = true;
				gCV_FriendlyFire.SetInt(1);
				gCV_InfiniteAmmo.SetInt(2);
			}
			case SPECIALDAY_HEADSHOT:
			{
				gB_FreeForAll = true;
				gCV_FriendlyFire.SetInt(1);
				gCV_InfiniteAmmo.SetInt(2);
				gCV_HeadshotOnly.SetInt(1);
			}
			case SPECIALDAY_TRIGGER: 
			{
				gB_FreeForAll = true;
				gCV_FriendlyFire.SetInt(1);	
				gCV_SelfDamage.SetFloat(0.2);
			}
		}
		CreateTimer(1.0, Timer_Countdown, gI_Round, TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
	}
	else
	{
		Menu hMenu = new Menu(Menu_VotingDay);
		hMenu.SetTitle("Special Day Vote\n ");
		hMenu.AddItem("Knife Battle", "Knife Battle");
		hMenu.AddItem("Kill Confirmed", "Kill Confirmed");
		hMenu.AddItem("Gang War", "Gang War");
		hMenu.AddItem("No Scope", "No Scope");
		hMenu.AddItem("Scoutzknivez", "Scoutzknivez");
		hMenu.AddItem("One in a Chamber", "One in a Chamber");
		hMenu.AddItem("Nade War", "Nade War");
		hMenu.AddItem("Headshot", "Headshot");
		hMenu.AddItem("Jedi", "Jedi");
		hMenu.AddItem("Shark", "Shark");
		hMenu.AddItem("NightCrawler", "NightCrawler");
		hMenu.AddItem("Cocktail Party", "Cocktail Party");
		hMenu.AddItem("Trigger Discipline", "Trigger Discipline");
		hMenu.AddItem("Gun Game", "Gun Game");
		hMenu.ExitButton = false;
		
		for (int i = 1; i <= MaxClients; ++i)
			if (IsClientInGame(i)) 
				hMenu.Display(i, 20);
		
		CreateTimer(1.0, Timer_Vote, GetGameTime() + 21, TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
	}
}

void TriggerSpecialDays()
{
	char[] sFormat = new char[100];
	char[][] sBuffer = new char[3][100];
	
	float fPos[3];
	float[][] fLocation = new float[(gI_Spawns <= 0)? 1:gI_Spawns][3];
		
	int iSpawns = -1;
	
	bool bSpawn = false;
	
	if (gI_Spawns >= GetTeamClientCount(2) + GetTeamClientCount(3))
	{
		bSpawn = true;
		
		for (int i = 0; i < gI_Spawns; ++i)
		{
			gA_SpawnLocation.GetString(i, sFormat, 100);
			ExplodeString(sFormat, ";", sBuffer, 3, 100);
			
			fLocation[i][0] = StringToFloat(sBuffer[0]);
			fLocation[i][1] = StringToFloat(sBuffer[1]);
			fLocation[i][2] = StringToFloat(sBuffer[2]);
		}
	}
	
	switch (gH_SpecialDay)
	{
		case SPECIALDAY_SCOUTZKNIVEZ:
		{
			gCV_Gravity.SetInt(200);
			
			for (int i = 1; i <= MaxClients; ++i)
			{
				if (IsClientInGame(i) && GetClientTeam(i) > 1)
				{
					if (!IsPlayerAlive(i))
						CS_RespawnPlayer(i);
					
					GivePlayerItem(i, "weapon_knife");
					GivePlayerItem(i, "weapon_ssg08");
					ClientCommand(i, "play %s", SOUND_SD_SCOUTZKNIVEZ);
					
					if (bSpawn)
					{
						++iSpawns;
						
						if (iSpawns <= gI_Spawns)
						{
							fPos[0] = fLocation[iSpawns][0];
							fPos[1] = fLocation[iSpawns][1];
							fPos[2] = fLocation[iSpawns][2];
							TeleportEntity(i, fPos, NULL_VECTOR, NULL_VECTOR);
						}
					}
				}
			}
			gCV_Radar.SetInt(1);
		}
		case SPECIALDAY_ONEINACHAMBER:
		{			
			for (int i = 1; i <= MaxClients; ++i)
			{
				if (IsClientInGame(i) && GetClientTeam(i) > 1)
				{
					if (!IsPlayerAlive(i))
						CS_RespawnPlayer(i);
					
					GivePlayerItem(i, "weapon_knife");
					gI_CheckHealth[i] = 1;
					
					int iWeapon = GivePlayerItem(i, "weapon_deagle");
					SetEntProp(iWeapon, Prop_Send, "m_iClip1", 1);
					SetEntProp(iWeapon, Prop_Send, "m_iPrimaryReserveAmmoCount", 0);
					SetEntProp(i, Prop_Send, "m_iHealth", 1);
					
					ClientCommand(i, "play %s", SOUND_SD_CHAMBER);
					
					if (bSpawn)
					{
						++iSpawns;
						
						if (iSpawns <= gI_Spawns)
						{
							fPos[0] = fLocation[iSpawns][0];
							fPos[1] = fLocation[iSpawns][1];
							fPos[2] = fLocation[iSpawns][2];
							TeleportEntity(i, fPos, NULL_VECTOR, NULL_VECTOR);
						}
					}
				}
			}
			gCV_Radar.SetInt(1);
		}
		case SPECIALDAY_HEADSHOT:
		{
			for (int i = 1; i <= MaxClients; ++i)
			{
				if (IsClientInGame(i) && GetClientTeam(i) > 1)
				{
					if (!IsPlayerAlive(i))
						CS_RespawnPlayer(i);
					
					GivePlayerItem(i, "weapon_knife");
					GivePlayerItem(i, "weapon_deagle");
					
					if (bSpawn)
					{
						++iSpawns;
						
						if (iSpawns <= gI_Spawns)
						{
							fPos[0] = fLocation[iSpawns][0];
							fPos[1] = fLocation[iSpawns][1];
							fPos[2] = fLocation[iSpawns][2];
							TeleportEntity(i, fPos, NULL_VECTOR, NULL_VECTOR);
						}
					}
				}
			}
			gCV_Radar.SetInt(1);
		}
		case SPECIALDAY_NOSCOPE:
		{
			for (int i = 1; i <= MaxClients; ++i)
			{
				if (IsClientInGame(i) && GetClientTeam(i) > 1)
				{
					if (!IsPlayerAlive(i))
						CS_RespawnPlayer(i);
					
					SDKHook(i, SDKHook_PreThink, OnPreThink);
					GivePlayerItem(i, "weapon_knife");
					GivePlayerItem(i, "weapon_awp");
					
					if (bSpawn)
					{
						++iSpawns;
						
						if (iSpawns <= gI_Spawns)
						{
							fPos[0] = fLocation[iSpawns][0];
							fPos[1] = fLocation[iSpawns][1];
							fPos[2] = fLocation[iSpawns][2];
							TeleportEntity(i, fPos, NULL_VECTOR, NULL_VECTOR);
						}
					}
				}
			}
			gCV_Radar.SetInt(1);
		}
		case SPECIALDAY_NADE:
		{
			gCV_Gravity.SetInt(400);
			Fog(true, 4.0, 0, 0, 0, 1200.0);
			
			for (int i = 1; i <= MaxClients; ++i)
			{
				if (IsClientInGame(i) && GetClientTeam(i) > 1)
				{
					if (!IsPlayerAlive(i))
						CS_RespawnPlayer(i);
					
					GivePlayerItem(i, "weapon_hegrenade"); 
					SetEntProp(i, Prop_Send, "m_ArmorValue", 0);
					ClientCommand(i, "play %s", SOUND_SD_NADEDAY);
					
					if (bSpawn)
					{
						++iSpawns;
						
						if (iSpawns <= gI_Spawns)
						{
							fPos[0] = fLocation[iSpawns][0];
							fPos[1] = fLocation[iSpawns][1];
							fPos[2] = fLocation[iSpawns][2];
							TeleportEntity(i, fPos, NULL_VECTOR, NULL_VECTOR);
						}
					}
				}
			}
			gCV_Radar.SetInt(1);
		}
		case SPECIALDAY_KNIFE:
		{
			for (int i = 1; i <= MaxClients; ++i)
			{
				if (IsClientInGame(i) && GetClientTeam(i) > 1)
				{
					if (!IsPlayerAlive(i))
						CS_RespawnPlayer(i);
					
					gI_Activity[i] = 3;
					GivePlayerItem(i, "weapon_knife");
					SetEntProp(i, Prop_Send, "m_iHealth", 35);
					gI_CheckHealth[i] = 35; 
					ClientCommand(i, "play %s", SOUND_SD_KNIFEDAY);
					
					if (bSpawn)
					{
						++iSpawns;
						
						if (iSpawns <= gI_Spawns)
						{
							fPos[0] = fLocation[iSpawns][0];
							fPos[1] = fLocation[iSpawns][1];
							fPos[2] = fLocation[iSpawns][2];
							TeleportEntity(i, fPos, NULL_VECTOR, NULL_VECTOR);
						}
					}
				}
			}
			gCV_Radar.SetInt(1);
		}
		case SPECIALDAY_KILLCONFIRM:
		{
			for (int i = 1; i <= MaxClients; ++i)
			{
				if (IsClientInGame(i) && GetClientTeam(i) > 1)
				{
					if (!IsPlayerAlive(i))
						CS_RespawnPlayer(i);
					
					gI_Activity[i] = 1;
					gB_Hook[i] = true;
					GivePlayerItem(i, "weapon_knife");
					GivePlayerItem(i, "weapon_ak47");
					GivePlayerItem(i, "weapon_deagle");
					SetEntProp(i, Prop_Send, "m_iHealth", 100);
					gI_CheckHealth[i] = 100; 
					//ClientCommand(i, "play %s", SOUND_SD_KNIFEDAY);
					PrintCenterText(i, "Pick up the tags to confirm the kills.");
					
					if (bSpawn)
					{
						++iSpawns;
						
						if (iSpawns <= gI_Spawns)
						{
							fPos[0] = fLocation[iSpawns][0];
							fPos[1] = fLocation[iSpawns][1];
							fPos[2] = fLocation[iSpawns][2];
							TeleportEntity(i, fPos, NULL_VECTOR, NULL_VECTOR);
						}
					}
				}
			}
			gCV_Radar.SetInt(1);
		}
		case SPECIALDAY_GANG:
		{		
			bool bFlip = view_as<bool>(GetRandomInt(0,1));
			gB_FreeForAll = true;
			
			for (int i = 1; i <= MaxClients; ++i)
			{
				if (IsClientInGame(i) && GetClientTeam(i) > 1)
				{
					if (!IsPlayerAlive(i))
						CS_RespawnPlayer(i);
						
					GivePlayerItem(i, "weapon_knife");
					GivePlayerItem(i, "weapon_tec9");
					GivePlayerItem(i, "weapon_mac10");
					SetEntityModel(i, "models/player/tm_pirate_variantc.mdl");
					SetEntPropString(i, Prop_Send, "m_szArmsModel", "models/weapons/t_arms_pirate.mdl");
					SetEntProp(i, Prop_Send, "m_ArmorValue", 0);
					SetEntProp(i, Prop_Send, "m_iHealth", 250);
					gI_CheckHealth[i] = 250;
					
					switch (bFlip)
					{
						case true: 
						{
							bFlip = false;
							SetGlow(i, 255, 0, 0, 255);
							FadePlayer(i, 300, 300, 0x0001, {255, 0, 0, 100});
							gI_ClientStatus[i] = COLOR_RED;
							PrintCenterText(i, "You're a <font color='#FF0000'>Blood</font> kill them <font color='#0013FE'>Crips</font>!");
							for (int b = 0; b < 3; ++b) PrintToChat(i, "%sYou're a \x02Blood\x01, Kill them \x0BCrips\x01!", JB_TAG);
						}
						case false: 
						{
							bFlip = true;
							SetGlow(i, 0, 0, 255, 255);
							FadePlayer(i, 300, 300, 0x0001, {0, 0, 255, 100});
							gI_ClientStatus[i] = COLOR_BLUE;
							PrintCenterText(i, "You're a <font color='#0013FE'>Crip</font> kill them <font color='#FF0000'>Bloods</font>!");
							for (int b = 0; b < 3; ++b) PrintToChat(i, "%sYou're a \x0BCrip\x01, Kill them \x02Bloods\x01!", JB_TAG);
						}
					}
					
					if (bSpawn)
					{
						++iSpawns;
						
						if (iSpawns <= gI_Spawns)
						{
							fPos[0] = fLocation[iSpawns][0];
							fPos[1] = fLocation[iSpawns][1];
							fPos[2] = fLocation[iSpawns][2];
							TeleportEntity(i, fPos, NULL_VECTOR, NULL_VECTOR);
						}
					}
					ClientCommand(i, "play %s", SOUND_SD_GANGWAR);
				}
			}
			CreateTimer(0.3, Timer_Gangs, INVALID_HANDLE, TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
			gCV_Radar.SetInt(1);
		}
		case SPECIALDAY_JEDI:
		{
			gCV_Gravity.SetInt(70);
			
			for (int i = 1; i <= MaxClients; ++i)
			{
				if (IsClientInGame(i) && GetClientTeam(i) > 1)
				{
					if (!IsPlayerAlive(i))
						CS_RespawnPlayer(i);
					
					PrintToChat(i, "%sKill everyone before they kill you!", JB_TAG);
					PrintCenterText(i, "Press E to push players down to their deaths");
					GivePlayerItem(i, "weapon_knife");
					
					if (bSpawn)
					{
						++iSpawns;
						
						if (iSpawns <= gI_Spawns)
						{
							fPos[0] = fLocation[iSpawns][0];
							fPos[1] = fLocation[iSpawns][1];
							fPos[2] = fLocation[iSpawns][2];
							TeleportEntity(i, fPos, NULL_VECTOR, NULL_VECTOR);
						}
					}
					ClientCommand(i, "play %s", SOUND_SD_JEDI);
				}	
			}	
			gCV_Radar.SetInt(1);
		}
		case SPECIALDAY_SHARK:
		{
			for (int i = 1; i <= MaxClients; ++i)
			{
				if (IsClientInGame(i) && GetClientTeam(i) > 1)
				{
					if (!IsPlayerAlive(i))
						CS_RespawnPlayer(i);
					
					switch (GetClientTeam(i))
					{
						case 2:
						{
							GivePlayerItem(i, "weapon_awp");
							GivePlayerItem(i, "weapon_knife");
						}
						case 3:
						{
							SDKHook(i, SDKHook_OnTakeDamagePost, OnTakeDamagePost);
							gI_CheckHealth[i] = 150;
							SetEntityHealth(i, 150);
							SetEntityMoveType(i, MOVETYPE_NOCLIP);
							GivePlayerItem(i, "weapon_knife");	
						}
					}
					
					if (bSpawn)
					{
						++iSpawns;
						
						if (iSpawns <= gI_Spawns)
						{
							fPos[0] = fLocation[iSpawns][0];
							fPos[1] = fLocation[iSpawns][1];
							fPos[2] = fLocation[iSpawns][2];
							TeleportEntity(i, fPos, NULL_VECTOR, NULL_VECTOR);
						}
					}
					ClientCommand(i, "play %s", SOUND_SD_SHARK);
				}
			}
			gCV_Radar.SetInt(3);
		}
		case SPECIALDAY_NIGHTCRAWLER:
		{
			Fog(true, 10.0);
			
			for (int i = 1; i <= MaxClients; ++i)
			{
				if (IsClientInGame(i) && GetClientTeam(i) > 1)
				{
					if (!IsPlayerAlive(i))
						CS_RespawnPlayer(i);

					switch (GetClientTeam(i))
					{
						case 2:
						{
							GivePlayerItem(i, "weapon_m4a1");
							GivePlayerItem(i, "weapon_deagle");
							GivePlayerItem(i, "weapon_knife");
							PrintToChat(i, "%sBecarefull the NightCrawlers are invisible!", JB_TAG);
						}
						case 3:
						{
							gB_PlayerSteps[i] = true;
							gI_Activity[i] = 3;
							gI_CheckHealth[i] = 150;
							SetEntityHealth(i, 150);
							SetEntPropFloat(i, Prop_Send, "m_flLaggedMovementValue", 1.4);
							SetEntityGravity(i, 0.7);
							GivePlayerItem(i, "weapon_knife");	
							SetGlow(i, 255, 255, 255, 170);
							PrintToChat(i, "%sPress \x04E\x01 to Climb walls!", JB_TAG);
							PrintToChat(i, "%sDouble tap \x04E\x01 to teleport!", JB_TAG);
							SDKHook(i, SDKHook_SetTransmit, OnSetTransmit);
							SDKHook(i, SDKHook_PreThink, OnPreThink);
						}
					}
					
					if (bSpawn)
					{
						++iSpawns;
						
						if (iSpawns <= gI_Spawns)
						{
							fPos[0] = fLocation[iSpawns][0];
							fPos[1] = fLocation[iSpawns][1];
							fPos[2] = fLocation[iSpawns][2];
							TeleportEntity(i, fPos, NULL_VECTOR, NULL_VECTOR);
						}
					}
					ClientCommand(i, "play %s", SOUND_SD_NIGHTCRAWLER);
				}
			}	
			gCV_Radar.SetInt(3);
		}
		case SPECIALDAY_COCKTAIL:
		{
			for (int i = 1; i <= MaxClients; ++i)
			{
				if (IsClientInGame(i) && GetClientTeam(i) > 1)
				{
					if (!IsPlayerAlive(i))
						CS_RespawnPlayer(i);
					
					SetEntityModel(i, "models/player/tm_anarchist_variantd.mdl");
					SetEntPropString(i, Prop_Send, "m_szArmsModel", "models/weapons/t_arms_anarchist.mdl");
					GivePlayerItem(i, "weapon_molotov");
					
					if (bSpawn)
					{
						++iSpawns;
						
						if (iSpawns <= gI_Spawns)
						{
							fPos[0] = fLocation[iSpawns][0];
							fPos[1] = fLocation[iSpawns][1];
							fPos[2] = fLocation[iSpawns][2];
							TeleportEntity(i, fPos, NULL_VECTOR, NULL_VECTOR);
						}
					}
				}
			}
			gCV_Radar.SetInt(1);
		}
		case SPECIALDAY_TRIGGER: 
		{
			for (int i = 1; i <= MaxClients; ++i)
			{
				if (IsClientInGame(i) && GetClientTeam(i) > 1)
				{
					if (!IsPlayerAlive(i))
						CS_RespawnPlayer(i);
					
					GivePlayerItem(i, "weapon_hkp2000");
					GivePlayerItem(i, "weapon_knife");
					
					if (bSpawn)
					{
						++iSpawns;
						
						if (iSpawns <= gI_Spawns)
						{
							fPos[0] = fLocation[iSpawns][0];
							fPos[1] = fLocation[iSpawns][1];
							fPos[2] = fLocation[iSpawns][2];
							TeleportEntity(i, fPos, NULL_VECTOR, NULL_VECTOR);
						}
					}
					ClientCommand(i, "play %s", SOUND_SD_TRIGGER);
				}
			}
			gCV_Radar.SetInt(1);
		}
		case SPECIALDAY_GUNGAME:
		{
			for (int i = 1; i <= MaxClients; ++i)
			{
				if (IsClientInGame(i) && GetClientTeam(i) > 1)
				{
					if (!IsPlayerAlive(i))
						CS_RespawnPlayer(i);
					
					gI_Activity[i] = 0;
					GivePlayerItem(i, "weapon_knife");
					GivePlayerItem(i, "weapon_glock");
					SetEntProp(i, Prop_Send, "m_iHealth", 100);
					gI_CheckHealth[i] = 100;
					
					if (bSpawn)
					{
						++iSpawns;
						
						if (iSpawns <= gI_Spawns)
						{
							fPos[0] = fLocation[iSpawns][0];
							fPos[1] = fLocation[iSpawns][1];
							fPos[2] = fLocation[iSpawns][2];
							TeleportEntity(i, fPos, NULL_VECTOR, NULL_VECTOR);
						}
					}
					ClientCommand(i, "play %s", SOUND_SD_GUNGAME);
				}
			}
			gCV_Radar.SetInt(1);
		}
	}
	
	++gI_Cells;
	Cells(true);
	CreateTimer(0.1, Timer_CheckHP, INVALID_HANDLE, TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
}

void TriggerLastRequest()
{
	RemoveAllWeapons(gI_Guard);
	RemoveAllWeapons(gI_Prisoner);
		
	SetEntityHealth(gI_Guard, 100);
	SetEntityHealth(gI_Prisoner, 100);
	
	SetEntPropFloat(gI_Guard, Prop_Data, "m_flLaggedMovementValue", 1.0);
	SetEntPropFloat(gI_Prisoner, Prop_Data, "m_flLaggedMovementValue", 1.0);
	
	SetEntityGravity(gI_Guard, 1.0);
	SetEntityGravity(gI_Prisoner, 1.0);
	
	SetGlow(gI_Guard, 255, 255, 255, 255);
	SetGlow(gI_Prisoner, 255, 255, 255, 255);
	
	if (!BaseComm_IsClientMuted(gI_Prisoner))
		SetClientListeningFlags(gI_Prisoner, VOICE_NORMAL);
	
	int iHealth;
	
	switch (gI_LRHealth[gI_Prisoner])
	{
		case 0: iHealth = 35;
		case 1: iHealth = 100;
		case 2: iHealth = 250;
		case 3: iHealth = 500;
		default: iHealth = 100;
	}
	
	SetEntityHealth(gI_Prisoner, iHealth);
	SetEntityHealth(gI_Guard, iHealth);
	
	GivePlayerItem(gI_Prisoner, "item_assaultsuit");
	GivePlayerItem(gI_Guard, "item_assaultsuit");
	
	switch (gH_LastRequest)
	{
		case LASTREQUEST_KNIFE:
		{
			GivePlayerItem(gI_Prisoner, "weapon_knife");
			GivePlayerItem(gI_Guard, "weapon_knife");
				
			PrintToChatAll("%s\x09%N \x01Chose to go against \x0B%N\x01 in a Knife Fight!", JB_TAG, gI_Prisoner, gI_Guard);
		}
		case LASTREQUEST_GUNTOSS:
		{
			GivePlayerItem(gI_Guard, "weapon_knife");
			GivePlayerItem(gI_Prisoner, "weapon_knife");
				
			int iWeapon = GivePlayerItem(gI_Guard, "weapon_deagle");
			SetEntProp(iWeapon, Prop_Send, "m_iClip1", 0);
			SetEntProp(iWeapon, Prop_Send, "m_iPrimaryReserveAmmoCount", 0);
				
			iWeapon = GivePlayerItem(gI_Prisoner, "weapon_deagle");
			SetEntProp(iWeapon, Prop_Send, "m_iClip1", 0);
			SetEntProp(iWeapon, Prop_Send, "m_iPrimaryReserveAmmoCount", 0);
				
			PrintToChatAll("%s\x09%N \x01Chose to go against \x0B%N\x01 in a Gun Toss!", JB_TAG, gI_Prisoner, gI_Guard);
			PrintToChat(gI_Prisoner, "%sChoose your rules on how to play \x04Gun Toss\x01!", JB_TAG);
		}
		case LASTREQUEST_NADE:
		{						
			GivePlayerItem(gI_Guard, "weapon_hegrenade");
			GivePlayerItem(gI_Prisoner, "weapon_hegrenade");
			
			PrintToChatAll("%s\x09%N \x01Chose to go against \x0B%N\x01 in a Nade War!", JB_TAG, gI_Prisoner, gI_Guard);
			PrintToChat(gI_Prisoner, "%sBlow up your opponent!", JB_TAG);
			PrintToChat(gI_Guard, "%sBlow up your opponent!", JB_TAG);
		}
		case LASTREQUEST_NOSCOPE:
		{					
			SDKHook(gI_Prisoner, SDKHook_PreThink, OnPreThink);
			SDKHook(gI_Guard, SDKHook_PreThink, OnPreThink);
			
			GivePlayerItem(gI_Prisoner, "weapon_knife");
			GivePlayerItem(gI_Guard, "weapon_knife");
				
			switch (gI_LastRequestWeapon)
			{
				case NOSCOPEWEAPON_AWP:
				{
					GivePlayerItem(gI_Prisoner, "weapon_awp");
					GivePlayerItem(gI_Guard, "weapon_awp");
				}
				case NOSCOPEWEAPON_SCOUT:
				{
					GivePlayerItem(gI_Prisoner, "weapon_ssg08");
					GivePlayerItem(gI_Guard, "weapon_ssg08");
				}
				case NOSCOPEWEAPON_SCAR:
				{
					GivePlayerItem(gI_Prisoner, "weapon_scar20");
					GivePlayerItem(gI_Guard, "weapon_scar20");
				}
				case NOSCOPEWEAPON_G3SG1:
				{
					GivePlayerItem(gI_Prisoner, "weapon_g3sg1");
					GivePlayerItem(gI_Guard, "weapon_g3sg1");
				}
			}
				
			PrintToChatAll("%s\x09%N \x01Chose to go against \x0B%N\x01 in a No Scope Battle!", JB_TAG, gI_Prisoner, gI_Guard);
		}
		case LASTREQUEST_SHOTGUN:
		{
			SetEntProp(gI_Guard, Prop_Send, "m_ArmorValue", 0);
			SetEntProp(gI_Prisoner, Prop_Send, "m_ArmorValue", 0);
			
			GivePlayerItem(gI_Prisoner, "weapon_nova");
			GivePlayerItem(gI_Guard, "weapon_nova");
				
			PrintToChatAll("%s\x09%N \x01Chose to go against \x0B%N\x01 in a Shotgun Battle!", JB_TAG, gI_Prisoner, gI_Guard);
		}
		case LASTREQUEST_SHOT4SHOT:
		{					
			GivePlayerItem(gI_Guard, "weapon_knife");
			GivePlayerItem(gI_Prisoner, "weapon_knife");
			
			switch (gI_LastRequestWeapon)
			{
				case SHOT4SHOTWEAPON_DEAGLE:
				{
					int iWeapon = GivePlayerItem(gI_Guard, "weapon_deagle");
					SetEntProp(iWeapon, Prop_Send, "m_iClip1", 0);
					SetEntProp(iWeapon, Prop_Send, "m_iPrimaryReserveAmmoCount", 0);
					
					iWeapon = GivePlayerItem(gI_Prisoner, "weapon_deagle");
					SetEntProp(iWeapon, Prop_Send, "m_iClip1", 1);
					SetEntProp(iWeapon, Prop_Send, "m_iPrimaryReserveAmmoCount", 0);
				}
				case SHOT4SHOTWEAPON_AK47:
				{
					int iWeapon = GivePlayerItem(gI_Guard, "weapon_ak47");
					SetEntProp(iWeapon, Prop_Send, "m_iClip1", 0);
					SetEntProp(iWeapon, Prop_Send, "m_iPrimaryReserveAmmoCount", 0);
					
					iWeapon = GivePlayerItem(gI_Prisoner, "weapon_ak47");
					SetEntProp(iWeapon, Prop_Send, "m_iClip1", 1);
					SetEntProp(iWeapon, Prop_Send, "m_iPrimaryReserveAmmoCount", 0);
				}
				case SHOT4SHOTWEAPON_M4A4:
				{
					int iWeapon = GivePlayerItem(gI_Guard, "weapon_m4a1");
					SetEntProp(iWeapon, Prop_Send, "m_iClip1", 0);
					SetEntProp(iWeapon, Prop_Send, "m_iPrimaryReserveAmmoCount", 0);
					
					iWeapon = GivePlayerItem(gI_Prisoner, "weapon_m4a1");
					SetEntProp(iWeapon, Prop_Send, "m_iClip1", 1);
					SetEntProp(iWeapon, Prop_Send, "m_iPrimaryReserveAmmoCount", 0);
				}
				case SHOT4SHOTWEAPON_SCOUT:
				{
					int iWeapon = GivePlayerItem(gI_Guard, "weapon_ssg08");
					SetEntProp(iWeapon, Prop_Send, "m_iClip1", 0);
					SetEntProp(iWeapon, Prop_Send, "m_iPrimaryReserveAmmoCount", 0);
					
					iWeapon = GivePlayerItem(gI_Prisoner, "weapon_ssg08");
					SetEntProp(iWeapon, Prop_Send, "m_iClip1", 1);
					SetEntProp(iWeapon, Prop_Send, "m_iPrimaryReserveAmmoCount", 0);
				}
				case SHOT4SHOTWEAPON_NEGEV:
				{
					int iWeapon = GivePlayerItem(gI_Guard, "weapon_negev");
					SetEntProp(iWeapon, Prop_Send, "m_iClip1", 0);
					SetEntProp(iWeapon, Prop_Send, "m_iPrimaryReserveAmmoCount", 0);
					
					iWeapon = GivePlayerItem(gI_Prisoner, "weapon_negev");
					SetEntProp(iWeapon, Prop_Send, "m_iClip1", 1);
					SetEntProp(iWeapon, Prop_Send, "m_iPrimaryReserveAmmoCount", 0);
				}
				case SHOT4SHOTWEAPON_MAG7:
				{
					int iWeapon = GivePlayerItem(gI_Guard, "weapon_mag7");
					SetEntProp(iWeapon, Prop_Send, "m_iClip1", 0);
					SetEntProp(iWeapon, Prop_Send, "m_iPrimaryReserveAmmoCount", 0);
					
					iWeapon = GivePlayerItem(gI_Prisoner, "weapon_mag7");
					SetEntProp(iWeapon, Prop_Send, "m_iClip1", 1);
					SetEntProp(iWeapon, Prop_Send, "m_iPrimaryReserveAmmoCount", 0);
				}
			}
			
			PrintToChatAll("%s\x09%N \x01Chose to go against \x0B%N \x01in a Shot 4 Shot!", JB_TAG, gI_Prisoner, gI_Guard);
		}
		case LASTREQUEST_RACE:
		{
			GivePlayerItem(gI_Guard, "weapon_knife");
			GivePlayerItem(gI_Prisoner, "weapon_knife");
			
			SetEntPropFloat(gI_Guard, Prop_Data, "m_flLaggedMovementValue", 1.2);
			SetEntPropFloat(gI_Prisoner, Prop_Data, "m_flLaggedMovementValue", 1.2);
			
			PrintToChatAll("%s\x09%N \x01Chose to go against \x0B%N\x01 in a Race!", JB_TAG, gI_Prisoner, gI_Guard);
			PrintToChat(gI_Prisoner, "%sPick a course or mini game to compete in!", JB_TAG);
		}
		case LASTREQUEST_HEADSHOT:
		{
			GivePlayerItem(gI_Guard, "weapon_knife");
			GivePlayerItem(gI_Prisoner, "weapon_knife");
			
			GivePlayerItem(gI_Guard, "weapon_deagle");
			GivePlayerItem(gI_Prisoner, "weapon_deagle");
			
			gCV_HeadshotOnly.SetInt(1);
			gCV_InfiniteAmmo.SetInt(2);
			
			PrintToChatAll("%s\x09%N \x01Chose to go against \x0B%N\x01 in Headshot Only!", JB_TAG, gI_Prisoner, gI_Guard);
		}
		case LASTREQUEST_KEYS:
		{
			GivePlayerItem(gI_Guard, "weapon_knife");
			GivePlayerItem(gI_Prisoner, "weapon_knife");
			
			PrintToChatAll("%s\x09%N \x01Chose to go against \x0B%N\x01 in a key combo!", JB_TAG, gI_Prisoner, gI_Guard);	
			
			int[] iKeys = new int[9];
			iKeys[0] = IN_FORWARD;
			iKeys[1] = IN_BACK;
			iKeys[2] = IN_MOVELEFT;
			iKeys[3] = IN_MOVERIGHT;
			iKeys[4] = IN_JUMP;
			iKeys[5] = IN_DUCK;
			iKeys[6] = IN_ATTACK;
			iKeys[7] = IN_ATTACK2;
			iKeys[8] = IN_USE;
			
			gS_TypingPhrase[0] = '\0';
			
			gI_Activity[gI_Guard] = 0;
			gI_Activity[gI_Prisoner] = 0;
			
			gI_ClientStatus[gI_Guard] = 0;
			gI_ClientStatus[gI_Prisoner] = 0;
			
			int iLastKey = -1;
			
			for (int i = 0; i < MAXKEYLIMIT; ++i) 
			{
				gI_MovementKeys[i] = iKeys[GetRandomInt(0, 8)];
				
				if (gI_MovementKeys[i] == iLastKey)
					gI_MovementKeys[i] = iKeys[GetRandomInt(0, 8)];
				
				switch (gI_MovementKeys[i])
				{
					case IN_FORWARD: 	Format(gS_TypingPhrase, sizeof(gS_TypingPhrase), "%s%sForward", gS_TypingPhrase, (i == 0)? "":"::");
					case IN_BACK: 		Format(gS_TypingPhrase, sizeof(gS_TypingPhrase), "%s%sBack", gS_TypingPhrase, (i == 0)? "":"::");
					case IN_MOVELEFT: 	Format(gS_TypingPhrase, sizeof(gS_TypingPhrase), "%s%sLeft", gS_TypingPhrase, (i == 0)? "":"::");
					case IN_MOVERIGHT: 	Format(gS_TypingPhrase, sizeof(gS_TypingPhrase), "%s%sRight", gS_TypingPhrase, (i == 0)? "":"::");
					case IN_JUMP: 		Format(gS_TypingPhrase, sizeof(gS_TypingPhrase), "%s%sJump", gS_TypingPhrase, (i == 0)? "":"::");
					case IN_DUCK: 		Format(gS_TypingPhrase, sizeof(gS_TypingPhrase), "%s%sDuck", gS_TypingPhrase, (i == 0)? "":"::");
					case IN_ATTACK:	 	Format(gS_TypingPhrase, sizeof(gS_TypingPhrase), "%s%sSlash", gS_TypingPhrase, (i == 0)? "":"::");
					case IN_ATTACK2:	Format(gS_TypingPhrase, sizeof(gS_TypingPhrase), "%s%sStab", gS_TypingPhrase, (i == 0)? "":"::");
					case IN_USE: 		Format(gS_TypingPhrase, sizeof(gS_TypingPhrase), "%s%sUse", gS_TypingPhrase, (i == 0)? "":"::");
				}
				
				iLastKey = gI_MovementKeys[i];
			}
			CreateTimer(0.4, Timer_TypingPhrase, INVALID_HANDLE, TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
		}
		case LASTREQUEST_TYPING:
		{
			GivePlayerItem(gI_Guard, "weapon_knife");
			GivePlayerItem(gI_Prisoner, "weapon_knife");
			
			PrintToChatAll("%s\x09%N \x01Chose to go against \x0B%N\x01 in a Typing contest!", JB_TAG, gI_Prisoner, gI_Guard);	
			
			ArrayList aArray = new ArrayList(1024);
			
			char[] sLine = new char[sizeof(gS_TypingPhrase)];
			
			File hFile = OpenFile("addons/sourcemod/configs/jailbreak/Typing-Phrases.txt", "r"); 
			
			if (hFile != null)
			{
				while (!hFile.EndOfFile() && hFile.ReadLine(sLine, sizeof(gS_TypingPhrase)))
					aArray.PushString(sLine);
				
				hFile.Close();
				
				int iLine = aArray.Length;
				
				if (iLine != 0)
				{
					aArray.GetString(GetRandomInt(0, iLine-1), gS_TypingPhrase, sizeof(gS_TypingPhrase));	
					gS_TypingPhrase[strlen(gS_TypingPhrase)-1] = '\0';
				}
				else strcopy(gS_TypingPhrase, sizeof(gS_TypingPhrase), "The FitnessGram Pacer Test is a multistage aerobic capacity test");
			}
			else strcopy(gS_TypingPhrase, sizeof(gS_TypingPhrase), "The FitnessGram Pacer Test is a multistage aerobic capacity test");
			CreateTimer(0.4, Timer_TypingPhrase, INVALID_HANDLE, TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
		}
	}	
}

void DayNames(char[] sNames)
{
	switch (gH_SpecialDay)
	{
		case SPECIALDAY_GANG: 			strcopy(sNames, 30, "Gang War");
		case SPECIALDAY_HEADSHOT: 		strcopy(sNames, 30, "Headshot");
		case SPECIALDAY_KNIFE: 			strcopy(sNames, 30, "Knife Battle");
		case SPECIALDAY_KILLCONFIRM: 	strcopy(sNames, 30, "Kill Confirmed");
		case SPECIALDAY_NADE: 			strcopy(sNames, 30, "Nade War");
		case SPECIALDAY_NOSCOPE:	 	strcopy(sNames, 30, "No Scope");
		case SPECIALDAY_ONEINACHAMBER: 	strcopy(sNames, 30, "One in the Chamber");
		case SPECIALDAY_SCOUTZKNIVEZ:	strcopy(sNames, 30, "Scoutzknivez");
		case SPECIALDAY_JEDI: 			strcopy(sNames, 30, "Jedi");
		case SPECIALDAY_SHARK: 			strcopy(sNames, 30, "Shark");
		case SPECIALDAY_NIGHTCRAWLER: 	strcopy(sNames, 30, "NightCrawler");
		case SPECIALDAY_COCKTAIL: 		strcopy(sNames, 30, "Cocktail Party");
		case SPECIALDAY_TRIGGER: 		strcopy(sNames, 30, "Trigger Discipline");
		case SPECIALDAY_GUNGAME: 		strcopy(sNames, 30, "Gungame");
	}
}

void LastrequestNames(char[] sNames)
{
	switch (gH_LastRequest)
	{
		case LASTREQUEST_KNIFE: 		strcopy(sNames, 30, "Knife");
		case LASTREQUEST_GUNTOSS:		strcopy(sNames, 30, "Gun Toss");
		case LASTREQUEST_NADE: 			strcopy(sNames, 30, "Nade War");
		case LASTREQUEST_NOSCOPE: 		strcopy(sNames, 30, "No Scope");
		case LASTREQUEST_SHOTGUN:		strcopy(sNames, 30, "Shotgun Battle");
		case LASTREQUEST_SHOT4SHOT:		strcopy(sNames, 30, "Shot 4 Shot");
		case LASTREQUEST_RACE: 			strcopy(sNames, 30, "Race");
		case LASTREQUEST_HEADSHOT: 		strcopy(sNames, 30, "Headshot Only");
		case LASTREQUEST_KEYS:			strcopy(sNames, 30, "Key Combo");
		case LASTREQUEST_TYPING: 		strcopy(sNames, 30, "Typing Contest");
	}
}

void ResetMarker()
{			
	for (int i = 0; i < 3; ++i)
		gF_MakerPos[i] = 0.0;
}

void SetGlow(int client, int r, int g, int b, int o)
{
	SetEntityRenderMode(client, RENDER_TRANSCOLOR);
	SetEntityRenderColor(client, r, g, b, o);
}

void RemoveAllWeapons(int client)
{
	int offset = FindDataMapInfo(client, "m_hMyWeapons") - 4;
	
	for (int i = 0; i < 48; i++) 
	{
		offset += 4;

		int iWeapon = GetEntDataEnt2(client, offset);
		
		if (IsValidEdict(iWeapon)) 
		{
			int iAmmo = FindDataMapInfo(client, "m_iAmmo") + (GetEntProp(iWeapon, Prop_Data, "m_iPrimaryAmmoType") * 4);
			SetEntData(client, iAmmo, 0, 4, true);
	
			iAmmo = FindDataMapInfo(client, "m_iAmmo") + (GetEntProp(iWeapon, Prop_Data, "m_iSecondaryAmmoType") * 4);
			SetEntData(client, iAmmo, 0, 4, true);
	
			if (RemovePlayerItem(client, iWeapon)) 
				AcceptEntityInput(iWeapon, "Kill");
		}
	}
}

void FadePlayer(int client, int iDuration, int iHold, any aFlags, int iColor[4])
{
    Handle hMessage = StartMessageOne("Fade", client, USERMSG_RELIABLE); 
    PbSetInt(hMessage, "duration", iDuration); 
    PbSetInt(hMessage, "hold_time", iHold); 
    PbSetInt(hMessage, "flags", aFlags); 
    PbSetColor(hMessage, "clr", iColor); 
    EndMessage(); 
}

int GetPlayerAliveCount(int iTeam)
{
	int iAmmount = 0;
	for (int i = 1; i <= MaxClients; i++) if (IsClientInGame(i) && IsPlayerAlive(i) && GetClientTeam(i) == iTeam) iAmmount++;
	return iAmmount;
}

void Fog(bool bTurnOn, float fDensity = 4.0, int iR = 0, int iG = 0, int iB = 0, float fEnd = 900.0)
{
	int iFog = FindEntityByClassname(-1, "env_fog_controller");
	
	if (!IsValidEntity(iFog)) 
	{
		iFog = CreateEntityByName("env_fog_controller");
		DispatchSpawn(iFog);	
	}
	
	char[] sFormat = new char[20];
	FormatEx(sFormat, 20, "%i %i %i", iR, iG, iB);

	DispatchKeyValue(iFog, "fogblend", "0");
	DispatchKeyValue(iFog, "fogcolor", sFormat);
	DispatchKeyValue(iFog, "fogcolor2", sFormat);
	DispatchKeyValueFloat(iFog, "fogstart", 0.0);
	DispatchKeyValueFloat(iFog, "fogend", fEnd);
	DispatchKeyValueFloat(iFog, "fogmaxdensity", fDensity);
	
	if (bTurnOn)
		AcceptEntityInput(iFog, "TurnOn");
	else
		AcceptEntityInput(iFog, "TurnOff");
}

void VelocityByAim(int client, float fVelocity[3], float fPower)
{
	GetEntPropVector(client, Prop_Data, "m_vecVelocity", fVelocity);
	float ang[3];
	GetClientEyeAngles(client, ang);
		
	GetAngleVectors(ang, fVelocity, NULL_VECTOR, NULL_VECTOR);
	NormalizeVector(fVelocity, fVelocity);
	ScaleVector(fVelocity, fPower);
}

bool IsInterference(int client, float kickDistance)
{
	float clientOrigin[3], clientEyeAngles[3];
	GetClientAbsOrigin(client, clientOrigin);
	GetClientEyeAngles(client, clientEyeAngles);
		
	float cos = Cosine(DegToRad(clientEyeAngles[1]));
	float sin = Sine(DegToRad(clientEyeAngles[1]));
	
	float leftBottomOrigin[3];
	leftBottomOrigin[0] = clientOrigin[0] - sin;
	leftBottomOrigin[1] = clientOrigin[1] - cos;
	leftBottomOrigin[2] = clientOrigin[2] + 25.0;
	
	float startOriginAddtitions[3];
	startOriginAddtitions[0] = sin * 15.0;
	startOriginAddtitions[1] = cos * 15.0;
	startOriginAddtitions[2] = 15.0;
	
	float testOriginAdditions[3];
	testOriginAdditions[0] = cos * (kickDistance + 10.0);
	testOriginAdditions[1] = sin * (kickDistance + 10.0);
	testOriginAdditions[2] = 0.0;	
	
	float startOrigin[3], testOrigin[3];
	
	for (int x = 0; x < 3; ++x)
	{
		for (int y = 0; y < 3; ++y)
		{
			for (int z = 0; z < 3; ++z)
			{
				startOrigin[0] = leftBottomOrigin[0] + x * startOriginAddtitions[0];
				startOrigin[1] = leftBottomOrigin[1] + y * startOriginAddtitions[1];
				startOrigin[2] = leftBottomOrigin[2] + z * startOriginAddtitions[2];
				
				for (int j = 0; j < 3; ++j)
					testOrigin[j] = startOrigin[j] + testOriginAdditions[j];
				
				Handle hTrace = TR_TraceRayFilterEx(startOrigin, testOrigin, MASK_SOLID, RayType_EndPoint, WallTraceFilter);
				
				if (TR_DidHit(hTrace))
				{
					delete hTrace;
					return true;
				}
				delete hTrace;
			}
		}
	}
	return false;
}

int GetClientAim(int client, float pos[3]) 
{	
	float vOrigin[3]; GetClientEyePosition(client,vOrigin); 
	float vAngles[3]; GetClientEyeAngles(client, vAngles);
	
	Handle trace = TR_TraceRayFilterEx(vOrigin, vAngles, MASK_PLAYERSOLID, RayType_Infinite, WallTraceFilter);
	
	int loopLimit = 100;
	
	float vBackwards[3];
	
	GetAngleVectors(vAngles, vBackwards, NULL_VECTOR, NULL_VECTOR);
	NormalizeVector(vBackwards, vBackwards);
	ScaleVector(vBackwards, 10.0); 
	
	if (TR_DidHit(trace))
	{
		TR_GetEndPosition(pos, trace);
		
		while (IsPlayerStuck(pos, client))
        {
            SubtractVectors(pos, vBackwards, pos); 
			
            if (GetVectorDistance(pos, vOrigin) < 10 || loopLimit-- < 1)
            {
                pos = vOrigin;   
                break;
            }
        }
	}
	
	int entity = TR_GetEntityIndex(trace);
	delete trace;
	return entity;
}

bool IsPlayerStuck(float pos[3], int client)
{
    float mins[3]; GetClientMins(client, mins);
    float maxs[3]; GetClientMaxs(client, maxs);
    
    for (int i = 0; i < 3; ++i)
    {
        mins[i] -= 3;
        maxs[i] += 3;
    }

    TR_TraceHullFilter(pos, pos, mins, maxs, MASK_SOLID, WallTraceFilter);
    return TR_DidHit();
}  

void CheckRatio()
{		
	if (GetTeamClientCount(3) * 2 >= GetTeamClientCount(2))
		gB_Ratio = true;
	else
		gB_Ratio = false;
}

void SetupGlowSkin(int client, int iRed = 255, int iGreen = 0, int iBlue = 255)
{
	char[] sModel = new char[PLATFORM_MAX_PATH];
	GetClientModel(client, sModel, PLATFORM_MAX_PATH);

	int iSkin = CPS_SetSkin(client, sModel, CPS_RENDER);
	
	if (iSkin == -1)
		return;

	if (SDKHookEx(iSkin, SDKHook_SetTransmit, OnSetTransmit_GlowSkin))
	{
		int iOffset;
	
		if ((iOffset = GetEntSendPropOffs(iSkin, "m_clrGlow")) == -1)
			return;
	
		SetEntProp(iSkin, Prop_Send, "m_bShouldGlow", true, true);
		SetEntProp(iSkin, Prop_Send, "m_nGlowStyle", 0);
		SetEntPropFloat(iSkin, Prop_Send, "m_flGlowMaxDist", 10000000.0);
	
		if (gH_LastRequest == LASTREQUEST_INVALID)
		{
			switch (gI_ClientStatus[client])
			{
				case COLOR_BLUE: iRed = 0;
				case COLOR_RED: iBlue = 0;
			}
		}
		
		SetEntData(iSkin, iOffset, iRed, _, true);
		SetEntData(iSkin, iOffset + 1, iGreen, _, true);
		SetEntData(iSkin, iOffset + 2, iBlue, _, true);
		SetEntData(iSkin, iOffset + 3, 255, _, true);
	}
}

void UnhookGlow(int client)
{
	int iSkin = CPS_GetSkin(client);
	
	if (iSkin != INVALID_ENT_REFERENCE)
	{
		SetEntProp(iSkin, Prop_Send, "m_bShouldGlow", false, true);
		SDKUnhook(iSkin, SDKHook_SetTransmit, OnSetTransmit_GlowSkin);
	}
}

void Cells(bool bOpen)
{
	if (SJD_IsMapConfigured(gS_Map))
	{
		if (bOpen)
			SJD_OpenDoors();
		else
			SJD_CloseDoors();
	}
}

int GetRandomClient(int iTeam)
{
	int iClients[MAXPLAYERS + 1] = {-1, ...};
	int iClientCount = 0;
	
	for (int i = 1; i <= MaxClients; i++)
	{
		if (IsClientInGame(i) && IsPlayerAlive(i) && GetClientTeam(i) == iTeam && !gB_Freeday[i])
		{
			iClients[iClientCount] = i;
			iClientCount++;
		}
	}	
	
	if (iClientCount != 0)
		return iClients[GetRandomInt(0, iClientCount-1)];
	else
		return -1;
}

void CreateBall()
{
	gI_Ball = CreateEntityByName("hegrenade_projectile");
	DispatchKeyValue(gI_Ball, "targetname", "simpleball");
	
	if (DispatchSpawn(gI_Ball))
	{
		SetEntityModel(gI_Ball, "models/knastjunkies/soccerball.mdl");
	
		SetEntProp(gI_Ball, Prop_Send, "m_usSolidFlags", 0x0004 | 0x0008);
		SetEntPropFloat(gI_Ball, Prop_Data, "m_flModelScale", 0.60);
		
		SetEntPropVector(gI_Ball, Prop_Send, "m_vecMins", view_as<float>({-BALL_RADIUS, -BALL_RADIUS, -BALL_RADIUS}));
		SetEntPropVector(gI_Ball, Prop_Send, "m_vecMaxs", view_as<float>({BALL_RADIUS, BALL_RADIUS, BALL_RADIUS}));
		SetEntityGravity(gI_Ball, 0.70);
		
		SDKHook(gI_Ball, SDKHook_TraceAttack, OnBallHit);
		SDKHook(gI_Ball, SDKHook_StartTouch, OnBallTouch);
	}
}

void DestroyBall()
{
	if (IsValidEntity(gI_Ball))
		AcceptEntityInput(gI_Ball, "Kill");
}

void RespawnBall()
{
	DestroyBall();
	CreateBall();
	
	gI_BallHolder = 0;
	TeleportEntity(gI_Ball, gF_BallSpawnOrigin, NULL_VECTOR, view_as<float>({0.0, 0.0, 100.0}));
}

void KickBall(int client, float power)
{
	if (IsInterferenceForKick(client, BALL_KICK_DISTANCE))
		return;		
	
	float clientEyeAngles[3], angleVectors[3];
	GetClientEyeAngles(client, clientEyeAngles);
	GetAngleVectors(clientEyeAngles, angleVectors, NULL_VECTOR, NULL_VECTOR);
	
	float ballVelocity[3];
	ballVelocity[0] = angleVectors[0] * power;
	ballVelocity[1] = angleVectors[1] * power;
	ballVelocity[2] = angleVectors[2] * power;
	
	float frontOrigin[3];
	
	if (GetClientFrontBallOrigin(client, BALL_KICK_DISTANCE, BALL_HOLD_HEIGHT + BALL_KICK_HEIGHT_ADDITION, frontOrigin))
	{
		float kickOrigin[3];
		kickOrigin[0] = frontOrigin[0];
		kickOrigin[1] = frontOrigin[1];
		kickOrigin[2] = frontOrigin[2] + BALL_KICK_HEIGHT_ADDITION;
	
		DestroyBall();
		CreateBall();
	
		TeleportEntity(gI_Ball, kickOrigin, NULL_VECTOR, ballVelocity);
	
		gI_BallHolder = 0;
	}
	else RespawnBall();
}

bool IsInterferenceForKick(int client, float kickDistance)
{
	float clientOrigin[3], clientEyeAngles[3];
	GetClientAbsOrigin(client, clientOrigin);
	GetClientEyeAngles(client, clientEyeAngles);
		
	float cos = Cosine(DegToRad(clientEyeAngles[1]));
	float sin = Sine(DegToRad(clientEyeAngles[1]));
	
	float leftBottomOrigin[3];
	leftBottomOrigin[0] = clientOrigin[0] - sin * BALL_RADIUS;
	leftBottomOrigin[1] = clientOrigin[1] - cos * BALL_RADIUS;
	leftBottomOrigin[2] = clientOrigin[2] + BALL_HOLD_HEIGHT + BALL_KICK_HEIGHT_ADDITION - BALL_RADIUS;
	
	float startOriginAddtitions[3];
	startOriginAddtitions[0] = sin * BALL_RADIUS;
	startOriginAddtitions[1] = cos * BALL_RADIUS;
	startOriginAddtitions[2] = BALL_RADIUS;
	
	float testOriginAdditions[3];
	testOriginAdditions[0] = cos * (kickDistance + BALL_RADIUS);
	testOriginAdditions[1] = sin * (kickDistance + BALL_RADIUS);
	testOriginAdditions[2] = 0.0;	
	
	float startOrigin[3], testOrigin[3];
	
	for (int x = 0; x < 3; ++x)
	{
		for (int y = 0; y < 3; ++y)
		{
			for (int z = 0; z < 3; ++z)
			{
				startOrigin[0] = leftBottomOrigin[0] + x * startOriginAddtitions[0];
				startOrigin[1] = leftBottomOrigin[1] + y * startOriginAddtitions[1];
				startOrigin[2] = leftBottomOrigin[2] + z * startOriginAddtitions[2];
				
				for (int j = 0; j < 3; ++j)
					testOrigin[j] = startOrigin[j] + testOriginAdditions[j];
				
				Handle hTrace = TR_TraceRayFilterEx(startOrigin, testOrigin, MASK_SOLID, RayType_EndPoint, BallTraceFilter);
				
				if (TR_DidHit(hTrace))
				{
					delete hTrace;
					return true;
				}
				delete hTrace;
			}
		}
	}
	return false;
}

bool GetClientFrontBallOrigin(int client, float distance, int height, float destOrigin[3])
{
	if (0 < client <= MaxClients)
	{
		float clientOrigin[3], clientEyeAngles[3];
		GetClientAbsOrigin(client, clientOrigin);
		GetClientEyeAngles(client, clientEyeAngles);
		
		float cos = Cosine(DegToRad(clientEyeAngles[1]));
		float sin = Sine(DegToRad(clientEyeAngles[1]));
		
		destOrigin[0] = clientOrigin[0] + cos * distance;
		destOrigin[1] = clientOrigin[1] + sin * distance;
		destOrigin[2] = clientOrigin[2] + height;
		return true;
	}
	return false;
}

void GetPlayerEyeViewPoint(int iClient, float fPosition[3])
{
	float fAngles[3], fOrigin[3];
	GetClientEyeAngles(iClient, fAngles);
	GetClientEyePosition(iClient, fOrigin);

	Handle hTrace = TR_TraceRayFilterEx(fOrigin, fAngles, MASK_SHOT, RayType_Infinite, WallTraceFilter);
	if (TR_DidHit(hTrace)) TR_GetEndPosition(fPosition, hTrace);
	delete hTrace;
}

bool IsInsideZone(float point[8][MAXZONELIMIT][3], float playerPos[3])
{    
    int iStatus = 0;
    
    for (int i = 0; i < 3; i++)
    {
		if (point[0][0][i] >= playerPos[i] == point[7][0][i] >= playerPos[i])
			continue;
		else
			++iStatus;
    }

    if (iStatus == 3)
    	return true;
    
    iStatus = 0;
    
    if (gI_Zones >= 1)
    {
	    for (int i = 0; i < 3; i++)
	    {
			if (point[0][1][i] >= playerPos[i] == point[7][1][i] >= playerPos[i])
				continue;
			else
				++iStatus;
	    }	
	    
	    if (iStatus == 3)
	    	return true;
    }
    return false;
}  

int GetPlayerAimTarget(int client, float fPosition[3] = {0.0, 0.0, 0.0})
{
	float fAngles[3], fOrigin[3];
	GetClientEyeAngles(client, fAngles);
	GetClientEyePosition(client, fOrigin);

	Handle hTrace = TR_TraceRayFilterEx(fOrigin, fAngles, MASK_SHOT, RayType_Infinite, PlayersOnly, client);
	
	TR_GetEndPosition(fPosition, hTrace);
	
	int iEnt = -1;
	
	if (TR_DidHit(hTrace)) iEnt = TR_GetEntityIndex(hTrace);
	delete hTrace;
	return iEnt;
}

public bool Trace_HitVictimOnly(int entity, int contentsMask, int victim) { 
	return entity == victim; 
}  

public bool PlayersOnly(int entity, int mask, any client) {
	return IsValidClient(entity) && entity != client;
}

public bool WallTraceFilter(int entity, int mask) {
	return !IsValidClient(entity);
}

public bool BallTraceFilter(int entity, int mask) {
	return !IsValidClient(entity) && entity != gI_Ball;
}