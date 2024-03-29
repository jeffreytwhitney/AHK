﻿#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.

SetWorkingDir, %A_ScriptDir%

#Include <archivelib>

if (A_Args.Length() > 0)
{
    for n, filePath in A_Args  
    {
        CopyFolderWithFileNameAppend(filePath, "ArchiveCMMFolder")
    }
}
Else
{
    ;For debugging
    CopyFolderWithFileNameAppend("C:\temp\Source\M23654789", "test")
}


