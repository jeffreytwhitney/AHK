#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
for n, GivenPath in A_Args  ; For each parameter (or file dropped onto a script):
{
    Loop Files, %GivenPath%, FD  ; Include files and directories.
        LongPath := A_LoopFileFullPath
    MsgBox %LongPath%
}




ArchiveFile(filePath)
{
        

    SplitPath, filePath, name, dir, ext, name_no_ext, drive
    MsgBox %name%
    

    ;FileCopy, SourcePattern, DestPattern , Overwrite
}