#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.


#Include <archivelib>





if (A_Args.Length() > 0)
{
    for n, filePath in A_Args  ; For each parameter (or file dropped onto a script):
    {
        CopyMicroVuFile(filePath, "ArchiveMicroVuFolder")
    }
}
Else
{
    CopyMicroVuFile("V:\Inspect Programs\Micro-Vu\Approved Programs\311\Pacing\M045719C002 REV A\M045719C002 TOP VIEW.iwp", "test")
}