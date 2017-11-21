;==================================================
;  Neverwinter Nights Direct Connect Launcher
;  Author: Joel McCracken (Alundaio)
;==================================================


;===============================
CURRENT_VERSION := 1.11
UPDATE_URL := "http://alundaio.chemicalservers.com/update.ini"
;===============================

#NoTrayIcon
#SingleInstance force
#Include FileHelper.ahk
;Get values from DCLConfig.ini
gosub ReadFromConfig

;Set up Gui, 1:
gui,1: color, %BACKGROUND_COLOR_LAUNCHER%
hGui := WinExist()
Gui,1: font,c%FONT_COLOR% %FONT_STYLE%, %FONT_TYPE%
Gui,1: +E0x80000000
BANNER_DIR := A_WorkingDir . "\DCLdata\Banners\"

Loop, 5
{

	Server := ServerName%A_Index%

	if (Server != "" && ServerIP%A_Index% !="")
	{
		Banner := ServerBanner%A_Index%
		Length := StrLen(Server)
		Length := Length*5 + 40
		
		ifexist,% BANNER_DIR . ServerBanner%A_Index%
		Gui,1: Add, picture,Center x82 hwnd%Server%_hwnd gServerLaunchURL%A_Index%, %A_WorkingDir%\DCLdata\Banners\%Banner%

		ServerName = ServerName%A_Index%
		Gui,1: Add, Button, x152 w%Length% gServer%A_Index% vServerButton%A_Index%, %Server%

		Gui,1: font, c0xFFFFFF
		Gui,1: Add, CheckBox, x+20 vEnableDM%A_Index%, DM
		Gui,1: font,c%FONT_COLOR% %FONT_STYLE%, %FONT_TYPE%
	}
}
;Align(ServerName1_hwnd, "L", 100)
	
AddPictureButton("IconNormalLaunch",A_WorkingDir . "\DCLdata\Icons\Icon_3","x15 y+100 gIconNormalLaunchOnClick","xp yp")
AddPictureButton("IconToolsetLaunch",A_WorkingDir . "\DCLdata\Icons\Icon_2","x+25 gIconToolsetLaunchOnClick","xp yp")
AddPictureButton("IconCepLaunch",A_WorkingDir . "\DCLdata\Icons\Icon_4","x+155 gIconCepLaunchOnClick","xp yp")
AddPictureButton("IconOptionsLaunch",A_WorkingDir . "\DCLdata\Icons\Icon_1","x+25 gIconOptionsLaunchOnClick","xp yp")

Gui,1: Show
Gui,1: Show, autosize center, Neverwinter Nights DC Launcher
WinSet, exstyle, -0x80000, Neverwinter Nights DC Launcher
Return
;==================================END INIT

;========================================--------------------------------==========
;                                                Function Includes
;========================================--------------------------------==========
#include NwnDCLFunctions.ahk
;========================================--------------------------------==========
;                                                  Subroutines
;========================================--------------------------------==========
IconNormalLaunchOnClick: 
   GuiControl, Hide, IconNormalLaunchState0 
   Sleep 250 
   GuiControl, Show, IconNormalLaunchState0
   Gosub, NormalLaunch
Return 
IconToolsetLaunchOnClick: 
   GuiControl, Hide, IconToolsetLaunchState0 
   Sleep 250 
   GuiControl, Show, IconToolsetLaunchState0
   Gosub, ToolsetLaunch
Return 
IconCepLaunchOnClick: 
   GuiControl, Hide, IconCepLaunchState0 
   Sleep 250 
   GuiControl, Show, IconCepLaunchState0
	Gosub, CEPUpdater
Return 
IconOptionsLaunchOnClick: 
   GuiControl, Hide, IconOptionsLaunchState0 
   Sleep 250 
   GuiControl, Show, IconOptionsLaunchState0
	Gosub, ServerOptions
Return 

ServerLaunchURL1:
run, %ServerURL1%
Return
ServerLaunchURL2:
run, %ServerURL2%
Return
ServerLaunchURL3:
run, %ServerURL3%
Return
ServerLaunchURL4:
run, %ServerURL4%
Return
ServerLaunchURL5:
run, %ServerURL5%
Return

ServerOptions:
{
gosub ReadFromConfig
Gui, +disabled
Gui, 2: +owner1
Gui, 2: +LastFound
Menu, MySubmenu, add, Check for updates,CheckUpdate
Menu, MySubmenu, add, About,ShowAbout
Gui, 2: Menu,MySubmenu
hGui := WinExist()

gui, 2: color, %BACKGROUND_COLOR_OPTIONS%
Gui, 2: font,c%FONT_COLOR% %FONT_STYLE%, %FONT_TYPE%
Gui, 2:  Add, Button, x272 y272 w100 h30 g2GuiSubmit, Ok
Gui, 2:  Add, Button, x422 y272 w100 h30 g2GuiClose, Cancel
Gui, 2:  Add, Tab, x2 y2 w760 h310 , Server Settings|Banner Options|Configuration|Game Options
;Gui, 2:  Add, GroupBox, x12 y42 w140 h220 , Server Name


Gui, 2:  Tab, Server Settings
Gui, 2:  Add, GroupBox, x312 y42 w140 h220 , Server Password
Gui, 2:  Add, GroupBox, x462 y42 w140 h220 , DM Password
Gui, 2:  Add, GroupBox, x612 y42 w140 h220 , Banner
Gui, 2:  Add, GroupBox, x162 y42 w140 h220 , Server IP address
Gui, 2:  Add, GroupBox, x12  y42 w140 h220 , Server Name

;Add Sever controls
Loop, 5
{
ServerVar := ServerName%A_Index%
Gui, 2:  Add, Edit, x22 yp+30 w120 h20 vServerName%A_Index%,%ServerVar%

ServerVar := ServerIP%A_Index%
Gui, 2:  Add, Edit, x+30 yp w120 h20 vServerIP%A_Index%,%ServerVar%

ServerVar := ServerPassword%A_Index%
Gui, 2:  Add, Edit,x+30 yp w120 h20 vServerPassword%A_Index%,%ServerVar%

ServerVar := ServerDMPassword%A_Index%
Gui, 2:  Add, Edit,x+30 yp w120 h20 vServerDMPassword%A_Index%,%ServerVar%

ServerVar := ServerBanner%A_Index%
Gui, 2:  Add, Edit,x+30 yp w120 h20 vServerBanner%A_Index%,%ServerVar%

}
Gui, 2:  Tab, Banner Options
Gui, 2:Add, GroupBox, x202 y32 w380 h230 , Banner On-Click URL
Gui, 2:Add, Text, x222 y62, Server 1:
Gui, 2:Add, Text, x222 y102, Server 2:
Gui, 2:Add, Text, x222 y142, Server 3:
Gui, 2:Add, Text, x222 y182, Server 4:
Gui, 2:Add, Text, x222 y222, Server 5:
Gui, 2:Add, Edit, x282 y62 w270 h20 vServerURL1,%ServerURL1%
Gui, 2:Add, Edit, x282 y102 w270 h20 vServerURL2,%ServerURL2%
Gui, 2:Add, Edit, x282 y142 w270 h20 vServerURL3,%ServerURL3%
Gui, 2:Add, Edit, x282 y182 w270 h20 vServerURL4,%ServerURL4%
Gui, 2:Add, Edit, x282 y222 w270 h20 vServerURL5,%ServerURL5%
Gui, 2: Add,Button, x635 y52 w80 h20 gOpenBannersFolder, Banners
Gui, 2:  Tab, Configuration
Gui, 2:  Add, GroupBox, x12 y32 w220 h170 , Options
if (%EnableLogging% == 0)
{
Gui, 2:  Add, CheckBox, x22 y52 w130 h30 vEnableLogging, Enable Log Renaming
}
Else
{
Gui, 2:  Add, CheckBox, x22 y52 w130 h30 vEnableLogging checked , Enable Log Renaming	
}
if (%PersistantLauncher% == 0)
{
Gui, 2:  Add, CheckBox, x22 y82 w130 h30 vPersistantLauncher, Persistant Launcher
}
Else
{
Gui, 2:  Add, CheckBox, x22 y82 w130 h30 vPersistantLauncher checked, Persistant Launcher	
}

Gui, 2: Add,Button, x162 y60 w60 h20 gOpenLogFolder, Logs

Gui, 2:  Add, GroupBox, x250 y32 w280 h50 , Game Directory
Gui, 2:  Add, Edit, x262 y52 w200 h20 vNWN_DIR, %NWN_DIR%
Gui, 2:  Add, Button, x465 y52 w60 h20 gBrowseGameDirectory, Browse

Gui, 2:  Add, GroupBox, x250 y92 w280 h80 , Current Override Directory
Gui, 2:  Add, Edit, x262 y112 w200 h20 vOVR_DIR, %OVR_DIR%
Gui, 2:  Add, Button, x465 y112 w60 h20 gBrowseOverride, Browse
Gui, 2:  Add,Button, x350 y142 w100 h20 gSwapOverrides, Swap Override

Gui, 2:  Add, GroupBox, x250 y180 w280 h80 , Swap dialog.tlk File
Gui, 2:  Add, Edit, x262 y200 w200 h20 vTLK_DIR, %TLK_DIR%
Gui, 2:  Add, Button, x465 y200 w60 h20 gBrowseTlk, Browse
Gui, 2:  Add,Button, x350 y232 w100 h20 gSwapTlk, Swap dialog.tlk

Gui, 2:  Add, GroupBox, x550 y32 w150 h50 , GUI Options
Gui, 2:  Add, Button, x590 y52 w75 h20 gSelectFont, Font
Gui, 2:  Add, GroupBox, x550 y75 w150 h70 , GUI Background Color
Gui, 2:  Add, Button, x590 y95 w75 h20 gSelectOptionsColor, Options
Gui, 2:  Add, Button, x590 y115 w75 h20 gSelectLauncherColor, Launcher

Gui, 2:  Show, xCenter yCenter h318 w769, Server Options

Gui, 2:  Tab, Game Options

Read_Nwnplayer(1)
;=========Chat Colors
Gui, 2:  Add, GroupBox, x12 y32 w235 h240 , Chat Colors

guipos_y = 50
Gui, 2:  Add, Button, x20 y%guipos_y% w70 h20 gOnChatColor, Talk
Gui, 2:  Add, Button, x195 y%guipos_y% w40 h20 gUndoTalk, Undo
RGB := Convert_RGB_to_Hex(TalkColor)
Gui, 2: Font,c%RGB%
Gui, 2:  Add, edit, c%RGB% x105 y%guipos_y% w80 center hwndTalk_color_hwnd vTalk_color, Talk text
CColor(Talk_color_hwnd, "Black", RGB)
Gui, 2: Font,c%FONT_COLOR%
guipos_y := guipos_y + 25

Gui, 2:  Add, Button, x20 y%guipos_y% w70 h20 gOnChatColor, Shout
Gui, 2:  Add, Button, x195 y%guipos_y% w40 h20 gUndoShout, Undo

RGB := Convert_RGB_to_Hex(ShoutColor)
Gui, Color,,000000
Gui, 2: Font,c%RGB%
Gui, 2:  Add, Edit, x105 y%guipos_y% w80 center hwndShout_color_hwnd vShout_color, Shout text
CColor(Shout_color_hwnd, "Black", RGB)
Gui, 2: Font,c%FONT_COLOR%
guipos_y := guipos_y + 25

Gui, 2:  Add, Button, x20 y%guipos_y% w70 h20 gOnChatColor, Whisper
Gui, 2:  Add, Button, x195 y%guipos_y% w40 h20 gUndoWhisper, Undo

RGB := Convert_RGB_to_Hex(WhisperColor)
Gui, 2: Font,c%RGB%
Gui, 2:  Add, Edit, x105 y%guipos_y% w80 center hwndWhisper_color_hwnd vWhisper_color, Whisper text
CColor(Whisper_color_hwnd, "Black", RGB)
Gui, 2: Font,c%FONT_COLOR%
guipos_y := guipos_y + 25

Gui, 2:  Add, Button, x20 y%guipos_y% w70 h20 gOnChatColor, Tell
Gui, 2:  Add, Button, x195 y%guipos_y% w40 h20 gUndoTell, Undo
RGB := Convert_RGB_to_Hex(TellColor)
Gui, 2: Font,c%RGB%
Gui, 2:  Add, Edit, x105  y%guipos_y% center hwndTell_color_hwnd w80 vTell_color, Tell text
CColor(Tell_color_hwnd, "Black", RGB)
Gui, 2: Font,c%FONT_COLOR%
guipos_y := guipos_y + 25

Gui, 2:  Add, Button, x20  y%guipos_y% w70 h20 gOnChatColor, Server
Gui, 2:  Add, Button, x195  y%guipos_y% w40 h20 gUndoServer, Undo
RGB := Convert_RGB_to_Hex(ServerColor)
Gui, 2: Font,c%RGB%
Gui, 2:  Add, Edit, x105  y%guipos_y% w80 center hwndServer_color_hwnd vServer_color, Server text
CColor(Server_color_hwnd, "Black", RGB)
Gui, 2: Font,c%FONT_COLOR%
guipos_y := guipos_y + 25

Gui, 2:  Add, Button, x20  y%guipos_y% w70 h20 gOnChatColor, Party
Gui, 2:  Add, Button, x195  y%guipos_y% w40 h20 gUndoParty, Undo
RGB := Convert_RGB_to_Hex(PartyColor)
Gui, 2: Font,c%RGB%
Gui, 2:  Add, Edit, x105  y%guipos_y% w80 center hwndParty_color_hwnd vParty_color, Party text
CColor(Party_color_hwnd, "Black", RGB)
Gui, 2: Font,c%FONT_COLOR%
guipos_y := guipos_y + 25

Gui, 2:  Add, Button, x20  y%guipos_y% w70 h20 gOnChatColor, DM
Gui, 2:  Add, Button, x195  y%guipos_y% w40 h20 gUndoDM, Undo
RGB := Convert_RGB_to_Hex(DMColor)
Gui, 2: Font,c%RGB%
Gui, 2:  Add, Edit, x105  y%guipos_y% center hwndDM_color_hwnd vDM_color w80, DM text
CColor(DM_color_hwnd, "Black", RGB)
Gui, 2: Font,c%FONT_COLOR%
guipos_y := guipos_y + 35

Gui, 2:  Add, Button, x95  y%guipos_y% w70 h20 gChatColorReset, Defaults


;=======Trap Colors
Read_Nwnplayer(2)

Gui, 2:  Add, GroupBox, x250 y32 w210 h80 , Trap Colors

guipos_y := 50
Gui, 2:  Add, Button, x265 y%guipos_y% w70 h20 gOnTrapColor, Friendly
RGB := Convert_RGB_to_Hex(FriendlyColor)
Gui, 2: Font,c%RGB%
Gui, 2:  Add, edit,c%RGB% x365 y%guipos_y% center hwndFriendly_color_hwnd w70 vFriendly_color, Friendly
CColor(Friendly_color_hwnd, "Black", RGB)
Gui, 2: Font,c%FONT_COLOR%
guipos_y := guipos_y + 25
Gui, 2:  Add, Button, x265 y%guipos_y% w70 h20 gOnTrapColor, Hostile
RGB := Convert_RGB_to_Hex(HostileColor)
Gui, 2: Font,c%RGB%
Gui, 2:  Add, edit,c%RGB% x365 y%guipos_y% center hwndHostile_color_hwnd w70 vHostile_color, Hostile
CColor(Hostile_color_hwnd, "Black", RGB)
Gui, 2: Font,c%FONT_COLOR%


Winset,Redraw
EmptyMem()
Return
}


ShowAbout:
Gui, 2: +disabled
Gui, 3: +owner1
Gui, 3: +LastFound
hGui3 := winexist()
Gui,3: Add, Button, x122 y222 w100 h30 g3GuiClose , Ok
Gui,3: Add, Text, x12 y12, Neverwinter Nights DC Launcher v%CURRENT_VERSION% `n`nAuthor: Alundaio
HLink_Add(hGui3, 45,  130,  250, 20, "OnLink", "Thank you. Please remember to 'vote':www.Google.com !" )
; Generated using SmartGUI Creator 4.0
Gui,3:Show, x373 y196 h272 w339, About
Return

LaunchVote:
Run http://nwvault.ign.com/View.php?view=Other.Detail&id=1431
Return

CheckUpdate:
	UrlDownloadToFile, %UPDATE_URL%,update.ini
	
	ifexist,update.ini
	{
		iniRead,UPDATE_VERSION,update.ini,Main,Version,1
		if (UPDATE_VERSION > CURRENT_VERSION)
		{
			msgbox,4,, There is an update available! Would you like to download it? `n`nPlease remember to vote. Thanks!
			IfMsgBox Yes
			{
			iniRead,INSTALL_URL,update.ini,Main,UpdateInstaller,1
			UrlDownloadToFile, %INSTALL_URL%, %A_WorkingDir%/temp/tempinstaller.zip
			sZip := A_WorkingDir . "\temp\tempinstaller.zip"
			sUnz := A_WorkingDir . "\temp"
			unz(sZip,sUnz)
			runwait,%A_WorkingDir%\temp\Neverwinter_Nights_Launcher_%UPDATE_VERSION%.exe

			filedelete,%A_WorkingDir%\temp\tempinstaller.zip
			filedelete,%A_WorkingDir%\temp\Neverwinter_Nights_Launcher_%UPDATE_VERSION%.exe
				if ErrorLevel   ; i.e. it's not blank or zero.
				{
				MsgBox, Failed. Download manually at http://nwvault.ign.com/View.php?view=Other.Detail&id=1431
				}
			}
		}
		Else
		{
		Msgbox, No update available.
		}
	}
	Else
	{
	msgbox, Failed. Download manually at http://nwvault.ign.com/View.php?view=Other.Detail&id=1431
	}

filedelete,Update.ini
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
	CColor(Talk_color_hwnd, "Black", RGB)
	RGB := Convert_RGB_to_Hex(ShoutColor)
	CColor(Shout_color_hwnd, "Black", RGB)
	RGB := Convert_RGB_to_Hex(WhisperColor)
	CColor(Whisper_color_hwnd, "Black", RGB)
	RGB := Convert_RGB_to_Hex(TellColor)
	CColor(Tell_color_hwnd, "Black", RGB)
	RGB := Convert_RGB_to_Hex(ServerColor)
	CColor(Server_color_hwnd, "Black", RGB)
	RGB := Convert_RGB_to_Hex(PartyColor)
	CColor(Party_color_hwnd, "Black", RGB)
	RGB := Convert_RGB_to_Hex(DMColor)
	CColor(DM_color_hwnd, "Black", RGB)
Winset,Redraw	
;Write the r,g,b values to the nwnplayer.ini
	iniWrite,%TalkColor%, %NWN_DIR%\nwnplayer.ini,Chat Colors, TalkColor
	iniWrite,%ShoutColor%, %NWN_DIR%\nwnplayer.ini,Chat Colors, ShoutColor
	iniWrite,%WhisperColor%, %NWN_DIR%\nwnplayer.ini,Chat Colors, WhisperColor
	iniWrite,%TellColor%, %NWN_DIR%\nwnplayer.ini,Chat Colors, TellColor
	iniWrite,%ServerColor%, %NWN_DIR%\nwnplayer.ini,Chat Colors, ServerColor
	iniWrite,%PartyColor%, %NWN_DIR%\nwnplayer.ini,Chat Colors, PartyColor
	iniWrite,%DMColor%, %NWN_DIR%\nwnplayer.ini,Chat Colors, DMColor
Return

;Undo Chatcolors
UndoTalk:
	IniRead,TalkColor,DCLConfig.ini,Chat Colors,TalkColor
	RGB := Convert_RGB_to_Hex(TalkColor)
	CColor(Talk_color_hwnd, "Black", RGB)
	RGB := Convert_RGB_from_Hex( "0x" . TalkColor)
	iniWrite,%RGB%, %NWN_DIR%\nwnplayer.ini,Chat Colors, TalkColor
	Winset,Redraw
Return
UndoShout:
	IniRead,ShoutColor,DCLConfig.ini,Chat Colors,ShoutColor
	RGB := Convert_RGB_to_Hex(ShoutColor)
	CColor(Shout_color_hwnd, "Black", RGB)
	RGB := Convert_RGB_from_Hex( "0x" . ShoutColor)
	iniWrite,%RGB%, %NWN_DIR%\nwnplayer.ini,Chat Colors, ShoutColor
	Winset,Redraw
Return
UndoWhisper:
	IniRead,WhisperColor,DCLConfig.ini,Chat Colors,WhisperColor
	RGB := Convert_RGB_to_Hex(WhisperColor)
	CColor(Whisper_color_hwnd, "Black", RGB)
	RGB := Convert_RGB_from_Hex( "0x" . WhisperColor)
	iniWrite,%RGB%, %NWN_DIR%\nwnplayer.ini,Chat Colors, WhisperColor
	Winset,Redraw
Return
UndoTell:
	IniRead,TellColor,DCLConfig.ini,Chat Colors,TellColor
	RGB := Convert_RGB_to_Hex(TellColor)
	CColor(Tell_color_hwnd, "Black", RGB)
	RGB := Convert_RGB_from_Hex( "0x" . TellColor)
	iniWrite,%RGB%, %NWN_DIR%\nwnplayer.ini,Chat Colors, TellColor
	Winset,Redraw
Return
UndoServer:
	IniRead,ServerColor,DCLConfig.ini,Chat Colors,ServerColor
	RGB := Convert_RGB_to_Hex(ServerColor)
	CColor(Server_color_hwnd, "Black", RGB)
	RGB := Convert_RGB_from_Hex( "0x" . ServerColor)
	iniWrite,%RGB%, %NWN_DIR%\nwnplayer.ini,Chat Colors, ServerColor
	Winset,Redraw
Return
UndoParty:
	IniRead,PartyColor,DCLConfig.ini,Chat Colors,PartyColor
	RGB := Convert_RGB_to_Hex(PartyColor)
	CColor(Party_color_hwnd, "Black", RGB)
	RGB := Convert_RGB_from_Hex( "0x" . PartyColor)
	iniWrite,%RGB%, %NWN_DIR%\nwnplayer.ini,Chat Colors, PartyColor
	Winset,Redraw
Return
UndoDM:
	IniRead,DMColor,DCLConfig.ini,Chat Colors,DMColor
	RGB := Convert_RGB_to_Hex(DMColor)
	CColor(DM_color_hwnd, "Black", RGB)
	RGB := Convert_RGB_from_Hex( "0x" . DMColor)
	iniWrite,%RGB%, %NWN_DIR%\nwnplayer.ini,Chat Colors, DMColor
	Winset,Redraw
Return

OnTrapColor:

		;Read from the nwnplayer.ini to grab trap colors
		Read_Nwnplayer(2)	
		
		if A_GuiControl = Friendly
		{
				RGB := Convert_RGB_to_Hex(FriendlyColor)
				if Dlg_Color( color:="0x" . RGB, hGui )
				{
					CColor(Friendly_color_hwnd, "Black", Color)
					RGB := Convert_RGB_from_Hex( "0x" . Color)
					iniWrite,%FriendlyColor%, DCLconfig.ini,Trap Colors, FriendlyColor
					iniWrite,%RGB%, %NWN_DIR%\nwnplayer.ini,Trap Colors, FriendlyColor
				}				
		}
		else if A_GuiControl = Hostile
		{
				RGB := Convert_RGB_to_Hex(HostileColor)
				if Dlg_Color( color:="0x" . RGB, hGui )
				{
					CColor(Hostile_color_hwnd, "Black", Color)
					RGB := Convert_RGB_from_Hex( "0x" . Color)
					iniWrite,%HostileColor%, DCLconfig.ini,Trap Colors, HostileColor
					iniWrite,%RGB%, %NWN_DIR%\nwnplayer.ini,Trap Colors, HostileColor
				}					
		}
Winset,Redraw
Return

OnChatColor:
		;Read from the nwnplayer.ini to grab Chat Colors
		Read_Nwnplayer(1)	

			if A_GuiControl = Talk
			{
				RGB := Convert_RGB_to_Hex(TalkColor)    ;Convert r,g,b to hex
				if Dlg_Color( color:="0x" . RGB, hGui ) ;Call Color Picker dialog passing the hexcolor and window
				{
					CColor(Talk_color_hwnd, "Black", Color)
					RGB := Convert_RGB_from_Hex( "0x" . Color) ;Convert new color hex back to r,g,b to write in nwnplayer.ini
					iniWrite,%TalkColor%, DCLconfig.ini,Chat Colors, TalkColor
					iniWrite,%RGB%, %NWN_DIR%\nwnplayer.ini,Chat Colors, TalkColor
				}
			}
			else if A_GuiControl = Shout
			{
			RGB := Convert_RGB_to_Hex(ShoutColor)	
				if Dlg_Color( color:="0x" . RGB, hGui )
				{
					CColor(Shout_color_hwnd, "Black", Color)
					RGB := Convert_RGB_from_Hex( "0x" . Color)
					iniWrite,%ShoutColor%, DCLconfig.ini,Chat Colors, ShoutColor
					iniWrite,%RGB%, %NWN_DIR%\nwnplayer.ini,Chat Colors, ShoutColor
				}				
			}
			else if A_GuiControl = Whisper
			{
				RGB := Convert_RGB_to_Hex(WhisperColor)
				if Dlg_Color( color:="0x" . RGB, hGui )
				{
					CColor(Whisper_color_hwnd, "Black", Color)
					RGB := Convert_RGB_from_Hex( "0x" . Color)
					iniWrite,%WhisperColor%, DCLconfig.ini,Chat Colors, WhisperColor
					iniWrite,%RGB%, %NWN_DIR%\nwnplayer.ini,Chat Colors, WhisperColor
				}				
			}
			else if A_GuiControl = Tell
			{
				RGB := Convert_RGB_to_Hex(TellColor)
				if Dlg_Color( color:="0x" . RGB, hGui )
				{
					CColor(Tell_color_hwnd, "Black", Color)
					RGB := Convert_RGB_from_Hex( "0x" . Color)
					iniWrite,%TellColor%, DCLconfig.ini,Chat Colors, TellColor
					iniWrite,%RGB%, %NWN_DIR%\nwnplayer.ini,Chat Colors, TellColor
				}				
			}
			else if A_GuiControl = Server
			{
				RGB := Convert_RGB_to_Hex(ServerColor)
				if Dlg_Color( color:="0x" . RGB, hGui )
				{
					CColor(Server_color_hwnd, "Black", Color)
					RGB := Convert_RGB_from_Hex( "0x" . Color)
					iniWrite,%ServerColor%, DCLconfig.ini,Chat Colors, ServerColor
					iniWrite,%RGB%, %NWN_DIR%\nwnplayer.ini,Chat Colors, ServerColor
				}				
			}
			else if A_GuiControl = Party
			{
				RGB := Convert_RGB_to_Hex(PartyColor)
				if Dlg_Color( color:="0x" . RGB, hGui )
				{
					CColor(Party_color_hwnd, "Black", Color)
					RGB := Convert_RGB_from_Hex( "0x" . Color)
					iniWrite,%PartyColor%, DCLconfig.ini,Chat Colors, PartyColor
					iniWrite,%RGB%, %NWN_DIR%\nwnplayer.ini,Chat Colors, PartyColor
				}				
			}
			else if A_GuiControl = DM
			{
				RGB := Convert_RGB_to_Hex(DMColor)
				if Dlg_Color( color:="0x" . RGB, hGui )
				{
					CColor(DM_color_hwnd, "Black", Color)
					RGB := Convert_RGB_from_Hex( "0x" . Color)
					iniWrite,%DMColor%, DCLconfig.ini,Chat Colors, DMColor
					iniWrite,%RGB%, %NWN_DIR%\nwnplayer.ini,Chat Colors, DMColor
				}				
			}
Winset,Redraw			
Return

SelectOptionsColor:
iniRead,BACKGROUND_COLOR_OPTIONS,DCLconfig.ini,GUI Options,Background_Color_Options, EEAA99
		if Dlg_Color(color := "0x" . OPTIONS_BKG_COLOR, hGui)
		{
			iniWrite, %Color%,DCLconfig.ini, GUI Options, Background_Color_Options	
		}
Return
SelectLauncherColor:
iniRead,BACKGROUND_COLOR_LAUNCHER,DCLconfig.ini,GUI Options,Background_Color_Launcher,000000
		if Dlg_Color(color := "0x" . LAUNCHER_BKG_COLOR, hGui)
		{
			iniWrite, %Color%,DCLconfig.ini, GUI Options, Background_Color_Launcher			
		}
Return

SelectFont:
iniRead,FONT_STYLE,DCLconfig.ini,GUI Options,Font_Style,9
iniRead,FONT_TYPE,DCLconfig.ini,GUI Options,Font_Type,MS Sans Serif
iniRead,FONT_COLOR,DCLconfig.ini,GUI Options,Font_Color,000000
		if Dlg_Font( font:=FONT_TYPE, style:=FONT_STYLE, color:= "0x" . FONT_COLOR, true, hGui)
		{
			iniWrite, %style%,DCLconfig.ini, GUI Options, Font_Style
			iniWrite, %font%,DCLconfig.ini, GUI Options, Font_Type
			iniWrite, %Color%,DCLconfig.ini, GUI Options, Font_Color
		}
Return

BrowseOverride:
FileSelectFolder, OutputVar, %NWN_DIR%, 3
if OutputVar =
    MsgBox, You didn't select a folder.
else
{
	GuiControl,, OVR_DIR, %OutputVar%
	OVR_DIR = %OutputVar%
}

Return

BrowseTlk:
FileSelectFile, SelectedFile, 3, %NWN_DIR%, Open a file, Dialog (*.tlk)
if SelectedFile =
MsgBox, You didn't select anything.
else
{
	GuiControl,, TLK_DIR, %SelectedFile%
	TLK_DIR = %SelectedFile%
}
Return

BrowseGameDirectory:
FileSelectFolder, OutputVar,, 3
if OutputVar !=
{
	GuiControl,, NWN_DIR, %OutputVar%
	NWN_DIR = %OutputVar%
}

Return

NormalLaunch:
{
	if (EnableLogging == 1)
	{
	RenameLogFile()
	}

	run, nwmain.exe,%NWN_DIR%,,NewPID
	;EmptyMem(NewPID)
	if (PersistantLauncher == 0)
	{
	Exitapp
	}
EmptyMem()
Return
}



ToolsetLaunch:
	run, nwtoolset.exe,%NWN_DIR%,,NewPID
	if (PersistantLauncher == 0)
	{
	Exitapp
	}
EmptyMem()
Return

CEPUpdater:
run, erf.exe -vm %CEPUpdateLink%, %NWN_DIR%
EmptyMem()
Return

ReadFromConfig:
	if fileExist("DCLconfig.ini")
	{
	ReadDCLConfig()
	}
	Else
	{
	BACKGROUND_COLOR_LAUNCHER = 000000  ;set default bkg color if ini doesn't exist
	CreateDCLConfig()
	}
Return

SwapOverrides:
	gui,2: submit,nohide
	
	ifexist,%OVR_DIR%
	{
		iniWrite,%OVR_DIR%,%NWN_DIR%\nwn.ini,Alias,OVERRIDE
		if ErrorLevel
		MsgBox, Nwn.ini could not be written to (Check if readonly).
		else
		MsgBox, Swapping successful.
	}
	Else
	{
		MsgBox, That folder does not exist.	
	}
	Return

SwapTlk:
	TLK_DEFAULT = %NWN_DIR%\dialog.tlk
	gui,2: submit,nohide
	iniRead,TlkSwapFirstTime,DCLconfig.ini,Server Options,TlkSwapFirstTime,1
	if (TlkSwapFirstTime == 1)
	{
		ifexist,%TLK_DEFAULT%
		{
			FileMove, %TLK_DEFAULT%, %NWN_DIR%\dialog_backup.tlk
			if ErrorLevel
			MsgBox, A backup of the dialog.tlk could not be created (It may already exist).
			else
			MsgBox, A backup of the dialog.tlk was created (dialog_backup.tlk).
			
			;Swap new folder
			FileMove, %TLK_DIR%, %TLK_DEFAULT%
			if ErrorLevel
			MsgBox, %TLK_DIR% could not be renamed to %TLK_DEFAULT%.
			Else
			{
			MsgBox, Swapping successful.			
			TLK_DIR_LAST = %TLK_DIR%
			iniWrite, 0,DCLconfig.ini,Server Options, TlkSwapFirstTime
			}
		}
		Else
		{
		MsgBox, The dialog.tlk does not exist.	
		}
	}
	Else
	{
		ifexist,%TLK_DIR_LAST%
		{
		MsgBox, The dialog.tlk could not be swapped. A file with it's stored name already exists.	
		}
		Else
		{
			FileMove, %TLK_DEFAULT%, %TLK_DIR_LAST%
			if ErrorLevel
			MsgBox, A backup of the dialog.tlk could not be created (It may already exist).
			
			;Swap new folder
			FileMove, %TLK_DIR%, %TLK_DEFAULT%
			if ErrorLevel
			MsgBox, The new dialog.tlk could not be created.
			Else
			{
			MsgBox, Swapping successful.			
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
	gui,2: submit,nohide
	;-----write to DCLConfig.ini
		;Server Options
	iniWrite, %NWN_DIR%,DCLconfig.ini,Server Options, GameDirectory
	iniWrite, %OVR_DIR%,DCLconfig.ini,Server Options, CurrentOverrideDirectory
	iniWrite, %TLK_DIR%,DCLconfig.ini,Server Options, CurrentTLK
	iniWrite, %TLK_DIR_LAST%,DCLconfig.ini,Server Options, LastTLK
	iniWrite, %EnableLogging%,DCLconfig.ini,Server Options, EnableLogging
	iniWrite, %PersistantLauncher%,DCLconfig.ini,Server Options, PersistantLauncher
		;Server 1
	iniWrite, %ServerName1%,DCLconfig.ini,Server 1, Name
	iniWrite, %ServerIP1%,DCLconfig.ini,Server 1, IPAddress
	iniWrite, %ServerPassword1%,DCLconfig.ini,Server 1, Password
	iniWrite, %ServerDMPassword1%,DCLconfig.ini,Server 1, DMPassword
	iniWrite, %ServerBanner1%,DCLconfig.ini,Server 1, Banner
	iniWrite, %ServerURL1%,DCLconfig.ini,Server 1, ServerURL
		;Server 2
	iniWrite, %ServerName2%,DCLconfig.ini,Server 2, Name
	iniWrite, %ServerIP2%,DCLconfig.ini,Server 2, IPAddress
	iniWrite, %ServerPassword2%,DCLconfig.ini,Server 2, Password
	iniWrite, %ServerDMPassword2%,DCLconfig.ini,Server 2, DMPassword
	iniWrite, %ServerBanner2%,DCLconfig.ini,Server 2, Banner
	iniWrite, %ServerURL2%,DCLconfig.ini,Server 2, ServerURL
		;Server 3
	iniWrite, %ServerName3%,DCLconfig.ini,Server 3, Name
	iniWrite, %ServerIP3%,DCLconfig.ini,Server 3, IPAddress
	iniWrite, %ServerPassword3%,DCLconfig.ini,Server 3, Password
	iniWrite, %ServerDMPassword3%,DCLconfig.ini,Server 3, DMPassword
	iniWrite, %ServerBanner3%,DCLconfig.ini,Server 3, Banner
	iniWrite, %ServerURL3%,DCLconfig.ini,Server 3, ServerURL
		;Server 4
	iniWrite, %ServerName4%,DCLconfig.ini,Server 4, Name
	iniWrite, %ServerIP4%,DCLconfig.ini,Server 4, IPAddress
	iniWrite, %ServerPassword4%,DCLconfig.ini,Server 4, Password
	iniWrite, %ServerDMPassword4%,DCLconfig.ini,Server 4, DMPassword
	iniWrite, %ServerBanner4%,DCLconfig.ini,Server 4, Banner
	iniWrite, %ServerURL4%,DCLconfig.ini,Server 4, ServerURL
		;Server 5
	iniWrite, %ServerName5%,DCLconfig.ini,Server 5, Name
	iniWrite, %ServerIP5%,DCLconfig.ini,Server 5, IPAddress
	iniWrite, %ServerPassword5%,DCLconfig.ini,Server 5, Password
	iniWrite, %ServerDMPassword5%,DCLconfig.ini,Server 5, DMPassword
	iniWrite, %ServerBanner5%,DCLconfig.ini,Server 5, Banner
	iniWrite, %ServerURL5%,DCLconfig.ini,Server 5, ServerURL
	run, Neverwinter Nights Launcher.exe
	gosub ,GuiClose
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
2GuiClose:
2GuiEscape: 
Gui, 1:-Disabled ; Re-enable the main window (must be done prior to the next step).
Gui, 2: Destroy
return

GuiClose:
ExitApp