#include <hmg.ch>

Function DepGrid()
	Local tmpmed:=""
	declare window main	
	cQuery := "Select Id, Nombre, Dependencia, jefe From Departamentos Order By Id"
		bQuery := oServer:Query (cQuery)
		If bQuery:NetErr()
			Msgstop(bQuery:Error())
			Return Nil
		EndIf 
		main.grid_10.DeleteAllItems()
		For i := 1 To bQuery:LastRec()
			oRow := bQuery:GetRow(i)
			main.grid_10.AddItem({transform(oRow:fieldget("Id"),'99999'),oRow:FieldGet("Nombre"),transform(oRow:fieldget("Dependencia"),'99999'),;
			oRow:FieldGet("Jefe")})
			bQuery:Skip(1)
		Next
	bQuery:Destroy()
	main.Grid_10.Refresh 
Return Nil

Function DepAbreReg()
Local nLinea:=0, aValue:={}
	If main.Grid_10.Value =0
		aValue := main.grid_10.item(1)
	Else
		nLinea := main.Grid_10.Value 
		aValue := main.Grid_10.Item (nLinea)
	EndIf 
	cQuery := "Select Id, Nombre, Dependencia, jefe From Departamentos Where id = " + aValue[1]
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
        return Nil
    EndIf 
	oRow := bQuery:GetRow(1)
	main.text_49.Value := oRow:FieldGet("Id")
	main.text_50.Value := oRow:FieldGet("Nombre")
	main.text_51.Value := oRow:FieldGet("Dependencia")
	main.text_52.Value := oRow:FieldGet("jefe")
	bQuery:Destroy()
	main.text_49.ReadOnly := .T.
	main.text_50.ReadOnly := .T.
	main.text_51.ReadOnly := .T.
	main.text_52.ReadOnly := .T.
Return Nil

Function DepLimpReg()
	main.text_49.Value := 0
	main.text_50.Value := ""
	main.text_51.Value := 0
	main.text_52.Value := ""
	main.text_49.ReadOnly := .T.
	main.text_50.ReadOnly := .T.
	main.text_51.ReadOnly := .T.
	main.text_52.ReadOnly := .T.
	Editar:=.F.
	main.DepSaveButt.enabled := .f.
Return Nil

Function DepNvoReg()
	DepLimpReg()
	main.text_49.ReadOnly := .F.
	main.text_50.ReadOnly := .F.
	main.text_51.ReadOnly := .F.
	main.text_52.ReadOnly := .F.
	main.text_50.SetFocus 
	main.DepSaveButt.enabled := .T.
	Editar:=.F.
Return Nil

Function DepGuardaReg()
//Local tmpid:="", tmpnom:="", tmpmed:="", tmpdom:="", tmpcom:="", tmpind:="", tmppub:=""
	If empty(main.text_50.value)
		MsgBox("Tiene que Ingresar Un Nombre Para El Departamento.","Mensaje del Sistema.")
		main.text_50.SetFocus 
		return
	EndIf 
	tmpid  := transform(main.text_49.Value,"99999")
	tmpnom := alltrim(main.text_50.Value )
	tmpdep := transform(main.text_51.Value,"99999")
	tmpjef := alltrim(main.text_52.Value )
	If Editar = .t.
		cQuery := "Update Departamentos set Nombre='" + tmpnom + "',Dependencia='" + tmpdep + "',jefe='";
		+ tmpjef + "' where id = " + tmpid
	Else
		cQuery := "Insert into Departamentos(nombre,dependencia,jefe) values ('" + tmpnom ;
		+ "','" + tmpdep + "','" + tmpjef + "')"
	EndIf
	//MsgBox(cQuery)
	bQuery:=oServer:Query(cQuery)
	If bQuery:NetErr()												
	    MsgStop(bQuery:Error())
        return Nil
    Endif
    bQuery:Destroy()
	Depgrid()
DepLimpReg()
Return Nil

Function DepEditEnable()
	main.text_49.ReadOnly := .F.
	main.text_50.ReadOnly := .F.
	main.text_51.ReadOnly := .F.
	main.text_52.ReadOnly := .F.
	Editar:=.T.
	main.DepSaveButt.enabled := .T.
Return Nil