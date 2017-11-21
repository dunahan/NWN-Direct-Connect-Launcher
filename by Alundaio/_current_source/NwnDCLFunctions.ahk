;===========================================
; Neverwinter Nights DC Launcher Functions
; NwnDCLFunctions.ahk
; Author: Alundaio
;===========================================


;========================================--------------------------------==========
;                                          DirectConnect(ServerNumber)   <---------*****
;========================================--------------------------------==========
DirectConnect(ServerNumber)
{
	Global
	local Params, Pass, ConnectToIP

;Collect EnableDM checkbox info
gui,1: submit,nohide

;Setup and run nwmain.exe with params
	
	if (EnableLogging == 1)
	{
	 RenameLogFile()
	}
if (EnableDM%ServerNumber% == 1)
{
Params = %Params%nwmain.exe -dmc
}
ConnectToIP := ServerIP%ServerNumber%
Params = %Params%nwmain.exe +connect %ConnectToIP%


if (EnableDM%ServerNumber% == 1)
{
	Pass := ServerDMPassword%ServerNumber%
	Params = %Params% +password %Pass%
}
Else
{
	If (ServerPassword%ServerNumber% != "")
	{
		Pass := ServerPassword%ServerNumber%
		Params = %Params% +password %Pass%
	}
}
	run, %Params%,%NWN_DIR%
	
	if (PersistantLauncher == 0)
	{
	Exitapp
	}
}
;===========================================================-------------------------------===========
;                                                             Picture Buttons <----------*****
;===========================================================-------------------------------===========
AddPictureButton(VariableName, ImgPath, Options="", SecondaryOptions="") 
{
	Global
	Gui,1: Add, Picture,   v%VariableName%state1 %Options%,%ImgPath%_1.ico
	Gui,1: Add, Picture,   v%VariableName%state0 hwnd%VariableName%_hwnd %SecondaryOptions%,%ImgPath%.ico
	%VariableName%_timer = 5
	Return
}
;===========================================================-------------------------===========
;                                                                ReadDCLConfig()     <----------*****
;===========================================================-------------------------===========

ReadDCLConfig()
{
	Global
;Version
iniRead,VERSION,DCLconfig.ini,Main,Version,1
; GUI Options
iniRead,FONT_STYLE,DCLconfig.ini,GUI Options,Font_Style,9
iniRead,FONT_TYPE,DCLconfig.ini,GUI Options,Font_Type,MS Sans Serif
iniRead,FONT_COLOR,DCLconfig.ini,GUI Options,Font_Color,000000
iniRead,BACKGROUND_COLOR_OPTIONS,DCLconfig.ini,GUI Options,Background_Color_Options, d6d6d6
iniRead,BACKGROUND_COLOR_LAUNCHER,DCLconfig.ini,GUI Options,Background_Color_Launcher,000000
;Server Options
FormatTime,timestamp,,MMMM d, yyyy [hmm tt]
iniRead,NWN_DIR,DCLconfig.ini,Server Options,GameDirectory,C:\NeverwinterNights\NWN
iniRead,OVR_DIR,DCLconfig.ini,Server Options,CurrentOverrideDirectory,C:\NeverwinterNights\NWN\override
iniRead,TLK_DIR,DCLconfig.ini,Server Options,CurrentTlk,C:\NeverwinterNights\NWN\dialog.tlk
iniRead,TLK_DIR_LAST,DCLconfig.ini,Server Options,LastTlk,C:\NeverwinterNights\NWN\dialog_backup.tlk
iniRead,EnableLogging,DCLconfig.ini,Server Options,EnableLogging,0
iniRead,timestamp,DCLconfig.ini,Server Options,CurrentLogDate,%timestamp%
iniRead,PersistantLauncher,DCLconfig.ini,Server Options,PersistantLauncher,0
iniread,CEPUpdateLink,DCLconfig.ini,Server Options,CEPUpdateLink,http://cep.hgweb.org/man/cep.txt

Loop, 5
{
iniRead,ServerName%A_Index%,DCLconfig.ini,Server %A_Index%, Name,""
iniRead,ServerIP%A_Index%,DCLconfig.ini,Server %A_Index%, IPAddress,""
iniRead,ServerPassword%A_Index%,DCLconfig.ini,Server %A_Index%, Password,""
iniRead,ServerDMPassword%A_Index%,DCLconfig.ini,Server %A_Index%, DMPassword,""
iniRead,ServerBanner%A_Index%,DCLconfig.ini,Server %A_Index%, Banner,""
iniRead,ServerURL%A_Index%,DCLconfig.ini,Server %A_Index%, ServerURL,""
}

if VERSION != CURRENT_VERSION
{
	;Check config for current version and update/add necessary keys
	if VERSION < 1.10
	{
	iniWrite,240`,240`,240, DCLconfig.ini,Default Chat Colors, TalkColor
	iniWrite,255`,239`,80, DCLconfig.ini,Default Chat Colors, ShoutColor
	iniWrite,128`,128`,128, DCLconfig.ini,Default Chat Colors, WhipserColor
	iniWrite,32`,255`,32, DCLconfig.ini,Default Chat Colors, TellColor
	iniWrite,176`,176`,176, DCLconfig.ini,Default Chat Colors, ServerColor
	iniWrite,240`,240`,240, DCLconfig.ini,Default Chat Colors, PartyColor
	iniWrite,16`,223`,255, DCLconfig.ini,Default Chat Colors, DMColor
	}
	if VERSION < 1.11
	{
	filedelete,DCLdata\images.dll
	}

	;Set Version
	iniWrite, %CURRENT_VERSION%,DCLconfig.ini, Main, Version
}
return
}

;===========================================================-------------------------===========
;                                                                CreateDCLConfig()     <----------*****
;===========================================================-------------------------===========
CreateDCLConfig()
{
		;Main
	iniWrite, %CURRENT_VERSION%,DCLconfig.ini, Main, Version
		;Gui Options
	iniWrite, 9,DCLconfig.ini, GUI Options, Font_Style
	iniWrite,MS Sans Serif,DCLconfig.ini, GUI Options, Font_Type
	iniWrite, 000000,DCLconfig.ini, GUI Options, Font_Color
	iniWrite, d6d6d6,DCLconfig.ini, GUI Options, Background_Color_Options
	iniWrite, 000000,DCLconfig.ini, GUI Options, Background_Color_Launcher
		;Server Options

	iniWrite, C:\NeverwinterNights\NWN,DCLconfig.ini,Server Options, GameDirectory
	iniWrite, C:\NeverwinterNights\NWN\dialog.tlk,DCLconfig.ini,Server Options, CurrentTlk
	iniWrite, C:\NeverwinterNights\NWN\dialog_backup.tlk,DCLconfig.ini,Server Options, LastTlk
	iniWrite, C:\NeverwinterNights\NWN\override,DCLconfig.ini,Server Options, CurrentOverrideDirectory
	iniWrite, 0,DCLconfig.ini,Server Options, EnableLogging
	iniWrite, 1,DCLconfig.ini,Server Options, TlkSwapFirstTime
	FormatTime,timestamp,,MMMM d, yyyy [hmm tt]
	iniWrite,%timestamp%,DCLconfig.ini,Server Options, CurrentLogDate
	iniWrite, 0,DCLconfig.ini,Server Options, PersistantLauncher
	iniWrite,http://cep.hgweb.org/man/cep.txt,DCLconfig.ini,Server Options, CEPUpdateLink
	
	Loop, 5    ;Write info for each of 5 servers
	{
	iniWrite, %A_SPACE%,DCLconfig.ini,Server %A_Index%, Name
	iniWrite, %A_SPACE%,DCLconfig.ini,Server %A_Index%, IPAddress
	iniWrite, %A_SPACE%,DCLconfig.ini,Server %A_Index%, Password
	iniWrite, %A_SPACE%,DCLconfig.ini,Server %A_Index%, DMPassword
	iniWrite, %A_SPACE%,DCLconfig.ini,Server %A_Index%, Banner
	iniWrite, %A_SPACE%,DCLconfig.ini,Server %A_Index%, ServerURL
	}	
	;Default Chat Colors
	iniWrite,240`,240`,240, DCLconfig.ini,Default Chat Colors, TalkColor
	iniWrite,255`,239`,80, DCLconfig.ini,Default Chat Colors, ShoutColor
	iniWrite,128`,128`,128, DCLconfig.ini,Default Chat Colors, WhipserColor
	iniWrite,32`,255`,32, DCLconfig.ini,Default Chat Colors, TellColor
	iniWrite,176`,176`,176, DCLconfig.ini,Default Chat Colors, ServerColor
	iniWrite,240`,240`,240, DCLconfig.ini,Default Chat Colors, PartyColor
	iniWrite,16`,223`,255, DCLconfig.ini,Default Chat Colors, DMColor
	return
}
;===========================================================-------------------------===========
;                                                                RenameLogFile()     <----------*****
;===========================================================-------------------------===========
RenameLogFile()
{
	global NWN_DIR
;Rename log file to last timestamp stored.
iniRead,timestamp,DCLconfig.ini,Server Options,CurrentLogDate,%timestamp%
iniWrite,1,%NWN_DIR%\nwnplayer.ini,Game Options,ClientEntireChatWindowLogging


loop, 5
{

	if fileexist(NWN_DIR . "\logs\nwclientLog" . A_Index . ".txt")
	{
		FileGetSize, logsize,%NWN_DIR%\logs\nwclientLog%A_Index%.txt
		if (logsize > 0) ;Only copy the log if it's size is greater then 0 bytes
		{
			filecopy,%NWN_DIR%\logs\nwclientLog1.txt,%NWN_DIR%\logs\%timestamp%(%A_Index%).txt			
		}
	}
}

if fileexist(NWN_DIR . "\logs.0\nwserverLog1.txt")
{
	FileGetSize, logsize,%NWN_DIR%\logs.0\nwserverLog1.txt
	if (logsize > 0) ;Only copy the log if it's size is greater then 0 bytes
	{
		filecopy,%NWN_DIR%\logs\nwserverLog1.txt,%NWN_DIR%\logs.0\%timestamp%.txt			
	}
}
;Store the current timestamp
	FormatTime,timestamp,,MMMM d, yyyy [hmm tt]
	iniWrite,%timestamp%,DCLconfig.ini,Server Options, CurrentLogDate
Return
}
;===========================================================-------------------------===========
;                                                             Convert_RGB_to_Dec(RGB)  <----------*****
;===========================================================-------------------------===========
Convert_RGB_to_Dec(RGB)
{
	StringSplit, ColorArray, RGB, `,

	RGB := ColorArray3 * 65536 + ColorArray2 * 256 + ColorArray1
	return RGB
}
;===========================================================-------------------------===========
;                                                             Convert_RGB_from_Dec(red,green,blue)  <----------*****
;===========================================================-------------------------===========
Convert_RGB_from_Dec(RGB)
{
	
 	blue := floor(RGB / 65536)
	green := floor((RGB - blue * 65536) / 256)
	red :=  floor(RGB - blue * 65536 - green * 256)

	RGB := red . "," . green . "," . blue
	return RGB
}
;===========================================================-------------------------===========
;                                                             Convert_RGB_to_Hex(rgb)  <----------*****
;===========================================================-------------------------===========
Convert_RGB_to_Hex(RGB)
{
	
	StringSplit, ColorArray, RGB, `,

	clr := ColorArray3 * 65536 + ColorArray2 * 256 + ColorArray1
	
    oldFormat := A_FormatInteger 
    SetFormat, integer, hex  ; Show RGB color extracted below in hex format. 
 ;convert to rgb 
    RGB := (clr & 0xff00) + ((clr & 0xff0000) >> 16) + ((clr & 0xff) << 16) 
    StringTrimLeft, RGB, RGB, 2 
    loop, % 6-strlen(RGB) 
		RGB=0%RGB% 
    RGB=%RGB% 
    SetFormat, integer, %oldFormat%
	return RGB
}
;===========================================================-------------------------===========
;                                                             Convert_RGB_from_Hex(rgb)  <----------*****
;===========================================================-------------------------===========
Convert_RGB_from_Hex(RGB)
{
    clr := ((RGB & 0xFF) << 16) + (RGB & 0xFF00) + ((RGB >> 16) & 0xFF)
 	blue := floor(clr / 65536)
	green := floor((clr - blue * 65536) / 256)
	red :=  floor(clr - blue * 65536 - green * 256)
	RGB := red . "," . green . "," . blue
	return RGB
}
;===========================================================-------------------------===========
;                                                             Dlg_Color(color,hgui)  <----------*****
;===========================================================-------------------------===========
Dlg_Color(ByRef Color, hGui=0){ 
  ;covert from rgb
    clr := ((Color & 0xFF) << 16) + (Color & 0xFF00) + ((Color >> 16) & 0xFF)

    VarSetCapacity(CHOOSECOLOR, 0x24, 0), VarSetCapacity(CUSTOM, 64, 0)
     ,NumPut(0x24,		CHOOSECOLOR, 0)      ; DWORD lStructSize 
     ,NumPut(hGui,		CHOOSECOLOR, 4)      ; HWND hwndOwner (makes dialog "modal"). 
     ,NumPut(clr,		CHOOSECOLOR, 12)     ; clr.rgbResult 
     ,NumPut(&CUSTOM,	CHOOSECOLOR, 16)     ; COLORREF *lpCustColors
     ,NumPut(0x00000103,CHOOSECOLOR, 20)     ; Flag: CC_ANYCOLOR || CC_RGBINIT 

    nRC := DllCall("comdlg32\ChooseColorA", str, CHOOSECOLOR)  ; Display the dialog. 
    if (errorlevel <> 0) || (nRC = 0) 
       return  false 

    clr := NumGet(CHOOSECOLOR, 12) 

    oldFormat := A_FormatInteger 
    SetFormat, integer, hex  ; Show RGB color extracted below in hex format. 

	;convert to rgb 
    Color := (clr & 0xff00) + ((clr & 0xff0000) >> 16) + ((clr & 0xff) << 16) 
    StringTrimLeft, Color, Color, 2 
    loop, % 6-strlen(Color) 
		Color=0%Color% 
    Color=%Color% 
    SetFormat, integer, %oldFormat% 
	return true

}
;===================================================================-------------------------------------------===========
;                                                                    Dlg_Font(font,style,color,boolean,hgui)   <----------*****
;===================================================================-------------------------------------------===========
Dlg_Font(ByRef Name, ByRef Style, ByRef Color, Effects=true, hGui=0) {

   LogPixels := DllCall("GetDeviceCaps", "uint", DllCall("GetDC", "uint", hGui), "uint", 90)	;LOGPIXELSY
   VarSetCapacity(LOGFONT, 128, 0)

   Effects := 0x041 + (Effects ? 0x100 : 0)  ;CF_EFFECTS = 0x100, CF_SCREENFONTS=1, CF_INITTOLOGFONTSTRUCT = 0x40

   ;set initial name
   DllCall("RtlMoveMemory", "uint", &LOGFONT+28, "Uint", &Name, "Uint", 32)

   ;convert from rgb  
   clr := ((Color & 0xFF) << 16) + (Color & 0xFF00) + ((Color >> 16) & 0xFF) 

   ;set intial data
   if InStr(Style, "bold")
      NumPut(700, LOGFONT, 16)

   if InStr(Style, "italic")
      NumPut(255, LOGFONT, 20, 1)

   if InStr(Style, "underline")
      NumPut(1, LOGFONT, 21, 1)
   
   if InStr(Style, "strikeout")
      NumPut(1, LOGFONT, 22, 1)

   if RegExMatch(Style, "s[1-9][0-9]*", s){
      StringTrimLeft, s, s, 1      
      s := -DllCall("MulDiv", "int", s, "int", LogPixels, "int", 72)
      NumPut(s, LOGFONT, 0, "Int")			; set size
   }
   else  NumPut(16, LOGFONT, 0)         ; set default size

   VarSetCapacity(CHOOSEFONT, 60, 0)
    ,NumPut(60,		 CHOOSEFONT, 0)		; DWORD lStructSize
    ,NumPut(hGui,    CHOOSEFONT, 4)		; HWND hwndOwner (makes dialog "modal").
    ,NumPut(&LOGFONT,CHOOSEFONT, 12)	; LPLOGFONT lpLogFont
    ,NumPut(Effects, CHOOSEFONT, 20)	
    ,NumPut(clr,	 CHOOSEFONT, 24)	; rgbColors

   r := DllCall("comdlg32\ChooseFontA", "uint", &CHOOSEFONT)  ; Display the dialog.
   if !r
      return false

  ;font name
	VarSetCapacity(Name, 32)
	DllCall("RtlMoveMemory", "str", Name, "Uint", &LOGFONT + 28, "Uint", 32)
	Style := "s" NumGet(CHOOSEFONT, 16) // 10

  ;color
	old := A_FormatInteger
	SetFormat, integer, hex                      ; Show RGB color extracted below in hex format.
	Color := NumGet(CHOOSEFONT, 24)
	SetFormat, integer, %old%

  ;styles
	Style =
	VarSetCapacity(s, 3)
	DllCall("RtlMoveMemory", "str", s, "Uint", &LOGFONT + 20, "Uint", 3)

	if NumGet(LOGFONT, 16) >= 700
	  Style .= "bold "

	if NumGet(LOGFONT, 20, "UChar")
      Style .= "italic "
   
	if NumGet(LOGFONT, 21, "UChar")
      Style .= "underline "

	if NumGet(LOGFONT, 22, "UChar")
      Style .= "strikeout "

	s := NumGet(LOGFONT, 0, "Int")
	Style .= "s" Abs(DllCall("MulDiv", "int", abs(s), "int", 72, "int", LogPixels))

 ;convert to rgb 
	oldFormat := A_FormatInteger 
    SetFormat, integer, hex  ; Show RGB color extracted below in hex format. 

    Color := (Color & 0xff00) + ((Color & 0xff0000) >> 16) + ((Color & 0xff) << 16) 
    StringTrimLeft, Color, Color, 2 
    loop, % 6-strlen(Color) 
		Color=0%Color% 
    Color=%Color% 
    SetFormat, integer, %oldFormat% 

   return 1
}
;=============================-------------------------------===========
;                                   SetChatColors            ===========
;=============================-------------------------------===========
SetChatColors()
{
	global
	Gui, Font,c%TalkColor%
	GuiControl, Font, Talk_color
	Gui, Font,c%ShoutColor%
	GuiControl, Font, Shout_color
	Gui, Font,c%WhisperColor%
	GuiControl, Font, Whisper_color
	Gui, Font,c%TellColor%
	GuiControl, Font, Tell_color
	Gui, Font,c%ServerColor%
	GuiControl, Font, Server_color
	Gui, Font,c%PartyColor%
	GuiControl, Font, Party_color
	Gui, Font,c%DMColor%
	GuiControl, Font, DM_color
	Gui, Font,c%TalkColor%
	GuiControl, Font, Talk_color
	Gui, Font,c%ShoutColor%
	GuiControl, Font, Shout_color
	Gui, Font,c%WhisperColor%
	GuiControl, Font, Whisper_color
	Gui, Font,c%TellColor%
	GuiControl, Font, Tell_color
	Gui, Font,c%ServerColor%
	GuiControl, Font, Server_color
	Gui, Font,c%PartyColor%
	GuiControl, Font, Party_color
	Gui, Font,c%DMColor%
	GuiControl, Font, DM_color
	Return
}	
;============================================================-------------------------===========
;                                                                Read_Nwnplayer(Type) ===========
;============================================================-------------------------===========
Read_Nwnplayer(Type)
{
	Global
	
	if (Type == 0)
	{
	IniRead,TalkColor,DCLconfig.ini,Default Chat Colors,TalkColor,240`,240`,240
	IniRead,ShoutColor,DCLconfig.ini,Default Chat Colors,ShoutColor,255`,239`,80
	IniRead,WhisperColor,DCLconfig.ini,Default Chat Colors,WhisperColor,128`,128`,128
	IniRead,TellColor,DCLconfig.ini,Default Chat Colors,TellColor,32`,255`,32
	IniRead,ServerColor,DCLconfig.ini,Default Chat Colors,ServerColor,176`,176`,176
	IniRead,PartyColor,DCLconfig.ini,Default Chat Colors,PartyColor,240`,240`,240
	IniRead,DMColor,DCLconfig.ini,Default Chat Colors,DMColor,16`,223`,255			
	}
	else if (Type == 1)
	{
	IniRead,TalkColor,%NWN_DIR%\nwnplayer.ini,Chat Colors,TalkColor
	IniRead,ShoutColor,%NWN_DIR%\nwnplayer.ini,Chat Colors,ShoutColor
	IniRead,WhisperColor,%NWN_DIR%\nwnplayer.ini,Chat Colors,WhisperColor
	IniRead,TellColor,%NWN_DIR%\nwnplayer.ini,Chat Colors,TellColor
	IniRead,ServerColor,%NWN_DIR%\nwnplayer.ini,Chat Colors,ServerColor
	IniRead,PartyColor,%NWN_DIR%\nwnplayer.ini,Chat Colors,PartyColor
	IniRead,DMColor,%NWN_DIR%\nwnplayer.ini,Chat Colors,DMColor	
	return true
	}
	else if (Type == 2)
	{
	IniRead,FriendlyColor,%NWN_DIR%\nwnplayer.ini,Trap Colors,FriendlyColor
	IniRead,HostileColor,%NWN_DIR%\nwnplayer.ini,Trap Colors,HostileColor		
	}
return
}
;============================================================-------------------------===========
;                                                                Zip/Unzip            ===========
;============================================================-------------------------===========
Zip(sDir, sZip) 
{ 
   If Not FileExist(sZip) 
   { 
      VarSetCapacity(Header, 22, 0) 
      Header := "PK" . Chr(5) . Chr(6) 
      ReadMemory(sZip, &Header, 22) 
   } 
   psh  := COM_ActiveXObject("Shell.Application") 
   pzip := COM_Invoke(psh, "Namespace", sZip) 
   COM_Invoke(pzip, "CopyHere", sDir, 4|16) 
   Sleep,   1000 
   COM_Release(pzip) 
   COM_Release(psh) 
} 

Unz(sZip, sUnz) 
{ 
   psh  := COM_ActiveXObject("Shell.Application") 
   pzip := COM_Invoke(psh, "Namespace", sZip) 
   punz := COM_Invoke(psh, "Namespace", sUnz) 
   pitms:= COM_Invoke(pzip, "Items") 
   COM_Invoke(punz, "CopyHere", "+" . pitms, 4|16) 
   Sleep,   1000 
   COM_Release(pitms) 
   COM_Release(pzip) 
   COM_Release(punz) 
   COM_Release(psh) 
}