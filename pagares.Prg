#include <hmg.ch>
#define REPORTPAGE    9 

function pagares
   public flagop:=1
   /*acons:={}
   select tipop
   set order to 2
   select pagares*/
   IF !IsWindowDefined(pagare) 
       Load Window pagare
		 paumenta()
       Center Window pagare
       Activate Window pagare
   endIf
return

function altapagares()
   parameter flagop
   IF !IsWindowDefined(altapagare) 
       Load Window altapagare
       altapagare.text_14.value:=mvaloriva
       altapagare.text_22.value:=mvaloriva
       pongetpagval(.f.)
       Center Window altapagare
       Activate Window altapagare
   endIf
return

function pondatpag
Local pLinea:=0, pValue := 0,tmpsruta:="", tmpsfolio:=""
   declare window altapagare
	declare Window pagare
   //select pagares
   if flagop = 2
		pLinea := pagare.Grid_1.Value 
		pValue := pagare.Grid_1.Item (pLinea)
		cQuery := "select * From Pagares where pagare=" + pValue[1]
		bQuery := oServer:Query (cQuery)
		If bQuery:NetErr()
			Msgstop(bQuery:Error())
			Return Nil
		EndIf 
		oRow := bQuery:GetRow(1)
		If len(bQuery)=0
			MsgBox("No se encontro el Pagare","Mensage del sistema")
			Return 
		EndIf
		
      altapagare.text_3.value:=oRow:FieldGet("pagare") //val(pagares->pagare)
      altapagare.text_4.value:=oRow:FieldGet("contrato") //val(pagares->contrato)
      altapagare.datepicker_1.value:=oRow:FieldGet("fecha_act") //pagares->
      altapagare.text_9.value:=oRow:FieldGet("nombre") //pagares->
      altapagare.text_10.value:=oRow:FieldGet("domicilio") //pagares->
		altapagare.text_19.value:=oRow:FieldGet("importe") //pagares->
		altapagare.text_20.value:=oRow:FieldGet("int_act") //pagares->
		altapagare.text_21.value:=altapagare.text_19.value * (altapagare.text_20.value/100)
		altapagare.text_23.value:=oRow:FieldGet("iva") //pagares->
		altapagare.text_24.value:=altapagare.text_19.value+altapagare.text_21.value+altapagare.text_23.value
		altapagare.text_25.value:=oRow:FieldGet("meses") //pagares->
		altapagare.text_26.value:=oRow:FieldGet("fecha_ven") //pagares->
		tmpsruta := oRow:FieldGet("ruta")
		tmpsfolio := oRow:FieldGet("folio")
      //select tipop
      //locate for tipop->clave = pagares->
      //if found()
      //   altapagare.combo_1.value:=tipop->(recno())
      //EndIf 
		n:=1
		For n=1 To len(CatTpg)
			If CatTpg[n,1] = oRow:FieldGet("concepto")
				altapagare.combo_1.Value := n//CatTpg[n,2]
				exit
			EndIf 
		Next
		
		if oRow:FieldGet("concepto") = 'AS' .or. oRow:FieldGet("concepto") = 'AD'
         //select contrato
			//seek strzero(altapagare.text_4.value,6)
			lQuery := "select * From Contrato where contrato=" + str(altapagare.text_4.value)
			tQuery := oServer:Query (lQuery)
			If tQuery:NetErr()
				Msgstop(tQuery:Error())
				Return Nil
			EndIf 
			tRow := tQuery:GetRow(1)
			If len(tQuery)=0
				MsgBox("No se encontro el Contrato","Mensage del sistema")
				Return 
			EndIf
		   altapagare.text_7.value:=tRow:FieldGet("orden_agua") //contrato->
         altapagare.text_8.value:=tRow:FieldGet("orden_dren") //contrato->
         mvalor1:=tRow:FieldGet("derecho_ap")/(1+(altapagare.text_14.value/100)) //contrato->/(1+(altapagare.text_14.value/100))
         mvalor2:=tRow:FieldGet("derecho_al")/(1+(altapagare.text_14.value/100)) //contrato->derecho_al
         mvalor3:=tRow:FieldGet("rotura")/(1+(altapagare.text_14.value/100)) //contrato->
         mvalor4:=tRow:FieldGet("linea_gral")/(1+(altapagare.text_14.value/100)) //contrato->
         mvalor5:=tRow:FieldGet("toma_larga")/(1+(altapagare.text_14.value/100)) //contrato->
         mvalor6:=tRow:FieldGet("total")-(mvalor1+mvalor2+mvalor3+mvalor4+mvalor5) //contrato->
         altapagare.text_13.value:=mvalor1+mvalor2+mvalor3+mvalor4+mvalor5
         altapagare.text_15.value:=mvalor6
         altapagare.text_16.value:=tRow:FieldGet("total") //contrato->total
         if mvalor1 > 0
            altapagare.Grid_1.AddItem( {'Conexion A.P.' , transform(mvalor1,"999,999,999.99")} )
         endif
         if mvalor2 > 0
            altapagare.Grid_1.AddItem( {'Concexion ALC.' , transform(mvalor2,"999,999,999.99")} )
         endif
         if mvalor3 > 0
            altapagare.Grid_1.AddItem( {'Rotura Pavimento' ,transform(mvalor3,"999,999,999.99")} )
         endif
         if mvalor4 > 0
            altapagare.Grid_1.AddItem( {'Linea General' , transform(mvalor4,"999,999,999.99")} )
         endif
         if mvalor5 > 0
            altapagare.Grid_1.AddItem( {'Toma Larga' , transform(mvalor5,"999,999,999.99")} )
         endif
         altapagare.text_17.value:=tRow:FieldGet("recibo") //contrato->
         altapagare.text_18.value:=tRow:FieldGet("contado") //contrato->
            //select tomas
            //seek contrato->
            //if found()
            //   :=tomas->des_toma
            //endif
			n:=1
			For n=1 To len(CatDia)
				If CatDia[n,12] = tRow:FieldGet("cve_toma")
					altapagare.text_11.value := CatDia[n,13]
					exit
				EndIf 
			Next
           //select usuarios
           //seek contrato->
           //if found()
           //   altapagare.text_12.value:=usuarios->des_usu
           //endif
			n:=1
			For n=1 To len(CatUsu)
				If CatUsu[n,3] = tRow:FieldGet("tipo_usu")
					altapagare.text_12.value := CatUsu[n,2]
					exit
				EndIf 
			Next
		EndIf 
			//tQuery:Destroy()
	Else //aqui estoy
		if !empty(tmpsruta+tmpsfolio) //pagares->ruta+pagares->folio)
			//	select padron
			//	seek pagares->ruta+pagares->folio
			lQuery := "select * From Padron where ruta='" + oRow:FieldGet("ruta") + "' and folio='" + oRow:FieldGet("folio") + "'"
			tQuery := oServer:Query (lQuery)
			If tQuery:NetErr()
				Msgstop(tQuery:Error())
				Return Nil
			EndIf 
			tRow := tQuery:GetRow(1)
			If len(tQuery)=0
				MsgBox("No se encontro el Usuario en Padron","Mensage del sistema")
				Return 
			EndIf
			//	select tomas
			//	seek padron->toma
			//if found()
			//tRow:FieldGet("")
			//:=tomas->des_toma
			//EndIf 
			n:=1
			For n=1 To len(CatDia)
				If CatDia[n,12] = tRow:FieldGet("toma")
					altapagare.text_11.Value := CatDia[n,13]
					exit
				EndIf 
			Next
			//select usuarios
			//seek padron->tipo_usu
			//if found()
			//	altapagare.text_12.value:=usuarios->des_usu
			//EndIf 
			n:=1
			For n=1 To len(CatUsu)
				If CatUsu[n,3] = tRow:FieldGet("tipo_usu")
					altapagare.text_12.Value := CatUsu[n,2]
					exit
				EndIf 
			Next
		endif
	   //select pagares
		
   endif
return

function buscusupagare
/*   select capturis
   seek altapagare.text_1.value
   if found()
      if capturis->estatus='A'
         if capturis->clave = 'C' .or. capturis->clave ='S'
            mpermisos:=capturis->nivel
            altapagare.text_2.value:=capturis->nom_captur
         endif 
      else
         MsgInfo('El capturista esta dado de baja','Mensaje del Sistema')
         altapagare.text_1.value:=space(3)
         altapagare.text_1.setfocus
	 return
      endif
   else
      MsgInfo('El capturista no existe','Mensaje del Sistema')
      altapagare.text_1.value:=space(3)
      altapagare.text_1.setfocus
      return
   endif*/
   pongetpagval(.t.)
return

function buscacontpag
   declare window altapagare
   //select contrato
   //seek strzero(,6)
   cQuery := "select * From Contrato where contrato=" + str(altapagare.text_4.value)
	bQuery := oServer:Query (cQuery)
	If bQuery:NetErr()
		Msgstop(bQuery:Error())
		Return Nil
	EndIf 
	oRow := bQuery:GetRow(1)
	If len(bQuery)=0
		MsgBox("No se encontro el contrato","Mensage del sistema")
		Return 
	EndIf 
   altapagare.text_9.value:=oRow:FieldGet("nombre") //contrato->
   altapagare.text_10.value:=oRow:FieldGet("domicilio") //ontrato->
   altapagare.text_7.value:=oRow:FieldGet("orden_agua") //contrato->
   altapagare.text_8.value:=oRow:FieldGet("orden_dren") //contrato->
   mvalor1:=oRow:FieldGet("derecho_ap")/(1+(altapagare.text_14.value/100)) //contrato->
   mvalor2:=oRow:FieldGet("derecho_al")/(1+(altapagare.text_14.value/100)) //contrato->
   mvalor3:=oRow:FieldGet("rotura")/(1+(altapagare.text_14.value/100)) //contrato->
   mvalor4:=oRow:FieldGet("linea_gral")/(1+(altapagare.text_14.value/100)) //contrato->
   mvalor5:=oRow:FieldGet("toma_larga")/(1+(altapagare.text_14.value/100)) //contrato->
   mvalor6:=oRow:FieldGet("total")-(mvalor1+mvalor2+mvalor3+mvalor4+mvalor5) //contrato->
   altapagare.text_13.value:=mvalor1+mvalor2+mvalor3+mvalor4+mvalor5
   altapagare.text_15.value:=mvalor6
   altapagare.text_16.value:=oRow:FieldGet("total") //contrato->
   if mvalor1 > 0
      altapagare.Grid_1.AddItem( {'Conexion A.P.' , transform(mvalor1,"999,999,999.99")} )
   endif
   if mvalor2 > 0
      altapagare.Grid_1.AddItem( {'Concexion ALC.' , transform(mvalor2,"999,999,999.99")} )
   endif
   if mvalor3 > 0
      altapagare.Grid_1.AddItem( {'Rotura Pavimento' ,transform(mvalor3,"999,999,999.99")} )
   endif
   if mvalor4 > 0
      altapagare.Grid_1.AddItem( {'Linea General' , transform(mvalor4,"999,999,999.99")} )
   endif
   if mvalor5 > 0
      altapagare.Grid_1.AddItem( {'Toma Larga' , transform(mvalor5,"999,999,999.99")} )
   endif
   altapagare.text_17.value:=oRow:FieldGet("recibo") //contrato->
   altapagare.text_18.value:=oRow:FieldGet("contado") //contrato->
   altapagare.text_19.value:=(oRow:FieldGet("total")-altapagare.text_18.value)/(1+(altapagare.text_22.value/100)) //contrato->
   altapagare.text_23.value:=(oRow:FieldGet("total")-altapagare.text_18.value)-altapagare.text_19.value //(contrato->
   altapagare.text_24.value:=altapagare.text_19.value+altapagare.text_21.value+altapagare.text_23.value
   //select tomas
   //seek oRow:FieldGet("") //contrato->
   //if found()
   //   :=tomas->des_toma
   //EndIf 
	n:=1
	For n=1 To len(CatDia)
		If CatDia[n,12] = oRow:FieldGet("cve_toma")
			 altapagare.text_11.Value := CatDia[n,13]
			exit
		EndIf 
	Next
   //select usuarios
   //seek oRow:FieldGet("") //contrato->
   //if found()
   //   altapagare.text_12.value:=usuarios->des_usu
   //EndIf 
	n:=1
	For n=1 To len(CatUsu)
		If CatUsu[n,3] = oRow:FieldGet("tipo_usu")
			 altapagare.text_12.Value := CatUsu[n,2]
			exit
		EndIf 
	Next
   //select contrato
   //select pagares
   altapagare.text_19.setfocus
return

function pongetspagare
   declare window altapagare
   if altapagare.combo_1.item (altapagare.combo_1.value) = 'AS' .or. altapagare.combo_1.item (altapagare.combo_1.value) = 'AD'
      altapagare.text_4.readonly:=.f.
      altapagare.text_5.readonly:=.t.
      altapagare.text_6.readonly:=.t.
      altapagare.text_4.setfocus
   else
      altapagare.text_4.readonly:=.t.
      altapagare.text_5.readonly:=.f.
      altapagare.text_6.readonly:=.f.
      altapagare.text_5.setfocus
   endif
return

function bskapadrpag
   declare window altapagare
   //select padron 
   //seek altapagare.text_5.value+altapagare.text_6.value
    cQuery := "select * From Padron where ruta='" + altapagare.text_5.Value + "' and folio='" + altapagare.text_6.Value + "'"
	bQuery := oServer:Query (cQuery)
	If bQuery:NetErr()
		Msgstop(bQuery:Error())
		Return Nil
	EndIf 
	oRow := bQuery:GetRow(1)
	If len(bQuery)=0
		MsgInfo('El usuario no existe','Mensaje del Sistema')
      altapagare.text_5.value:=space(3)
      altapagare.text_6.value:=space(4)
      altapagare.text_5.setfocus
		Return 
	EndIf 
   altapagare.text_9.value:= oRow:FieldGet("nombre") //padron->
   altapagare.text_10.value:=oRow:FieldGet("domicilio") //padron->
   /*select tomas
   seek oRow:FieldGet("") //padron->toma
   if found()
      altapagare.text_11.value:=tomas->des_toma
   endif
   select usuarios
   seek oRow:FieldGet("") //padron->tipo_usu
   if found()
      altapagare.text_12.value:=usuarios->des_usu
   EndIf */
	n:=1
	For n=1 To len(CatDia)
		If CatDia[n,12] = oRow:FieldGet("toma")
			 altapagare.text_11.Value := CatDia[n,13]
			exit
		EndIf 
	Next
	n:=1
	For n=1 To len(CatUsu)
		If CatUsu[n,3] = oRow:FieldGet("tipo_usu")
			 altapagare.text_12.Value := CatUsu[n,2]
			exit
		EndIf 
	Next
   altapagare.text_19.setfocus
return

function sumavalpagas
   declare window altapagare
   altapagare.text_21.value:=altapagare.text_19.value * (altapagare.text_20.value/100)
   altapagare.text_23.value:=altapagare.text_19.value * (altapagare.text_22.value/100)
   altapagare.text_24.value:=altapagare.text_19.value+altapagare.text_21.value+altapagare.text_23.value
return

function siesmesp 
   declare window altapagare
   altapagare.text_26.value:=altapagare.datepicker_1.value+(30*altapagare.text_25.value)
   do case
      case upper(cdow(altapagare.text_26.value)) = 'SUNDAY'
         altapagare.text_26.value:=altapagare.text_26.value+1
      case upper(cdow(altapagare.text_26.value)) = 'SATURDAY'
         altapagare.text_26.value:=altapagare.text_26.value+2
   endcase
return

function grabapagare
Local tmpusu:=""
   //dbselectarea('pagares')
   if flagop =1 //nuevo
      cQuery := "Insert into Pagares (contrato,ruta,folio,recibo,nombre,domicilio,contado,importe,interes,iva,total,"+;
			"int_act,int_mora,fecha_act,fecha_ven,meses,concepto,capturo) values (" + str(altapagare.text_4.Value);
			+ ",'" + altapagare.text_5.Value + "','" + altapagare.text_6.Value + "','" + altapagare.text_17.Value + "','" + altapagare.text_9.Value;
			+ "','" + altapagare.text_10.Value + "'," + str(altapagare.text_18.Value) + "," + str(altapagare.text_19.Value) + "," + str(altapagare.text_21.Value);
			+ "," + str(altapagare.text_23.Value) + "," + str(altapagare.text_24.Value) + "," + str(altapagare.text_20.Value) + "," + str(altapagare.text_27.Value);
			+ ",'" + cdate2mysqldate(altapagare.datepicker_1.value) + "','" + cdate2mysqldate(altapagare.text_26.value) + "',";
			+ str(altapagare.text_25.Value) + ",'" + strzero(altapagare.combo_1.value,2) + "','" + altapagare.text_1.Value + "')"
   Else //editar
		If date() - altapagare.datepicker_1.value  >= 1
				MsgInfo('No se puede modificar el pagare','Mensaje del Sistema')
				pongetpagval(.f.)
		Return
		EndIf
		cQuery := "Update Pagares set contrato=" + str(altapagare.text_4.Value) + ",ruta='" + altapagare.text_5.Value + "'folio='";
			+ altapagare.text_6.Value + "'recibo=" + altapagare.text_17.Value +	"nombre='" + altapagare.text_9.Value + "'domicilio='";
			+ altapagare.text_10.Value + "'contado=" + str(altapagare.text_18.Value) + "importe=" + str(altapagare.text_19.Value) + "interes=";
			+ str(altapagare.text_21.Value) + "iva=" + str(altapagare.text_23.Value) + "total=" + str(altapagare.text_24.Value) + "int_act=";
			+ str(altapagare.text_20.Value) + "int_mora=" + str(altapagare.text_27.Value) + "fecha_act='";
			+ cdate2mysqldate(altapagare.datepicker_1.value) + "'fecha_ven='" + cdate2mysqldate(altapagare.text_26.value) + 	"'meses=";
			+ str(altapagare.text_25.Value) + "concepto='" + strzero(altapagare.combo_1.Value,2) + "'capturo='" + altapagare.text_1.value;
			+ "' where pagare=" + str(altapagare.text_3.Value)
	endif
   bQuery:=oServer:Query(cQuery)
	If bQuery:NetErr()												
		MsgStop(bQuery:Error(),"No se guardaron los datos")
		return Nil
	Endif
	If flagop =1
		oQuery:= oServer:Query( "SELECT LAST_INSERT_ID()")
		If oQuery:NetErr()												
			MsgStop(bQuery:Error(),"No se guardaron los datos")
			return Nil
		Endif
		oRow := oQuery:GetRow(1)
		altapagare.text_3.Value := oRow:fieldGet(1)
	EndIf 
	bQuery:Destroy()
	//dbselectarea('pag_doc')
	
   mpagosm:=int(altapagare.text_24.value/altapagare.text_25.value)
   if flagop =1
      mpagosm:=int(altapagare.text_24.value/altapagare.text_25.value)
		cQuery := "Insert into Pagdoc (pagare,pago_act, fecha_pag, enviado) values (" + str(altapagare.text_3.Value) + "," + str(mpagosm) +;
		",'    -  -  ','X')"
      for i=1 to altapagare.text_25.value-1
	//         append blank
	//         pag_doc->pagare:=strzero(altapagare.text_3.value,7)
	//         pag_doc->pago_act:=mpagosm
			bQuery:=oServer:Query(cQuery)
			If bQuery:NetErr()												
				MsgStop(bQuery:Error(),"No se guardaron los datos")
				return Nil
			Endif
			bQuery:Destroy()
      next
      //append blank
      //pag_doc->pagare:=strzero(altapagare.text_3.value,7)
      mpagosm:=altapagare.text_24.value-((altapagare.text_25.value-1)*mpagosm)
		cQuery := "Insert into Pagdoc (pagare,pago_act, fecha_pag, enviado) values (" + str(altapagare.text_3.Value) + "," + str(mpagosm) +;
		",'    -  -  ','X')"
		bQuery:=oServer:Query(cQuery)
		If bQuery:NetErr()												
			MsgStop(bQuery:Error(),"No se guardaron los datos")
			return Nil
		Endif
		bQuery:Destroy()
   /*else
      seek strzero(altapagare.text_3.value,7)
      do while pag_doc->pagare = strzero(altapagare.text_3.value,7)
         do while .t.
            if pag_doc->(rlock())
	        if dtoc(pag_doc->fecha_pag) = '  /  /    '
                   delete
		endif
                pag_doc->(dbunlock())
               exit
  	    else
               loop
	    endif
         enddo
         skip
      enddo
      mpagosm:=int(altapagare.text_24.value/altapagare.text_25.value)
      for n=1 to altapagare.text_25.value-1
         append blank
         pag_doc->pagare:=strzero(altapagare.text_3.value,7)
         pag_doc->pago_act:=mpagosm
      next
      append blank
      pag_doc->pagare:=strzero(altapagare.text_3.value,7)
      pag_doc->pago_act:=altapagare.text_24.value-((altapagare.text_25.value-1)*mpagosm)*/
   endif
   pongetpagval(.f.)
   altapagare.button_1.enabled:=.t.
   altapagare.text_1.enabled:=.f.
   altapagare.text_2.enabled:=.f.
return

function imprepaga 
/*   local cRun, nWidth, nTab, nI, nJ, nK, nCol, nRow, aStyle, aFonts,unil:=6
   local nTop, nLeft, nBottom, nRight
   *local ruta:='f:\sca\documentos\pagares\'
   local ruta:='c:\documentos\pagares\'
   local aColor := { ;
   "FF0000", "8B0000", "800000", "FF4500", "D2691E", "B8860B", "FF8C00", "FFA500", "DAA520", "808000", "FFD700", "FFFF00", "ADFF2F", "9ACD32", "7FFF00", "7CFC00", "00FF00", "32CD32", "008000", "006400",;
   "66CDAA", "7FFFD4", "87CEFA", "87CEEB", "F0F8FF", "E0FFFF", "B0C4DE", "B0E0E6", "AFEEEE", "ADD8E6", "8FBC8F", "90EE90", "98FB98", "00FA9A", "00FF7F", "3CB371", "2E8B57", "228B22", "556B2F", "6B8E23",;
   "5F9EA0", "40E0D0", "48D1CC", "00CED1", "20B2AA", "008B8B", "008080", "2F4F4F", "00BFFF", "00FFFF", "00FFFF", "0000FF", "0000CD", "00008B", "000080", "1E90FF", "4169E1", "4682B4", "6495ED", "7B68EE",;
   "C71585", "FF1493", "FF00FF", "FF00FF", "9370DB", "DDADDD", "DB7093", "FF69B4", "DA70D6", "EE82EE", "BA55D3", "9932CC", "8A2BE2", "9400D3", "8B008B", "800080", "4B0082", "191970", "483D8B", "6A5ACD",;
   "DC143C", "B22222", "A52A2A", "CD5C5C", "FA8072", "E9967A", "FFA07A", "F5DEB3", "FFDEAD", "EEE8AA", "FFDAB9", "FFE4C4", "FFEFD5", "FFE4E1", "FFE4B5", "D2B48C", "DEB887", "F0E68C", "BDB76B", "F4A460",;
   "FDF5E6", "FFF8DC", "FAF0E6", "FAFAD2", "FFFACD", "FFEBCD", "FFFFE0", "FAEBD7", "FFF5EE", "FFF0F5", "D8BFD8", "FFC0CB", "FFB6C1", "BC8F8F", "F08080", "FF7F50", "FF6347", "8B4513", "A0522D", "CD853F",;
   "FFFAFA", "FFFFF0", "E6E6FA", "FFFAF0", "F8F8FF", "F0FFF0", "F5F5DC", "F0FFFF", "F5FFFA", "708090", "778899", "F5F5F5", "DCDCDC", "D3D3D3", "C0C0C0", "A9A9A9", "808080", "696969", "000000", "FFFFFF"}
   aReport := PdfInit()
   archivopdf:=ruta+strzero(altapagare.text_3.value,7)+'.pdf'
   nline:=24
   *set date format to "YYYY/MM/DD" //important for save/load array function!!!

   aStyle := { "Normal", "Bold", "Italic", "BoldItalic" }
   aFonts := { { "Times",     .t., .t., .t., .t. },;
               { "Helvetica", .t., .t., .t., .t. },;
               { "Courier",   .t., .t., .t., .t. } }
   pdfOpen( archivopdf, 200, .t.)
   pdfEditOnHeader()
   pdfEditOffHeader()
   pdfBookOpen()
   pdfNewPage( "MC", "P", 6 )
   pdfBookAdd( "Pagare", 1, aReport[ REPORTPAGE ], 0 )
   pdfImage( 'laredo.jpg', 10, 10, "M",20,20) // file, row, col, units, height, width
   pdfImage( 'comapa.jpg', 10, 180, "M",20,20) // file, row, col, units, height, width
   pdfSetFont( "Times" , 1 , 12 )
   pdfAtSay("COMISION MUNICIPAL DE AGUA POTABLE Y ALCANTARILLADO", 2,30, "R" )
   pdfAtSay('                      DEL MUNICIPIO DE NUEVO LAREDO',4, 35, "R" )
   pdfSetFont( "Times" , 1 , 14 )
   pdfAtSay('PAGARE',unil,82,"R")
   unil:=unil+3
   pdfSetFont( "Times" , 1 , 9 )
   pdfAtSay('FOLIO : '+strzero(altapagare.text_3.value,7),unil,0,"R")
   pdfAtSay('NUEVO LAREDO, TAMP.  A '+ alltrim(str(day(altapagare.datepicker_1.value)))+' DE '+ upper(ames[month(altapagare.datepicker_1.value)]) +' '+ str(year(altapagare.datepicker_1.value),4),unil,130,"R")
   unil:=unil+2
   pdfAtSay('POR ESTE PAGARE INCONDICIONALMENTE (ME) (NOS) OBLIG(O) (AMOS) A CUBRIR LA ORDEN DE COMAPA',unil,0,"R")
   unil:=unil+1
   pdfAtSay('(  COMISION  MUNICIPAL  DE  AGUA  POTABLE  Y   ALCANTARILLADO ) DE NUEVO LAREDO,  TAM.,   EN  SUS',unil,0,"R")
   unil:=unil+1
   select tipop
   locate for tipop->clave = pagares->concepto
   pdfAtSay('OFICINAS, UBICADAS EN VICTORIA No. 4610 POR CONCEPTO DE ' + alltrim(tipop->nombre),unil,0,"R")
   select pagares
   unil:=unil+2
   pdfAtSay('CONTRATO No. :' + strzero(altapagare.text_4.value,7),unil,0,"R")
   unil:=unil+1
   pdfAtSay('SUBTOTAL :' + transform(altapagare.text_19.value,'999,999.99')+'                      I.V.A. :' + transform(altapagare.text_23.value,'999,999.99')+'                      TOTAL :' + transform(altapagare.text_24.value,'999,999.99'),unil,0,"R")
   unil:=unil+1
   pdfAtSay('LA CANTIDAD DE :' + transform(altapagare.text_24.value,'999,999.99'),unil,0,"R")
   unil:=unil+2
   pdfAtSay(letras(altapagare.text_24.value),unil,0,"R")
   unil:=unil+2
   pdfAtSay('DE NO SER CUBIERTA A SU  VENCIMIENTO LA  CANTIDAD  ANTERIOR  CAUSARA  INTERESES  MORATORIOS',unil,0,"R")
   unil:=unil+1
   pdfAtSay('A RAZON DEL (10%) MENSUAL',unil,0,"R")
   unil:=unil+2
   pdfAtSay('VENCIMIENTO : ' + dtoc(altapagare.text_26.value),unil,0,"R")
   unil:=unil+1
   if !empty(altapagare.text_5.value+altapagare.text_6.value)
      pdfAtSay('LOCALIZACION : ' + altapagare.text_5.value +'-'+altapagare.text_6.value,unil,0,"R")
      unil:=unil+1
   endif
   pdfAtSay('DOMICILIO : ' + altapagare.text_10.value,unil,0,"R")
   pdfImage( 'usuario.jpg', 93, 155, "M",20,30) // file, row, col, units, height, width
   pdfAtSay(altapagare.text_9.value,unil,140,"R")
   unil:=unil+2
   *pdfAtSay('REALIZO : ' + vargen:usu,unil,0,"R")
   pdfAtSay(mcomercial,unil,73,"R")
   unil:=unil+1
   pdfImage( 'COMERCIAL.jpg', 98, 90, "M",30,50) // file, row, col, units, height, width
   pdfAtSay('GERENTE COMERCIAL ( FIRMA Y SELLO )',unil,70,"R")
   unil:=unil+1
   pdfAtSay('ORIGINAL - JURIDICO',unil,0,"R")
   pdfAtSay('AUTORIZACIÓN',unil,92,"R")
   pdfClose()
   set date to FRENCH*/
return

Function paumenta()
declare Window pagare
	pagare.button_1.enabled:=.f.
	pagare.button_2.enabled:=.f.
	pagare.grid_1.enabled:=.f.
	//If inicont = .t.
	//	cahora := chojas
	//	inicont:= .f.
	//	cargacontratos()
	//Else 
		pahora++
		ordpagare()
	//EndIf 
Return Nil

Function pdisminuye()
declare Window pagare
pahora--
pagare.button_1.enabled:=.f.
pagare.button_2.enabled:=.f.
pagare.grid_1.enabled:=.F.
ordpagare()
Return Nil

function ordpagare
/*   parameters opcion
   declare window pagare
   select pagares
   do case
      case opcion =1
           set order to 6
	   mtit:='Buscar x Pagare'
	   mlabel[1]:='# Pagare :'
	   mvalue[1]:=0
	   mformat[1]:="9999999"
      case opcion =2
           set order to 10
	   mtit:='Buscar x # Contrato'
	   mlabel[1]:='# Contrato :'
	   mvalue[1]:=0
	   mformat[1]:="9999999"
      case opcion =6
           set order to 5
	   mtit:='Buscar x Localizacion'
	   mlabel[1]:='Localizacion :'
	   mvalue[1]:=space(7)
	   mformat[1]:=7
      case opcion =4
           set order to 7
	   mtit:='Buscar x Nombre de Usuario'+replicate('_',40)
	   mlabel[1]:='Nombre :'
	   mvalue[1]:=space(40)
	   mformat[1]:=40
  endcase
  go top
  pagare.browse_1.value:=pagares->(recno())
  pagare.browse_1.refresh*/
  Declare Window pagare
cQuery := "select * From Pagares Order By pagare"
	bQuery := oServer:Query (cQuery)
	If bQuery:NetErr()
		Msgstop(bQuery:Error())
		Return Nil
	EndIf 
	pagare.grid_1.DeleteAllItems()
phojas:= round(bQuery:LastRec()/3000,0)
pagare.label_1.Value := "Hoja"+str(pahora)+" / "+str(phojas)
		pfilafin:=pahora*3000
		pfilaini:=pfilafin-3000
 cn:=0
 x:=1
//If primer= 1
	For i := pfilaini To pfilafin //bQuery:LastRec() //
		If cn=500
			doevents()
			cn:=0
		EndIf 
		cn++
		oRow := bQuery:GetRow(i)
		If oRow:FieldGet("pagare") > 0
			pagare.grid_1.AddItem({transform(oRow:FieldGet("pagare"),"9999999"),dtoc(oRow:FieldGet("fecha_act")),;
				transform(oRow:FieldGet("contrato"),'999999'),	alltrim(oRow:FieldGet("ruta")) + "-" + alltrim(oRow:FieldGet("folio")),;
				alltrim(oRow:FieldGet("nombre")),alltrim(oRow:FieldGet("Domicilio"))})
			//aadd(contratoar,{x,oRow:FieldGet("contrato")})
			//x++
		EndIf 
			
	Next

//	muestrainf(1)
//	ahora:=1
bQuery:Destroy()
pagare.button_1.enabled:=.t.
pagare.button_2.enabled:=.t.
pagare.grid_1.enabled:=.t.
//MsgBox(str(ahora),"")
//Padron.Grid_1.Refresh
return

function buscapagares
/*    declare window pagare
    llaveb:=InputWindow(mtit,mlabel,mvalue,mformat)
    if empty(llaveb[1])
       return
    endif
    if valtype(llaveb[1]) ='N'
       if mlabel[1] = '# Contrato :'
          mllaveb:=replicate("0",6-len(alltrim(str(llaveb[1]))))+alltrim(str(llaveb[1]))
       else
          mllaveb:=replicate("0",7-len(alltrim(str(llaveb[1]))))+alltrim(str(llaveb[1]))
       endif
    endif
    select pagares
    if valtype(llaveb[1]) ='N'
       seek mllaveb
    else
       seek upper(mllaveb)
    endif
    pagare.browse_1.value:=pagares->(recno())
    pagare.browse_1.setfocus
    pagare.browse_1.refresh*/
return

function pongetpagval()
   parameters opcionp
   declare window altapagare
   altapagare.button_1.enabled:=opcionp
   altapagare.button_3.enabled:=opcionp
   altapagare.text_9.enabled:=opcionp
   altapagare.text_10.enabled:=opcionp
   altapagare.text_4.enabled:=opcionp
   altapagare.text_5.enabled:=opcionp
   altapagare.text_6.enabled:=opcionp
   altapagare.text_19.enabled:=opcionp
   altapagare.text_20.enabled:=opcionp
   altapagare.text_21.enabled:=opcionp
   altapagare.text_22.enabled:=opcionp
   altapagare.text_23.enabled:=opcionp
   altapagare.text_25.enabled:=opcionp
   altapagare.text_26.enabled:=opcionp
   altapagare.text_27.enabled:=opcionp
return


