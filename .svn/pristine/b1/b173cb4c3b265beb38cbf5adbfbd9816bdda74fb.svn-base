#include <hmg.ch>


Function Calgrid()

Local tmpmed:=""
declare window main	
cQuery := "select Id, Nombre From Calles Order By Id"
	bQuery := oServer:Query (cQuery)
	If bQuery:NetErr()
		Msgstop(bQuery:Error())
		Return Nil
	EndIf 
	main.grid_6.DeleteAllItems()
	For i := 1 To bQuery:LastRec()
		oRow := bQuery:GetRow(i)
				main.grid_6.AddItem({transform(oRow:fieldget("Id"),'99999'),oRow:FieldGet("Nombre")})
		bQuery:Skip(1)
	Next
bQuery:Destroy()
main.Grid_6.Refresh 
Return Nil

Function CalAbreReg()
Local nLinea:=0, aValue:={}
	If main.Grid_6.Value =0
		aValue := main.grid_6.item(1)
	Else
		nLinea := main.Grid_6.Value 
		aValue := main.Grid_6.Item (nLinea)
	EndIf 
	cQuery := "Select Id, Nombre From Calles Where id = " + aValue[1]
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
        return Nil
    EndIf 
	oRow := bQuery:GetRow(1)
	main.text_32.Value := oRow:FieldGet("Id")
	main.text_33.Value := oRow:FieldGet("Nombre")
	
	bQuery:Destroy()
	main.text_32.ReadOnly := .T.
	main.text_33.ReadOnly := .T.
Return Nil

Function CalLimpReg()
	main.text_22.Value := 0
	main.text_33.Value := ""
	main.text_22.ReadOnly := .T.
	main.text_33.ReadOnly := .T.
	Editar:=.F.
	main.CalSaveButt.enabled := .f.
Return Nil

Function CalNvoReg()
	CalLimpReg()
	main.text_32.ReadOnly := .F.
	main.text_33.ReadOnly := .F.
	main.text_33.SetFocus 
	main.CalSaveButt.enabled := .T.
	Editar:=.F.
Return Nil

Function CalGuardaReg()
//Local tmpid:="", tmpnom:="", tmpmed:="", tmpdom:="", tmpcom:="", tmpind:="", tmppub:=""
	If empty(main.text_33.value)
		MsgBox("Tiene que Ingresar Un Nombre.","Mensaje del Sistema.")
		main.text_33.SetFocus 
		return
	EndIf 
	tmpid  := transform(main.text_32.Value,"99999")
	tmpnom := alltrim(main.text_33.Value )
	If Editar = .t.
		cQuery := "Update Calles set nombre='" + tmpnom + "' where id = " + tmpid
	Else
		cQuery := "Insert into Calles (nombre) values ('" + tmpnom + "')"
	EndIf
	bQuery:=oServer:Query(cQuery)
	If bQuery:NetErr()												
	    MsgStop(bQuery:Error())
        return Nil
    Endif
    bQuery:Destroy()
	CalGrid()
CalLimpReg()
Return Nil

Function CalEditEnable()
	main.text_32.ReadOnly := .F.
	main.text_33.ReadOnly := .F.
	Editar:=.T.
	main.CalSaveButt.enabled := .T.
Return Nil