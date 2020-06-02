#include <hmg.ch>

Function CuaGrid()
	Local tmpmed:=""
	declare window main	
	cQuery := "Select Id, Nombre, Area, Departamento, Encargado, Vehiculo From Cuadrillas Order By Id"
		bQuery := oServer:Query (cQuery)
		If bQuery:NetErr()
			Msgstop(bQuery:Error())
			Return Nil
		EndIf 
		main.grid_9.DeleteAllItems()
		For i := 1 To bQuery:LastRec()
			oRow := bQuery:GetRow(i)
			main.grid_9.AddItem({transform(oRow:fieldget("Id"),'99999'),oRow:FieldGet("Nombre"),transform(oRow:fieldget("Area"),'99999'),;
			transform(oRow:fieldget("Departamento"),'99999'),oRow:fieldget("Encargado"),oRow:fieldget("Vehiculo")})
			bQuery:Skip(1)
		Next
	bQuery:Destroy()
	main.Grid_9.Refresh 
Return Nil

Function CuaAbreReg()
Local nLinea:=0, aValue:={}
	If main.Grid_9.Value =0
		aValue := main.grid_9.item(1)
	Else
		nLinea := main.Grid_9.Value 
		aValue := main.Grid_9.Item (nLinea)
	EndIf 
	cQuery := "Select Id, Nombre, Area, Departamento, Encargado, Vehiculo From Cuadrillas Where id = " + aValue[1]
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
        return Nil
    EndIf 
	oRow := bQuery:GetRow(1)
	main.text_43.Value := oRow:FieldGet("Id")
	main.text_44.Value := oRow:FieldGet("Nombre")
	main.text_45.Value := oRow:FieldGet("Area")
	main.text_46.Value := oRow:FieldGet("Departamento") 
	main.text_47.Value := oRow:FieldGet("Encargado")
	main.text_48.Value := oRow:FieldGet("Vehiculo")
	bQuery:Destroy()
	main.text_43.ReadOnly := .T.
	main.text_44.ReadOnly := .T.
	main.text_45.ReadOnly := .T.
	main.text_46.ReadOnly := .T.
	main.text_47.ReadOnly := .T.
	main.text_48.ReadOnly := .T.
Return Nil

Function CuaLimpReg()
	main.text_43.Value := 0
	main.text_44.Value := ""
	main.text_45.Value := 0
	main.text_46.Value := 0
	main.text_47.Value := ""
	main.text_48.Value := ""
	main.text_43.ReadOnly := .T.
	main.text_44.ReadOnly := .T.
	main.text_45.ReadOnly := .T.
	main.text_46.ReadOnly := .T.
	main.text_47.ReadOnly := .T.
	main.text_48.ReadOnly := .T.
	Editar:=.F.
	main.CuaSaveButt.enabled := .f.
Return Nil

Function CuaNvoReg()
	CuaLimpReg()
	main.text_43.ReadOnly := .F.
	main.text_44.ReadOnly := .F.
	main.text_45.ReadOnly := .F.
	main.text_46.ReadOnly := .F.
	main.text_47.ReadOnly := .F.
	main.text_48.ReadOnly := .F.
	main.text_44.SetFocus 
	main.CuaSaveButt.enabled := .T.
	Editar:=.F.
Return Nil

Function CuaGuardaReg()
//Local tmpid:="", tmpnom:="", tmpmed:="", tmpdom:="", tmpcom:="", tmpind:="", tmppub:=""
	If empty(main.text_44.value)
		MsgBox("Tiene que Ingresar Un Nombre de Cuadrilla.","Mensaje del Sistema.")
		main.text_44.SetFocus 
		return
	EndIf 
	If empty(main.text_45.value)
		MsgBox("Tiene que Ingresar Un Area.","Mensaje del Sistema.")
		main.text_45.SetFocus 
		return
	EndIf 
	If empty(main.text_46.value)
		MsgBox("Tiene que Ingresar Un Departamento.","Mensaje del Sistema.")
		main.text_46.SetFocus 
		return
	EndIf 
	tmpid  := transform(main.text_43.Value,"99999")
	tmpnom := alltrim(main.text_44.Value )
	tmpare := transform(main.text_45.Value,"99999")
	tmpdep := transform(main.text_46.Value,"99999")
	tmpenc := alltrim(main.text_47.Value)
	tmpveh := alltrim(main.text_48.Value)
	If Editar = .t.
		cQuery := "Update Cuadrillas set Nombre='" + tmpnom + "',Area='" + tmpare + "',Departamento='";
		+ tmpdep + "',Encargado='" + tmpenc + "',Vehiculo='" + tmpveh + "' where id = " + tmpid
	Else
		cQuery := "Insert into Cuadrillas (nombre,area,departamento,encargado,vehiculo) values ('" + tmpnom ;
		+ "','" + tmpare + "','" + tmpdep + "','" + tmpenc + "','" + tmpveh + "')"
	EndIf
	//MsgBox(cQuery)
	bQuery:=oServer:Query(cQuery)
	If bQuery:NetErr()												
	    MsgStop(bQuery:Error())
        return Nil
    Endif
    bQuery:Destroy()
	Cuagrid()
CuaLimpReg()
Return Nil

Function CuaEditEnable()
	main.text_43.ReadOnly := .F.
	main.text_44.ReadOnly := .F.
	main.text_45.ReadOnly := .F.
	main.text_46.ReadOnly := .F.
	main.text_47.ReadOnly := .F.
	main.text_48.ReadOnly := .F.
	Editar:=.T.
	main.CuaSaveButt.enabled := .T.
Return Nil