#include <hmg.ch>


function cambiacom
   parameters opconsflag
   public flagbr:=4
   IF !IsWindowDefined(cambiacom) 
       Load Window cambiacom
       Center Window cambiacom
       cambiacom.text_1.setfocus
       Activate Window cambiacom
   endIf
return

function buscambcom
Local tmlcve_cenc:=0
   declare window cambiacom
	cQuery := "select * From Padron Where Ruta='" + cambiacom.text_1.Value + "' and folio='" + cambiacom.text_2.Value + "'"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
   Endif
	If bQuery:LastRec() = 0
      MsgInfo('La cuenta no existe','Mensaje del Sistema')
      cambiacom.text_1.value:=space(3)
      cambiacom.text_2.value:=space(4)
      return
   endif
   oRow := bQuery:GetRow(1)
		tmpContrato:=oRow:FieldGet("contrato")
		tmpPredio:=oRow:FieldGet("Predio")
		tmpMinimo:=oRow:FieldGet("minimo")
		tmpDren:=iif(oRow:FieldGet("serv_dren") ='1','SI','NO')
		tmpCuenta:=oRow:FieldGet("cuenta")
		tmpNombre:=oRow:FieldGet("Nombre")
		tmpDomicilio:=oRow:FieldGet("Domicilio") 
		tmpMedidor:=iif(empty(oRow:FieldGet("Medidor")),"Fija",oRow:FieldGet("Medidor"))  
		tmpvalvula:=oRow:FieldGet("valvula")
		tmpEstatus:=oRow:FieldGet("Estatus") 
		tmpTipo_usu:=oRow:FieldGet("tipo_usu") 
		tmpFtepag:=oRow:FieldGet("fte_pag") 
		tmpSector:=oRow:FieldGet("Sector") 
		tmpToma:=oRow:FieldGet("toma") 
		tmpColonia:=oRow:FieldGet("Colonia") 
		tmpTarifa:=iif(oRow:FieldGet("Tarifa") ='2','FIJA','MEDIDA')
		tmpmeses_rez:=oRow:FieldGet("meses_rez")
		tmpGiro:=oRow:FieldGet("Giro_n")
		cambiacom.text_4.value:=tmpMedidor+tmpvalvula
   bQuery:Destroy()
	cQuery := "Select * From Rutas Where cve_ruta='" + cambiacom.text_1.Value + "'"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
   Endif
   if bQuery:LastRec() = 0
	 	MsgInfo('No se encontro la Ruta','Mensaje del Sistema')
      cambiacom.text_1.Value:=space(3)
      cambiacom.text_2.Value:=space(4)
      cambiacom.text_1.setfocus
      return Nil
   EndIf
	oRow := bQuery:GetRow(1)
		cambiacom.text_3.Value := oRow:FieldGet("Lecturista")
		tmlcve_cenc := oRow:FieldGet("Cve_venc")
	n:=1
	For n=1 To len(CatVen)
		If CatVen[n,1] = val(tmlcve_cenc)
			mvene := CatVen[n,2] 
			exit
		EndIf 
	Next
	
	bQuery:Destroy()
   cambiacom.text_5.value:=tmpNombre 
   n:=1
	For n=1 To len(CatDia)
		If CatDia[n,12] = tmpToma
			cambiacom.text_6.value:= CatDia[n,13] 
			exit
		EndIf 
	Next
	cambiacom.text_7.value:=tmpTarifa 
   cambiacom.text_8.value:=tmpdomicilio
   cambiacom.text_9.value:=tmpcontrato
   cambiacom.text_10.value:=tmpDren 
	For y=1 To len(CatUsu)
		If CatUsu[y,3] = tmpTipo_usu
			cambiacom.text_11.Value := CatUsu[y,2] 
			exit
		EndIf 
	Next
   cambiacom.text_12.value:=tmpminimo
   cambiacom.text_13.value:=tmpmeses_rez
   cambiacom.text_22.value:=tmpcuenta
	cQuery := "select * From Factant Where Ruta='" + cambiacom.text_1.Value + "' and folio='" + cambiacom.text_2.Value + "'"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
   Endif
	oRow := bQuery:GetRow(1)
		tmfperiodo:= oRow:FieldGet("periodo")
	If bQuery:LastRec() > 0
       cambiacom.text_14.value:=alltrim(mvene)+' '+ames[int(val(right(tmfperiodo,2)))]+' '+left(tmfperiodo,4)
   endif
  
   cambiacom.text_15.value:=iif(tmpTipo_usu='02' .or. tmpTipo_usu='03','ALTOS CONSUMOS','BAJOS CONSUMOS')
   For y=1 To len(CatGir)
		If CatGir[y,1] = tmpgiro
			cambiacom.text_18.value:= CatGir[y,2]
			exit
		EndIf 
	Next
	bQuery:Destroy()
	cQuery := "select informa From Lecturas Where Ruta='" + cambiacom.text_1.Value + "' and folio='" + cambiacom.text_2.Value + "'"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
   Endif
	oRow := bQuery:GetRow(1)
		tmlinforma:= oRow:FieldGet("informa")
	If bQuery:LastRec() > 0
       cambiacom.edit_1.value:=tmlinforma
   EndIf 
	bQuery:Destroy()
return

function guardacoment
	tmcinforma := cambiacom.Edit_1.Value
	cQuery := "Update Lecturas set informa='" + tmcinforma + "' where ruta='";
				 + cambiacom.text_1.Value + "' and folio='" + cambiacom.text_2.Value + "'"
	//cQuery := "select informa From Lecturas Where Ruta='" + cambiacom.text_1.Value + "' and folio='" + cambiacom.text_2.Value + "'"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
   Endif
	bQuery:Destroy()
   //select lecturas
   //do while .t.
   //   if lecturas->(rlock())
   //      exit
   //   endif 
   //enddo
   //lecturas->informa:=upper(cambiacom.edit_1.value)
   //lecturas->(dbcommit())
   //lecturas->(dbunlock())
   //select padron
   cambiacom.text_1.value:=space(3)
   cambiacom.text_2.value:=space(4)
   cambiacom.text_4.value:=space(10)
   cambiacom.text_3.value:=space(40)
   cambiacom.text_5.value:=space(60)
   cambiacom.text_6.value:=space(20)
   cambiacom.text_7.value:=space(10)
   cambiacom.text_8.value:=space(60)
   cambiacom.text_9.value:=space(7)
   cambiacom.text_10.value:=space(2)
   cambiacom.text_11.value:=space(40)
   cambiacom.text_12.value:=0
   cambiacom.text_13.value:=0
   cambiacom.text_22.value:=space(7)
   cambiacom.text_14.value:=space(20)
   cambiacom.text_15.value:=space(10)
   cambiacom.text_18.value:=space(30)
   cambiacom.edit_1.value:=''
return