#include <hmg.ch>
#define REPORTPAGE 9 

function contratosop
   public flagopcon:=1
   mpermisos:=' '
   IF !IsWindowDefined(contrato) 
       Load Window contrato
       Center Window contrato
		 Activate Window contrato
   endIf
return

Function caumenta()
	contrato.button_1.enabled:=.f.
	contrato.button_2.enabled:=.f.
	contrato.grid_1.enabled:=.f.
	//If inicont = .t.
	//	cahora := chojas
	//	inicont:= .f.
	//	cargacontratos()
	//Else 
		cahora++
		cargacontratos()
	//EndIf 
Return Nil

Function cdisminuye()
cahora--
contrato.button_1.enabled:=.f.
contrato.button_2.enabled:=.f.
contrato.grid_1.enabled:=.F.
cargacontratos()
Return Nil

Function cargacontratos()
Declare Window contrato
cQuery := "select contrato From Contrato Order By contrato"
bQuery := oServer:Query (cQuery)
	If bQuery:NetErr()
		Msgstop(bQuery:Error())
		Return Nil
	EndIf 
chojas:= round(bQuery:LastRec()/1000,0)
bQuery:Destroy()

cQuery := "select contrato, fecha, nombre, Domicilio From Contrato Order By contrato desc limit " + Str(cahora*1000) + ",1000"
	bQuery := oServer:Query (cQuery)
	If bQuery:NetErr()
		Msgstop(bQuery:Error())
		Return Nil
	EndIf 
	contrato.grid_1.DeleteAllItems()
//Chojas:= round(bQuery:LastRec()/3000,0)
contrato.label_1.Value := "Hoja"+str(Cahora)+" / "+str(Chojas)
		//cfilafin:=cahora*3000
		//cfilaini:=cfilafin-3000
 contratoar:={}
 x:=1
//If primer= 1
	For i := 1 To bQuery:LastRec() // cfilaini To cfilafin //
		If cn=500
			doevents()
			cn:=0
		EndIf 
		cn++
		oRow := bQuery:GetRow(i)
		If oRow:FieldGet("contrato") > 0
			contrato.grid_1.AddItem({transform(oRow:FieldGet("contrato"),'999999'),dtoc(oRow:FieldGet("fecha")),alltrim(oRow:FieldGet("nombre")),;
				alltrim(oRow:FieldGet("Domicilio"))})
			//aadd(contratoar,{x,oRow:FieldGet("contrato")})
			x++
		EndIf 
			
	Next

//	muestrainf(1)
//	ahora:=1
bQuery:Destroy()
contrato.button_1.enabled:=.t.
contrato.button_2.enabled:=.t.
contrato.grid_1.enabled:=.t.
//MsgBox(str(ahora),"")
//Padron.Grid_1.Refresh
Return Nil

function altacontrato
   parameters flagopcon
	declare Window contrato
   IF !IsWindowDefined(altacont) 
       Load Window altacont
		if flagopcon = 2
		//MsgBox(contrato.Grid_1.Value,"5")
	   	If contrato.Grid_1.Value = 0
				cValue := contrato.grid_1.item(1)
			Else
				cLinea := contrato.Grid_1.Value 
				cValue := contrato.Grid_1.Item (cLinea)
			EndIf
			pondatoscont()
		endif
       Center Window altacont
       Activate Window altacont
   endIf
return

function  buscusucont
 /*  select capturis
   seek altacont.text_29.value
   if found()
      if capturis->estatus='A'
         if capturis->clave = 'C' .or. capturis->clave ='S'
            mpermisos:=capturis->nivel
            altacont.text_30.value:=capturis->nom_captur
         endif 
      else
         MsgInfo('El capturista esta dado de baja','Mensaje del Sistema')
         altacont.text_29.value:=space(3)
         altacont.text_29.setfocus
	 return
      endif
   else
      MsgInfo('El capturista no existe','Mensaje del Sistema')
      altacont.text_29.value:=space(3)
      altacont.text_29.setfocus
      return
   endif*/
   //altacont.tab_1.enabled:=.t.
return

Function mensage()
	declare Window contrato
	cValue := contrato.Grid_1.Item (contrato.grid_1.value)
	dato := cValue[1]
	//msgbox(dato,n)
	altacontrato(2)
Return Nil

function pondatoscont
  declare window altacont
	cQuery := "select * From Contrato where contrato=" + cValue[1]
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
   //if flagop = 2
      altacont.text_1.value:=oRow:FieldGet("contrato")
      altacont.text_2.value:=val(oRow:FieldGet("orden_agua")) //val(contrato->)
      altacont.text_3.value:=val(oRow:FieldGet("orden_dren"))
      altacont.datepicker_1.value:=oRow:FieldGet("fecha") //contrato->
		n:=1
		//MsgBox(oRow:FieldGet("tipo_con"),"")
		For n=1 To len(CatTco)
			If CatTco[n,1] = oRow:FieldGet("tipo_con")
				altacont.combo_1.Value := n
				exit
			EndIf 
		Next
      //altacont.combo_1.value:=tipo_con->(recno())
      altacont.text_5.value:=oRow:FieldGet("predio") //contrato->
      altacont.text_6.value:=oRow:FieldGet("nombre") //contrato->
      altacont.text_7.value:=oRow:FieldGet("domicilio")//contrato->
      altacont.text_8.value:=val(oRow:FieldGet("colonia")) //contrato->
      n:=1
		//MsgBox(oRow:FieldGet("tipo_con"),"")
		If !empty(altacont.text_8.Value)
			For n=1 To len(CatCol)
				If CatCol[n,1] = altacont.text_8.value
					altacont.text_9.Value := CatCol[n,2]
					exit
				EndIf 
			Next
		Else
			altacont.text_9.Value := "Sin Colonia"
		EndIf 
		//altacont.text_9.value:=colonias->des_col
      altacont.text_10.value:=oRow:FieldGet("telefono") //contrato->
		n:=1
		//MsgBox(oRow:FieldGet("tipo_con"),"")
		For n=1 To len(CatUsu)
			If CatUsu[n,3] = oRow:FieldGet("tipo_usu")
				altacont.Combo_2.Value := n
				exit
			EndIf 
		Next
		n:=1
		//MsgBox(oRow:FieldGet("tipo_con"),"")
		For n=1 To len(CatDia)
			If CatDia[n,12] = oRow:FieldGet("cve_toma")
				altacont.Combo_3.Value := n
				exit
			EndIf 
		Next
      //altacont.combo_2.value:=usuarios->(recno())
      altacont.text_11.value:=oRow:FieldGet("giro") //contrato->
		n:=1
		//MsgBox(oRow:FieldGet("tipo_con"),"")
		If altacont.text_11.Value = 0
			altacont.text_12.Value := "Sin Giro"
		Else 
			For n=1 To len(CatGir)
				If CatGir[n,1] = altacont.text_11.value
					altacont.text_12.Value := CatGir[n,2]
					exit
				EndIf 
			Next
		EndIf 
      //altacont.text_12.value:=giros->nombre
      //altacont.combo_3.value:=tomas->(recno())
      altacont.text_13.value:=oRow:FieldGet("cons_min") //contrato->
      altacont.text_14.value:=val(oRow:FieldGet("recibo")) //contrato->)
      altacont.text_15.value:=val(oRow:FieldGet("recibo1")) //contrato->)
      altacont.text_16.value:=oRow:FieldGet("derecho_ap") //contrato->
      altacont.text_17.value:=oRow:FieldGet("derecho_al") //contrato->
      altacont.text_18.value:=oRow:FieldGet("rotura") //contrato->
      altacont.text_19.value:=oRow:FieldGet("linea_gral") //contrato->
      altacont.text_20.value:=oRow:FieldGet("toma_larga") //contrato->
      altacont.text_21.value:=oRow:FieldGet("total") //contrato->
      altacont.text_22.value:=oRow:FieldGet("contado") //contrato->
      altacont.text_23.value:=oRow:FieldGet("dcto1") //contrato->
      altacont.text_25.value:=oRow:FieldGet("rfc") //contrato->
      altacont.text_26.value:=oRow:FieldGet("comentario") //contrato->
      altacont.radiogroup_6.value:=iif(empty(oRow:FieldGet("no_oficial")),2,val(oRow:FieldGet("no_oficial")))
      altacont.text_27.value:=oRow:FieldGet("fecha_no") //contrato->
      altacont.radiogroup_7.value:=iif(empty(oRow:FieldGet("titulo_pro")),2,val(oRow:FieldGet("titulo_pro")))
      altacont.radiogroup_5.value:=iif(oRow:FieldGet("medidor") = 0,2,oRow:FieldGet("medidor"))
      altacont.text_28.value:=oRow:FieldGet("fecha_ti") //contrato->
      altacont.radiogroup_3.value:=iif(oRow:FieldGet("servicio") = 0,2,oRow:FieldGet("servicio"))
      altacont.radiogroup_4.value:=iif(oRow:FieldGet("especial")=0,2,oRow:FieldGet("especial"))
      sumavalcont()
      sumaformpagoc()
   //EndIf 
	bQuery:Destroy()
return

function sumavalcont
   declare window altacont
   altacont.text_21.value:=altacont.text_16.value+altacont.text_17.value+altacont.text_18.value+altacont.text_19.value+altacont.text_20.value
return

function sumaformpagoc
   declare window altacont
   altacont.text_24.value:=altacont.text_22.value+altacont.text_23.value
return

Function EscribeCol()
	declare Window browcolonia
	declare Window altacont
	colLinea := browcolonia.Grid_1.Value 
	colValue := browcolonia.Grid_1.Item (colLinea)
	
	n:=1
	For n=1 To len(CatCol)
	//MsgBox(alltrim(catcol[n,2]),alltrim(colvalue[1]))
		If alltrim(CatCol[n,2]) = alltrim(colValue[1])
			altacont.text_8.Value := CatCol[n,1]
			altacont.text_9.Value := CatCol[n,2]
			exit
		EndIf 
	Next
	browcolonia.release
	altacont.text_9.SetFocus 
   //IF !IsWindowDefined(altacont) 
   //    Load Window altacont
	//	if flagopcon = 2
	//	MsgBox(contrato.Grid_1.Value,"5")
	//   	If contrato.Grid_1.Value = 0
	//			cValue := contrato.grid_1.item(1)
	//		Else
				
	//		EndIf
	//		pondatoscont()
	//	endif
   //    Center Window altacont
   //    Activate Window altacont
   //endIf
Return Nil

function grabacont
   declare window altacont
	If flagopcon = 1
		cQuery := "Insert into Contrato (NOMBRE,DOMICILIO,PREDIO,COLONIA,TIPO_USU,CVE_TOMA,CONS_MIN,FECHA,ORDEN_AGUA,ORDEN_DREN,CONTADO,RECIBO,DERECHO_AP,DERECHO_AL,ROTURA,LINEA_GRAL,TOMA_LARGA,TOTAL,DCTO1,RECIBO1,COMENTARIO,REALIZO,TELEFONO,NO_OFICIAL,FECHA_NO,TITULO_PRO,FECHA_TI,TIPO_CON,GIRO,SERVICIO,ESPECIAL,RFC,MEDIDOR) values ";
		+ "('" + AltaCont.Text_6.value + "','" + AltaCont.Text_7.value + "','" + AltaCont.Text_5.value + "','" + str(AltaCont.Text_8.value) + "','" + str(AltaCont.Combo_2.value) + "','" + str(AltaCont.Combo_3.value) + "'," + str(AltaCont.Text_13.value) + ",'" + cdate2mysqldate(AltaCont.DatePicker_1.value) + "','" + AltaCont.Text_2.value + "','" + AltaCont.Text_3.value + "'," + str(AltaCont.Text_22.value) + ",'" + AltaCont.Text_14.value + "'," + str(AltaCont.Text_16.value) + "," + str(AltaCont.Text_17.value) + "," + str(AltaCont.Text_18.value) + "," + str(AltaCont.Text_19.value) + "," + str(AltaCont.Text_20.value) + "," + str(AltaCont.Text_21.value) + "," + str(AltaCont.Text_23.value) + ",'" + AltaCont.Text_15.value + "','" + AltaCont.Text_26.value + "','" + AltaCont.Text_29.value + "','" + AltaCont.Text_10.value + "','" + str(AltaCont.RadioGroup_6.value) + "','" + AltaCont.Text_27.value + "','" + str(AltaCont.RadioGroup_7.value) + "','" + AltaCont.Text_28.value + "'," + str(AltaCont.Combo_1.value) + "," + str(AltaCont.Text_11.value) + "," + str(AltaCont.RadioGroup_3.value) + "," + str(AltaCont.RadioGroup_4.value) + ",'" + AltaCont.Text_25.value + "'," + str(AltaCont.RadioGroup_5.value) + ")"
		/*+ "'" + Contrato.Text_6.value + "','" + Contrato.Text_7.value + "','" + Contrato.Text_5.value + "','" + Contrato.Text_8.value + "','" + Contrato.Combo_2.value + "','" + Contrato.Combo_3.value + "'," + str(Contrato.Text_13.value) + ",'" + Contrato.DatePicker_1.value + "','" + Contrato.Text_2.value + "','" + Contrato.Text_3.value + "'," + str(Contrato.Text_22.value) + ",'" + Contrato.Text_14.value + "'," + str(Contrato.Text_16.value) + "," + str(Contrato.Text_17.value) + "," + str(Contrato.Text_18.value) + "," + str(Contrato.Text_19.value) + "," + str(Contrato.Text_20.value) + "," + str(Contrato.Text_21.value) + "," + str(Contrato.Text_23.value) + ",'" + Contrato.Text_15.value + "','" + Contrato.Text_26.value + "','" + Contrato.Text_29.value + "','" + Contrato.Text_10.value + "','" + Contrato.RadioGroup_6.value + "','" + Contrato.Text_27.value + "','" + Contrato.RadioGroup_7.value + "','" + Contrato.Text_28.value + "'," + str(Contrato.Combo_1.value) + "," + str(Contrato.Text_11.value) + "," + str(Contrato.RadioGroup_3.value) + "," + str(Contrato.RadioGroup_4.value) + ",'" + Contrato.Text_25.value + "'," + str(Contrato.RadioGroup_5.value) + ")"
		NOMBRE,DOMICILIO,PREDIO,
		COLONIA,TIPO_USU,CVE_TOMA,
		CONS_MIN,FECHA,ORDEN_AGUA,
		ORDEN_DREN,CONTADO,RECIBO,
		DERECHO_AP,DERECHO_AL,ROTURA,
		LINEA_GRAL,TOMA_LARGA,TOTAL,
		DCTO1,RECIBO1,COMENTARIO,
		REALIZO,TELEFONO,NO_OFICIAL,
		FECHA_NO,TITULO_PRO,FECHA_TI,
		TIPO_CON,GIRO,SERVICIO,
		ESPECIAL,RFC,MEDIDOR) values ("'";
		+ Altacont.text_6.Value + "','" + Altacont.text_7.Value + "','" + Altacont.text_5.Value + "','";
		+ Altacont.text_8.Value + "','" + Altacont.combo_2.Value + "','" + str(Altacont.combo_3.Value) + "',";
		+ str(Altacont.text_13.Value) + ",'" + cdate2mysqldate(Altacont.datepicker_1.Value) + "','" + Altacont.text_2.Value + "','";
		+ Altacont.text_3.Value + "'," + Altacont.text_22.Value + ",'" + Altacont.text_14.Value + "',";
		+ Altacont.text_16.Value + "," + Altacont.text_17.Value + "," + Altacont.text_18.Value + ",";
		+ Altacont.text_19.Value + "," + Altacont.text_20.Value + "," + Altacont.text_21.Value + ",";
		+ Altacont.text_23.Value + ",'" + Altacont.text_15.Value + "','" + Altacont.text_26.Value + "','";
		+ Altacont.text_29.Value + "','" + Altacont.text_10.Value + "','" + alltrim(str(altacont.radiogroup_6.value)) + "','";
		+ cdate2mysqldate(Altacont.text_27.Value) + "','" + alltrim(str(altacont.radiogroup_7.value)) + "','" + cdate2mysqldate(Altacont.text_28.Value) + "','";
		+ altacont.combo_1.Value + "','" + Altacont.text_11.Value + "','" + altacont.radiogroup_3.value + "','";
		+ altacont.radiogroup_4.value + "','" + Altacont.text_25.Value + "','" +altacont.radiogroup_5.value + "')"*/
	Else
		/*cQuery := "Update Contrato set NOMBRE='" + alltrim(AltaCont.Text_6.value) + "',DOMICILIO='" + alltrim(AltaCont.Text_7.value) + "',PREDIO='" + AltaCont.Text_5.value + "',COLONIA='" + AltaCont.Text_8.value + "',TIPO_USU='" + AltaCont.Combo_2.value + "',CVE_TOMA='" + AltaCont.Combo_3.value + "',CONS_MIN=" + str(AltaCont.Text_13.value) + ",FECHA='" + AltaCont.DatePicker_1.value + "',ORDEN_AGUA='" + AltaCont.Text_2.value + "',ORDEN_DREN='" + AltaCont.Text_3.value + "',CONTADO=" + str(AltaCont.Text_22.value) + ",RECIBO='" + AltaCont.Text_14.value + "',DERECHO_AP=" + str(AltaCont.Text_16.value) + ",DERECHO_AL=" + str(AltaCont.Text_17.value) + ",ROTURA=" + str(AltaCont.Text_18.value) + ",LINEA_GRAL=" + str(AltaCont.Text_19.value) + ",TOMA_LARGA=" + str(AltaCont.Text_20.value) + ",TOTAL=" + str(AltaCont.Text_21.value) + ",DCTO1=" + str(AltaCont.Text_23.value) + ",RECIBO1='" + AltaCont.Text_15.value + "',COMENTARIO='" + AltaCont.Text_26.value + "',REALIZO='" + AltaCont.Text_29.value + "',TELEFONO='" + AltaCont.Text_10.value + "',NO_OFICIAL='" + AltaCont.RadioGroup_6.value + "',FECHA_NO='" + AltaCont.Text_27.value + "',TITULO_PRO='" + AltaCont.RadioGroup_7.value + "',FECHA_TI='" + AltaCont.Text_28.value + "',TIPO_CON=" + str(AltaCont.Combo_1.value) + ",GIRO=" + str(AltaCont.Text_11.value) + ",SERVICIO=" + str(AltaCont.RadioGroup_3.value) + ",ESPECIAL=" + str(AltaCont.RadioGroup_4.value) + ",RFC='" + AltaCont.Text_25.value + "',MEDIDOR=" + str(AltaCont.RadioGroup_5.value) + ")"
									  "NOMBRE=' + alltrim(AltaCont.Text_6.Value) + 


		Nombre='" + Altacont.text_6.Value + "', orden_agua=" + str(altacont.text_2.value) + ",orden_dren=";
			+ str(altacont.text_3.value) + ",fecha='" + cdate2mysqldate(altacont.datepicker_1.value) + "', tipo_con=" + str(altacont.combo_1.value);
			+	",predio='" + altacont.text_5.Value + "', domicilio='" + altacont.text_7.Value + "', colonia='";
			+ strzero(altacont.text_8.value,3) + "', telefono='" + altacont.text_10.Value + "', tipo_usu='";
			+ strzero(altacont.combo_2.value,2) + "', giro=" + str(altacont.text_11.Value) + ",cve_toma='" + strzero(altacont.combo_3.value,2);
			+ "', cons_min=" + str(altacont.text_13.Value) + ",recibo='" + strzero(altacont.text_14.value,7) + "', recibo1='";
			+ strzero(altacont.text_15.value,7) + "', derecho_ap=" + str(altacont.text_16.Value) + ",derecho_al=" + str(altacont.text_17.value);
			+ ",rotura=" + str(altacont.text_18.Value) + ",linea_gral=" + str(altacont.text_19.Value) + ",toma_larga=" + str(altacont.text_20.value);
			+ ",total=" + str(altacont.text_21.Value) + ",contado=" + str(altacont.text_22.Value) + ",dcto1=" + str(altacont.text_23.value);
			+ ",realizo='" + altacont.text_29.Value + "', rfc='" + altacont.text_25.Value + "', comentario='" + altacont.text_26.value;
			+ "', no_oficial='" + alltrim(str(altacont.radiogroup_6.value)) + "', fecha_no='" + cdate2mysqldate(altacont.text_27.value);
			+ "', titulo_pro='" + alltrim(str(altacont.radiogroup_7.value)) + "', medidor=" + altacont.radiogroup_5.value; + "', fecha_ti='";
			+ cdate2mysqldate(altacont.text_28.value) + "', servicio=" + str(altacont.radiogroup_3.Value) + ",especial=";
			+ str(altacont.radiogroup_4.Value) + " where contrato=" + str(Altacont.text_1.Value)*/
	EndIf 
	MsgBox(cQuery,"")
	bQuery:=oServer:Query(cQuery)
			If bQuery:NetErr()												
				MsgStop(bQuery:Error())
				return Nil
			Endif
	bQuery:Destroy()
	/*
   select contrato
   
		cQuery := "select contrato From Foliosn "
	bQuery := oServer:Query (cQuery)
	If bQuery:NetErr()
		Msgstop(bQuery:Error())
		Return Nil
	EndIf 
      select 60
      do while .t.
         use foliosn exclu
	 if !neterr()
	    exit
         endif
      enddo
      altacont.text_1.value:=foliosn->contrato+1
      foliosn->contrato:=altacont.text_1.value
      dbselectarea('foliosn')
      foliosn->(dbclosearea())
      select contrato
      append blank
   
      do while .t.
         if contrato->(rlock())
            exit
	 endif
      enddo
   endif
   contrato->contrato:=strzero(altacont.text_1.value,6)
   contrato->orden_agua:=strzero(altacont.text_2.value,6)
   contrato->orden_dren:=strzero(altacont.text_3.value,6)
   contrato->fecha:=altacont.datepicker_1.value
   contrato->tipo_con:=altacont.combo_1.value
   contrato->predio:=altacont.text_5.value
   contrato->nombre:=altacont.text_6.value
   contrato->domicilio:=altacont.text_7.value
   contrato->colonia:=altacont.text_8.value
   contrato->telefono:=altacont.text_10.value
   contrato->tipo_usu:=altacont.combo_2.value
   contrato->giro:=altacont.text_11.value
   contrato->cve_toma:=altacont.combo_3.value
   contrato->cons_min:=altacont.text_13.value
   contrato->recibo:=strzero(altacont.text_14.value,7)
   contrato->recibo1:=strzero(altacont.text_15.value,7)
   contrato->derecho_ap:=altacont.text_16.value
   contrato->derecho_al:=altacont.text_17.value
   contrato->rotura:=altacont.text_18.value
   contrato->linea_gral:=altacont.text_19.value
   contrato->toma_larga:=altacont.text_20.value
   contrato->total:=altacont.text_21.value
   contrato->contado:=altacont.text_22.value
   contrato->dcto1:=altacont.text_23.value
   contrato->realizo:=altacont.text_29.value
   contrato->rfc:=altacont.text_25.value
   contrato->comentario:=altacont.text_26.value
   contrato->no_oficial:=alltrim(str(altacont.radiogroup_6.value))
   contrato->fecha_no:=altacont.text_27.value
   contrato->titulo_pro:=alltrim(str(altacont.radiogroup_7.value))
   contrato->medidor:=altacont.radiogroup_5.value
   contrato->fecha_ti:=altacont.text_28.value
   contrato->servicio:=altacont.radiogroup_3.value
   contrato->especial:=altacont.radiogroup_4.value
   contrato->(dbcommit())
   contrato->(dbunlock())*/
return

function bskacolcont
   declare window altacont
/*   select colonias
   set order to 3
   go top*/
   IF !IsWindowDefined(browcolonia) 
       Load Window browcolonia
       cQuery := "select nombre From Colonias order by nombre"
	bQuery := oServer:Query (cQuery)
	If bQuery:NetErr()
		Msgstop(bQuery:Error())
		Return Nil
	EndIf 
	
	For i=1 To bQuery:LastRec()
		oRow := bQuery:GetRow(i)
		browcolonia.grid_1.AddItem({oRow:FieldGet("nombre")})
	Next
	bQuery:Destroy()
		 Center Window browcolonia
       Activate Window browcolonia
   endIf
	
return

function buscacolonias
	declare window browcolonia
  /* select colonias
   seek alltrim(browcolonia.text_1.value)
   browcolonia.browse_1.value:=colonias->(recno())
   browcolonia.browse_1.refresh*/
	cQuery := "select nombre From Colonias where nombre like '%" + browcolonia.text_1.Value  + "%'"
	bQuery := oServer:Query (cQuery)
	If bQuery:NetErr()
		Msgstop(bQuery:Error())
		Return Nil
	EndIf 
	browcolonia.grid_1.DeleteAllItems()
	For i=1 To bQuery:LastRec()
		oRow := bQuery:GetRow(i)
		browcolonia.grid_1.AddItem({oRow:FieldGet("nombre")})
	Next
	bQuery:Destroy()
return


function buscagirocont
  declare window browgiro
   IF !IsWindowDefined(browgiro) 
       Load Window browgiro
       cQuery := "select nombre From Giros order by nombre"
	bQuery := oServer:Query (cQuery)
	If bQuery:NetErr()
		Msgstop(bQuery:Error())
		Return Nil
	EndIf 
	
	For i=1 To bQuery:LastRec()
		oRow := bQuery:GetRow(i)
		browgiro.grid_1.AddItem({oRow:FieldGet("nombre")})
	Next
	bQuery:Destroy()
		 Center Window browgiro
       Activate Window browgiro
   endIf
return

function seekgirocont
 declare window browgiro
  /* select colonias
   seek alltrim(browcolonia.text_1.value)
   browcolonia.browse_1.value:=colonias->(recno())
   browcolonia.browse_1.refresh*/
	cQuery := "select nombre From Giros where nombre like '%" + browgiro.text_1.Value  + "%'"
	bQuery := oServer:Query (cQuery)
	If bQuery:NetErr()
		Msgstop(bQuery:Error())
		Return Nil
	EndIf 
	browgiro.grid_1.DeleteAllItems()
	For i=1 To bQuery:LastRec()
		oRow := bQuery:GetRow(i)
		browgiro.grid_1.AddItem({oRow:FieldGet("nombre")})
	Next
	bQuery:Destroy()
return

function pongirocont
   /*declare window browgiro
   declare window altacont
   altacont.text_11.value:=giros->clave
   altacont.text_12.value:=giros->nombre
   browgiro.release
   
   altacont.combo_3.setfocus*/
	declare Window browgiro
	declare Window altacont
	
	girLinea := browgiro.Grid_1.Value 
	girValue := browgiro.Grid_1.Item (girLinea)
	
	n:=1
	For n=1 To len(CatGir)
	//MsgBox(alltrim(catcol[n,2]),alltrim(colvalue[1]))
		If alltrim(CatGir[n,2]) = alltrim(girValue[1])
			altacont.text_11.Value := CatGir[n,1]
			altacont.text_12.Value := CatGir[n,2]
			exit
		EndIf 
	Next
	browgiro.release
	altacont.text_12.SetFocus 
	girLinea:=0
	girValue:={}
return


//function sumavalcont
   //declare window altacont
   //altacont.text_21.value:=altacont.text_16.value+altacont.text_17.value+altacont.text_18.value+altacont.text_19.value+altacont.text_20.value
//return

//function sumaformpagoc
   //declare window altacont
   //altacont.text_24.value:=altacont.text_22.value+altacont.text_23.value
//return

function imprimecont
   declare window altacont
   if altacont.text_1.value = 0
      MsgInfo('Tiene que grabar el contrato antes de imprimirlo','Mensaje del Sistema')
      altacont.datepicker_1.setfocus
      return
   endif
   if  altacont.datepicker_1.value <> date() .and. mpermisos <> '1'
       MsgInfo('No Puede Imprimir El Contrato','Mensaje del Sistema')
       return
   else
      if altacont.datepicker_1.value = date()
         impcontpdf1()
      endif
   endif
   impcontpdf2()
return

function impcontpdf1
   declare window altacont
   local cRun, nWidth, nTab, nI, nJ, nK, nCol, nRow, aStyle, aFonts,unil:=8
	Local strcpto:="", strdiam:="",strusu:="",tmpfecha_venc:=ctod("  /  /    ")
   *local nTop, nLeft, nBottom, nRight,ruta:='f:\sca\documentos\contratos\'
   local nTop, nLeft, nBottom, nRight,ruta:='c:\documentos\contratos\'
   local aColor := { ;
   "FF0000", "8B0000", "800000", "FF4500", "D2691E", "B8860B", "FF8C00", "FFA500", "DAA520", "808000", "FFD700", "FFFF00", "ADFF2F", "9ACD32", "7FFF00", "7CFC00", "00FF00", "32CD32", "008000", "006400",;
   "66CDAA", "7FFFD4", "87CEFA", "87CEEB", "F0F8FF", "E0FFFF", "B0C4DE", "B0E0E6", "AFEEEE", "ADD8E6", "8FBC8F", "90EE90", "98FB98", "00FA9A", "00FF7F", "3CB371", "2E8B57", "228B22", "556B2F", "6B8E23",;
   "5F9EA0", "40E0D0", "48D1CC", "00CED1", "20B2AA", "008B8B", "008080", "2F4F4F", "00BFFF", "00FFFF", "00FFFF", "0000FF", "0000CD", "00008B", "000080", "1E90FF", "4169E1", "4682B4", "6495ED", "7B68EE",;
   "C71585", "FF1493", "FF00FF", "FF00FF", "9370DB", "DDADDD", "DB7093", "FF69B4", "DA70D6", "EE82EE", "BA55D3", "9932CC", "8A2BE2", "9400D3", "8B008B", "800080", "4B0082", "191970", "483D8B", "6A5ACD",;
   "DC143C", "B22222", "A52A2A", "CD5C5C", "FA8072", "E9967A", "FFA07A", "F5DEB3", "FFDEAD", "EEE8AA", "FFDAB9", "FFE4C4", "FFEFD5", "FFE4E1", "FFE4B5", "D2B48C", "DEB887", "F0E68C", "BDB76B", "F4A460",;
   "FDF5E6", "FFF8DC", "FAF0E6", "FAFAD2", "FFFACD", "FFEBCD", "FFFFE0", "FAEBD7", "FFF5EE", "FFF0F5", "D8BFD8", "FFC0CB", "FFB6C1", "BC8F8F", "F08080", "FF7F50", "FF6347", "8B4513", "A0522D", "CD853F",;
   "FFFAFA", "FFFFF0", "E6E6FA", "FFFAF0", "F8F8FF", "F0FFF0", "F5F5DC", "F0FFFF", "F5FFFA", "708090", "778899", "F5F5F5", "DCDCDC", "D3D3D3", "C0C0C0", "A9A9A9", "808080", "696969", "000000", "FFFFFF"}
   aReport := PdfInit()
   archivopdf:=ruta+strzero(altacont.text_1.value,8)+'.pdf'
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
   if altacont.text_15.value > 0
      //select pagares
      //set order to 6
      //seek strzero(altacont.text_15.value,7)
      cQuery := "select * From Pagares where pagare='" + altacont.text_15.Value  + "'"
		bQuery := oServer:Query (cQuery)
		If bQuery:NetErr()
			Msgstop(bQuery:Error())
			Return Nil
		EndIf 
		if bQuery:LastRec() > 0
			oRow := bQuery:GetRow(1)
         unil:=6
         pdfNewPage( "MC", "P", 6 )
         pdfBookAdd( "Pagare", 1, aReport[ REPORTPAGE ], 0 )
         pdfImage( 'laredo.jpg', 10, 10, "M",20,20) // file, row, col, units, height, width
         pdfImage( 'comapa.jpg', 10, 180, "M",20,20) // file, row, col, units, height, width
         pdfSetFont( "Times" , 1 , 12 )
         pdfAtSay("COMISION MUNICIPAL DE AGUA POTABLE Y ALCANTARILLADO", 2,30, "R" )
         pdfAtSay('                      DEL MUNICIPIO DE NUEVO LAREDO',4, 35, "R" )
         pdfSetFont( "Times" , 1 , 14 )
         pdfAtSay('PAGARE',unil,82,"R")
	 unil:=unil+2
         pdfSetFont( "Times" , 1 , 9 )
         pdfAtSay('FOLIO : '+strzero(altacont.text_15.value,7),unil,0,"R")
         pdfAtSay('NUEVO LAREDO, TAMP.  A '+ alltrim(str(day(oRow:FieldGet("fecha_act"))))+' DE '+ upper(ames[month(oRow:FieldGet("fecha_act"))]) +' '+ str(year(oRow:FieldGet("fecha_act")),4),unil,130,"R")
         unil:=unil+2
         pdfAtSay('POR ESTE PAGARE INCONDICIONALMENTE (ME) (NOS) OBLIG(O) (AMOS) A CUBRIR LA ORDEN DE COMAPA',unil,0,"R")
         unil:=unil+1
         pdfAtSay('(  COMISION  MUNICIPAL  DE  AGUA  POTABLE  Y   ALCANTARILLADO ) DE NUEVO LAREDO,  TAM.,   EN  SUS',unil,0,"R")
         unil:=unil+1
	 n:=0
	 For n=1 To len(CatTpg)
		If CatTpg[n,1] = oRow:FieldGet("concepto")
			strcpto := CatTpg[n,2]
			exit
		EndIf 
	 Next
	  n:=0
	 For n=1 To len(CatDia)
		If CatDia[n,12] = oRow:FieldGet("cve_toma")
			strdiam := CatDia[n,13]
			exit
		EndIf 
	 Next
	
	 n:=0
	 For n=1 To len(CatUsu)
		If CatUsu[n,12] = oRow:FieldGet("tipo_usu")
			strusu := CatUsu[n,13]
			exit
		EndIf 
	 Next
	 tmpfecha_venc := oRow:FieldGet("fecha_ven")
	 //select tipop
	 //seek pagares->concepto
         pdfAtSay('OFICINAS, UBICADAS EN VICTORIA No. 4610 POR CONCEPTO DE ' + alltrim(strcpto),unil,0,"R")
	 //select pagares
         unil:=unil+2
         pdfAtSay('CONTRATO No. :' + alltrim(oRow:FieldGet("contrato")),unil,0,"R")
         unil:=unil+1
         pdfAtSay('SUBTOTAL :' + transform(oRow:FieldGet("importe"),'999,999.99')+'                      I.V.A. :' + transform(oRow:FieldGet("iva"),'999,999.99')+'                      TOTAL :' + transform(pagares->total,'999,999.99'),unil,0,"R")
         unil:=unil+1
         pdfAtSay('LA CANTIDAD DE :' + transform(oRow:FieldGet("total"),'999,999.99'),unil,0,"R")
         unil:=unil+2
         pdfAtSay(letras(oRow:FieldGet("total")),unil,0,"R")
         unil:=unil+2
         pdfAtSay('DE NO SER CUBIERTA A SU  VENCIMIENTO LA  CANTIDAD  ANTERIOR  CAUSARA  INTERESES  MORATORIOS',unil,0,"R")
         unil:=unil+1
         pdfAtSay('A RAZON DEL (10%) MENSUAL',unil,0,"R")
         unil:=unil+2
         pdfAtSay('VENCIMIENTO : ' + dtoc(oRow:FieldGet("fecha_ven")),unil,0,"R")
         unil:=unil+1
         if oRow:FieldGet("ruta")+oRow:FieldGet("folio") != space(7)
            pdfAtSay('LOCALIZACION : ' + oRow:FieldGet("ruta") +'-'+oRow:FieldGet("folio"),unil,0,"R")
            unil:=unil+1
         endif
         pdfAtSay('DOMICILIO : ' + oRow:FieldGet("domicilio"),unil,0,"R")
         pdfImage( 'usuario.jpg', 97, 155, "M",20,30) // file, row, col, units, height, width
         pdfAtSay(oRow:FieldGet("nombre"),unil,140,"R")
         unil:=unil+2
         pdfAtSay('REALIZO : ' + oRow:FieldGet("capturo"),unil,0,"R")
         unil:=unil+2
         pdfAtSay('ORIGINAL - JURIDICO',unil,0,"R")
			pdfAtSay(mcomercial,unil,73,"R")
         unil:=unil+1
         pdfImage( 'COMERCIAL.jpg', 107, 90, "M",30,50) // file, row, col, units, height, width
         pdfAtSay('GERENTE COMERCIAL ( FIRMA Y SELLO )',unil,70,"R")
         unil:=unil+1
         pdfAtSay('AUTORIZACIÓN',unil,92,"R")
      endif
      //set order to 1
		bQuery:Destroy()
   else
      pdfNewPage( "LETER", "P", 6 )
      pdfBookAdd( "Pagare", 1, aReport[ REPORTPAGE ], 0 )
      pdfAtSay("NO TIENE PAGARE", 2,35, "R" )
   endif
   if altacont.text_14.value > 0
      pdfNewPage( "MC", "P", 7 )
      pdfBookAdd( "Recibo Diverso", 1, aReport[ REPORTPAGE ], 0 )
		//select diverso
      //seek strzero(altacont.text_14.value,7)
      cQuery := "select * From Diversos where numero=" + altacont.text_14.Value
		bQuery := oServer:Query (cQuery)
		If bQuery:NetErr()
			Msgstop(bQuery:Error())
			Return Nil
		EndIf 
		if bQuery:LastRec() > 0
			oRow := bQuery:GetRow(1)
			pdfImage( 'diverso.jpg', 0, 0, "M") // file, row, col, units, height, width
			unil:=8
			pdfAtSay('RECIBO :'+strzero(altacont.text_14.value,7),unil,34,"R")
			pdfAtSay('FECHA : '+ alltrim(str(day(oRow:FieldGet("fecha"))))+' DE '+ upper(ames[month(oRow:FieldGet("fecha"))]) +' '+ str(year(oRow:FieldGet("fecha")),4),unil,140,"R")
			unil:=unil+1
			pdfAtSay('CONTRATO :'+strzero(altacont.text_1.value,8),unil,34,"R")
			pdfAtSay('TOMA :'+left(strdiam,6),unil,100,"R")
			pdfAtSay('USUARIO :'+alltrim(strusu),unil,140,"R")
			unil:=unil+1
			if altacont.text_15.value > 0
				pdfAtSay('DOCUMENTO :'+strzero(altacont.text_15.value,7),unil,34,"R")
		 //select pagares
		 //seek strzero(altacont.text_15.value,7)
				pdfAtSay('FECHA DE VENCIMIENTO DEL PAGARE :'+ dtoc(tmpfecha_venc),unil,100,"R")
		 //select diverso
				unil:=unil+1
			endif
			if altacont.text_2.value >0  .or.  altacont.text_3.value > 0
				pdfAtSay('ORDEN DE AGUA :'+strzero(altacont.text_2.value,8),unil,34,"R")
				pdfAtSay('ORDEN DE DRENAJE :'+strzero(altacont.text_3.value,8),unil,100,"R")
				unil:=unil+1
			endif
			pdfAtSay('LOCALIZACION :'+oRow:FieldGet("ruta")+'-'+oRow:FieldGet("folio"),unil,34,"R")
			pdfAtSay('NOMBRE    :' + ALLTRIM(oRow:FieldGet("nombre")),unil,100,"R")
			unil:=unil+1
			pdfAtSay('DOMICILIO :' + ALLTRIM(oRow:FieldGet("domicilio")),unil,34,"R")
			unil:=unil+1
			pdfAtSay('COLONIA :'+alltrim(altacont.text_9.value),unil,34,"R")
			unil:=unil+3
			flagcon:=0
			//dbselectarea('diversod')
			//seek strzero(altacont.text_14.value,7)
			lQuery := "select * From Diversod where numero=" + altacont.text_14.Value
			tQuery := oServer:Query (lQuery)
			If tQuery:NetErr()
				Msgstop(tQuery:Error())
				Return Nil
			EndIf 
			For i=1 To tQuery:LastRec()
				kRow := tQuery:GetRow(i)
			  // do while diversod->numero = strzero(altacont.text_14.value,7)
				 //  if diversod->numero = strzero(altacont.text_14.value,7)
						pdfAtSay(kRow:FieldGet("cve_cpto"),unil,34,"R")
						pdfAtSay(kRow:FieldGet("nombre"),unil,40,"R")
						pdfAtSay(transform(kRow:FieldGet("cantidad"),'999,999,999.99'),unil,180,"R")
				 //skip
						unil:=unil+1
			Next     // endif
	 //enddo
      endif
      unil:=unil+5
      dbselectarea('diverso')
      pdfAtSay('SUBTOTAL :',unil,150,"R")
      pdfAtSay(transform(oRow:FieldGet("subtotal"),'999,999,999.99'),unil,180,"R")
      unil:=unil+1
      pdfAtSay('11%   I.V.A. :',unil,150,"R")
      pdfAtSay(transform(oRow:FieldGet("iva"),'999,999,999.99'),unil,180,"R")
      unil:=unil+1
      pdfAtSay('       TOTAL :',unil,150,"R")
      pdfAtSay(transform(oRow:FieldGet("total"),'999,999,999.99'),unil,180,"R")
      unil:=unil+4
      *pdfAtSay(alltrim(vardiv:nomfor),ofont3)      
      pdfAtSay(mcajero,unil,140,"R")
   else
      pdfNewPage( "LETER", "P", 6 )
      pdfBookAdd( "Recibo Diverso", 1, aReport[ REPORTPAGE ], 0 )
      pdfAtSay("NO TIENE RECIBO DIVERSO", 2,35, "R" )
   endif
   pdfClose()
   //set date to FRENCH
   //dbselectarea('contrato')*/
return

function impcontpdf2() //aqui me quede
   declare window altacont
   local cRun, nWidth, nTab, nI, nJ, nK, nCol, nRow, aStyle, aFonts,unil:=8
   *local nTop, nLeft, nBottom, nRight,ruta1:='f:\sca\documentos\contratos\temp\'
   local nTop, nLeft, nBottom, nRight,ruta1:='c:\documentos\contratos\temp\'
   local aColor := { ;
   "FF0000", "8B0000", "800000", "FF4500", "D2691E", "B8860B", "FF8C00", "FFA500", "DAA520", "808000", "FFD700", "FFFF00", "ADFF2F", "9ACD32", "7FFF00", "7CFC00", "00FF00", "32CD32", "008000", "006400",;
   "66CDAA", "7FFFD4", "87CEFA", "87CEEB", "F0F8FF", "E0FFFF", "B0C4DE", "B0E0E6", "AFEEEE", "ADD8E6", "8FBC8F", "90EE90", "98FB98", "00FA9A", "00FF7F", "3CB371", "2E8B57", "228B22", "556B2F", "6B8E23",;
   "5F9EA0", "40E0D0", "48D1CC", "00CED1", "20B2AA", "008B8B", "008080", "2F4F4F", "00BFFF", "00FFFF", "00FFFF", "0000FF", "0000CD", "00008B", "000080", "1E90FF", "4169E1", "4682B4", "6495ED", "7B68EE",;
   "C71585", "FF1493", "FF00FF", "FF00FF", "9370DB", "DDADDD", "DB7093", "FF69B4", "DA70D6", "EE82EE", "BA55D3", "9932CC", "8A2BE2", "9400D3", "8B008B", "800080", "4B0082", "191970", "483D8B", "6A5ACD",;
   "DC143C", "B22222", "A52A2A", "CD5C5C", "FA8072", "E9967A", "FFA07A", "F5DEB3", "FFDEAD", "EEE8AA", "FFDAB9", "FFE4C4", "FFEFD5", "FFE4E1", "FFE4B5", "D2B48C", "DEB887", "F0E68C", "BDB76B", "F4A460",;
   "FDF5E6", "FFF8DC", "FAF0E6", "FAFAD2", "FFFACD", "FFEBCD", "FFFFE0", "FAEBD7", "FFF5EE", "FFF0F5", "D8BFD8", "FFC0CB", "FFB6C1", "BC8F8F", "F08080", "FF7F50", "FF6347", "8B4513", "A0522D", "CD853F",;
   "FFFAFA", "FFFFF0", "E6E6FA", "FFFAF0", "F8F8FF", "F0FFF0", "F5F5DC", "F0FFFF", "F5FFFA", "708090", "778899", "F5F5F5", "DCDCDC", "D3D3D3", "C0C0C0", "A9A9A9", "808080", "696969", "000000", "FFFFFF"}
   aReport := PdfInit()
   archivopdf:=ruta1+strzero(altacont.text_1.value,8)+'.pdf'
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
   pdfNewPage( "LEGAL", "P", 8 )
   pdfBookAdd( "Contrato", 1, aReport[ REPORTPAGE ], 0 )
   pdfImage( 'laredo.jpg', 10, 10, "M",20,20) // file, row, col, units, height, width
   pdfImage( 'comapa.jpg', 10, 180, "M",20,20) // file, row, col, units, height, width
   pdfSetFont( "Times" , 1 , 12 )
   pdfAtSay("COMISION MUNICIPAL DE AGUA POTABLE Y ALCANTARILLADO", 2,30, "R" )
   pdfAtSay('                      DEL MUNICIPIO DE NUEVO LAREDO',4, 30, "R" )
   pdfSetFont( "Times" , 1 , 10 )
   pdfAtSay('CONTRATO NUMERO : '+strzero(altacont.text_1.value,8),6,63,"R")
   pdfSetFont( "Times" , 0 , 9 )
   unil:=11
   pdfAtSay('Contrato  que  celebran  por  una  parte  la  Comision   Municipal  de  Agua  Potable  y  Alcantarillado  de  Nuevo  Laredo,  Tamaulipas   representada',unil,0,"R")
   unil:=unil+1
   pdfAtSay('por  su  Gerente  General, __________________________________________ quien  en   lo  sucesivo  se denominara  LA COMISION, y  por la  otra',unil,0,"R")
   pdfAtSay(mgerente,unil,37,"R")
   unil:=unil+1
   pdfAtSay('el  sr(a). _______________________________________________ a  quien  en lo sucesivo  se le denominara  EL USUARIO; y  cuyo  objeto  sera  la',unil,0,"R")
   pdfAtSay(left(altacont.text_6.value,40),unil,14,"R" )
   unil:=unil+1
   pdfAtSay('prestación del servicio de _________________________ uso especifico ____________________ y diámetro _________, de acuerdo a las siguientes:',unil,0,"R")
   pdfAtSay(left(tipo_con->nombre,15),unil,35,"R")
   pdfAtSay(left(usuarios->des_usu,15),unil,96,"R")
   pdfAtSay(left(tomas->des_toma,6),unil,145,"R")
   pdfSetFont( "Times" , 1 , 12 )
   unil:=unil+2
   pdfAtSay('C L A U S U L A S',unil,80,"R")
   pdfSetFont( "Times" , 0 , 9 )
   unil:=unil+2
   pdfAtSay('PRIMERA.- El USUARIO solicita  el  servicio de  agua  potable  y  alcantarillado  sanitario  para  el  predio  que se  encuentra  ubicado  en   la    calle',unil,0,"R" )
   unil:=unil+1
   pdfAtSay('____________________________________________, de la colonia ____________________________, La  toma domiciliaria y la descarga sanitaria',unil,0,"R" )
   pdfAtSay(alltrim(left(altacont.text_7.value,30)),unil,0,"R" )
   pdfAtSay(alltrim(altacont.text_9.value),unil,91,"R" )
   unil:=unil+1
   pdfAtSay('es  para  uso  exclusivo  del  predio  antes  referido, por  lo  tanto  quedan  prohibidas  las  conexiones  internas    entre  otros predios, el  desacato a  lo',unil,0,"R" )
   unil:=unil+1
   pdfAtSay('señalado anteriormente es motivo de multas o baja definitiva del presente contrato.',unil,0,"R" )
   unil:=unil+2
   pdfAtSay('SEGUNDA.- El   USUARIO se obliga a  pagar los  gastos de instalación del servicio (líneas) y accesorios (tubería) asi como las  que  se originen  por',unil,0,"R" )
   unil:=unil+1
   pdfAtSay('reparaciones derivadas de su uso.',unil,0,"R" )
   unil:=unil+2
   pdfAtSay('TERCERA.-  El USUARIO  pagara  a  LA  COMISION  por  concepto  de  prestación  del  servicio  solicitado  en  el presente  contrato la cantidad de ',unil,0,"R" )
   unil:=unil+1
   pdfSetFont( "Times" , 1 , 9 )
   pdfAtSay(transform(altacont.text_21.value,'999,999.99')+ '    CON LETRA:   ('+alltrim(letras(altacont.text_21.value))+')',unil,0,"R" )
   pdfSetFont( "Times" , 0 , 9 )
   unil:=unil+2
   
   pdfAtSay('CUARTA.- En el supuesto que se  autorice a EL USUARIO  pagar en parcialidades la cantidad señalada la clausula anterior, este suscribirá un pagare',unil,0,"R" )
   unil:=unil+1
   pdfAtSay('a favor de LA COMISION en el que se señala  el saldo pendiente, y el plazo  para finquítarlo  y  en caso de incumplimiento EL USUARIO autoriza  a',unil,0,"R" )
   unil:=unil+1
   pdfAtSay('LA COMISION a suspender el servicio de agua potable y drenaje.',unil,0,"R" )
   unil:=unil+2

   pdfAtSay('QUINTA.- LA COMISION  proporcionara  el  servicio  contratado, instalando un  aparato medidor  de volúmenes  de agua y una  llave reguladora del',unil,0,"R" )
   unil:=unil+1
   pdfAtSay('servicio y esta infraestructura deberá estar ubicada a la entrada del predio, con libre acceso para el personal autorizado por LA COMISION.',unil,0,"R" )
   unil:=unil+2
   pdfAtSay('Los medidores son  propiedad  de  LA COMISION, solamente  el  personal   autorizado  por  esta   podrá  instalarlos,  revisarlos, cambiarlos',unil,0,"R" )
   unil:=unil+1
   pdfAtSay('y verificarlos, la violación señalada anteriormente, será sancionado conforme a lo que establecen las disposiciones legales aplicables.',unil,0,"R" )
   unil:=unil+2

   pdfAtSay('SEXTA.- El USUARIO pagara por el uso y goce del servicio conforme a los precios y tarifas en vigor, dentro de los usos específicos establecidos; las',unil,0,"R" )
   unil:=unil+1
   pdfAtSay('tarifas del servicio podrán ser revisadas y modificadas cuando lo estime LA COMISION.',unil,0,"R" )
   unil:=unil+2
   
   pdfAtSay('SEPTIMA.- La falta u omisión de  la entrega  de  recibo  de  cobro  del servicio  por parte de LA COMISION, no exime a El USUARIO su obligación',unil,0,"R" )
   unil:=unil+1
   pdfAtSay('de cubrir el pago correspondiente puntualmente.',unil,0,"R" )
   unil:=unil+2
   
   pdfAtSay('OCTAVA.- EL USUARIO  que  no  cumpla oportunamente  con el pago de  los servicios contratados, faculta  a   LA COMISION   para suspender  el',unil,0,"R" )
   unil:=unil+1
   pdfAtSay('servicio al día siguiente  de  la fecha  de  su vencimiento y  el servicio será reinstalado hasta que el usuario regularice su pago, previo el pago  que  fije',unil,0,"R" )
   unil:=unil+1
   pdfAtSay('LA COMISION por concepto de reconexión y en caso de que el usuario no cubra el  adeudo dos meses  después de la fecha de su vencimiento se dara',unil,0,"R" )
   unil:=unil+1
   pdfAtSay('por cancelado el presente contrato.',unil,0,"R" )

   unil:=unil+2
   
   pdfAtSay('NOVENA.- EL USUARIO se obliga a permitir el  acceso al predio  servido, al personal autorizado por LA COMISION para efectuar lecturas, repara-',unil,0,"R" )
   unil:=unil+1
   pdfAtSay('ciones, inspecciones, suspensiones y las acciones que sean necesarias para el servicio en mención.',unil,0,"R" )
   unil:=unil+2
   
   pdfAtSay('DECIMA.- Ambas partes acuerdan que en caso de requerirse alguna reparación en la línea contratada, sera responsabilidad de LA COMISION única y',unil,0,"R" )
   unil:=unil+1
   pdfAtSay('exclusivamente de la toma domiciliaria hacia la línea general y al interior de esta será responsabilidad de EL USUARIO.',unil,0,"R" )
   unil:=unil+2
   
   pdfAtSay('DECIMO PRIMERA.- LA COMISION podrá suspender los servicios temporalmente por causa de fuerza mayor o necesidades de trabajo, por  lo  que',unil,0,"R" )
   unil:=unil+1
   pdfAtSay('EL USUARIO no se reserva ninguna acción en contra de la misma.',unil,0,"R" )
   unil:=unil+2

   pdfAtSay('DECIMO SEGUNDA.- Solo LA COMISION tendrá atribuciones para modificar la condiciones hidráulicas de la red de la distribución  en función  de',unil,0,"R" )
   unil:=unil+1
   pdfAtSay('la capacidad de sus instalaciones y de la cuantía integral de la demanda del servicio y de regular los caudales de acuerdo a la fluctación  de  la relación',unil,0,"R" )
   unil:=unil+1
   pdfAtSay('necesidad-capacidad. Debiendo EL USUARIO respetar desde ahora y en lo futuro las disposiciones que para tales fines dicte LA COMISION.',unil,0,"R" )
   unil:=unil+2

   pdfAtSay('DECIMO TERCERA.- LA COMISION tendrá derecho, sin restricción alguna por parte de EL USUARIO para instalar, extender, componer,  cambiar',unil,0,"R" )
   unil:=unil+1
   pdfAtSay('o quitar la línea, equipo de medición y demás materiales necesarios para el servicio objeto de este contrato y cobrar los excedentes a los nueve  metros',unil,0,"R" )
   unil:=unil+1
   pdfAtSay('promedio de tubería de cobre convenidos, asi como a seis metros de tubo de concreto  lineales para el drenaje  y  este ultimo  llegara  hasta  el registro',unil,0,"R" )
   unil:=unil+1
   pdfAtSay('que EL USUARIO tendrá en la banqueta.',unil,0,"R" )

   unil:=unil+2

   pdfAtSay('DECIMO CUARTA.-  EL  USUARIO  declara   expresamente  que   se  somete  en  todo   lo   previsto  de  este  contrato, a  las leyes  y   reglamentos',unil,0,"R" )
   unil:=unil+1
   pdfAtSay('en la materia que rigen a LA COMISION.',unil,0,"R" )
   unil:=unil+2
   pdfAtSay('LEIDO   que   fue  el   presente  contrato,  por  los   que  intervinieron  y   percatados   de    el  valor  y   la   fuerza  legal  de  todas  y  cada  una  de las' ,unil,0,"R" )
   unil:=unil+1
   pdfAtSay('clausulas, lo firman en Nuevo Laredo, Tam. a los : ' + str(day(altacont.datepicker_1.value),2) + ' dias del mes de ' + ames[month(altacont.datepicker_1.value)] + ' de ' + str(year(altacont.datepicker_1.value),4),unil,0,"R" )
   unil:=unil+2
   pdfSetFont( "Times" , 1 , 9 )
   pdfAtSay('LIQUIDACION:',unil,0,"R" )
   pdfAtSay('FORMA DE PAGO:',unil,120,"R" )
   pdfSetFont( "Times" , 0 , 9 )
   unil:=unil+2
   A1:=altacont.text_16.value
   A2:=altacont.text_17.value
   A3:=altacont.text_18.value
   A4:=altacont.text_19.value
   SUM1:=A1+A2+A3+A4
   A1:=INT(A1*100/1.16)/100
   A2:=INT(A2*100/1.16)/100
   A3:=INT(A3*100/1.16)/100
   A4:=INT(A4*100/1.16)/100
   SUB:=A1+A2+A3+A4
   IVA:=SUM1-SUB
   pdfAtSay('CONTRATO',unil,0,"R" )
   pdfAtSay('$',unil,78,"R" )
   pdfAtSay(TRANSFORM(A1+A2+A3+A4+iva,'999,999.99'),unil,80,"R" )
   pdfAtSay('CONTADO                   ',unil,120,"R" )
   pdfAtSay(TRANSFORM(altacont.text_22.value,'999,999.99'),unil,160,"R" )
   unil:=unil+1
   pdfAtSay('DOCUMENTOS',unil,120,"R" )
   pdfAtSay(TRANSFORM(altacont.text_23.value,'999,999.99'),unil,160,"R" )
   unil:=unil+1
   pdfAtSay('TOTAL',unil,120,"R" )
   pdfAtSay('$',unil,157,"R" )
   pdfAtSay(TRANSFORM(altacont.text_24.value,'999,999.99'),unil,160,"R" )
   unil:=unil+1
   unil:=unil+1
   unil:=unil+1
   unil:=unil+1
   unil:=unil+3
   pdfAtSay(alltrim(mgerente),unil,20,"R" )
   pdfAtSay(alltrim(altacont.text_6.value),unil,140,"R" )
   unil:=unil+1
   pdfAtSay('COMISION MUNICIPAL DE AGUA POTABLE Y ALCANTARILLADO',unil,0,"R" )
   pdfImage( 'usuario.jpg', 248, 155, "M",30,30) // file, row, col, units, height, width
   pdfAtSay('USUARIO Y/O REPRESENTANTE LEGAL',unil,135,"R" )
   unil:=unil+9
   pdfAtSay(mcomercial,unil,2,"R" )
   pdfAtSay(mcontratos,unil,135,"R" )
   unil:=unil+1
   pdfAtSay('GERENTE COMERCIAL ( FIRMA Y SELLO ) ',unil,0,"R" )
   pdfAtSay('JEFE DEL DEPTO. DE CONTRATOS',unil,135,"R" )
   unil:=unil+1
   pdfAtSay('AUTORIZACIÓN',unil,17,"R" )
   pdfAtSay('REVISO',unil,152,"R" )
   unil:=unil+5
   pdfAtSay(tabcon[1],unil,0,"R" )
   pdfAtSay('_____________________________',unil,135,"R" )
   unil:=unil+1
   pdfAtSay('VALIDO UNICAMENTE CON SELLO Y FIRMA DE LA GERENCIA COMERCIAL',unil,0,"R" )
   pdfAtSay('VO BO  ELABORO',unil,145,"R" )
   pdfClose()
return

function ordcont
  /* parameters opcion
   declare window contrato
   select contrato
   do case
      case opcion =1
           set order to 1
	   mtit:='Buscar x # Contrato'
	   mlabel[1]:='# Contrato :'
	   mvalue[1]:=0
	   mformat[1]:="9999999"
      case opcion =2
           set order to 2
	   mtit:='Buscar x Nombre'
	   mlabel[1]:='Nombre :'
	   mvalue[1]:=space(40)
	   mformat[1]:=40
      case opcion =3
           set order to 3
	   mtit:='Buscar x Domicilio'+replicate('_',40)
	   mlabel[1]:='Domicilio :'
	   mvalue[1]:=space(40)
	   mformat[1]:=40
  endcase
  go top
  contrato.browse_1.value:=contrato->(recno())
  contrato.browse_1.refresh*/
return

function buscacontrato
    declare window contrato
	Local cTitle, aLabels, aInitValues, aFormats
	cTitle      := 'Busqueda de Contrato....            '
	aLabels     := {'# Contrato'} //, 'Field 2 (CheckBox):', 'Field 3 (ComboBox)', 'Field 4 (DatePicker)', 'Field 5 (Numeric masked TextBox)', 'Field 6 (Numeric TextBox for integers)', 'Field 7 (EditBox)', 'Field 8 (Grid)', 'Field 9 (PassWord)' }
	aInitValues := {''}//, .T., 0, Date(), 12.34, 0, 'Memo text', aGridValues, "" }
	aFormats    := { 8}//, Nil, {'Option 1','Option 2'}, Nil, '99.99', 10, 50, {aHeaders, aWidths}, "PASSWORD" }

	llaveb:=InputWindow(cTitle,aLabels,aInitValues,aFormats)
	MsgBox(llaveb[1],"")
    if empty(llaveb[1])
	contrato.grid_1.SetFocus 
       return
    endif
    if !left(llaveb[1],1) ='N' .or. !left(llaveb[1],1) ='n'
       mllaveb:=replicate("0",6-len(alltrim(llaveb[1])))+alltrim(llaveb[1])
    else
       mllaveb:=alltrim(llaveb[1])
    EndIf 
	MsgBox(mllaveb,"")
	cQuery := "select * From Contrato Where contrato= " + mllaveb
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
        return Nil
    EndIf 
	oRow := bQuery:GetRow(1)
		contrato.grid_1.DeleteAllItems()
		contrato.grid_1.AddItem({transform(oRow:FieldGet("contrato"),'999999'),dtoc(oRow:FieldGet("fecha")),alltrim(oRow:FieldGet("nombre")),;
				alltrim(oRow:FieldGet("Domicilio"))})
	contrato.grid_1.Refresh 
	contrato.grid_1.SetFocus 
    /*select contrato
    if mlabel[1] = '# Contrato :'
       seek mllaveb
    else
       seek upper(mllaveb)
    endif
    contrato.browse_1.value:=contrato->(recno())
    contrato.browse_1.setfocus
    contrato.browse_1.refresh*/
return

Function recarga()
cahora:=0
Return Nil

Function buscanumc()
cahora := val(inputbox("Dame el numero de la hoja a Mostrar"))
contrato.button_1.enabled:=.f.
contrato.button_2.enabled:=.f.
contrato.grid_1.enabled:=.F.
cargacontratos()
Return Nil