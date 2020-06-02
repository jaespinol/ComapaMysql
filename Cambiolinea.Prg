#include <hmg.ch>

function Cambiolinea()
   IF !IsWindowDefined(camlinea) 
       Load Window camlinea
	   camlinea.title := 'Cambios de Linea'
	   cargatitCL()
       Center Window camlinea
       Activate Window camlinea
   endIf
return

Function cargatitCL()
	camlinea.label_1.Value := 'Ruta - Folio'
	camlinea.label_2.Value := 'Nombre'
	camlinea.label_3.Value := 'Linea'
	camlinea.label_4.Value := 'Consumo Minimo'
	camlinea.label_5.Value := 'Contrato'
	camlinea.label_6.Value := 'Toma'
	camlinea.label_7.Value := 'Folio Cambio'
	camlinea.label_8.Value := 'Fecha'
	camlinea.label_9.Value := 'Adeudo'
	camlinea.label_10.Value := 'I.V.A.'
	camlinea.label_11.Value := 'Total'
	camlinea.label_12.Value := 'Pagado'
	camlinea.combo_1.enabled := .f.
	camlinea.combo_2.enabled := .f.
Return Nil

Function buscacamlin()
Public tmpcontratocaml := ""
declare Window camlinea
	cQuery := "Select contrato, nombre, toma, minimo From Padron where ruta='" + camlinea.text_1.Value + "' and folio='" + camlinea.text_2.Value + "'"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
        return Nil
    EndIf 
	oRow := bQuery:GetRow(1)
	For n=1 To len(CatDia)
		If CatDia[n,12] = oRow:FieldGet("toma")//tmtToma
			camlinea.combo_1.value := n
			exit
		EndIf 
	Next
	camlinea.text_3.Value := oRow:FieldGet("nombre")
	camlinea.text_4.Value := oRow:FieldGet("minimo")
	tmpcontratocaml := oRow:FieldGet("contrato")
	bQuery:Destroy()
Return Nil

Function compcontcamlin()
	If tmpcontratocaml = StrZero(Val(camlinea.text_5.value),6)
		camlinea.combo_2.enabled := .t.
		camlinea.combo_2.SetFocus
		camlinea.text_5.Value := tmpcontratocaml
	Else
		MsgBox("Verifique la informacion del usuario","Error de sistema CL1")
	EndIf 
Return Nil

Function guardarcamlin()
Local tmptomacl:= "", tmppagcl:=""
	MsgBox("Guardado","PA Checar")
	For n=1 To len(CatDia)
		If CatDia[n,1] = camlinea.combo_2.value
			 tmptomacl:= CatDia[n,12]
			exit
		EndIf 
	Next
	If camlinea.RadioGroup_1.Value = 1
		tmppagcl := '1'
	Else
		tmppagcl := space(0)
	EndIf 
	cQuery := "Insert into Cambio (ruta,folio,contrato,toma,fol_camlin,fecha_act,adeudo_act,ad_iva,pagado,concepto) values ('";
			+ camlinea.text_1.Value + "','"  ;
			+ camlinea.text_2.Value + "','"  ;
			+ camlinea.text_5.Value + "','"  ;
			+ tmptomacl + "',"  ;
			+ Str(camlinea.text_6.Value) + ",'"  ;
			+ cdate2mysqldate(camlinea.dp1.Value) + "',"  ;
			+ Str(camlinea.text_7.Value) + ","  ;
			+ Str(camlinea.text_8.Value) + ",'"  ;
			+ tmppagcl + "','')" 

	bQuery := oServer:Query(cQuery)
		If bQuery:NetErr()												
			  MsgStop ( bQuery:Error() )
			  return Nil
		Endif
	bQuery:Destroy()
	limpiacamlin()
Return Nil

Function limpiacamlin()
	camlinea.text_1.Value := space(3)
	camlinea.text_2.Value := space(4)
	camlinea.text_4.Value := 0
	camlinea.text_3.Value := space(5)
	camlinea.text_5.Value := space(6)
	camlinea.text_6.Value := 0
	camlinea.text_7.Value := 0
	camlinea.text_8.Value := 0
	camlinea.text_9.Value := 0
	camlinea.dp1.Value := date()
	camlinea.RadioGroup_1.Value := 1
	camlinea.combo_1.value := 0
	camlinea.combo_2.value := 0
	camlinea.combo_2.enabled := .f.
	camlinea.combo_1.enabled := .f.
	camlinea.text_1.SetFocus
Return Nil

Function calcivacl()
	camlinea.text_8.Value := camlinea.text_7.Value * (mvalorIva/100)
	camlinea.text_9.Value := camlinea.text_8.Value + camlinea.text_7.Value
Return Nil