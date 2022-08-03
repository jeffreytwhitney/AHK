#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.

SetWorkingDir, %A_ScriptDir%



CopyFolderToWorkInProgress(sourceDirectory)
{
    singleSlashFilePath := ReplaceDoubleSlashWithSingleSlash(sourceDirectory)
    outputDirectory := GetOutputPath(singleSlashFilePath)

    if (outputDirectory == "")
    {    
        Return
    }

    
    if FileExist(outputDirectory)
    {
        message = Directory '%outputDirectory%' already exists. Overwrite?
        MsgBox, 36,, %message%
        IfMsgBox No
            Return
        FileRemoveDir, %outputDirectory%, 1
        FileCreateDir, %outputDirectory%
        FileCopy, %singleSlashFilePath%, %outputDirectory%, 1
        message = File '%singleSlashFilePath%' has been copied to your Work In Progress directory.
        MsgBox, 64,, %message%
        
    }
    else
    {
        
        FileCreateDir, %outputDirectory%
        FileCopy, %singleSlashFilePath%, %outputDirectory%, 1
        message = File '%singleSlashFilePath%' has been copied to your Work In Progress directory.
        MsgBox, 64,, %message%
    }
    
    Return
}




GetOutputPath(sourceFilePath)
{
    trimmedFilePath := RTrim(sourceFilePath, "\")
    directoryParts := StrSplit(trimmedFilePath , "\")
    numberOfParts := directoryParts.Length()
    lastPart := directoryParts[numberOfParts]
    outputDirectory := GetStoredOutputPath() 
    If (outputDirectory == "")
    {
        return ""
    }
    Else
    {
        return outputDirectory . "\" . lastPart
    }
}


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
    return iniPath
}

StoreWorkInProgressPath(directory)
{
	iniFile := GetIniFilePath()
    singleSlashedDirectory := ReplaceDoubleSlashWithSingleSlash(directory)
    IniWrite, %singleSlashedDirectory%, %iniFile%, WorkInProgressPath, Path
	Return
}

GetStoredOutputPath()
{
	iniFile := GetIniFilePath()
    IniRead, workInProgressPath, %iniFile%, WorkInProgressPath, Path, Null
    if (workInProgressPath == "Null")
    {
        FileSelectFolder, workInProgressPath
	    if (workInProgressPath == "")
        {
            Return ""
        }
        Else
        {
            StoreWorkInProgressPath(workInProgressPath)
        }
    }
    
    Return ReplaceDoubleSlashWithSingleSlash(workInProgressPath)
}




if (A_Args.Length() > 0)
{
    for n, filePath in A_Args  
    {
        CopyFolderToWorkInProgress(filePath)
    }
}
Else
{
    ;For debugging
    CopyFolderToWorkInProgress("C:\temp\Source\M23654789")
}


