;===========================================
; Neverwinter Nights DC Launcher Functions
; NwnDCLFunctions.ahk
; Author: Alundaio
;===========================================
;Updated Zip/Unzip and EmptyMem() functions for AHK_L
;========================================--------------------------------==========
;                                          DirectConnect(ServerNumber)   <---------*****
;========================================--------------------------------==========
DirectConnect(ServerNumber)
{
  Global
    local Params, Pass, ConnectToIP,

    if (NWNCxLauncher == 0)
      EXECUTEABLE = nwmain.exe
    else
      EXECUTEABLE = NWNCX_Loader.exe

    ;Collect EnableDM checkbox info
    Gui, 1: submit, nohide

    ;Setup and Run nwmain.exe with params
    If (EnableLogging == 1)
    {
      RenameLogFile()
    }

    If (EnableDM%ServerNumber% == 1)
    {
      Params = %Params%%EXECUTEABLE% -dmc
    }
  
    ConnectToIP := ServerIP%ServerNumber%
    Params = %Params%%EXECUTEABLE% +connect %ConnectToIP%

    If (EnableDM%ServerNumber% == 1)
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

    Run, %Params%, %NWN_DIR%
  
    If (PersistantLauncher == 0)
    {
      ExitApp
    }
}
;===========================================================-------------------------------===========
;                                                             Picture Buttons <----------*****
;===========================================================-------------------------------===========
AddPictureButton(VariableName, ImgPath, Options="", SecondaryOptions="") 
{
  Global
    Gui, 1: Add, Picture, v%VariableName%state1 %Options%,%ImgPath%_1.ico
    Gui, 1: Add, Picture, v%VariableName%state0 hwnd%VariableName%_hwnd %SecondaryOptions%,%ImgPath%.ico
    %VariableName%_timer = 5
  Return
}
;===========================================================-------------------------===========
;                                                                ReadLanguage()     <----------*****
;===========================================================-------------------------===========
ReadLanguage()
{
  Global
    IniRead, IniLangChoosen, language.ini, CHOOSEN, DCLanguagesChoosen, ENGLISH
    
    IniRead, LogInAsDMText, language.ini, %IniLangChoosen%, LogInAsDMText, DM
    
    IniRead, CheckUpdateText, language.ini, %IniLangChoosen%, CheckUpdateText, Check for updates
    IniRead, ShowAboutText, language.ini, %IniLangChoosen%, ShowAboutText, About

    IniRead, OptionsTabsText, language.ini, %IniLangChoosen%, OptionsTabsText, Server Settings|Banner Options|Configuration|Game Options
    IniRead, ServerSettingsTabText, language.ini, %IniLangChoosen%, ServerSettingsTabText, Server Settings
    IniRead, BannerOptionsTabText, language.ini, %IniLangChoosen%, BannerOptionsTabText, Banner Options
    IniRead, ConfigurationTabText, language.ini, %IniLangChoosen%, ConfigurationTabText, Configuration
    IniRead, GameOptionsTabText, language.ini, %IniLangChoosen%, GameOptionsTabText, Game Options

    IniRead, ServerNameText, language.ini, %IniLangChoosen%, ServerNameText, Server Name
    IniRead, ServerIPaddressText, language.ini, %IniLangChoosen%, ServerIPaddressText, Server IP address
    IniRead, ServerPasswordText, language.ini, %IniLangChoosen%, ServerPasswordText, Server Password
    IniRead, DMPasswordText, language.ini, %IniLangChoosen%, DMPasswordText, DM Password
    IniRead, BannerText, language.ini, %IniLangChoosen%, BannerText, Banner

    IniRead, BannerOnClickURLText, language.ini, %IniLangChoosen%, BannerOnClickURLText, Banner On-Click URL
    IniRead, ServerBannerLinkText, language.ini, %IniLangChoosen%, ServerBannerLinkText, Server
    IniRead, BannersButtonText, language.ini, %IniLangChoosen%, BannersButtonText, Banners
    
    IniRead, OptionsText, language.ini, %IniLangChoosen%, OptionsText, Options
	  IniRead, LogRotating, language.ini, %IniLangChoosen%, LogRotating, Log rotating
	  IniRead, OtherLogLblRotator, language.ini, %IniLangChoosen%, OtherLogLblRotator, Use other Log-Rotator
	  IniRead, MsgFailedOtherLogRotator, language.ini, %IniLangChoosen%, MsgFailedOtherLogRotator, Please select a program for log-rotation.
    IniRead, EnableLogRenamingLblText, language.ini, %IniLangChoosen%, EnableLogRenamingLblText, Enable Log Renaming
    IniRead, PersistantLauncherLblText, language.ini, %IniLangChoosen%, PersistantLauncherLblText, Persistant Launcher
    IniRead, NWNCXLauncherCBText, language.ini, %IniLangChoosen%, NWNCXLauncherCBText, NWNCX Launcher
    IniRead, NWNxCFileNameText, language.ini, %IniLangChoosen%, NWNxCFileNameText, NWNxC File
    IniRead, NWNTXLauncherCBText, language.ini, %IniLangChoosen%, NWNTXLauncherCBText, NWNTX Launcher
    IniRead, NWNxTFileNameText, language.ini, %IniLangChoosen%, NWNxTFileNameText, NWNxT File
    IniRead, LogsButtonText, language.ini, %IniLangChoosen%, LogsButtonText, Logs
    IniRead, ConfigRunText, language.ini, %IniLangChoosen%, ConfigRunText, Conf/Run
    IniRead, LogRotatingConfig, language.ini, %IniLangChoosen%, LogRotatingConfig, Config DC-Log Rotator

    IniRead, GameDirectoryGBText, language.ini, %IniLangChoosen%, GameDirectoryGBText, Game Directory
    IniRead, BrowseButtonText, language.ini, %IniLangChoosen%, BrowseButtonText, Browse
    IniRead, CurrentOverrideDirectoryGBText, language.ini, %IniLangChoosen%, CurrentOverrideDirectoryGBText, Current Override Directory
    IniRead, SwapOverrideButtonText, language.ini, %IniLangChoosen%, SwapOverrideButtonText, Swap Override
    IniRead, SwapSialogTlkFileGBText, language.ini, %IniLangChoosen%, SwapSialogTlkFileGBText, Swap dialog.tlk File
    IniRead, SwapDialogFileButtonText, language.ini, %IniLangChoosen%, SwapDialogFileButtonText, Swap dialog.tlk

    IniRead, GuiOptionsGBText, language.ini, %IniLangChoosen%, GuiOptionsGBText, Gui Options
    IniRead, GuiFontButtonText, language.ini, %IniLangChoosen%, GuiFontButtonText, Font
    IniRead, GuiBackgroundColorGBText, language.ini, %IniLangChoosen%, GuiBackgroundColorGBText, Gui Background Color
    IniRead, GuiOptionsButtonText, language.ini, %IniLangChoosen%, GuiOptionsButtonText, Options
    IniRead, GuiLauncherButtonText, language.ini, %IniLangChoosen%, GuiLauncherButtonText, Launcher    
    IniRead, GuiWindowNameText, language.ini, %IniLangChoosen%, GuiWindowNameText, Server Options
    IniRead, DCLanguagesText, language.ini, %IniLangChoosen%, DCLanguagesText, Choose language
    
    IniRead, ChatColorsGBText, language.ini, %IniLangChoosen%, ChatColorsGBText, Chat Colors
    IniRead, ChatColorsUndoButtonText, language.ini, %IniLangChoosen%, ChatColorsUndoButtonText, Undo
    IniRead, ChatColorsExampleText, language.ini, %IniLangChoosen%, ChatColorsExampleText, Example
    IniRead, ChatColorsTalkButtonText, language.ini, %IniLangChoosen%, ChatColorsTalkButtonText, Talk
    IniRead, ChatColorsShoutButtonText, language.ini, %IniLangChoosen%, ChatColorsShoutButtonText, Shout
    IniRead, ChatColorsWhisperButtonText, language.ini, %IniLangChoosen%, ChatColorsWhisperButtonText, Whisper
    IniRead, ChatColorsTellButtonText, language.ini, %IniLangChoosen%, ChatColorsTellButtonText, Tell
    IniRead, ChatColorsServerButtonText, language.ini, %IniLangChoosen%, ChatColorsServerButtonText, Server
    IniRead, ChatColorsPartyButtonText, language.ini, %IniLangChoosen%, ChatColorsPartyButtonText, Party
    IniRead, ChatColorsDMButtonText, language.ini, %IniLangChoosen%, ChatColorsDMButtonText, DM
    IniRead, ChatColorsDefaultsButtonText, language.ini, %IniLangChoosen%, ChatColorsDefaultsButtonText, Defaults
    
    IniRead, TrapColorsGBText, language.ini, %IniLangChoosen%, TrapColorsGBText, Trap Colors
    IniRead, TrapColorsFriendButtonText, language.ini, %IniLangChoosen%, TrapColorsFriendButtonText, Friendly
    IniRead, TrapColorsHostileButtonText, language.ini, %IniLangChoosen%, TrapColorsHostileButtonText, Hostile
    
    IniRead, MsgBoxUpdateAvailable, language.ini, %IniLangChoosen%, MsgBoxUpdateAvailable, There is an update available! Would you like to download it? Please remember to vote. Thanks!
    IniRead, MsgBoxUpdateDownloaded, language.ini, %IniLangChoosen%, MsgBoxUpdateDownloaded, Update sucessfully downloaded, please navigate to the folder "%A_WorkingDir%\update" and close DC Launcher. Please remember to delete the update-folder after sucessful upgrade!
    IniRead, MsgBoxUpdateFailed, language.ini, %IniLangChoosen%, MsgBoxUpdateFailed, Failed. Download manually at https://neverwintervault.org/project/nwn1/other/tool/nwn-1-direct-connect-launcher
    IniRead, MsgBoxUpdateNoAvailable, language.ini, %IniLangChoosen%, MsgBoxUpdateNoAvailable, No update available.
    
    IniRead, MsgBoxBrowseOverride, language.ini, %IniLangChoosen%, MsgBoxBrowseOverride, You didn't select a folder.
    
    IniRead, MsgBoxBrowseFile, language.ini, %IniLangChoosen%, MsgBoxBrowseFile, You didn't select anything.
    
    IniRead, MsgBoxStartNWNcX, language.ini, %IniLangChoosen%, MsgBoxStartNWNcX, Loading NWNCX... Stay tuned! Remember to start NWN DC Launcher with admin-rigths
    IniRead, MsgBoxStartNWNtX, language.ini, %IniLangChoosen%, MsgBoxStartNWNtX, Loading NWNTX... Stay tuned!
    
    IniRead, MsgBoxSwapSuccess, language.ini, %IniLangChoosen%, MsgBoxSwapSuccess, Swapping successful.
    IniRead, MsgBoxSwapOverrideError, language.ini, %IniLangChoosen%, MsgBoxSwapOverrideError, Nwn.ini could not be written to (Check If readonly).
    IniRead, MsgBoxSwapOverrideOther, language.ini, %IniLangChoosen%, MsgBoxSwapOverrideOther, That folder does not exist.
    
    IniRead, MsgBoxSwapTlkBackUpFail, language.ini, %IniLangChoosen%, MsgBoxSwapTlkBackUpFail, A backup of the dialog.tlk could not be created (It may already exist).
    IniRead, MsgBoxSwapTlkBackUpSuccess, language.ini, %IniLangChoosen%, MsgBoxSwapTlkBackUpSuccess, A backup of the dialog.tlk was created (dialog_backup.tlk).
    IniRead, MsgBoxRenameTlkFail, language.ini, %IniLangChoosen%, MsgBoxRenameTlkFail, %TLK_DIR% could not be renamed to %TLK_DEFAULT%.
    IniRead, MsgBoxRenameTlkOther, language.ini, %IniLangChoosen%, MsgBoxRenameTlkOther, The dialog.tlk does not exist.
    
    IniRead, MsgBoxSwapTlkFileExists, language.ini, %IniLangChoosen%, MsgBoxSwapTlkFileExists, The dialog.tlk could not be swapped. A file with it's stored name already exists.
    IniRead, MsgBoxSwapTlkBackUpExists, language.ini, %IniLangChoosen%, MsgBoxSwapTlkBackUpExists, A backup of the dialog.tlk could not be created (It may already exist).
    IniRead, MsgBoxSwapTlkNewError, language.ini, %IniLangChoosen%, MsgBoxSwapTlkNewError, The new dialog.tlk could not be created.
  Return
}
;===========================================================-------------------------===========
;                                                                ReadDCLConfig()     <----------*****
;===========================================================-------------------------===========
ReadDCLConfig()
{
  Global
  ;Languages
  IniRead, DCLanguagesOptions, language.ini, CHOOSEN, DCLanguagesOptions, ENGLISH|GERMAN|
  IniRead, DCLanguagesChoosen, language.ini, CHOOSEN, DCLanguagesChoosen, ENGLISH
  
  ;Version
  IniRead, VERSION, DCLconfig.ini, Main, Version, 1
  
  ; Gui Options
  IniRead, FONT_STYLE, DCLconfig.ini, Gui Options, Font_Style, 9
  IniRead, FONT_TYPE, DCLconfig.ini, Gui Options, Font_Type, MS Sans SerIf
  IniRead, FONT_COLOR, DCLconfig.ini, Gui Options, Font_Color, 000000
  IniRead, BACKGROUND_COLOR_OPTIONS, DCLconfig.ini, Gui Options, Background_Color_Options, d6d6d6
  IniRead, BACKGROUND_COLOR_LAUNCHER, DCLconfig.ini, Gui Options, Background_Color_Launcher, 000000

  ;Server Options
  FormatTime, timestamp, , MMMM d, yyyy [h mm tt]
  IniRead, NBR_SERVERS, DCLconfig.ini, Server Options, NBR_SERVERS, 5
  IniRead, NWN_DIR, DCLconfig.ini, Server Options, GameDirectory, C:\NeverwinterNights\NWN
  IniRead, OVR_DIR, DCLconfig.ini, Server Options, CurrentOverrideDirectory, C:\NeverwinterNights\NWN\override
  IniRead, TLK_DIR, DCLconfig.ini, Server Options, CurrentTlk, C:\NeverwinterNights\NWN\dialog.tlk
  IniRead, TLK_DIR_LAST, DCLconfig.ini, Server Options, LastTlk, C:\NeverwinterNights\NWN\dialog_backup.tlk
  IniRead, EnableLogging, DCLconfig.ini, Server Options, EnableLogging, 0
  IniRead, OtherLogRotator, DCLconfig.ini, Server Options, OtherLogRotator, -
  IniRead, timestamp, DCLconfig.ini, Server Options, CurrentLogDate, %timestamp%
  IniRead, PersistantLauncher, DCLconfig.ini, Server Options, PersistantLauncher, 0
  IniRead, CEPUpdateLink, DCLconfig.ini, Server Options, CEPUpdateLink, https://neverwintervault.org/cep

  ;ExtenderVersions
  IniRead, NWNCxLauncher, DCLconfig.ini, NWNxLauncher, NWNCxLauncher, 1
  IniRead, NWNCxFile, DCLconfig.ini, NWNxLauncher, NWNCxFile, NWNCX Loader.exe
  IniRead, NWNTxLauncher, DCLconfig.ini, NWNxLauncher, NWNTxLauncher, 1
  IniRead, NWNTxFile, DCLconfig.ini, NWNxLauncher, NWNTxFile, NWNTX_Loader.exe

  Loop, 10
  {
    IniRead, ServerName%A_Index%, DCLconfig.ini, Server %A_Index%, Name, ""
    IniRead, ServerIP%A_Index%, DCLconfig.ini, Server %A_Index%, IPAddress, ""
    IniRead, ServerPassword%A_Index%, DCLconfig.ini, Server %A_Index%, Password, ""
    IniRead, ServerDMPassword%A_Index%, DCLconfig.ini, Server %A_Index%, DMPassword, ""
    IniRead, ServerBanner%A_Index%, DCLconfig.ini, Server %A_Index%, Banner, ""
    IniRead, ServerURL%A_Index%, DCLconfig.ini, Server %A_Index%, ServerURL, ""
  }

  If VERSION != CURRENT_VERSION
  {
    ;Check config for current version and update/add necessary keys
    If VERSION < 1.10
    {
      IniWrite, 240`,240`,240, DCLconfig.ini, Default Chat Colors, TalkColor
      IniWrite, 255`,239`,80, DCLconfig.ini, Default Chat Colors, ShoutColor
      IniWrite, 128`,128`,128, DCLconfig.ini ,Default Chat Colors, WhipserColor
      IniWrite, 32`,255`,32, DCLconfig.ini, Default Chat Colors, TellColor
      IniWrite, 176`,176`,176, DCLconfig.ini, Default Chat Colors, ServerColor
      IniWrite, 240`,240`,240, DCLconfig.ini, Default Chat Colors, PartyColor
      IniWrite, 16`,223`,255, DCLconfig.ini, Default Chat Colors, DMColor
    }
    If VERSION < 1.11
    {
      FileDelete, DCLdata\images.dll
    }

    ;Set Version
    IniWrite, %CURRENT_VERSION%, DCLconfig.ini, Main, Version
  }
  Return
}
;===========================================================-------------------------===========
;                                                                CreateDCLConfig()     <----------*****
;===========================================================-------------------------===========
CreateDCLConfig()
{
  ;Main
  IniWrite, %CURRENT_VERSION%, DCLconfig.ini, Main, Version

  ;Languages
  IniWrite, ENGLISH|GERMAN, language.ini, CHOOSEN, DCLanguagesOptions
  IniWrite, ENGLISH, language.ini, CHOOSEN, DCLanguagesChoosen
  
  ;Gui Options
  IniWrite, 9, DCLconfig.ini, Gui Options, Font_Style
  IniWrite, MS Sans Serif, DCLconfig.ini, Gui Options, Font_Type
  IniWrite, 000000, DCLconfig.ini, Gui Options, Font_Color
  IniWrite, d6d6d6, DCLconfig.ini, Gui Options, Background_Color_Options
  IniWrite, 000000, DCLconfig.ini, Gui Options, Background_Color_Launcher
  
  ;Server Options
  IniWrite, 5, DCLconfig.ini, Server Options, NBR_SERVERS
  IniWrite, C:\NeverwinterNights\NWN, DCLconfig.ini, Server Options, GameDirectory
  IniWrite, C:\NeverwinterNights\NWN\dialog.tlk, DCLconfig.ini, Server Options, CurrentTlk
  IniWrite, C:\NeverwinterNights\NWN\dialog_backup.tlk, DCLconfig.ini, Server Options, LastTlk
  IniWrite, C:\NeverwinterNights\NWN\override, DCLconfig.ini, Server Options, CurrentOverrideDirectory
  IniWrite, 0, DCLconfig.ini, Server Options, EnableLogging
  IniWrite, -, DCLconfig.ini, Server Options, OtherLogRotator
  IniWrite, 1, DCLconfig.ini, Server Options, TlkSwapFirstTime
  FormatTime, timestamp, , MMMM d, yyyy [hmm tt]
  IniWrite, %timestamp%, DCLconfig.ini, Server Options, CurrentLogDate
  IniWrite, 0, DCLconfig.ini, Server Options, PersistantLauncher
  IniWrite, https://neverwintervault.org/cep , DCLconfig.ini, Server Options, CEPUpdateLink
  
  ;ExtenderVersions
  IniWrite, 1, DCLconfig.ini, NWNCxLauncher, NWNCxLauncher
  IniWrite, NWNCX Loader.exe, DCLconfig.ini, NWNCxFile, NWNCxFile
  IniWrite, 1, DCLconfig.ini, NWNTxLauncher, NWNTxLauncher
  IniWrite, NWNTX_Loader.exe, DCLconfig.ini, NWNTxFile, NWNTxFile
  
  ;Write info for each of 5 servers
  Loop, 10
  {
    IniWrite, %A_SPACE%, DCLconfig.ini, Server %A_Index%, Name
    IniWrite, %A_SPACE%, DCLconfig.ini, Server %A_Index%, IPAddress
    IniWrite, %A_SPACE%, DCLconfig.ini, Server %A_Index%, Password
    IniWrite, %A_SPACE%, DCLconfig.ini, Server %A_Index%, DMPassword
    IniWrite, %A_SPACE%, DCLconfig.ini, Server %A_Index%, Banner
    IniWrite, %A_SPACE%, DCLconfig.ini, Server %A_Index%, ServerURL
  }  
  
  ;Default Chat Colors
  IniWrite, 240`,240`,240, DCLconfig.ini, Default Chat Colors, TalkColor
  IniWrite, 255`,239`,80, DCLconfig.ini, Default Chat Colors, ShoutColor
  IniWrite, 128`,128`,128, DCLconfig.ini, Default Chat Colors, WhipserColor
  IniWrite, 32`,255`,32, DCLconfig.ini, Default Chat Colors, TellColor
  IniWrite, 176`,176`,176, DCLconfig.ini, Default Chat Colors, ServerColor
  IniWrite, 240`,240`,240, DCLconfig.ini, Default Chat Colors, PartyColor
  IniWrite, 16`,223`,255, DCLconfig.ini, Default Chat Colors, DMColor
  
  Return
}
;===========================================================-------------------------===========
;                                                                RenameLogFile()     <----------*****
;===========================================================-------------------------===========
RenameLogFile()
{
  Global NWN_DIR
  ;Rename log file to last timestamp stored.
  IniRead, timestamp, DCLconfig.ini, Server Options, CurrentLogDate, %timestamp%
  IniWrite, 1, %NWN_DIR%\nwnplayer.ini, Game Options, ClientEntireChatWindowLogging

  Loop, 5
  {
    If FileExist(NWN_DIR . "\logs\nwclientLog" . A_Index . ".txt")
    {
      FileGetSize, logsize, %NWN_DIR%\logs\nwclientLog%A_Index%.txt
      ;Only copy the log If it's size is greater then 0 bytes
      If (logsize > 0)
      {
        FileCopy, %NWN_DIR%\logs\nwclientLog1.txt, %NWN_DIR%\logs\%timestamp%(%A_Index%).txt
      }
    }
  }

  If FileExist(NWN_DIR . "\logs.0\nwserverLog1.txt")
  {
    FileGetSize, logsize,%NWN_DIR%\logs.0\nwserverLog1.txt
    ;Only copy the log If it's size is greater then 0 bytes
    If (logsize > 0)
    {
      FileCopy, %NWN_DIR%\logs\nwserverLog1.txt, %NWN_DIR%\logs.0\%timestamp%.txt
    }
  }
  
  ;Store the current timestamp
  FormatTime, timestamp, , MMMM d, yyyy [h mm tt]
  IniWrite, %timestamp%, DCLconfig.ini, Server Options, CurrentLogDate
  Return
}
;===========================================================-------------------------===========
;                                                             Convert_RGB_to_Dec(RGB)  <----------*****
;===========================================================-------------------------===========
Convert_RGB_to_Dec(RGB)
{
  StringSplit, ColorArray, RGB, `,

  RGB := ColorArray3 * 65536 + ColorArray2 * 256 + ColorArray1
  Return RGB
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
  Return RGB
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
    Loop, % 6-strlen(RGB) 
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
;                                                             Dlg_Color(color,hGui)  <----------*****
;===========================================================-------------------------===========
Dlg_Color(ByRef Color, hGui=0){ 
  ;covert from rgb
    clr := ((Color & 0xFF) << 16) + (Color & 0xFF00) + ((Color >> 16) & 0xFF)

    VarSetCapacity(CHOOSECOLOR, 0x24, 0), VarSetCapacity(CUSTOM, 64, 0)
     ,NumPut(0x24,    CHOOSECOLOR, 0)      ; DWORD lStructSize 
     ,NumPut(hGui,    CHOOSECOLOR, 4)      ; HWND hwndOwner (makes dialog "modal"). 
     ,NumPut(clr,    CHOOSECOLOR, 12)     ; clr.rgbResult 
     ,NumPut(&CUSTOM,  CHOOSECOLOR, 16)     ; COLORREF *lpCustColors
     ,NumPut(0x00000103,CHOOSECOLOR, 20)     ; Flag: CC_ANYCOLOR || CC_RGBINIT 

    nRC := DllCall("comdlg32\ChooseColorA", str, CHOOSECOLOR)  ; Display the dialog. 
    If (errorlevel <> 0) || (nRC = 0) 
       Return  false 

    clr := NumGet(CHOOSECOLOR, 12) 

    oldFormat := A_FormatInteger 
    SetFormat, integer, hex  ; Show RGB color extracted below in hex format. 

    ;convert to rgb 
    Color := (clr & 0xff00) + ((clr & 0xff0000) >> 16) + ((clr & 0xff) << 16) 
    StringTrimLeft, Color, Color, 2 
    Loop, % 6-strlen(Color) 
    Color=0%Color% 
    Color=%Color% 
    SetFormat, integer, %oldFormat% 
  Return true

}
;===================================================================-------------------------------------------===========
;                                                                    Dlg_Font(font,style,color,boolean,hGui)   <----------*****
;===================================================================-------------------------------------------===========
Dlg_Font(ByRef Name, ByRef Style, ByRef Color, Effects=true, hGui=0)
{
   LogPixels := DllCall("GetDeviceCaps", "uint", DllCall("GetDC", "uint", hGui), "uint", 90)  ;LOGPIXELSY
   VarSetCapacity(LOGFONT, 128, 0)

   Effects := 0x041 + (Effects ? 0x100 : 0)  ;CF_EFFECTS = 0x100, CF_SCREENFONTS=1, CF_INITTOLOGFONTSTRUCT = 0x40

   ;set initial name
   DllCall("RtlMoveMemory", "uint", &LOGFONT+28, "Uint", &Name, "Uint", 32)

   ;convert from rgb  
   clr := ((Color & 0xFF) << 16) + (Color & 0xFF00) + ((Color >> 16) & 0xFF) 

   ;set intial data
   If InStr(Style, "bold")
      NumPut(700, LOGFONT, 16)

   If InStr(Style, "italic")
      NumPut(255, LOGFONT, 20, 1)

   If InStr(Style, "underline")
      NumPut(1, LOGFONT, 21, 1)
   
   If InStr(Style, "strikeout")
      NumPut(1, LOGFONT, 22, 1)

   If RegExMatch(Style, "s[1-9][0-9]*", s){
      StringTrimLeft, s, s, 1      
      s := -DllCall("MulDiv", "int", s, "int", LogPixels, "int", 72)
      NumPut(s, LOGFONT, 0, "Int")      ; set size
   }
   else  NumPut(16, LOGFONT, 0)         ; set default size

   VarSetCapacity(CHOOSEFONT, 60, 0)
    ,NumPut(60,     CHOOSEFONT, 0)    ; DWORD lStructSize
    ,NumPut(hGui,    CHOOSEFONT, 4)    ; HWND hwndOwner (makes dialog "modal").
    ,NumPut(&LOGFONT,CHOOSEFONT, 12)  ; LPLOGFONT lpLogFont
    ,NumPut(Effects, CHOOSEFONT, 20)  
    ,NumPut(clr,   CHOOSEFONT, 24)  ; rgbColors

   r := DllCall("comdlg32\ChooseFontA", "uint", &CHOOSEFONT)  ; Display the dialog.
   If !r
      Return false

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

  If NumGet(LOGFONT, 16) >= 700
    Style .= "bold "

  If NumGet(LOGFONT, 20, "UChar")
      Style .= "italic "
   
  If NumGet(LOGFONT, 21, "UChar")
      Style .= "underline "

  If NumGet(LOGFONT, 22, "UChar")
      Style .= "strikeout "

  s := NumGet(LOGFONT, 0, "Int")
  Style .= "s" Abs(DllCall("MulDiv", "int", abs(s), "int", 72, "int", LogPixels))

 ;convert to rgb 
  oldFormat := A_FormatInteger 
    SetFormat, integer, hex  ; Show RGB color extracted below in hex format. 

    Color := (Color & 0xff00) + ((Color & 0xff0000) >> 16) + ((Color & 0xff) << 16) 
    StringTrimLeft, Color, Color, 2 
    Loop, % 6-strlen(Color) 
    Color=0%Color% 
    Color=%Color% 
    SetFormat, integer, %oldFormat% 

   Return 1
}
;=============================-------------------------------===========
;                                   SetChatColors            ===========
;=============================-------------------------------===========
SetChatColors()
{
  Global
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
  
  If (Type == 0)
  {
    IniRead, TalkColor, DCLconfig.ini, Default Chat Colors, TalkColor, 240`,240`,240
    IniRead, ShoutColor, DCLconfig.ini, Default Chat Colors, ShoutColor, 255`,239`,80
    IniRead, WhisperColor, DCLconfig.ini, Default Chat Colors, WhisperColor, 128`,128`,128
    IniRead, TellColor, DCLconfig.ini, Default Chat Colors, TellColor, 32`,255`,32
    IniRead, ServerColor, DCLconfig.ini, Default Chat Colors, ServerColor, 176`,176`,176
    IniRead, PartyColor, DCLconfig.ini, Default Chat Colors, PartyColor, 240`,240`,240
    IniRead, DMColor, DCLconfig.ini, Default Chat Colors, DMColor,16`, 223`,255      
  }
  else If (Type == 1)
  {
    IniRead, TalkColor, %NWN_DIR%\nwnplayer.ini, Chat Colors, TalkColor
    IniRead, ShoutColor, %NWN_DIR%\nwnplayer.ini, Chat Colors, ShoutColor
    IniRead, WhisperColor, %NWN_DIR%\nwnplayer.ini, Chat Colors, WhisperColor
    IniRead, TellColor, %NWN_DIR%\nwnplayer.ini, Chat Colors, TellColor
    IniRead, ServerColor, %NWN_DIR%\nwnplayer.ini, Chat Colors, ServerColor
    IniRead, PartyColor, %NWN_DIR%\nwnplayer.ini, Chat Colors, PartyColor
    IniRead, DMColor, %NWN_DIR%\nwnplayer.ini, Chat Colors, DMColor  
    Return true
  }
  else If (Type == 2)
  {
    IniRead,FriendlyColor, %NWN_DIR%\nwnplayer.ini, Trap Colors, FriendlyColor
    IniRead,HostileColor, %NWN_DIR%\nwnplayer.ini, Trap Colors, HostileColor    
  }
  Return
}
;============================================================-------------------------===========
;                                                                Zip/Unzip
;============================================================-------------------------===========
/*
Original from Shajul
Zip/Unzip file(s)/folder(s)/wildcard pattern files
Requires: Autohotkey_L, Windows > XP
URL: http://www.autohotkey.com/forum/viewtopic.php?t=65401
Credits: Sean for original idea
*/
; -----------   THE FUNCTIONS   -------------------------------------
CreateZipFile(sZip)
{
  Header1 := "PK" . Chr(5) . Chr(6)
  VarSetCapacity(Header2, 18, 0)
  file := FileOpen(sZip,"w")
  file.Write(Header1)
  file.RawWrite(Header2,18)
  file.close()
}

Zip(FilesToZip, sZip)
{
  If Not FileExist(sZip)
    CreateZipFile(sZip)

  psh := ComObjCreate( "Shell.Application" )
  pzip := psh.Namespace( sZip )

  If InStr(FileExist(FilesToZip), "D")
    FilesToZip .= SubStr(FilesToZip,0)="\" ? "*.*" : "\*.*"

  Loop,%FilesToZip%,1
  {
    zipped++
    ToolTip Zipping %A_LoopFileName% ..
    pzip.CopyHere( A_LoopFileLongPath, 4|16 )

    Loop
    {
      done := pzip.items().count
      If done = %zipped%
        break
    }

    done := -1
  }
  ;ToolTip
}

Unz(sZip, sUnz)
{
  fso := ComObjCreate("Scripting.FileSystemObject")
  
  If Not fso.FolderExists(sUnz)  ;http://www.autohotkey.com/forum/viewtopic.php?p=402574
         fso.CreateFolder(sUnz)
  
  psh  := ComObjCreate("Shell.Application")
  zippedItems := psh.Namespace( sZip ).items().count
  psh.Namespace( sUnz ).CopyHere( psh.Namespace( sZip ).items, 4|16 )
  
  Loop
  {
    sleep 50

    unzippedItems := psh.Namespace( sUnz ).items().count
    
    ToolTip Unzipping in progress... %unzippedItems%/%zippedItems%

    IfEqual,zippedItems,%unzippedItems%
      break
  }
  ;ToolTip
}
; -----------   END FUNCTIONS   -------------------------------------

;============================================================-------------------------===========
;                                                                Empty Memory for performances
;============================================================-------------------------===========
EmptyMem(PID="AHK Rocks")
{
  pid:=(pid="AHK Rocks") ? DllCall("GetCurrentProcessId") : pid
  h:=DllCall("OpenProcess", "UInt", 0x001F0FFF, "Int", 0, "Int", pid)
  DllCall("SetProcessWorkingSetSize", "UInt", h, "Int", -1, "Int", -1)
  DllCall("CloseHandle", "Int", h)
}

;============================================================-------------------------===========
;                                                                Token functions
;============================================================-------------------------===========
/* Data from INI
    [CHOOSEN]
    DCLanguagesOptions=ENGLISH|GERMAN|
    DCLanguagesChoosen=GERMAN
*/

; counts the tokens within the haystack
GetTokenCount(haystack, delim="`|")
{
  StringReplace, haystack, haystack, %delim%, %delim%, UseErrorLevel ;use ErrorLevel for counting

  return ErrorLevel
}

; gets the position of the specified token in the array
GetTokenPosition(haystack, needle, delim="`|")
{
  ; Initialize counter to keep track of our position in the string.
  position := 0

  ; parse the haystack, token by token
  Loop, Parse, haystack, %delim%
  {
    position++  ; counter added by one

    If (A_LoopField == needle)  ; if actual token is the needle
    {
      result := position  ; set position as result 
    }
  }
  ; finally return the result
  return result 
}
