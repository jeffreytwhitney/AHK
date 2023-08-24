#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.

SetWorkingDir, %A_ScriptDir%

#Include <archivelib>




if (A_Args.Length() > 0)
{
    for n, filePath in A_Args  
    {
        filePathSubDirectory := GetMicroVuFolderSubDirectory(filePath)
        if (filePathSubDirectory != "")
        { 
            CopyFolderToSubDirectoryWithFileNameAppend(filePath, filePathSubDirectory, "ArchiveMicroVuFolder")
        }
    }
}
Else
{
    ;For debugging
    CopyFolderToSubDirectoryWithFileNameAppend("V:\Inspect Programs\Micro-Vu\Approved Programs\311\Pacing\23-01-2211_REV D", filePathSubDirectory, "test")
}


