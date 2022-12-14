/*******************************************************************************

  SM File/Folder Downloader and Precacher

  Version: 1.4
  Author: SWAT_88

  1.0 	First version, should work on basically any mod
 
  1.1	Added new features:	
		Added security checks.
		Added map specific downloads.
		Added simple downloads.
  1.2	Added Folder Download Feature.
  1.3	Version for testing.
  1.4	Fixed some bugs.
		Closed all open Handles.
		Added more security checks.
   
  Description:
  
	This Plugin downloads and precaches the Files in downloads.ini.
	There are several categories for Download and Precache in downloads.ini.
	The downloads_simple.ini contains simple downloads (no precache), like the original.
	Folder Download usage:
	Write your folder name in the downloads.ini or downloads_simple.ini.
	Example:
	Correct: sound/misc
	Incorrect: sound/misc/
	
  Commands:
  
	None.

  Cvars:

	sm_downloader_enabled 	"1"		- 0: disables the plugin - 1: enables the plugin
	
	sm_downloader_normal	"1"		- 0: dont use downloads.ini - 1: Use downloads.ini
	
	sm_downloader_simple	"1"		- 0: dont use downloads_simple.ini	- 1: Use downloads_simple.ini

  Setup (SourceMod):

	Install the smx file to addons\sourcemod\plugins.
	Install the downloads.ini to addons\sourcemod\configs.
	Install the downloads_simple.ini to addons\sourcemod\configs.
	(Re)Load Plugin or change Map.
	
  TO DO:
  
	Nothing make a request.
	
  Copyright:
  
	Everybody can edit this plugin and copy this plugin.
	
  Thanks to:
	pRED*
	sfPlayer

  Tester:
	J@y-R
	FunTF2Server
	
  HAVE FUN!!!

*******************************************************************************/

#include <sourcemod>
#include <sdktools>
#include <emitsoundany>

#define SM_DOWNLOADER_VERSION		"1.4"

char map[256];
char mediatype[256];

bool downloadfiles = true;

public Plugin myinfo = 
{
	name = "SM File/Folder Downloader and Precacher",
	author = "SWAT_88",
	description = "Downloads and Precaches Files",
	version = SM_DOWNLOADER_VERSION,
	url = "http://www.sourcemod.net"
}

public void OnMapStart()
{
	ReadDownloads();
}

void ReadFileFolder(char[] path)
{
	Handle dirh = INVALID_HANDLE;
	
	char buffer[256];
	char tmp_path[256];
	
	FileType type = FileType_Unknown;
	
	int len = strlen(path);
	
	if (path[len-1] == '\n')
		path[--len] = '\0';

	TrimString(path);
	
	if (DirExists(path)){
		dirh = OpenDirectory(path);
		while(ReadDirEntry(dirh,buffer,sizeof(buffer),type)){
			len = strlen(buffer);
			if (buffer[len-1] == '\n')
				buffer[--len] = '\0';

			TrimString(buffer);

			if (!StrEqual(buffer,"",false) && !StrEqual(buffer,".",false) && !StrEqual(buffer,"..",false)){
				strcopy(tmp_path,255,path);
				StrCat(tmp_path,255,"/");
				StrCat(tmp_path,255,buffer);
				
				if(type == FileType_File)
					ReadItem(tmp_path);
				else
					ReadFileFolder(tmp_path);
			}
		}
	}
	else ReadItem(path);
	
	if (dirh != INVALID_HANDLE)
		CloseHandle(dirh);
}

void ReadDownloads()
{
	char[] file = new char[PLATFORM_MAX_PATH];
	BuildPath(Path_SM, file, 255, "configs/downloads.ini");
	Handle fileh = OpenFile(file, "r");
	char[] buffer = new char[PLATFORM_MAX_PATH];
	int len;
	
	GetCurrentMap(map,255);
	
	if (fileh == null)
		return;
	
	while (ReadFileLine(fileh, buffer, PLATFORM_MAX_PATH))
	{	
		len = strlen(buffer);
		if (buffer[len-1] == '\n')
			buffer[--len] = '\0';

		TrimString(buffer);

		if (!StrEqual(buffer,"",false))
			ReadFileFolder(buffer);
		
		if (IsEndOfFile(fileh))
			break;
	}
	
	if (fileh != null)
		delete fileh;
}

void ReadItem(char[] buffer)
{
	int len = strlen(buffer);
	
	if (buffer[len-1] == '\n')
		buffer[--len] = '\0';
	
	TrimString(buffer);
	
	if(StrContains(buffer,"//Files (Download Only No Precache)",true) >= 0){
		strcopy(mediatype,255,"File");
		downloadfiles=true;
	}
	else if(StrContains(buffer,"//Decal Files (Download and Precache)",true) >= 0){
		strcopy(mediatype,255,"Decal");
		downloadfiles=true;
	}
	else if(StrContains(buffer,"//Sound Files (Download and Precache)",true) >= 0){
		strcopy(mediatype,255,"Sound");
		downloadfiles=true;
	}
	else if(StrContains(buffer,"//Model Files (Download and Precache)",true) >= 0){
		strcopy(mediatype,255,"Model");
		downloadfiles=true;
	}
	else if(len >= 2 && buffer[0] == '/' && buffer[1] == '/'){
		//Comment
		if(StrContains(buffer,"//") >= 0){
			ReplaceString(buffer,255,"//","");
		}
		if(StrEqual(buffer,map,true)){
			downloadfiles=true;
		}
		else if(StrEqual(buffer,"Any",false)){
			downloadfiles=true;
		}
		else{
			downloadfiles=false;
		}
	}
	else if (!StrEqual(buffer,"",false) && FileExists(buffer))
	{
		if(downloadfiles){
			if(StrContains(mediatype,"Decal",true) >= 0){
				PrecacheDecal(buffer,true);
			}
			else if(StrContains(mediatype,"Sound",true) >= 0)
			{
				ReplaceString(buffer, 255, "sound/", "");
				PrecacheSoundAny(buffer, true);
				Format(buffer, 255, "sound/%s", buffer);
			}
			else if(StrContains(mediatype,"Model",true) >= 0){
				PrecacheModel(buffer,true);
			}
			AddFileToDownloadsTable(buffer);
		}
	}
}