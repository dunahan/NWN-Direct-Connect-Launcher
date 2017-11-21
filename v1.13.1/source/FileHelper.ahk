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
