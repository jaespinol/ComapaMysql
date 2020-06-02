#include <hmg.ch>

Function tragrid()
	Local tmpmed:=""
	declare window main	
	cQuery := "Select Id, Nombre, Usuario,Contrasena, Tipo, Area From Trabajadores Order By Id"
		bQuery := oServer:Query (cQuery)
		If bQuery:NetErr()
			Msgstop(bQuery:Error())
			Return Nil
		EndIf 
		main.grid_3.DeleteAllItems()
		For i := 1 To bQuery:LastRec()
			oRow := bQuery:GetRow(i)
			main.grid_3.AddItem({transform(oRow:fieldget("Id"),'99999'),oRow:FieldGet("Nombre"),oRow:FieldGet("Usuario"),;
			oRow:FieldGet("Contrasena"),; //alltrim(hb_blowfishDecrypt(oRow:FieldGet("Constrasena"),alltrim(memoline(mvarsxy,100,1)))),; 
			transform(oRow:fieldget("Tipo"),'99999'),transform(oRow:fieldget("Area"),'99999')})
			bQuery:Skip(1)
		Next
	bQuery:Destroy()
	main.Grid_3.Refresh 
Return Nil

Function TraAbreReg()
Local nLinea:=0, aValue:={}
	If main.Grid_3.Value =0
		aValue := main.grid_3.item(1)
	Else
		nLinea := main.Grid_3.Value 
		aValue := main.Grid_3.Item (nLinea)
	EndIf 
	cQuery := "Select Id, Nombre, Usuario,Contrasena, Tipo, Area From Trabajadores Where id = " + aValue[1]
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
        return Nil
    EndIf 
	oRow := bQuery:GetRow(1)
	main.text_14.Value := oRow:FieldGet("Id")
	main.text_15.Value := oRow:FieldGet("Nombre")
	main.text_16.Value := oRow:FieldGet("Usuario")
	
	//main.text_17.Value := oRow:FieldGet("Contrasena") 
		main.text_17.Value := alltrim(hb_blowfishDecrypt(mvarpas,alltrim(oRow:FieldGet("Contrasena"))))
		//hb_blowfishDecrypt(oRow:FieldGet("Contrasena"),mvarsxy)
	
	main.text_18.Value := oRow:FieldGet("Tipo")
	main.text_19.Value := oRow:FieldGet("Area")
	bQuery:Destroy()
	main.text_14.ReadOnly := .T.
	main.text_15.ReadOnly := .T.
	main.text_16.ReadOnly := .T.
	main.text_17.ReadOnly := .T.
	main.text_18.ReadOnly := .T.
	main.text_19.ReadOnly := .T.
Return Nil

Function TraLimpReg()
	main.text_14.Value := 0
	main.text_15.Value := ""
	main.text_16.Value := ""
	main.text_17.Value := ""
	main.text_18.Value := 0
	main.text_19.Value := 0
	main.text_14.ReadOnly := .T.
	main.text_15.ReadOnly := .T.
	main.text_16.ReadOnly := .T.
	main.text_17.ReadOnly := .T.
	main.text_18.ReadOnly := .T.
	main.text_19.ReadOnly := .T.
	Editar:=.F.
	main.TraSaveButt.enabled := .f.
Return Nil

Function TraNvoReg()
	TraLimpReg()
	main.text_14.ReadOnly := .F.
	main.text_15.ReadOnly := .F.
	main.text_16.ReadOnly := .F.
	main.text_17.ReadOnly := .F.
	main.text_18.ReadOnly := .F.
	main.text_19.ReadOnly := .F.
	main.text_15.SetFocus 
	main.TraSaveButt.enabled := .T.
	Editar:=.F.
Return Nil

Function TraGuardaReg()
//Local tmpid:="", tmpnom:="", tmpmed:="", tmpdom:="", tmpcom:="", tmpind:="", tmppub:=""
	If empty(main.text_15.value)
		MsgBox("Tiene que Ingresar Un Nombre.","Mensaje del Sistema.")
		main.text_15.SetFocus 
		return
	EndIf 
	If empty(main.text_16.value)
		MsgBox("Tiene que Ingresar Un Usuario.","Mensaje del Sistema.")
		main.text_16.SetFocus 
		return
	EndIf 
	If empty(main.text_17.value)
		MsgBox("Tiene que Ingresar Una Contrasena.","Mensaje del Sistema.")
		main.text_17.SetFocus 
		return
	EndIf 
	tmpid  := transform(main.text_14.Value,"99999")
	tmpnom := alltrim(main.text_15.Value )
	tmpusu := alltrim(main.text_16.Value)
	tmppas := alltrim(hb_blowfishEncrypt(mvarpas,alltrim(main.text_17.Value))) //oRow:FieldGet("Contrasena"))
	tmptip := transform(main.text_18.Value,"99999")
	tmpare := transform(main.text_19.Value,"99999")
	If Editar = .t.
		cQuery := "Update Trabajadores set Nombre='" + tmpnom + "',Usuario='" + tmpusu + "',Contrasena='";
		+ tmppas + "',Tipo='" + tmptip + "',Area='" + tmpare + "' where id = " + tmpid
	Else
		cQuery := "Insert into Trabajadores (nombre,usuario,contrasena,tipo,area) values ('" + tmpnom ;
		+ "','" + tmpusu + "','" + tmppas + "','" + tmptip + "','" + tmpare + "')"
	EndIf
	//MsgBox(cQuery)
	bQuery:=oServer:Query(cQuery)
	If bQuery:NetErr()												
	    MsgStop(bQuery:Error())
        return Nil
    Endif
    bQuery:Destroy()
	Tragrid()
TraLimpReg()
Return Nil

Function TraEditEnable()
	main.text_14.ReadOnly := .F.
	main.text_15.ReadOnly := .F.
	main.text_16.ReadOnly := .F.
	main.text_17.ReadOnly := .F.
	main.text_18.ReadOnly := .F.
	main.text_19.ReadOnly := .F.
	Editar:=.T.
	main.TraSaveButt.enabled := .T.
Return Nil