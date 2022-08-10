#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.

SetWorkingDir, %A_ScriptDir%
#Include <archivelib>

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
        FileCopy, %singleSlashFilePath%, %archiveFilePath%, 1
        message = File '%singleSlashFilePath%' has been copied to backup folder.
        MsgBox, 64,, %message%
    }

    Return
}


GetArchiveFilePath(sourceFilePath, iniFileName)
{
    SplitPath, sourceFilePath, fileName, fileDirectory, fileExtension, fileNameWithoutExtension, fileDrivefileSuffix
    archivePath := GetStoredIniValue("FileExtensionPaths", "fileExtension", iniFileName)
    if (archivePath == "")
    {
        Return ""
    }
    Else
    {
        StoreIniValue(archivePath, iniFileName, "FileExtensionPaths", "fileExtension")
        archiveFilePath := archivePath . "\" . fileName
        Return archiveFilePath
    }
}


if (A_Args.Length() > 0)
{
    for n, filePath in A_Args  ; For each parameter (or file dropped onto a script):
    {
        ArchiveFile(filePath, "BackupFileByExtension")
    }
}
Else
{
    ;For debugging
    ArchiveFile("C:\\temp\\Source\\1A.txt", "testWFileExtensions")
    ArchiveFile("C:\\temp\\Source\\5A.rtf", "testWFileExtensions")
}


