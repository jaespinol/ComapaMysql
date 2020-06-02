#include <hmg.ch>

function consbon
   public flagbr:=1
   IF !IsWindowDefined(consbon) 
       Load Window consbon
       Center Window consbon
       consbon.text_1.setfocus
       Activate Window consbon
   endIf
return


function buscbonusu
   declare window consbon
   mven:=' '
   cQuery := "select * from Padron Where RUTA='" + consbon.text_1.Value + "' and folio='" + consbon.text_2.Value + "'"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
	 	MsgInfo('No se encontro al usuario','Mensaje del Sistema')
      consbon.text_1.Value:=space(3)
      consbon.text_2.Value:=space(4)
      consbon.text_1.setfocus
        return Nil
    EndIf
	oRow := bQuery:GetRow(1)
	bQuery:Destroy()
   pondatobon()
return


function pondatobon
Local tmpaut:="", tmptbo:="", tmpcap:=""
   cQuery := "select * from Padron Where RUTA='" + consbon.text_1.Value + "' and folio='" + consbon.text_2.Value + "'"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
	 	MsgInfo('No se encontro al usuario','Mensaje del Sistema')
      consbon.text_1.Value:=space(3)
      consbon.text_2.Value:=space(4)
      consbon.text_1.setfocus
        return Nil
    EndIf
	oRow := bQuery:GetRow(1)
	tmpnombre := oRow:FieldGet("nombre")
	tmpdomicilio := oRow:FieldGet("Domicilio")
	tmptarifa := iif(oRow:FieldGet("tarifa") ='2','FIJA','MEDIDA')
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
   consbon.text_4.value:=tmpmedidor+tmpvalvula
	cQuery := "select lecturista,Rutas.cve_venc,Vencimie.cve_venc, des_venc from Rutas,Vencimie Where Rutas.CVE_RUTA='";
			 + consbon.text_1.Value +"' and Rutas.CVE_VENC=Vencimie.CVE_VENC"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
	 	MsgInfo('No se encontro al usuario','Mensaje del Sistema')
      consbon.text_1.Value:=space(3)
      consbon.text_2.Value:=space(4)
      consbon.text_1.setfocus
        return Nil
    EndIf
	oRow := bQuery:GetRow(1)
	tmrlecturista := oRow:FieldGet("lecturista")
	tmrcve_venc := oRow:FieldGet("Rutas.cve_venc")
	tmrdes_venc := oRow:FieldGet("des_venc")
   bQuery:Destroy()
      consbon.text_3.value:=tmrlecturista
      mven:=tmrcve_venc
   consbon.text_5.value:=tmpnombre
   consbon.text_7.value:=tmptarifa
   consbon.text_8.value:=tmpdomicilio
   consbon.text_9.value:=tmpcontrato
   consbon.text_10.value:=tmpserv_dren
   consbon.text_12.value:=tmpminimo
   consbon.text_13.value:=tmpmeses_rez
   consbon.text_22.value:=tmpcuenta
	y:=1
	For y=1 To len(CatUsu)
		If CatUsu[y,3] = tmpTipo_usu
			consbon.text_11.Value := CatUsu[y,2]
			exit
		EndIf 
	Next
	y:=1
	For y=1 To len(CatGir)
		If CatGir[y,1] = tmpgiro
			consbon.text_18.value:= CatGir[y,2]
			exit
		EndIf 
	Next
	y:=1
	For y=1 To len(CatDia)
		If CatDia[y,12] = tmptoma
			consbon.text_6.value:= CatDia[y,13]
			exit
		EndIf 
	Next
cQuery := "select periodo from Factant Where RUTA='" + consbon.text_1.Value + "'and folio='" + consbon.text_2.Value + "'"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
	 	MsgInfo('No se encontro al usuario','Mensaje del Sistema')
      consbon.text_1.Value:=space(3)
      consbon.text_2.Value:=space(4)
      consbon.text_1.setfocus
        return Nil
    EndIf
	oRow := bQuery:GetRow(1)
	faaperiodo := oRow:FieldGet("periodo")
//   if found()
      consbon.text_14.value:=alltrim(tmrdes_venc)+' '+ames[int(val(right(faaperiodo,2)))]+' '+left(faaperiodo,4)
//   endif
bQuery:Destroy() 
   consbon.text_15.value:=iif(tmptipo_usu='02' .or. tmptipo_usu='03','ALTOS CONSUMOS','BAJOS CONSUMOS')
   if consbon.Grid_1.ItemCount > 0
      consbon.Grid_1.DeleteallItems()
   EndIf 
	cQuery := "select cve_cpto, Cve_bonif, pago_act, fecha_pag, Cve_captur, no_bonif, Apagar, autorizo, num_boleta,"+;
	" contrato from Histbon Where RUTA='" + consbon.text_1.Value + "'and folio='" + consbon.text_2.Value + "' union "+;
	"select cve_cpto, Cve_bonif, pago_act, fecha_pag, Cve_captur, no_bonif, Apagar, autorizo, num_boleta, contrato from"+;
	" Bonifica Where RUTA='" + consbon.text_1.Value + "'and folio='" + consbon.text_2.Value + "'"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
	 	MsgInfo('El usuario no tiene bonificaciones','Mensaje del Sistema')
      consbon.text_1.Value:=space(3)
      consbon.text_2.Value:=space(4)
      consbon.text_1.setfocus
        return Nil
    EndIf
	 
	oRow := bQuery:GetRow(1)
	For i=1 To bQuery:LastRec()
		oRow := bQuery:GetRow(i)
		y:=1
		For y=1 To len(CatAut)
			If CatAut[y,1] = oRow:FieldGet("autorizo")
				tmpaut:= CatAut[y,2]
				exit
			EndIf 
		Next	
		y:=1
		For y=1 To len(CatTbo)
			If CatTbo[y,1] = oRow:FieldGet("Cve_bonif")
				tmpTbo:= CatTbo[y,2]
				exit
			EndIf 
		Next	
		y:=1
		For y=1 To len(CatCap)
			If CatCap[y,1] = oRow:FieldGet("Cve_Captur")
				tmpCap:= CatCap[y,2]
				exit
			EndIf 
		Next	
			consbon.Grid_1.AddItem ({oRow:FieldGet("no_bonif"),dtoc(oRow:FieldGet("fecha_pag")),tmpTbo,transform(oRow:FieldGet("pago_act"),;
			'999,999,999.99'),transform(oRow:FieldGet("apagar"),'999,999,999.99'),tmpAut,tmpCap})
		
	Next
   bQuery:Destroy()
return

function impconsbon
   declare window consbon
   if empty(consbon.text_1.value) .and. empty(consbon.text_2.value)
      consbon.text_1.setfocus
      return
   endif
   SELECT PRINTER DEFAULT ;
   ORIENTATION PRINTER_ORIENT_PORTRAIT;
   PAPERSIZE PRINTER_PAPER_LETTER;
   QUALITY PRINTER_RES_MEDIUM 
   SELECT PRINTER DIALOG TO lSuccess PREVIEW
   If lSuccess == .T.
      start printdoc
      start printpage
      lin:=20
      a:=4
      aumento:=0
      headconsbon(1)
      for n=1 to consbon.Grid_1.ItemCount
         aTemp := consbon.Grid_1.Item(n)
         @ lin,7 print atemp[1] Font "Arial" size 7 bold	  
         @ lin,19 print atemp[2] Font "Arial" size 7 bold 
         @ lin,32 print atemp[3] Font "Arial" size 7 bold 
         @ lin,103 print atemp[4] Font "Arial" size 7 bold right
         @ lin,124 print atemp[5] Font "Arial" size 7 bold right
         @ lin,126 print atemp[6] Font "Arial" size 7 bold 
         @ lin,170 print atemp[7] Font "Arial" size 7 bold 
         if aumento < 60
            aumento:=aumento+1	 
	    lin:=lin+a
         else
            end printpage
	    a:=4
 	    lin:=20
	    aumento:=0
            start printpage
            headconsbon(2)
         endif
      next
      end printpage
      end printdoc
    endif
return

function headconsbon
   parameters galfhead
   declare window consbon
   aTemp := consbon.Grid_1.Item(1)
   p1:=atemp[1]
   aTemp := consbon.Grid_1.Item(consbon.Grid_1.ItemCount)
   p2:=atemp[1]
   @ 10,05 print image "laredo.bmp" width 25 height 20
   @ 10,190 print image "comapa.bmp" width 15 height 20
   @ 10,107 print "COMISION MUNICIPAL DE AGUA POTABLE Y ALCANTARILLADO DEL MUNICIPIO DE NUEVO LAREDO" Font "Arial" size 9.5 BOLD CENTER
   @ 15,107 print 'Estado de cuenta del periodo :'+p1+'  Al periodo :'+p2 Font "Arial" size 8 bold center
   if galfhead = 1
      @ lin,10 print 'Fecha :'+strzero(day(date()),2)+' de '+ames[month(date())]+' del '+alltrim(str(year(date()))) Font "Arial" size 8 bold
      @ lin,165 print 'Hora :'+time() Font "Arial" size 8 bold
      lin:=lin+a
      aumento:=aumento+1
      @ lin,10 print 'Localizacion :'+consbon.text_1.value+'-'+consbon.text_2.value  Font "Arial" size 8 bold
      @ lin,90 print 'Lecturista :'+consbon.text_3.value  Font "Arial" size 8 bold
      @ lin,170 print 'Medidor :'+consbon.text_4.value  Font "Arial" size 8 bold
      lin:=lin+a
      aumento:=aumento+1
      @ lin,10 print 'Nombre :'+consbon.text_5.value  Font "Arial" size 8 bold
      @ lin,90 print 'Toma :'+consbon.text_6.value  Font "Arial" size 8 bold
      @ lin,170 print 'Cuenta :'+consbon.text_22.value  Font "Arial" size 8 bold
      lin:=lin+a
      aumento:=aumento+1
      @ lin,10  print 'Domicilio :'+consbon.text_8.value  Font "Arial" size 8 bold
      @ lin,90 print  'Usuario :'+alltrim(consbon.text_11.value)+' :'+alltrim(consbon.text_18.value) Font "Arial" size 8 bold
      @ lin,170 print 'Minimo :'+transform(consbon.text_12.value,'9999999')  Font "Arial" size 8 bold
      lin:=lin+a
      aumento:=aumento+1
      @ lin,10  print 'Contrato :'+consbon.text_9.value  Font "Arial" size 8 bold
      @ lin,50 print  'Tarifa :'+consbon.text_7.value  Font "Arial" size 8 bold
      @ lin,90 print 'Meses de rezago :'+transform(consbon.text_13.value,'9999999')  Font "Arial" size 8 bold
      @ lin,170 print 'Drenaje :'+consbon.text_10.value Font "Arial" size 8 bold
      lin:=lin+a
      aumento:=aumento+1
   endif
   @ lin,7 print '# Bonif.' Font "Arial" size 7 bold
   @ lin,19 print 'Fecha' Font "Arial" size 7 bold
   @ lin,32 print 'Motivo Bonificacion' Font "Arial" size 7 bold
   @ lin,103 print 'Cant. Bonificada' Font "Arial" size 7 bold right
   @ lin,124 print 'A Pagar' Font "Arial" size 7 bold right
   @ lin,126 print 'Autorizada Por' Font "Arial" size 7 bold 
   @ lin,170 print 'Realizada Por' Font "Arial" size 7 bold 
   lin:=lin+a
   aumento:=aumento+1
   @ lin,1 print line to lin,250 penwidth .4
return
