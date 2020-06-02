#include <hmg.ch>

function loadlistpadron
public flagop:=.f.,mfecante,flagentra:=0, lopcion:=1
ahora := 0
   IF !IsWindowDefined(Padron) 
       Load Window Padron
       Center Window Padron
       Activate Window Padron
   endIf
return

Function aumenta()
ahora++
padron.button_1.enabled:=.f.
padron.button_2.enabled:=.f.
padron.grid_1.enabled:=.f.
LoadPdrGrid(lopcion)
Return Nil
Function disminuye()
ahora--
padron.button_1.enabled:=.f.
padron.button_2.enabled:=.f.
padron.grid_1.enabled:=.F.
LoadPdrGrid(lopcion)
Return Nil

Function LoadPdrGrid()
parameters lopcion
Declare Window Padron
Local n:=0,hojas:=0, filaini:=0, filafin:=0, sumandolos:=0
cQuery := "select Ruta, Folio, Cuenta, Nombre, Domicilio, Contrato, Medidor From Padron"
bQuery := oServer:Query (cQuery)
	If bQuery:NetErr()
		Msgstop(bQuery:Error())
		Return Nil
	EndIf 
hojas:= round(bQuery:LastRec()/1000,0)
bQuery:Destroy()
Do Case 
	Case lopcion = 1
	cQuery := "select Ruta, Folio, Cuenta, Nombre, Domicilio, Contrato, Medidor From Padron Order By Ruta,Folio limit " + Str(ahora*1000) + ",1000 "
	Case lopcion = 2
	cQuery := "select Ruta, Folio, Cuenta, Nombre, Domicilio, Contrato, Medidor From Padron Order By Cuenta limit " + Str(ahora*1000) + ",1000 "
	Case lopcion = 3
	cQuery := "select Ruta, Folio, Cuenta, Nombre, Domicilio, Contrato, Medidor From Padron Order By Contrato limit " + Str(ahora*1000) + ",1000 "
	Case lopcion = 4
	cQuery := "select Ruta, Folio, Cuenta, Nombre, Domicilio, Contrato, Medidor From Padron Order By Medidor limit " + Str(ahora*1000) + ",1000 "
	Case lopcion = 5
	cQuery := "select Ruta, Folio, Cuenta, Nombre, Domicilio, Contrato, Medidor From Padron Order By Ruta limit " + Str(ahora*1000) + ",1000 "
	Case lopcion = 6
	cQuery := "select Ruta, Folio, Cuenta, Nombre, Domicilio, Contrato, Medidor From Padron Order By Nombre limit " + Str(ahora*1000) + ",1000 "
	Case lopcion = 7
	cQuery := "select Ruta, Folio, Cuenta, Nombre, Domicilio, Contrato, Medidor From Padron Order By Domicilio limit " + Str(ahora*1000) + ",1000 "
	Case lopcion = 8
	cQuery := "select Ruta, Folio, Cuenta, Nombre, Domicilio, Contrato, Medidor From Padron Order By Estatus limit " + Str(ahora*1000) + ",1000 "
	Case lopcion = 9
	cQuery := "select Ruta, Folio, Cuenta, Nombre, Domicilio, Contrato, Medidor From Padron Order By Tipo_usu limit " + Str(ahora*1000) + ",1000 "
EndCase 
	bQuery := oServer:Query (cQuery)
	If bQuery:NetErr()
		Msgstop(bQuery:Error())
		Return Nil
	EndIf 
	Padron.grid_1.DeleteAllItems()
padron.label_1.Value := "Hoja"+str(ahora)+" / "+str(hojas)
		filafin:=ahora*10000
		filaini:=filafin-10000
 
//If primer= 1
	For i := 1 to bQuery:LastRec() //filaini To filafin // //
		If n=500
			Doevents()
			n=0
		EndIf 
		n++
		oRow := bQuery:GetRow(i)
		If val(oRow:FieldGet("contrato")) > 0
			Padron.grid_1.AddItem({oRow:FieldGet("Ruta")+ "-" + oRow:FieldGet("Folio"),oRow:FieldGet("Cuenta"),;
					alltrim(oRow:FieldGet("Nombre")),alltrim(oRow:FieldGet("Domicilio")),oRow:FieldGet("Contrato"),oRow:FieldGet("Medidor")})
		EndIf 
		sumandolos++
		padron.label_2.Value := str(sumandolos)
	Next

//	muestrainf(1)
//	ahora:=1
bQuery:Destroy()
padron.button_1.enabled:=.t.
padron.button_2.enabled:=.t.
padron.grid_1.enabled:=.t.
//MsgBox(str(ahora),"")
//Padron.Grid_1.Refresh 
Return Nil

//////para la pantalla de AltaPadron//////////////////////////////////////
function loadaltapad
   parameters flagoppad
   IF !IsWindowDefined(Altapadron) 
       Load Window altapadron
       AltaPadron.combo_1.enabled:=.f.
       AltaPadron.combo_2.enabled:=.f.
       AltaPadron.combo_3.enabled:=.f.
       AltaPadron.combo_4.enabled:=.f.
       if flagoppad = 2
	   	If padron.Grid_1.Value =0
				aValue := padron.grid_1.item(1)
			Else
				nLinea := padron.Grid_1.Value 
				aValue := padron.Grid_1.Item (nLinea)
			EndIf
			CargaInfoPad()
			AltaPadron.label_17.visible:=.t.
         AltaPadron.text_12.visible:=.t.
         AltaPadron.label_1.visible:=.f.
         AltaPadron.text_1.visible:=.f.
			AltaPadron.text_1.enabled:=.f.
         AltaPadron.text_2.visible:=.f.
       endif
       AltaPadron.radiogroup_1.enabled:=.f.
       AltaPadron.radiogroup_2.enabled:=.f.
       //AltaPadron.button_1.enabled:=.f.
		 activared()
       Center Window AltaPadron
       Activate Window AltaPadron
   endIf
return

Function CargaInfoPad()
Local tmptoma:="", tmpTusu:="", tmpFpag:="", tmpStat:=""
declare window AltaPadron
declare Window Padron
	cQuery := "select Ruta, Folio, Contrato, Predio, Minimo, Serv_Dren, Cuenta, Nombre, Domicilio, Contrato, Medidor, Estatus, Tipo_usu, Fte_pag, Sector, Toma, Colonia, Tarifa, meses_rez From Padron Where  cuenta= " + aValue[2]
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
        return Nil
    EndIf 
	oRow := bQuery:GetRow(1)
	AltaPadron.text_3.Value := oRow:FieldGet("Ruta")
	AltaPadron.text_4.Value := oRow:FieldGet("Folio")	
	AltaPadron.text_5.Value := oRow:FieldGet("Contrato")
	AltaPadron.text_6.Value := oRow:FieldGet("Predio")
	AltaPadron.text_7.Value := oRow:FieldGet("Nombre")
	AltaPadron.text_8.Value := oRow:FieldGet("Domicilio")
	AltaPadron.text_9.Value := oRow:FieldGet("Medidor")
	AltaPadron.text_10.Value := oRow:FieldGet("Minimo")
	AltaPadron.text_11.Value := oRow:FieldGet("Sector")
	AltaPadron.text_12.Value := oRow:FieldGet("Meses_rez")
	AltaPadron.text_13.Value := oRow:FieldGet("Cuenta")
	tmpToma := iif(empty(oRow:FieldGet("Toma")),0,oRow:FieldGet("Toma"))
	tmpTusu := oRow:FieldGet("Tipo_usu")
	tmpFpag := oRow:FieldGet("Fte_pag")
	tmpStat := oRow:FieldGet("Estatus")
	bQuery:Destroy()
	//MsgBox(tmptusu)
	//MsgBox(CatUsu[1,3])
	For y=1 To len(CatEst)
		If CatEst[y,3] = tmpStat
			AltaPadron.combo_4.Value := y
			exit
		EndIf 
	Next
	For n=1 To len(CatUsu)
		If CatUsu[n,3] = tmpTusu
			AltaPadron.combo_3.Value := n
			exit
		EndIf 
	Next
	y:=1
	For y=1 To len(CatFte)
		If CatFte[y,1] = tmpFpag
			AltaPadron.combo_2.Value := y
			exit
		EndIf 
	Next
	y:=1
	For y=1 To len(CatDia)
		If CatDia[y,12] = tmpToma
			AltaPadron.combo_1.Value := y
			exit
		EndIf 
	Next
	bQuery:Destroy()
	 cQuery ="Select informa from Lecturas where Ruta = '" + strzero(val(AltaPadron.text_3.value),3)+;
				"' and Folio = '" + strzero(val(AltaPadron.text_4.value),4) + "'" 
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
		//MsgBox(bQuery)
    if bQuery:LastRec() = 0
        return Nil
    EndIf
        oRow := bQuery:GetRow(1)
		AltaPadron.edit_1.value := oRow:FieldGet("Informa")
		bQuery:Destroy()
	editar:=.t.
	AltaPadron.button_1.enabled := .t.
Return Nil

Function grabapadron()
Local tmptoma:="01", tmptipo:="01", tmpfpa:="99", tmpest:="I"
If Editar = .t.
MsgBox(aValue[2])
		cQuery := "Update Padron set Nombre='" + AltaPadron.text_7.Value + "',predio='" + AltaPadron.text_6.value + "',Medidor='" +;
		AltaPadron.text_9.Value + "',Domicilio='" + AltaPadron.text_8.Value + "',Sector='" + AltaPadron.text_11.value + "',Meses_rez=" +;
		str(AltaPadron.text_12.value) + ",Toma='" + tmptoma + "',tipo_usu='" + tmptipo + "',fte_pag='" + tmpfpa + "',Estatus='" + tmpest +;
		"',minimo=" + str(AltaPadron.text_10.Value) + " where cuenta='" + aValue[2] + "'"
	Else
	y:=1
	For y=1 To len(CatDia)
		If CatDia[y,1] = altapadron.combo_1.value
			tmptoma := CatDia[y,12]
			exit
		EndIf 
	Next
	MsgBox(tmptoma,"1")
	y:=1
	For y=1 To len(CatUsu)
		If CatUsu[y,1] = altapadron.combo_3.value
			tmptipo := CatUsu[y,3]
			exit
		EndIf 
	Next
	MsgBox(tmptipo,"2")
	y:=1
	For y=1 To len(CatFte)
		If val(CatFte[y,1]) = altapadron.combo_3.value
			tmpfpa := CatFte[y,1]
			exit
		EndIf 
	Next
	MsgBox(tmpfpa,"3")
	y:=1
	For y=1 To len(CatEst)
		If CatEst[y,1] = altapadron.combo_4.value
			tmpest := CatEst[y,3]
			exit
		EndIf 
	Next
	MsgBox(tmpest,"4")
		cQuery := "Insert into Padron (ruta, folio, nombre,Predio,Medidor,Domicilio,Sector,meses_rez,Toma,tipo_usu,fte_pag,Estatus,Cuenta,Contrato,Fecha_alta,minimo) values ('";
		+ AltaPadron.text_3.Value + "','" + AltaPadron.text_4.Value + "','" + AltaPadron.text_7.Value + "','";
		+ AltaPadron.text_6.value + "','" + AltaPadron.text_9.Value + "','" + AltaPadron.text_8.Value + "','";
		+ AltaPadron.text_11.Value + "'," + AltaPadron.text_12.value + ",'" + tmptoma + "','";
		+ tmptipo + "','" + tmpfpa + "','" + tmpest + "','";
		+ AltaPadron.text_13.Value + "','" + AltaPadron.text_5.Value + "','" +  cdate2mysqldate(date()) + "'," +;
		str(AltaPadron.text_10.Value) + ")"
	EndIf
	MsgBox(cQuery,"")
	msgbox(cQuery)
		    bQuery:=oServer:Query(cQuery)
				If bQuery:NetErr()												
					MsgStop(bQuery:Error())
					return Nil
				Endif
			bQuery:Destroy()
			If Editar = .t.
				cQuery := "Update Lecturas set informa='" + AltaPadron.edit_1.value + "' where Ruta = '" + strzero(val(AltaPadron.text_3.value),3)+;
				"' and Folio = '" + strzero(val(AltaPadron.text_4.value),4) + "'" 
			Else 
				//cQuery := "Insert into Padron (Informa) Values (AltaPadron.edit_1.value)
			EndIf 
			 bQuery:=oServer:Query(cQuery)
				If bQuery:NetErr()												
					MsgStop(bQuery:Error())
					return Nil
				Endif
			bQuery:Destroy()
	editar:=.f.
Return Nil

Function activared()
	AltaPadron.text_3.ReadOnly := .f.
	AltaPadron.text_4.ReadOnly := .f.
	AltaPadron.text_5.ReadOnly := .f.
	AltaPadron.text_6.ReadOnly := .f.
	AltaPadron.text_7.ReadOnly := .f.
	AltaPadron.text_8.ReadOnly := .f.
	AltaPadron.text_9.ReadOnly := .f.
	AltaPadron.text_10.ReadOnly := .f.
	AltaPadron.text_11.ReadOnly := .f.
	AltaPadron.text_12.ReadOnly := .f.
	AltaPadron.text_13.ReadOnly := .f.
	AltaPadron.edit_1.ReadOnly := .f.
	AltaPadron.combo_1.enabled := .t.
	AltaPadron.combo_2.enabled := .t.
	AltaPadron.combo_3.enabled := .t.
	AltaPadron.combo_4.enabled := .t.
Return Nil

Function buscapadr()
Local valorbuscar:="", n:=0
valorbuscar := inputbox("RutaFolio")
 cQuery =cQuery := "select Ruta, Folio, Cuenta, Nombre, Domicilio, Contrato, Medidor From Padron where ruta='";
 + left(valorbuscar,3) + "' and folio='" + right(valorbuscar,4) + "' Order By Ruta,Folio"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
		//MsgBox(bQuery)
    if bQuery:LastRec() = 0
        return Nil
    EndIf
	Padron.grid_1.DeleteAllItems()
hojas:= round(bQuery:LastRec()/3000,0)
padron.label_1.Value := "Hoja"+str(ahora)+" / "+str(hojas)
		filafin:=ahora*3000
		filaini:=filafin-3000
 
	For i := 1 To bQuery:LastRec()
		If n=500
			doevents()
			n=0
		EndIf 
		n++
		oRow := bQuery:GetRow(i)
		//If val(oRow:FieldGet("contrato")) > 0
			Padron.grid_1.AddItem({oRow:FieldGet("Ruta")+ "-" + oRow:FieldGet("Folio"),oRow:FieldGet("Cuenta"),;
					alltrim(oRow:FieldGet("Nombre")),alltrim(oRow:FieldGet("Domicilio")),oRow:FieldGet("Contrato"),;
					oRow:FieldGet("Medidor")})
		//EndIf 
				
	Next
bQuery:Destroy()
Return Nil

Function buscanum()
ahora := val(inputbox("Dame el numero de la hoja a Mostrar"))
padron.button_1.enabled:=.f.
padron.button_2.enabled:=.f.
padron.grid_1.enabled:=.F.
LoadPdrGrid(lopcion)
Return Nil