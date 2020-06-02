#include <hmg.ch>


Function colgrid()
	Local tmpmed:=""
	declare window main	
	cQuery := "Select Id, Nombre, Sect_No, Sub_Sector, Total_Col From Colonias Order By Id"
		bQuery := oServer:Query (cQuery)
		If bQuery:NetErr()
			Msgstop(bQuery:Error())
			Return Nil
		EndIf 
		main.grid_5.DeleteAllItems()
		For i := 1 To bQuery:LastRec()
			oRow := bQuery:GetRow(i)
			main.grid_5.AddItem({transform(oRow:fieldget("Id"),'99999'),oRow:FieldGet("Nombre"),transform(oRow:fieldget("sect_no"),'9'),;
			oRow:fieldget("sub_sector"), transform(oRow:fieldget("total_col"),'99999999999')})
			bQuery:Skip(1)
		Next
	bQuery:Destroy()
	main.Grid_5.Refresh 
Return Nil

Function colAbreReg()
Local nLinea:=0, aValue:={}
	If main.Grid_5.Value =0
		aValue := main.grid_5.item(1)
	Else
		nLinea := main.Grid_5.Value 
		aValue := main.Grid_5.Item (nLinea)
	EndIf 
	cQuery := "Select Id, Nombre, Sect_No, Sub_Sector, Total_Col From Colonias Where id = " + aValue[1]
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
        return Nil
    EndIf 
	oRow := bQuery:GetRow(1)
	main.text_27.Value := oRow:FieldGet("Id")
	main.text_28.Value := oRow:FieldGet("Nombre")
	main.text_29.Value := oRow:FieldGet("sect_no")
	main.text_30.Value := oRow:FieldGet("sub_sector")
	main.text_31.Value := oRow:FieldGet("total_col")
	bQuery:Destroy()
	main.text_27.ReadOnly := .T.
	main.text_28.ReadOnly := .T.
	main.text_29.ReadOnly := .T.
	main.text_30.ReadOnly := .T.
	main.text_31.ReadOnly := .T.
Return Nil

Function ColLimpReg()
	main.text_27.Value := 0
	main.text_28.Value := ""
	main.text_29.Value := 0
	main.text_30.Value := ""
	main.text_31.Value := 0
	main.text_27.ReadOnly := .T.
	main.text_28.ReadOnly := .T.
	main.text_29.ReadOnly := .T.
	main.text_30.ReadOnly := .T.
	main.text_31.ReadOnly := .T.
	Editar:=.F.
	main.ColSaveButt.enabled := .f.
Return Nil

Function ColNvoReg()
	ColLimpReg()
	main.text_27.ReadOnly := .F.
	main.text_28.ReadOnly := .F.
	main.text_29.ReadOnly := .F.
	main.text_30.ReadOnly := .F.
	main.text_31.ReadOnly := .F.
	main.text_28.SetFocus 
	main.ColSaveButt.enabled := .T.
	Editar:=.F.
Return Nil

Function ColGuardaReg()
//Local tmpid:="", tmpnom:="", tmpmed:="", tmpdom:="", tmpcom:="", tmpind:="", tmppub:=""
	If empty(main.text_28.value)
		MsgBox("Tiene que Ingresar Un Nombre.","Mensaje del Sistema.")
		main.text_28.SetFocus 
		return
	EndIf 
	tmpid  := transform(main.text_27.Value,"99999")
	tmpnom := alltrim(main.text_28.Value)
	tmpnse := transform(main.text_29.Value,"9")
	tmpsub := alltrim(main.text_30.Value)
	tmptcl := transform(main.text_31.Value,"99999999999")
	If Editar = .t.
		cQuery := "Update Colonias set Nombre='" + tmpnom + "',sect_no='" + tmpnse + "',sub_sector='";
		+ tmpsub + "',total_col='" + tmptcl + "' where id = " + tmpid
	Else
		cQuery := "Insert into Colonias (nombre, sect_no, sub_sector, total_col) values ('" + tmpnom ;
		+ "','" + tmpnse + "','" + tmpsub + "','" + tmptcl + "')"
	EndIf
	//MsgBox(cQuery)
	bQuery:=oServer:Query(cQuery)
	If bQuery:NetErr()												
	    MsgStop(bQuery:Error())
        return Nil
    Endif
    bQuery:Destroy()
	Colgrid()
ColLimpReg()
Return Nil

Function ColEditEnable()
	main.text_27.ReadOnly := .F.
	main.text_28.ReadOnly := .F.
	main.text_29.ReadOnly := .F.
	main.text_30.ReadOnly := .F.
	main.text_31.ReadOnly := .F.
	Editar:=.T.
	main.ColSaveButt.enabled := .T.
Return Nil