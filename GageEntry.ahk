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
	SendInput, C
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

InputBox, gageID, Enter GageID 
InputBox, resultsMessage, Enter Message

EnterGageByGageID(gageID, resultsMessage, false)


Gui, Add, Text, x12 y19 w80 h20 , Gage ID
Gui, Add, Edit, x102 y19 w220 h20 , Edit
Gui, Add, Text, x102 y169 w50 h-110 , Text
Gui, Add, Text, x12 y49 w80 h20 , Results
Gui, Add, Edit, x102 y49 w220 h20 , Edit
Gui, Add, CheckBox, x102 y79 w90 h20 , Add Print Label
Gui, Add, Button, x102 y119 w100 h30 , Execute

Gui, Show, x127 y87 h274 w458, New GUI Window
Return

GuiClose:
ExitApp