#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.

SetWorkingDir, %A_ScriptDir%
#Include <archivelib>

ArchiveOverlay(filePath, iniFileName)
{
    archiveFilePath := GetFileOutputPath(filePath, iniFileName)
    incrementedFilePath := GetIncrementedFilePath(filePath)

    if (archiveFilePath == "")
    {    
        Return
    }

    if (incrementedFilePath == "")
    {    
        Return
    }

    doArchive := False

    if FileExist(archiveFilePath)
    {
        message = File '%archiveFilePath%' already exists. Overwrite?
        MsgBox, 36,, %message%
        IfMsgBox No
           Return
        doArchive := True 
    }
    else
    {
        doArchive := True 
    }

    if FileExist(incrementedFilePath)
    {
        message = File '%incrementedFilePath%' already exists.
        MsgBox, 48,, %message%
        Return
    }

    if (doArchive == True) 
    {    
        FileCopy, %filePath%, %archiveFilePath%, 1
        FileMove, %filePath%, %incrementedFilePath%
        message = File '%filePath%' has been archived and renamed.
        MsgBox, 64,, %message%
    }
    
    Return
}

GetIncrementedFilePath(sourceFilePath)
{
    SplitPath, sourceFilePath, fileName, fileDirectory, fileExtension, fileNameWithoutExtension, fileDrivefileSuffix

    currentFileSuffix := SubStr(fileNameWithoutExtension, StrLen(fileNameWithoutExtension) , 1)
    incrementedFileSuffix := IncrementFileSuffix(currentFileSuffix)
    fileNameLength := StrLen(fileNameWithoutExtension)
    incrementedFileName := SubStr(fileNameWithoutExtension, 1, fileNameLength-1) . incrementedFileSuffix . "." . fileExtension
    incrementedFilePath := fileDirectory . "\" . incrementedFileName

    Return incrementedFilePath
}

IncrementFileSuffix(fileSuffix)
{
    StringUpper, fileSuffix, fileSuffix
    asciiFileSuffix := Asc(fileSuffix)
    asciiFileSuffix ++
    returnValue := Chr(asciiFileSuffix)
    Return returnValue
}





if (A_Args.Length() > 0)
{
    for n, filePath in A_Args  ; For each parameter (or file dropped onto a script):
    {
        ArchiveOverlay(filePath, "ArchiveOverlay")
    }
}
Else
{
    ;For debugging
    ArchiveOverlay("C:\\temp\\Source\\1C.txt", "ArchiveOverlayTest")
}


