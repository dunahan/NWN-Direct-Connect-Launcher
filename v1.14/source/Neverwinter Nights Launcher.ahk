;==================================================
;  Neverwinter Nights Direct Connect Launcher
;  Author: Joel McCracken (Alundaio)
;==================================================
; v 1.12 (.1-.3)
; Updated by dunahan@schwerterkueste.de for AHK_L
; Added functionality for NWN Extender
; Added a few comments
; Bugfixes
; Enabled direct connection with NWNcX
; v 1.13 (.1)
; Added Languages
; modified for more language support and optimized script for IniRead()
; v 1.14
; Update enabled, optimizing scriptset
;===============================
CURRENT_VERSION := "1.14"
UPDATE_URL := "https://neverwintervault.org/sites/neverwintervault.org/files/project/27639/files/update.txt"
;===============================

#NoTrayIcon
#NoEnv                  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force
#Include FileHelper.ahk

;Get values from DCLConfig.ini
GoSub ReadFromConfig

;Set up Gui, 1:
Gui, 1: Color, %BACKGROUND_COLOR_LAUNCHER%
hGui := WinExist()
Gui, 1: Font, c%Font_COLOR% %Font_STYLE%, %Font_TYPE%
Gui, 1: +E0x80000000

BANNER_DIR := A_WorkingDir . "\DCLdata\Banners\"
FILE := A_WorkingDir . "\Neverwinter Nights Launcher.exe"

;Loop through Server Options to list up the servers in the Main GUI
Loop, 5
{
	Server := ServerName%A_Index%

	If (Server != "" && ServerIP%A_Index% !="")
	{
		Banner := ServerBanner%A_Index%
		Length := StrLen(Server)
		Length := Length*5 + 40
		
		IfExist,% BANNER_DIR . ServerBanner%A_Index%
		Gui, 1: Add, Picture, Center x82 hwnd%Server%_hwnd gServerLaunchURL%A_Index%, %A_WorkingDir%\DCLdata\Banners\%Banner%

		ServerName = ServerName%A_Index%
		Gui, 1: Add, Button, x152 w%Length% gServer%A_Index% vServerButton%A_Index%, %Server%

		Gui, 1: Font, c0xFFFFFF
		Gui, 1: Add, CheckBox, x+20 vEnableDM%A_Index%, %LogInAsDMText%
		Gui, 1: Font, c%Font_COLOR% %Font_STYLE%, %Font_TYPE%
	}
}

;Show up all the Buttons at the Main GUI
AddPictureButton("IconNormalLaunch", A_WorkingDir . "\DCLdata\Icons\Icon_3", "x15 y+100 gIconNormalLaunchOnClick","xp yp")
AddPictureButton("IconToolsetLaunch", A_WorkingDir . "\DCLdata\Icons\Icon_2", "x+25 gIconToolsetLaunchOnClick","xp yp")
AddPictureButton("IconCepLaunch", A_WorkingDir . "\DCLdata\Icons\Icon_4", "x+155 gIconCepLaunchOnClick","xp yp")
AddPictureButton("IconOptionsLaunch", A_WorkingDir . "\DCLdata\Icons\Icon_1", "x+25 gIconOptionsLaunchOnClick","xp yp")

Gui, 1: Show
Gui, 1: Show, autosize center, Neverwinter Nights DC Launcher ;No translations needed!
WinSet, exstyle, -0x80000, Neverwinter Nights DC Launcher     ;No translations needed!
Return
;==================================END INIT

;========================================--------------------------------==========
;                                                Function Includes
;========================================--------------------------------==========
#include NwnDCLFunctions.ahk
;========================================--------------------------------==========
;                                                  Subroutines
;========================================--------------------------------==========
GoSub ReadFromConfig

IconNormalLaunchOnClick: 
  GuiControl, Hide, IconNormalLaunchState0 
  Sleep 250 
  GuiControl, Show, IconNormalLaunchState0
  GoSub, NormalLaunch
Return
 
IconToolsetLaunchOnClick: 
  GuiControl, Hide, IconToolsetLaunchState0 
  Sleep 250 
  GuiControl, Show, IconToolsetLaunchState0
  GoSub, ToolsetLaunch
Return 

IconCepLaunchOnClick: 
  GuiControl, Hide, IconCepLaunchState0 
  Sleep 250 
  GuiControl, Show, IconCepLaunchState0
	GoSub, CEPUpdater
Return

IconOptionsLaunchOnClick: 
  GuiControl, Hide, IconOptionsLaunchState0 
  Sleep 250 
  GuiControl, Show, IconOptionsLaunchState0
	GoSub, ServerOptions
Return 

ServerLaunchURL1:
  Run, %ServerURL1%
Return

ServerLaunchURL2:
  Run, %ServerURL2%
Return

ServerLaunchURL3:
  Run, %ServerURL3%
Return

ServerLaunchURL4:
  Run, %ServerURL4%
Return

ServerLaunchURL5:
  Run, %ServerURL5%
Return

ServerOptions:
{
  GoSub ReadFromConfig
  
  Gui, +disabled
  Gui, 2: +owner1
  Gui, 2: +LastFound
  Menu, MySubmenu, Add, %CheckUpdateText%, CheckUpdate
  Menu, MySubmenu, Add, %ShowAboutText%, ShowAbout
  Gui, 2: Menu,MySubmenu
  hGui := WinExist()

  Gui, 2: Color, %BACKGROUND_COLOR_OPTIONS%
  Gui, 2: Font, c%Font_COLOR% %Font_STYLE%, %Font_TYPE%
  Gui, 2: Add, Button, x272 y272 w100 h30 g2GuiSubmit, Ok
  Gui, 2: Add, Button, x422 y272 w100 h30 g2GuiClose, Cancel
  Gui, 2: Add, Tab, x2 y2 w760 h310, %ServerSettingsTabText%|%BannerOptionsTabText%|%ConfigurationTabText%|%GameOptionsTabText%

  Gui, 2: Tab, %ServerSettingsTabText%
  Gui, 2: Add, GroupBox, x12  y42 w140 h220, %ServerNameText%
  Gui, 2: Add, GroupBox, x162 y42 w140 h220, %ServerIPaddressText%
  Gui, 2: Add, GroupBox, x312 y42 w140 h220, %ServerPasswordText%
  Gui, 2: Add, GroupBox, x462 y42 w140 h220, %DMPasswordText%
  Gui, 2: Add, GroupBox, x612 y42 w140 h220, %BannerText%

  ;Add Sever controls
  Loop, 5
  {
    ServerVar := ServerName%A_Index%
    Gui, 2: Add, Edit, x22 yp+30 w120 h20 vServerName%A_Index%, %ServerVar%

    ServerVar := ServerIP%A_Index%
    Gui, 2: Add, Edit, x+30 yp w120 h20 vServerIP%A_Index%, %ServerVar%

    ServerVar := ServerPassword%A_Index%
    Gui, 2: Add, Edit, x+30 yp w120 h20 vServerPassword%A_Index%, %ServerVar%

    ServerVar := ServerDMPassword%A_Index%
    Gui, 2: Add, Edit, x+30 yp w120 h20 vServerDMPassword%A_Index%, %ServerVar%

    ServerVar := ServerBanner%A_Index%
    Gui, 2: Add, Edit, x+30 yp w120 h20 vServerBanner%A_Index%, %ServerVar%
  }
  
  Gui, 2: Tab, %BannerOptionsTabText%
  Gui, 2: Add, GroupBox, x202 y32 w380 h230, %BannerOnClickURLText%
  Gui, 2: Add, Text, x222 y62, %Server1BannerLinkText%:
  Gui, 2: Add, Text, x222 y102, %Server2BannerLinkText%:
  Gui, 2: Add, Text, x222 y142, %Server3BannerLinkText%:
  Gui, 2: Add, Text, x222 y182, %Server4BannerLinkText%:
  Gui, 2: Add, Text, x222 y222, %Server5BannerLinkText%:
  Gui, 2: Add, Edit, x282 y62 w270 h20 vServerURL1, %ServerURL1%
  Gui, 2: Add, Edit, x282 y102 w270 h20 vServerURL2, %ServerURL2%
  Gui, 2: Add, Edit, x282 y142 w270 h20 vServerURL3, %ServerURL3%
  Gui, 2: Add, Edit, x282 y182 w270 h20 vServerURL4, %ServerURL4%
  Gui, 2: Add, Edit, x282 y222 w270 h20 vServerURL5, %ServerURL5%
  Gui, 2: Add, Button, x635 y52 w80 h20 gOpenBannersFolder, %BannersButtonText%
  
  Gui, 2: Tab, %ConfigurationTabText%
  Gui, 2: Add, GroupBox, x12 y32 w220 h245, %OptionsText%
    If (%EnableLogging% == 0)
  {
    Gui, 2: Add, CheckBox, x22 y52 w130 h30 vEnableLogging, %EnableLogRenamingLblText%
  }
  Else
  {
    Gui, 2: Add, CheckBox, x22 y52 w130 h30 vEnableLogging checked, %EnableLogRenamingLblText%
  }
  
  If (%PersistantLauncher% == 0)
  {
    Gui, 2: Add, CheckBox, x22 y82 w130 h30 vPersistantLauncher, %PersistantLauncherLblText%
  }
  Else
  {
    Gui, 2: Add, CheckBox, x22 y82 w130 h30 vPersistantLauncher checked, %PersistantLauncherLblText%
  }
  
  If (%NWNCxLauncher% == 0)
  {
    Gui, 2: Add, CheckBox, x22 y112 w130 h30 vNWNCxLauncher, %NWNCXLauncherCBText%
  }
  Else
  {
    Gui, 2: Add, CheckBox, x22 y112 w130 h30 vNWNCxLauncher checked, %NWNCXLauncherCBText%
  }
  
  Gui, 2: Add, Text, x22 y145, %NWNxCFileNameText%:
  Gui, 2: Add, Edit, x92 y142 w130 h20 vNWNCxFile, %NWNCxFile% ;if needed, user can specify a other file-name

  If (%NWNTxLauncher% == 0)
  {
    Gui, 2: Add, CheckBox, x22 y172 w200 h30 vNWNTxLauncher, %NWNTXLauncherCBText%
  }
  Else
  {
    Gui, 2: Add, CheckBox, x22 y172 w200 h30 vNWNTxLauncher checked, %NWNTXLauncherCBText%
  }
  
  Gui, 2: Add, Text, x22 y205, %NWNxTFileNameText%:
  Gui, 2: Add, Edit, x92 y202 w130 h20 vNWNTxFile, %NWNTxFile% ;if needed, user can specify a other file-name
  
  ;; Languages
  LangPos := GetTokenPosition(DCLanguagesOptions, DCLanguagesChoosen) ; Get position of choosen language
  Gui, 2: Add, Text, x22 y232, %DCLanguagesText%:
  Gui, 2: Add, DDL, vChangeLangVar gChangeLang Choose%LangPos%, %DCLanguagesOptions% ; Display choosen lang in DropDownList
  
  Gui, 2: Add, Button, x162 y60 w60 h20 gOpenLogFolder, %LogsButtonText%

  Gui, 2: Add, GroupBox, x250 y32 w280 h50, %GameDirectoryGBText%
  Gui, 2: Add, Edit, x262 y52 w200 h20 vNWN_DIR, %NWN_DIR%
  Gui, 2: Add, Button, x465 y52 w60 h20 gBrowseGameDirectory, %BrowseButtonText%

  Gui, 2: Add, GroupBox, x250 y92 w280 h80, %CurrentOverrideDirectoryGBText%
  Gui, 2: Add, Edit, x262 y112 w200 h20 vOVR_DIR, %OVR_DIR%
  Gui, 2: Add, Button, x465 y112 w60 h20 gBrowseOverride, %BrowseButtonText%
  Gui, 2: Add, Button, x350 y142 w100 h20 gSwapOverrides, %SwapOverrideButtonText%

  Gui, 2: Add, GroupBox, x250 y180 w280 h80, %SwapSialogTlkFileGBText%
  Gui, 2: Add, Edit, x262 y200 w200 h20 vTLK_DIR, %TLK_DIR%
  Gui, 2: Add, Button, x465 y200 w60 h20 gBrowseTlk, %BrowseButtonText%
  Gui, 2: Add, Button, x350 y232 w100 h20 gSwapTlk, %SwapDialogFileButtonText%

  Gui, 2: Add, GroupBox, x550 y32 w150 h50, %GuiOptionsGBText%
  Gui, 2: Add, Button, x590 y52 w75 h20 gSelectFont, %GuiFontButtonText%
  Gui, 2: Add, GroupBox, x550 y75 w150 h70, %GuiBackgroundColorGBText%
  Gui, 2: Add, Button, x590 y95 w75 h20 gSelectOptionsColor, %GuiOptionsButtonText%
  Gui, 2: Add, Button, x590 y115 w75 h20 gSelectLauncherColor, %GuiLauncherButtonText%

  Gui, 2: Show, xCenter yCenter h318 w769, %GuiWindowNameText% ;Server Options ;is it possible to translate???

  Gui, 2: Tab, %GameOptionsTabText%

  ;=========Chat Colors
  Read_Nwnplayer(1)
  Gui, 2: Add, GroupBox, x12 y32 w235 h240, %ChatColorsGBText%

  Guipos_y = 50
  Gui, 2: Add, Button, x20 y%Guipos_y% w70 h20 gOnChatColor, %ChatColorsTalkButtonText%
  Gui, 2: Add, Button, x195 y%Guipos_y% w40 h20 gUndoTalk, %ChatColorsUndoButtonText%
  RGB := Convert_RGB_to_Hex(TalkColor)
  Gui, 2: Font,c%RGB%
  Gui, 2: Add, Edit, c%RGB% x105 y%Guipos_y% w80 center hwndTalk_color_hwnd vTalk_color, %ChatColorsExampleText%
  Gui, 2: Font,c%Font_COLOR%

  Guipos_y := Guipos_y + 25
  Gui, 2: Add, Button, x20 y%Guipos_y% w70 h20 gOnChatColor, %ChatColorsShoutButtonText%
  Gui, 2: Add, Button, x195 y%Guipos_y% w40 h20 gUndoShout, %ChatColorsUndoButtonText%
  RGB := Convert_RGB_to_Hex(ShoutColor)
  Gui, Color, , 000000
  Gui, 2: Font, c%RGB%
  Gui, 2: Add, Edit, x105 y%Guipos_y% w80 center hwndShout_color_hwnd vShout_color, %ChatColorsExampleText%
  Gui, 2: Font, c%Font_COLOR%

  Guipos_y := Guipos_y + 25
  Gui, 2: Add, Button, x20 y%Guipos_y% w70 h20 gOnChatColor, %ChatColorsWhisperButtonText%
  Gui, 2: Add, Button, x195 y%Guipos_y% w40 h20 gUndoWhisper, %ChatColorsUndoButtonText%
  RGB := Convert_RGB_to_Hex(WhisperColor)
  Gui, 2: Font, c%RGB%
  Gui, 2: Add, Edit, x105 y%Guipos_y% w80 center hwndWhisper_color_hwnd vWhisper_color, %ChatColorsExampleText%
  Gui, 2: Font, c%Font_COLOR%

  Guipos_y := Guipos_y + 25
  Gui, 2: Add, Button, x20 y%Guipos_y% w70 h20 gOnChatColor, %ChatColorsTellButtonText%
  Gui, 2: Add, Button, x195 y%Guipos_y% w40 h20 gUndoTell, %ChatColorsUndoButtonText%
  RGB := Convert_RGB_to_Hex(TellColor)
  Gui, 2: Font, c%RGB%
  Gui, 2: Add, Edit, x105  y%Guipos_y% center hwndTell_color_hwnd w80 vTell_color, %ChatColorsExampleText%
  Gui, 2: Font, c%Font_COLOR%

  Guipos_y := Guipos_y + 25
  Gui, 2: Add, Button, x20  y%Guipos_y% w70 h20 gOnChatColor, %ChatColorsServerButtonText%
  Gui, 2: Add, Button, x195  y%Guipos_y% w40 h20 gUndoServer, %ChatColorsUndoButtonText%
  RGB := Convert_RGB_to_Hex(ServerColor)
  Gui, 2: Font, c%RGB%
  Gui, 2: Add, Edit, x105  y%Guipos_y% w80 center hwndServer_color_hwnd vServer_color, %ChatColorsExampleText%
  Gui, 2: Font, c%Font_COLOR%

  Guipos_y := Guipos_y + 25
  Gui, 2: Add, Button, x20  y%Guipos_y% w70 h20 gOnChatColor, %ChatColorsPartyButtonText%
  Gui, 2: Add, Button, x195  y%Guipos_y% w40 h20 gUndoParty, %ChatColorsUndoButtonText%
  RGB := Convert_RGB_to_Hex(PartyColor)
  Gui, 2: Font, c%RGB%
  Gui, 2: Add, Edit, x105  y%Guipos_y% w80 center hwndParty_color_hwnd vParty_color, %ChatColorsExampleText%
  Gui, 2: Font, c%Font_COLOR%

  Guipos_y := Guipos_y + 25
  Gui, 2: Add, Button, x20  y%Guipos_y% w70 h20 gOnChatColor, %ChatColorsDMButtonText%
  Gui, 2: Add, Button, x195  y%Guipos_y% w40 h20 gUndoDM, %ChatColorsUndoButtonText%
  RGB := Convert_RGB_to_Hex(DMColor)
  Gui, 2: Font, c%RGB%
  Gui, 2: Add, Edit, x105  y%Guipos_y% center hwndDM_color_hwnd vDM_color w80, %ChatColorsExampleText%
  Gui, 2: Font, c%Font_COLOR%

  Guipos_y := Guipos_y + 35
  Gui, 2: Add, Button, x95  y%Guipos_y% w70 h20 gChatColorReset, %ChatColorsDefaultsButtonText%

  ;=======Trap Colors
  Read_Nwnplayer(2)
  Gui, 2: Add, GroupBox, x250 y32 w210 h80, %TrapColorsGBText%

  Guipos_y := 50
  Gui, 2: Add, Button, x265 y%Guipos_y% w70 h20 gOnTrapColor, %TrapColorsFriendButtonText%
  RGB := Convert_RGB_to_Hex(FriendlyColor)
  Gui, 2: Font, c%RGB%
  Gui, 2: Add, Edit,c%RGB% x365 y%Guipos_y% center hwndFriendly_color_hwnd w70 vFriendly_color, %TrapColorsFriendButtonText%
  Gui, 2: Font, c%Font_COLOR%
  
  Guipos_y := Guipos_y + 25
  Gui, 2: Add, Button, x265 y%Guipos_y% w70 h20 gOnTrapColor, %TrapColorsHostileButtonText%
  RGB := Convert_RGB_to_Hex(HostileColor)
  Gui, 2: Font, c%RGB%
  Gui, 2: Add, Edit, c%RGB% x365 y%Guipos_y% center hwndHostile_color_hwnd w70 vHostile_color, %TrapColorsHostileButtonText%
  Gui, 2: Font, c%Font_COLOR%

  Winset, Redraw
  EmptyMem()
  Return
}

ChangeLang:
  Gui, Submit, NoHide ; Set the defined language as seeable
  IniWrite, %ChangeLangVar%, language.ini, CHOOSEN, DCLanguagesChoosen ; Save Language in Ini-file
return

ShowAbout:
  Gui, 2: +disabled
  Gui, 3: +owner1
  Gui, 3: +LastFound
  hGui3 := winexist()
  Gui, 3: Add, Button, x122 y222 w100 h30 g3GuiClose , Ok
  Gui, 3: Add, Text, x12 y12, Neverwinter Nights DC Launcher v%CURRENT_VERSION% `n`nOriginal Author: Alundaio (with all his work!)`n`nUpdated Content: Dunahan`n`nWhatsNew:`n- Switching between languages`n- Another Bugfixes`n`nThank you for using!
  Gui, 3: Add, Link, , <a href="https://neverwintervault.org/project/nwn1/other/tool/nwn-1-direct-connect-launcher">Please vote here for this version</a> 
  Gui, 3: Add, Link, , <a href="https://neverwintervault.org/project/nwn1/other/tool/nwn-1-direct-connect-launcher-alundaio-v-111-now-sources">And don't forget to vote here for Alundaio's version</a>
  Gui, 3: Show, x373 y196 h272 w339, About
Return

LaunchVote:
  Run https://neverwintervault.org/project/nwn1/other/tool/nwn-1-direct-connect-launcher
Return

CheckUpdate:
	UrlDownloadToFile, %UPDATE_URL%, %A_WorkingDir%\update.ini
  ; FileCopy, %UPDATE_URL%, %A_WorkingDir%\update.ini, 1  ; For debugging on a local machine
  
	IfExist, update.ini
	{
		IniRead, UPDATE_VERSION, update.ini, Main, Version, 1
    
		If (UPDATE_VERSION > CURRENT_VERSION)
		{
			MsgBox, 4, , %MsgBoxUpdateAvailable%
			IfMsgBox Yes
			{
				IniRead, INSTALL_URL, update.ini, Main, UpdateInstaller, 1
				UrlDownloadToFile, %INSTALL_URL%, %A_WorkingDir%\tempinstaller.zip
        ; FileCopy, %INSTALL_URL%, %A_WorkingDir%\tempinstaller.zip, 1  ; For debugging on a local machine
        
				sZip := A_WorkingDir . "\tempinstaller.zip"
				sUnz := A_WorkingDir . "\update"
        
				Unz(sZip, sUnz) ; unzips downloaded zip to a empty update folder

				If ErrorLevel   ; i.e. it's not blank or zero.
				{
				  MsgBox, %MsgBoxUpdateFailed%
				}
        
        MsgBox, %MsgBoxUpdateDownloaded%
			}
		}
		Else
		{
			MsgBox, %MsgBoxUpdateNoAvailable%
		}
	}
	Else
	{
		MsgBox, %MsgBoxUpdateFailed%
	}

  IfExist, tempinstaller.zip
    FileDelete, %A_WorkingDir%\tempinstaller.zip ; deletes the temporary downloaded zipped content

  IfExist, update.ini
    FileDelete, %A_WorkingDir%\update.ini
Return

;On-Click ServerName buttons
Server1:
  DirectConnect(1)
Return

Server2:
  DirectConnect(2)
Return

Server3:
  DirectConnect(3)
Return

Server4:
  DirectConnect(4)
Return

Server5:
  DirectConnect(5)
Return

ChatColorReset:
  ;Grab default Chat Colors from dclConfig.ini
	Read_Nwnplayer(0)
  
  ;Set all the preview colors
	RGB := Convert_RGB_to_Hex(TalkColor)
	RGB := Convert_RGB_to_Hex(ShoutColor)
	RGB := Convert_RGB_to_Hex(WhisperColor)
	RGB := Convert_RGB_to_Hex(TellColor)
	RGB := Convert_RGB_to_Hex(ServerColor)
	RGB := Convert_RGB_to_Hex(PartyColor)
	RGB := Convert_RGB_to_Hex(DMColor)
  
  Winset,Redraw	
  
  ;Write the r,g,b values to the nwnplayer.ini
	IniWrite, %TalkColor%, %NWN_DIR%\nwnplayer.ini, Chat Colors, TalkColor
	IniWrite, %ShoutColor%, %NWN_DIR%\nwnplayer.ini, Chat Colors, ShoutColor
	IniWrite, %WhisperColor%, %NWN_DIR%\nwnplayer.ini, Chat Colors, WhisperColor
	IniWrite, %TellColor%, %NWN_DIR%\nwnplayer.ini, Chat Colors, TellColor
	IniWrite, %ServerColor%, %NWN_DIR%\nwnplayer.ini, Chat Colors, ServerColor
	IniWrite, %PartyColor%, %NWN_DIR%\nwnplayer.ini, Chat Colors, PartyColor
	IniWrite, %DMColor%, %NWN_DIR%\nwnplayer.ini, Chat Colors, DMColor
Return

;Undo Chatcolors
UndoTalk:
	IniRead, TalkColor, DCLConfig.ini, Chat Colors, TalkColor
	RGB := Convert_RGB_to_Hex(TalkColor)
	RGB := Convert_RGB_from_Hex( "0x" . TalkColor)
	IniWrite, %RGB%, %NWN_DIR%\nwnplayer.ini, Chat Colors, TalkColor
	Winset, Redraw
Return

UndoShout:
	IniRead, ShoutColor, DCLConfig.ini, Chat Colors, ShoutColor
	RGB := Convert_RGB_to_Hex(ShoutColor)
	RGB := Convert_RGB_from_Hex( "0x" . ShoutColor)
	IniWrite, %RGB%, %NWN_DIR%\nwnplayer.ini, Chat Colors, ShoutColor
	Winset, Redraw
Return

UndoWhisper:
	IniRead, WhisperColor, DCLConfig.ini, Chat Colors, WhisperColor
	RGB := Convert_RGB_to_Hex(WhisperColor)
	RGB := Convert_RGB_from_Hex( "0x" . WhisperColor)
	IniWrite, %RGB%, %NWN_DIR%\nwnplayer.ini, Chat Colors, WhisperColor
	Winset, Redraw
Return

UndoTell:
	IniRead, TellColor, DCLConfig.ini, Chat Colors, TellColor
	RGB := Convert_RGB_to_Hex(TellColor)
	RGB := Convert_RGB_from_Hex( "0x" . TellColor)
	IniWrite, %RGB%, %NWN_DIR%\nwnplayer.ini, Chat Colors, TellColor
	Winset, Redraw
Return

UndoServer:
	IniRead, ServerColor, DCLConfig.ini, Chat Colors, ServerColor
	RGB := Convert_RGB_to_Hex(ServerColor)
	RGB := Convert_RGB_from_Hex( "0x" . ServerColor)
	IniWrite, %RGB%, %NWN_DIR%\nwnplayer.ini, Chat Colors, ServerColor
	Winset, Redraw
Return

UndoParty:
	IniRead, PartyColor, DCLConfig.ini, Chat Colors, PartyColor
	RGB := Convert_RGB_to_Hex(PartyColor)
	RGB := Convert_RGB_from_Hex( "0x" . PartyColor)
	IniWrite, %RGB%, %NWN_DIR%\nwnplayer.ini, Chat Colors, PartyColor
	Winset, Redraw
Return

UndoDM:
	IniRead, DMColor, DCLConfig.ini, Chat Colors, DMColor
	RGB := Convert_RGB_to_Hex(DMColor)
	RGB := Convert_RGB_from_Hex( "0x" . DMColor)
	IniWrite, %RGB%, %NWN_DIR%\nwnplayer.ini, Chat Colors, DMColor
	Winset, Redraw
Return

OnTrapColor:
  ;Read from the nwnplayer.ini to grab trap colors
	Read_Nwnplayer(2)	
		
  If A_GuiControl = Friendly
  {
    RGB := Convert_RGB_to_Hex(FriendlyColor)
    If Dlg_Color( color:="0x" . RGB, hGui )
    {
      RGB := Convert_RGB_from_Hex( "0x" . Color)
      IniWrite, %FriendlyColor%, DCLconfig.ini, Trap Colors, FriendlyColor
      IniWrite, %RGB%, %NWN_DIR%\nwnplayer.ini, Trap Colors, FriendlyColor
    }				
  }
  Else If A_GuiControl = Hostile
  {
    RGB := Convert_RGB_to_Hex(HostileColor)
    If Dlg_Color( color:="0x" . RGB, hGui )
    {
      RGB := Convert_RGB_from_Hex( "0x" . Color)
      IniWrite, %HostileColor%, DCLconfig.ini, Trap Colors, HostileColor
      IniWrite, %RGB%, %NWN_DIR%\nwnplayer.ini, Trap Colors, HostileColor
    }					
  }
  Winset, Redraw
Return

OnChatColor:
  ;Read from the nwnplayer.ini to grab Chat Colors
  Read_Nwnplayer(1)	

  If A_GuiControl = Talk
  {
    RGB := Convert_RGB_to_Hex(TalkColor)    ;Convert r,g,b to hex
    If Dlg_Color( color:="0x" . RGB, hGui ) ;Call Color Picker dialog passing the hexcolor and window
    {
      RGB := Convert_RGB_from_Hex( "0x" . Color) ;Convert new color hex back to r,g,b to write in nwnplayer.ini
      IniWrite, %TalkColor%, DCLconfig.ini, Chat Colors, TalkColor
      IniWrite, %RGB%, %NWN_DIR%\nwnplayer.ini, Chat Colors, TalkColor
    }
  }
  Else If A_GuiControl = Shout
  {
    RGB := Convert_RGB_to_Hex(ShoutColor)	
    If Dlg_Color( color:="0x" . RGB, hGui )
    {
      RGB := Convert_RGB_from_Hex( "0x" . Color)
      IniWrite, %ShoutColor%, DCLconfig.ini, Chat Colors, ShoutColor
      IniWrite, %RGB%, %NWN_DIR%\nwnplayer.ini,C hat Colors, ShoutColor
    }				
  }
  Else If A_GuiControl = Whisper
  {
    RGB := Convert_RGB_to_Hex(WhisperColor)
    If Dlg_Color( color:="0x" . RGB, hGui )
    {
      RGB := Convert_RGB_from_Hex( "0x" . Color)
      IniWrite, %WhisperColor%, DCLconfig.ini, Chat Colors, WhisperColor
      IniWrite, %RGB%, %NWN_DIR%\nwnplayer.ini, Chat Colors, WhisperColor
    }				
  }
  Else If A_GuiControl = Tell
  {
    RGB := Convert_RGB_to_Hex(TellColor)
    If Dlg_Color( color:="0x" . RGB, hGui )
    {
      RGB := Convert_RGB_from_Hex( "0x" . Color)
      IniWrite, %TellColor%, DCLconfig.ini, Chat Colors, TellColor
      IniWrite, %RGB%, %NWN_DIR%\nwnplayer.ini, Chat Colors, TellColor
    }				
  }
  Else If A_GuiControl = Server
  {
    RGB := Convert_RGB_to_Hex(ServerColor)
    If Dlg_Color( color:="0x" . RGB, hGui )
    {
      RGB := Convert_RGB_from_Hex( "0x" . Color)
      IniWrite, %ServerColor%, DCLconfig.ini, Chat Colors, ServerColor
      IniWrite, %RGB%, %NWN_DIR%\nwnplayer.ini, Chat Colors, ServerColor
    }				
  }
  Else If A_GuiControl = Party
  {
    RGB := Convert_RGB_to_Hex(PartyColor)
    If Dlg_Color( color:="0x" . RGB, hGui )
    {
      RGB := Convert_RGB_from_Hex( "0x" . Color)
      IniWrite, %PartyColor%, DCLconfig.ini, Chat Colors, PartyColor
      IniWrite, %RGB%, %NWN_DIR%\nwnplayer.ini, Chat Colors, PartyColor
    }				
  }
  Else If A_GuiControl = DM
  {
    RGB := Convert_RGB_to_Hex(DMColor)
    If Dlg_Color( color:="0x" . RGB, hGui )
    {
      RGB := Convert_RGB_from_Hex( "0x" . Color)
      IniWrite, %DMColor%, DCLconfig.ini, Chat Colors, DMColor
      IniWrite, %RGB%, %NWN_DIR%\nwnplayer.ini, Chat Colors, DMColor
    }				
  }
  
  Winset, Redraw			
Return

SelectOptionsColor:
  IniRead, BACKGROUND_COLOR_OPTIONS, DCLconfig.ini, Gui Options, Background_Color_Options, EEAA99
  If Dlg_Color(color := "0x" . OPTIONS_BKG_COLOR, hGui)
  {
    IniWrite, %Color%, DCLconfig.ini, Gui Options, Background_Color_Options	
  }
Return

SelectLauncherColor:
  IniRead, BACKGROUND_COLOR_LAUNCHER, DCLconfig.ini, Gui Options, Background_Color_Launcher, 000000
  If Dlg_Color(color := "0x" . LAUNCHER_BKG_COLOR, hGui)
  {
    IniWrite, %Color%, DCLconfig.ini, Gui Options, Background_Color_Launcher			
  }
Return

SelectFont:
  IniRead, Font_STYLE, DCLconfig.ini, Gui Options, Font_Style, 9
  IniRead, Font_TYPE, DCLconfig.ini, Gui Options, Font_Type, MS Sans SerIf
  IniRead, Font_COLOR, DCLconfig.ini, Gui Options, Font_Color, 000000
  If Dlg_Font( Font:=Font_TYPE, style:=Font_STYLE, color:= "0x" . Font_COLOR, true, hGui)
  {
    IniWrite, %style%, DCLconfig.ini, Gui Options, Font_Style
    IniWrite, %Font%, DCLconfig.ini, Gui Options, Font_Type
    IniWrite, %Color%, DCLconfig.ini, Gui Options, Font_Color
  }
Return

BrowseOverride:
  FileSelectFolder, OutputVar, %NWN_DIR%, 3
  If OutputVar =
    MsgBox, %MsgBoxBrowseOverride%
  Else
  {
    GuiControl, , OVR_DIR, %OutputVar%
    OVR_DIR = %OutputVar%
  }
Return

BrowseTlk:
  FileSelectFile, SelectedFile, 3, %NWN_DIR%, Open a file, Dialog (*.tlk)
  If SelectedFile =
  MsgBox, %MsgBoxBrowseFile%
  Else
  {
    GuiControl, , TLK_DIR, %SelectedFile%
    TLK_DIR = %SelectedFile%
  }
Return

BrowseGameDirectory:
  FileSelectFolder, OutputVar, , 3
  If OutputVar !=
  {
    GuiControl, , NWN_DIR, %OutputVar%
    NWN_DIR = %OutputVar%
  }
Return

NormalLaunch:
    If (EnableLogging == 1)
    {
        RenameLogFile()
    }

    If (NWNCxLauncher == 1)
    {
      MsgBox, %MsgBoxStartNWNcX%
      Run, %NWNCxFile%, %NWN_DIR%, , NewPID
    }
    Else
        Run, nwmain.exe, %NWN_DIR%, ,NewPID

    ;EmptyMem(NewPID)
  
    If (PersistantLauncher == 0)
    {
        ExitApp
    }
  
    EmptyMem()
Return

ToolsetLaunch:
    If (NWNTxLauncher == 1)
    {
      MsgBox, %MsgBoxStartNWNtX%
      Run, %NWNTxFile%, %NWN_DIR%, , NewPID
    }
    Else
        Run, nwtoolset.exe, %NWN_DIR%,,NewPID

    If (PersistantLauncher == 0)
    {
        ExitApp
    }
  
  EmptyMem()
Return

CEPUpdater:
  Run, https://neverwintervault.org/cep
  EmptyMem()
Return

ReadFromConfig:
  ReadLanguage()
	If FileExist("DCLconfig.ini")
	{
		ReadDCLConfig()
	}
	Else
	{
		BACKGROUND_COLOR_LAUNCHER = 000000  ;set default bkg color If ini doesn't exist
		CreateDCLConfig()
	}
Return

SwapOverrides:
	Gui, 2: submit, nohide
	
	IfExist,%OVR_DIR%
	{
		IniWrite, %OVR_DIR%, %NWN_DIR%\nwn.ini, Alias, OVERRIDE
		If ErrorLevel
			MsgBox, %MsgBoxSwapOverrideError%
		Else
			MsgBox, %MsgBoxSwapSuccess%
	}
	Else
	{
		MsgBox, %MsgBoxSwapOverrideOther%
	}
Return

SwapTlk:
	TLK_DEFAULT = %NWN_DIR%\dialog.tlk
	Gui, 2: submit, nohide
	IniRead, TlkSwapFirstTime, DCLconfig.ini, Server Options, TlkSwapFirstTime, 1
  
	If (TlkSwapFirstTime == 1)
	{
		IfExist, %TLK_DEFAULT%
		{
			FileMove, %TLK_DEFAULT%, %NWN_DIR%\dialog_backup.tlk
			If ErrorLevel
				MsgBox, %MsgBoxSwapTlkBackUpFail%
			Else
				MsgBox, %MsgBoxSwapTlkBackUpSuccess%
			
			;Swap new folder
			FileMove, %TLK_DIR%, %TLK_DEFAULT%
			If ErrorLevel
				MsgBox, %TLK_DIR%%MsgBoxRenameTlkFailA%%TLK_DEFAULT%%MsgBoxRenameTlkFailB%. ;is it possible to translate???
			Else
			{
				MsgBox, %MsgBoxSwapSuccess%			
				TLK_DIR_LAST = %TLK_DIR%
				IniWrite, 0, DCLconfig.ini, Server Options, TlkSwapFirstTime
			}
		}
		Else
		{
			MsgBox, %MsgBoxRenameTlkOther%
		}
	}
	Else
	{
		IfExist,%TLK_DIR_LAST%
		{
			MsgBox, %MsgBoxSwapTlkFileExists%
		}
		Else
		{
			FileMove, %TLK_DEFAULT%, %TLK_DIR_LAST%
			If ErrorLevel
				MsgBox, %MsgBoxSwapTlkBackUpExists%
			
			;Swap new folder
			FileMove, %TLK_DIR%, %TLK_DEFAULT%
			If ErrorLevel
				MsgBox, MsgBoxSwapTlkNewError
			Else
			{
				MsgBox, %MsgBoxSwapSuccess%
				TLK_DIR_LAST = %TLK_DIR%
			}
		}	
	}
Return

OpenLogFolder:
  Run, explore %NWN_DIR%\logs
Return

OpenBannersFolder:
  Run, explore %A_WorkingDir%\DCLdata\Banners
Return

2GuiSubmit:
	Gui, 2: submit, nohide
	;-----write to DCLConfig.ini
	;Server Options
	IniWrite, %NWN_DIR%, DCLconfig.ini, Server Options, GameDirectory
	IniWrite, %OVR_DIR%, DCLconfig.ini, Server Options, CurrentOverrideDirectory
	IniWrite, %TLK_DIR%, DCLconfig.ini, Server Options, CurrentTLK
	IniWrite, %TLK_DIR_LAST%, DCLconfig.ini, Server Options, LastTLK
	IniWrite, %EnableLogging%, DCLconfig.ini, Server Options, EnableLogging
	IniWrite, %PersistantLauncher%, DCLconfig.ini, Server Options, PersistantLauncher

	;ExtenderVersions
	IniWrite, %NWNCxLauncher%, DCLconfig.ini, NWNxLauncher, NWNCxLauncher
	IniWrite, %NWNTxLauncher%, DCLconfig.ini, NWNxLauncher, NWNTxLauncher
  IniWrite, %NWNCxFile%, DCLconfig.ini, NWNxLauncher, NWNCxFile
  IniWrite, %NWNTxFile%, DCLconfig.ini, NWNxLauncher, NWNTxFile
 
	;Server 1
	IniWrite, %ServerName1%, DCLconfig.ini, Server 1, Name
	IniWrite, %ServerIP1%, DCLconfig.ini, Server 1, IPAddress
	IniWrite, %ServerPassword1%, DCLconfig.ini, Server 1, Password
	IniWrite, %ServerDMPassword1%, DCLconfig.ini, Server 1, DMPassword
	IniWrite, %ServerBanner1%, DCLconfig.ini, Server 1, Banner
	IniWrite, %ServerURL1%, DCLconfig.ini, Server 1, ServerURL
	;Server 2
	IniWrite, %ServerName2%, DCLconfig.ini, Server 2, Name
	IniWrite, %ServerIP2%, DCLconfig.ini, Server 2, IPAddress
	IniWrite, %ServerPassword2%, DCLconfig.ini, Server 2, Password
	IniWrite, %ServerDMPassword2%, DCLconfig.ini, Server 2, DMPassword
	IniWrite, %ServerBanner2%, DCLconfig.ini, Server 2, Banner
	IniWrite, %ServerURL2%, DCLconfig.ini, Server 2, ServerURL
	;Server 3
	IniWrite, %ServerName3%, DCLconfig.ini, Server 3, Name
	IniWrite, %ServerIP3%, DCLconfig.ini, Server 3, IPAddress
	IniWrite, %ServerPassword3%, DCLconfig.ini, Server 3, Password
	IniWrite, %ServerDMPassword3%, DCLconfig.ini, Server 3, DMPassword
	IniWrite, %ServerBanner3%, DCLconfig.ini, Server 3, Banner
	IniWrite, %ServerURL3%, DCLconfig.ini, Server 3, ServerURL
	;Server 4
	IniWrite, %ServerName4%, DCLconfig.ini, Server 4, Name
	IniWrite, %ServerIP4%, DCLconfig.ini, Server 4, IPAddress
	IniWrite, %ServerPassword4%, DCLconfig.ini, Server 4, Password
	IniWrite, %ServerDMPassword4%, DCLconfig.ini, Server 4, DMPassword
	IniWrite, %ServerBanner4%, DCLconfig.ini, Server 4, Banner
	IniWrite, %ServerURL4%, DCLconfig.ini, Server 4, ServerURL
	;Server 5
	IniWrite, %ServerName5%, DCLconfig.ini, Server 5, Name
	IniWrite, %ServerIP5%, DCLconfig.ini, Server 5, IPAddress
	IniWrite, %ServerPassword5%, DCLconfig.ini, Server 5, Password
	IniWrite, %ServerDMPassword5%, DCLconfig.ini, Server 5, DMPassword
	IniWrite, %ServerBanner5%, DCLconfig.ini, Server 5, Banner
	IniWrite, %ServerURL5%, DCLconfig.ini, Server 5, ServerURL

	Run, %FILE%
	GoSub, GuiClose
Return

;========================================--------------------==========
;                                            Destructers
;========================================--------------------==========
3GuiClose:
3GuiEscape:
  Gui, 2: -disabled
  Gui, 2: +lastfound
  Gui, 3: Destroy
Return

4GuiClose:
4GuiEscape:
  Gui, 3: -disabled
  Gui, 3: +lastfound
  Gui, 4: Destroy
Return

2GuiClose:

2GuiEscape: 
  Gui, 1:-Disabled ; Re-enable the main window (must be done prior to the next step).
  Gui, 2: Destroy
Return

GuiClose:
  ExitApp