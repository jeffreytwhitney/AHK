#SingleInstance, Force
SendMode Input 


FormatTime, time_stamp, , yy_MM_dd-hh_mm_tt
outputDirectory := "X:\Quality Calibration\Work in Progress\Jeffrey\Backup\MPM_be" . time_stamp . ".accdb"
inputDirectory := "X:\Quality Calibration\Project Management Database\MPM_be.accdb"


SetWorkingDir, %A_ScriptDir%
FileCopy, %inputDirectory%, %outputDirectory%, 1
message = MPM_be database has been copied to '%outputDirectory%'.
MsgBox, 64,, %message%
