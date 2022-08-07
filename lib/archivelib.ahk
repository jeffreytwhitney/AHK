#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.


ReplaceDoubleSlashWithSingleSlash(filePath)
{
    doubleSlash := "\\"
    singleSlash := "\"
    result := StrReplace(filePath, doubleSlash, singleSlash)
    Return result
}

GetIniFilePath(iniFileName)
{
    scriptNameSlices := StrSplit(A_ScriptName , ".")
    scriptName := scriptNameSlices[1]
    iniPath := A_WorkingDir . "\" scriptName . ".ini"
    Return iniPath
}


GetStoredOutputFilePath(iniFileName)
{
    outputPath = GetStoredIniValue("OutputFilePath", "Path", iniFileName)
    if (outputPath == "Null")
    {
        FileSelectFolder, outputPath
	    if (outputPath == "")
        {
            Return ""
        }
        Else
        {
            outputPath = ReplaceDoubleSlashWithSingleSlash(outputPath)
            StoreIniValue(outputPath, iniFileName, "OutputFilePath", "Path")
            return outputPath
        }
    }
}


GetStoredIniValue(iniSection, iniKey, iniFileName)
{
	iniFilePath := GetIniFilePath(iniFileName)
    IniRead, %iniValue%, %iniFilePath%, %iniSection%, %iniKey%, Null
    Return iniValue
}


StoreIniValue(iniValue, iniFileName, iniSection, iniKey)
{
	iniFilePath := GetIniFilePath(iniFileName)
    IniWrite, %iniValue%, %iniFilePath%, %iniSection%, %iniKey%
	Return
}



