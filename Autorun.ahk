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



OpenSolidWorks()
{
    run, "C:\Program Files\SOLIDWORKS Corp\SOLIDWORKS (2)\"
    Return
}




OpenY26()
{
    run, explorer "\\rms-microvuy026\Microvu Programs"
    Return
}


OpenSetupPics()
{
    run, explorer "V:\Inspect Programs\Micro-Vu\Approved Programs\Microvu\Microvu Setup Pics"
    Return
}


OpenCMMDirectory()
{
    run, explorer "V:\Inspect Programs\CMM Programs\B_S Approved Programs\PDF Approved Programs"
    Return
}


OpenWIPDirectory()
{
    run, explorer "X:\Quality Calibration\Work in Progress\Jeffrey"
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
    Return
}


OpenThreeFortyOneDirectory()
{
    run, explorer "V:\Inspect Programs\Micro-Vu\Approved Programs\341\"
    Return
}

OpenThreeElevenDirectory()
{
    run, explorer "V:\Inspect Programs\Micro-Vu\Approved Programs\311\"
    Return
}

OpenOverlayDirectory()
{
    run, explorer "V:\Inspect Programs\Overlays\"
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
    Return
}

OpenKeyenceDirectory()
{
	run, explorer "V:\Inspect Programs\Keyence\"
	Return
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


