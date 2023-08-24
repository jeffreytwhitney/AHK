; ^	{Ctrl}	
; +	{Shift}	
; !	{Alt}	
; #	{LWin}
#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%






ExecutePCDMISTest(gageID, resultsMessage, addLabel)
{
	   
    WinActivate, PC-DMIS 
	Sleep, 1000
	Send, {Tab 5}
    
}


ExecutePCDMISTest(1,2,3)