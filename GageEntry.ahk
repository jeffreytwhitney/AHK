; ^	{Ctrl}	
; +	{Shift}	
; !	{Alt}	
; #	{LWin}


#NoEnv
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Window
SendMode Input
#SingleInstance Force
SetTitleMatchMode 2
#WinActivateForce
SetControlDelay 1
SetWinDelay 0
SetKeyDelay 10
SetMouseDelay -1
SetBatchLines -1


EnterGageByGageID(gageID, resultsMessage, addLabel)
{
	WinActivate, GAGEtrak 6.8 ahk_class OMain
	Sleep, 333
	Click, 350, 74 
	Sleep, 1000
	WinActivate, Filter Gage Entry ahk_class OFormPopup
	Sleep, 100
	SendInput, %gageID%
	SendInput, {Enter}
	Sleep, 100
	WinActivate, GAGEtrak 6.8 ahk_class OMain
	Sleep, 333
	SendInput, +{TAB 3}
	SendInput, {Enter}
	Sleep, 333
	SendInput ^{+}
	SendInput, {TAB 6}
	SendInput, CALIBRATION
	Sleep, 10
	SendInput, {Enter}
	SendInput, {TAB 2}
	SendInput, %resultsMessage%
	SendInput, {TAB 4}
	Sleep, 3000
	SendInput, {Space}
	Sleep, 3000
	WinWaitActive, GAGEtrak 6.8 ahk_class OMain,, 15
	if ErrorLevel
	{
		MsgBox, WinWait timed out.
		return
	}
	else
	{	
		SendInput, {TAB 26}
		SendInput, {Enter}
		Return
	}
}

EnterGageBySerialNumber(gageID, resultsMessage, addLabel)
{
	WinActivate, GAGEtrak 6.8 ahk_class OMain
	Sleep, 333
	Click, 350, 74 
	Sleep, 1000
	WinActivate, Filter Gage Entry ahk_class OFormPopup
	Sleep, 100
	
	
	
	Return
}



 EnterGageByGageID("PM-0031", "OK", false)

