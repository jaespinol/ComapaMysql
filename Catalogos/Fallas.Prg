#include <hmg.ch>

Function Falgrid()
Local tmpmed:=""
declare window main	
cQuery := "select Id, Nombre, Letra From Falla Order By Id"
	bQuery := oServer:Query (cQuery)
	If bQuery:NetErr()
		Msgstop(bQuery:Error())
		Return Nil
	EndIf 
	main.grid_7.DeleteAllItems()
	For i := 1 To bQuery:LastRec()
		oRow := bQuery:GetRow(i)
				main.grid_7.AddItem({transform(oRow:fieldget("Id"),'99999'),oRow:FieldGet("Nombre"),oRow:FieldGet("Letra")})
		bQuery:Skip(1)
	Next
bQuery:Destroy()
main.Grid_7.Refresh 
Return Nil

Function FalAbreReg()
Local nLinea:=0, aValue:={}
	If main.Grid_7.Value =0
		aValue := main.grid_7.item(1)
	Else
		nLinea := main.Grid_7.Value 
		aValue := main.Grid_7.Item (nLinea)
	EndIf 
	cQuery := "Select Id, Nombre, Letra From Falla Where id = " + aValue[1]
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
        return Nil
    EndIf 
	oRow := bQuery:GetRow(1)
	main.text_34.Value := oRow:FieldGet("Id")
	main.text_35.Value := oRow:FieldGet("Nombre")
	main.text_36.Value := oRow:FieldGet("Letra")	
	bQuery:Destroy()
	main.text_34.ReadOnly := .T.
	main.text_35.ReadOnly := .T.
	main.text_36.ReadOnly := .T.
Return Nil

Function FalLimpReg()
	main.text_34.Value := 0
	main.text_35.Value := ""
	main.text_36.Value := ""
	main.text_34.ReadOnly := .T.
	main.text_35.ReadOnly := .T.
	main.text_36.ReadOnly := .T.
	Editar:=.F.
	main.FalSaveButt.enabled := .f.
Return Nil

Function FalNvoReg()
	FalLimpReg()
	main.text_34.ReadOnly := .F.
	main.text_35.ReadOnly := .F.
	main.text_36.ReadOnly := .F.
	main.text_35.SetFocus 
	main.FalSaveButt.enabled := .T.
	Editar:=.F.
Return Nil

Function FalGuardaReg()
//Local tmpid:="", tmpnom:="", tmpmed:="", tmpdom:="", tmpcom:="", tmpind:="", tmppub:=""
	If empty(main.text_35.value)
		MsgBox("Tiene que Ingresar Un Nombre.","Mensaje del Sistema.")
		main.text_35.SetFocus 
		return
	EndIf 
	tmpid  := transform(main.text_34.Value,"99999")
	tmpnom := alltrim(main.text_35.Value )
	tmplet := alltrim(main.text_36.Value )
	If Editar = .t.
		cQuery := "Update Falla set nombre='" + tmpnom + "',Letra='" + tmplet + "' where id = " + tmpid
	Else
		cQuery := "Insert into Falla (nombre, letra) values ('" + tmpnom + "','" + tmplet + "')"
	EndIf
	bQuery:=oServer:Query(cQuery)
	If bQuery:NetErr()												
	    MsgStop(bQuery:Error())
        return Nil
    Endif
    bQuery:Destroy()
	FalGrid()
FalLimpReg()
Return Nil

Function FalEditEnable()
	main.text_34.ReadOnly := .F.
	main.text_35.ReadOnly := .F.
	main.text_36.ReadOnly := .F.
	Editar:=.T.
	main.FalSaveButt.enabled := .T.
Return Nil