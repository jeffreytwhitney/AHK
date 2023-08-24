#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.

SetWorkingDir, %A_ScriptDir%
#Include <archivelib>





if (A_Args.Length() > 0)
{
    for n, filePath in A_Args  ; For each parameter (or file dropped onto a script):
    {
        fileExtension := GetFileExtensionFromFilePath(filePath)

        if (fileExtension = ".iwp")
        {
            MsgBox, 48,, You can't archive MicroVu programs through this script.
            Return
        }
        CopyFile(filePath, "ArchiveFileByExtension")
    }
}
Else
{
    fileExtension := GetFileExtensionFromFilePath("V:\Inspect Programs\Micro-Vu\Approved Programs\311\additive\10000T-TIP REV A\10000T-TIP REV A.iwp")
    if (fileExtension = ".iwp")
    {
        MsgBox, 48,, You can't archive MicroVu programs through this script.
        Return
    }
    ;For debugging
    ;CopyFile("C:\\temp\\Source\\1A.txt", "ArchiveFileByExtension")
}


