#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.

SetWorkingDir, %A_ScriptDir%

ArchiveFile(filePath)
{
    singleSlashFilePath := ReplaceDoubleSlashWithSingleSlash(filePath)
    archiveFilePath := GetArchiveFilePath(singleSlashFilePath)
    incrementedFilePath := GetIncrementedFilePath(singleSlashFilePath)

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
        IfMsgBox Yes
           doArchive := True 
        else
           Return
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
        FileCopy, %singleSlashFilePath%, %archiveFilePath% , Overwrite
        FileMove, %singleSlashFilePath%, %incrementedFilePath%
        message = File '%singleSlashFilePath%' has been archived and renamed.
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

GetArchiveFilePath(sourceFilePath)
{
    SplitPath, sourceFilePath, fileName, fileDirectory, fileExtension, fileNameWithoutExtension, fileDrivefileSuffix
    archivePath := GetStoredArchivePathByFileExtension(fileExtension)
    if (archivePath == "")
    {
        Return ""
    }
    Else
    {
        archiveFilePath := archivePath . "\" . fileName
        Return archiveFilePath
    }
    
}


StoreArchivePathForFileExtension(directory, fileExtension)
{
	iniFile := A_WorkingDir . "\ArchiveFileBySuffix.ini"
    singleSlashedDirectory := ReplaceDoubleSlashWithSingleSlash(directory)
    IniWrite, %singleSlashedDirectory%, %iniFile%, FileExtensionPaths, %fileExtension%
	Return
}

GetStoredArchivePathByFileExtension(fileExtension)
{
	iniFile := A_WorkingDir . "\ArchiveFileBySuffix.ini"
    IniRead, archivePath, %iniFile%, FileExtensionPaths, %fileExtension%, Null
    if (archivePath == "Null")
    {
        FileSelectFolder, archivePath
	    if archivePath = 
        {
            Return ""
        }
        Else
        {
            StoreArchivePathForFileExtension(archivePath, fileExtension)
        }
    }
    Return ReplaceDoubleSlashWithSingleSlash(archivePath)
}

ReplaceDoubleSlashWithSingleSlash(filePath)
{
    doubleSlash := "\\"
    singleSlash := "\"
    result := RegExReplace(filePath, doubleSlash, singleSlash)
    Return result
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
        ArchiveFile(filePath)
    }
}
Else
{
    ;For debugging
    ArchiveFile("C:\\temp\\Source\\BillE.txt")
}


