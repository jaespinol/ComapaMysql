#include <hmg.ch>

Function estagrid()

Local tmpmed:=""
declare window main	
cQuery := "select Id, Nombre From Estatus Order By Id"
	bQuery := oServer:Query (cQuery)
	If bQuery:NetErr()
		Msgstop(bQuery:Error())
		Return Nil
	EndIf 
	main.grid_2.DeleteAllItems()
	For i := 1 To bQuery:LastRec()
		oRow := bQuery:GetRow(i)
				main.grid_2.AddItem({transform(oRow:fieldget("Id"),'99999'),oRow:FieldGet("Nombre")})
		bQuery:Skip(1)
	Next
bQuery:Destroy()
main.Grid_2.Refresh 
Return Nil

Function EstAbreReg()
Local nLinea:=0, aValue:={}
	If main.Grid_2.Value =0
		aValue := main.grid_2.item(1)
	Else
		nLinea := main.Grid_2.Value 
		aValue := main.Grid_2.Item (nLinea)
	EndIf 
	cQuery := "Select Id, Nombre From Estatus Where id = " + aValue[1]
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
        return Nil
    EndIf 
	oRow := bQuery:GetRow(1)
	main.text_12.Value := oRow:FieldGet("Id")
	main.text_13.Value := oRow:FieldGet("Nombre")
	
	bQuery:Destroy()
	main.text_12.ReadOnly := .T.
	main.text_13.ReadOnly := .T.
Return Nil

Function EstLimpReg()
	main.text_12.Value := 0
	main.text_13.Value := ""
	main.text_12.ReadOnly := .T.
	main.text_13.ReadOnly := .T.
	Editar:=.F.
	main.EstSaveButt.enabled := .f.
Return Nil

Function EstNvoReg()
	EstLimpReg()
	main.text_12.ReadOnly := .F.
	main.text_13.ReadOnly := .F.
	main.text_12.SetFocus 
	main.EstSaveButt.enabled := .T.
	Editar:=.F.
Return Nil

Function EstGuardaReg()
//Local tmpid:="", tmpnom:="", tmpmed:="", tmpdom:="", tmpcom:="", tmpind:="", tmppub:=""
	If empty(main.text_13.value)
		MsgBox("Tiene que Ingresar Un Nombre.","Mensaje del Sistema.")
		main.text_13.SetFocus 
		return
	EndIf 
	tmpid  := transform(main.text_12.Value,"99999")
	tmpnom := alltrim(main.text_13.Value )
	If Editar = .t.
		cQuery := "Update Estatus set nombre='" + tmpnom + "' where id = " + tmpid
	Else
		cQuery := "Insert into Estatus (nombre) values ('" + tmpnom + "')"
	EndIf
	bQuery:=oServer:Query(cQuery)
	If bQuery:NetErr()												
	    MsgStop(bQuery:Error())
        return Nil
    Endif
    bQuery:Destroy()
	Estagrid()
EstLimpReg()
Return Nil

Function EstEditEnable()
	main.text_12.ReadOnly := .F.
	main.text_13.ReadOnly := .F.
	Editar:=.T.
	main.EstSaveButt.enabled := .T.
Return Nil