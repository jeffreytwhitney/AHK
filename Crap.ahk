#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%



Process, Exist, pcdlrn.exe
    If (ErrorLevel != 0)
    {
        MsgBox "Yep"
        ;WinActivate ahk_class rctrl_renwnd32
        ;WinWaitActive ahk_class rctrl_renwnd32
    }
    else
    {
        Run 
        MsgBox "nope"
        ;Run outlook.exe 
    }
    
    Return