#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.

SetWorkingDir, %A_ScriptDir%
#Include <archivelib>







;CopyFilesWithRecursion("\\rms-microvuy026\Microvu Programs\Jeffrey\TEST", "c:\backup\test")
CopyFolderWithOverwrite("\\rms-microvuy026\Microvu Programs\Jeffrey\TEST", "CopyFolderToBackup")