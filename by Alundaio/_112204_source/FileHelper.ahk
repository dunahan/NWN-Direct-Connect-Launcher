ReadMemory(sFile, pBuffer, nSize = 512, bAppend = False)
{
   If !(1 + hFile := CreateFile(sFile, 4, 0x40000000, 1))
   Return "File not created/opened!"
   SetFilePointer(hFile, bAppend ? 2 : 0)
   nSize := WriteFile(hFile, pBuffer, nSize)
   SetEndOfFile(hFile)
   CloseHandle(hFile)
   Return nSize
}

WriteMemory(sFile, ByRef sBuffer, nSize = 0)
{
   If !(1 + hFile := CreateFile(sFile, 3, 0x80000000, 1))
   Return "File not found!"
   VarSetCapacity(sBuffer, nSize += nSize ? 0 : GetFileSize(hFile))
   nSize := ReadFile(hFile, &sBuffer, nSize)
   VarSetCapacity(sBuffer, -1)
   CloseHandle(hFile)
   Return nSize
}


CreateFile(sFile, nCreate = 3, nAccess = 0x1F01FF, nShare = 7, bFolder = False)
{
/*
   CREATE_NEW    = 1
   CREATE_ALWAYS = 2
   OPEN_EXISTING = 3
   OPEN_ALWAYS   = 4

   GENERIC_READ    = 0x80000000
   GENERIC_WRITE   = 0x40000000
   GENERIC_EXECUTE = 0x20000000
   GENERIC_ALL     = 0x10000000 

   FILE_SHARE_READ   = 1
   FILE_SHARE_WRITE  = 2
   FILE_SHARE_DELETE = 4
*/
   Return DllCall("CreateFile", "Uint", &sFile, "Uint", nAccess, "Uint", nShare, "Uint", 0, "Uint", nCreate, "Uint", bFolder ? 0x02000000 : 0, "Uint", 0)
}

DeleteFile(sFile)
{
   Return DllCall("DeleteFile", "Uint", &sFile)
}

ReadFile(hFile, pBuffer, nSize = 1024)
{
   DllCall("ReadFile", "Uint", hFile, "Uint", pBuffer, "Uint", nSize, "UintP", nSize, "Uint", 0)
   Return nSize
}

WriteFile(hFile, pBuffer, nSize = 1024)
{
   DllCall("WriteFile", "Uint", hFile, "Uint", pBuffer, "Uint", nSize, "UintP", nSize, "Uint", 0)
   Return nSize
}

GetFileSize(hFile)
{
   DllCall("GetFileSizeEx", "Uint", hFile, "int64P", nSize)
   Return nSize
}

SetEndOfFile(hFile)
{
   Return DllCall("SetEndOfFile", "Uint", hFile)
}

SetFilePointer(hFile, nPos = 0, nMove = 0)
{
/*
   FILE_BEGIN   = 0
   FILE_CURRENT = 1
   FILE_END     = 2
*/
   Return DllCall("SetFilePointerEx", "Uint", hFile, "int64", nMove, "Uint", 0, "Uint", nPos)
}

CloseHandle(Handle)
{
   Return DllCall("CloseHandle", "Uint", Handle)
}


InternetOpen(sAgent = "AutoHotkey", nType = 4)
{
   If !DllCall("GetModuleHandle", "str", "wininet")
       DllCall("LoadLibrary"    , "str", "wininet")
   Return DllCall("wininet\InternetOpenA", "str", sAgent, "Uint", nType, "Uint", 0, "Uint", 0, "Uint", 0)
}

InternetOpenUrl(hInet, sUrl, nFlags = 0, pHeaders = 0)
{
   Return DllCall("wininet\InternetOpenUrlA", "Uint", hInet, "Uint", &sUrl, "Uint", pHeaders, "Uint", -1, "Uint", nFlags | 0x80000000, "Uint", 0)   ; INTERNET_FLAG_RELOAD = 0x80000000
}

InternetReadFile(hFile, pBuffer, nSize = 1024)
{
   DllCall("wininet\InternetReadFile", "Uint", hFile, "Uint", pBuffer, "Uint", nSize, "UintP", nSize)
   Return nSize
}

InternetWriteFile(hFile, pBuffer, nSize = 1024)
{
   DllCall("wininet\InternetWriteFile", "Uint", hFile, "Uint", pBuffer, "Uint", nSize, "UintP", nSize)
   Return nSize
}

InternetSetFilePointer(hFile, nPos = 0, nMove = 0)
{
   Return DllCall("wininet\InternetSetFilePointer", "Uint", hFile, "Uint", nMove, "Uint", 0, "Uint", nPos, "Uint", 0)
}

InternetCloseHandle(Handle)
{
   Return DllCall("wininet\InternetCloseHandle", "Uint", Handle)
}

EmptyMem(PID="AHK Rocks")
{
  pid:=(pid="AHK Rocks") ? DllCall("GetCurrentProcessId") : pid
  h:=DllCall("OpenProcess", "UInt", 0x001F0FFF, "Int", 0, "Int", pid)
  DllCall("SetProcessWorkingSetSize", "UInt", h, "Int", -1, "Int", -1)
  DllCall("CloseHandle", "Int", h)
}

/* Title: HLink
HyperLink control.

Function: Add
Creates hyperlink control.
Parameters: 
hGui - Handle of the parent GUI.
X..H - Size & position.
Handler - Notification handler. If you omit handler, link will be opened in default browser when clicked.
Text - Link text. Link is text between the ' char followd by the : char and location (as Textille mark-up).
Everything else will be displayed as ordinary text.
Notifications:
> Result := OnLink(hWnd, Text, Link)
hWnd - Handle of the HLink control that generated notification.
Text - Text of the control.
Link - Link of the control.
Returns:
Handle of the new control or 0 on failure.
Example:
> hLink := HLink_Add(hGui, "OnLink", 10, 10, 200, 20, "Click 'here':www.Google.com to go to Google")

o Ver 2.01 by majkinetor. See http://www.autohotkey.com/forum/topic19508.html
o HLink Reference at MSDN: <http://msdn2.microsoft.com/en-us/library/bb760704.aspx>;
o Licensed under GNU GPL <http://creativecommons.org/licenses/GPL/2.0/>; 
*/

HLink_Add(hGui, X, Y, W, H, Handler="", Text="'HLink Control':")
{
  static MODULEID
  static ICC_LINK_CLASS=0x8000, WS_CHILD=0x40000000, WS_VISIBLE=0x10000000, WS_TABSTOP=0x10000
  static id=1

  if MODULEID =
  { 
    old := OnMessage(0x4E, "HLink_onNotify"), MODULEID := 170608
    if old != HLink_onNotify
    HLink("oldNotify", RegisterCallback(old))

    VarSetCapacity(ICC, 8, 0), NumPut(8, ICC, 0)
    DllCall("comctl32.dll\InitCommonControlsEx", "uint", &ICC)
  }
  Text := RegExReplace(Text, "'(.+?)'\:([^ ]*)", "<a href=""$2"">$1</a>")
  hCtrl := DllCall("CreateWindowEx"
                  ,"Uint", 0
                  ,"str", "SysLink"
                  ,"str", Text
                  ,"Uint", WS_CHILD | WS_VISIBLE | WS_TABSTOP
                  ,"int", X, "int", Y, "int", W, "int", H
                  ,"Uint", hGui
                  ,"Uint", MODULEID
                  ,"Uint", 0
                  ,"Uint", 0, "Uint")
    ifEqual, hCtrl, 0, return 0

  if IsFunc(Handler)
    HLink(hCtrl "handler", Handler)
  return hCtrl
}

;========================= PRIVATE ==========================================

HLink_onNotify(Wparam, Lparam, Msg, Hwnd)
{
  static MODULEID := 170608, oldNotify="*"
  static NM_CLICK = -2, NM_ENTER = -4

  if (_ := (NumGet(Lparam+4))) != MODULEID
    ifLess _, 10000, return ;if ahk control, return asap (AHK increments control ID starting from 1. Custom controls use IDs > 10000 as its unlikely that u will use more then 10K ahk controls.
  else
  {
    ifEqual, oldNotify, *, SetEnv, oldNotify, % HLink("oldNotify") 
    if oldNotify !=
      return DllCall(oldNotify, "uint", Wparam, "uint", Lparam, "uint", Msg, "uint", Hwnd)
  }

  hw := NumGet(Lparam+0), code := NumGet(Lparam+8, 0, "Int")

  if code not in %NM_CLICK%,%NM_ENTER%
  return

  ControlGetText, txt, ,ahk_id %hw%
  RegExmatch(txt, "\Q<a href=""\E(.*?)"">(.+?)</a>", out)
  StringReplace, txt, txt, %out%, %out2%

  handler := HLink(hw "Handler")
  if (handler = "")
    Run, %out1%
  else if ( %handler%(hw, txt, out1) )
    Run, %out1%
}

;Mini storage function
HLink(var="", value="~`a")
{
  static
  _ := %var%

  ifNotEqual, value, ~`a, SetEnv, %var%, %value%
    return _
}

;Required function by Forms framework.
HLink_add2Form(hParent, Txt, Opt)
{
  static f := "Form_Parse"

  %f%(Opt, "x# y# w# h# g*", x, y, w, h, handler)
  x .= x = "" ? 0 : "", y .= y = "" ? 0 : "", w .= w="" ? 100 : "", h .= h = "" ? 25 : ""
  return HLink_Add(hParent, x, y, w, h, handler, Txt)
}
