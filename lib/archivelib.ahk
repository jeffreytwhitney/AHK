#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.

CopyFolder(sourceDirectory, iniFileName)
{
    outputDirectory := GenerateFolderOutputPath(sourceDirectory, iniFileName)

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
        FileCopyDir, %sourceDirectory%, %outputDirectory%, True
        message = File '%sourceDirectory%' has been copied to '%outputDirectory%'.
        MsgBox, 64,, %message%
    }

    Return
}

CopyFolderWithOverwrite(sourceDirectory, iniFileName)
{
    outputDirectory := GenerateFolderOutputPath(sourceDirectory, iniFileName)

    if (outputDirectory == "")
    { 
        Return
    }

    if FileExist(outputDirectory)
    {
        message = Directory '%outputDirectory%' already exists. Overwrite?
        MsgBox, 36,, %message%
        IfMsgBox No
        {
            Return
        }
        FileRemoveDir, %outputDirectory%, 1
    }

    FileCreateDir, %outputDirectory%
    if !(FileExist(outputDirectory))
    {
        message = Unable to create directory '%outputDirectory%'. 
        MsgBox, 64,, %message%
        Return
    }

    CopyFilesWithRecursion(sourceDirectory, outputDirectory)
    message = File '%sourceDirectory%' has been copied to '%outputDirectory%'.
    MsgBox, 64,, %message%

    Return
}

CopyFolderWithFileNameAppend(sourceDirectory, iniFileName)
{

    outputDirectory := GenerateFolderOutputPath(sourceDirectory, iniFileName)

    if (outputDirectory == "")
    { 
        Return
    }

    if FileExist(outputDirectory)
    {
        searchDirectory := sourceDirectory . "\*.*"
        Loop, Files, %searchDirectory% 															
        { 
            currentFileName := A_LoopFileName
            CopyFileWithFileNameAppend(currentFileName, outputDirectory, sourceDirectory)
        }
        message = Folder '%sourceDirectory%' has been copied to '%outputDirectory%'.
        MsgBox, 64,, %message%
    }
    else
    {
        FileCopyDir, %sourceDirectory%, %outputDirectory%, 1
        message = Folder '%sourceDirectory%' has been copied to '%outputDirectory%'.
        MsgBox, 64,, %message%
    }

    Return
}

GetIniFilePath(iniFileName)
{
    iniPath := A_WorkingDir . "\" iniFileName . ".ini"
    Return iniPath
}

GenerateFolderOutputPath(sourceFilePath, iniFileName)
{
    trimmedFilePath := RTrim(sourceFilePath, "\")
    directoryParts := StrSplit(trimmedFilePath , "\")
    numberOfParts := directoryParts.Length()
    lastPart := directoryParts[numberOfParts]
    outputDirectory := GetFolderOutputPath(iniFileName) 
    If (outputDirectory == "")
    {
        return ""
    }
    Else
    {
        return outputDirectory . "\" . lastPart
    }
}

CopyFile(filePath, iniFileName)
{
    archiveFilePath := GetFileOutputPath(filePath, iniFileName)

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
        FileCopy, %filePath%, %archiveFilePath%, 1
        message = File '%filePath%' has been copied to '%archiveFilePath%'.
        MsgBox, 64,, %message%
    }

    Return
}

CopyFilesWithRecursion(sourceDirectory, outputDirectory)
{
    searchDirectory := sourceDirectory . "\*.*"
    Loop, Files, %searchDirectory%, F 															
    { 
        sourceFilePath := A_LoopFileFullPath
        outputFilePath := outputDirectory . "\" . A_LoopFileName
        FileCopy, %sourceFilePath%, %outputFilePath%, 1 
        if ErrorLevel
        {
            MsgBox, Could not copy "%A_LoopFileFullPath%" to "%outputFilePath%\%A_LoopFileName%"
            Return
        }
        if !FileExist(outputFilePath)
        {
            MsgBox, It did not work.
        }

    }
    Loop, Files, %searchDirectory%, D
    {
        sourceSubDirectory := A_LoopFileFullPath
        outputSubDirectory := outputDirectory . "\" . A_LoopFileName
        FileCreateDir, %outputSubDirectory%
        CopyFilesWithRecursion(sourceSubDirectory, outputSubDirectory)
    }
}

CopyFileWithFileNameAppend(currentFileName, outputDirectory, sourceDirectory)
{
    sourceFileName := sourceDirectory . "\" . currentFileName
    outputFileName := outputDirectory . "\" . currentFileName
    fileNameParts := StrSplit(currentFileName , ".")
    fileStem := fileNameParts[1]
    fileExtension := "." . fileNameParts[2]

    fileNameSuffix := 0
    if FileExist(outputFileName)
    {
        While True
        {
            fileNameSuffix += 1
            outputFileName := outputDirectory . "\" . fileStem . "-" . fileNameSuffix . fileExtension
            if FileExist(outputFileName)
            {
                Continue
            }
            Else
            {
                FileCopy %sourceFileName%, %outputFileName%
                break
            }
        }
    }
    Else
    {
        FileCopy %sourceFileName%, %outputFileName%
    }

    Return 
}

GetFileOutputPath(sourceFilePath, iniFileName)
{
    SplitPath, sourceFilePath, fileName, fileDirectory, fileExtension, fileNameWithoutExtension, fileDrivefileSuffix
    archiveFolder := GetStoredIniValue("FileExtensionPaths", fileExtension, iniFileName)
    if (archiveFolder == "Null")
    {
        FileSelectFolder, outputFolder
        if (outputFolder == "")
        {
            Return ""
        }
        Else
        {
            StoreIniValue(outputFolder, iniFileName, "FileExtensionPaths", fileExtension)
            archiveFilePath := outputFolder . "\" . fileName
            Return archiveFilePath
        }
    }
    Else
    {
        archiveFilePath:= archiveFolder . "\" . fileName
        return archiveFilePath
    }
}

GetFolderOutputPath(iniFileName)
{
    outputPath := GetStoredIniValue("OutputFilePath", "Path", iniFileName)
    if (outputPath == "Null")
    {
        FileSelectFolder, outputPath
        if (outputPath == "")
        {
            Return ""
        }
        Else
        {
            StoreIniValue(outputPath, iniFileName, "OutputFilePath", "Path")
            return outputPath
        }
    }
    Else
    {
        return outputPath
    }
}

GetStoredIniValue(iniSection, iniKey, iniFileName)
{
    iniFilePath := GetIniFilePath(iniFileName)
    IniRead, iniValue, %iniFilePath%, %iniSection%, %iniKey%, Null
    Return iniValue
}

StoreIniValue(iniValue, iniFileName, iniSection, iniKey)
{
    iniFilePath := GetIniFilePath(iniFileName)
    IniWrite, %iniValue%, %iniFilePath%, %iniSection%, %iniKey%
    Return
}

