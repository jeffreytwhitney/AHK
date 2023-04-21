#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.

SetWorkingDir, %A_ScriptDir%


CleanUpMicroVu(sourceDirectory)
{
    searchDirectory := sourceDirectory . "*.*"

   Loop, Files,  %searchDirectory%, R
   {
        if !(A_LoopFileExt ~= "^(iwp|py|spp|jpg)$")
        {
            continue
        }
        StringUpper sourceFilePath, A_LoopFileFullPath

        If InStr(sourceFilePath, "EXPORT CHECK") and A_LoopFileExt = "iwp"
        {
            continue
        }

        If InStr(sourceFilePath, "CAL TEST") and A_LoopFileExt = "iwp"
        {
            continue
        }

        If InStr(sourceFilePath, "\CALIBRATION\") 
        {
            continue
        }

        If InStr(sourceFilePath, "\EXPORT CHECKER\") 
        {
            continue
        }

        If InStr(sourceFilePath, "\TIEN\") 
        {
            if (SubStr(A_Now, 1, 8) - SubStr(A_LoopFileTimeModified, 1, 8) < 30)
            {
                continue
            }
        }

        If InStr(sourceFilePath, "\TVH\") 
        {
            if (SubStr(A_Now, 1, 8) - SubStr(A_LoopFileTimeModified, 1, 8) < 30)
            {
                continue
            }
        }

        If InStr(sourceFilePath, "\SHAWN\") 
        {
            if (SubStr(A_Now, 1, 8) - SubStr(A_LoopFileTimeModified, 1, 8) < 30)
            {
                continue
            }        }

        If InStr(sourceFilePath, "\RON\") 
        {
            if (SubStr(A_Now, 1, 8) - SubStr(A_LoopFileTimeModified, 1, 8) < 30)
            {
                continue
            } 
        }

        If InStr(sourceFilePath, "\DYLAN\") 
        {
            if (SubStr(A_Now, 1, 8) - SubStr(A_LoopFileTimeModified, 1, 8) < 30)
            {
                continue
            } 
        }

        If InStr(sourceFilePath, "\CARRIE\") 
        {
            if (SubStr(A_Now, 1, 8) - SubStr(A_LoopFileTimeModified, 1, 8) < 30)
            {
                continue
            } 
        }

        If InStr(sourceFilePath, "\JIM\") 
        {
            if (SubStr(A_Now, 1, 8) - SubStr(A_LoopFileTimeModified, 1, 8) < 30)
            {
                continue
            } 
        }

        If InStr(sourceFilePath, "\DON\") 
        {
            if (SubStr(A_Now, 1, 8) - SubStr(A_LoopFileTimeModified, 1, 8) < 30)
            {
                continue
            } 
        }

        If InStr(sourceFilePath, "\ADAM\") 
        {
            if (SubStr(A_Now, 1, 8) - SubStr(A_LoopFileTimeModified, 1, 8) < 30)
            {
                continue
            } 
        }

        If InStr(sourceFilePath, "\JEFFREY\") 
        {
            if (SubStr(A_Now, 1, 8) - SubStr(A_LoopFileTimeModified, 1, 8) < 30)
            {
                continue
            } 
        }
        FileDelete, %sourceFilePath%
   }
}


CleanUpMicroVu("\\10.146.50.216\Microvu Programs\")
CleanUpMicroVu("\\rms-microvuy006\MicroVu Programs\")
CleanUpMicroVu("\\rms-microvuy008\MicroVu Programs\")
CleanUpMicroVu("\\rms-microvuy009\Microvu Programs\")
CleanUpMicroVu("\\rms-microvuy011\MicroVu Programs\")
CleanUpMicroVu("\\rms-microvuy012\MicroVu Programs\")
CleanUpMicroVu("\\rms-microvuy013\MicroVu Programs\")
CleanUpMicroVu("\\rms-microvuy014\MicroVu Programs\")
CleanUpMicroVu("\\rms-microvuy017\MicroVu Programs\")
CleanUpMicroVu("\\rms-microvuy019\MicroVu Programs\")
CleanUpMicroVu("\\rms-microvuy020\Microvu Programs\")
CleanUpMicroVu("\\rms-microvuy024\Microvu Programs\")
CleanUpMicroVu("\\rms-microvuy026\Microvu Programs\")
CleanUpMicroVu("\\rms-microvuy028\MicroVu Programs\")
CleanUpMicroVu("\\rms-microvuy029\MicroVu Programs\")
CleanUpMicroVu("\\rms-microvuy031\Microvu Programs\")
CleanUpMicroVu("\\rms-microvuy032\Microvu Programs\")
CleanUpMicroVu("\\RMS-MICROVUy033\Microvu Programs\")
CleanUpMicroVu("\\rms-microvuy036\Microvu Programs\")
CleanUpMicroVu("\\RMS-MICROVUy037\Microvu Programs\")
CleanUpMicroVu("\\RMS-MICROVUy045\Microvu Programs\")
CleanUpMicroVu("\\RMS-MICROVUy046\Microvu Programs\")
CleanUpMicroVu("\\RMS-MICROVUy047\Microvu Programs\")
CleanUpMicroVu("\\RMS-MICROVUy048\Microvu Programs\")
CleanUpMicroVu("\\RMS-MICROVUy050\Microvu Programs\")
CleanUpMicroVu("\\RMS-MICROVUy051\Microvu Programs\")
CleanUpMicroVu("\\RMS-MICROVUy054\Microvu Programs\")
CleanUpMicroVu("\\RMS-MICROVUY055\Microvu Programs\")
CleanUpMicroVu("\\RMS-MICROVUY057\Microvu Programs\")
CleanUpMicroVu("\\RMS-MICROVUY058\Microvu Programs\")
CleanUpMicroVu("\\rms-microvuy059\Microvu Programs\")
CleanUpMicroVu("\\rms-microvuy060\MicroVu Programs\")
CleanUpMicroVu("\\rms-microvuy061\MicroVu Programs\")

MsgBox, Done!