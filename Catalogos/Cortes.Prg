#include <hmg.ch>

Function corgrid()
	Local tmpmed:=""
	declare window main	
	cQuery := "Select Id, Nombre, Clave, precdom, preccom, precind From Tipocorte Order By Id"
		bQuery := oServer:Query (cQuery)
		If bQuery:NetErr()
			Msgstop(bQuery:Error())
			Return Nil
		EndIf 
		main.grid_8.DeleteAllItems()
		For i := 1 To bQuery:LastRec()
			oRow := bQuery:GetRow(i)
			main.grid_8.AddItem({transform(oRow:fieldget("Id"),'99999'),oRow:FieldGet("Clave"),oRow:FieldGet("Nombre"),;
			transform(oRow:fieldget("precdom"),'999,999,999.99'),transform(oRow:fieldget("preccom"),'999,999,999.99'),;
			transform(oRow:fieldget("precind"),'999,999,999.99')})
			bQuery:Skip(1)
		Next
	bQuery:Destroy()
	main.Grid_8.Refresh 
Return Nil

Function corAbreReg()
Local nLinea:=0, aValue:={}
	If main.Grid_8.Value =0
		aValue := main.grid_8.item(1)
	Else
		nLinea := main.Grid_8.Value 
		aValue := main.Grid_8.Item (nLinea)
	EndIf 
	cQuery := "Select Id, Nombre, Clave, precdom, preccom, precind From Tipocorte Where id = " + aValue[1]
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
        return Nil
    EndIf 
	oRow := bQuery:GetRow(1)
	main.text_37.Value := oRow:FieldGet("Id")
	main.text_38.Value := oRow:FieldGet("Clave")
	main.text_39.Value := oRow:FieldGet("Nombre")
	main.text_40.Value := oRow:FieldGet("precdom")
	main.text_41.Value := oRow:FieldGet("preccom")
	main.text_42.Value := oRow:FieldGet("precind")
	bQuery:Destroy()
	main.text_37.ReadOnly := .T.
	main.text_38.ReadOnly := .T.
	main.text_39.ReadOnly := .T.
	main.text_40.ReadOnly := .T.
	main.text_41.ReadOnly := .T.
	main.text_42.ReadOnly := .T.
Return Nil

Function CorLimpReg()
	main.text_37.Value := 0
	main.text_38.Value := ""
	main.text_39.Value := ""
	main.text_40.Value := 0
	main.text_41.Value := 0
	main.text_42.Value := 0
	main.text_37.ReadOnly := .T.
	main.text_38.ReadOnly := .T.
	main.text_39.ReadOnly := .T.
	main.text_40.ReadOnly := .T.
	main.text_41.ReadOnly := .T.
	main.text_42.ReadOnly := .T.
	Editar:=.F.
	main.CorSaveButt.enabled := .f.
Return Nil

Function CorNvoReg()
	CorLimpReg()
	main.text_37.ReadOnly := .F.
	main.text_38.ReadOnly := .F.
	main.text_39.ReadOnly := .F.
	main.text_40.ReadOnly := .F.
	main.text_41.ReadOnly := .F.
	main.text_42.ReadOnly := .F.
	main.text_38.SetFocus 
	main.CorSaveButt.enabled := .T.
	Editar:=.F.
Return Nil

Function CorGuardaReg()
//Local tmpid:="", tmpnom:="", tmpmed:="", tmpdom:="", tmpcom:="", tmpind:="", tmppub:=""
	If empty(main.text_39.value)
		MsgBox("Tiene que Ingresar Un Nombre.","Mensaje del Sistema.")
		main.text_39.SetFocus 
		return
	EndIf 
	If empty(main.text_40.value)
		MsgBox("Tiene que Ingresar Un Precio de Corte Domestico.","Mensaje del Sistema.")
		main.text_40.SetFocus 
		return
	EndIf 
	If empty(main.text_41.value)
		MsgBox("Tiene que Ingresar Un Precio de Corte Comercial.","Mensaje del Sistema.")
		main.text_41.SetFocus 
		return
	EndIf 
	If empty(main.text_42.value)
		MsgBox("Tiene que Ingresar Un Precio de Corte Industrial.","Mensaje del Sistema.")
		main.text_42.SetFocus 
		return
	EndIf 
	tmpid  := transform(main.text_37.Value,"99999")
	tmpnom := alltrim(main.text_39.Value)
	tmpcla := alltrim(main.text_38.Value)
	tmppdo := transform(main.text_40.Value,"999999999.99")
	tmppco := transform(main.text_41.Value,"999999999.99")
	tmppin := transform(main.text_42.Value,"999999999.99")
	If Editar = .t.
		cQuery := "Update Tipocorte set clave='" + tmpcla + "',Nombre='" + tmpnom + "',precdom='" + tmppdo + "',preccom='";
		+ tmppco + "',precind='" + tmppin + "' where id = " + tmpid
	Else
		cQuery := "Insert into Tipocorte (clave, nombre, precdom, preccom, precind) values ('" + tmpcla + "','" +tmpnom ;
		+ "','" + tmppdo + "','" + tmppco + "','" + tmppin +  "')"
	EndIf
	//MsgBox(cQuery)
	bQuery:=oServer:Query(cQuery)
	If bQuery:NetErr()												
	    MsgStop(bQuery:Error())
        return Nil
    Endif
    bQuery:Destroy()
	Corgrid()
CorLimpReg()
Return Nil

Function CorEditEnable()
	main.text_37.ReadOnly := .F.
	main.text_38.ReadOnly := .F.
	main.text_39.ReadOnly := .F.
	main.text_40.ReadOnly := .F.
	main.text_41.ReadOnly := .F.
	main.text_42.ReadOnly := .F.
	Editar:=.T.
	main.CorSaveButt.enabled := .T.
Return Nil