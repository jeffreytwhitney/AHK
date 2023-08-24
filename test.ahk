String= ( Dallas,Fort Worth, TX Coppell,TX Old town, Alexandria, VA Novato,CA ) 
;*********Use For loop over Var going line by line********************* 
for i, row in Loopobj:=StrSplit(String,"`n","`r") 
{ 
;use For loop to parse over line breaks 
S:=StrSplit(Row) 
for k, v in S m(k,v) 
{
    Pos:=InStr(Row,",",,0,1) 
    MsgBox % SubStr(Row,1,InStr(Row,",",,0,1)-1) "`r`r" trim(SubStr(row,InStr(Row,",",,0,1)+1)) 
}
} return