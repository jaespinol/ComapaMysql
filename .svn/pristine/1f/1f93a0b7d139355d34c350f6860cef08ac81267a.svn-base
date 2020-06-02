#include <hmg.ch>

Function diamgrid()
	Local tmpmed:=""
	declare window main	
	cQuery := "Select Id, Nombre, Medida,Precdom, PrecCom, PrecInd, PrecPub From Diametros Order By Id"
		bQuery := oServer:Query (cQuery)
		If bQuery:NetErr()
			Msgstop(bQuery:Error())
			Return Nil
		EndIf 
		main.grid_1.DeleteAllItems()
		For i := 1 To bQuery:LastRec()
			oRow := bQuery:GetRow(i)
			Do Case
			Case oRow:FieldGet("Medida")=val('0.5')
				tmpmed:="1/2 '"
			Case oRow:FieldGet("Medida")=val('0.25')
				tmpmed:="1/4 '"
			Case oRow:FieldGet("Medida")=val('0.75')
				tmpmed:="3/4 '"
			Case oRow:FieldGet("Medida")=Val('1')
				tmpmed:="1 '"
			Case oRow:FieldGet("Medida")=Val('2')
				tmpmed:="2 '"
			Case oRow:FieldGet("Medida")=Val('4')
				tmpmed:="4 '"
			Case oRow:FieldGet("Medida")=Val('6')
				tmpmed:="6 '"
			Case oRow:FieldGet("Medida")=Val('8')
				tmpmed:="8 '"
			OtherWise
				tmpmed:=str(oRow:FieldGet("Medida"))
			EndCase 
			main.grid_1.AddItem({transform(oRow:fieldget("Id"),'99999'),oRow:FieldGet("Nombre"), tmpmed,;
			transform(oRow:FieldGet("PrecDom"),'999,999,999.99'), transform(oRow:FieldGet("PrecCom"),'999,999,999.99'),;
			transform(oRow:FieldGet("PrecInd"),'999,999,999.99'),transform(oRow:FieldGet("PrecPub"),'999,999,999.99')})
			bQuery:Skip(1)
		Next
	bQuery:Destroy()
	main.Grid_1.Refresh 
Return Nil

Function DiaAbreReg()
Local nLinea:=0, aValue:={}
	If main.Grid_1.Value =0
		aValue := main.grid_1.item(1)
	Else
		nLinea := main.Grid_1.Value 
		aValue := main.Grid_1.Item (nLinea)
	EndIf 
	cQuery := "Select Id, Nombre, Medida,PrecDom, PrecCom, PrecInd, PrecPub From Diametros Where id = " + aValue[1]
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
        return Nil
    EndIf 
	oRow := bQuery:GetRow(1)
	main.text_2.Value := oRow:FieldGet("Id")
	main.text_6.Value := oRow:FieldGet("Nombre")
	main.text_7.Value := oRow:FieldGet("Medida")
	main.text_8.Value := oRow:FieldGet("PrecDom")
	main.text_9.Value := oRow:FieldGet("PrecCom")
	main.text_10.Value := oRow:FieldGet("PrecInd")
	main.text_11.Value := oRow:FieldGet("PrecPub")
	bQuery:Destroy()
	main.text_2.ReadOnly := .T.
	main.text_6.ReadOnly := .T.
	main.text_7.ReadOnly := .T.
	main.text_8.ReadOnly := .T.
	main.text_9.ReadOnly := .T.
	main.text_10.ReadOnly := .T.
	main.text_11.ReadOnly := .T.
Return Nil

Function DiamLimpReg()
	main.text_2.Value := 0
	main.text_6.Value := ""
	main.text_7.Value := 0
	main.text_8.Value := 0
	main.text_9.Value := 0
	main.text_10.Value := 0
	main.text_11.Value := 0
	main.text_2.ReadOnly := .T.
	main.text_6.ReadOnly := .T.
	main.text_7.ReadOnly := .T.
	main.text_8.ReadOnly := .T.
	main.text_9.ReadOnly := .T.
	main.text_10.ReadOnly := .T.
	main.text_11.ReadOnly := .T.
	Editar:=.F.
	main.diaSaveButt.enabled := .f.
Return Nil

Function DiamNvoReg()
	DiamLimpReg()
	main.text_2.ReadOnly := .F.
	main.text_6.ReadOnly := .F.
	main.text_7.ReadOnly := .F.
	main.text_8.ReadOnly := .F.
	main.text_9.ReadOnly := .F.
	main.text_10.ReadOnly := .F.
	main.text_11.ReadOnly := .F.
	main.text_6.SetFocus 
	main.diaSaveButt.enabled := .T.
	Editar:=.F.
Return Nil

Function DiamGuardaReg()
//Local tmpid:="", tmpnom:="", tmpmed:="", tmpdom:="", tmpcom:="", tmpind:="", tmppub:=""
	If empty(main.text_6.value)
		MsgBox("Tiene que Ingresar Un Nombre.","Mensaje del Sistema.")
		main.text_6.SetFocus 
		return
	EndIf 
	tmpid  := transform(main.text_2.Value,"99999")
	tmpnom := alltrim(main.text_6.Value )
	tmpmed := transform(main.text_7.Value,"999.99")
	tmpdom := transform(main.text_8.Value,"9999999.99")
	tmpcom := transform(main.text_9.Value,"9999999.99")
	tmpind := transform(main.text_10.Value,"9999999.99") 
	tmppub := transform(main.text_11.Value,"9999999.99")
	If Editar = .t.
		cQuery := "Update Diametros set nombre='" + tmpnom + "',medida='" + tmpmed + "',precdom='";
		+ tmpdom + "',preccom='" + tmpcom + "',precind='" + tmpind;
		+ "',precpub='" + tmppub + "' where id = " + tmpid
	Else
		cQuery := "Insert into Diametros (nombre,medida,precdom,preccom,precind,precpub) values ('" + tmpnom ;
		+ "','" + tmpmed + "','" + tmpdom + "','" + tmpcom + "','";
		+ tmpind + "','" + tmppub + "')"
	EndIf
	bQuery:=oServer:Query(cQuery)
	If bQuery:NetErr()												
	    MsgStop(bQuery:Error())
        return Nil
    Endif
    bQuery:Destroy()
	diamgrid()
DiamLimpReg()
Return Nil

Function DiamEditEnable()
	main.text_2.ReadOnly := .F.
	main.text_6.ReadOnly := .F.
	main.text_7.ReadOnly := .F.
	main.text_8.ReadOnly := .F.
	main.text_9.ReadOnly := .F.
	main.text_10.ReadOnly := .F.
	main.text_11.ReadOnly := .F.
	Editar:=.T.
	main.diaSaveButt.enabled := .T.
Return Nil