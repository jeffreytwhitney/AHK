#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.

SetWorkingDir, %A_ScriptDir%
#Include <archivelib>


if (A_Args.Length() > 0)
{
    for n, filePath in A_Args  ; For each parameter (or file dropped onto a script):
    {
        ;CopyFile(filePath, "BackupFileByExtension")
    }
}
Else
{
    ;For debugging
    CopyFile("C:\temp\Source\1A.txt", "testWFileExtensions")
    CopyFile("C:\temp\Source\5A.rtf", "testWFileExtensions")
}


