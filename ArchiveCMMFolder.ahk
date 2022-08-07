#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.

SetWorkingDir, %A_ScriptDir%



CopyFolder(sourceDirectory)
{
    singleSlashFilePath := ReplaceDoubleSlashWithSingleSlash(sourceDirectory)
    outputDirectory := GetOutputPath(singleSlashFilePath)

    if (outputDirectory == "")
    {    
        Return
    }

    
    if FileExist(outputDirectory)
    {
        message = Directory '%outputDirectory%' already exists. 
        MsgBox, 64,, %message%
        Return
    }
    else
    {
        
        FileCopyDir, %singleSlashFilePath%, %outputDirectory%, 1
        message = Folder '%singleSlashFilePath%' has been copied to the CMM Archive Directory.
        MsgBox, 64,, %message%
    }
    
    Return
}

CopyFilesWithFileNameAppend(sourceDirectory, outputDirectory)
{
	;Loop, Files, % myFolder "\*", D																		
	;myResult .= A_LoopFileName "`n"
	;MsgBox % myResult
}


GetOutputPath(sourceFilePath)
{
    trimmedFilePath := RTrim(sourceFilePath, "\")
    directoryParts := StrSplit(trimmedFilePath , "\")
    numberOfParts := directoryParts.Length()
    lastPart := directoryParts[numberOfParts]
    outputDirectory := GetStoredOutputFilePath("ArchiveCMMFolder") 
    If (outputDirectory == "")
    {
        return ""
    }
    Else
    {
        return outputDirectory . "\" . lastPart
    }
}






if (A_Args.Length() > 0)
{
    for n, filePath in A_Args  
    {
        CopyFolder(filePath)
    }
}
Else
{
    ;For debugging
    CopyFolder("C:\temp\Source\M23654789")
}


