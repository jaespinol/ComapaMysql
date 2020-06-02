#include <hmg.ch>
#include "fileio.ch"
#include "hbssl.ch"
#include "directry.ch"
#include "inkey.ch"
#include "hfcl.ch"
#define CRLF HB_OSNewLine()

Function daumenta()
	declare Window diverso
	diverso.button_1.enabled:=.f.
	diverso.button_2.enabled:=.f.
	diverso.grid_1.enabled:=.f.
	dahora++
	cargagriddiv()
Return Nil

Function ddisminuye()
	declare Window diverso
	dahora--
	diverso.button_1.enabled:=.f.
	diverso.button_2.enabled:=.f.
	diverso.grid_1.enabled:=.F.
	cargagriddiv()
Return Nil

function diversos
   public flagop:=1,opflagdiv:=0,arcepto:={.f.,.f.,.f.,.f.,.f.}
   public cvepip:=0,mviajes:=0,mcap:=0,mvale:=0,arnumcepto:={'17','20','23','26','29'},arvalcepto:={0,0,0,0,0}
   public mtoma:='',musu:='',mfact2:='',mfact3:='',mfact4:='',mfact5:='',mfact6:='',mfact7:='',mfechapag:=ctod('  /  /    ')
   public mordagua:='',morddren:='',cadorg:='||2.2|',cademp1:='',cademp2:='',cademp3:='',efolion:=0,mrfc:='',mcp:='',nconceptos:=0,arrayconceptos:={}
   public cStringcorg
   ERR_load_PEM_strings()
   OpenSSL_add_all_algorithms()
   set decimals to 6
   mpermisos:=' '
   IF !IsWindowDefined(diverso) 
       Load Window diverso
		 daumenta()
       Center Window diverso
       Activate Window diverso
   endIf
return

Function cargagriddiv()
//fields {'diverso->numero','dtoc(diverso->fecha)','diverso->nombre','diverso->domicilio'}
//Heathers {'# Recibo','Fecha','Nombre','Domicilio'}
//widths {90,80,300,300}
//ondblclick altadiv(2)
	Declare Window diverso
	cQuery := "select numero, fecha, nombre, domicilio From Diversos Order By numero desc"
	bQuery := oServer:Query (cQuery)
	If bQuery:NetErr()
		Msgstop(bQuery:Error())
		Return Nil
	EndIf 
	diverso.grid_1.DeleteAllItems()
	dhojas:= round(bQuery:LastRec()/3000,0)
	diverso.label_1.Value := "Hoja"+str(dahora)+" / "+str(dhojas)
		dfilafin:=dahora*3000
		dfilaini:=dfilafin-3000
	cn:=0
	x:=1
	For i := dfilaini To dfilafin //bQuery:LastRec() //
		If cn=500
			doevents()
			cn:=0
		EndIf 
		cn++
		oRow := bQuery:GetRow(i)
		If oRow:FieldGet("numero") > 0
			diverso.grid_1.AddItem({transform(oRow:FieldGet("numero"),"9999999"),dtoc(oRow:FieldGet("fecha")),;
				alltrim(oRow:FieldGet("nombre")),alltrim(oRow:FieldGet("Domicilio"))})
		EndIf 
			
	Next
	bQuery:Destroy()
	diverso.button_1.enabled:=.t.
	diverso.button_2.enabled:=.t.
	diverso.grid_1.enabled:=.t.
return


function altadiv
   parameters flagop
	declare Window diverso
   arcepto:={.f.,.f.,.f.,.f.,.f.}
   arvalcepto:={0,0,0,0,0}
   mviajes:=0
   cvepip:=0
   musu:=''
   mtoma:=space(10)
   mcap:=0
   mvale:=0
   mordagua:=''
   morddren:=''
   IF !IsWindowDefined(altadiverso) 
      Load Window altadiverso
      if flagop = 1
         altadiverso.button_1.enabled:=.f.
      else
         altadiverso.button_1.enabled:=.t.
			dLinea := diverso.Grid_1.Value 
			dValue := diverso.Grid_1.Item (dLinea)
			tmpdivnom := val(dvalue[1])
      endif
      altadiverso.button_6.enabled:=.f.
      altadiverso.button_3.enabled:=.f.
      habilitadiv(.F.)
      Center Window altadiverso
      Activate Window altadiverso
   endIf
return

function pondatosdiv
   declare window altadiverso
   arrayconceptos:={}
   nconceptos:=0
   if flagop = 2
      altadiverso.button_1.enabled:=.t.
		altadiverso.text_3.Value := tmpdivnom
/*      cQuery := "select D.*,"+;
				"(select P.tipo_usu from Padron as P where D.RUTA = P.RUTA and D.folio = P.FOLIO) as p_usuario," +;
				"(select C.TIPO_USU from Contrato as C where C.contrato=D.contrato) as c_usuario," +;
				"(select P.toma from Padron as P where D.RUTA = P.RUTA and D.folio = P.FOLIO) as p_toma," +;
				"(select C.CVE_TOMA from Contrato as C where C.contrato=D.contrato) as c_toma " +;
				"FROM Diversos AS D where D.numero=" + str(altadiverso.text_3.Value)*/
	  cQuery :=  "select D.*," +;
				"(select P.tipo_usu from Padron as P where D.RUTA = P.RUTA and D.folio = P.FOLIO) as p_usuario," +;
				"(select C.TIPO_USU from Contrato as C where C.contrato=D.contrato) as c_usuario," +;
				"(select P.toma from Padron as P where D.RUTA = P.RUTA and D.folio = P.FOLIO) as p_toma," +;
				"(select C.CVE_TOMA from Contrato as C where C.contrato=D.contrato) as c_toma,K.*," +;
				"(select G.fecha_ven from Pagares as G where G.PAGARE =D.PAGARE) as g_Fechavenc " +;
				"FROM Diversos AS D, Diversod as K where D.numero="+ str(altadiverso.text_3.Value) + " and K.NUMEROD=D.NUMERO"
		bQuery := oServer:Query (cQuery)
		If bQuery:NetErr()
			Msgstop(bQuery:Error())
			Return Nil
		EndIf
		oRow := bQuery:GetRow(bQuery:LastRec())
		MsgBox(bquery,"")
		/*If len(bQuery)=0
			MsgInfo('El usuario no existe','Mensaje del Sistema')
			altapagare.text_5.value:=space(3)
			altapagare.text_6.value:=space(4)
			altapagare.text_5.setfocus
			Return 
		EndIf */
		//select diverso
      altadiverso.text_3.value:=oRow:FieldGet("numero") //val(diverso->)
      altadiverso.datepicker_1.value:=oRow:FieldGet("fecha") //diverso->
      altadiverso.text_7.value:=oRow:FieldGet("pagare") //diverso->
      altadiverso.text_4.value:=oRow:FieldGet("contrato") //diverso->
      altadiverso.text_5.value:=oRow:FieldGet("ruta") //diverso->
      altadiverso.text_6.value:=oRow:FieldGet("folio") //diverso->
      altadiverso.text_9.value:=oRow:FieldGet("nombre") //diverso->
      altadiverso.text_10.value:=oRow:FieldGet("domicilio") //diverso->
      altadiverso.text_11.value:=oRow:FieldGet("colonia") //diverso->
	  if empty(oRow:FieldGet("rfc")) //diverso->)
         mrfc:="XAXX010101000"
		 altadiverso.text_12.value:="XAXX010101000"
      else
         altadiverso.text_12.value:=oRow:FieldGet("rfc") //diverso->
         mrfc:=oRow:FieldGet("rfc") //diverso->rfc
	  endif
      mviajes:=oRow:FieldGet("viajes") //diverso->
      mcap:=oRow:FieldGet("capacidad") //diverso->
      cvepip:=oRow:FieldGet("pipero") //diverso->
      altadiverso.text_13.value:=oRow:FieldGet("subtotal") //diverso->
      altadiverso.text_15.value:=oRow:FieldGet("iva") //diverso->
      altadiverso.text_14.value:=iif(oRow:FieldGet("iva")= 0,0,16) //diverso-> 
      altadiverso.text_16.value:=oRow:FieldGet("total") //diverso->
      altadiverso.text_32.value:=oRow:FieldGet("numero_c") //diverso->
      musu:=''
      mtoma:=space(10)
	  if !empty(altadiverso.text_4.Value) //diverso->)
			musu:=oRow:FieldGet("c_usuario")
            mtoma:=oRow:FieldGet("c_toma")
      elseif !empty(altadiverso.text_5.value) .and. !empty(altadiverso.text_6.value)
			musu:=oRow:FieldGet("p_usuario")
            mtoma:=oRow:FieldGet("p_toma")
      endif
      if !empty(altadiverso.text_7.value)
		mfechapag:=oRow:FieldGet("g_fecha_vec")
      EndIf 
	  n:=1
	  For n=1 To len(cataut)
			If cataut[n,1] = oRow:FieldGet("Formulo")
				altadiverso.combo_1.Value := n
				exit
			EndIf 
	  Next
	  For e=1 To bQuery:LastRec()
		oRow := bQuery:GetRow(e)
		Do Case 
			Case e=1
				  altadiverso.text_17.value:=oRow:FieldGet("cve_cpto")
		          altadiverso.text_18.value:=oRow:FieldGet("nombred")
		          if oRow:FieldGet("iva") > 0
		             altadiverso.text_19.value:=oRow:FieldGet("cantidad")/(1+altadiverso.text_14.value/100)
		          else
                     altadiverso.text_19.value:=oRow:FieldGet("cantidad")
		          endif
			Case e=2
				  altadiverso.text_20.value:=oRow:FieldGet("cve_cpto")
		          altadiverso.text_21.value:=oRow:FieldGet("nombred")
		          if oRow:FieldGet("iva") > 0
		             altadiverso.text_22.value:=oRow:FieldGet("cantidad")/(1+altadiverso.text_14.value/100)
		          else
                     altadiverso.text_22.value:=oRow:FieldGet("cantidad")
		          endif
			Case e=3
				  altadiverso.text_23.value:=oRow:FieldGet("cve_cpto")
		          altadiverso.text_24.value:=oRow:FieldGet("nombred")
		          if oRow:FieldGet("iva") > 0
		             altadiverso.text_25.value:=oRow:FieldGet("cantidad")/(1+altadiverso.text_14.value/100)
		          else
                     altadiverso.text_25.value:=oRow:FieldGet("cantidad")
		          endif
			Case e=4
				  altadiverso.text_26.value:=oRow:FieldGet("cve_cpto")
		          altadiverso.text_27.value:=oRow:FieldGet("nombred")
		          if oRow:FieldGet("iva") > 0
		             altadiverso.text_28.value:=oRow:FieldGet("cantidad")/(1+altadiverso.text_14.value/100)
		          else
                     altadiverso.text_28.value:=oRow:FieldGet("cantidad")
		          endif
			Case e=5
				  altadiverso.text_29.value:=oRow:FieldGet("cve_cpto")
		          altadiverso.text_30.value:=oRow:FieldGet("nombred")
		          if oRow:FieldGet("iva") > 0
		             altadiverso.text_31.value:=oRow:FieldGet("cantidad")/(1+altadiverso.text_14.value/100)
		          else
                     altadiverso.text_31.value:=oRow:FieldGet("cantidad")
		          endif
		EndCase 
	  Next
	  bQuery:Destroy()
      /*select diversod
      seek strzero(altadiverso.text_3.value,7)
      if found()
         vara:=0
         do while diversod->numero = strzero(altadiverso.text_3.value,7)
            if diversod->numero = strzero(altadiverso.text_3.value,7)
 	           vara++
	           if arnumcepto[vara] ='17'
                  altadiverso.text_17.value:=diversod->cve_cpto
		          altadiverso.text_18.value:=diversod->nombre
		          if diverso->iva > 0
		             altadiverso.text_19.value:=diversod->cantidad/multiva
		          else
                     altadiverso.text_19.value:=diversod->cantidad
		          endif
				  aadd(arrayconceptos,{'1','Servicio',diversod->cve_cpto,diversod->nombre,alltrim(transform( altadiverso.text_19.value ,"9999999999.99")),alltrim(transform( altadiverso.text_19.value ,"9999999999.99"))})
		          nconceptos:=nconceptos+1
	           elseif arnumcepto[vara] ='20'
                  altadiverso.text_20.value:=diversod->cve_cpto
		          altadiverso.text_21.value:=diversod->nombre
 		          if diverso->iva > 0
	 	             altadiverso.text_22.value:=diversod->cantidad/multiva
		          else
                     altadiverso.text_22.value:=diversod->cantidad
		          endif
				  aadd(arrayconceptos,{'1','Servicio',diversod->cve_cpto,diversod->nombre,alltrim(transform( altadiverso.text_22.value ,"9999999999.99")),alltrim(transform( altadiverso.text_22.value ,"9999999999.99"))})
		          nconceptos:=nconceptos+1
	          elseif arnumcepto[vara] ='23'
                 altadiverso.text_23.value:=diversod->cve_cpto
		         altadiverso.text_24.value:=diversod->nombre
 		         if diverso->iva > 0
	 	            altadiverso.text_25.value:=diversod->cantidad/multiva
		         else
                    altadiverso.text_25.value:=diversod->cantidad
		         endif
				 aadd(arrayconceptos,{'1','Servicio',diversod->cve_cpto,diversod->nombre,alltrim(transform( altadiverso.text_25.value ,"9999999999.99")),alltrim(transform( altadiverso.text_25.value ,"9999999999.99"))})
		         nconceptos:=nconceptos+1
	          elseif arnumcepto[vara] ='26'
                 altadiverso.text_26.value:=diversod->cve_cpto
		         altadiverso.text_27.value:=diversod->nombre
 		         if diverso->iva > 0
	 	            altadiverso.text_28.value:=diversod->cantidad/multiva
		         else
                    altadiverso.text_28.value:=diversod->cantidad
		         endif
				 aadd(arrayconceptos,{'1','Servicio',diversod->cve_cpto,diversod->nombre,alltrim(transform( altadiverso.text_28.value ,"9999999999.99")),alltrim(transform( altadiverso.text_28.value ,"9999999999.99"))})
		         nconceptos:=nconceptos+1
      	      elseif arnumcepto[vara] ='29'
                 altadiverso.text_29.value:=diversod->cve_cpto
		         altadiverso.text_30.value:=diversod->nombre
 		         if diverso->iva > 0
	 	            altadiverso.text_31.value:=diversod->cantidad/multiva
		         else
                    altadiverso.text_31.value:=diversod->cantidad
		         endif
				 aadd(arrayconceptos,{'1','Servicio',diversod->cve_cpto,diversod->nombre,alltrim(transform( altadiverso.text_31.value ,"9999999999.99")),alltrim(transform( altadiverso.text_31.value ,"9999999999.99"))})
		         nconceptos:=nconceptos+1
	          endif
     	   endif
	       skip
        enddo
     endif
	 select ediverso 
	 seek strzero(altadiverso.text_3.value,7)
     if !found()
	    altadiverso.button_9.visible:=.t.
     endif	 
     select diverso*/
  ENDIF
return


function grabadiverso
  /* declare window altadiverso
   if empty(altadiverso.text_9.value)
      MsgInfo('Tiene que dar un nombre antes de grabar','Mensaje del Sistema')
      return
   endif
   if empty(altadiverso.combo_1.value)
      MsgInfo('Tiene que dar quien realizo','Mensaje del Sistema')
      return
   endif
   if empty(altadiverso.text_10.value)
      MsgInfo('Tiene que dar un domicilio antes de grabar','Mensaje del Sistema')
      return
   endif
   if altadiverso.text_13.value = 0
      if !Msgyesno('El subtotal esta en ceros desea continuar?','Mensaje del Sistema')
	     return
	  endif
   endif
   if !empty(altadiverso.text_12.value)
      if len(alltrim(STRTRAN(altadiverso.text_12.value,'-',''))) < 12 .or. len(alltrim(STRTRAN(altadiverso.text_12.value,'-',''))) > 13
         MsgInfo('El RFC no es valido','Mensaje del Sistema')
         return
      endif
   endif 
   if altadiverso.text_17.value =  '04' .or. altadiverso.text_17.value = '06' 
      if empty(altadiverso.text_7.value)
         MsgInfo('No tiene numero de DOCUMENTO','Mensaje del Sistema')
         altadiverso.text_7.setfocus
	 return
      endif
   elseif altadiverso.text_20.value='04' .or. altadiverso.text_20.value='06'
      if empty(altadiverso.text_7.value)
         MsgInfo('No tiene numero de DOCUMENTO','Mensaje del Sistema')
         altadiverso.text_7.setfocus
	 return
      endif
   elseif altadiverso.text_23.value='04' .or. altadiverso.text_23.value='06'
      if empty(altadiverso.text_7.value)
         MsgInfo('No tiene numero de DOCUMENTO','Mensaje del Sistema')
         altadiverso.text_7.setfocus
	 return
      endif
   elseif altadiverso.text_26.value='04' .or. altadiverso.text_26.value='06'
      if empty(altadiverso.text_7.value)
         MsgInfo('No tiene numero de DOCUMENTO','Mensaje del Sistema')
         altadiverso.text_7.setfocus
	 return
      endif
   elseif altadiverso.text_29.value='04' .or. altadiverso.text_29.value='06'
      if empty(altadiverso.text_7.value)
         MsgInfo('No tiene numero de DOCUMENTO','Mensaje del Sistema')
         altadiverso.text_7.setfocus
	 return
      endif
   endif
   if flagop = 1
      select 60
      do while .t.
         use foliosn exclu
	     if !neterr()
	       exit
         endif
      enddo
      altadiverso.text_3.value:=foliosn->diversos+1
      foliosn->diversos:=altadiverso.text_3.value
      dbselectarea('foliosn')
      foliosn->(dbclosearea())
      select diverso
      append blank 
   else
      do while .t.
         if diverso->(rlock())
            exit
	     endif
      enddo
   endif
   diverso->numero:=strzero(altadiverso.text_3.value,7)
   diverso->fecha:=altadiverso.datepicker_1.value
   diverso->pagare:=altadiverso.text_7.value
   diverso->ruta:=altadiverso.text_5.value
   diverso->folio:=altadiverso.text_6.value
   diverso->nombre:=altadiverso.text_9.value
   diverso->domicilio:=altadiverso.text_10.value
   diverso->colonia:=altadiverso.text_11.value
   diverso->rfc:=altadiverso.text_12.value
   diverso->contrato:=altadiverso.text_4.value
   diverso->viajes:=mviajes
   diverso->capacidad:=mcap
   diverso->pipero:=cvepip
   diverso->subtotal:=altadiverso.text_13.value
   diverso->iva:=altadiverso.text_15.value
   diverso->total:=altadiverso.text_16.value
   diverso->formulo:=altadiverso.combo_1.value
   diverso->pagado:=altadiverso.text_1.value
   diverso->numero_c:=altadiverso.text_32.value
   diverso->(dbcommitall())
   diverso->(dbunlock())
   select diversod
   if flagop = 2
      seek strzero(altadiverso.text_3.value,7)
      do while diversod->numero = strzero(altadiverso.text_3.value,7)
         if diversod->numero = strzero(altadiverso.text_3.value,7)
	    do while .t.
               if diversod->(rlock())
                  delete
                  exit
  	       endif
	    enddo
	 endif
	 skip
      enddo
   endif
   nconceptos:=0
   arrayconceptos:={}
   if !empty(altadiverso.text_17.value)
      append blank
      diversod->numero:=strzero(altadiverso.text_3.value,7)
      diversod->cve_cpto:=altadiverso.text_17.value
      diversod->nombre:=altadiverso.text_18.value
      diversod->cantidad:=arvalcepto[1]
	  aadd(arrayconceptos,{'1','Servicio',diversod->cve_cpto,diversod->nombre,alltrim(transform( altadiverso.text_19.value ,"9999999999.99")),alltrim(transform( altadiverso.text_19.value ,"9999999999.99"))})
	  nconceptos:=nconceptos+1
   endif
   if !empty(altadiverso.text_20.value)
      append blank
      diversod->numero:=strzero(altadiverso.text_3.value,7)
      diversod->cve_cpto:=altadiverso.text_20.value
      diversod->nombre:=altadiverso.text_21.value
      diversod->cantidad:=arvalcepto[2]
	  aadd(arrayconceptos,{'1','Servicio',diversod->cve_cpto,diversod->nombre,alltrim(transform( altadiverso.text_22.value ,"9999999999.99")),alltrim(transform( altadiverso.text_22.value ,"9999999999.99"))})
	  nconceptos:=nconceptos+1
   endif
   if !empty(altadiverso.text_23.value)
      append blank
      diversod->numero:=strzero(altadiverso.text_3.value,7)
      diversod->cve_cpto:=altadiverso.text_23.value
      diversod->nombre:=altadiverso.text_24.value
      diversod->cantidad:=arvalcepto[3]
	  aadd(arrayconceptos,{'1','Servicio',diversod->cve_cpto,diversod->nombre,alltrim(transform( altadiverso.text_25.value ,"9999999999.99")),alltrim(transform( altadiverso.text_25.value ,"9999999999.99"))})
	  nconceptos:=nconceptos+1
   endif
   if !empty(altadiverso.text_26.value)
      append blank
      diversod->numero:=strzero(altadiverso.text_3.value,7)
      diversod->cve_cpto:=altadiverso.text_26.value
      diversod->nombre:=altadiverso.text_27.value
      diversod->cantidad:=arvalcepto[4]
	  aadd(arrayconceptos,{'1','Servicio',diversod->cve_cpto,diversod->nombre,alltrim(transform( altadiverso.text_28.value ,"9999999999.99")),alltrim(transform( altadiverso.text_28.value ,"9999999999.99"))})
	  nconceptos:=nconceptos+1
   endif
   if !empty(altadiverso.text_29.value)
      append blank
      diversod->numero:=strzero(altadiverso.text_3.value,7)
      diversod->cve_cpto:=altadiverso.text_29.value
      diversod->nombre:=altadiverso.text_30.value
      diversod->cantidad:=arvalcepto[5]
	  aadd(arrayconceptos,{'1','Servicio',diversod->cve_cpto,diversod->nombre,alltrim(transform( altadiverso.text_31.value ,"9999999999.99")),alltrim(transform( altadiverso.text_31.value ,"9999999999.99"))})
	  nconceptos:=nconceptos+1
   endif
   diversod->(dbcommitall())
   diversod->(dbunlock())
   mrfc:=''
   if empty(altadiverso.text_12.value)
      mrfc:="XAXX010101000"
   else
      mrfc:=alltrim(STRTRAN(altadiverso.text_12.value,'-',''))
      if len(mrfc) < 12
         mrfc:="XAXX010101000"
      elseif len(mrfc) > 13
         mrfc:="XAXX010101000"
      endif
   endif
   mcp:='88000'
   if !empty(altadiverso.text_32.value)
      mcp:=altadiverso.text_32.value
   endif
   if flagop = 1
      generarcfdi()
   endif
   habilitadiv(.f.)
   altadiverso.button_1.enabled:=.t.
   altadiverso.button_3.enabled:=.f.
   altadiverso.button_6.enabled:=.f.
   imprimediverso()*/
return

function generarcfdi
  /* if flagop==2
      select hist_otr
      set order to 2
      seek diverso->numero
      if !found()
	     select dia_pag
		 set order to 3
		 seek diverso->numero
		 if !found()
			Msginfo("El recibo diverso no esta pagado, imposible generar","Mensaje del sistema")
		    return
	     endif
      endif
   endif
   select empresas
   nfactura:=alltrim(str(val(diverso->numero)))
   tipo:='cfdi:'
   seriefac:='DIV'
   foliofac:=diverso->numero
   vsubtotal:=alltrim(str(diverso->subtotal))
   totalfac:=alltrim(str(diverso->total))
   descuento:=''
   motivodescuento:=''
   tipocambio:=''
   moneda:=''
   tipodecomprobante:='ingreso'
   formadepago:='Pago en una sola exhibicion'
   nconceptos:=nconceptos
   arrayconceptos:=arrayconceptos
   totalimpuestostrasladados:=''
   totalimpuestosretenidos:=''
   traslados:={}
   aadd(traslados,{'IVA',transform(altadiverso.text_14.value,'99.99'),transform(altadiverso.text_15.value,'999999999.99')})
   retenciones:={}
   mpago:='No identificado'
   nscuenta:=''
   lugarexpedicion:='Matriz'
   rfcemisor:=empresas->rfc
   nombreemisor:=empresas->nombre
   calleemisor:=empresas->domicilio
   noexterioremisor:=empresas->num_ext
   nointerioremisor:=''
   coloniaemisor:=empresas->colonia
   localidademisor:=empresas->localidad
   municipioemisor:=empresas->municipio
   estadoemisor:=empresas->estado
   paisemisor:=empresas->pais
   cpemisor:=empresas->codpost
   calleexpedido:=''
   noexteriorexpedido:=''
   nointeriorexpedido:=''
   coloniaexpedido:=''
   localidadexpedido:=''
   municipioexpedido:=''
   estadoexpedido:=''
   paisexpedido:=''
   cpexpedido:=''
   nocertificado:=empresas->nocertific
   certificado:=empresas->certificad
   condicionesdepago:=''
   regimenfac:={}
   aadd(regimenfac,alltrim(empresas->regimen))
   fincertificado:=empresas->fecfincer
   horafincer:=empresas->hrfincer
   rfcreceptor:=mrfc
   nombrereceptor:=''
   callereceptor:=''
   noexteriorreceptor:=''
   nointeriorreceptor:=''
   coloniareceptor:=''
   municipioreceptor:=''
   estadoreceptor:=''
   paisreceptor:=''
   cpreceptor:=''
   uspac:=empresas->uspac
   passpac:=HB_STRTOUTF8(empresas->passpac)
   select 60
   timbre:=0
   do while .t.
      use timbres exclu
	  if !neterr()
	     exit
      endif
   enddo
   if (timbres->usados + 1) > timbres->disploc
      MsgInfo('No hay mas timbres avisar a sistemas','Mensaje del Sistema')
      enviacorreo(alltrim(empresas->notifica),'Notificación de timbrado','No hay ningun timbre disponible')
      habilitadiv(.f.)
      altadiverso.button_1.enabled:=.t.
	  altadiverso.button_3.enabled:=.f.
	  altadiverso.button_6.enabled:=.f.
	  altadiverso.button_9.visible:=.t.
	  dbselectarea('timbres')
      timbres->(dbclosearea())
	  select diverso
      return
   endif
   if date()+30>=timbres->expiran .and. timbres->notfec==.f.
      enviacorreo(alltrim(empresas->notifica),'Notificacion de timbrado','Lo timbres estan por expirar, expirara el dia: '+dtoc(timbres->expiran))
      timbres->notfec:=.t.	
   endif
   if (timbres->disploc - timbres->usados) <= 2000 .and. timbres->notifica1==.f.
	  enviacorreo(alltrim(empresas->notifica),'Notificacion de timbrado','Lo timbres se estan agotando quedan: '+alltrim(str(timbres->disploc - timbres->usados)))
      timbres->notifica1:=.t.			
   endif
   if (timbres->disploc - timbres->usados) <= 1000 .and. timbres->notifica2==.f.
      enviacorreo(alltrim(empresas->notifica),'Notificacion de timbrado','Lo timbres se estan agotando quedan: '+alltrim(str(timbres->disploc - timbres->usados)))
      timbres->notifica2:=.t.			
   endif
   if (timbres->disploc - timbres->usados) <= 500 .and. timbres->notifica3==.f.
	  enviacorreo(alltrim(empresas->notifica),'Notificacion de timbrado','Lo timbres se estan agotando quedan: '+alltrim(str(timbres->disploc - timbres->usados)))
      MsgInfo('Avisar a sistemas que hay que pedir mas timbres quedan: '+alltrim(str(timbres->disploc - timbres->usados)),'Mensaje del Sistema')
      timbres->notifica3:=.t.			
   endif
   timbres->(dbclosearea())
   select diverso
   if !creafactelec(tipo,nfactura,seriefac,foliofac,vsubtotal,totalfac,descuento,motivodescuento,tipocambio,moneda,tipodecomprobante,formadepago,nconceptos,arrayconceptos,totalimpuestostrasladados,totalimpuestosretenidos,traslados,retenciones,mpago,nscuenta,lugarexpedicion,rfcemisor,nombreemisor,calleemisor,noexterioremisor,nointerioremisor,coloniaemisor,localidademisor,municipioemisor,estadoemisor,paisemisor,cpemisor,calleexpedido,noexteriorexpedido,nointeriorexpedido,coloniaexpedido,localidadexpedido,municipioexpedido,estadoexpedido,paisexpedido,cpexpedido,nocertificado,certificado,condicionesdepago,regimenfac,fincertificado,horafincer,rfcreceptor,nombrereceptor,callereceptor,noexteriorreceptor,nointeriorreceptor,coloniareceptor,municipioreceptor,estadoreceptor,paisreceptor,cpreceptor,uspac,passpac)
      Msginfo("Error al generar CFDI, presione GENERAR CFDI"+CHR(10)+CHR(13)+"si el problema persiste informe a sistemas")
	  habilitadiv(.f.)
      altadiverso.button_1.enabled:=.t.
  	  altadiverso.button_3.enabled:=.f.
      altadiverso.button_6.enabled:=.f.
	  altadiverso.button_9.visible:=.t.
	  return
   else
      select 60
      timbre:=0
      do while .t.
         use timbres exclu
	     if !neterr()
	        exit
         endif
      enddo
      timbre:=timbres->usados+1
      timbres->usados:=timbre
      dbselectarea('timbres')
      timbres->(dbclosearea())
	  select diverso
	endif
	altadiverso.button_9.visible:=.f.
	imprimediverso()*/
return

function bskapadrdiv
   /*declare window altadiverso
   if !empty(altadiverso.text_5.value) .and. !empty(altadiverso.text_6.value)
      select padron
      set order to 1
      seek altadiverso.text_5.value+altadiverso.text_6.value
      if found()
         altadiverso.text_4.value:=padron->contrato
	 altadiverso.text_9.value:=padron->nombre
	 altadiverso.text_10.value:=padron->domicilio
         altadiverso.text_8.value:=padron->medidor
	 select tomas
	 seek padron->toma
	 if found()
	    mtoma:=tomas->des_toma
	 endif
	 select usuarios
	 seek padron->tipo_usu
	 if found()
	    musu:=usuarios->des_usu
	 endif
         altadiverso.text_4.enabled:=.f.
         altadiverso.text_7.enabled:=.f.
         altadiverso.text_9.enabled:=.t.
         altadiverso.text_10.enabled:=.t.
         altadiverso.text_11.enabled:=.t.
         altadiverso.text_12.enabled:=.t.
         altadiverso.text_8.enabled:=.f.
         altadiverso.text_9.setfocus
      else
         altadiverso.text_5.value:=space(3)
	 altadiverso.text_6.value:=space(4)
	 altadiverso.text_5.setfocus
	 return
      endif
      select rfc 
      set order to 1
      seek altadiverso.text_5.value+altadiverso.text_6.value
      if found()
         altadiverso.text_12.value:=rfc->rfc
      endif
      select padron
   endif*/
return

function buscacontdiv
   /*declare window altadiverso
   if !empty(altadiverso.text_4.value)
      select contrato
      seek altadiverso.text_4.value
      if found()
 	 altadiverso.text_9.value:=contrato->nombre
	 altadiverso.text_10.value:=contrato->domicilio
	 mordagua:=contrato->orden_agua
	 morddren:=contrato->orden_dren
	 select usuarios
	 seek contrato->tipo_usu
	 if found()
	    musu:=usuarios->des_usu
	 endif
         altadiverso.text_5.enabled:=.f.
         altadiverso.text_6.enabled:=.f.
         altadiverso.text_9.enabled:=.t.
         altadiverso.text_10.enabled:=.t.
         altadiverso.text_11.enabled:=.t.
         altadiverso.text_12.enabled:=.t.
         altadiverso.text_8.enabled:=.f.
         altadiverso.text_9.setfocus
      else
         altadiverso.text_4.value:=space(7)
	 altadiverso.text_4.setfocus
      endif
   endif*/
return


function buscapagdiv
   /*declare window altadiverso
   if !empty(altadiverso.text_7.value)
      select pagares 
      seek altadiverso.text_7.value
      if found()
         altadiverso.text_4.value:=pagares->contrato
 	 altadiverso.text_9.value:=pagares->nombre
	 altadiverso.text_10.value:=pagares->domicilio
         altadiverso.text_5.value:=pagares->ruta
	 altadiverso.text_6.value:=pagares->folio
	 mfechapag:=pagares->fecha_ven
         altadiverso.text_5.enabled:=.f.
         altadiverso.text_6.enabled:=.f.
         altadiverso.text_9.enabled:=.t.
         altadiverso.text_10.enabled:=.t.
         altadiverso.text_11.enabled:=.t.
         altadiverso.text_12.enabled:=.t.
         altadiverso.text_8.enabled:=.f.
         altadiverso.text_9.setfocus
      else
         altadiverso.text_7.value:=space(7)
	 altadiverso.text_7.setfocus
      endif
   endif*/
return

function buscusudiv
   /*select capturis
   seek altadiverso.text_1.value
   if found()
      if capturis->estatus='A'
         if capturis->clave = 'C' .or. capturis->clave ='S'
            mpermisos:=capturis->nivel
            arcepto:={.f.,.f.,.f.,.f.,.f.}
            altadiverso.text_2.value:=capturis->nom_captur
            altadiverso.button_1.enabled:=.f.
            altadiverso.button_3.enabled:=.t.
            altadiverso.button_6.enabled:=.t.
            altadiverso.text_5.readonly:=.f.
            altadiverso.text_6.readonly:=.f.
            altadiverso.text_4.readonly:=.f.
            altadiverso.text_7.readonly:=.f.
	    pongetdiv()
            habilitadiv(.t.)
         endif 
      else
         MsgInfo('El capturista esta dado de baja','Mensaje del Sistema')
         altadiverso.text_1.value:=space(3)
         altadiverso.text_1.setfocus
	 return
      endif
   else
      MsgInfo('El capturista no existe','Mensaje del Sistema')
      altadiverso.text_1.value:=space(3)
      altadiverso.text_1.setfocus
      return
   endif*/
return

function buscadivcepto
   /*parameters opflagdiv
   select concepto
   set order to 2
   go top
   IF !IsWindowDefined(browcepto) 
       Load Window browcepto
       Center Window browcepto
       Activate Window browcepto
   endIf*/
return

function seekgirococep()
   /*declare window browcepto
   select concepto
   seek alltrim(browcepto.text_1.value)
   browcepto.browse_1.value:=concepto->(recno())
   browcepto.browse_1.refresh*/
return

function ponceptodiv
   /*declare window altadiverso
   browcepto.release
   if opflagdiv = 1
      altadiverso.text_17.value:=concepto->cve_cpto
      altadiverso.text_18.value:=concepto->des_cpto
      altadiverso.text_19.setfocus
   elseif opflagdiv = 2
      altadiverso.text_20.value:=concepto->cve_cpto
      altadiverso.text_21.value:=concepto->des_cpto
      altadiverso.text_22.setfocus
   elseif opflagdiv = 3
      altadiverso.text_23.value:=concepto->cve_cpto
      altadiverso.text_24.value:=concepto->des_cpto
      altadiverso.text_25.setfocus
   elseif opflagdiv = 4
      altadiverso.text_26.value:=concepto->cve_cpto
      altadiverso.text_27.value:=concepto->des_cpto
      altadiverso.text_28.setfocus
   elseif opflagdiv = 5
      altadiverso.text_29.value:=concepto->cve_cpto
      altadiverso.text_30.value:=concepto->des_cpto
      altadiverso.text_31.setfocus
   endif
   select concepto
   set order to 1*/
return


function cabiarprecio
  /* parameters flagpre
   if altadiverso.radiogroup_1.value =  1
      if flagpre = 1
         if !arcepto[flagpre] .and. altadiverso.text_19.value > 0
	    arvalcepto[flagpre]:=altadiverso.text_19.value
            arcepto[flagpre]:=.t.
            altadiverso.text_19.value:=altadiverso.text_19.value/(1+(altadiverso.text_14.value/100))
         endif
      elseif flagpre = 2
         if !arcepto[flagpre] .and. altadiverso.text_22.value > 0
	    arvalcepto[flagpre]:=altadiverso.text_22.value
            arcepto[flagpre]:=.t.
            altadiverso.text_22.value:=altadiverso.text_22.value/(1+(altadiverso.text_14.value/100))
         endif
      elseif flagpre = 3
         if !arcepto[flagpre] .and. altadiverso.text_25.value > 0
	    arvalcepto[flagpre]:=altadiverso.text_25.value
            arcepto[flagpre]:=.t.
            altadiverso.text_25.value:=altadiverso.text_25.value/(1+(altadiverso.text_14.value/100))
         endif
      elseif flagpre = 4
         if !arcepto[flagpre] .and. altadiverso.text_28.value > 0
	    arvalcepto[flagpre]:=altadiverso.text_28.value
            arcepto[flagpre]:=.t.
            altadiverso.text_28.value:=altadiverso.text_28.value/(1+(altadiverso.text_14.value/100))
         endif
      elseif flagpre = 5
         if !arcepto[flagpre] .and. altadiverso.text_31.value > 0
	    arvalcepto[flagpre]:=altadiverso.text_31.value
            arcepto[flagpre]:=.t.
            altadiverso.text_31.value:=altadiverso.text_31.value/(1+(altadiverso.text_14.value/100))
         endif
      endif
      altadiverso.text_13.value:=altadiverso.text_19.value+altadiverso.text_22.value+altadiverso.text_25.value+altadiverso.text_28.value+altadiverso.text_31.value
      altadiverso.text_15.value:=(arvalcepto[1]+arvalcepto[2]+arvalcepto[3]+arvalcepto[4]+arvalcepto[5])-altadiverso.text_13.value
      altadiverso.text_16.value:=altadiverso.text_13.value+altadiverso.text_15.value
   else
      altadiverso.text_13.value:=altadiverso.text_19.value+altadiverso.text_22.value+altadiverso.text_25.value+altadiverso.text_28.value+altadiverso.text_31.value
      altadiverso.text_15.value:=altadiverso.text_13.value * (altadiverso.text_14.value/100)
      altadiverso.text_16.value:=altadiverso.text_13.value+altadiverso.text_15.value
   endif*/
return

function habilitadiv
   parameters flaghab
   *altadiverso.button_3.enabled:=flaghab
   altadiverso.text_4.enabled:=flaghab
   altadiverso.text_5.enabled:=flaghab
   altadiverso.text_6.enabled:=flaghab
   altadiverso.text_7.enabled:=flaghab
   altadiverso.text_9.enabled:=flaghab
   altadiverso.text_10.enabled:=flaghab
   altadiverso.text_11.enabled:=flaghab
   altadiverso.text_12.enabled:=flaghab
   altadiverso.text_17.enabled:=flaghab
   altadiverso.text_19.enabled:=flaghab
   altadiverso.text_20.enabled:=flaghab
   altadiverso.text_22.enabled:=flaghab
   altadiverso.text_23.enabled:=flaghab
   altadiverso.text_25.enabled:=flaghab
   altadiverso.text_26.enabled:=flaghab
   altadiverso.text_28.enabled:=flaghab
   altadiverso.text_29.enabled:=flaghab
   altadiverso.text_31.enabled:=flaghab
   altadiverso.text_32.enabled:=flaghab
   altadiverso.button_5.enabled:=flaghab
   altadiverso.button_7.enabled:=flaghab
   altadiverso.button_8.enabled:=flaghab
   altadiverso.button_10.enabled:=flaghab
   altadiverso.button_11.enabled:=flaghab
return

function buscapipero
   /*select piperos
   set order to 2
   go top
   arcepto:={.f.,.f.,.f.,.f.,.f.}
   IF !IsWindowDefined(browpipero) 
       Load Window browpipero
       Center Window browpipero
       Activate Window browpipero
   endIf*/
return

function seekpipero
  /* declare window browpipero
   select piperos
   seek alltrim(browpipero.text_1.value)
   browpipero.browse_1.value:=piperos->(recno())
   browpipero.browse_1.refresh*/
return

function ponpiperodiv
  /* declare window ponpip
   declare window browpipero
   browpipero.release
   cvepip:=piperos->pipero_no
   ponpip.text_1.value:=piperos->pipero_no
   ponpip.text_2.value:=piperos->nombre
   ponpip.text_3.value:=piperos->domicilio
   ponpip.text_4.value:=piperos->rfc*/
return

function llenavale
  /* IF !IsWindowDefined(valepipero) 
       Load Window valepipero
       Center Window valepipero
       Activate Window valepipero
   endIf*/
return


function grdavalorpipe
  /* declare window valepipero
   mviajes:=valepipero.text_1.value
   mcap:=valepipero.text_2.value
   mvale:=valepipero.text_3.value
   valepipero.release*/
return

function pongetdiv
   /*mviajes:=0
   mcap:=0
   cvepip:=0
   mvale:=0
   mordagua:=''
   morddren:=''
   altadiverso.text_2.value:=space(40)
   altadiverso.text_3.value:=0
   altadiverso.text_4.value:=space(7)
   altadiverso.text_5.value:=space(3)
   altadiverso.text_6.value:=space(4)
   altadiverso.text_7.value:=space(7)
   altadiverso.text_8.value:=space(20)
   altadiverso.text_9.value:=space(60)
   altadiverso.text_10.value:=space(40)
   altadiverso.text_11.value:=space(40)
   altadiverso.text_12.value:=space(15)
   altadiverso.text_17.value:=space(2)
   altadiverso.text_18.value:=space(40)
   altadiverso.text_19.value:=0
   altadiverso.text_20.value:=space(2)
   altadiverso.text_21.value:=space(40)
   altadiverso.text_22.value:=0
   altadiverso.text_23.value:=space(2)
   altadiverso.text_24.value:=space(40)
   altadiverso.text_25.value:=0
   altadiverso.text_26.value:=space(2)
   altadiverso.text_27.value:=space(40)
   altadiverso.text_28.value:=0
   altadiverso.text_29.value:=space(2)
   altadiverso.text_30.value:=space(40)
   altadiverso.text_31.value:=0*/
return

function siestalistodiv
   retval:=.f.
  /* if empty(altadiverso.text_3.value) .or. diverso->impreso ='1'
       //retval:=.f.
       retval:=.t.
   else
      if Msgyesno('El recibo no esta impreso esta seguro que desea salir?','Mensaje del Sistema')
		retval:=.t.
	  endif
   endif*/
   retval:=.t.
return(retval)

function seekcvecpto
  /* parameter flagseekkcv
   select concepto
   if flagseekkcv =  1
      seek altadiverso.text_17.value
      if found()
         altadiverso.text_18.value:=concepto->des_cpto
         altadiverso.text_19.setfocus
      else
         MsgInfo('El concepto no existe','Mensaje del Sistema')
         altadiverso.text_17.setfocus
	 return
      endif
   elseif flagseekkcv = 2
      seek altadiverso.text_20.value
      if found()
         altadiverso.text_21.value:=concepto->des_cpto
         altadiverso.text_22.setfocus
      else
         MsgInfo('El concepto no existe','Mensaje del Sistema')
         altadiverso.text_20.setfocus
	 return
      endif
   elseif flagseekkcv = 3
      seek altadiverso.text_23.value
      if found()
         altadiverso.text_24.value:=concepto->des_cpto
         altadiverso.text_25.setfocus
      else
         MsgInfo('El concepto no existe','Mensaje del Sistema')
         altadiverso.text_23.setfocus
	 return
      endif
   elseif flagseekkcv = 4
      seek altadiverso.text_26.value
      if found()
         altadiverso.text_27.value:=concepto->des_cpto
         altadiverso.text_28.setfocus
      else
         MsgInfo('El concepto no existe','Mensaje del Sistema')
         altadiverso.text_26.setfocus
	 return
      endif
   elseif flagseekkcv = 5
      seek altadiverso.text_29.value
      if found()
         altadiverso.text_30.value:=concepto->des_cpto
         altadiverso.text_31.setfocus
      else
         MsgInfo('El concepto no existe','Mensaje del Sistema')
         altadiverso.text_29.setfocus
	 return
      endif
   endif*/
return

function imprimediverso
  /* declare window altadiverso
   mfact2:='' 
   mfact3:=''
   mfact4:=''
   mfact5:=''
   mfact6:=''
   mfact7:=''
   dbfoldant:=alias()
   select ediverso
   set softseek off
   seek STRZERO(altadiverso.text_3.value,7)
   set softseek on
   if !found()
      res:=msgyesno('El recibo no se ha timbrado, si desea continuar presione SI','Mensaje del Sistema')
	  if res=.f.
		select &dbfoldant   
		return
	  endif
   else
      mfact2:=ediverso->serie
      mfact3:=ediverso->folio
      mfact4=ediverso->fecha
      mfact7:=ediverso->certifica
   endif
   select &dbfoldant   
   arimp:={'ORIGINAL','COPIA'}
   nompdf:='F:\FACTELEC\PDF\DIVERSOS\CMA930425IZ2_'+alltrim(ediverso->serie)+'-'+alltrim(diverso->numero)+'.pdf'
   *nompdf:='F:\FACTELEC\PDF\DIVERSOS\CMA930425IZ2_'+alltrim(ediverso->serie)+'-'+alltrim(diverso->numero)+'.pdf'
   *nompdf:='D:\Desarrollo\comapa\F\factelec\PDF\DIVERSOS\CMA930425IZ2_'+alltrim(ediverso->serie)+'-'+alltrim(ediverso->folio)+'.pdf'
   *Msginfo(nompdf)
   SELECT HPDFDOC nompdf TO lSuccess papersize HPDF_PAPER_A5 ORIENTATION HPDF_ORIENT_LANDSCAPE
   SET HPDFDOC COMPRESS ALL
   SET HPDFDOC ENCODING TO "CP1252"
   if lSuccess
      START HPDFDOC
      for u=1 to 2
		*Msginfo(str(u))
         START HPDFPAGE
	     lin:=36
	     incre:=3
         @ 1,1 HPDFPRINT IMAGE "diverso.png" width 200 height 100
         @ 8,107 HPDFPRINT "COMISION MUNICIPAL DE AGUA POTABLE" font "Times-Bold" size 12 center
         @ 13,107 HPDFPRINT "Y ALCANTARILLADO DEL MUNICIPIO DE" font "Times-Bold" size 12 center
         @ 18,107 HPDFPRINT "NUEVO LAREDO, TAMAULIPAS" font "Times-Bold" size 12 center
         @ 24,100 HPDFPRINT "FACTURA POR SERVICIOS DIVERSOS Y CONEXIONES DE AGUA Y DRENAJE" font "Times-Bold" size 10 center
         @ 29,60 HPDFPRINT "R.F.C. CMA-930425-IZ2  Victoria No. 4610   tel. : (867)8900-900  Nuevo Laredo, Tam." font "Times-Roman" size 8 
         @ 36,135 HPDFPRINT "SERIE "+alltrim(ediverso->serie) font "Times-Bold" size 6 
		 @ 36,155 HPDFPRINT "FOLIO # "+strzero(altadiverso.text_3.value,7) font "Times-Bold" size 8 
		 @ 39,135 HPDFPRINT "FOLIO SAT "+alltrim(ediverso->uuid) font "Times-Bold" size 6 
		 @ 42,135 HPDFPRINT "CERTIFICADO # "+ALLTRIM(ediverso->certifica) font "Times-Bold" size 6 
		 @ 45,135 HPDFPRINT "CERTIFICADO SAT # "+ALLTRIM(ediverso->nocertific) font "Times-Bold" size 6
		 @ 48,135 HPDFPRINT "LUGAR Y FECHA Nuevo Laredo, Tamps "+alltrim(ediverso->fecha) font "Times-Bold" size 6
		 @ 51,135 HPDFPRINT "FECHA CERTIFICACION "+ALLTRIM(ediverso->fechatimbr) font "Times-Bold" size 6
         @ lin,10 HPDFPRINT "CONTRATO : "+ altadiverso.text_4.value font "Times-Roman" size 8 
         @ lin,60 HPDFPRINT iif(!empty(mtoma),"TOMA : "+ mtoma,' ') font "Times-Roman" size 8 
         @ lin,100 HPDFPRINT iif(!empty(musu),"USUARIO : "+ musu,' ') font "Times-Roman" size 8 
         lin:=lin+incre
		 

	 if !empty(altadiverso.text_7.value)
            @ lin,10 HPDFPRINT "PAGARE : "+altadiverso.text_7.value font "Times-Roman" size 8 
	    @ lin,60 HPDFPRINT "FECHA VENCIMIENTO DEL PAGARE : "+dtoc(mfechapag) font "Times-Roman" size 8
            lin:=lin+incre
	 endif
	 
	 if !empty(mordagua) .or. !empty(morddren)
            @ lin,10 HPDFPRINT "ORDEN DE AGUA : "+mordagua  font "Times-Roman" size 8 
            @ lin,60 HPDFPRINT "ORDEN DE DRENAJE : "+morddren font "Times-Roman" size 8 
            lin:=lin+incre
	 endif
	 
         @ lin,10 HPDFPRINT "LOCALIZACION : "+ altadiverso.text_5.value+"-"+altadiverso.text_6.value font "Times-Roman" size 8 
         @ lin,60 HPDFPRINT "NOMBRE : "+ altadiverso.text_9.value font "Times-Roman" size 8 
         lin:=lin+incre
         @ lin,10 HPDFPRINT "DOMICILIO : "+ altadiverso.text_10.value font "Times-Roman" size 8 
		 if !empty(altadiverso.text_32.value)
  	    lin:=lin+incre
            @ lin,10 HPDFPRINT "C.P. : "+ altadiverso.text_32.value font "Times-Roman" size 8 
         endif         
		 
         if !empty(altadiverso.text_32.value) .and. !empty(mrfc)
  	    @ lin,60 HPDFPRINT "RFC : "+ altadiverso.text_12.value font "Times-Roman" size 8 
         elseif empty(altadiverso.text_32.value) .and. !empty(mrfc)
            lin:=lin+incre
     	    @ lin,10 HPDFPRINT "RFC : "+ altadiverso.text_12.value font "Times-Roman" size 8 
	 endif
	 if !empty(altadiverso.text_11.value)
            lin:=lin+incre
            @ lin,10 HPDFPRINT "COLONIA : "+ altadiverso.text_11.value font "Times-Roman" size 8 
	 endif
	 
	 
	 if cvepip > 0
	    if mcap > 0
               lin:=lin+incre
               @ lin,10 HPDFPRINT "CAPACIDAD : "+ transform(mcap,'999.99') font "Times-Roman" size 8 
	    endif
	 endif
         lin:=67
	 if !empty(altadiverso.text_17.value)
            @ lin,10 HPDFPRINT altadiverso.text_17.value font "Times-Roman" size 8 
            @ lin,30 HPDFPRINT altadiverso.text_18.value font "Times-Roman" size 8 
            @ lin,140 HPDFPRINT transform(altadiverso.text_19.value,'999,999,999.99') font "Times-Roman" size 8 right
            lin:=lin+incre
	 endif
	 if !empty(altadiverso.text_20.value)
            @ lin,10 HPDFPRINT altadiverso.text_20.value font "Times-Roman" size 8 
            @ lin,30 HPDFPRINT altadiverso.text_21.value font "Times-Roman" size 8 
            @ lin,140 HPDFPRINT transform(altadiverso.text_22.value,'999,999,999.99') font "Times-Roman" size 8  right
            lin:=lin+incre
	 endif
	 if !empty(altadiverso.text_23.value)
            @ lin,10 HPDFPRINT altadiverso.text_23.value font "Times-Roman" size 8 
            @ lin,30 HPDFPRINT altadiverso.text_24.value font "Times-Roman" size 8 
            @ lin,140 HPDFPRINT transform(altadiverso.text_25.value,'999,999,999.99') font "Times-Roman" size 8  right
            lin:=lin+incre
	 endif
	 if !empty(altadiverso.text_26.value)
            @ lin,10 HPDFPRINT altadiverso.text_26.value font "Times-Roman" size 8 
            @ lin,30 HPDFPRINT altadiverso.text_27.value font "Times-Roman" size 8 
            @ lin,140 HPDFPRINT transform(altadiverso.text_28.value,'999,999,999.99') font "Times-Roman" size 8  right
            lin:=lin+incre
	 endif
	 if !empty(altadiverso.text_29.value)
            @ lin,10 HPDFPRINT altadiverso.text_29.value font "Times-Roman" size 8 
            @ lin,30 HPDFPRINT altadiverso.text_30.value font "Times-Roman" size 8 
            @ lin,140 HPDFPRINT transform(altadiverso.text_31.value,'999,999,999.99') font "Times-Roman" size 8  right
            lin:=lin+incre
         endif
         rtot:=10
         increr:=5
         if cvepip > 0
            lin:=lin+incre
            for t = 1 to mviajes
               @ lin,rtot HPDFPRINT strzero(t,2) font "Times-Roman" size 8 
	       if rtot <= 70
    	          rtot:=rtot+increr
	       else
                  rtot:=20
                  lin:=lin+incre
	       endif
            next
            lin:=lin+incre
            @ lin,10 HPDFPRINT iif(mviajes > 1 ,'DEL VALE :'+alltrim(str(mvale))+'       Al :'+alltrim(str(mvale+(mviajes-1))) ,'DEL VALE :'+alltrim(str(mvale))) font "Times-Roman" size 8 
         endif
         codigosat:='?re='+alltrim(empresas->rfc)+'&rr='+alltrim(mrfc)+'&tt='+strzero(diverso->total,17,6)+'&id='+alltrim(ediverso->uuid)
		  //Msginfo(len(codigosat))
		if !empty(alltrim(ediverso->uuid))
		   hBitMap :=HMG_CreateBarCode( codigosat, "QRCODE" , 3, 3, , "codigo.png", , , , ,  )
		   @ 65,155 HPDFPRINT IMAGE ".\codigo.png" width 30 height 30
		endif
		lin:=lin+10
	 if u = 2
	 		*hBitMap :=HMG_CreateBarCode( "PRUEBA", "CODE39" , 30,2 , , "codigo2.png", , , , ,  )
			hBitMap :=HMG_CreateBarCode( 'X'+strzero(altadiverso.text_3.value,6)+strzero(val(str(altadiverso.text_16.value*100,0)),10), "CODE39" ,2 , 50,.t. , "codigo2.png", , , , ,  )
            @ 85,13 HPDFPRINT IMAGE ".\codigo2.png" width 50 height 13
	 endif
         @ 91,100 HPDFPRINT 'SUB TOTAL' font "Times-Roman" size 8 right
         @ 91,140 HPDFPRINT transform(altadiverso.text_13.value,'999,999,999.99') font "Times-Roman" size 8  right
         @ 94,85 HPDFPRINT transform(altadiverso.text_14.value,'99')+' %' font "Times-Roman" size 8 
         @ 94,100 HPDFPRINT 'I.V.A.' font "Times-Roman" size 8 right
         @ 94,140 HPDFPRINT transform(altadiverso.text_15.value,'999,999,999.99') font "Times-Roman" size 8  right
         @ 97,100 HPDFPRINT 'TOTAL' font "Times-Roman" size 8  right
         @ 97,140 HPDFPRINT transform(altadiverso.text_16.value,'999,999,999.99') font "Times-Roman" size 8  right
	     lin:=104
         @ lin,10 HPDFPRINT "ESTE DOCUMENTO ES UNA REPRESENTACION IMPRESA DE UN CFDI           (PAGO EN UNA SOLA EXHIBICION)          METODO DE PAGO NO IDENTIFICADO" font "Times-Bold" size 7 
         lin:=lin+incre
		 @ lin,10 HPDFPRINT "REGIMEN FISCAL "+alltrim(empresas->regimen) font "Times-Bold" size 7 
         lin:=lin+incre
         @ lin,10 HPDFPRINT "CADENA ORIGINAL DEL COMPLEMENTO DE CERTIFICACION DIGITAL DEL SAT: " font "Times-Bold" size 5 
         lin:=lin+incre 
         dbfoldant:=alias()
         select ediverso
         seek strzero(altadiverso.text_3.value,7)
         if found()
            cString := "||"+alltrim(ediverso->versat)+"|"+alltrim(ediverso->uuid)+"|"+alltrim(ediverso->fecha)+"|"+alltrim(ediverso->sello)+"|"+alltrim(ediverso->nocertific)+"||"
            nLines := MLCOUNT(cString, 180 )
            FOR nCurrentLine := 1 TO nLines
               nlect:=alltrim(MEMOLINE(cString,180, nCurrentLine))
               @ lin,10 HPDFPRINT nlect font "Times-Bold" size 5 
               lin:=lin+incre
            next
            @ lin,10 HPDFPRINT "SELLO DIGITAL DEL CFDI" font "Times-Bold" size 5 
            lin:=lin+incre
            cString := ediverso->sello
            nLines := MLCOUNT(cString, 180 )
            FOR nCurrentLine := 1 TO nLines
               nlect:=alltrim(MEMOLINE(cString,180, nCurrentLine))
               @ lin,10 HPDFPRINT nlect font "Times-Bold" size 5
               lin:=lin+incre
            next
			@ lin,10 HPDFPRINT "SELLO DEL SAT:" font "Times-Bold" size 5 
            lin:=lin+incre
            cString := ediverso->sellosat
            nLines := MLCOUNT(cString, 180 )
            FOR nCurrentLine := 1 TO nLines
               nlect:=alltrim(MEMOLINE(cString,180, nCurrentLine))
               @ lin,10 HPDFPRINT nlect font "Times-Bold" size 5
               lin:=lin+incre
            next
         endif 
         select &dbfoldant 
         END HPDFPAGE
      next
      end HPDFDOC
      select diverso
      do while .t.
         if diverso->(rlock())
	        diverso->impreso:='1'
            exit
         endif
      enddo
	  execute file nompdf
   endif
   altadiverso.text_1.value:=space(3)
   altadiverso.text_1.setfocus*/
return

function buscadiv
   /*local mseek
   select diverso
   /* if upper(ORDSETFOCUS()) = 'REQUISI'
      mensg1:='Requisicion #'
   else
      if upper(ORDSETFOCUS()) = 'NUMERO'
         mensg1:='Oren de Compra #'
      endif   
   endif */
   /*mseek:=InputBox ( ' ' , 'Busqueda X Folio' , space(10) )
   mseek:=mseek
   seek mseek
   diverso.browse_1.value:=diverso->(recno())
   diverso.browse_1.refresh*/
return

function ponpipdiv
   /*IF !IsWindowDefined(ponpip) 
       Load Window ponpip
       Center Window ponpip
       Activate Window ponpip
   endIf*/
return

function buscapiperonvo
  /* select piperos
   set order to 1
   seek ponpip.text_1.value
   if !found()
      msginfo('El pipero no existe','Mensaje del Sistema')
      ponpip.text_1.setfocus
      return
   endif
   cvepip:=piperos->pipero_no
   ponpip.text_2.value:=piperos->nombre
   ponpip.text_3.value:=piperos->domicilio
   ponpip.text_4.value:=piperos->rfc*/
return

function pondatospipdivt
   /*declare window altadiverso
   altadiverso.text_9.value:=piperos->nombre
   altadiverso.text_10.value:=piperos->domicilio
   altadiverso.text_12.value:=piperos->rfc
   if piperos->tambopipa = 'P'
      altadiverso.text_17.value:='37'
   else
      altadiverso.text_17.value:='42'
   endif
   ponpip.release
   select concepto
   set order to 1
   seek altadiverso.text_17.value
   if found()
       altadiverso.text_18.value:=concepto->des_cpto
   endif
   select piperos
   altadiverso.text_19.setfocus
   llenavale()*/
return

function enviacorreo(destinatario,asuntocorreo,mensajecorreo)
	/*local cServer       :=      "192.168.1.200"                  // Required. IP or domain name of the mail server
	local nPort         :=      26                              // Optional. Port used my email server
	local cFrom         :=      "sistemas@comapanuevolaredo.gob.mx"       // Required. Email address of the sender
	local xTo           :=      destinatario       // Required. Character string or array of email addresses to send the email to
   local xCC           :=      ""                              // Optional. Character string or array of email adresses for CC (Carbon Copy)
	local xBCC          :=      ""                              // Optional. Character string or array of email adresses for BCC (Blind Carbon Copy)
	local cBody         :=      mensajecorreo // Optional. The body message of the email as text, or the filename of the HTML message to send.
	local cSubject      :=      asuntocorreo            // Optional. Subject of the sending email
	local aFiles        :=      {}                              // Optional. Array of files attachments to the email to send {{"a"},{"b"}}
	local cUser         :=      "sistemas@comapanuevolaredo.gob.mx"                  // Required. User name for the POP3 server
	local cPass         :=      "comapa2000"              // Required. User password for the POP3 server
	local cPopServer    :=      "192.168.1.200"                  // Required. POP3 server name or address
	local nPriority     :=      3                               // Optional. Email priority: 1=High,3=Normal (Standard), 5=Low
	local lRead         :=      .f.                             // Optional. If set to .T., a confirmation request is send. Standard setting is .F.
	local bTrace        :=      .t.                             // Optional. If set to .T., a log file is created (smtp-<nNr>.log). Standard setting is NIL.
	// If a block is passed, it will be called for each log event with the message a string, no param on session close.
	local lPopAuth      :=      .f.                             // Optional. Do POP3 authentication before sending mail.
	local lNoAuth       :=      .f.                             // Optional. Disable Autentication methods
	local nTimeOut      :=      1000                            // Optional. Number os ms to wait default 20000 (20s)
	local cReplyTo      :=      "sistemas@comapanuevolaredo.gob.mx"       // Optional. mail address to reply to
	local lTLS          :=      .F.                             // Optional. Set to .t. if you want/need to use Transport Layer Security default to .F.
	local cSMTPPass     :=      "comapa2000"                              // Optional. Character string password for SMTP server if needed
	local cCharset      :=      ""                              // Character set to be used, default to "ISO-8859-1"
	local cEncoding     :=      ""                              // Optional. Encode option to be used, default to "quoted-printable"
	hb_SendMail( cServer, nPort, cFrom, xTo, xCC , xBCC , cBody, cSubject, aFiles, cUser, cPass, cPopServer, nPriority, lRead, bTrace,lPopAuth,lNoAuth, nTimeOut, cReplyTo, lTLS , cSMTPPass, cCharset, cEncoding )
	*/
return