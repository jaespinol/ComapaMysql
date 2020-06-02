#include <hmg.ch>
#include <hfcl.ch>
#define REPORTPAGE    9

function ordenes
   public flagop:=1,debel:=0,pagosl:=0,numfor:=0,mrazon,mautor,cvetoma,mcvecol
   public mcontrato,mmedidor,musuario,impforma:=.f.,mcolonia:=space(30),mrecibo:=space(7),mtomas:=space(10),mmes,manio,mtrab:=0
   /*select nomaut
   set order to 2
   set filter to nomaut->estatus='A'
   go top
   select varios
   select varios*/
   acons:={}
   IF !IsWindowDefined(ordenes) 
       Load Window ordenes
		 //MsgBox("1","1")
       Center Window ordenes
       Activate Window ordenes
   endIf
return


Function oaumenta()

	ordenes.button_1.enabled:=.f.
	ordenes.button_2.enabled:=.f.
	ordenes.grid_1.enabled:=.f.
	//If iniord = .t.
	//MsgBox("3","3")
	//	oahora := ohojas
	//	iniord := .f.
		//cargaordenes()
	//Else 
	//MsgBox("4","4")
		oahora++
		cargaordenes()
	//MsgBox("2","2")//EndIf 
Return Nil

Function odisminuye()
oahora--
//MsgBox(oahora,"5")
ordenes.button_1.enabled:=.f.
ordenes.button_2.enabled:=.f.
ordenes.grid_1.enabled:=.F.
cargaordenes()
Return Nil

Function cargaordenes()
Declare Window ordenes
cQuery := "select numero, fecha, ruta, folio, nombre, domicilio From Varios Order By numero"
	bQuery := oServer:Query (cQuery)
	If bQuery:NetErr()
		Msgstop(bQuery:Error())
		Return Nil
	EndIf 
	ordenes.grid_1.DeleteAllItems()
	ohojas:= round(bQuery:LastRec()/3000,0)
	ordenes.label_1.Value := "Hoja"+str(oahora)+" / "+str(ohojas)
	ofilafin:=oahora*3000
	ofilaini:=ofilafin-3000
	ordenar:={}
 //x:=1
 //MsgBox(,"")
//If primer= 1
//MsgBox(bQuery:LastRec(),"6")
	For i := ofilaini To ofilafin //bQuery:LastRec() //
	//For i := 1 To bQuery:LastRec()
		If co=500
			doevents()
			co:=0
		EndIf 
		co++
		oRow := bQuery:GetRow(i)
		//MsgBox(oRow:FieldGet("numero"),bQuery:GetRow(i))
		If oRow:FieldGet("numero") > 0
			ordenes.grid_1.AddItem({transform(oRow:FieldGet("numero"),'999999'),dtoc(oRow:FieldGet("fecha")),oRow:FieldGet("ruta")+"-"+oRow:FieldGet("folio"),;
				alltrim(oRow:FieldGet("nombre")),alltrim(oRow:FieldGet("Domicilio"))})
			//aadd(ordenar,{x,oRow:FieldGet("nombre")})
			//x++
		EndIf 
			
	Next

//	muestrainf(1)
//	ahora:=1
bQuery:Destroy()
ordenes.button_1.enabled:=.t.
ordenes.button_2.enabled:=.t.
ordenes.grid_1.enabled:=.t.
//MsgBox(str(ahora),"")
//Padron.Grid_1.Refresh
Return Nil


function altaordent
   parameters flagop
	declare Window ordenes
   impforma:=.f.
   numfor:=0
   mtrab:=0
   mrecibo:=space(7)
   mcvecol:=space(3)
   mcolonia:=space(30)
   mcontrato:=space(7)
   mmedidor:=space(10)
  IF !IsWindowDefined(altaorden) 
       Load Window altaorden
		if flagop = 2
		//MsgBox(contrato.Grid_1.Value,"5")
	   	If ordenes.Grid_1.Value = 0
				oValue := ordenes.grid_1.item(1)
			Else
				oLinea := ordenes.Grid_1.Value 
				oValue := ordenes.Grid_1.Item (oLinea)
			EndIf
			pondatorden()
			//altaorden.button_3.visible:=.f.
			altaorden.text_14.setfocus
			habiord(.f.)
      EndIf 
		 Center Window altaorden
       Activate Window altaorden
   endIf
return

function buscuserord
   /*select capturis
   seek altaorden.text_14.value
   if found()
      if capturis->estatus='A'
         if capturis->clave = 'C' .or. capturis->clave ='S'
            mpermisos:=capturis->nivel
            altaorden.text_15.value:=capturis->nom_captur
         endif 
      else
         MsgInfo('El capturista esta dado de baja','Mensaje del Sistema')
         altaorden.text_14.value:=space(3)
         altaorden.text_14.setfocus
	 return
      endif
   else
      MsgInfo('El capturista no existe','Mensaje del Sistema')
      altaorden.text_14.value:=space(3)
      altaorden.text_14.setfocus
      return
   endif*/
   habiord(.t.)
return


function habiord
Declare Window altaorden
   parameters falgenabled
   //altaorden.datepicker_1.enabled:=falgenabled
   If falgenabled = .t.
		altaorden.text_2.readonly:=iif(!falgenabled,.t.,.f.)
		altaorden.text_3.readonly:=iif(!falgenabled,.t.,.f.)
		altaorden.text_5.readonly:=iif(!falgenabled,.t.,.f.)
		altaorden.text_12.readonly:=iif(!falgenabled,.t.,.f.)
		altaorden.text_7.readonly:=iif(!falgenabled,.t.,.f.)
		altaorden.text_8.readonly:=iif(!falgenabled,.t.,.f.)
		altaorden.text_9.readonly:=iif(!falgenabled,.t.,.f.)
		altaorden.text_10.readonly:=iif(!falgenabled,.t.,.f.)
		altaorden.text_11.readonly:=iif(!falgenabled,.t.,.f.)
		altaorden.text_13.readonly:=iif( !falgenabled,.t.,.f.)
		altaorden.text_6.readonly:=iif( !falgenabled,.t.,.f.)
		altaorden.text_4.readonly:=iif( !falgenabled,.t.,.f.)
		altaorden.combo_1.enabled:=falgenabled
		altaorden.combo_2.enabled:=falgenabled
		altaorden.combo_3.enabled:=falgenabled
		altaorden.button_1.enabled:=falgenabled
	EndIf 
return


function pondatorden
Declare Window altaorden
   if flagop = 2
		//select varios
      cQuery := "select * From Varios where numero=" + ovalue[1]
		bQuery := oServer:Query (cQuery)
		If bQuery:NetErr()
			Msgstop(bQuery:Error())
			Return Nil
		EndIf 
		If len(bQuery)=0
			MsgBox("No se encontro la Orden","Mensage del sistema")
			Return 
		EndIf 
		oRow := bQuery:GetRow(1)
      altaorden.text_1.value:=oRow:FieldGet("numero")
      altaorden.datepicker_1.value:=oRow:FieldGet("fecha")
      altaorden.text_2.value:=oRow:FieldGet("ruta")
      altaorden.text_3.value:=oRow:FieldGet("folio")
      altaorden.text_5.value:=oRow:FieldGet("nombre")
      altaorden.text_12.value:=oRow:FieldGet("domicilio")
      altaorden.text_7.value:=oRow:FieldGet("cantidad")
      altaorden.text_8.value:=oRow:FieldGet("observ1")
      altaorden.text_9.value:=oRow:FieldGet("observ2")
      altaorden.text_10.value:=oRow:FieldGet("observ3")
      altaorden.text_11.value:=oRow:FieldGet("observ4")
		//altaorden.text_13.value:=iif(oRow:FieldGet("num_calle")
      //altaorden.text_6.value:=oRow:FieldGet("cve_calle")
      numfor:=oRow:FieldGet("numformato")
      //altaorden.text_4.value:=oRow:FieldGet("contrato")
      //select areas
      //locate for areas->clave = varios->
      //if found()
      //   :=areas->(recno())
      //endif
		n:=1
			For n=1 To len(CatAre)
				If CatAre[n,1] = oRow:FieldGet("clve_area")
					altaorden.combo_1.value := n
					exit
				EndIf 
			Next
      /*select tpo_trab
      locate for tpo_trab->clave =  varios->
      if found()
         altaorden.combo_2.value:=tpo_trab->(recno())
      EndIf*/
		n:=1
			For n=1 To len(CatTtr)
				If CatTtr[n,1] = oRow:FieldGet("clve_trab")
					altaorden.combo_2.value := n
					exit
				EndIf 
			Next
      /*select nomaut
      locate for nomaut->clave = varios->
      if found()
         altaorden.combo_3.value:=nomaut->(recno())
      EndIf */
		n:=1
			For n=1 To len(CatTtr)
				If CatAut[n,1] = oRow:FieldGet("autorizo")
					altaorden.combo_3.value := n
					exit
				EndIf 
			Next
      //select varios
		bQuery:destroy()
   EndIf 
	
return

function bscapadrord
   declare window altaorden
   //select padron
   //seek altaorden.text_2.value+altaorden.text_3.value
   cQuery := "select Nombre, Domicilio, Colonia, Medidor, Contrato, Toma, tipo_usu From Padron where ruta=" + altaorden.text_2.Value + ' and folio=' + altaorden.text_3.value
	bQuery := oServer:Query (cQuery)
		If bQuery:NetErr()
			Msgstop(bQuery:Error())
			Return Nil
		EndIf 
		If len(bQuery)=0
			MsgBox("No se encontro al usuario","Mensage del sistema")
			altaorden.text_2.value:=space(3)
			altaorden.text_3.value:=space(4)
	      altaorden.text_2.SetFocus 
			Return 
		EndIf 
		oRow := bQuery:GetRow(1)
   altaorden.text_5.value:=oRow:FieldGet("Nombre")
   mcolonia:=oRow:FieldGet("colonia")
   *altaorden.text_12.value:=oRow:FieldGet("domicilio")
   mcontrato:=oRow:FieldGet("contrato")
   mmedidor:=oRow:FieldGet("medidor")
   //select tomas
   //seek padron->toma
   mtomas:=space(20)
   cvetoma:=space(2)
	n:=1
		For n=1 To len(CatDia)
			If CatDia[n,12] = oRow:FieldGet("toma")
				mtomas:=CatDia[n,13]
				cvetoma:=oRow:FieldGet("toma")
				exit
			EndIf 
		Next
   //select padron
   mcolonia:=space(30)
		if !empty(oRow:FieldGet("colonia"))
		  n:=1
			For n=1 To len(CatCol)
				If CatCol[n,1] = oRow:FieldGet("toma")
					mcvecol:=CatCol[n,1]
					mcolonia:=CatCol[n,2]
					exit
				EndIf 
			Next
		endif
   //select usuarios
   //seek padron->tipo_usu
	 n:=1
			For n=1 To len(CatUsu)
				If CatUsu[n,3] = oRow:FieldGet("tipo_usu")
					musuario:=CatUsu[n,2]
					
					exit
				EndIf 
			Next
   //select padron
   altaorden.text_4.readonly:=.t.
   altaorden.text_5.SetFocus 
	bQuery:Destroy()
return

function buscacontord
   declare window altaorden
   select contrato
   seek strzero(altaorden.text_4.value,6)
	 cQuery := "select Nombre, Domicilio, Colonia, Medidor, Contrato, Toma, tipo_usu From Padron where ruta=" + altaorden.text_2.Value + ' and folio=' + altaorden.text_3.value
	bQuery := oServer:Query (cQuery)
		If bQuery:NetErr()
			Msgstop(bQuery:Error())
			Return Nil
		EndIf 
		If len(bQuery)=0
			MsgBox("No se encontro el Contrato","Mensage del sistema")
			altaorden.text_4.value:= 0
	      altaorden.text_4.SetFocus 
			Return 
		EndIf 
		oRow := bQuery:GetRow(1)

   altaorden.text_5.value:=oRow:FieldGet("nombre")
//   select tomas
//   seek contrato->
	mtomas:=space(20)
   cvetoma:=space(2)
   if !empty(oRow:FieldGet("cve_toma"))
		n:=1
		For n=1 To len(CatDia)
			If CatDia[n,12] = oRow:FieldGet("cve_toma")
				mtomas:=CatDia[n,13]
				cvetoma:=CatDia[n,12]
				exit
			EndIf 
		Next
	endif
 
//   select contrato
	mcolonia:=space(30)
   if !empty(oRow:FieldGet("colonia"))
		n:=1
		For n=1 To len(CatCol)
			If CatCol[n,1] = oRow:FieldGet("colonia")
				mcvecol:=CatCol[n,1] //colonias->cve_col
				mcolonia:=CatCol[n,2] //colonias->des_col
				exit
			EndIf 
		Next
	EndIf 
   //select usuarios
   //seek contrato->
   if !empty(oRow:FieldGet("tipo_usu"))
		n:=1
		For n=1 To len(CatUsu)
			If CatUsu[n,3] = oRow:FieldGet("tipo_usu")
				musuario:=CatUsu[n,2] //des_usu
				exit
			EndIf 
		Next
	EndIf 
return

function pontpotraord
   /*declare window altaorden
   select tpo_trab
   set filter to tpo_trab->area = altaorden.combo_1.value
   go top
   altaorden.combo_2.refresh*/
return

function siesordbaja
  /* declare window altaorden
   if !sinadeudo()
      MsgInfo('El Usuario Tiene Adeudo, No Puede Ser Dado De Baja','Mensaje del Sistema')
      *altaorden.text_2.value:=space(3)
      *altaorden.text_3.value:=space(4)
      altaorden.text_2.setfocus
   endif*/
return

function sinadeudo
   /*declare window altaorden
   local dbfant
   retval:=.t.
   if altaorden.combo_2.value = 52 .or. altaorden.combo_2.value = 57
      if empty(altaorden.text_2.value) .or. empty(altaorden.text_3.value) 
         MsgInfo('Tiene que dar la localizacion','Mensaje del Sistema')
         altaorden.combo_2.setfocus
         return(retval)
      endif
      dbfant:=alias()
      select fact_ant
      set order to 1
      seek altaorden.text_2.value+altaorden.text_3.value
      if found()
         debel:=fact_ant->ad_total
      endif
      pagosl:=0
      select dia_pag
      set order to 2
      seek altaorden.text_2.value+altaorden.text_3.value
      if found()
         do while dia_pag->ruta + dia_pag->folio = altaorden.text_2.value+altaorden.text_3.value
            if dia_pag->ruta + dia_pag->folio = altaorden.text_2.value+altaorden.text_3.value
	       pagosl:=pagosl+dia_pag->pago_act
   	    endif
	    skip
         enddo
      endif
      select bonifica
      set order to 2
      seek altaorden.text_2.value+altaorden.text_3.value
      if found()
         do while bonifica->ruta + bonifica->folio = altaorden.text_2.value+altaorden.text_3.value
            if bonifica->ruta + bonifica->folio = altaorden.text_2.value+altaorden.text_3.value
	       pagosl:=pagosl+bonifica->pago_act
    	    endif
	    skip
         enddo
      endif
      select hist_pag
      set order to 1
      seek altaorden.text_2.value+altaorden.text_3.value
      if found()
         do while hist_pag->ruta + hist_pag->folio = altaorden.text_2.value+altaorden.text_3.value
            if hist_pag->ruta + hist_pag->folio = altaorden.text_2.value+altaorden.text_3.value .and. hist_pag->facturado = ' '
	       pagosl:=pagosl+hist_pag->pago_act
	    endif
  	    skip
         enddo
      endif
      select hist_bon
      set order to 1
      seek altaorden.text_2.value+altaorden.text_3.value
      if found()
         do while hist_bon->ruta + hist_bon->folio = altaorden.text_2.value+altaorden.text_3.value
            if hist_bon->ruta + hist_bon->folio = altaorden.text_2.value+altaorden.text_3.value .and. hist_bon->facturado = ' '
	       pagosl:=pagosl+hist_bon->pago_act
	    endif
	    skip
         enddo
      endif
      if pagosl <  debel
         retval:=.f.
         altaorden.button_1.enabled:=.f.
      else
         retval:=.t.
         altaorden.button_1.enabled:=.t.
      endif
      select &dbfant
   endif*/
return(retval)

function siesfactord
  /* declare window altaorden
   select tpo_trab
   seek altaorden.combo_2.value
   if tpo_trab->formato = '1'
      select varios
      *if pagosl >=  debel
          IF !IsWindowDefined(formato) 
             dbfant1:=alias()
             Load Window formato
	     formato.text_1.value:=tpo_trab->nombre
             formato.text_2.value:=month(date())
             formato.text_3.value:=year(date())
             formato.text_4.value:=altaorden.text_2.value+'-'+altaorden.text_3.value
	     formato.text_5.value:=altaorden.text_5.value
             formato.text_6.value:=alltrim(altaorden.text_12.value)+' '+alltrim(altaorden.text_13.value)
	     mtrab:=altaorden.combo_2.value
             formato.text_8.value:=mcontrato
	     formato.text_9.value:=mmedidor
             formato.text_10.value:=musuario
	     select nomaut
	     seek altaorden.combo_2.value
	     if found()
                formato.text_12.value:=nomaut->nombre
	     endif
	     select &dbfant1
             Center Window formato
             Activate Window formato
          endIf
      *endif
   endif*/
return

function ponbrowcalle
   parameters flagcalle
	
   IF !IsWindowDefined(browcalle) 
      Load Window browcalle
      cargacalles()
		Center Window browcalle
      Activate Window browcalle
   EndIf
return

function buscbrwcalle
    declare window browcalle
    //seek alltrim(browcalle.text_1.value)
    //browcalle.browse_1.value:=calles->(recno())
    //browcalle.browse_1.refresh
	//MsgBox("1","1")
	cQuery := "select nombre From Calles where nombre like '%" + browcalle.text_1.value + "%' order by nombre"
	bQuery := oServer:Query (cQuery)
	If bQuery:NetErr()
		Msgstop(bQuery:Error())
		Return Nil
	EndIf 
	//MsgBox(bQuery:LastRec(),"2")
	If bQuery:LastRec() > 0
		browcalle.grid_1.DeleteAllItems()
		//MsgBox(bQuery:LastRec(),"3")
		For i=1 To bQuery:LastRec()
			oRow := bQuery:GetRow(i)
			browcalle.grid_1.AddItem({upper(oRow:FieldGet("nombre"))})
		Next
	EndIf 
	

return

Function cargacalles()
	//browcalle.grid_1.DeleteAllItems()
	//For i=1 To len(CmbCll)
	//	browcalle.grid_1.AddItem({upper(CmbCll[i])})
	//Next
	cQuery := "select nombre From Calles order by nombre"
	bQuery := oServer:Query (cQuery)
	If bQuery:NetErr()
		Msgstop(bQuery:Error())
		Return Nil
	EndIf 
	//MsgBox(bQuery:LastRec(),"2")
	If bQuery:LastRec() > 0
		browcalle.grid_1.DeleteAllItems()
		//MsgBox(bQuery:LastRec(),"3")
		For i=1 To bQuery:LastRec()
			oRow := bQuery:GetRow(i)
			browcalle.grid_1.AddItem({upper(oRow:FieldGet("nombre"))})
		Next
	EndIf 
Return Nil

function pongetcalle
Local claLinea:=0, claValue:=""
   declare window browcalle
   declare window altaorden
	claLinea := browcalle.Grid_1.Value 
	claValue := browcalle.Grid_1.Item(claLinea)
	n:=1
	MsgBox(clavalue,len(CatCll))
		For n=1 To len(CatCll)
			MsgBox(alltrim(clavalue),alltrim(CatCll[n,2]))
			If alltrim(CatCll[n,2]) = alltrim(clavalue)
				altaorden.text_6.value:=CatCll[n,1]
				altaorden.text_12.value:=CatCll[n,2]
				exit
			EndIf 
		Next
   altaorden.text_13.setfocus
return

function buscclleordn
	declare window altaorden
   n:=1
	For n=1 To len(CatCll)
		If CatCll[n,1] = altaorden.text_6.value
			altaorden.text_12.Value := CatCll[n,2]
			Return 
		EndIf 
	Next
      MsgInfo('La calle no existe','Mensaje del Sistema')
      altaorden.text_6.value:=0
      altaorden.text_6.setfocus
return

function grabaorden
   declare window altaorden
   if flagop = 1
		cQuery := "insert into Varios (FECHA,RUTA,FOLIO,NOMBRE,DOMICILIO,OBSERV1,OBSERV2,OBSERV3,OBSERV4,"+;
		"AUTORIZO,CANTIDAD,CLVE_AREA,CLVE_TRAB,CAPTURIS) values ('" + cdate2mysqldate(altaorden.datepicker_1.value);
		+ "','" + altaorden.text_2.Value + "','" + altaorden.text_3.Value + "','" + altaorden.text_5.Value + "','" + altaorden.text_12.Value + ;
		"','" + altaorden.text_8.Value + "','" + altaorden.text_9.Value + "','" + altaorden.text_10.Value + "','" + ;
		altaorden.text_11.Value + "','" + ;
		strzero(altaorden.combo_3.value,2) + "'," + 	alltrim(str(altaorden.text_7.Value)) + "," + alltrim(str(altaorden.combo_1.Value)) + "," + alltrim(str(altaorden.combo_2.Value)) + ;
		",'" + altaorden.text_14.Value + "')"
//		insert into Varios (FECHA,    RUTA, FOLIO,  NOMBRE,                 DOMICILIO,     DEPTO,TRABAJO,OBSERV1,     OBSERV2,            OBSERV3,                 OBSERV4,                       CUMPLIDO,   OBSERVA5,LECTURA,MAYORDOMO,MEDIDOR,AUTORIZO,CANTIDAD,CLVE_AREA,CLVE_TRAB,CAPTURIS) values (
//								 2014-08-27,'010','3240','BARBARITA R DE GARCIA','JHSCJKHGXSCSD',' ',  ' ',    'YA DEBERIA','DE ESTAR JALANDO','ESTA COSA QUE LO UNICO','QUE HACE ES HACERME BATALLAR','1990-01-01',' ',     ' ',    ' ',      ' ',    '75',     **,      5,        5,        '')
		altaorden.edit_1.Value := cQuery	
   Else 
		//editar
      //select varios
      //do while .t.
      //   if varios->(rlock())
      //      exit
		//	endif
      //enddo
	cQuery := "Update Varios set FECHA='" + cdate2mysqldate(altaorden.datepicker_1.value);
	+ "',RUTA='" + altaorden.text_2.value;
	+ "',FOLIO='" + altaorden.text_3.value;
	+ "',NOMBRE='" + altaorden.text_5.value;
	+ "',DOMICILIO='" + altaorden.text_12.value;
	+ "',OBSERV1='" + altaorden.text_8.value;
	+ "',OBSERV2='" + altaorden.text_9.value;
	+ "',OBSERV3='" + altaorden.text_10.value;
	+ "',OBSERV4='" + altaorden.text_11.value;
	+ "',AUTORIZO='" + strzero(altaorden.combo_3.value,2);
	+ "',CANTIDAD=" + str(altaorden.text_7.value,2);
	+ ",CLVE_AREA=" + str(altaorden.combo_1.value);
	+ ",CLVE_TRAB=" + str(altaorden.combo_2.value);
	+ ",CAPTURIS='" + altaorden.text_14.value;
	+ "where NUMERO=" + altaorden.text_1.value
   EndIf 
		bQuery := oServer:Query (cQuery)
		If bQuery:NetErr()
			Msgstop(bQuery:Error())
			Return Nil
		EndIf 	
	/*numero:=altaorden.text_1.value
   fecha:=altaorden.datepicker_1.value
   ruta:=altaorden.text_2.value
   folio:=altaorden.text_3.value
   nombre:=altaorden.text_5.value
   domicilio:=altaorden.text_12.value
   clve_area:=altaorden.combo_1.value
   clve_trab:=altaorden.combo_2.value
   cantidad:=altaorden.text_7.value
   autorizo:=altaorden.combo_3.value
   observ1:=altaorden.text_8.value
   observ2:=altaorden.text_9.value
   observ3:=altaorden.text_10.value
   varios->observ4:=altaorden.text_11.value
   num_calle:=altaorden.text_13.value
   varios->cve_calle:=altaorden.text_6.value
   contrato:=strzero(altaorden.text_4.value,6)
   numformato:=numfor
   //(dbunlock())*/
	bQuery:Destroy()
	If !empty(altaorden.text_4.Value)
		If altaorden.combo_1.value = 1 .or. altaorden.combo_1.value = 4
	//      dbselectarea('contrato')
	//      seek strzero(altaorden.text_4.value,6)
			cQuery := "select * From Contrato where contrato='" + altaorden.text_4.Value + "'"
			bQuery := oServer:Query (cQuery)
			If bQuery:NetErr()
				Msgstop(bQuery:Error())
				Return Nil
			EndIf 
			//oRow := bQuery:GetRow(1)
			If len(bQuery)>0
				bQuery:Destroy()
				If altaorden.combo_2.value = 1 .or. altaorden.combo_1.value = 59
					cQuery := "Update Contrato set orden_agua=" + altaorden.text_1.value;
					+ "where contrato=" + altaorden.text_4.value
					 //contrato->orden_agua:=strzero(altaorden.text_1.value,6)
				ElseIf altaorden.combo_2.value =  12 .or. altaorden.combo_2.value = 18
					cQuery := "Update Contrato set orden_dren=" + altaorden.text_1.value;
					+ "where contrato=" + altaorden.text_4.value
					 contrato->orden_dren:=strzero(altaorden.text_1.value,6)
				EndIf 
			EndIf 
			/*if found()
				do while .t.
					if contrato->(rlock())
					 exit
					endif
				enddo*/
		EndIf 
	EndIf 
	/* llena la db del departamento de redes
	if flagop = 1
      if altaorden.combo_1.value = 1 .or. altaorden.combo_1.value = 4
         if altaorden.combo_2.value = 1 .or. altaorden.combo_2.value =  12 .or. altaorden.combo_2.value = 18
            do while .t.
               if abrearch('40',"consec","consec",{""},2,1)
                  exit
               endif
            enddo
            dbselectarea('consec')
            do while .t.
               if consec->(rlock())
                  foliored:=numero+1
   					consec->numero:=foliored
						consec->( DBCOMMIT() )
                  consec->(dbunlock())
   	          exit
               endif
            enddo
				consec->(dbclosearea())
            dbselectarea('trabajos')
				append blank
				trabajos->folio:=foliored
            trabajos->no_orden:=strzero(altaorden.text_1.value,8)
            trabajos->no_cont:=strzero(altaorden.text_4.value,8)
            trabajos->no_recibo:=mrecibo
				trabajos->fecha:=altaorden.datepicker_1.value
				trabajos->fte_info:='C'
				trabajos->codigo:='C'
				trabajos->nombre:=altaorden.text_5.value
				trabajos->cve_calle:=altaorden.text_6.value
            trabajos->no_calle:=altaorden.text_13.value
   			trabajos->colonia:=mcvecol
            trabajos->clave:=altaorden.combo_1.value
				trabajos->tel:=altaorden.text_13.value
				trabajos->toma:=cvetoma
            trabajos->desc_trab:=altaorden.combo_2.value
         endif
      endif
   endif
   altaorden.button_3.visible:=.t.
   altaorden.button_1.enabled:=.f.
   select varios*/
return

/*function grabaformato
   local dbfant
   declare window altaorden
   declare window formato
   if flagop = 1
      do while .t.
         select 50
         use foliosn exclu
         if !neterr()
            exit
         else
            loop
         endif
      enddo
      impforma:=.t.
      numfor:=formato+1
      foliosn->formato:=numfor
      foliosn->(dbcommit())
      foliosn->(dbunlock())
      dbselectarea('formato')
      foliosn->(dbclosearea())
      append blank
    else
      dbselectarea('formato')
      do while .t.
         if formato->(rlock())
	    exit
	 endif
      enddo
    endif
    if tpo_trab->formato ='1'
       impforma:=.t.
    endif
    formato->numero:=numfor 
    formato->fecha:=formato.datepicker_1.value
    formato->ruta:=altaorden.text_2.value
    formato->folio:=altaorden.text_3.value
    formato->razon_baja:=formato.text_11.value
    formato->recibo:=formato.text_14.value
    mrecibo:=formato.text_14.value
    mmes:=formato.text_2.value
    manio:=formato.text_3.value
    mrazon:=formato.text_11.value
    mautor:=formato.text_12.value
    formato->autorizo:=altaorden.combo_3.value
    formato->tipo_baja:=mtrab
    formato->(dbcommit())
    formato->(dbunlock())
    formato.release
    altaorden.button_1.enabled:=.t.
    select varios
return*/

function improrpdf
Local lin:=0, ruta:='c:\datos\'
   declare window altaorden
   declare window formato
   //local cRun, nWidth, nTab, nI, nJ, nK, nCol, nRow, aStyle, aFonts,unil:=8
   //local nTop, nLeft, nBottom, nRight,ruta:='f:\sca\documentos\ordenes\'
   //local nTop, nLeft, nBottom, nRight,
   /*local aColor := { ;
   "FF0000", "8B0000", "800000", "FF4500", "D2691E", "B8860B", "FF8C00", "FFA500", "DAA520", "808000", "FFD700", "FFFF00", "ADFF2F", "9ACD32", "7FFF00", "7CFC00", "00FF00", "32CD32", "008000", "006400",;
   "66CDAA", "7FFFD4", "87CEFA", "87CEEB", "F0F8FF", "E0FFFF", "B0C4DE", "B0E0E6", "AFEEEE", "ADD8E6", "8FBC8F", "90EE90", "98FB98", "00FA9A", "00FF7F", "3CB371", "2E8B57", "228B22", "556B2F", "6B8E23",;
   "5F9EA0", "40E0D0", "48D1CC", "00CED1", "20B2AA", "008B8B", "008080", "2F4F4F", "00BFFF", "00FFFF", "00FFFF", "0000FF", "0000CD", "00008B", "000080", "1E90FF", "4169E1", "4682B4", "6495ED", "7B68EE",;
   "C71585", "FF1493", "FF00FF", "FF00FF", "9370DB", "DDADDD", "DB7093", "FF69B4", "DA70D6", "EE82EE", "BA55D3", "9932CC", "8A2BE2", "9400D3", "8B008B", "800080", "4B0082", "191970", "483D8B", "6A5ACD",;
   "DC143C", "B22222", "A52A2A", "CD5C5C", "FA8072", "E9967A", "FFA07A", "F5DEB3", "FFDEAD", "EEE8AA", "FFDAB9", "FFE4C4", "FFEFD5", "FFE4E1", "FFE4B5", "D2B48C", "DEB887", "F0E68C", "BDB76B", "F4A460",;
   "FDF5E6", "FFF8DC", "FAF0E6", "FAFAD2", "FFFACD", "FFEBCD", "FFFFE0", "FAEBD7", "FFF5EE", "FFF0F5", "D8BFD8", "FFC0CB", "FFB6C1", "BC8F8F", "F08080", "FF7F50", "FF6347", "8B4513", "A0522D", "CD853F",;
   "FFFAFA", "FFFFF0", "E6E6FA", "FFFAF0", "F8F8FF", "F0FFF0", "F5F5DC", "F0FFFF", "F5FFFA", "708090", "778899", "F5F5F5", "DCDCDC", "D3D3D3", "C0C0C0", "A9A9A9", "808080", "696969", "000000", "FFFFFF"}*/
	//aReport := PdfInit()
   //archivopdf:=ruta+strzero(altaorden.text_1.value,7)+'.pdf'
   //nline:=24
   /*aStyle := { "Normal", "Bold", "Italic", "BoldItalic" }
   aFonts := { { "Times",     .t., .t., .t., .t. },;
               { "Helvetica", .t., .t., .t., .t. },;
               { "Courier",   .t., .t., .t., .t. } }*/
   nompdf:=ruta+strzero(altaorden.text_1.value,7)+'.pdf'
	delete file nompdf
	SELECT HPDFDOC nompdf TO lSuccess papersize HPDF_PAPER_LETTER ORIENTATION HPDF_ORIENT_LANDSCAPE
	SET HPDFDOC COMPRESS ALL
	SET HPDFDOC ENCODING TO "CP1252"
	If lSuccess == .T.
	msgstop("","")
		START HPDFDOC
			START HPDFPAGE
				SET HPDFDOC PAGEOUTLINE TITLE "ORDEN DE TRABAJO" 
				lin:=10
				n:=3
				aumento:=0
				@ 10,10 HPDFPRINT image "laredo.png" width 20 height 20
				@ 10,180 HPDFPRINT image "comapa.png" width 20 height 20
				@ lin,105 HPDFPRINT 'COMISION MUNICIPAL DE AGUA POTABLE Y ALCANTARILLADO DEL MUNICIPIO DE NUEVO LAREDO' font 'Times-Bold' size 12 center
				//lin:=lin + (n * 4)
				//pdfOpen( archivopdf, 200, .t.)
				//pdfEditOnHeader()
				//pdfEditOffHeader()
				//pdfBookOpen()
				//pdfNewPage( "MC", "P", 6 )
				//pdfBookAdd( "Orden de Trabajo", 1, aReport[ REPORTPAGE ], 0 )
				//pdfImage( 'laredo.jpg', 10, 10, "M",20,20) // file, row, col, units, height, width
				//pdfImage( 'comapa.jpg', 10, 180, "M",20,20) // file, row, col, units, height, width
				//pdfSetFont( "Times" , 1 , 12 )
				//pdfAtSay("COMISION MUNICIPAL DE AGUA POTABLE Y ALCANTARILLADO", 2,30, "R" )
				//pdfAtSay('                      DEL MUNICIPIO DE NUEVO LAREDO',4, 35, "R" )
				//pdfSetFont( "Times" , 1 , 14 )
				@lin,82 HPDFPRINT 'ORDEN DE TRABAJO' Font 'Times-Roman' Size 12 //pdfAtSay('ORDEN DE TRABAJO',unil,82,"R")
				lin:=lin+3
				//pdfSetFont( "Times" , 1 , 9 )
				@lin,0 HPDFPRINT 'FOLIO: ' + strzero(altaorden.text_1.value,7) Font 'Times-Roman' Size 9 //pdfAtSay('FOLIO : '+strzero(altaorden.text_1.value,7),unil,0,"R")
				@lin,130 HPDFPRINT 'NUEVO LAREDO, TAMP.  A '+ alltrim(str(day(altaorden.datepicker_1.value)))+' DE '+ upper(ames[month(altaorden.datepicker_1.value)]) +' '+ str(year(altaorden.datepicker_1.value),4) Font 'Times-Roman' Size 9 //pdfAtSay('NUEVO LAREDO, TAMP.  A '+ alltrim(str(day(altaorden.datepicker_1.value)))+' DE '+ upper(ames[month(altaorden.datepicker_1.value)]) +' '+ str(year(altaorden.datepicker_1.value),4),unil,130,"R")
				lin:=lin+2
				areaimp := altaorden.combo_1.item(altaorden.combo_1.value) //
				@lin,0 HPDFPRINT 'AL ' + areaimp Font 'Times-Roman' Size 9 //   pdfAtSay('AL '+ areas->nombre,unil,0,"R")
				lin:=lin+1 
				@lin,0 HPDFPRINT 'PRESENTE.' Font 'Times-Roman' Size 9 //pdfAtSay('PRESENTE.',unil,0,"R")
				lin:=lin+2
				@lin,0 HPDFPRINT 'SIRVASE CUMPLIR LA SIGUIENTE ORDEN DE TRABAJO, INFORMANDO DE SU EJECUCION A LA MAYOR BREVEDAD.' Font 'Times-Roman' Size 9 //pdfAtSay('SIRVASE CUMPLIR LA SIGUIENTE ORDEN DE TRABAJO, INFORMANDO DE SU EJECUCION A LA MAYOR BREVEDAD.',unil,0,"R")
				lin:=lin+1
				trabimp := altaorden.combo_2.item(altaorden.combo_2.value)
				@lin,0 HPDFPRINT trabimp Font 'Times-Roman' Size 9 //pdfAtSay(tpo_trab->nombre,unil,0,"R")
				lin:=lin+2
				if val(altaorden.text_2.value+altaorden.text_3.value) != 0
					@lin,0 HPDFPRINT "LOCALIZACION : "+alltrim(altaorden.text_2.value)+"-"+alltrim(altaorden.text_3.value) Font 'Times-Roman' Size 9 //pdfAtSay("LOCALIZACION : "+alltrim(altaorden.text_2.value)+"-"+alltrim(altaorden.text_3.value),unil,0,"R")
					@lin,90 HPDFPRINT 'MEDIDOR :'+mmedidor+' ____________________________________' Font 'Times-Roman' Size 9 //pdfAtSay('MEDIDOR :'+mmedidor+' ____________________________________',unil,90,"R")
					lin:=lin+1
				endif
				@lin,0 HPDFPRINT 'NOMBRE :'+altaorden.text_5.Value Font 'Times-Roman' Size 9 //pdfAtSay('NOMBRE :'+altaorden.text_5.value,unil,0,"R")
				if mcontrato != space(7)
					@lin,90 HPDFPRINT  'CONTRATO :'+ mcontrato Font 'Times-Roman' Size 9 //pdfAtSay('CONTRATO :'+mcontrato,unil,90,"R")
				endif
				lin:=lin+1
				@lin,0 HPDFPRINT 'DOMICILIO :' + altaorden.text_12.Value Font 'Times-Roman' Size 9 //pdfAtSay('DOMICILIO :'+altaorden.text_12.value,unil,0,"R")
				if !empty(mtomas)
					@lin,130 HPDFPRINT 'DIAMETRO :' + alltrim(mtomas) Font 'Times-Roman' Size 9 //pdfAtSay('DIAMETRO :'+alltrim(mtomas),unil,130,"R")
				endif
				lin:=lin+1
				if !empty(mcolonia)
					@lin,0 HPDFPRINT 'COLONIA :' + mcolonia Font 'Times-Roman' Size 9 // pdfAtSay('COLONIA :'+mcolonia,unil,0,"R")
				endif
				lin:=lin+2
				@lin,70 HPDFPRINT 'OBSERVACIONES' Font 'Times-Roman' Size 9 //pdfAtSay('OBSERVACIONES',unil,70,"R")
				lin:=lin+1
				@lin,0 HPDFPRINT altaorden.text_8.Value Font 'Times-Roman' Size 9 //pdfAtSay(altaorden.text_8.value,unil,0,"R")
				lin:=lin+1
				@lin,0 HPDFPRINT altaorden.text_9.Value Font 'Times-Roman' Size 9 //pdfAtSay(altaorden.text_9.value,unil,0,"R")
				if altaorden.combo_3.value = 41
					//@ 95,155 HPDFPRINT image "contratos.png" width 35 heigth 50 //pdfImage( 'contratos.jpg', 95, 155, "M",30,50) file, row, col, units, height, width
					@lin,150 HPDFPRINT 'JEFE DEL DEPTO. DE CONTRATOS' Font 'Times-Roman' Size 9 //pdfAtSay('JEFE DEL DEPTO. DE CONTRATOS',unil,150,"R")
				endif
				lin:=lin+1
				@lin,0 HPDFPRINT altaorden.text_10.Value Font 'Times-Roman' Size 9 //pdfAtSay(altaorden.text_10.value,unil,0,"R")
				lin:=lin+3
				@lin,20 HPDFPRINT 'RECIBI DE CONFORMIDAD' Font 'Times-Roman' Size 9 //pdfAtSay('RECIBI DE CONFORMIDAD',unil,20,"R")
				lin:=lin+2
			End HPDFPAGE
			if impforma
				START	HPDFPAGE
					SET HPDFDOC PAGEOUTLINE TITLE "FORMATO DE BAJA"
					lin:=10
					//pdfNewPage( "MC", "P", 6 )
					//pdfBookAdd( "Formato de Baja", 1, aReport[ REPORTPAGE ], 0 )
					//@lin,10 HPDFPRINT image "laredo.png" width 20 heigth 20 //pdfImage( 'laredo.jpg', 10, 10, "M",20,20) // file, row, col, units, height, width
					//@lin,180 HPDFPRINT image "comapa.png" width 20 heigth 20 //pdfImage( 'comapa.jpg', 10, 180, "M",20,20) // file, row, col, units, height, width
					//pdfSetFont( "Times" , 1 , 12 )
					lin:=lin-8
					@lin,30 HPDFPRINT "COMISION MUNICIPAL DE AGUA POTABLE Y ALCANTARILLADO"Font 'Times-Roman' Size 12 //pdfAtSay("COMISION MUNICIPAL DE AGUA POTABLE Y ALCANTARILLADO", 2,30, "R" )
					lin:=lin+2
					@lin,350 HPDFPRINT '                      DEL MUNICIPIO DE NUEVO LAREDO' Font 'Times-Roman' Size 12 //pdfAtSay('                      DEL MUNICIPIO DE NUEVO LAREDO',4, 35, "R" )
					lin:=lin+6
					//pdfSetFont( "Times" , 1 , 9 )
					@lin,130 HPDFPRINT 'NUEVO LAREDO, TAMP.  A '+ alltrim(str(day(altaorden.datepicker_1.value)))+' DE '+ upper(ames[month(altaorden.datepicker_1.value)]) +' '+ str(year(altaorden.datepicker_1.value),4) Font 'Times-Roman' Size 9 //pdfAtSay('NUEVO LAREDO, TAMP.  A '+ alltrim(str(day(altaorden.datepicker_1.value)))+' DE '+ upper(ames[month(altaorden.datepicker_1.value)]) +' '+ str(year(altaorden.datepicker_1.value),4),unil,130,"R")
					lin:=lin+1
					@lin,0 HPDFPRINT 'CIUDAD' Font 'Times-Roman' Size 9 //pdfAtSay('CIUDAD' ,unil,0,"R")
					lin:=lin+1
					@lin,0 HPDFPRINT 'Por medio de la presente solicito '+left(tpo_trab->nombre,30)+' de los servicios que  me presta  la COMISION ' Font 'Times-Roman' Size 9 //pdfAtSay('Por medio de la presente solicito '+left(tpo_trab->nombre,30)+' de los servicios que  me presta  la COMISION ' ,unil,0,"R")
					lin:=lin+1
					@lin,0 HPDFPRINT 'MUNICIPAL DE AGUA POTABLE Y ALCANTARILLADO, por no necesitar dicho servicio haste el momento; se aclara que' Font 'Times-Roman' Size 9 //pdfAtSay('MUNICIPAL DE AGUA POTABLE Y ALCANTARILLADO, por no necesitar dicho servicio haste el momento; se aclara que',unil,0,"R")
					lin:=lin+1
					@lin,0 HPDFPRINT 'la cuenta quedara hasta el mes de '+ames[mmes]+' del '+str(manio,4) Font 'Times-Roman' Size 9 //pdfAtSay('la cuenta quedara hasta el mes de '+ames[mmes]+' del '+str(manio,4),unil,0,"R")
					lin:=lin+2
					@lin,0 HPDFPRINT 'Mis datos son los siguientes:' Font 'Times-Roman' Size 9 //pdfAtSay('Mis datos son los siguientes:',unil,0,"R")
					lin:=lin+1
					@lin,0 HPDFPRINT 'Localizacion: '+altaorden.text_2.value+'-'+altaorden.text_3.Value Font 'Times-Roman' Size 9 //pdfAtSay('Localizacion: '+altaorden.text_2.value+'-'+altaorden.text_3.value,unil,0,"R")
					lin:=lin+1
					@lin,0 HPDFPRINT 'Nombre: '+altaorden.text_5.Value Font 'Times-Roman' Size 9 //pdfAtSay('Nombre: '+altaorden.text_5.value,unil,0,"R")
					lin:=lin+1
					@lin,0 HPDFPRINT 'Dirección: '+alltrim(altaorden.text_12.value)+' '+altaorden.text_13.Value Font 'Times-Roman' Size 9 //pdfAtSay('Dirección: '+alltrim(altaorden.text_12.value)+' '+altaorden.text_13.value,unil,0,"R")
					@lin,90 HPDFPRINT 'Colonia: '+mcolonia Font 'Times-Roman' Size 9 //pdfAtSay('Colonia: '+mcolonia,unil,90,"R")
					lin:=lin+1
					@lin,0 HPDFPRINT 'Contrato: ' + mcontrato Font 'Times-Roman' Size 9 //pdfAtSay('Contrato: '+mcontrato,unil,0,"R")
					@lin,90 HPDFPRINT 'Medidor: ' + mmedidor Font 'Times-Roman' Size 9 //pdfAtSay('Medidor: '+mmedidor,unil,90,"R")
					lin:=lin+1
					@lin,0 HPDFPRINT 'Tipo de Usuario: ' + musuario Font 'Times-Roman' Size 9 //pdfAtSay('Tipo de Usuario: '+musuario,unil,0,"R")
					lin:=lin+1
					@lin,0 HPDFPRINT 'Razon de la baja: ' + mrazon Font 'Times-Roman' Size 9 //pdfAtSay('Razon de la baja: '+mrazon,unil,0,"R")
					lin:=lin+1
					@lin,0 HPDFPRINT 'Pago con recibo No.: ' + mrecibo Font 'Times-Roman' Size 9 //pdfAtSay('Pago con recibo No.: '+mrecibo,unil,0,"R")
					lin:=lin+5
					@lin,18 HPDFPRINT 'Autorizo'Font 'Times-Roman' Size 9 //pdfAtSay('Autorizo',unil,18,"R")
					@lin,140 HPDFPRINT 'Autorizo'Font 'Times-Roman' Size 9 //pdfAtSay('Autorizo',unil,140,"R")
					lin:=lin+2
					@lin,0 HPDFPRINT mautor Font 'Times-Roman' Size 9 //pdfAtSay(mautor,unil,10,"R")
					@lin,130 HPDFPRINT altaorden.text_5.Value Font 'Times-Roman' Size 9 //pdfAtSay(altaorden.text_5.value,unil,130,"R")
					//@113,145 HPDFPRINT image "usuario.png" width 20 heigth 30
					//pdfImage( 'usuario.jpg', 113, 145, "M",20,30) // file, row, col, units, height, width
				End HPDFPAGE
			EndIf
	   End HPDFDOC
	EndIf 
	//pdfClose()
   //set date to FRENCH
return
