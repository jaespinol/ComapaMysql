#include <hmg.ch>


Function congrid()
	Local tmpmed:=""
	declare window main	
	cQuery := "Select Id, Nombre, Aplicacion, No_cta, Cve_cta, Imp_cpto, Ivaxc From Concepto Order By Id"
		bQuery := oServer:Query (cQuery)
		If bQuery:NetErr()
			Msgstop(bQuery:Error())
			Return Nil
		EndIf 
		main.grid_4.DeleteAllItems()
		For i := 1 To bQuery:LastRec()
			oRow := bQuery:GetRow(i)
			main.grid_4.AddItem({transform(oRow:fieldget("Id"),'99999'),oRow:FieldGet("Nombre"),transform(oRow:fieldget("Aplicacion"),'9'),;
			transform(oRow:fieldget("No_cta"),'999'),; //alltrim(hb_blowfishDecrypt(oRow:FieldGet("Constrasena"),alltrim(memoline(mvarsxy,100,1)))),; 
			transform(oRow:fieldget("Cve_cta"),'999999'),transform(oRow:fieldget("Imp_cpto"),'9,999,999,999.99'),transform(oRow:fieldget("Ivaxc"),'99,999,999,999.99')})
			bQuery:Skip(1)
		Next
	bQuery:Destroy()
	main.Grid_4.Refresh 
Return Nil

Function conAbreReg()
Local nLinea:=0, aValue:={}
	If main.Grid_4.Value =0
		aValue := main.grid_4.item(1)
	Else
		nLinea := main.Grid_4.Value 
		aValue := main.Grid_4.Item (nLinea)
	EndIf 
	cQuery := "Select Id, Nombre, Aplicacion, No_cta, Cve_cta, Imp_cpto, Ivaxc From Concepto Where id = " + aValue[1]
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
        return Nil
    EndIf 
	oRow := bQuery:GetRow(1)
	main.text_20.Value := oRow:FieldGet("Id")
	main.text_21.Value := oRow:FieldGet("Nombre")
	main.text_22.Value := oRow:FieldGet("Aplicacion")
	main.text_23.Value := oRow:FieldGet("No_cta")
	main.text_24.Value := oRow:FieldGet("Cve_cta")
	main.text_25.Value := oRow:FieldGet("Imp_cpto")
	main.text_26.Value := oRow:FieldGet("Ivaxc")
	bQuery:Destroy()
	main.text_20.ReadOnly := .T.
	main.text_21.ReadOnly := .T.
	main.text_22.ReadOnly := .T.
	main.text_23.ReadOnly := .T.
	main.text_24.ReadOnly := .T.
	main.text_25.ReadOnly := .T.
	main.text_26.ReadOnly := .T.
Return Nil

Function conLimpReg()
	main.text_20.Value := 0
	main.text_21.Value := ""
	main.text_22.Value := 0
	main.text_23.Value := 0
	main.text_24.Value := 0
	main.text_25.Value := 0
	main.text_26.Value := 0
	main.text_20.ReadOnly := .T.
	main.text_21.ReadOnly := .T.
	main.text_22.ReadOnly := .T.
	main.text_23.ReadOnly := .T.
	main.text_24.ReadOnly := .T.
	main.text_25.ReadOnly := .T.
	main.text_26.ReadOnly := .T.
	Editar:=.F.
	main.conSaveButt.enabled := .f.
Return Nil

Function conNvoReg()
	conLimpReg()
	main.text_20.ReadOnly := .F.
	main.text_21.ReadOnly := .F.
	main.text_22.ReadOnly := .F.
	main.text_23.ReadOnly := .F.
	main.text_24.ReadOnly := .F.
	main.text_25.ReadOnly := .F.
	main.text_26.ReadOnly := .F.
	main.text_21.SetFocus 
	main.ConSaveButt.enabled := .T.
	Editar:=.F.
Return Nil

Function ConGuardaReg()
//Local tmpid:="", tmpnom:="", tmpmed:="", tmpdom:="", tmpcom:="", tmpind:="", tmppub:=""
	If empty(main.text_21.value)
		MsgBox("Tiene que Ingresar Un Nombre.","Mensaje del Sistema.")
		main.text_21.SetFocus 
		return
	EndIf 
	tmpid  := transform(main.text_20.Value,"99999")
	tmpnom := alltrim(main.text_21.Value )
	tmpapl := transform(main.text_22.Value,"9")
	tmpnct := transform(main.text_23.Value,"999")
	tmpcve := transform(main.text_24.Value,"999999")
	tmpimp := transform(main.text_25.Value,"9999999999.99")
	tmpiva := transform(main.text_26.Value,"99999999999.99")
	If Editar = .t.
		cQuery := "Update Concepto set Nombre='" + tmpnom + "',aplicacion='" + tmpapl + "',no_cta='";
		+ tmpnct + "',cve_cta='" + tmpcve + "',imp_cpto='" + tmpimp + "',ivaxc='" + tmpiva + "' where id = " + tmpid
	Else
		cQuery := "Insert into Concepto (nombre,aplicacion, no_cta, cve_cta, imp_cpto, ivaxc) values ('" + tmpnom ;
		+ "','" + tmpapl + "','" + tmpnct + "','" + tmpcve + "','" + tmpimp + "','" + tmpiva + "')"
	EndIf
	//MsgBox(cQuery)
	bQuery:=oServer:Query(cQuery)
	If bQuery:NetErr()												
	    MsgStop(bQuery:Error())
        return Nil
    Endif
    bQuery:Destroy()
	Congrid()
ConLimpReg()
Return Nil

Function ConEditEnable()
	main.text_20.ReadOnly := .F.
	main.text_21.ReadOnly := .F.
	main.text_22.ReadOnly := .F.
	main.text_23.ReadOnly := .F.
	main.text_24.ReadOnly := .F.
	main.text_25.ReadOnly := .F.
	main.text_26.ReadOnly := .F.
	Editar:=.T.
	main.ConSaveButt.enabled := .T.
Return Nil