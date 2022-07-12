#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.

SetWorkingDir, %A_ScriptDir%

ArchiveDirectory(filePath)
{
    singleSlashFilePath := ReplaceDoubleSlashWithSingleSlash(filePath)
    archiveFilePath := GetArchiveFilePath(singleSlashFilePath)

    if (archiveFilePath == "")
    {    
        Return
    }

    if FileExist(archiveFilePath)
    {
        message = Directory '%archiveFilePath%' already exists.
        MsgBox, 48,, %message%
        Return
    }
    else
    {
        FileCopyDir, %singleSlashFilePath%, %archiveFilePath% , Overwrite
        message = Directory '%singleSlashFilePath%' has been archived.
        MsgBox, 64,, %message%
    }

    Return
}


GetArchiveFilePath(sourceFilePath)
{
    SplitPath, sourceFilePath, fileName, fileDirectory
    
    directoryParts := StrSplit(sourceFilePath , "\\")
    numberOfParts := directoryParts.Length()
    lastPart := directoryParts[numberOfParts - 1]
    
    archiveDirectory := "V:\\Inspect Programs\\Micro-Vu Archive\\Old Programs\\" . lastPart . "\\"
    
    return archiveDirectory
    
}


ReplaceDoubleSlashWithSingleSlash(filePath)
{
    doubleSlash := "\\"
    singleSlash := "\"
    result := RegExReplace(filePath, doubleSlash, singleSlash)
    Return result
}







if (A_Args.Length() > 0)
{
    for n, filePath in A_Args  ; For each parameter (or file dropped onto a script):
    {
        ArchiveDirectory(filePath)
    }
}
Else
{
    ;For debugging
    ArchiveDirectory("C:\\temp\\Source\\M987654321\\")
}


