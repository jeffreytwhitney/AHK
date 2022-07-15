#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.

SetWorkingDir, %A_ScriptDir%

ArchiveFile(filePath)
{
    singleSlashFilePath := ReplaceDoubleSlashWithSingleSlash(filePath)
    archiveFilePath := GetArchiveFilePath(singleSlashFilePath)

    if (archiveFilePath == "")
    {    
        Return
    }

    if FileExist(archiveFilePath)
    {
        message = File '%archiveFilePath%' already exists.
        MsgBox, 48,, %message%
        Return
    }
    else
    {
        FileCopy, %singleSlashFilePath%, %archiveFilePath% , Overwrite
        message = File '%singleSlashFilePath%' has been archived.
        MsgBox, 64,, %message%
    }

    Return
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
	iniFile := A_WorkingDir . "\CopyToArchiveFolder.ini"
    singleSlashedDirectory := ReplaceDoubleSlashWithSingleSlash(directory)
    IniWrite, %singleSlashedDirectory%, %iniFile%, FileExtensionPaths, %fileExtension%
	Return
}

GetStoredArchivePathByFileExtension(fileExtension)
{
	iniFile := A_WorkingDir . "\CopyToArchiveFolder.ini"
    IniRead, archivePath, %iniFile%, FileExtensionPaths, %fileExtension%, Null
    if (archivePath == "Null")
    {
        FileSelectFolder, archivePath
	    if (archivePath == "")
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
    result := StrReplace(filePath, doubleSlash, singleSlash)
    Return result
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


