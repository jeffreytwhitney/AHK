#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.



ArchiveFile(filePath)
{
    archiveFilePath := GetArchiveFilePath(filePath)
    MsgBox, %archiveFilePath%
    
    incrementedFilePath := GetIncrementedFilePath(filePath)
    MsgBox, %incrementedFilePath%
    


    ; if (archiveFilePath == "")
    ;     {
    ;         Return
    ;     }
    
    
    ;FileCopy, SourcePattern, DestPattern , Overwrite
    
    ;newFileSuffix := IncreasefileSuffixByOne("c")
    
    Return
}

GetIncrementedFilePath(sourceFilePath)
{
    SplitPath, sourceFilePath, fileName, fileDirectory, fileExtension, fileNameWithoutExtension, fileDrivefileSuffix

    currentFileSuffix := SubStr(fileNameWithoutExtension, StrLen(fileNameWithoutExtension) , 1)
    incrementedFileSuffix := IncrementFileSuffix(currentFileSuffix)
    incrementedFileName := SubStr(fileNameWithoutExtension, 0, StrLen(fileNameWithoutExtension)) + incrementedFileSuffix
    incrementedFilePath := fileDirectory . "\\" . incrementedFileName

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
	IniWrite, %directory%, %A_WorkingDir%\ArchiveFileBySuffix.ini, FileExtensionPaths, %fileExtension%
	Return
}

GetStoredArchivePathByFileExtension(fileExtension)
{
	IniRead, archivePath, %A_WorkingDir%\ArchiveFileBySuffix.ini, FileExtensionPaths, %fileExtension%, Null
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
    Return archivePath
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
    ArchiveFile("C:\\temp\\Source\\BillB.txt")
}


