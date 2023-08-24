; ^	{Ctrl}	
; +	{Shift}	
; !	{Alt}	
; #	{LWin}
#NoEnv
#SingleInstance force

^n::
    OpenEverything()
    Return

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

#+6:: 
    OpenY26()
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

#+i:: 
    OpenSetupPics()
    Return

#+b:: 
    OpenBackup()
    Return


OpenSolidWorks()
{
    run, "C:\Program Files\SOLIDWORKS Corp\SOLIDWORKS (2)\"
    Return
}


OpenBackup()
{
    run, explorer "C:\Backup\"
    Return
}


OpenY26()
{
    run, explorer "\\rms-microvuy026\Microvu Programs"
    WinActivate ahk_exe Explorer.EXE
    Return
}


OpenSetupPics()
{
    run, explorer "V:\Inspect Programs\Micro-Vu\Approved Programs\Microvu\Microvu Setup Pics"
    WinActivate ahk_exe Explorer.EXE
    Return
}


OpenCMMDirectory()
{
    run, explorer "V:\Inspect Programs\CMM Programs\B_S Approved Programs\PDF Approved Programs"
    WinActivate ahk_exe Explorer.EXE
    Return
}


OpenWIPDirectory()
{
    run, explorer "X:\Quality Calibration\Work in Progress\Jeffrey"
    WinActivate ahk_exe Explorer.EXE
    Return
}


OpenTickets()
{
    Run, http://10.146.2.11:8080/ehelpdesk/login.glml
    sleep 1000
    SendInput jtwhitney
    SendInput {tab}
    SendRaw An0nym0us!
    SendInput {enter}
    Return
}

OpenFourTwentyDirectory()
{
    run, explorer "V:\Inspect Programs\Micro-Vu\Approved Programs\420\"
    WinActivate ahk_exe Explorer.EXE
    Return
}


OpenThreeFortyOneDirectory()
{
    run, explorer "V:\Inspect Programs\Micro-Vu\Approved Programs\341\"
    WinActivate ahk_exe Explorer.EXE
    Return
}

OpenThreeElevenDirectory()
{
    run, explorer "V:\Inspect Programs\Micro-Vu\Approved Programs\311\"
    WinActivate ahk_exe Explorer.EXE
    Return
}

OpenOverlayDirectory()
{
    run, explorer "V:\Inspect Programs\Overlays\"
    WinActivate ahk_exe Explorer.EXE
    Return
}

OpenGageTrak()
{
    Run, "C:\Program Files (x86)\Common Files\Sagekey Software\StartAccess_2003.exe" /runtime  /wrkgrp "C:\gagetrak\system.mdw" "C:\gagetrak\Gtw68.mdb"
    Sleep 3000
	SendInput J. Whitney
	SendInput {Tab}
	SendRaw An0nym0us!
	SendInput {Enter}
	Return
}

OpenAutoCad()
{
    MsgBox, OpenAutoCad
    Return
}

OpenSmartProfileDirectory()
{
    run, explorer "V:\Inspect Programs\Micro-Vu\Approved Programs\Smart Profile"
    WinActivate ahk_exe Explorer.EXE
    Return
}

OpenKeyenceDirectory()
{
	run, explorer "V:\Inspect Programs\Keyence\"
    WinActivate ahk_exe Explorer.EXE
	Return
}

OpenEverything()
{
    Run, "C:\Program Files\Everything\Everything.exe"
}

OpenOutlook()
{
    Process, Exist, outlook.exe
    If (ErrorLevel != 0)
    {
        WinActivate ahk_class rctrl_renwnd32
        WinWaitActive ahk_class rctrl_renwnd32
    }
    else
    {
        Run outlook.exe 
    }
    
    Return
}


