#include <hmg.ch>

function consumos
   parameters opconsflag
   public flagbr:=1,flagtimpomp:=1,totpagosh:=0,madudoact:=0,p1,p2,varpagum,acons:={}, apagos:={}, arcortes:={},alect:={},apagares:={},amedis:={},aconve:={},amovp:={},aotros:={}
   public msaldocon:= 0,mpagosnop:= 0,mbonisnop:= 0,mpagocon:= 0,mabodoc:= 0,mabomed:= 0,mpagorx:= 0, msalrec:= 0,msaliva:=0
   public mmeses,mtotpagare:=0,mpagosdoc:=0,msubsid:=0,mtotpagare:=0,mpagosdoc:=0,mabodoc:=0,mabomed:=0,msubsidio:=0,mabomedup:=0,pags:=0
	Public faaPeriodo:="",tmvdes_venc:="",koke:=0, faanumboleta:="", faaad_total:=0, faadescuento:=0, faarecargo:=0, aguaydrenaje:=0, mnumvonv:=0, mnumpagare:=""
	Public tmtContrato:="", tmtPredio:="", tmtMinimo:=0, tmtDren:="", tmtCuenta:="", tmtNombre:="", tmtDomicilio:="", tmtMedidor:="", tmtvalvula:="", tmtEstatus:="", tmtTipo_usu:="", tmtFtepag:="", tmtSector:="", tmtToma:="", tmtColonia:="", tmtTarifa:="", tmtmeses_rez:="", tmtGiro:=""
   //acombopag:={'AGUA NO FACTURADA','CONTRATO AGUA Y DRENAJE','CONSUMO AGUA','CONTRATO DRENAJE','CAMBIO LINEA','CONTRATO AGUA','RECONEXION','EXCESO DE CARGA ORGANICA','MULTA'}
   //aopcombo:={'NF','AD','CA','DE','CL','AS','RX','EX','MU'}
   apagares:={}
   aotros:={}
	IF !IsWindowDefined(edocta) 
       Load Window edocta
       //on key ALT+F8 of edocta action duplicados()
       Center Window edocta
       edocta.combo_3.enabled:=.f.
       edocta.button_4.enabled:=.f.
       edocta.text_1.setfocus
       Activate Window edocta
   endIf
return

function buscusucon
   declare window edocta
Wait Window "Procesando Trabajo, Espere . . ." NOWait    && ventana de espera    
   mven:=' '
	cQuery := "select * from Padron Where RUTA='" + EdoCta.text_1.Value + "' and folio='";
	+ EdoCta.text_2.Value + "'"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
	 	MsgInfo('No se encontro al usuario','Mensaje del Sistema')
      EdoCta.text_1.Value:=space(3)
      EdoCta.text_2.Value:=space(4)
      EdoCta.text_1.setfocus
        return Nil
    EndIf
	oRow := bQuery:GetRow(1)
	bQuery:Destroy()
   pondatoscta()
Wait Clear
return

function buscctap
   declare window edocta
   mven:=' '
	cQuery := "select * From Padron Where  Cuenta='" + EdoCta.text_22.Value + "'"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
   Endif
   if bQuery:LastRec() = 0
	 	MsgInfo('No se encontro al usuario','Mensaje del Sistema')
      EdoCta.text_1.Value:=space(3)
      EdoCta.text_2.Value:=space(4)
      EdoCta.text_1.setfocus
        return Nil
   EndIf
	oRow := bQuery:GetRow(1)
	bQuery:Destroy()
   pondatoscta()
return

function pondatoscta
Local tmtRuta:="", tmtFolio:="",tmtPredio:="", tmtMinimo:=0, tmtDren:="", tmtCuenta:="", tmtNombre:="", tmtDomicilio:="", tmtContrato:="", tmtMedidor:="", tmtEstatus:="", tmtTipo_usu:="", tmtFtepag:="", tmtSector:="", tmtToma:="", tmtColonia:="", tmtTarifa:="", tmtmeses_rez:=0 , tmtGiro:=0
	ponencerocta()
   if edocta.Grid_1.ItemCount > 0
      edocta.Grid_1.DeleteallItems()
   endif
   if edocta.Grid_2.ItemCount > 0
      edocta.Grid_2.DeleteallItems()
   endif
   if edocta.Grid_3.ItemCount > 0
      edocta.Grid_3.DeleteallItems()
   endif
   if edocta.Grid_4.ItemCount > 0
      edocta.Grid_4.DeleteallItems()
   endif
   if edocta.Grid_5.ItemCount > 0
      edocta.Grid_5.DeleteallItems()
   endif
   if edocta.Grid_6.ItemCount > 0
      edocta.Grid_6.DeleteallItems()
   endif
   if edocta.Grid_7.ItemCount > 0
      edocta.Grid_7.DeleteallItems()
   endif
   if edocta.Grid_8.ItemCount > 0
      edocta.Grid_8.DeleteallItems()
   endif
   if edocta.Grid_9.ItemCount > 0
      edocta.Grid_9.DeleteallItems()
   endif
  
   madudoact:=0
	declare window edocta
   mven:=' '
	cQuery := "Select * From Rutas Where cve_ruta='" + EdoCta.text_1.Value + "'"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
   Endif
   if bQuery:LastRec() = 0
	 	MsgInfo('No se encontro la Ruta','Mensaje del Sistema')
      EdoCta.text_1.Value:=space(3)
      EdoCta.text_2.Value:=space(4)
      EdoCta.text_1.setfocus
      return Nil
   EndIf
	oRow := bQuery:GetRow(1)
	edocta.text_3.Value := oRow:FieldGet("Lecturista")
	mven:= oRow:FieldGet("Cve_venc")
	bQuery:Destroy()
  //------------------------------------------------------------------------------
  declare window edocta
	cQuery := "select * From Padron Where Ruta='" + EdoCta.text_1.Value + "' and folio='" + EdoCta.text_2.Value + "'"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
   Endif
	oRow := bQuery:GetRow(1)
		tmtContrato:=oRow:FieldGet("contrato")
		tmtPredio:=oRow:FieldGet("Predio")
		tmtMinimo:=oRow:FieldGet("minimo")
		tmtDren:=iif(oRow:FieldGet("serv_dren") ='1','SI','NO')
		tmtCuenta:=oRow:FieldGet("cuenta")
		tmtNombre:=oRow:FieldGet("Nombre")
		tmtDomicilio:=oRow:FieldGet("Domicilio") 
		tmtMedidor:=iif(empty(oRow:FieldGet("Medidor")),"Fija",oRow:FieldGet("Medidor"))  
		tmtvalvula:=oRow:FieldGet("valvula")
		tmtEstatus:=oRow:FieldGet("Estatus") 
		tmtTipo_usu:=oRow:FieldGet("tipo_usu") 
		tmtFtepag:=oRow:FieldGet("fte_pag") 
		tmtSector:=oRow:FieldGet("Sector") 
		tmtToma:=oRow:FieldGet("toma") 
		tmtColonia:=oRow:FieldGet("Colonia") 
		tmtTarifa:=iif(oRow:FieldGet("Tarifa") ='2','FIJA','MEDIDA')
		tmtmeses_rez:=oRow:FieldGet("meses_rez")
		tmtGiro:=oRow:FieldGet("Giro_n")
    if bQuery:LastRec() = 0
	 	MsgInfo('No se encontro al usuario','Mensaje del Sistema')
      EdoCta.text_1.Value:=space(3)
      EdoCta.text_2.Value:=space(4)
      EdoCta.text_1.setfocus
        return Nil
    EndIf
	edocta.text_4.Value := tmtMedidor
	edocta.text_5.Value := tmtNombre
	edocta.text_7.value:=tmtTarifa 
	edocta.text_8.Value := tmtDomicilio
   edocta.text_9.value:=tmtContrato
   edocta.text_10.value:=tmtDren
	edocta.text_12.value:=tmtMinimo
   edocta.text_13.value:=tmtmeses_rez
   edocta.text_22.value:=tmtCuenta
	edocta.radiogroup_1.value:=iif(tmtDren="SI",1,2)
	edocta.radiogroup_2.value:=iif(tmtTarifa="M",1,2)
   For y=1 To len(CatUsu)
		If CatUsu[y,3] = tmtTipo_usu
			edocta.combo_1.value:= y
			edocta.text_11.Value := CatUsu[y,2]
			exit
		EndIf 
	Next
	n:=1
	For n=1 To len(CatDia)
		If CatDia[n,12] = tmtToma
			edocta.combo_2.value:= n
			edocta.text_6.value:= CatDia[n,13]
			exit
		EndIf 
	Next
	bQuery:Destroy()
	cQuery := "Select * From Padrmov Where Ruta='" + EdoCta.text_1.Value + "' and folio='" + EdoCta.text_2.Value + "'"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
   Endif
	For i := 1 To bQuery:LastRec()
      if oRow:FieldGet("Ruta")+oRow:FieldGet("Folio") = edocta.text_1.value + edocta.text_2.value
         if oRow:FieldGet("campo")='Estatus' .and.  left(oRow:FieldGet("descrip"),1)=' '
				if oRow:FieldGet("capturista") = 'ATX'
               IF !IsWindowDefined(alertausu) 
                  Load Window alertausu
  						alertausu.label_1.value:='Baja Por Sistemas'
						alertausu.label_2.value:=''
						alertausu.label_3.value:=''
                  alertausu.label_4.value:=''
                  Center Window alertausu
                  Activate Window alertausu
               endIf
				endif
			endif
			
		EndIf
		bQuery:Skip(1)
   Next  
	bQuery:Destroy()
   cQuery := "select * From Multas Where Cuenta= '" + EdoCta.text_22.Value + "'"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
   Endif
	if bQuery:LastRec() > 0
      IF !IsWindowDefined(alertausu) 
         Load Window alertausu
			alertausu.label_1.value:=oRow:FieldGet("comenta1")
			alertausu.label_2.value:=oRow:FieldGet("comenta2")
			alertausu.label_3.value:=oRow:FieldGet("comenta3")
         alertausu.label_4.value:='Debe Pasar a Gerencia Comercial'
         Center Window alertausu
         Activate Window alertausu
      endIf
   EndIf 
	bQuery:Destroy()
   cQuery := "select Periodo, rezago_man, pagare, cve_cpto, ad_sin_iva, Ad_con_iva, Ad_con_san, Ad_sin_san Adeudo_act, adeudo_san,"+;
	" ad_iva, ad_total, pago_act, num_boleta, descuento From Factant Where Ruta='" + EdoCta.text_1.Value + "' and folio='" + EdoCta.text_2.Value + "' order by periodo"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
   Endif
	oRow := bQuery:GetRow(1)
	faaPeriodo := oRow:FieldGet("Periodo")
	iif(oRow:FieldGet("Rezago_man")=0,"000000",strzero(oRow:FieldGet("Rezago_man"),6))   //mnumvonv:=oRow:FieldGet("Rezago_man")//iif(oRow:FieldGet("Rezago_man")=0,"000000",strzero(str(oRow:FieldGet("Rezago_man")),6))
   mnumpagare:=oRow:FieldGet("Pagare")
	msbcuscacC:=oRow:FieldGet("rezago_man")//strzero(oRow:FieldGet("rezago_man"),6)
	faaCve_cpto := oRow:FieldGet("Cve_cpto")
	faaRecargo := iif(!empty(oRow:FieldGet("Recargo")),oRow:FieldGet("Recargo"),0)
	faaAd_sin_iva := oRow:FieldGet("Ad_sin_iva")
	faaAd_sin_san := oRow:FieldGet("Ad_sin_san")
	faaAd_con_iva := oRow:FieldGet("Ad_con_iva")
	faaAd_con_san := oRow:FieldGet("Ad_con_san")
	faaAdeudo_act := oRow:FieldGet("Adeudo_act")
	faaAdeudo_san := oRow:FieldGet("Adeudo_san")
	faaAd_iva := oRow:FieldGet("Ad_iva")
	faaAd_total := oRow:FieldGet("Ad_total")
	faaPago_act := oRow:FieldGet("Pago_act")
	faanumboleta := oRow:FieldGet("num_boleta")
	faadescuento:= oRow:FieldGet("descuento")
	bQuery:Destroy()
	if bQuery:LastRec() > 0
      if empty(faaPeriodo)
         MsgInfo('La cuenta no esta aun facturada','Mensaje del Sistema')          
			ponencerocta()
         edocta.text_1.setfocus
         return
      EndIf
		cQuery := "select * from Vencimie where cve_venc =" + mven
		bQuery := oServer:Query(cQuery)
		If bQuery:NetErr()												
			  MsgStop ( bQuery:Error() )
			  return Nil
		Endif
		oRow := bQuery:GetRow(1)
		tmvdes_venc:=oRow:FieldGet("des_venc")
      edocta.text_14.value:=alltrim(tmvdes_venc) + ' ' + ames[int(val(right(faaPeriodo,2)))] + ' ' + left(faaPeriodo,4)
      madudoact:=faaAd_total
   else
      MsgInfo('La cuenta no existe en Fact_ant','Mensaje del Sistema')
      ponencerocta()
      edocta.text_1.setfocus
      return
   endif
	bQuery:Destroy()
   edocta.text_15.value:=iif(tmtTipo_usu='02' .or. tmtTipo_usu='03','ALTOS CONSUMOS','BAJOS CONSUMOS')
   For y=1 To len(CatGir)
		If CatGir[y,1] = tmtgiro
			edocta.text_18.value:= CatGir[y,2]
			exit
		EndIf 
	Next
	y:=0
   msaldocon:=0
   msalrec:=0
   msaliva:=0
   mpagocon:=0
   mtotconv:=0
	cQuery := "select convenio, fecha, valor_con from Convenio where cuenta ='" + tmtCuenta + "'"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
		  MsgStop ( bQuery:Error() )
		  return Nil
	Endif
	if bQuery:LastRec() > 0
		oRow := bQuery:GetRow(1)
		tmcCONVENIO := oRow:FieldGet("CONVENIO")
		tmcFECHA    := oRow:FieldGet("FECHA")
		tmcVALOR_CON:= oRow:FieldGet("VALOR_CON")
		bQuery:Destroy()
				edocta.text_43.value:=tmcconvenio
				edocta.text_44.value:=tmcfecha
				edocta.text_45.value:=tmcvalor_con
			cQuery := "Select * from Pagcon where cuenta ='" + tmcconvenio + "'"
			bQuery := oServer:Query(cQuery)
				If bQuery:NetErr()												
					  MsgStop ( bQuery:Error() )
					  return Nil
				Endif
			If  bQuery:LastRec() > 0
				For c=1 To bQuery:LastRec()
				oRow := bQuery:GetRow(c)
					tmnnoconv:= oRow:FieldGet("CONVENIO")
					tmnpagact:= oRow:FieldGet("PAGO_ACT")
					tmnfecpag:= oRow:FieldGet("FECHA_PAG")
						if tmnfecpag=ctod("  /  /    ")
							msumacon:=msumacon + tmnpagact
							msaldocon:=msaldocon + tmnpagact
							msalrec:=msalrec + tmnsalrec
							msaliva:=msaliva + tmnsaliva
							if k=0
								mpagocon:=tmnpagact
								salrec:=0
								k:=1
							EndIf 
							if tmnpagact >= 0
								edocta.Grid_7.AddItem ( {dtoc(tmnfecpag),transform(tmnpagact,'999,999,999.99')} )
							EndIf 
							bQuery:Skip(1) 
						endif
				Next
				edocta.text_19.value:=tmcCONV
				edocta.text_20.value:=msumacon
				edocta.text_47.value:=msumacon
				edocta.text_46.value:=tmcVALOR_CON - msumacon
			endif
      mconv=edocta.text_43.value
      msumacon=0
      k:=0
   EndIf 	
	bQuery:Destroy()
			cQuery := "Select * from Mediinst where Ruta='" + EdoCta.text_1.Value + "' and folio='" + EdoCta.text_2.Value + "'"
			bQuery := oServer:Query(cQuery)
			If bQuery:NetErr()												
				  MsgStop ( bQuery:Error() )
				  return Nil
			Endif
			oRow := bQuery:GetRow(1)
			tmmrut:= oRow:FieldGet("RUTA")
			tmmfol:= oRow:FieldGet("FOLIO")
			tmmautorizo:= oRow:FieldGet("AUTORIZO")
			tmmcapturo:= oRow:FieldGet("CAPTURO")
			tmmcantidad:= oRow:FieldGet("CANTIDAD")
			tmmmedida:= oRow:FieldGet("TAM_MED")
			tmmfecha:= oRow:FieldGet("FECHA")
			tmmconcepto:= oRow:FieldGet("CONCEPTO")
			bQuery:Destroy()
   If bQuery:LastRec() > 0
      edocta.text_38.value:=tmmmedida
      edocta.text_39.value:=tmmfecha
      edocta.text_40.value:=tmmcantidad
   Else 
      edocta.text_38.value:=space(40)
      edocta.text_39.value:=ctod("  /  /    ")
      edocta.text_40.value:=0
   EndIf 
			cQuery := "Select * from Medis where Ruta='"	+ EdoCta.text_1.Value + "' and folio='" + EdoCta.text_2.Value + "'"
			bQuery := oServer:Query(cQuery)
			If bQuery:NetErr()												
				  MsgStop ( bQuery:Error() )
				  return Nil
			Endif
			mabonmed:=0
			mabomedup:=0
			x:=1
		For x=1 To bQuery:LastRec()
		oRow := bQuery:GetRow(x)
			tmsrut:= oRow:FieldGet("RUTA")
			tmsfol:= oRow:FieldGet("FOLIO")
			tmspago:= oRow:FieldGet("PAGO")
			tmsfech_pag:= oRow:FieldGet("FECHA_PAG")
			tmsconcepto:= oRow:FieldGet("CONCEPTO")
			tmsenviado:= oRow:FieldGet("ENVIADO")
				if tmsrut + tmsfol = edocta.text_1.value + edocta.text_2.value
					if tmsfech_pag <> ctod("  /  /    ")
						mabonmed:=mabonmed + tmspago
					else
						if mabomedup = 0
							mabomedup:=tmspago
						endif
					endif
					edocta.Grid_6.AddItem ( {dtoc(tmsfech_pag),transform(tmspago,'999,999,999.99')} )
				endif
			 bQuery:Skip(1)
		Next 
		edocta.text_16.value:=edocta.text_40.value - mabonmed
		edocta.text_41.value:=mabonmed
		edocta.text_42.value:=edocta.text_40.value - mabonmed
		if edocta.text_42.value = 0
			edocta.button_4.enabled:=.t.
		endif
		bQuery:Destroy()
   cQuery := "Select numero, fecha, clve_area, clve_trab from Varios where Ruta='" + EdoCta.text_1.Value + "' and folio='" + EdoCta.text_2.Value + "'"
	bQuery := oServer:Query(cQuery)
		If bQuery:NetErr()												
			  MsgStop ( bQuery:Error() )
			  return Nil
		Endif
		For v=1 To bQuery:LastRec()
		oRow := bQuery:GetRow(v)
			tmvNUMERO:= oRow:FieldGet("NUMERO")
			tmvFECHA:= oRow:FieldGet("FECHA")
			tmvCLVE_AREA:= oRow:FieldGet("CLVE_AREA")
			tmvCLVE_TRAB:= oRow:FieldGet("CLVE_TRAB")
			if tmvCLVE_AREA = 2 .and. tmvCLVE_TRAB = 26 .and. tmvFECHA >= edocta.text_39.value 
				edocta.text_48.value:=tmvNUMERO
            edocta.text_49.value:=tmvFECHA
			EndIf 
			 bQuery:Skip(1)
		Next
	bQuery:Destroy()
	cQuery := "Select pagare, nombre, total, fecha_act, Fecha_ven, concepto from Pagares where Pagare='" + mnumpagare + "'"
	bQuery := oServer:Query(cQuery)
		If bQuery:NetErr()												
			  MsgStop ( bQuery:Error() )
			  return Nil
		Endif
		oRow := bQuery:GetRow(1)
		tmpPAGARE:= oRow:FieldGet("PAGARE")
		tmpNOMBRE:= oRow:FieldGet("NOMBRE")
		tmpTOTAL:= oRow:FieldGet("TOTAL")
		tmpFECHA_ACT:= oRow:FieldGet("FECHA_ACT")
		tmpFECHA_VEN:= oRow:FieldGet("FECHA_VEN")
		tmpCONCEPTO:= oRow:FieldGet("CONCEPTO")
   valpag=0
   pags=0
   mtotpagare:=0
   mpagosdoc:=0
   mabodoc:=0
   mabomed:=0
	varpagum:=0
   if bQuery:LastRec() > 0
      nump:=tmpPAGARE
      valpag:=tmpTOTAL
      mtotpagare:=tmpTOTAL
      edocta.text_23.value:=tmpPAGARE
      edocta.text_32.value:=tmpFECHA_ACT
      edocta.text_33.value:=tmpFECHA_VEN
      edocta.text_34.value:=tmpTOTAL
      edocta.text_37.value:=tmpNOMBRE
      for k=1 to 9
         if tmpCONCEPTO = aopcombo[k]
            edocta.combo_3.value:=k
				exit
         endif
      next
		bQuery:Destroy()
		cQuery := "Select * from Pagdoc where pagare='" + mnumpagare + "'"
		bQuery := oServer:Query(cQuery)
		If bQuery:NetErr()												
			  MsgStop ( bQuery:Error() )
			  return Nil
		Endif
		oRow := bQuery:GetRow(1)
		tmpdPAGARE:= oRow:FieldGet("PAGARE")
		tmpdPAGO_ACT:= oRow:FieldGet("PAGO_ACT")
		tmpdFECHA_PAG:= oRow:FieldGet("FECHA_PAG")
		tmpdENVIADO:= oRow:FieldGet("ENVIADO")
		For c=1 To bQuery:LastRec()
         if tmpdFECHA_PAG<>ctod("  /  /    ")
            pags:=pags + tmpdPAGO_ACT
         else
            if mabodoc = 0
  					mabodoc:=tmpdPAGO_ACT
				endif
            mpagosdoc:=mpagosdoc + tmpdPAGO_ACT
         endif
         edocta.Grid_5.AddItem ( {dtoc(tmpdFECHA_PAG),transform(tmpdPAGO_ACT,'999,999,999.99')} )
          bQuery:Skip(1)
      Next
		bQuery:Destroy()
		varpagum:=0
		cQuery := "Select * from Ivapag where pagare='" + mnumpagare + "'"
		bQuery := oServer:Query(cQuery)
		If bQuery:NetErr()												
			  MsgStop ( bQuery:Error() )
			  return Nil
		Endif
		oRow := bQuery:GetRow(1)
		tmipPAGARE:= oRow:FieldGet("PAGARE")
		tmipPAGO_ACT:= oRow:FieldGet("PAGO_ACT")
		tmipFECHA_PAG:= oRow:FieldGet("FECHA_PAG")
		tmipENVIADO:= oRow:FieldGet("ENVIADO")
		tmipENVIADO:= oRow:FieldGet("REDONDEO")
		For a=1 To bQuery:LastRec()
            if tmipPAGARE = nump
				  	varpagum:=varpagum  + tmipPAGO_ACT
				endif
			bQuery:Skip(1)
		Next 
		bQuery:Destroy()
   EndIf 
	edocta.text_34.value:=edocta.text_34.value + varpagum
   edocta.text_35.value:=pags
   edocta.text_36.value:=edocta.text_34.value - edocta.text_35.value
   edocta.text_17.value:=edocta.text_36.value
   edocta.Grid_5.value:=edocta.Grid_5.ItemCount
   edocta.Grid_5.Refresh 
	cQuery := "Select INFORMA from Lecturas where Ruta='" + EdoCta.text_1.Value + "' and folio='" + EdoCta.text_2.Value + "'"
		bQuery := oServer:Query(cQuery)
		If bQuery:NetErr()												
			  MsgStop ( bQuery:Error() )
			  return Nil
		Endif
		oRow := bQuery:GetRow(1)
	tmlINFORMA:= oRow:FieldGet("INFORMA")
	If bQuery:LastRec()>0
	  //Msginfo(len(alltrim(lecturas->informa)))
      edocta.edit_1.value:=upper(alltrim(tmlINFORMA))
	  //Msginfo(len(alltrim(edocta.edit_1.value)))
   endif
   edocta.text_17.value:=valpag + varpagum - pags
   if opconsflag = 2
      ponhistoria()
   EndIf 
	bQuery:destroy()
		cQuery := "select ruta, folio, periodo, recargo, ad_sin_iva, ad_sin_san, Ad_con_iva, Ad_con_san, adeudo_act, Adeudo_san, ad_iva, ad_total, pago_act"+;
		", num_boleta, lect_ant, Lect_act, falla From Facthis Where Ruta='" + EdoCta.text_1.Value + "' and folio='" + EdoCta.text_2.Value + "' order by periodo"		
		bQuery := oServer:Query(cQuery)
		If bQuery:NetErr()												
			  MsgStop ( bQuery:Error() )
			  return Nil
		Endif
		koke:=0
      For h=1 To bQuery:LastRec()		
		oRow := bQuery:GetRow(h)
		   per:=oRow:FieldGet("PERIODO")
         mesper:=left(alltrim(per),4) 
         per2:=right(alltrim(per),2) + '-' + left(alltrim(per),4)
         per1:=right(alltrim(per),2)
         per1:=val(per1)
         cant1:=oRow:FieldGet("RECARGO")
			cant2:=oRow:FieldGet("AD_SIN_IVA")+oRow:FieldGet("AD_SIN_SAN")+ oRow:FieldGet("AD_CON_IVA") + oRow:FieldGet("AD_CON_SAN")
         cant3:=oRow:FieldGet("ADEUDO_ACT") + oRow:FieldGet("ADEUDO_SAN")
         cant4:=oRow:FieldGet("AD_IVA")
         cant5:=oRow:FieldGet("AD_TOTAL")
         cant6:=oRow:FieldGet("PAGO_ACT")
         cant12:=oRow:FieldGet("NUM_BOLETA")
         leca:=oRow:FieldGet("LECT_ACT")
         lecp:=oRow:FieldGet("LECT_ANT")
         fall:=oRow:FieldGet("FALLA")
         din:=0
         bonis:=0
            hQuery := "select ruta, folio, periodo, pago_act From Histpap Where Ruta='" + EdoCta.text_1.Value + "' and folio='";
				+ EdoCta.text_2.Value + "' and periodo='" + per + "' union select ruta, folio, periodo, pago_act From Histpag Where Ruta='" ;
				+ EdoCta.text_1.Value + "' and folio='" + EdoCta.text_2.Value + "' and periodo='" + per + "'"
				lQuery := oServer:Query(hQuery)
				If lQuery:NetErr()												
					  MsgStop ( lQuery:Error() )
					  return Nil
				Endif
				p:=1
					For p=1 To lQuery:LastRec()
					oRow := lQuery:GetRow(p)
							if oRow:FieldGet("ruta") + oRow:FieldGet("folio") + oRow:FieldGet("periodo") = edocta.text_1.value + edocta.text_2.value + per
								din:=din + oRow:FieldGet("pago_act")
							endif
							//lQuery:Skip(1)
					Next
				lQuery:Destroy()
           // hQuery := "select ruta, folio, periodo, pago_act From Histpag Where Ruta='" + EdoCta.text_1.Value + "' and folio='" + EdoCta.text_2.Value + ;
			//	"' and periodo='" + per + "'"
			//	lQuery := oServer:Query(hQuery)
			//	If lQuery:NetErr()												
			//		  MsgStop ( lQuery:Error() )
			//		  return Nil
			//	Endif
			//	p:=1
			//		For p=1 To lQuery:LastRec()
			//		oRow := lQuery:GetRow(p)
			//				if oRow:FieldGet("ruta") + oRow:FieldGet("folio") + oRow:FieldGet("periodo") = edocta.text_1.value + edocta.text_2.value + per
			//					din:=din + oRow:FieldGet("pago_act")
		//					endif
		//					//lQuery:Skip(1)
			//		Next   
			//	lQuery:Destroy()
            hQuery := "select ruta, folio, periodo, pago_act From Histbon Where Ruta='" + EdoCta.text_1.Value + "' and folio='" + EdoCta.text_2.Value + "' and periodo='" + per+ "'"
				lQuery := oServer:Query(hQuery)
				If lQuery:NetErr()												
					  MsgStop ( lQuery:Error() )
					  return Nil
				Endif
				p:=1
					For p=1 To lQuery:LastRec()
					oRow := lQuery:GetRow(p)
							if oRow:FieldGet("ruta") + oRow:FieldGet("folio") + oRow:FieldGet("periodo") = edocta.text_1.value + edocta.text_2.value + per
								bonis:=bonis + oRow:FieldGet("pago_act")
							endif
							//lQuery:Skip(1)
					Next   
				lQuery:Destroy()
				edocta.Grid_1.AddItem ( {per2,transform(cant1,'999,999,999.99'),transform(cant2,'999,999,999.99'),transform(cant3,'999,999,999.99'),transform(cant4,'999,999,999.99'),transform(cant5,'999,999,999.99'),;
				transform(cant6,'999,999,999.99'),transform(din,'999,999,999.99'),transform(bonis,'999,999,999.99'),transform(lecp,'999999999'),transform(leca,'999999999'),transform(leca-lecp,'999999999'),;
				fall,0,transform(cant12,'9999999999')} )
				edocta.Grid_4.AddItem ( {per2,transform(leca,'999999999'),transform(lecp,'999999999'),transform(leca-lecp,'999999999'),fall})
			//bQuery:Skip(1) 
			Do Events
      Next
		bQuery:Destroy()
		din:=0
	   bonis:=0
		cQuery := "select periodo, recargo, ad_sin_iva, ad_sin_san, Ad_con_iva, Ad_con_san, adeudo_act, Adeudo_san, ad_iva, ad_total, pago_act"+;
		", num_boleta, lect_ant, Lect_act, falla From Factant Where Ruta='" + EdoCta.text_1.Value + "' and folio='" + EdoCta.text_2.Value + "'"		
		bQuery := oServer:Query(cQuery)
		If bQuery:NetErr()												
			  MsgStop ( bQuery:Error() )
			  return Nil
		Endif
		h:=1
      For h=1 To	bQuery:LastRec()
		oRow := bQuery:GetRow(h)
		   per:=oRow:FieldGet("PERIODO")
         mesper:=left(alltrim(oRow:FieldGet("PERIODO")),4) 
         per2:=right(alltrim(oRow:FieldGet("PERIODO")),2) + '-' + left(alltrim(oRow:FieldGet("PERIODO")),4)
         per1:=right(alltrim(oRow:FieldGet("PERIODO")),2)
         per1:=val(per1)
         cant1:=oRow:FieldGet("RECARGO")
			cant2:=oRow:FieldGet("AD_SIN_IVA") + oRow:FieldGet("AD_SIN_SAN")+ oRow:FieldGet("AD_CON_IVA") + oRow:FieldGet("AD_CON_SAN")
         cant3:=oRow:FieldGet("ADEUDO_ACT") + oRow:FieldGet("ADEUDO_SAN")
         cant4:=oRow:FieldGet("AD_IVA")
         cant5:=oRow:FieldGet("AD_TOTAL")
         cant6:=oRow:FieldGet("PAGO_ACT")
         cant12:=oRow:FieldGet("NUM_BOLETA")
         leca:=oRow:FieldGet("LECT_ACT")
         lecp:=oRow:FieldGet("LECT_ANT")
         fall:=oRow:FieldGet("FALLA")
			edocta.Grid_4.AddItem ( {per2,transform(leca,'999999999'),transform(lecp,'999999999'),transform(leca-lecp,'999999999'),fall})
			aTemp := edocta.Grid_4.Item(edocta.Grid_4.ItemCount)
			meses1=left(atemp[1],2)
			anios1=right(atemp[1],4)
			meses1=val(meses1)
			if meses1 = 1
				meses2:=12
			else
				meses2:=meses1-1 
			endif  
			mesle1=replicate("0",2-len(alltrim(str(meses1)))) + alltrim(str(meses1))                 
			mesle2=replicate("0",2-len(alltrim(str(meses2)))) + alltrim(str(meses2))
			if EdoCta.text_7.Value = 'M'
				nQuery := "select * From Lecturas Where Ruta='" + EdoCta.text_1.Value + "' and folio='" + EdoCta.text_2.Value + "'"		
				lQuery := oServer:Query(nQuery)
				If lQuery:NetErr()												
					  MsgStop ( lQuery:Error() )
					  return Nil
				Endif
				oRow := lQuery:GetRow(1)
				opmem:=oRow:FieldGet("informa")
				lectad='"lec' + mesle1 + '"'
				faill='"nolec' + mesle1 + '"'
				lectnd='"lec' + mesle2 + '"'
				feclec='"fec' + mesle1 + '"'
				lectad=oRow:FieldGet(&lectad)
				lectnd=oRow:FieldGet(&lectnd)
				faill1=oRow:FieldGet(&faill)
				lQuery:Destroy()
			Else 
				nQuery := "select INFORMA From Lecturas Where Ruta='" + EdoCta.text_1.Value + "' and folio='" + EdoCta.text_2.Value + "'"		
				lQuery := oServer:Query(cQuery)
				If lQuery:NetErr()												
					  MsgStop ( lQuery:Error() )
					  return Nil
				Endif
		oRow := lQuery:GetRow(1)
				opmem:= oRow:FieldGet("informa")
				lectad=tmtMinimo
				lectnd=0
				faill1='2'
				lQuery:Destroy()
			endif        
			mead=val(mesle1) + 1
			if mead=13
				mead=1
				anios1=str(val(anios1) + 1,4)
			endif	   
			mead=replicate("0",2-len(alltrim(str(mead)))) + alltrim(str(mead))
			edocta.Grid_4.AddItem ( {mead+'-'+anios1,transform(lectad,'999999999'),transform(lectnd,'999999999'),transform(lectad-lectnd,'999999999'),faill1})
			edocta.Grid_4.Value := edocta.Grid_4.ItemCount
			edocta.Grid_4.refresh
			din:=0
			bonis:=0
			mbonisnop:=0
			mpagosnop:=0
			mfecbonant:=ctod('  /  /    ')
			nQuery := "select	* From Histpag Where Ruta='" + EdoCta.text_1.Value + "' and folio='" + EdoCta.text_2.Value + "'"		
			lQuery := oServer:Query(nQuery)
			If lQuery:NetErr()												
				  MsgStop ( lQuery:Error() )
				  return Nil
			Endif
			if lQuery:LastRec()>0
			a:=1
					For a=1 To	lQuery:LastRec()
					oRow := lQuery:GetRow(a)
					if oRow:FieldGet("ruta") + oRow:FieldGet("folio") = edocta.text_1.value + edocta.text_2.value .and. oRow:FieldGet("facturado") = " "
						din:=din + oRow:FieldGet("pago_act")
						mpagosnop:=mpagosnop + oRow:FieldGet("pago_act")
					endif
					lQuery:Skip(1)
					next 
			endif   
			lQuery:Destroy()
			nQuery := "select * From Diapag Where Ruta='" + EdoCta.text_1.Value + "' and folio='" + EdoCta.text_2.Value + "'"	
			lQuery := oServer:Query(nQuery)
		
			If lQuery:NetErr()												
				  MsgStop ( lQuery:Error() )
				  return Nil
			Endif
			if lQuery:LastRec()>0
			e:=1
				For e=1 To	bQuery:LastRec()
				oRow := lQuery:GetRow(e)
					if oRow:FieldGet("ruta") + oRow:FieldGet("folio") = edocta.text_1.value + edocta.text_2.value
						if oRow:FieldGet("cve_cpto") = '01'
							din:=din + oRow:FieldGet("pago_act")
							mpagosnop:=mpagosnop + oRow:FieldGet("pago_act")
						endif
					endif
					lQuery:Skip(1)
				Next
			endif  
			lQuery:Destroy()
			nQuery := "select * From Histbon Where Ruta='" + EdoCta.text_1.Value + "' and folio='" + EdoCta.text_2.Value + "'"	
			lQuery := oServer:Query(nQuery)
			If lQuery:NetErr()												
				  MsgStop ( lQuery:Error() )
				  return Nil
			Endif
			e:=1
			if lQuery:LastRec()>0
				For e=1 To	bQuery:LastRec()
			oRow := lQuery:GetRow(e)
					if oRow:FieldGet("ruta") + oRow:FieldGet("folio")  = edocta.text_1.value + edocta.text_2.value .and. oRow:FieldGet("facturado") = ' '
						bonis:=bonis + oRow:FieldGet("pago_act")
						mbonisnop:=mbonisnop + oRow:FieldGet("pago_act")
					endif 
				 lQuery:Skip(1)
				Next
				lQuery:Skip(-1)
				mfecbonant:=oRow:FieldGet("fecha_pag")
			endif           
			lQuery:Destroy()
			nQuery := "select * From Bonifica Where Ruta='" + EdoCta.text_1.Value + "' and folio='" + EdoCta.text_2.Value + "'"	
			lQuery := oServer:Query(nQuery)
			If lQuery:NetErr()												
				  MsgStop ( lQuery:Error() )
				  return Nil
			Endif
			if lQuery:LastRec()>0
				For e=1 To	bQuery:LastRec()
				oRow := lQuery:GetRow(e)
					if oRow:FieldGet("ruta") + oRow:FieldGet("folio") = edocta.text_1.value + edocta.text_2.value
						bonis:=bonis + oRow:FieldGet("pago_act")
						mbonisnop:=mbonisnop + oRow:FieldGet("pago_act")
					endif
					lQuery:Skip(1)
				Next
				lQuery:Skip(-1)
				mfecbonant:=oRow:FieldGet("fecha_pag")
			endif           
			lQuery:Destroy()
			nQuery := "select * From Bonifica Where contrato='" + EdoCta.text_9.Value + "'"
			lQuery := oServer:Query(nQuery)
			If lQuery:NetErr()												
				  MsgStop ( lQuery:Error() )
				  return Nil
			Endif 
				msubsidio:=0
						oRow := bQuery:GetRow(1)
				if lQuery:LastRec()>0
					msubsidio:=oRow:FieldGet("pago_act")
				endif  
				lQuery:Destroy()
			*edocta.text_21.value:=cant5 - din - bonis -subsidio
			edocta.Grid_1.AddItem ( {per2,transform(cant1,'999,999,999.99'),transform(cant2,'999,999,999.99'),transform(cant3,'999,999,999.99'),transform(cant4,'999,999,999.99'),transform(cant5,'999,999,999.99'),;
			transform( din+bonis,'999,999,999.99'),transform(din,'999,999,999.99'),transform(bonis,'999,999,999.99'),transform(lecp,'999999999'),transform(leca,'999999999'),transform(leca-lecp,'999999999'),;
			fall,0,transform(cant12,'9999999999')} )
			bQuery:Skip(-1)
		next 
		edocta.Grid_1.Value := edocta.Grid_1.ItemCount
		edocta.Grid_1.refresh
		llenapagos() 
		llenacorte() 
		llenamovpad()
		llenaotros()
		if int(((date()- mfecbonant)/30.4)) <= 6
			IF !IsWindowDefined(alertausu) 
				Load Window alertausu
				alertausu.label_1.value:='El Usuario tiene una bonificacion'
				alertausu.label_2.value:='Dentro de un periodod de 6 meses'
				alertausu.label_3.value:=''
				alertausu.label_4.value:=''
				Center Window alertausu
				Activate Window alertausu
			endIf
		endif
		edocta.Grid_1.setfocus
return

//*******************************************-----------------------------------------------------*******************************************

function ponhistoria
Local xy:=0
   ardbf:={"Facth93","Facth94","Facth95","Facth96","Facth97","Facth98","Facth99","Facth00","Facth01","Facth02"} 
   for anio=8 To 9 //1 to 10
      dbfopen:=ardbf[anio]
		 cQuery := "select * From " + dbfopen + " Where Ruta='" + EdoCta.text_1.Value + "' and folio='" + ;
			EdoCta.text_2.Value + "'"
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
         cant1:=oRow:FieldGet("RECARGO")
			cant2:=oRow:FieldGet("AD_SIN_IVA")+oRow:FieldGet("AD_SIN_SAN")+ oRow:FieldGet("AD_CON_IVA") + oRow:FieldGet("AD_CON_SAN")
         cant3:=oRow:FieldGet("ADEUDO_ACT") + oRow:FieldGet("ADEUDO_SAN")
         cant4:=oRow:FieldGet("AD_IVA")
         cant5:=oRow:FieldGet("AD_TOTAL")
         cant6:=oRow:FieldGet("PAGO_ACT")
         cant12:=oRow:FieldGet("NUM_BOLETA")
         leca:=oRow:FieldGet("LECT_ACT")
         lecp:=oRow:FieldGet("LECT_ANT")
         fall:=oRow:FieldGet("FALLA")
         din:=0
         bonis:=0
            hQuery := "Select * From Histpap Where Ruta='" + EdoCta.text_1.Value + "' and folio='" + EdoCta.text_2.Value + "' and periodo='" + per + "'"
				lQuery := oServer:Query(hQuery)
				If lQuery:NetErr()												
					  MsgStop ( lQuery:Error() )
					  return Nil
				Endif
				p:=1
				For p=1 To lQuery:LastRec()
				oRow := lQuery:GetRow(p)
						if oRow:FieldGet("ruta") + oRow:FieldGet("folio") + oRow:FieldGet("periodo") = edocta.text_1.value + edocta.text_2.value + per
   						din:=din + oRow:FieldGet("pago_act")
						endif
						lQuery:Skip(1)
				Next
				lQuery:Destroy()
            hQuery := "select * From Histpag Where Ruta='" + EdoCta.text_1.Value + "' and folio='" + EdoCta.text_2.Value + "' and periodo='" + per + "'"
				lQuery := oServer:Query(hQuery)
				If lQuery:NetErr()												
					  MsgStop ( lQuery:Error() )
					  return Nil
				Endif
				p:=1
				For p=1 To lQuery:LastRec()
				oRow := lQuery:GetRow(p)
						if oRow:FieldGet("ruta") + oRow:FieldGet("folio") + oRow:FieldGet("periodo") = edocta.text_1.value + edocta.text_2.value + per
  							din:=din + oRow:FieldGet("pago_act")
						endif
            		lQuery:Skip(1)
				Next   
				lQuery:Destroy()
            hQuery := "select * From Histbon Where Ruta='" + EdoCta.text_1.Value + "' and folio='" + EdoCta.text_2.Value + "' and periodo='" + per + "'"
				lQuery := oServer:Query(hQuery)
				If lQuery:NetErr()												
					  MsgStop ( lQuery:Error() )
					  return Nil
				Endif
				p:=1
				For p=1 To lQuery:LastRec()
				oRow := lQuery:GetRow(p)
						if oRow:FieldGet("ruta") + oRow:FieldGet("folio") + oRow:FieldGet("periodo") = edocta.text_1.value + edocta.text_2.value + per
  							bonis:=bonis + oRow:FieldGet("pago_act")
						endif
            		lQuery:Skip(1)
				Next   
				lQuery:Destroy()
         edocta.Grid_1.AddItem ( {per2,transform(cant1,'999,999,999.99'),transform(cant2,'999,999,999.99'),transform(cant3,'999,999,999.99'),transform(cant4,'999,999,999.99'),transform(cant5,'999,999,999.99'),;
         transform(cant6,'999,999,999.99'),transform(din,'999,999,999.99'),transform(bonis,'999,999,999.99'),transform(lecp,'999999999'),transform(leca,'999999999'),transform(leca-lecp,'999999999'),;
         fall,0,transform(cant12,'9999999999')} )
         edocta.Grid_4.AddItem ( {per2,transform(leca,'999999999'),transform(lecp,'999999999'),transform(leca-lecp,'999999999'),fall})
			bQuery:Skip(1)
			Do Events
      Next
		bQuery:Destroy()
	next
	
return nil


function llenapagos()
   declare windows edocta
				hQuery := "Select * From Histpap Where Ruta='" + EdoCta.text_1.Value + "' and folio='" + EdoCta.text_2.Value + "'" 
				lQuery := oServer:Query(hQuery)
				If lQuery:NetErr()												
					  MsgStop ( bQuery:Error() )
					  return Nil
				Endif
	totpagosh:=0
   mvara:=0
   mvarb:=0		
	if lQuery:LastRec()>0
	p:=1
		For p=1 To lQuery:LastRec()
		oRow := lQuery:GetRow(p)
         if oRow:FieldGet("ruta") +oRow:FieldGet("folio") = edocta.text_1.value + edocta.text_2.value
				mvara:=mvara + 1
            infor:=transform(oRow:FieldGet("pago_act"),'999,999.99') + '  ' + dtoc(oRow:FieldGet("fecha_pag")) +;
				'  ' + iif(empty(oRow:FieldGet("fte_pago")),' ',oRow:FieldGet("fte_pago")) + ' ' + oRow:FieldGet("periodo")
            edocta.Grid_2.AddItem ( {infor, space(20) , space(20), space(20)})
			endif
			lQuery:Skip(1)
      Next
   EndIf 
	lQuery:Destroy()
	hQuery := "select * From Histpag Where Ruta='" + EdoCta.text_1.Value + "' and folio='" + EdoCta.text_2.Value + "'" // and periodo='" + per+ "'"
		lQuery := oServer:Query(hQuery)			
		If lQuery:NetErr()															
			MsgStop ( lQuery:Error() ) 
			return Nil			  			
		Endif			
		totpagosh:=0
		mvara:=0
		mvarb:=0		
	if lQuery:LastRec()>0
	p:=1
		For p=1 To lQuery:LastRec()  
		oRow := lQuery:GetRow(p)
         if oRow:FieldGet("ruta") +oRow:FieldGet("folio") = edocta.text_1.value + edocta.text_2.value
				mvara:=mvara + 1
            infor:=transform(oRow:FieldGet("pago_act"),'999,999.99') + '  ' + dtoc(oRow:FieldGet("fecha_pag")) +;
				'  ' + iif(empty(oRow:FieldGet("fte_pago")),' ',oRow:FieldGet("fte_pago")) + ' ' + oRow:FieldGet("periodo")
            edocta.Grid_2.AddItem ( {infor, space(20) , space(20), space(20)})
			endif
			lQuery:Skip(1)
      Next
	EndIf 
	lQuery:Destroy()
  hQuery := "select * From Histpag Where Ruta='" + EdoCta.text_1.Value + "' and folio='" + EdoCta.text_2.Value + "'" // and periodo='" + per+ "'"
					lQuery := oServer:Query(hQuery)
					If lQuery:NetErr()												
						  MsgStop ( lQuery:Error() )
						  return Nil
					Endif
		totpagosh:=0
		mvara:=0
		mvarb:=0		
	if lQuery:LastRec()>0
	p:=1
		For p=1 To lQuery:LastRec()  
		oRow := lQuery:GetRow(p)
         if oRow:FieldGet("ruta") + oRow:FieldGet("folio") = edocta.text_1.value + edocta.text_2.value .and. oRow:FieldGet("facturado") = ' '
 				totpagosh:=totpagosh + oRow:FieldGet("pago_act")
            infor:=transform(oRow:FieldGet("pago_act"),'999,999.99') + '  ' + dtoc(oRow:FieldGet("fecha_pag")) + '  ' + iif(empty(oRow:FieldGet("fte_pago")),' ',oRow:FieldGet("fte_pago"))
				if edocta.Grid_2.ItemCount > 0
					mvarb:=mvarb + 1
					if mvarb <= mvara 
                  aTemp := edocta.Grid_2.Item(mvarb)
                  edocta.Grid_2.Item (mvarb) := { atemp[1] , infor , atemp[3] , atemp[4]}
               else
                  edocta.Grid_2.AddItem ( {space(20) , infor , space(20), space(20)})
					endif
				else
               mvarb:=mvarb + 1
               edocta.Grid_2.AddItem ( {space(20) , infor , space(20), space(20)})
				endif
			endif
			lQuery:Skip(1)
      Next
   EndIf 
	lQuery:Destroy()
    hQuery := "select * From Histpag Where Ruta='" + EdoCta.text_1.Value + "' and folio='" + EdoCta.text_2.Value + "'" // and periodo='" + per+ "'"
					lQuery := oServer:Query(hQuery)
		If lQuery:NetErr()															
			MsgStop ( lQuery:Error() )
			return Nil
		Endif
		totpagosh:=0
		mvara:=0
		mvarb:=0		
	if lQuery:LastRec()>0
	p:=1
		For p=1 To lQuery:LastRec()
		oRow := lQuery:GetRow(p)
         if oRow:FieldGet("ruta") + oRow:FieldGet("folio") = edocta.text_1.value + edocta.text_2.value .and. oRow:FieldGet("facturado") = ' ' .and. oRow:FieldGet("cve_cpto") = '01'
  				totpagosh:=totpagosh + oRow:FieldGet("pago_act")
            infor:=transform(oRow:FieldGet("pago_act"),'999,999.99') + '  ' + dtoc(oRow:FieldGet("fecha_pag")) + '  ' + oRow:FieldGet("fte_pago")
				if edocta.Grid_2.ItemCount > 0
					mvarb:=mvarb + 1
					if mvarb <= mvara 
                  aTemp := edocta.Grid_2.Item(mvarb)
                  edocta.Grid_2.Item (mvarb) := { atemp[1] , infor , atemp[3] , atemp[4]}
               else
                  edocta.Grid_2.AddItem ( {space(20) , infor , space(20), space(20)})
					endif
				else
               mvarb:=mvarb + 1
               edocta.Grid_2.AddItem ( {space(20) , infor , space(20), space(20)})
				endif
			endif
			lQuery:Skip(1)
      Next
   EndIf 
	lQuery:Destroy()
   if mvarb > mvara 
      mvara:= mvarb
   endif
   mvarb:= 0
				hQuery := "select * From Histbon Where Ruta='" + EdoCta.text_1.Value + "' and folio='" + EdoCta.text_2.Value + "'" // and periodo='" + per+ "'"
				lQuery := oServer:Query(hQuery)
				If lQuery:NetErr()												
					  MsgStop ( lQuery:Error() )
					  return Nil
				Endif
	if lQuery:LastRec()>0
	p:=1
		For p=1 To lQuery:LastRec()
  oRow := lQuery:GetRow(p)
			if oRow:FieldGet("ruta") + oRow:FieldGet("folio") = edocta.text_1.value + edocta.text_2.value .and. oRow:FieldGet("facturado") = '1'
            infor:=transform(oRow:FieldGet("pago_act"),'999,999.99') + '  ' + dtoc(oRow:FieldGet("fecha_pag"))+' '+oRow:FieldGet("periodo") 
				if edocta.Grid_2.ItemCount > 0
					mvarb:=mvarb + 1
					if mvarb <= mvara 
                  aTemp := edocta.Grid_2.Item(mvarb)
                  edocta.Grid_2.Item (mvarb) := { atemp[1] , atemp[2]  , infor , atemp[4]}
               else
   					edocta.Grid_2.AddItem ( {space(20) , space(20), infor , space(20)})
					endif
				else
               mvarb:=mvarb + 1
               edocta.Grid_2.AddItem ( {space(20) , space(20), infor , space(20)})
				endif
			endif
			lQuery:Skip(1)
      Next
   EndIf 
	lQuery:Destroy()
   if mvarb > mvara 
      mvara:= mvarb
   endif
   mvarb = 0
	hQuery :="select * From Histbon Where Ruta='" + EdoCta.text_1.Value + "' and folio='" + EdoCta.text_2.Value + "'" // and periodo='" + per+ "'"
				lQuery := oServer:Query(hQuery)
				If lQuery:NetErr()												
					  MsgStop ( lQuery:Error() )
					  return Nil
				Endif
	if lQuery:LastRec()>0
	p:=1
		For p=1 To lQuery:LastRec()
		oRow := lQuery:GetRow(p)
         if oRow:FieldGet("ruta") + oRow:FieldGet("folio") = edocta.text_1.value + edocta.text_2.value .and. oRow:FieldGet("facturado") = ' '
 				totpagosh:=totpagosh + oRow:FieldGet("pago_act")
            infor:=transform(oRow:FieldGet("pago_act"),'999,999.99')+'  '+ dtoc(oRow:FieldGet("fecha_pag")) 
				if edocta.Grid_2.ItemCount > 0
					mvarb:=mvarb + 1
					if mvarb <= mvara 
                  aTemp := edocta.Grid_2.Item(mvarb)
                  edocta.Grid_2.Item (mvarb) := { atemp[1] , atemp[2]  ,  atemp[3], infor }
               else
                  edocta.Grid_2.AddItem ( {space(20) , space(20), space(20), infor })
					endif
				else
               mvarb:=mvarb + 1
               edocta.Grid_2.AddItem ( {space(20) , space(20), space(20), infor })
				endif
			endif
			lQuery:Skip(1)
      Next
   EndIf 
	lQuery:Destroy()
			 nQuery := "select * From Bonifica Where Ruta='" + EdoCta.text_1.Value + "' and folio='" + EdoCta.text_2.Value + "'"	
		lQuery := oServer:Query(nQuery)
		If lQuery:NetErr()												
			  MsgStop ( lQuery:Error() )
			  return Nil
		Endif
		if lQuery:LastRec()>0
		e:=1
      For e=1 To lQuery:LastRec() 
		oRow := lQuery:GetRow(p)
         if oRow:FieldGet("ruta") + oRow:FieldGet("folio") = edocta.text_1.value + edocta.text_2.value .and. oRow:FieldGet("facturado") = ' '
  				totpagosh:=totpagosh + oRow:FieldGet("pago_act")
            infor:=transform(oRow:FieldGet("pago_act"),'999,999.99') + '  ' + dtoc(oRow:FieldGet("fecha_pag")) 
				if edocta.Grid_2.ItemCount > 0
					mvarb:=mvarb + 1
					if mvarb <= mvara 
                  aTemp := edocta.Grid_2.Item(mvarb)
                  edocta.Grid_2.Item (mvarb) := { atemp[1] , atemp[2]  ,  atemp[3], infor }
               else
                  edocta.Grid_2.AddItem ( {space(20) , space(20), space(20), infor })
					endif
				else
               mvarb:=mvarb + 1
               edocta.Grid_2.AddItem ( {space(20) , space(20), space(20), infor })
				endif
			endif
			lQuery:Skip(1)
      Next
   EndIf 
	lQuery:Destroy()
return nil 


function llenaotros
   declare window edocta 
   nQuery := "select * From Histotr Where Ruta='" + EdoCta.text_1.Value + "' and folio='" + EdoCta.text_2.Value + "'"	
				lQuery := oServer:Query(nQuery)
		If lQuery:NetErr()												
			  MsgStop ( lQuery:Error() )
			  return Nil
		Endif
	if lQuery:LastRec()>0
		e:=1
      For e=1 To	lQuery:LastRec()
		oRow := lQuery:GetRow(e)
         if oRow:FieldGet("ruta") + oRow:FieldGet("folio") = edocta.text_1.value + edocta.text_2.value
            mnomcp:=space(25)
				y:=1
				For y=1 To len(CatCpt)
					If CatCpt[y,1] = val(oRow:FieldGet("cve_cpto"))
						mnomcp := CatCpt[y,2]
						exit
					EndIf 
				Next
				edocta.Grid_9.AddItem ({ dtoc(oRow:FieldGet("fecha_pag")) , oRow:FieldGet("recibo") , oRow:FieldGet("cve_cpto"), mnomcp, transform(oRow:FieldGet("pago_act"),'999,999,999.99')  })
			endif
			lQuery:Skip(1)
      Next
   EndIf 
	lQuery:Destroy()
   nQuery := "select * From Diapag Where Ruta='" + EdoCta.text_1.Value + "' and folio='" + EdoCta.text_2.Value + "'"	
				lQuery := oServer:Query(nQuery)
		If lQuery:NetErr()												
			  MsgStop ( lQuery:Error() )
			  return Nil
		Endif
	if lQuery:LastRec()>0
		e=1
      For e=1 To	lQuery:LastRec()
		oRow := lQuery:GetRow(e)
         if oRow:FieldGet("ruta") + oRow:FieldGet("folio") = edocta.text_1.value + edocta.text_2.value 
				if oRow:FieldGet("cve_cpto") <> '01'
               For y=1 To len(CatCpt)
					If CatCpt[y,3] = oRow:FieldGet("cve_cpto")
						//edocta.combo_1.value:= y
						mnomcp := CatUsi[y,2]
						exit
					EndIf 
				Next
					edocta.Grid_9.AddItem ({ dtoc(oRow:FieldGet("fecha_pag")) , oRow:FieldGet("recibo") , oRow:FieldGet("cve_cpto"), mnomcp, transform(oRow:FieldGet("pago_act"),'999,999,999.99')  })
				endif
         endif 
         lQuery:Skip(1)
      Next
   EndIf 
	lQuery:Destroy()
return


function llenacorte
   declare window edocta 
 nQuery := "select * From Cortenvo Where cuenta='" + EdoCta.text_22.Value + "'"	
				lQuery := oServer:Query(nQuery)
		If lQuery:NetErr()												
			  MsgStop ( lQuery:Error() )
			  return Nil
		Endif
	if lQuery:LastRec()>0
		e:=1
      For e=1 To bQuery:LastRec()
		oRow := lQuery:GetRow(e)
         edocta.Grid_3.AddItem ({ dtoc(oRow:FieldGet("corte")) , dtoc(oRow:FieldGet("reconexion")) , oRow:FieldGet("tipo_corte"), iif(oRow:FieldGet("tp")='D','S',' ') })
          lQuery:Skip(1)
      Next
   EndIf 
	lQuery:Destroy()
//   edocta.Grid_3.value:=numregc
   edocta.Grid_3.refresh
return

function buscapadcon 
  parameters flagbr
   //select padron 
   //set order to 3
   //go top
   IF !IsWindowDefined(browpadcon) 
       Load Window browpadcon
       Center Window browpadcon
       Activate Window browpadcon
   endIf
return

function brobscapadcon1 //jorge
   parameters falgnsca
   declare window browpadcon

	browpadcon.grid_1.DeleteAllItems()

   If falgnsca  = 1
		cQuery := "select Ruta, Folio, Cuenta, Nombre, Domicilio From Padron where nombre like'%" + browpadcon.text_1.Value + "%' order by nombre"
   Else
		cQuery := "select Ruta, Folio, Cuenta, Nombre, Domicilio From Padron where domicilio like '%" + browpadcon.text_2.Value + "%' order by domicilio"
   EndIf 
		bQuery := oServer:Query (cQuery)
		If bQuery:NetErr()
			Msgstop(bQuery:Error())
			Return Nil
		EndIf
		MsgBox(bQuery:LastRec(),"")
	For i=1 To bQuery:LastRec()
		oRow := bQuery:GetRow(i)
		browpadcon.grid_1.AddItem({oRow:FieldGet("Ruta")+ "-" + oRow:FieldGet("Folio"),oRow:FieldGet("cuenta"),oRow:FieldGet("Nombre"),oRow:FieldGet("Domicilio")})
		bQuery:Skip(1)
	Next
	bQuery:destroy()
//{'Localizacion','Cuenta','Nombre','Domicilio'} 
//	browpadcon.browse_1.value:=padron->(recno())
   browpadcon.grid_1.refresh
   browpadcon.grid_1.setfocus
return

function ponvalbrow1
Local nValue:={}, klinea:=0, busruta:="", busfolio:=""
	//select padron

   if flagbr =1
      declare window edocta
      declare window browpadcon
		kLinea := browpadcon.grid_1.Value
		nValue := browpadcon.grid_1.item (kLinea)
		//MsgBox(nValue[1],"")
		busruta := left(nValue[1],3)
		busfolio := right(nValue[1],4)
		//MsgBox(busruta,busfolio)
      edocta.text_1.value:=busruta
      edocta.text_2.value:=busfolio
      browpadcon.release
      edocta.text_2.caretpos:=len(busfolio)
      edocta.text_2.setfocus
      pondatoscta()
   else
      if flagbr = 2
         declare window conslect
         declare window browpadcon
			kLinea := browpadcon.grid_1.Value
			nValue := browpadcon.grid_1.item (kLinea)
			busruta := left(nValue[1],3)
			busfolio := right(nValue[1],4)
         conslect.text_1.value:=busruta
         conslect.text_2.value:=busfolio
         browpadcon.release
         conslect.text_2.caretpos:=len(alltrim(busfolio))
         conslect.text_2.setfocus
      else
         if flagbr = 3
            declare window cambpad
            declare window browpadcon
				kLinea := browpadcon.grid_1.Value
				nValue := browpadcon.grid_1.item (kLinea)
				busruta := left(nValue[1],3)
				busfolio := right(nValue[1],4)
            cambpad.text_1.value:=busruta
            cambpad.text_2.value:=busfolio
            browpadcon.release
            cambpad.text_2.caretpos:=len(alltrim(busfolio))
            cambpad.text_2.setfocus
			else
				if flagbr = 3
               declare window cambiacom
               declare window browpadcon
					kLinea := browpadcon.grid_1.Value
					nValue := browpadcon.grid_1.item (kLinea)
					busruta := left(nValue[1],3)
					busfolio := right(nValue[1],4)
               cambiacom.text_1.value:=busruta
               cambiacom.text_2.value:=busfolio
               browpadcon.release
               cambiacom.text_2.caretpos:=len(alltrim(busfolio))
               cambiacom.text_2.setfocus
            else
               declare window consbon
               declare window browpadcon
					kLinea := browpadcon.grid_1.Value
					nValue := browpadcon.grid_1.item (kLinea)
					busruta := left(nValue[1],3)
					busfolio := right(nValue[1],4)
               consbon.text_1.value:=busruta
               consbon.text_2.value:=busfolio
               browpadcon.release
               consbon.text_2.caretpos:=len(alltrim(busfolio))
               consbon.text_2.setfocus
				endif
			endif
      endif
   endif
return


function ponvaltogetimp
   declare window edocta
   if edocta.tab_1.value= 1
      flagtimpomp:=1
   elseif edocta.tab_1.value= 2
      flagtimpomp:=2
   elseif edocta.tab_1.value= 3
      flagtimpomp:=3
   elseif edocta.tab_1.value= 4
      flagtimpomp:=4
   elseif edocta.tab_1.value= 5
      flagtimpomp:=5
   elseif edocta.tab_1.value= 6
      flagtimpomp:=6
   elseif edocta.tab_1.value= 7
      flagtimpomp:=7
   elseif edocta.tab_1.value= 8
      flagtimpomp:=8
   elseif edocta.tab_1.value= 9
      flagtimpomp:=9
   elseif edocta.tab_1.value= 10
      flagtimpomp:=10
   elseif edocta.tab_1.value= 11
      flagtimpomp:=11
   endif         
return


function escogetipoimp
   if flagtimpomp = 1
      impconsumo()
   elseif flagtimpomp = 2
      impripragos()
   elseif flagtimpomp = 3

   elseif flagtimpomp = 4
      MsgInfo('Listado de cortes','Mensaje del Sistema')      
   elseif flagtimpomp = 5
      impedolect()
   elseif flagtimpomp = 6
      imprimetar()
   elseif flagtimpomp = 7
      *MsgInfo('Listado de Pagares','Mensaje del Sistema')      
   elseif flagtimpomp = 8
      *MsgInfo('Listado de Medidores','Mensaje del Sistema')     
   elseif flagtimpomp = 9
      impconvenio()
   elseif flagtimpomp = 10
      imprimcamb()
   elseif flagtimpomp = 11

   endif
return


function impconsumo
   declare window edocta
   if empty(edocta.text_1.value) .and. empty(edocta.text_2.value)
      edocta.text_1.setfocus
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
      headconsumo(1)
      for n = 1 to edocta.Grid_1.ItemCount
         aTemp := edocta.Grid_1.Item(n)
         @ lin,7 print atemp[1] Font "Arial" size 7 bold	  
         @ lin,32 print atemp[2] Font "Arial" size 7 bold right
         @ lin,53 print atemp[3] Font "Arial" size 7 bold right
         @ lin,74 print atemp[4] Font "Arial" size 7 bold right
         @ lin,90 print atemp[5] Font "Arial" size 7 bold right
         @ lin,108 print atemp[6] Font "Arial" size 7 bold right
         @ lin,123 print atemp[7] Font "Arial" size 7 bold right
         @ lin,141 print atemp[8] Font "Arial" size 7 bold right
         @ lin,160 print atemp[9] Font "Arial" size 7 bold right
         @ lin,173 print atemp[10] Font "Arial" size 7 bold right
         @ lin,185 print atemp[11] Font "Arial" size 7 bold right
			@ lin,200 print atemp[12] Font "Arial" size 7 bold right
         @ lin,205 print atemp[13] Font "Arial" size 7 bold
         if aumento < 60
            aumento:=aumento+1	 
				lin:=lin+a
         else
            end printpage
				a:=4
 				lin:=20
				aumento:=0
            start printpage
            headconsumo(2)
         endif
      next
      if len(edocta.edit_1.value) > 0
         nLineas := MLCOUNT(edocta.edit_1.value)
         for nlact = 1 to nlineas
            if !empty(MEMOLINE(edocta.edit_1.value,120, nlact))
               @ lin,7  print MEMOLINE(edocta.edit_1.value,120, nlact) font 'Arial' size 8 
               if aumento < 60
                  aumento:=aumento + 1	 
						lin:=lin+a
               else
                  end printpage
                  a:=4
 						lin:=20
						aumento:=0
                  start printpage
                  headconsumo(2)
               endif
            endif
         next
      endif
      end printpage
      end printdoc
    endif
return

function headconsumo
   parameters galfhead
   declare window edocta
   aTemp := edocta.Grid_1.Item(1)
   p1:=aTemp[1]
   aTemp:=edocta.Grid_1.Item(edocta.Grid_1.ItemCount)
   p2:=aTemp[1]
   @ 10,05 print image "laredo.bmp" width 25 height 20
   @ 10,190 print image "comapa.bmp" width 15 height 20
   @ 10,107 print "COMISION MUNICIPAL DE AGUA POTABLE Y ALCANTARILLADO DEL MUNICIPIO DE NUEVO LAREDO" Font "Arial" size 9.5 BOLD CENTER
   @ 15,107 print 'Estado de cuenta del periodo :' + p1 + '  Al periodo :' + p2 Font "Arial" size 8 bold center
   if galfhead = 1
      @ lin,10 print 'Fecha :' + strzero(day(date()),2) + ' de ' + ames[month(date())] + ' del ' + alltrim(str(year(date()))) Font "Arial" size 8 bold
      @ lin,165 print 'Hora :' + time() Font "Arial" size 8 bold
      lin:=lin + a
      aumento:=aumento + 1
      @ lin,10 print 'Localizacion :' + edocta.text_1.value+'-'+edocta.text_2.value  Font "Arial" size 8 bold
      @ lin,90 print 'Lecturista :' + edocta.text_3.value  Font "Arial" size 8 bold
      @ lin,170 print 'Medidor :' + edocta.text_4.value  Font "Arial" size 8 bold
      lin:=lin + a
      aumento:=aumento + 1
      @ lin,10 print 'Nombre :' + edocta.text_5.value  Font "Arial" size 8 bold
      @ lin,90 print 'Toma :' + edocta.text_6.value  Font "Arial" size 8 bold
      @ lin,170 print 'Cuenta :' + edocta.text_22.value  Font "Arial" size 8 bold
      lin:=lin + a
      aumento:=aumento + 1
      @ lin,10  print 'Domicilio :' + edocta.text_8.value  Font "Arial" size 8 bold
      @ lin,90 print  'Usuario :' + alltrim(edocta.text_11.value) + ' :' + alltrim(edocta.text_18.value) Font "Arial" size 8 bold
      @ lin,170 print 'Minimo :' + transform(edocta.text_12.value,'9999999')  Font "Arial" size 8 bold
      lin:=lin + a
      aumento:=aumento + 1
      @ lin,10  print 'Contrato :' + edocta.text_9.value  Font "Arial" size 8 bold
      @ lin,50 print  'Tarifa :' + edocta.text_7.value  Font "Arial" size 8 bold
      @ lin,90 print 'Meses de rezago :' + transform(edocta.text_13.value,'9999999')  Font "Arial" size 8 bold
      @ lin,170 print 'Drenaje :' + edocta.text_10.value Font "Arial" size 8 bold
      lin:=lin + a
      aumento:=aumento + 1
   endif
   @ lin,7 print 'Periodo' Font "Arial" size 7 bold
   @ lin,21 print 'Recargos' Font "Arial" size 7 bold
   @ lin,44 print 'Rezago' Font "Arial" size 7 bold
   @ lin,64 print 'Mensual' Font "Arial" size 7 bold
   @ lin,84 print 'I.V.A.' Font "Arial" size 7 bold
   @ lin,100 print 'Total' Font "Arial" size 7 bold
   @ lin,110 print 'Acreditado' Font "Arial" size 7 bold
   @ lin,132 print 'Pagado' Font "Arial" size 7 bold
   @ lin,147 print 'Bonificado' Font "Arial" size 7 bold
   @ lin,164 print 'Lec Ant' Font "Arial" size 7 bold
   @ lin,176 print 'Lec Act' Font "Arial" size 7 bold
   @ lin,188 print 'Consumo' Font "Arial" size 7 bold
   @ lin,202 print 'Falla' Font "Arial" size 7 bold
   lin:=lin+a
   aumento:=aumento+1
   @ lin,1 print line to lin,250 penwidth .4
return

function impripragos
   declare window edocta
   if empty(edocta.text_1.value) .and. empty(edocta.text_2.value)
      edocta.text_1.setfocus
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
      lin:=24
      a:=4
      aumento:=0
      headpagos()
      for n=1 to edocta.Grid_2.ItemCount
         aTempp := edocta.Grid_2.Item(n)
         @ lin,47 print atempp[1] Font "Arial" size 7 bold right	  
         @ lin,106 print atempp[2] Font "Arial" size 7 bold right
         @ lin,150 print atempp[3] Font "Arial" size 7 bold right
         @ lin,199 print atempp[4] Font "Arial" size 7 bold right
         if aumento < 60
            aumento:=aumento + 1	 
				lin:=lin + a
         else
            end printpage
				a:=4
 				lin:=20
				aumento:=0
            start printpage
            headpagos()
         endif
      next
      end printpage
      end printdoc
    endif
return

function headpagos
   @ 10,05 print image "laredo.bmp" width 25 height 20
   @ 10,190 print image "comapa.bmp" width 15 height 20
   @ 14,107 print "COMISION MUNICIPAL DE AGUA POTABLE Y ALCANTARILLADO DEL MUNICIPIO DE NUEVO LAREDO" Font "Arial" size 9.5 BOLD CENTER
   @ 19,107 print 'Listado de Pagos y Bonificaciones' Font "Arial" size 8 bold center
   @ lin,10 print 'Fecha :' + strzero(day(date()),2) + ' de ' + ames[month(date())] + ' del ' + alltrim(str(year(date()))) Font "Arial" size 8 bold
   @ lin,165 print 'Hora :' + time() Font "Arial" size 8 bold
   lin:=lin + a
   aumento:=aumento + 1
   @ lin,10 print 'Localizacion :' + edocta.text_1.value + '-' + edocta.text_2.value  Font "Arial" size 8 bold
   @ lin,90 print 'Cuenta :' + edocta.text_22.value  Font "Arial" size 8 bold
   lin:=lin + a
   aumento:=aumento + 1
   @ lin,10 print 'Nombre :' + edocta.text_5.value  Font "Arial" size 8 bold
   @ lin,90 print 'Toma :' + edocta.text_6.value  Font "Arial" size 8 bold
   lin:=lin + a
   aumento:=aumento + 1
   @ lin,10  print 'Domicilio :' + edocta.text_8.value  Font "Arial" size 8 bold
   lin:=lin + a
   aumento:=aumento + 1
   @ lin,10  print 'Adeudo Actual $:'  Font "Arial" size 8 bold
   lin:=lin + a
   aumento:=aumento + 1
   @ lin,25  print 'Pagos Aplicados'  Font "Arial" size 8 bold
   @ lin,79  print 'Pagos No Aplicados'  Font "Arial" size 8 bold
   @ lin,115  print 'Bonificaciones Aplicadas'  Font "Arial" size 8 bold
   @ lin,160  print 'Bonificaciones No Aplicadas'  Font "Arial" size 8 bold
   lin:=lin + a
   aumento:=aumento + 1
   @ lin,1 print line to lin,250 penwidth .4
return

function iniciatarifa 
Local tot:=0, tot1:=0, tot2:=0, resag1:=0, recar1:=0, cantid1:=0, sanea1:=0, iva1:=0, recar2:=0
   musu:=strzero(edocta.combo_1.Value,2)
	mes1:='0'
	san1:=iif(edocta.radiogroup_1.value=1,1,0)
   med1:=iif(edocta.radiogroup_2.value=1,'M','2')
   mts:=edocta.text_24.value
   mes:=edocta.text_25.value
   if mts > 999999
      tmplim2 := 999999
   else               
      tmplim2 := mts
   endif     
	MsgBox(musu+"-"+med1+"-"+str(tmplim2),"1") //buscar en catalogo de usuarios el id es lo que regresa
				nQuery := "select * From Tarifas Where tipo_usu='" + musu + "' and Tarifa='" + med1 + "' and LIMITE1 <= ";
				+ str(tmplim2) + " and LIMITE2 >=" + str(tmplim2)
				lQuery := oServer:Query(nQuery)
		If lQuery:NetErr()												
			  MsgStop ( lQuery:Error() )
			  return Nil
		Endif
		MsgBox(lQuery:LastRec(),"recno")
	if lQuery:LastRec()>0
		For e=1 To lQuery:LastRec()
		
			oRow := lQuery:GetRow(e)
			tot:=0
			tot1:=0
			tot2:=0
			if oRow:FieldGet("limite1") = 0 .or. oRow:FieldGet("limite1") = 6
				mts:=1
			EndIf 
			resag1:=0
			recar1:=0
			cantid1:=0
			sanea1:=0
			iva1:=0
			tot1:=0
			MsgBox(mes,">1")
			if mes > 1
				if mes = 1
					resag1:=cantid + sanea
					recar1:=resag1 * .05
					iva1:=0
				EndIf 
				MsgBox(oRow:FieldGet("tipo_usu"),">1")
				if ( oRow:FieldGet("tipo_usu") = '07' .or. oRow:FieldGet("tipo_usu") = '08' ) .and. oRow:FieldGet("mts") > 20
					if oRow:FieldGet("tarifa") = 'M'
						cantid1:=round((oRow:FieldGet("imp_tarifa") * (mts-20)),2) + 62.26
					else
						cantid1:=round((oRow:FieldGet("imp_tarifa") * (mts-20)),2) + 62.26
					endif
				else
					cantid1:=round((oRow:FieldGet("imp_tarifa") * mts),2)
				endif
				if (oRow:FieldGet("tipo_usu") = '02' .or. oRow:FieldGet("tipo_usu") = '03' .or. oRow:FieldGet("tipo_usu") = '04')
					sanea1:=round((cantid1 * .50 * san1),2)
				else
					if oRow:FieldGet("tarifa") = '2'
						sanea1:=round((cantid1 * .50 * san1),2)
					else
						sanea1:=round((cantid1 * .50 * san1),2)
					endif
				endif
				if musu = '01' .or. musu = '05' .or. musu = '06' .or. musu = '07' .or. musu = '08' 
					iva1:=0
				else
					iva1:=iva1 + round(((cantid1 + sanea1) * .16),2)
				endif
				tot1:=cantid1 + sanea1 + iva1 + resag1 + recar1
				for g = 2 to mes
					resag1:=resag1 + cantid1 + sanea1
					recar1:=recar1 + round((resag1 * .05),2)        
					if ( oRow:FieldGet("tipo_usu") = '07' .or. oRow:FieldGet("tipo_usu") = '08' ) .and. mts > 20 
						if tarifa = 'M'
							cantid1:=round((oRow:FieldGet("imp_tarifa") * (mts - 20)),2) + 62.26
						else
							cantid1:=round((oRow:FieldGet("imp_tarifa") * (mts - 20)),2) + 62.26
						endif
					else
						cantid1:=round((oRow:FieldGet("imp_tarifa") * mts),2)
					endif
					if (oRow:FieldGet("tipo_usu") = '02' .or. oRow:FieldGet("tipo_usu") = '03' .or. oRow:FieldGet("tipo_usu") = '04')
						sanea1:=round((cantid1 * .50 * san1),2)
					else
						if oRow:FieldGet("tarifa") = '2'
							sanea1:=round((cantid1 * .50 * san1),2)
						else
							sanea1:=round((cantid1 * .50 * san1),2)
						endif
					endif
					if musu = '01' .or. musu = '05' .or. musu = '06' .or. musu = '07' .or. musu = '08' 
						iva1:=0
					else
						iva1:=iva1 + round(((cantid1 + sanea1) * .16),2)         
					endif
					tot1:=cantid1 + sanea1 + iva1 + resag1 + recar1
				next
			else
				if mes = 1
					if mes1 = '1'
						resag1:=cantid + sanea
						recar1:=resag1 * .05
						iva1:=0
					else
						cantid1:=0
						sanea1:=0
						iva1:=0
					EndIf 
					MsgBox(oRow:FieldGet("tipo_usu"),">1")
					if ( oRow:FieldGet("tipo_usu") = '07' .or. oRow:FieldGet("tipo_usu") = '08' ) .and. mts > 20 
						if oRow:FieldGet("tarifa") = 'M'
							cantid1:=round((oRow:FieldGet("imp_tarifa") * (mts - 20)),2) + 62.26
						else
							cantid1:=round((oRow:FieldGet("imp_tarifa") * (mts - 20)),2) + 62.26
						endif
					else
						cantid1:=round((oRow:FieldGet("imp_tarifa") * mts),2)
					endif
					if (oRow:FieldGet("tipo_usu") = '02' .or. oRow:FieldGet("tipo_usu") = '03' .or. oRow:FieldGet("tipo_usu") = '04')
						sanea1:=round((cantid1 * .50 * san1),2)
					else
						if oRow:FieldGet("tarifa") = '2'
							sanea1:=round((cantid1 * .50 * san1),2)
						else
							sanea1:=round((cantid1 * .50 * san1),2)
						endif
					endif
					if musu = '01' .or. musu = '05' .or. musu = '06' .or. musu = '07' .or. musu = '08' 
						iva1:=0
					else
						iva1:=iva1 + round(((cantid1 + sanea1) * .16),2)
					endif
					tot1:=cantid1 + sanea1 + iva1 + resag1 + recar1
					MsgBox(oRow:FieldGet("tarifa"),">1")
				else
					cantid1:=0
					sanea1:=0
					iva1:=0
					tot1:=0
					mantenim1:=0
				endif
			EndIf 
			lQuery:Skip(1)
		Next 
   else
      cantidad:=0
   endif
   cantid2:=0
   tot2 := tot + tot1
   recar2:=recar1
   resag2:=resag1
   ivarec:=recar2 * .16
   edocta.text_26.value:=resag1
   edocta.text_27.value:=recar1
   edocta.text_28.value:=cantid1
   edocta.text_29.value:=sanea1
   edocta.text_30.value:=iva1 + ivarec
   edocta.text_31.value:=tot1 + ivarec
return

Function llenamovpad  //AQUI ME QUEDE***************************************************************************************
		nQuery := "select * from Padrmov, Capturis where Ruta='" + EdoCta.text_1.Value + "' and folio='" + EdoCta.text_2.Value;
		+ "' and cve_captur=CAPTURISTA" 
		lQuery := oServer:Query(nQuery)
		If lQuery:NetErr()												
			  MsgStop ( lQuery:Error() )
			  return Nil
		Endif
	if lQuery:LastRec()>0
	e:=1
      For e=1 To lQuery:LastRec()
		oRow := lQuery:GetRow(e)
         if oRow:FieldGet("ruta") + oRow:FieldGet("folio") = edocta.text_1.value + edocta.text_2.Value 
            edocta.Grid_8.AddItem ( {oRow:FieldGet("campo"),oRow:FieldGet("descrip"),oRow:FieldGet("nom_captur"),iif(empty(oRow:FieldGet("fecha")),"  ",dtoc(oRow:FieldGet("fecha"))),oRow:FieldGet("hora")} )   
         endif
			//lQuery:Skip(1)
		Next   
   endif
   lQuery:Destroy()
	edocta.Grid_8.refresh
return

function ponencerocta
   edocta.text_3.value:=space(60)
   edocta.text_4.value:=space(20)
   edocta.text_5.value:=space(60)
   edocta.text_6.value:=space(20)
   edocta.text_7.value:=space(20)
   edocta.text_8.value:=space(60)
   edocta.text_9.value:=space(7)
   edocta.text_10.value:=space(10)
   edocta.text_11.value:=space(20)
   edocta.text_12.value:=0
   edocta.text_13.value:=0
   edocta.text_14.value:=space(20)
   edocta.text_15.value:=space(20)
   edocta.text_16.value:=0
   edocta.text_17.value:=0
   edocta.text_19.value:=space(20)
   edocta.text_20.value:=0
   edocta.text_21.value:=0
   edocta.text_22.value:=space(7)
   edocta.text_23.value:=space(7)
   edocta.combo_1.value:=0
   edocta.combo_2.value:=0
   edocta.radiogroup_1.value:=1
   edocta.radiogroup_2.value:=1
   edocta.text_24.value:=0
   edocta.text_25.value:=0
   edocta.text_26.value:=0
   edocta.text_27.value:=0
   edocta.text_28.value:=0
   edocta.text_29.value:=0
   edocta.text_30.value:=0
   edocta.text_31.value:=0
   edocta.text_23.value:=space(7)
   edocta.text_32.value:=ctod("  /  /    ")
   edocta.text_33.value:=ctod("  /  /    ")
   edocta.text_34.value:=0
   edocta.text_37.value:=space(60)
   edocta.combo_1.value:=0
   edocta.combo_2.value:=0
   edocta.combo_3.value:=0
   edocta.text_35.value:=0
   edocta.text_36.value:=0
   edocta.text_38.value:=space(20)
   edocta.text_39.value:=ctod("  /  /    ")
   edocta.text_40.value:=0
   edocta.text_41.value:=0
   edocta.text_42.value:=0
   edocta.text_43.value:=space(7)
   edocta.text_44.value:=ctod("  /  /    ")
   edocta.text_45.value:=0
   edocta.text_46.value:=0
   edocta.text_47.value:=0
   edocta.text_48.value:=0
return

function impedolect
   declare window edocta
   if empty(edocta.text_1.value) .and. empty(edocta.text_2.value)
      edocta.text_1.setfocus
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
      lin:=24
      a:=4
      aumento:=0
      headlectur(1,1)
      for n=1 to edocta.Grid_4.ItemCount
         aTemp:= edocta.Grid_4.Item(n)
         @ lin,7 print atemp[1] Font "Arial" size 7 bold	  
         @ lin,40 print atemp[2] Font "Arial" size 7 bold right
         @ lin,70 print atemp[3] Font "Arial" size 7 bold right
			@ lin,100 print atemp[4] Font "Arial" size 7 bold right
         @ lin,130 print atemp[5] Font "Arial" size 7 bold
         if aumento < 60
            aumento:=aumento + 1	 
				lin:=lin + a
         else
            end printpage
				a:=4
 				lin:=20
				aumento:=0
            start printpage
            headlectur(1,2)
         endif
      next
      end printpage
      end printdoc
   endif
return

function imprimetar
   if empty(edocta.text_1.value) .and. empty(edocta.text_2.value)
      edocta.text_1.setfocus
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
      lin:=30
      a:=6
      @ 10,05 print image "laredo.bmp" width 25 height 20
      @ 10,190 print image "comapa.bmp" width 15 height 20
      @ 10,107 print "COMISION MUNICIPAL DE AGUA POTABLE Y ALCANTARILLADO DEL MUNICIPIO DE NUEVO LAREDO" Font "Arial" size 9.5 BOLD CENTER
      lin:=lin + a
      aumento:=aumento + 1
      @ lin,10 print 'Localizacion :' + edocta.text_1.value+'-'+edocta.text_2.value  Font "Arial" size 8 bold
      @ lin,90 print 'Fecha :' + dtoc(edocta.datepicker_1.value) Font "Arial" size 8 bold
      lin:=lin + a
      aumento:=aumento + 1
      @ lin,10 print  'Tipo de Usuario :' + alltrim(edocta.text_11.value) Font "Arial" size 8 bold
      @ lin,80 print 'Rezago'  Font "Arial" size 8 bold 
      @ lin,130 print  transform(edocta.text_26.value,'999,999,999.99') Font "Arial" size 8 bold right
      lin:=lin + a
      aumento:=aumento + 1
      @ lin,10 print 'Drenaje :' + iif(edocta.radiogroup_1.value = 1,'Si','No') Font "Arial" size 8 bold
      @ lin,80 print 'Recargos' Font "Arial" size 8 bold 
      @ lin,130 print transform(edocta.text_27.value,'999,999,999.99') Font "Arial" size 8 bold right
      lin:=lin + a
      aumento:=aumento + 1
      @ lin,10 print 'Medido :' + iif(edocta.radiogroup_1.value = 2,'Si','No') Font "Arial" size 8 bold
      @ lin,80 print 'Consumo' Font "Arial" size 8 bold
      @ lin,130 print transform(edocta.text_28.value,'999,999,999.99') Font "Arial" size 8 bold right
      lin:=lin + a
      aumento:=aumento + 1
      @ lin,10 print 'Mts 3 a Cobrar :' + transform(edocta.text_24.value,'9999999')  Font "Arial" size 8 bold
      @ lin,80 print 'Saneamiento'  Font "Arial" size 8 bold 
      @ lin,130 print transform(edocta.text_29.value,'999,999,999.99') Font "Arial" size 8 bold right
      lin:=lin + a
      @ lin,10 print 'Meses Totales :' + transform(edocta.text_25.value,'9999999')  Font "Arial" size 8 bold
      @ lin,80 print 'I.V.A.' Font "Arial" size 8 bold 
      @ lin,130 print transform(edocta.text_30.value,'999,999,999.99') Font "Arial" size 8 bold right
      lin:=lin + a
      aumento:=aumento + 1
      @ lin,100 print  '________________________' Font "Arial" size 8 bold 
      lin:=lin + a
      aumento:=aumento + 1
      @ lin,80 print 'Total' Font "Arial" size 8 bold
      @ lin,130 print transform(edocta.text_31.value,'999,999,999.99') Font "Arial" size 8 bold right
      end printpage
      end printdoc
   endif
return


function imprimcamb
   if empty(edocta.text_1.value) .and. empty(edocta.text_2.value)
      edocta.text_1.setfocus
      return
   endif
   SELECT PRINTER DEFAULT ;
   ORIENTATION PRINTER_ORIENT_PORTRAIT;
   PAPERSIZE PRINTER_PAPER_LETTER;
   QUALITY PRINTER_RES_MEDIUM 
   SELECT PRINTER DIALOG TO lSuccess PREVIEW
   If lSuccess == .T.
      lin:=24
      a:=4
      aumento:=0
      start printdoc
      start printpage
      headlectur(2,1)
      for n=1 to edocta.Grid_8.ItemCount
         aTemp:= edocta.Grid_8.Item(n)
         @ lin,7 print atemp[1] Font "Arial" size 7 bold	  
         @ lin,40 print atemp[2] Font "Arial" size 7 bold
         @ lin,100 print atemp[3] Font "Arial" size 7 bold
			@ lin,160 print atemp[4] Font "Arial" size 7 bold
         @ lin,190 print atemp[5] Font "Arial" size 7 bold
         if aumento < 60
            aumento:=aumento + 1	 
				lin:=lin + a
         else
            end printpage
				a:=4
 				lin:=20
				aumento:=0
            start printpage
            headlectur(2,2)
         endif
      next
      end printpage
      end printdoc
   endif
return


function headlectur
   parameters opflagk,opflagpag
   aTemp := edocta.Grid_4.Item(1)
   p1:=atemp[1]
   aTemp := edocta.Grid_4.Item(edocta.Grid_4.ItemCount)
   p2:=atemp[1]
   if opflagpag = 1
      @ 10,05 print image "laredo.bmp" width 25 height 20
      @ 10,190 print image "comapa.bmp" width 15 height 20
      @ 10,107 print "COMISION MUNICIPAL DE AGUA POTABLE Y ALCANTARILLADO DEL MUNICIPIO DE NUEVO LAREDO" Font "Arial" size 9.5 BOLD CENTER
      if opflagk = 1 
         @ 15,107 print 'Lecturas del periodo :' + p1 + '  Al periodo :' + p2 Font "Arial" size 8 bold center
      else
         @ 15,107 print 'Cambios al Padron' Font "Arial" size 8 bold center
      endif
      @ lin,10 print 'Fecha :' + strzero(day(date()),2) + ' de ' + ames[month(date())] + ' del ' + alltrim(str(year(date()))) Font "Arial" size 8 bold
      @ lin,165 print 'Hora :' + time() Font "Arial" size 8 bold
      lin:=lin + a
      aumento:=aumento + 1
      @ lin,10 print 'Localizacion :' + edocta.text_1.value + '-' + edocta.text_2.value  Font "Arial" size 8 bold
      @ lin,90 print 'Lecturista :' + edocta.text_3.value  Font "Arial" size 8 bold
      @ lin,170 print 'Medidor :' + edocta.text_4.value  Font "Arial" size 8 bold
      lin:=lin + a
      aumento:=aumento + 1
      @ lin,10 print 'Nombre :' + edocta.text_5.value  Font "Arial" size 8 bold
      @ lin,90 print 'Toma :' + edocta.text_6.value  Font "Arial" size 8 bold
      @ lin,170 print 'Cuenta :' + edocta.text_22.value  Font "Arial" size 8 bold
      lin:=lin + a
      aumento:=aumento + 1
      @ lin,10  print 'Domicilio :' + edocta.text_8.value  Font "Arial" size 8 bold
      @ lin,90 print  'Usuario :' + alltrim(edocta.text_11.value) + ' :' + alltrim(edocta.text_18.value) Font "Arial" size 8 bold
      @ lin,170 print 'Minimo :' + transform(edocta.text_12.value,'9999999')  Font "Arial" size 8 bold
      lin:=lin + a
      aumento:=aumento + 1
      @ lin,10  print 'Contrato :' + edocta.text_9.value  Font "Arial" size 8 bold
      @ lin,50 print  'Tarifa :' + edocta.text_7.value  Font "Arial" size 8 bold
      @ lin,90 print 'Meses de rezago :' + transform(edocta.text_13.value,'9999999')  Font "Arial" size 8 bold
      @ lin,170 print 'Drenaje :' + edocta.text_10.value Font "Arial" size 8 bold
   endif
   lin:=lin + a
   aumento:=aumento + 1
   if opflagk = 1
      @ lin,7 print 'Periodo' Font "Arial" size 7 bold
      @ lin,30 print 'Lec Ant' Font "Arial" size 7 bold
      @ lin,60 print 'Lec Act' Font "Arial" size 7 bold
      @ lin,90 print 'Consumo' Font "Arial" size 7 bold
      @ lin,120 print 'Falla' Font "Arial" size 7 bold
   elseif opflagk = 2
      @ lin,7 print 'Cambio' Font "Arial" size 7 bold
      @ lin,40 print 'Movimiento' Font "Arial" size 7 bold
      @ lin,100 print 'Capturista' Font "Arial" size 7 bold
      @ lin,160 print 'Fecha' Font "Arial" size 7 bold
      @ lin,190 print 'Hora' Font "Arial" size 7 bold
   endif
   lin:=lin+a
   aumento:=aumento+1
   @ lin,1 print line to lin,250 penwidth .4
return


function nuevomedcons
/*   declare window edocta
   flagop:=1
   IF !IsWindowDefined(altamedi) 
       Load Window altamedi
       Center Window altamedi
       altamedi.text_1.value:=edocta.text_1.value
       altamedi.text_2.value:=edocta.text_2.value
       altamedi.button_1.enabled:=.f.
       altamedi.combo_1.enabled:=.f.
       altamedi.combo_2.enabled:=.f.
       Activate Window altamedi
   endIf*/
return

function imprime_dupcta
   SELECT PRINTER DEFAULT ;
   ORIENTATION PRINTER_ORIENT_PORTRAIT;
   PAPERSIZE PRINTER_PAPER_LETTER;
   QUALITY PRINTER_RES_MEDIUM
   *SELECT PRINTER DIALOG TO lSuccess PREVIEW
   for t=1 to 2
      l:=12
      n:=3
      start printdoc
      start printpage
      @ 1,1 print image "laredo.jpg" width 10 height 13
      @ 1,60 print image "comapa1.jpg" width 8 height 11
      @ 5,15 print 'COMAPA DE NUEVO LAREDO' font 'Arial' size 8
      @ 8,25 print 'DUPLICADO' font 'Arial' size 8

      @ l,6 print 'Cuenta:' font 'Arial' size 8
      @ l,20 print edocta.text_22.value font 'Arial' size 9 bold
      l:=l + n
      @ l,6 print 'Localización:' font 'Arial' size 8
      @ l,25 print edocta.text_1.value + '-' + edocta.text_2.value font 'Arial' size 9 bold
      l:=l + n
      @ l,6 print 'Nombre:' font 'Arial' size 8
      @ l,18 print edocta.text_5.value font 'Arial' size 8
      l:=l + n
      @ l,6 print 'Domicilio:' font 'Arial' size 8
      @ l,19 print edocta.text_8.value font 'Arial' size 8
      l:=l + n
      @ l,6 print 'Contrato:' font 'Arial' size 8
      @ l,20 print edocta.text_9.value font 'Arial' size 8
      l:=l + n
      @ l,6 print 'Tipo de usuario:' font 'Arial' size 8
      @ l,30 print edocta.text_11.value font 'Arial' size 8
      l:=l + n
      @ l,6 print 'Tarifa:' font 'Arial' size 8
      @ l,20 print edocta.text_7.value font 'Arial' size 8
      l:=l + n
      meses:=edocta.text_13.value
      //select fact_ant
      //seek edocta.text_1.value + edocta.text_2.value
      @ l,6 print 'No. Boleta:' font 'Arial' size 8
      @ l,22 print transform(faanumboleta,'999999999') font 'Arial' size 8
      l:=l + n
      /*select rutas
      seek edocta.text_1.value
      if cve_venc = '1'
         vencimi:='5'
      elseif cve_venc = '2'
         vencimi:='10'
      elseif cve_venc = '3'
         vencimi:='15'
      elseif cve_venc = '4'
         vencimi:='20'
      elseif cve_venc = '5'
         vencimi:='25'
      elseif cve_venc = '6'
         vencimi:='30'
      endif	*/	
      vencimi:=tmvdes_venc + ' ' + ames[val(right(faaperiodo,2))] + ' ' + left(faaperiodo,4)
		//MsgBox(str(faarecargo),"")
		aguaydrenaje := faaAd_total + faadescuento - (msaldocon - msalrec - msaliva) - faarecargo - msaliva
      @ l,6 print 'Meses de Rezago:' font 'Arial' size 8
      @ l,35 print transform(meses,'999') font 'Arial' size 8
      l:=l + n
      suma:= 0
      @ l,6 print '01' font 'Arial' size 8
      @ l,10 print 'Agua y Drenaje' font 'Arial' size 8
      @ l,55 print transform(aguaydrenaje,'9,999,999.99') font 'Arial' size 8 right
      l:=l + n
      @ l,6 print '01' font 'Arial' size 8 
      @ l,10 print 'Recargos' font 'Arial' size 8
      @ l,55 print transform(faarecargo - msalrec,'9,999,999.99') font 'Arial' size 8 right
      l:=l + n
      if mnumvonv <> 0
         @ l,6 print '01' font 'Arial' size 8
         @ l,10 print 'C' font 'Arial' size 8
         @ l ,11 print ' -'+ strzero(mnumvonv,6) + " (" + transform(msaldocon,'999,999.99') + ")"  font 'Arial' size 8
         @ l,55 print transform(mpagocon,'9,999,999.99') font 'Arial' size 8 right
         l:=l + n
      endif
      if mnumpagare <> spac(06)
         @ l,6 print '40' font 'Arial' size 8
         @ l,10 print 'P' font 'Arial' size 8
         @ l ,11 print ' -'+ mnumpagare + " (" + transform(mtotpagare + varpagum - pags,'999,999.99') + ")"  font 'Arial' size 7
         @ l,55 print transform(mabodoc,'9,999,999.99') font 'Arial' size 8 right
         l:=l + n
      endif
      @ l,6 print '41' font 'Arial' size 8
      @ l,10 print 'Medidor' font 'Arial' size 8
      @ l,55 print transform(mabomedup,'9,999,999.99') font 'Arial' size 8 right
      l:=l + n
      @ l,10 print 'Subsidio' font 'Arial' size 8
      @ l,55 print transform(msubsidio,'9,999,999.99') font 'Arial' size 8 right
      l:=l + n
      @ l, 6 print 'Pagos y bonif. Pendientes' font 'Arial' size 8
      @ l,55 print transform(mpagosnop + mbonisnop,'9,999,999.99') font 'Arial' size 8 right
		if faadescuento > 0
         l:=l + n
         @ l, 6 print '- 5% Descuento' font 'Arial' size 8
         @ l,55 print transform(faadescuento,'9,999,999.99') font 'Arial' size 8 right
		endif
      msuma:= (faaad_total - msaldocon) + mpagocon + mabodoc + mabomedup - mpagosnop - mbonisnop - msubsidio
      l:=l + n
      @ l,10 print 'T o t a l' font 'Arial' size 8 bold
      @ l,55 print transform(msuma,'9,999,999.99') font 'Arial' size 12 bold right
      l:=l + (n *3)
      decimal = msuma * 100
      if t = 1
         @ l ,6 print '*' + '9' + tmtcuenta + strzero(int(decimal),10) + '*' font 'Bar Code 39 f HR' size 14
      endif
      l:=l + (n*3)
      if right(faaperiodo,2) = '02' .and. mven = '6'
         vencimi:='28'
         vencimi:=vencimi + ' FEBRERO ' + left(faaperiodo,4)
         @ l ,6 print 'Vencimiento: ' + vencimi font 'Arial' size 9
      else
         @ l ,6 print 'Vencimiento: ' + vencimi font 'Arial' size 9
      endif
      l:=l + n
      @ l,6 print '.'
      end printpage
      end printdoc
   next
return

function Impconvenio
   declare window edocta
   if empty(edocta.text_1.value) .and. empty(edocta.text_2.value)
      edocta.text_1.setfocus
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
      lin:=30
      a:=4
      aumento:=0
      @ 10,05 print image "laredo.bmp" width 25 height 20
      @ 10,190 print image "comapa.bmp" width 15 height 20
      @ 10,107 print "COMISION MUNICIPAL DE AGUA POTABLE Y ALCANTARILLADO DEL MUNICIPIO DE NUEVO LAREDO" Font "Arial" size 9.5 BOLD CENTER
      @ 15,107 print 'Estado del Convenio' Font "Arial" size 8 bold center
      @ lin,10 print 'Fecha :' + strzero(day(date()),2) + ' de ' + ames[month(date())] + ' del ' + alltrim(str(year(date()))) Font "Arial" size 8 bold
      @ lin,165 print 'Hora :' + time() Font "Arial" size 8 bold
      lin:=lin + a
      aumento:=aumento + 1
      @ lin,10 print 'Localizacion :' + edocta.text_1.value + '-' + edocta.text_2.value  Font "Arial" size 8 bold
      @ lin,90 print 'Lecturista :' + edocta.text_3.value  Font "Arial" size 8 bold
      @ lin,170 print 'Medidor :' + edocta.text_4.value  Font "Arial" size 8 bold
      lin:=lin + a
      aumento:=aumento + 1
      @ lin,10 print 'Nombre :' + edocta.text_5.value  Font "Arial" size 8 bold
      @ lin,90 print 'Toma :' + edocta.text_6.value  Font "Arial" size 8 bold
      @ lin,170 print 'Cuenta :' + edocta.text_22.value  Font "Arial" size 8 bold
      lin:=lin + a
      aumento:=aumento + 1
      @ lin,10  print 'Domicilio :' + edocta.text_8.value  Font "Arial" size 8 bold
      @ lin,90 print  'Usuario :' + alltrim(edocta.text_11.value) + ' :' + alltrim(edocta.text_18.value) Font "Arial" size 8 bold
      @ lin,170 print 'Minimo :' + transform(edocta.text_12.value,'9999999')  Font "Arial" size 8 bold
      lin:=lin + a
      aumento:=aumento + 1
      @ lin,10  print 'Contrato :' + edocta.text_9.value  Font "Arial" size 8 bold
      @ lin,50 print  'Tarifa :' + edocta.text_7.value  Font "Arial" size 8 bold
      @ lin,90 print 'Meses de rezago :' + transform(edocta.text_13.value,'9999999')  Font "Arial" size 8 bold
      @ lin,170 print 'Drenaje :' + edocta.text_10.value Font "Arial" size 8 bold
      lin:=lin + a
      aumento:=aumento + 1
      @ lin,10 print '# Convenio :' + edocta.text_43.value Font "Arial" size 8 bold
      @ lin,90 print 'Fecha del Convenio :' + dtoc(edocta.text_44.value)  Font "Arial" size 8 bold
      lin:=lin + a
      aumento:=aumento + 1
      @ lin,10 print 'Valor    :' + transform(edocta.text_45.value,'999,999,999.99')  Font "Arial" size 8 bold
      lin:=lin + a
      aumento:=aumento + 1
      @ lin,10 print 'Abonos :' + transform(edocta.text_46.value,'999,999,999.99')  Font "Arial" size 8 bold
      lin:=lin + a
      aumento:=aumento + 1
      @ lin,10 print 'Saldo    :' + transform(edocta.text_47.value,'999,999,999.99')  Font "Arial" size 8 bold
      lin:=lin + a
      lin:=lin + a
      aumento:=aumento + 1
      @ lin,10 print 'Fecha :'  Font "Arial" size 8 bold
      @ lin,30 print 'Abonos :'  Font "Arial" size 8 bold
      lin:=lin + a
      aumento:=aumento + 1
      for n=1 to edocta.Grid_7.ItemCount
         aTemp:= edocta.Grid_7.Item(n)
			if atemp[1] <> '  /  /    '
            @ lin,10 print atemp[1] Font "Arial" size 7 bold	  
            @ lin,30 print atemp[2] Font "Arial" size 7 bold
            lin:=lin + a
            aumento:=aumento + 1
         endif
      next
      end printpage
      end printdoc
   endif
return


function preview_dupcta
   SELECT PRINTER DEFAULT ;
   ORIENTATION PRINTER_ORIENT_PORTRAIT;
   PAPERSIZE PRINTER_PAPER_LETTER;
   QUALITY PRINTER_RES_MEDIUM PREVIEW
   //SELECT PRINTER DIALOG TO lSuccess 
   for t=1 to 1
      l:=12
      n:=3
      start printdoc
      start printpage
      @ 1,1 print image "laredo.jpg" width 10 height 13
      @ 1,60 print image "comapa1.jpg" width 8 height 11
      @ 5,15 print 'COMAPA DE NUEVO LAREDO' font 'Arial' size 8
      @ 8,25 print 'DUPLICADO' font 'Arial' size 8

      @ l,6 print 'Cuenta:' font 'Arial' size 8
      @ l,20 print edocta.text_22.value font 'Arial' size 9 bold
      l:=l + n
      @ l,6 print 'Localización:' font 'Arial' size 8
      @ l,25 print edocta.text_1.value + '-' + edocta.text_2.value font 'Arial' size 9 bold
      l:=l + n
      @ l,6 print 'Nombre:' font 'Arial' size 8
      @ l,18 print edocta.text_5.value font 'Arial' size 8
      l:=l + n
      @ l,6 print 'Domicilio:' font 'Arial' size 8
      @ l,19 print edocta.text_8.value font 'Arial' size 8
      l:=l + n
      @ l,6 print 'Contrato:' font 'Arial' size 8
      @ l,20 print edocta.text_9.value font 'Arial' size 8
      l:=l + n
      @ l,6 print 'Tipo de usuario:' font 'Arial' size 8
      @ l,30 print edocta.text_11.value font 'Arial' size 8
      l:=l + n
      @ l,6 print 'Tarifa:' font 'Arial' size 8
      @ l,20 print edocta.text_7.value font 'Arial' size 8
      l:=l + n
      meses:=edocta.text_13.value
      //select fact_ant
      //seek edocta.text_1.value + edocta.text_2.value
      @ l,6 print 'No. Boleta:' font 'Arial' size 8
      @ l,22 print transform(faanumboleta,'999999999') font 'Arial' size 8
      l:=l + n
      /*select rutas
      seek edocta.text_1.value
      if cve_venc = '1'
         vencimi:='5'
      elseif cve_venc = '2'
         vencimi:='10'
      elseif cve_venc = '3'
         vencimi:='15'
      elseif cve_venc = '4'
         vencimi:='20'
      elseif cve_venc = '5'
         vencimi:='25'
      elseif cve_venc = '6'
         vencimi:='30'
      endif	*/	
      vencimi:=tmvdes_venc + ' ' + ames[val(right(faaperiodo,2))] + ' ' + left(faaperiodo,4)
		//MsgBox(str(faarecargo),"")
		aguaydrenaje := faaAd_total + faadescuento - (msaldocon - msalrec - msaliva) - faarecargo - msaliva
      @ l,6 print 'Meses de Rezago:' font 'Arial' size 8
      @ l,35 print transform(meses,'999') font 'Arial' size 8
      l:=l + n
      suma:= 0
      @ l,6 print '01' font 'Arial' size 8
      @ l,10 print 'Agua y Drenaje' font 'Arial' size 8
      @ l,55 print transform(aguaydrenaje,'9,999,999.99') font 'Arial' size 8 right
      l:=l + n
      @ l,6 print '01' font 'Arial' size 8 
      @ l,10 print 'Recargos' font 'Arial' size 8
      @ l,55 print transform(faarecargo - msalrec,'9,999,999.99') font 'Arial' size 8 right
      l:=l + n
      if mnumvonv <> 0
         @ l,6 print '01' font 'Arial' size 8
         @ l,10 print 'C' font 'Arial' size 8
         @ l ,11 print ' -'+ strzero(mnumvonv,6) + " (" + transform(msaldocon,'999,999.99') + ")"  font 'Arial' size 8
         @ l,55 print transform(mpagocon,'9,999,999.99') font 'Arial' size 8 right
         l:=l + n
      endif
      if mnumpagare <> spac(06)
         @ l,6 print '40' font 'Arial' size 8
         @ l,10 print 'P' font 'Arial' size 8
         @ l ,11 print ' -'+ mnumpagare + " (" + transform(mtotpagare + varpagum - pags,'999,999.99') + ")"  font 'Arial' size 7
         @ l,55 print transform(mabodoc,'9,999,999.99') font 'Arial' size 8 right
         l:=l + n
      endif
      @ l,6 print '41' font 'Arial' size 8
      @ l,10 print 'Medidor' font 'Arial' size 8
      @ l,55 print transform(mabomedup,'9,999,999.99') font 'Arial' size 8 right
      l:=l + n
      @ l,10 print 'Subsidio' font 'Arial' size 8
      @ l,55 print transform(msubsidio,'9,999,999.99') font 'Arial' size 8 right
      l:=l + n
      @ l, 6 print 'Pagos y bonif. Pendientes' font 'Arial' size 8
      @ l,55 print transform(mpagosnop + mbonisnop,'9,999,999.99') font 'Arial' size 8 right
		if faadescuento > 0
         l:=l + n
         @ l, 6 print '- 5% Descuento' font 'Arial' size 8
         @ l,55 print transform(faadescuento,'9,999,999.99') font 'Arial' size 8 right
		endif
      msuma:= (faaad_total - msaldocon) + mpagocon + mabodoc + mabomedup - mpagosnop - mbonisnop - msubsidio
      l:=l + n
      @ l,10 print 'T o t a l' font 'Arial' size 8 bold
      @ l,55 print transform(msuma,'9,999,999.99') font 'Arial' size 12 bold right
      l:=l + (n *3)
      decimal = msuma * 100
      if t = 1
         @ l ,6 print '*' + '9' + tmtcuenta + strzero(int(decimal),10) + '*' font 'Bar Code 39 f HR' size 14
      endif
      l:=l + (n*3)
      if right(faaperiodo,2) = '02' .and. mven = '6'
         vencimi:='28'
         vencimi:=vencimi + ' FEBRERO ' + left(faaperiodo,4)
         @ l ,6 print 'Vencimiento: ' + vencimi font 'Arial' size 9
      else
         @ l ,6 print 'Vencimiento: ' + vencimi font 'Arial' size 9
      endif
      l:=l + n
      @ l,6 print '.'
      end printpage
      end printdoc
   next
return