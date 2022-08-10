#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.

CopyFolder(sourceDirectory, iniFileName)
{
    singleSlashFilePath := ReplaceDoubleSlashWithSingleSlash(sourceDirectory)
    outputDirectory := GenerateOutputPath(singleSlashFilePath, iniFileName)

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
        FileCopyDir, %singleSlashFilePath%, %outputDirectory%, True
        message = File '%singleSlashFilePath%' has been copied to '%outputDirectory%'.
        MsgBox, 64,, %message%
    }
    
    Return
}

CopyFolderWithOverwrite(sourceDirectory, iniFileName)
{
    singleSlashFilePath := ReplaceDoubleSlashWithSingleSlash(sourceDirectory)
    outputDirectory := GenerateOutputPath(singleSlashFilePath, iniFileName)

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
        FileCreateDir, %outputDirectory%
        FileCopy, %singleSlashFilePath%, %outputDirectory%, 1
		if (ErrorCount != 0)
		{
			MsgBox %ErrorCount% files/folders could not be copied.
			Return
		}
        message = File '%singleSlashFilePath%' has been copied to '%outputDirectory%'.
        MsgBox, 64,, %message%
        
    }
    else
    {
        
        FileCreateDir, %outputDirectory%
        FileCopy, %singleSlashFilePath%, %outputDirectory%, 1
        message = File '%singleSlashFilePath%' has been copied to '%outputDirectory%'.
        MsgBox, 64,, %message%
    }
    
    Return
}

CopyFolderWithFileNameAppend(sourceDirectory, iniFileName)
{
    singleSlashFilePath := ReplaceDoubleSlashWithSingleSlash(sourceDirectory)
    outputDirectory := GenerateOutputPath(singleSlashFilePath, iniFileName)

    if (outputDirectory == "")
    {    
        Return
    }
    
    if FileExist(outputDirectory)
    {
        searchDirectory := sourceDirectory . "\*"
        Loop, Files, %searchDirectory% 															
	    {    
            currentFileName := A_LoopFileName
            CopyFileWithFileNameAppend(currentFileName, outputDirectory, sourceDirectory)
        }
        message = Folder '%singleSlashFilePath%' has been copied to '%outputDirectory%'.
        MsgBox, 64,, %message%
    }
    else
    {
        FileCopyDir, %singleSlashFilePath%, %outputDirectory%, 1
        message = Folder '%singleSlashFilePath%' has been copied to '%outputDirectory%'.
        MsgBox, 64,, %message%
    }
    
    Return
}

ReplaceDoubleSlashWithSingleSlash(filePath)
{
    doubleSlash := "\\"
    singleSlash := "\"
    result := StrReplace(filePath, doubleSlash, singleSlash)
    Return result
}

GetIniFilePath(iniFileName)
{
    iniPath := A_WorkingDir . "\" iniFileName . ".ini"
    Return iniPath
}

GenerateOutputPath(sourceFilePath, iniFileName)
{
    trimmedFilePath := RTrim(sourceFilePath, "\")
    directoryParts := StrSplit(trimmedFilePath , "\")
    numberOfParts := directoryParts.Length()
    lastPart := directoryParts[numberOfParts]
    outputDirectory := GetStoredOutputFilePath(iniFileName) 
    If (outputDirectory == "")
    {
        return ""
    }
    Else
    {
        return outputDirectory . "\" . lastPart
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

GetStoredOutputFilePath(iniFileName)
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
            outputPath := ReplaceDoubleSlashWithSingleSlash(outputPath)
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

