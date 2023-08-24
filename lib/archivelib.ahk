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
            CopyFileWithFileNameAppend(currentFileName, outputDirectory, sourceDirectory, false)
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

CopyFolderToSubDirectoryWithFileNameAppend(sourceDirectory, subDirectory, iniFileName)
{

    outputDirectory := GenerateFolderOutputPath(sourceDirectory, iniFileName)

    if (outputDirectory == "")
    { 
        Return
    }

    outputSubDirectory := outputDirectory . "\" . subDirectory

    if FileExist(outputSubDirectory)
    {
        searchDirectory := sourceDirectory . "\*.*"
        Loop, Files, %searchDirectory% 															
        { 
            currentFileName := A_LoopFileName
            CopyFileWithFileNameAppend(currentFileName, outputSubDirectory, sourceDirectory, false)
        }
        message = Folder '%sourceDirectory%' has been copied to '%outputSubDirectory%'.
        MsgBox, 64,, %message%
    }
    else
    {
        FileCopyDir, %sourceDirectory%, %outputSubDirectory%, 1
        message = Folder '%sourceDirectory%' has been copied to '%outputSubDirectory%'.
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

CopyMicroVuFile(sourceFilePath, iniFileName)
{
    fileNameParts := StrSplit(sourceFilePath , "\") 
    filename := fileNameParts[fileNameParts.Count()]
    outputDirectory := GetFolderOutputPath(iniFileName) 
    subDirectory := GetMicroVuFileSubDirectory(sourceFilePath)
    outputDirectory .= subDirectory
    sourceDirectory := ExtractDirectoryFromFilePath(sourceFilePath)

    CopyFileWithFileNameAppend(filename, outputDirectory, sourceDirectory, true)

}

ExtractDirectoryFromFilePath(sourceFilePath)
{
    outputPath := ""
    fileNameParts := StrSplit(sourceFilePath , "\")
    tmp_last := fileNameParts.Count()
    for filePartIdx in fileNameParts
    {
        if filePartIdx < %tmp_last%
        {
            if outputPath != 
            {
                outputPath .= "\"
            }
            file_part := fileNameParts[filePartIdx] 
            outputPath .= file_part 
        }
    }
    return outputPath
}

CopyFileWithFileNameAppend(currentFileName, outputDirectory, sourceDirectory, showMessageBox)
{
    sourceFileName := sourceDirectory . "\" . currentFileName
    outputFileName := outputDirectory . "\" . currentFileName
    fileNameParts := StrSplit(currentFileName , ".")
    fileStem := fileNameParts[1]
    fileExtension := "." . fileNameParts[2]

    if !FileExist(outputDirectory) 
    {
        FileCreateDir, %outputDirectory%
    }

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

    if showMessageBox
    {
        message = File '%currentFileName%' has been copied to '%outputFileName%'.
        MsgBox, 64,, %message%
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

GetMicroVuFileSubDirectory(dirToCheck)
{
    machineTypeSubDirectory := ""
    partNameSubDirectory := ""
    fileNameParts := StrSplit(dirToCheck , "\")
    tmp_last := fileNameParts.Count()
    return_value = ""
    
    If InStr(dirToCheck, "\311\")
    {
        machineTypeSubDirectory :=  "311"
    }

    If InStr(dirToCheck, "\341\")
    {
        machineTypeSubDirectory :=  "341"
    }

    If InStr(dirToCheck, "\420\")
    {
        machineTypeSubDirectory :=  "420"
    }

    for file_part_idx in fileNameParts
    {
        file_part := fileNameParts[file_part_idx]
        if file_part = %machineTypeSubDirectory%
        {
            project_name_index := file_part_idx
            project_name_index += 2
            if tmp_last >= %project_name_index%
            {
                partNameSubDirectory := fileNameParts[project_name_index]
            }
        }
    }
    
    If machineTypeSubDirectory != "" && partNameSubDirectory != ""
    {
        return_value := "\" . partNameSubDirectory . "\" . machineTypeSubDirectory 
    }
    Else
    {
        return_value = ""
    }

    return return_value
    
}

GetMicroVuFolderSubDirectory(dirToCheck)
{
    subDirectory = ""
    
    If InStr(dirToCheck, "\311\")
    {
        subDirectory :=  "311"
    }

    If InStr(dirToCheck, "\341\")
    {
        subDirectory :=  "341"
    }

    If InStr(dirToCheck, "\420\")
    {
        subDirectory :=  "420"
    }

    return subDirectory
    
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

