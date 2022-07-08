#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
for n, givenPath in A_Args  ; For each parameter (or file dropped onto a script):
{
    ArchiveFile(givenPath)
}


ArchiveFile(filePath)
{
    SplitPath, filePath, fileName, fileDirectory, fileExtension, fileNameWithoutExtension, fileDriveLetter
    
    lengthOfFileName := StrLen(fileNameWithoutExtension)    
    fileSuffix := SubStr(fileNameWithoutExtension, lengthOfFileName - 1 , 1)

    
    
    
    
    FileCopy, SourcePattern, DestPattern , Overwrite
    
    ;newFileSuffix := IncreaseLetterByOne("c")
    
    Return
}


WriteArchivePathByFileExtension(directory, fileExtension)
{
	IniWrite, %directory%, settings.ini, FileExtensionPaths, %fileExtension%
	Return
}

GetFolderForFileExtension(fileExtension)
{
	FileSelectFolder, directory
	Return directory
}

IncreaseLetterByOne(letter)
{
    StringUpper, letter, letter
    asciiLetter := Asc(letter)
    asciiLetter ++
    returnValue := Chr(asciiLetter)
    Return returnValue
}


archivePath := GetFolderForFileExtension("txt")
WriteArchivePathByFileExtension(archivePath, "txt")
IniRead, archivePath, settings.ini, FileExtensionPaths, txt, Null



if (archivePath == "Null")
{
	MsgBox Empty archivePath
}
Else
{
	MsgBox %archivePath%
}
if (noPath == "Null")
{
	MsgBox Empty noPath
}
Else
{
	MsgBox %noPath%
}


