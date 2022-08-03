GetIniFilePath()
{
    scriptNameSlices := StrSplit(A_ScriptName , ".")
    scriptName := scriptNameSlices[1]
    iniPath := A_WorkingDir . "\" scriptName . ".ini"
    return iniPath
}


bob := GetIniFilePath()
MsgBox, %bob%