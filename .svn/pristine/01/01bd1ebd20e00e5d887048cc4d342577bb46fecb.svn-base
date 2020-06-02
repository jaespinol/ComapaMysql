#include <hmg.ch>


function conslect
/*   select padron
   set rela to toma into tomas
   set rela to tipo_usu into usuarios additive
   set rela to giro_n into giros additive*/
   IF !IsWindowDefined(conslect) 
       Load Window conslect
       Center Window conslect
       conslect.text_1.setfocus
       Activate Window conslect
   endIf
return


function busclectusu
Local xy:=0
   declare window conslect
	cQuery := "select * from Padron Where RUTA='" + conslect.text_1.Value + "' and folio='" + conslect.text_2.Value + "'"
	bQuery := oServer:Query(cQuery)
		If bQuery:NetErr()												
			MsgStop ( bQuery:Error() )
			return Nil
		Endif
			if bQuery:LastRec() = 0
	 		MsgInfo('No se encontro al usuario','Mensaje del Sistema')
			conslect.text_1.Value:=space(3)
			conslect.text_2.Value:=space(4)
			conslect.text_1.setfocus
        return Nil
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
	/*
   select padron 
   set order to 1
   seek conslect.text_1.value+conslect.text_2.value
   if !found()
      MsgInfo('La cuenta no existe','Mensaje del Sistema')
      conslect.text_1.value:=space(3)
      conslect.text_2.value:=space(4)
      return
   endif*/
   conslect.text_4.value:=tmpmedidor+tmpvalvula
   cQuery := "select lecturista,Rutas.cve_venc,Vencimie.cve_venc, des_venc from Rutas,Vencimie Where Rutas.CVE_RUTA='";
			 + conslect.text_1.Value +"' and Rutas.CVE_VENC=Vencimie.CVE_VENC"
	bQuery := oServer:Query(cQuery)
		If bQuery:NetErr()												
			MsgStop ( bQuery:Error() )
			return Nil
	   Endif
		if bQuery:LastRec() = 0
	 		MsgInfo('No se encontro al usuario','Mensaje del Sistema')
	      conslect.text_1.Value:=space(3)
		   conslect.text_2.Value:=space(4)
			conslect.text_1.setfocus
	      return Nil
		EndIf
	oRow := bQuery:GetRow(1)
	
	tmrlecturista := oRow:FieldGet("lecturista")
	tmrcve_venc := oRow:FieldGet("Rutas.cve_venc")
	tmrdes_venc := oRow:FieldGet("Vencimie.des_venc")
   bQuery:Destroy()
	//MsgBox(tmrdes_venc,tmrcve_venc)
	/*select rutas
   seek conslect.text_1.value
   if found()*/
   conslect.text_3.value:=tmrlecturista
   mven:=tmrcve_venc
  // endif
  // select padron
   conslect.text_5.value:=tmpnombre
   //conslect.text_6.value:=tomas->des_toma
   conslect.text_7.value:=tmptarifa
   conslect.text_8.value:=tmpdomicilio
   conslect.text_9.value:=tmpcontrato
   conslect.text_10.value:=tmpserv_dren
   //conslect.text_11.value:=alltrim(usuarios->des_usu)
   conslect.text_12.value:=tmpminimo
   conslect.text_13.value:=tmpmeses_rez
   conslect.text_22.value:=tmpcuenta
	y:=1
	For y=1 To len(CatUsu)
		If CatUsu[y,3] = tmpTipo_usu
			conslect.text_11.Value := CatUsu[y,2]
			exit
		EndIf 
	Next
	y:=1
	For y=1 To len(CatGir)
		If CatGir[y,1] = tmpgiro
			conslect.text_18.value:= CatGir[y,2]
			exit
		EndIf 
	Next
	y:=1
	For y=1 To len(CatDia)
		If CatDia[y,12] = tmptoma
			conslect.text_6.value:= CatDia[y,13]
			exit
		EndIf 
	Next
	cQuery := "select periodo from Factant Where RUTA='" + conslect.text_1.Value + "'and folio='" + conslect.text_2.Value + "'"
	bQuery := oServer:Query(cQuery)
		If bQuery:NetErr()												
			MsgStop ( bQuery:Error() )
			return Nil
	   Endif
		if bQuery:LastRec() = 0
	 		MsgInfo('No se encontro al usuario','Mensaje del Sistema')
	      conslect.text_1.Value:=space(3)
		   conslect.text_2.Value:=space(4)
			conslect.text_1.setfocus
			return Nil
	   EndIf
	oRow := bQuery:GetRow(1)
	faaperiodo := oRow:FieldGet("periodo")
	bQuery:Destroy()
//   select fact_ant
//   seek conslect.text_1.value+conslect.text_2.value
//   if found() alltrim(tmrdes_venc)+' '+ames[int(val(right(faaperiodo,2)))]+' '+left(faaperiodo,4)
//   conslect.text_14.value:=tmrdes_venc+' '+ames[int(val(right(faaperiodo,2)))]+' '+left(faaperiodo,4)
//   endif
   conslect.text_15.value:=iif(tmptipo_usu='02' .or. tmptipo_usu='03','ALTOS CONSUMOS','BAJOS CONSUMOS')
   //conslect.text_18.value:=giros->nombre
   //select padron
   If conslect.Grid_1.ItemCount > 0
      conslect.Grid_1.DeleteallItems()
   EndIf 
	   ardbf:={"Facth93","Facth94","Facth95","Facth96","Facth97","Facth98","Facth99","Facth00","Facth01","Facth02"}
   for anio=8 To 9 //1 to 10
      dbfopen:=ardbf[anio]
	cQuery := "select * From " + dbfopen + " Where Ruta='" + conslect.text_1.Value + "' and folio='" + ;
				 conslect.text_2.Value + "'"
	bQuery := oServer:Query(cQuery)
		If bQuery:NetErr()												
			  MsgStop ( bQuery:Error() )
			  return Nil
		Endif
		h=1
      For h=1 To bQuery:LastRec()
			oRow := bQuery:GetRow(h)
			per:=oRow:FieldGet("PERIODO")
			mesper:=left(alltrim(oRow:FieldGet("PERIODO")),4) 
			per2:=right(alltrim(oRow:FieldGet("PERIODO")),2) + '-' + left(alltrim(oRow:FieldGet("PERIODO")),4)
			per1:=right(alltrim(oRow:FieldGet("PERIODO")),2)
			per1:=val(per1)
			leca:=oRow:FieldGet("LECT_ACT")
			lecp:=oRow:FieldGet("LECT_ANT")
			fall:=oRow:FieldGet("FALLA")
			din:=0
			bonis:=0
//         cant1:=oRow:FieldGet("RECARGO")
//			  cant2:=oRow:FieldGet("AD_SIN_IVA")+oRow:FieldGet("AD_SIN_SAN")+ oRow:FieldGet("AD_CON_IVA") + oRow:FieldGet("AD_CON_SAN")
//         cant3:=oRow:FieldGet("ADEUDO_ACT") + oRow:FieldGet("ADEUDO_SAN")
//         cant4:=oRow:FieldGet("AD_IVA")
//         cant5:=oRow:FieldGet("AD_TOTAL")
//         cant6:=oRow:FieldGet("PAGO_ACT")
//         cant12:=oRow:FieldGet("NUM_BOLETA")

/*	for anio=1 to 10
      dbfopen:=ardbf[anio]
      if !abrearch('50',dbfopen,dbfopen,{dbfopen},1,1)
         MsgInfo('La base de datos '+"fecha_fac"+' esta en uso exclusivo','Mensaje del Sistema')
      endif
      set order to 1
      seek conslect.text_1.value+conslect.text_2.value
      do while &dbfopen->ruta + &dbfopen->folio = conslect.text_1.value+conslect.text_2.value*/
         //per:=&dbfopen->periodo
         /*mesper:=left(alltrim(&dbfopen->periodo),4) 
         per2:=right(alltrim(&dbfopen->periodo),2)+'-'+left(alltrim(periodo),4)
         per1:=right(alltrim(&dbfopen->periodo),2)
         per1:=val(per1)
         leca:=&dbfopen->lect_act
         lecp:=&dbfopen->lect_ant
         fall:=&dbfopen->falla*/
         conslect.Grid_1.AddItem ( {per2,transform(leca,'999999999'),transform(lecp,'999999999'),transform(leca-lecp,'999999999'),fall})
		Next 
//         select &dbfopen
//         skip
//      enddo
//      do events
	bQuery:destroy()
   Next
//   select 50
//   use
//   select fact_his
//   set order to 1
//   seek conslect.text_1.value+conslect.text_2.value
	cQuery := "select * From Facthis Where Ruta='" + conslect.text_1.Value + "' and folio='" + ;
				 conslect.text_2.Value + "'"
	bQuery := oServer:Query(cQuery)
		If bQuery:NetErr()												
			  MsgStop ( bQuery:Error() )
			  return Nil
		Endif
		h=1
      For h=1 To bQuery:LastRec()
		oRow := bQuery:GetRow(h)
		   per:=oRow:FieldGet("PERIODO")
         mesper:=left(alltrim(oRow:FieldGet("PERIODO")),4) 
         per2:=right(alltrim(oRow:FieldGet("PERIODO")),2) + '-' + left(alltrim(oRow:FieldGet("PERIODO")),4)
         per1:=right(alltrim(oRow:FieldGet("PERIODO")),2)
         per1:=val(per1)
         leca:=oRow:FieldGet("LECT_ACT")
         lecp:=oRow:FieldGet("LECT_ANT")
         fall:=oRow:FieldGet("FALLA")
         din:=0
         bonis:=0
			/*do while fact_his->ruta + fact_his->folio = conslect.text_1.value+conslect.text_2.value
			per:= periodo
			mesper:=left(alltrim(periodo),4) 
			per2:=right(alltrim(periodo),2)+'-'+left(alltrim(periodo),4)
			per1:=right(alltrim(periodo),2)
			per1:=val(per1)
			leca:=fact_his->lect_act
			lecp:=fact_his->lect_ant
			fall:=fact_his->falla*/
			conslect.Grid_1.AddItem ( {per2,transform(leca,'999999999'),transform(lecp,'999999999'),transform(leca-lecp,'999999999'),fall})
		  // select fact_his
		  // skip
		next
   //enddo
	bQuery:destroy()
   do events
  // select fact_ant
  // set order to 1
  // seek conslect.text_1.value+conslect.text_2.value
  // if found()
	cQuery := "select * From Factant Where Ruta='" + conslect.text_1.Value + "' and folio='" + ;
			    conslect.text_2.Value + "'"
	bQuery := oServer:Query(cQuery)
		If bQuery:NetErr()												
			  MsgStop ( bQuery:Error() )
			  return Nil
		Endif
		h=1
      For h=1 To bQuery:LastRec()
			oRow := bQuery:GetRow(h)
		   per:=oRow:FieldGet("PERIODO")
         mesper:=left(alltrim(oRow:FieldGet("PERIODO")),4) 
         per2:=right(alltrim(oRow:FieldGet("PERIODO")),2) + '-' + left(alltrim(oRow:FieldGet("PERIODO")),4)
         per1:=right(alltrim(oRow:FieldGet("PERIODO")),2)
         per1:=val(per1)
         leca:=oRow:FieldGet("LECT_ACT")
         lecp:=oRow:FieldGet("LECT_ANT")
         fall:=oRow:FieldGet("FALLA")
         din:=0
         bonis:=0
     /*per:=fact_ant->periodo
      mesper:=left(alltrim(fact_ant->periodo),4) 
      per2:=right(alltrim(fact_ant->periodo),2)+'-'+left(alltrim(fact_ant->periodo),4)
      per1:=right(alltrim(fact_ant->periodo),2)
      per1:=val(per1)
      leca:=fact_ant->lect_act
      lecp:=fact_ant->lect_ant
      fall:=fact_ant->falla*/
			conslect.Grid_1.AddItem ( {per2,transform(leca,'999999999'),transform(lecp,'999999999'),transform(leca-lecp,'999999999'),fall})
   //endif
			aTemp := conslect.Grid_1.Item(conslect.Grid_1.ItemCount)
			meses1:=left(atemp[1],2)
			anios1:=right(atemp[1],4)
			meses1:=val(meses1)
			if meses1=1
				meses2:=12
			else
				meses2:=meses1-1 
			endif  
			mesle1=replicate("0",2-len(alltrim(str(meses1))))+alltrim(str(meses1))                 
			mesle2=replicate("0",2-len(alltrim(str(meses2))))+alltrim(str(meses2))
			if tmptarifaa='M'
				//select lecturas
				//seek conslect.text_1.value+conslect.text_2.value
					cQuery := "select * From Lecturas Where Ruta='" + conslect.text_1.Value + "' and folio='" + ;
					conslect.text_2.Value + "'"
				bQuery := oServer:Query(cQuery)
				If bQuery:NetErr()												
					  MsgStop ( bQuery:Error() )
					  return Nil
				Endif
				oRow := bQuery:GetRow(1)
				opmem:=oRow:FieldGet("informa")
				lectad='"lec' + mesle1 + '"'
				faill='"nolec' + mesle1 + '"'
				lectnd='"lec' + mesle2 + '"'
				feclec='"fec' + mesle1 + '"'
				lectad=oRow:FieldGet(&lectad)
				lectnd=oRow:FieldGet(&lectnd)
				faill1=oRow:FieldGet(&faill)
				bQuery:Destroy()
				opmem:=upper(opmem)
				conslect.edit_1.value:=upper(opmem)
			else
      /*select lecturas
      seek conslect.text_1.value+conslect.text_2.value*/
				cQuery := "select * From Lecturas Where Ruta='" + conslect.text_1.Value + "' and folio='" + ;
							 conslect.text_2.Value + "'"
				bQuery := oServer:Query(cQuery)
				If bQuery:NetErr()												
						MsgStop ( bQuery:Error() )
						return Nil
				Endif
					oRow := bQuery:GetRow(1)
					opmem:=oRow:FieldGet("informa")
					opmem:= upper(opmem)
					lectad=tmpminimo
					lectnd=0
					faill1='2'
					conslect.edit_1.value:=upper(opmem)
			endif        
				 mead=val(mesle1)+1
				if mead=13
					mead=1
					anios1=str(val(anios1)+1,4)
				endif	   
			mead=replicate("0",2-len(alltrim(str(mead))))+alltrim(str(mead))
				conslect.Grid_1.AddItem ( {mead+'-'+anios1,transform(lectad,'999999999'),transform(lectnd,'999999999'),transform(lectad-lectnd,'999999999'),faill1})
				conslect.Grid_1.Value := conslect.Grid_1.ItemCount
				conslect.Grid_1.refresh
				conslect.Grid_1.SetFocus 
		next
return

function impconslect
   declare window conslect
   if empty(conslect.text_1.value) .and. empty(conslect.text_2.value)
      conslect.text_1.setfocus
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
      headconlec(1)
      for n=1 to conslect.Grid_1.ItemCount
         aTemp := conslect.Grid_1.Item(n)
         @ lin,7 print atemp[1] Font "Arial" size 7 bold	  
         @ lin,32 print atemp[2] Font "Arial" size 7 bold right
         @ lin,53 print atemp[3] Font "Arial" size 7 bold right
         @ lin,74 print atemp[4] Font "Arial" size 7 bold right
         @ lin,90 print atemp[5] Font "Arial" size 7 bold right
         if aumento < 60
            aumento:=aumento+1	 
	    lin:=lin+a
         else
            end printpage
	    a:=4
 	    lin:=20
	    aumento:=0
            start printpage
            headconlec(2)
         endif
      next
      if len(conslect.edit_1.value) > 0
         nLineas := MLCOUNT(conslect.edit_1.value)
         for nlact =1 to nlineas
            if !empty(MEMOLINE(conslect.edit_1.value,120, nlact))
               @ lin,7  print MEMOLINE(conslect.edit_1.value,120, nlact) font 'Arial' size 8 
               if aumento < 60
                  aumento:=aumento+1	 
	          lin:=lin+a
               else
                  end printpage
                  a:=4
 	          lin:=20
	          aumento:=0
                  start printpage
                  headconlec(2)
               endif
            endif
         next
      endif
      end printpage
      end printdoc
    endif
return

function headconlec
   parameters galfhead
   declare window conslect
   aTemp := conslect.Grid_1.Item(1)
   p1:=atemp[1]
   aTemp := conslect.Grid_1.Item(conslect.Grid_1.ItemCount)
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
      @ lin,10 print 'Localizacion :'+conslect.text_1.value+'-'+conslect.text_2.value  Font "Arial" size 8 bold
      @ lin,90 print 'Lecturista :'+conslect.text_3.value  Font "Arial" size 8 bold
      @ lin,170 print 'Medidor :'+conslect.text_4.value  Font "Arial" size 8 bold
      lin:=lin+a
      aumento:=aumento+1
      @ lin,10 print 'Nombre :'+conslect.text_5.value  Font "Arial" size 8 bold
      @ lin,90 print 'Toma :'+conslect.text_6.value  Font "Arial" size 8 bold
      @ lin,170 print 'Cuenta :'+conslect.text_22.value  Font "Arial" size 8 bold
      lin:=lin+a
      aumento:=aumento+1
      @ lin,10  print 'Domicilio :'+conslect.text_8.value  Font "Arial" size 8 bold
      @ lin,90 print  'Usuario :'+alltrim(conslect.text_11.value)+' :'+alltrim(conslect.text_18.value) Font "Arial" size 8 bold
      @ lin,170 print 'Minimo :'+transform(conslect.text_12.value,'9999999')  Font "Arial" size 8 bold
      lin:=lin+a
      aumento:=aumento+1
      @ lin,10  print 'Contrato :'+conslect.text_9.value  Font "Arial" size 8 bold
      @ lin,50 print  'Tarifa :'+conslect.text_7.value  Font "Arial" size 8 bold
      @ lin,90 print 'Meses de rezago :'+transform(conslect.text_13.value,'9999999')  Font "Arial" size 8 bold
      @ lin,170 print 'Drenaje :'+conslect.text_10.value Font "Arial" size 8 bold
      lin:=lin+a
      aumento:=aumento+1
   endif
   @ lin,7 print 'Periodo' Font "Arial" size 7 bold
   @ lin,21 print 'Lec Ant' Font "Arial" size 7 bold
   @ lin,44 print 'Lec Act' Font "Arial" size 7 bold
   @ lin,64 print 'Consumo' Font "Arial" size 7 bold
   @ lin,84 print 'Falla' Font "Arial" size 7 bold 
   lin:=lin+a
   aumento:=aumento+1
   @ lin,1 print line to lin,250 penwidth .4
return

