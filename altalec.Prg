#include <minigui.ch>


function altalec
   IF !IsWindowDefined(altalectura) 
       Load Window altalectura
       Center Window altalectura
       Activate Window altalectura
   endIf
return

function buscusualtlec
   /*select capturis
   seek altalectura.text_3.value
   if found()
      if capturis->estatus='A'
         if capturis->clave = 'L' .or. capturis->clave ='S'
            mpermisos:=capturis->nivel
            altalectura.text_4.value:=capturis->nom_captur*/
            altalectura.text_1.readonly:=.f.
            altalectura.text_2.readonly:=.f.
         /*endif 
      else
         MsgInfo('El capturista esta dado de baja','Mensaje del Sistema')
         altalectura.text_3.value:=space(3)
         altalectura.text_3.setfocus
	 return
      endif
   else
      MsgInfo('La clave no existe','Mensaje del Sistema')
      altalectura.text_3.value:=space(3)
      altalectura.text_3.setfocus
      return
   endif*/
return

function buscapaltalec
	cQuery := "select * from Padron Where RUTA='" + altalectura.text_1.Value + "' and folio='" + altalectura.text_2.Value + "'"
	bQuery := oServer:Query(cQuery)
		If bQuery:NetErr()												
			MsgStop ( bQuery:Error() )
			return Nil
		Endif
		if bQuery:LastRec() = 0
	 		MsgInfo('No se encontro al usuario','Mensaje del Sistema')
			altalectura.text_1.Value:=space(3)
			altalectura.text_2.Value:=space(4)
			altalectura.text_1.setfocus
			Return Nil
		EndIf
	oRow := bQuery:GetRow(1)
	tmpnombre := oRow:FieldGet("nombre")
	tmpdomicilio := oRow:FieldGet("Domicilio")
	tmptarifa := iif(oRow:FieldGet("tarifa") ='2','FIJA','MEDIDA')
	tmptarifaa := oRow:FieldGet("tarifa")
	tmpcontrato := oRow:FieldGet("contrato")
	tmpserv_dren := iif(oRow:FieldGet("serv_dren")='1','SI','NO')
	tmptoma := oRow:FieldGet("toma")
	tmpminimo := oRow:FieldGet("minimo")
	tmpmeses_rez := oRow:FieldGet("meses_rez")
	tmpcuenta := oRow:FieldGet("cuenta")
	tmptipo_usu := oRow:FieldGet("tipo_usu")
	tmpmedidor := oRow:FieldGet("medidor")
	tmpvalvula := oRow:FieldGet("valvula")
	tmpgiro := oRow:FieldGet("giro_n")
	bQuery:Destroy()
	altalectura.text_5.value:=tmpnombre
    altalectura.text_6.value:=tmpdomicilio
	
	cQuery := "select * from Lecturas Where RUTA='" + altalectura.text_1.Value + "' and folio='" + altalectura.text_2.Value + "'"
	bQuery := oServer:Query(cQuery)
		If bQuery:NetErr()												
			MsgStop ( bQuery:Error() )
			return Nil
		Endif
		if bQuery:LastRec() > 0
	 		MsgInfo('El Usuario Ya Esta Dado de Alta en Lecturas','Mensaje del Sistema')
			altalectura.text_1.Value:=space(3)
			altalectura.text_2.Value:=space(4)
			altalectura.text_5.value:=space(40)
			altalectura.text_6.value:=space(40)
			altalectura.text_1.setfocus
			Return Nil
		EndIf
		bQuery:Destroy()
		cQuery := "Insert into Lecturas (RUTA,FOLIO) values ('" + altalectura.text_1.Value + "','" + altalectura.text_2.Value + "')"//,LEC01,LEC02,LEC03,LEC04,LEC05,LEC06,LEC07,LEC08,LEC09,LEC10,LEC11,LEC12,NOLEC01,NOLEC02,NOLEC03,NOLEC04,NOLEC05,NOLEC06,NOLEC07,NOLEC08,NOLEC09,NOLEC10,NOLEC11,NOLEC12,MES,FECHA,CVE_CAPTUR,FEC01,FEC02,FEC03,FEC04,FEC05,FEC06,FEC07,FEC08,FEC09,FEC10,FEC11,FEC12,INFORMA,INFORMA)
		bQuery := oServer:Query(cQuery)
		If bQuery:NetErr()												
			MsgStop ( bQuery:Error() )
			return Nil
		Endif
		bQuery:Destroy()
   /*select padron
   set order to 1
   seek altalectura.text_1.value+altalectura.text_2.value
   if !found()
      MsgInfo('La Localizacion no existe','Mensaje del Sistema')
      altalectura.text_1.value:=space(4)
      altalectura.text_2.setfocus
      return
   else
      if padron->tarifa ='2'
         MsgInfo('El Usuario esta en Cuota Fija','Mensaje del Sistema')
         altalectura.text_2.value:=space(4)
         altalectura.text_2.setfocus
	 return
      else
        altalectura.text_5.value:=padron->nombre
        altalectura.text_6.value:=padron->domicilio
      endif
   endif
   select lecturas
   seek altalectura.text_1.value+altalectura.text_2.value
   if !found()
      if !msgyesno('Desea dar de alta en Lecturas, Desea darla de alta ?','Mensaje del Sistema')
         append blank
		 lecturas->ruta:=altalectura.text_1.value
         lecturas->folio:=altalectura.text_2.value
         lecturas->(dbcommit())
         lecturas->(dbunlock())
	 select padron
      endif
   else
      MsgInfo('El Usuario Ya Esta Dado de Alta en Lecturas','Mensaje del Sistema')
   endif*/
   altalectura.text_1.value:=space(3)
   altalectura.text_2.value:=space(4)
   altalectura.text_5.value:=space(40)
   altalectura.text_6.value:=space(40)
   altalectura.text_1.setfocus
return