#NoEnv
#SingleInstance force


#+o:: 
    OpenOutlook()
    Return

#+k:: 
    OpenKeyenceDirectory()
    Return

#+d:: 
    OpenSolidWorks()
    Return

#+c:: 
    OpenCMMDirectory()
    Return

#+w:: 
    OpenWIPDirectory()
    Return

#+t:: 
    OpenTickets()
    Return

#+2:: 
    OpenFourTwentyDirectory()
    Return

#+3:: 
    OpenThreeElevenDirectory()
    Return

#+4:: 
    OpenThreeFortyOneDirectory()
    Return

#+g:: 
    OpenGageTrak()
    Return
    
#+v:: 
    OpenOverlayDirectory()
    Return

#+a:: 
    OpenAutoCad()
    Return

#+p:: 
    OpenSmartProfileDirectory()
    Return




OpenSolidWorks()
{
    MsgBox, OpenSolidWorks
    Return
}


OpenCMMDirectory()
{
    MsgBox, OpenCMMDirectory
    ;run, explorer "C:\"
    Return
}


OpenWIPDirectory()
{
    MsgBox, OpenWIPDirectory
    ;run, explorer "C:\"
    Return
}


OpenTickets()
{
    MsgBox, OpenTickets
    Return
}

OpenFourTwentyDirectory()
{
    MsgBox, OpenFourTwentyDirectory
    ;run, explorer "C:\"
    Return
}


OpenThreeFortyOneDirectory()
{
    MsgBox, OpenThreeFortyOneDirectory
    ;run, explorer "C:\"
    Return
}

OpenThreeElevenDirectory()
{
    MsgBox, OpenThreeElevenDirectory
    ;run, explorer "C:\"
    Return
}

OpenOverlayDirectory()
{
    MsgBox, OpenOverlayDirectory
    ;run, explorer "C:\"
    Return
}

OpenGageTrak()
{
    MsgBox, OpenGageTrak
    Return
}

OpenAutoCad()
{
    MsgBox, OpenAutoCad
    Return
}

OpenSmartProfileDirectory()
{
    MsgBox, OpenSmartProfileDirectory
    ; run, explorer "C:\"
    Return
}

OpenKeyenceDirectory()
{
    MsgBox, OpenKeyenceDirectory
    ; run, explorer "C:\"
    Return
}


OpenOutlook()
{
    ; MsgBox, OpenOutlook
    ; Return
    Process, Exist, outlook.exe
    If (ErrorLevel != 0)
    {
        WinActivate ahk_class rctrl_renwnd32
        WinWaitActive ahk_class rctrl_renwnd32
    }
    else
    {
        Run outlook.exe 
        ; WinWaitActive ahk_class rctrl_renwnd32
    }
    
    Return
}


