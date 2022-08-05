#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

ReplaceDoubleSlashWithSingleSlash(filePath)
{
    doubleSlash := "\\"
    singleSlash := "\"
    result := StrReplace(filePath, doubleSlash, singleSlash)
    Return result
}

GetIniFilePath()
{
    scriptNameSlices := StrSplit(A_ScriptName , ".")
    scriptName := scriptNameSlices[1]
    iniPath := A_WorkingDir . "\" scriptName . ".ini"
    Return iniPath
}

GetStoredOutputPath()
{
	iniFile := GetIniFilePath()
    IniRead, iniFilePath, %iniFile%, FilePath, Path, Null
    if (iniFilePath == "Null")
    {
        FileSelectFolder, iniFilePath
	    if (iniFilePath == "")
        {
            Return ""
        }
        Else
        {
            StoreOutputPath(iniFilePath)
        }
    }
    
    Return ReplaceDoubleSlashWithSingleSlash(iniFilePath)
}

StoreOutputPath(directory)
{
	iniFile := GetIniFilePath()
    singleSlashedDirectory := ReplaceDoubleSlashWithSingleSlash(directory)
    IniWrite, %singleSlashedDirectory%, %iniFile%, FilePath, Path
	Return
}