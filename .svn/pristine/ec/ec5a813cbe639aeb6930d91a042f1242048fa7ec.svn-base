#include <hmg.ch>


function cambpad
   //select padrmov
   //set relation to capturista into capturis
   //select padron
   //set rela to toma into tomas additive
   //set rela to tipo_usu into usuarios additive
   //set rela to giro_n into giros additive
   IF !IsWindowDefined(cambpad) 
       Load Window cambpad
       Center Window cambpad
       cambpad.text_1.setfocus
       Activate Window cambpad
   endIf
return

function buscambpad
   declare window cambpad
   Local tmpgiro_n:=0, tmptoma:="", tmpusu:=""
	cQuery := "select * From Padron Where Ruta='" + cambpad.text_1.Value + "' and folio='" + cambpad.text_2.Value + "'"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
	If bQuery:LastRec() = 0
      MsgInfo('La cuenta no existe','Mensaje del Sistema')
      cambpad.text_1.value:=space(3)
      cambpad.text_2.value:=space(4)
      return
    EndIf
   //select padron 
   //set order to 1
   //seek cambpad.text_1.value+cambpad.text_2.value
   //if !found()
   //   MsgInfo('La cuenta no existe','Mensaje del Sistema')
   //   cambpad.text_1.value:=space(3)
   //   cambpad.text_2.value:=space(4)
   //   return
   //endif
   oRow := bQuery:GetRow(1)
   n:=1
	For n=1 To len(CatDia)
		If CatDia[n,12] = oRow:FieldGet("toma")
			tmptoma := CatDia[n,2] 
			exit
		EndIf 
	Next
	n:=1
	For n=1 To len(CatUsu)
		If CatUsu[n,3] = oRow:FieldGet("tipo_usu")
			tmpusu := CatUsu[n,2] 
			exit
		EndIf 
	Next
   cambpad.text_4.value:= oRow:FieldGet("medidor") + oRow:FieldGet("valvula")//padron->medidor+padron->valvula
   cambpad.text_5.value:= oRow:FieldGet("nombre")//padron->nombre
   cambpad.text_6.value:= tmptoma //tomas->des_toma
   cambpad.text_7.value:= iif(oRow:FieldGet("tarifa")='2','FIJA','MEDIDA')//iif(padron->tarifa ='2','FIJA','MEDIDA')
   cambpad.text_8.value:= oRow:FieldGet("domicilio")//padron->domicilio
   cambpad.text_9.value:= oRow:FieldGet("contrato")//padron->contrato
   cambpad.text_10.value:= iif(oRow:FieldGet("serv_dren") ='1','SI','NO')//iif(padron->serv_dren ='1','SI','NO')
   cambpad.text_11.value:= tmpusu//alltrim(usuarios->des_usu)
   cambpad.text_12.value:= oRow:FieldGet("minimo")//padron->minimo
   cambpad.text_13.value:= oRow:FieldGet("meses_rez")//padron->meses_rez
   cambpad.text_22.value:= oRow:FieldGet("cuenta")//padron->cuenta
   cambpad.text_15.value:=iif(oRow:FieldGet("tipo_usu")='02' .or. oRow:FieldGet("tipo_usu")='03','ALTOS CONSUMOS','BAJOS CONSUMOS')
   tmpgiro_n := oRow:FieldGet("giro_n")
   //select rutas
   //seek cambpad.text_1.value
   bQuery:Destroy()
   cQuery := "select * From Rutas Where cve_Ruta='" + cambpad.text_1.Value + "'"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
	If bQuery:LastRec() = 0
      MsgInfo('La cuenta no existe','Mensaje del Sistema')
      cambpad.text_1.value:=space(3)
      cambpad.text_2.value:=space(4)
      return
    EndIf
   //if found()
   oRow := bQuery:GetRow(1)
   cambpad.text_3.value:=oRow:FieldGet("lecturista") //rutas->lecturista
	mven = oRow:FieldGet("cve_venc")
   //endif
   //select padron
   //select fact_ant
   //seek cambpad.text_1.value+cambpad.text_2.value
   bQuery:Destroy()
	cQuery := "select * From Factant Where Ruta='" + cambpad.text_1.Value + "' and folio='" + cambpad.text_2.Value + "'"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
	If bQuery:LastRec() = 0
      MsgInfo('La cuenta no ha sido facturada','Mensaje del Sistema')
      cambpad.text_1.value:=space(3)
      cambpad.text_2.value:=space(4)
      return
    EndIf
	oRow := bQuery:GetRow(1)
   //if found()
      //cambpad.text_14.value:=alltrim(vencimie->des_venc)+' '+ames[int(val(right(fact_ant->periodo,2)))]+' '+left(fact_ant->periodo,4)
		cambpad.text_14.value:=alltrim(mven) + ' ' + ames[int(val(right(oRow:FieldGet("periodo"),2)))]+' '+left(oRow:FieldGet("periodo"),4)
   //endif
   //select padron
   bQuery:Destroy()
	cQuery := "select * From Giros Where clave=" + str(tmpgiro_n)
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
	If bQuery:LastRec() = 0
      MsgInfo('La cuenta no ha sido facturada','Mensaje del Sistema')
      cambpad.text_1.value:=space(3)
      cambpad.text_2.value:=space(4)
      return
    EndIf
	oRow := bQuery:GetRow(1)
      cambpad.text_18.value:=oRow:FieldGet("nombre") //giros->nombre
   if cambpad.Grid_1.ItemCount > 0
       cambpad.Grid_1.DeleteallItems()
   endif
   //select padrmov
   //set order to 1
   //seek cambpad.text_1.value+cambpad.text_2.value
	bQuery:Destroy()
	cQuery := "select * From Padrmov,Capturis Where Ruta='" + cambpad.text_1.Value + "' and folio='" + cambpad.text_2.Value + "'"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
	If bQuery:LastRec() = 0
      MsgInfo('La cuenta no tiene movimientos','Mensaje del Sistema')
      cambpad.text_1.value:=space(3)
      cambpad.text_2.value:=space(4)
      return
    EndIf
   //if found()
     //do while padrmov->ruta+padrmov->folio = cambpad.text_1.value+cambpad.text_2.value
	 For i=1 To bQuery:LastRec()
			oRow := bQuery:GetRow(i)
         //if padrmov->ruta+padrmov->folio = cambpad.text_1.value+cambpad.text_2.value
	    //cambpad.Grid_1.AddItem ( { padrmov->campo,padrmov->desc ,capturis->nom_captur,dtoc(padrmov->fecha),padrmov->hora} )
		cambpad.Grid_1.AddItem ( { oRow:FieldGet("campo"),oRow:FieldGet("desc") ,oRow:FieldGet("nom_captur"),dtoc(oRow:FieldGet("fecha")),oRow:FieldGet("hora")} )
	 Next 
	 //endif
	 //skip
     // enddo
   //endif
   bQuery:Destroy()
   cambpad.Grid_1.Value := cambpad.Grid_1.ItemCount
   cambpad.Grid_1.refresh
   cambpad.Grid_1.setfocus
return