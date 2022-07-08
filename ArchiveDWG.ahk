#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
for n, GivenPath in A_Args  ; For each parameter (or file dropped onto a script):
{
    Loop Files, %GivenPath%  ; Include files and directories.
        longFilePath := A_LoopFileFullPath
    ArchiveFile(longFilePath)
}




ArchiveFile(filePath)
{
    SplitPath, filePath, fileName, fileDirectory, fileExtension, fileNameWithoutExtension, fileDriveLetter
    MsgBox %fileName%
    MsgBox %fileDirectory%
    MsgBox %fileExtension%
    MsgBox %fileNameWithoutExtension%
    MsgBox %fileDriveLetter%
    ;FileCopy, SourcePattern, DestPattern , Overwrite
    Return
}

IncreaseLetterByOne(letter)
{
    
}