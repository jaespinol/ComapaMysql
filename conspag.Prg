#include <hmg.ch>

function conspag
   public acombopag:=array(9),aopcombo:=array(9)
   apagares:={}
   apagares:={}
   IF !IsWindowDefined(conspag) 
       Load Window conspag
       conspag.text_3.setfocus
       conspag.button_1.enabled:=.f.
       conspag.button_3.enabled:=.f.
       conspag.combo_1.enabled:=.f.
	   conspag.dp1.enabled:=.f.
	   conspag.dp1.Value := CtoD("01/01/1900")
       Center Window conspag
       Activate Window conspag
   endIf
return

function buscausupagc
   declare window conspag
   /*select capturis
   seek conspag.text_1.value
   if found()
      if capturis->estatus='A'
         if capturis->clave = 'D' .or. capturis->clave ='S' .or. capturis->clave ='B'
            mpermisos:=capturis->nivel
            conspag.text_2.value:=capturis->nom_captur*/
            conspag.button_1.enabled:=.t.
            conspag.button_3.enabled:=.t.
        /* endif 
      else
         MsgInfo('El capturista esta dado de baja','Mensaje del Sistema')
         conspag.text_1.value:=space(3)
         conspag.text_1.setfocus
	 return
      endif
   else
      MsgInfo('La clave no existe','Mensaje del Sistema')
      conspag.text_1.value:=space(3)
      conspag.text_1.setfocus
      return
   endif*/
return

function bskarpagxvar // este hay que cambiar
   /*select pagares
   set order to 1
   go top
   go top
   IF !IsWindowDefined(browpag) 
       Load Window browpag
       browpag.text_1.setfocus
       Center Window browpag
       Activate Window browpag
   endIf*/
	 declare window browpag
/*   select colonias
   set order to 3
   go top*/
   IF !IsWindowDefined(browpag) 
		Load Window browpag
			/*cQuery := "select pagare, ruta, folio, nombre, domicilio From Pagares order by pagare"
			bQuery := oServer:Query (cQuery)
			If bQuery:NetErr()
				Msgstop(bQuery:Error())
				Return Nil
			EndIf 
			MsgBox( bQuery:LastRec(),"10")
			n:=1
			For i=1 To bQuery:LastRec()
				oRow := bQuery:GetRow(i)
				browpag.grid_1.AddItem({oRow:FieldGet("pagare"),oRow:FieldGet("Ruta") + "-" + oRow:FieldGet("folio"),oRow:FieldGet("nombre");
				,oRow:FieldGet("domicilio")})
				If n=500
					Do Events
					n:=1
				EndIf 
				n++
			Next
			bQuery:Destroy()*/
		Center Window browpag
		Activate Window browpag
   endIf
return

function campospag //este hay que hacer es la busqueda
  parameters opbusca
   declare window browpag
   //select pagares
   if opbusca = 1
      /*set order to 5
      seek browpag.text_1.value+ */
		If empty(browpag.text_2.Value)
			cQuery := "select pagare, ruta, folio, nombre, domicilio From Pagares where ruta='" + browpag.text_1.Value +;
						 "'"
			bQuery := oServer:Query (cQuery)
			If bQuery:NetErr()
				Msgstop(bQuery:Error())
				Return Nil
			EndIf 
			MsgBox( bQuery:LastRec(),"10")
			n:=1
			browpag.grid_1.DeleteAllItems()
			For i=1 To bQuery:LastRec()
				oRow := bQuery:GetRow(i)
				browpag.grid_1.AddItem({oRow:FieldGet("pagare"),oRow:FieldGet("Ruta") + "-" + oRow:FieldGet("folio"),oRow:FieldGet("nombre");
				,oRow:FieldGet("domicilio")})
				/*If n=500
					Do Events
					n:=1
				EndIf 
				n++*/
			Next
			bQuery:Destroy()
		Else
			cQuery := "select pagare, ruta, folio, nombre, domicilio From Pagares where ruta='" + browpag.text_1.Value +;
						 "' and folio='" + browpag.text_2.Value + "'"
			bQuery := oServer:Query (cQuery)
			If bQuery:NetErr()
				Msgstop(bQuery:Error())
				Return Nil
			EndIf 
			MsgBox( bQuery:LastRec(),"10")
			n:=1
			browpag.grid_1.DeleteAllItems()
			For i=1 To bQuery:LastRec()
				oRow := bQuery:GetRow(i)
				browpag.grid_1.AddItem({oRow:FieldGet("pagare"),oRow:FieldGet("Ruta") + "-" + oRow:FieldGet("folio"),oRow:FieldGet("nombre");
				,oRow:FieldGet("domicilio")})
				/*If n=500
					Do Events
					n:=1
				EndIf 
				n++*/
			Next
			bQuery:Destroy()
		EndIf 
   ElseIf opbusca = 2
      /*set order to 7
      seek alltrim(browpag.text_3.value)*/
		cQuery := "select pagare, ruta, folio, nombre, domicilio From Pagares where nombre like '%" + browpag.text_3.Value +;
					 "%'"
			bQuery := oServer:Query (cQuery)
			If bQuery:NetErr()
				Msgstop(bQuery:Error())
				Return Nil
			EndIf 
			MsgBox( bQuery:LastRec(),"10")
			n:=1
			browpag.grid_1.DeleteAllItems()
			For i=1 To bQuery:LastRec()
				oRow := bQuery:GetRow(i)
				browpag.grid_1.AddItem({oRow:FieldGet("pagare"),oRow:FieldGet("Ruta") + "-" + oRow:FieldGet("folio"),oRow:FieldGet("nombre");
				,oRow:FieldGet("domicilio")})
				If n=500
					Do Events
					n:=1
				EndIf 
				n++
			Next
			bQuery:Destroy()
	Else 
		cQuery := "select pagare, ruta, folio, nombre, domicilio From Pagares where domicilio like '%" + browpag.text_4.Value +;
					 "%'"
			bQuery := oServer:Query (cQuery)
			If bQuery:NetErr()
				Msgstop(bQuery:Error())
				Return Nil
			EndIf 
			MsgBox( bQuery:LastRec(),"10")
			n:=1
			browpag.grid_1.DeleteAllItems()
			For i=1 To bQuery:LastRec()
				oRow := bQuery:GetRow(i)
				browpag.grid_1.AddItem({oRow:FieldGet("pagare"),oRow:FieldGet("Ruta") + "-" + oRow:FieldGet("folio"),oRow:FieldGet("nombre");
				,oRow:FieldGet("domicilio")})
				If n=500
					Do Events
					n:=1
				EndIf 
				n++
			Next
			bQuery:Destroy()
   endif
/*   browpag.browse_1.value:=pagares->(recno())
   browpag.browse_1.refresh
   browpag.browse_1.setfocus*/
return

function ponvalbskapag //el dato traido de buscar pagare
   declare window browpag
   declare window conspag
	pagLinea := browpag.Grid_1.Value 
	pagValue := browpag.Grid_1.Item (pagLinea)
	conspag.text_3.Value := pagValue[1]
    /*conspag.text_3.value:=pagares->pagare
    browpag.release
   seekpagare()*/
	browpag.release
	conspag.text_3.SetFocus 
return

function seekpagare
   declare window conspag
   if empty(conspag.text_3.value)
      MsgInfo('Tiene que ingresar el numero de pagare','Mensaje del Sistema')
      conspag.text_3.value:=space(7)
      conspag.text_3.setfocus
      return
   EndIf 
	If len(conspag.text_3.value) < 7
		conspag.text_3.Value := strzero(val(conspag.text_3.value),7)
	EndIf 
	cQuery := "select * from Pagares Where pagare='" +conspag.text_3.Value + "'"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
	 	MsgInfo('No se encontro el Pagare','Mensaje del Sistema')
      conspag.text_3.Value:=space(7)
      conspag.text_3.setfocus
        return Nil
    EndIf
    conspag.button_3.enabled:=.t.
	oRow := bQuery:GetRow(1)
	tmpruta := oRow:FieldGet("ruta")
	tmpfolio := oRow:FieldGet("folio")
	tmpnombre := oRow:FieldGet("nombre")
	tmpdomicilio := oRow:FieldGet("domicilio")
	tmpfecha_act := oRow:FieldGet("fecha_act")
	tmpfecha_ven := oRow:FieldGet("fecha_ven")
	tmpconcepto := oRow:FieldGet("concepto")
	tmpcontrato := oRow:FieldGet("contrato")
	tmpnva_cita := oRow:FieldGet("nva_cita")
	tmptotal := oRow:FieldGet("total")
MsgBox(tmpconcepto,"")
  /* select pagares
   set order to 6
   seek conspag.text_3.value*/
   
   apagares:={}
   if conspag.Grid_1.ItemCount > 0
      conspag.Grid_1.DeleteallItems()
   endif
   conspag.Grid_1.refresh
   conspag.text_4.value:=tmpruta
   conspag.text_5.value:=tmpfolio
   conspag.text_6.value:=tmpnombre
   conspag.text_7.value:=tmpdomicilio
   conspag.text_8.value:=tmpfecha_act
   conspag.text_9.value:=tmpfecha_ven
   conspag.text_11.value:=iif(empty(tmpcontrato),"000000",strzero(tmpcontrato,6))
   //conspag.text_12.value:=tmpnva_cita
   conspag.dp1.value:=tmpnva_cita
	n:=1
	For n=1 To len(CatTpg)
		If CatTpg[n,1] = tmpconcepto
			MsgBox(n,CatTpg[n,2])
			conspag.combo_1.value:= n
			//edocta.text_6.value:= CatDia[n,13]
			exit
		EndIf 
	Next
/*	for k=1 to 9
      if pagares->concepto = aopcombo[k]
         conspag.combo_1.value:=k
	 exit
      endif
   next*/
bQuery:Destroy()
	varivapag:=0
	cQuery := "select * from Ivapag Where pagare='" +conspag.text_3.Value + "'"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
   Endif
   if bQuery:LastRec() > 0
	 	oRow := bQuery:GetRow(1)
		tmipago_act := oRow:FieldGet("pago_act")
		varivapag:=varivapag + tmipago_act
	EndIf
	conspag.text_13.value:=tmptotal + varivapag
	/*select ivapag
	set order to 1
	seek conspag.text_3.value
   if found()
      do while ivapag->pagare = conspag.text_3.value
         if ivapag->pagare = conspag.text_3.value*/
  				
/*			endif
			skip
		enddo   
	endif*/
   mpagos:=0
	madeudodoc:=0
	bQuery:Destroy()
	cQuery := "select * from Pagdoc Where pagare='" +conspag.text_3.Value + "'"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
   Endif
   if bQuery:LastRec() > 0
	 	For i=1 To bQuery:LastRec()
			oRow := bQuery:GetRow(i)
			tmdpago_act := oRow:FieldGet("pago_act")
			tmdpagare := oRow:FieldGet("pagare")
			tmdfecha_pag := oRow:FieldGet("fecha_pag")
		if tmdpagare = val(conspag.text_3.value)
         conspag.Grid_1.AddItem ( {dtoc(tmdfecha_pag),transform(tmdpago_act,'999,999,999.99')} )
			if tmdfecha_pag <> ctod("  /  /    ")
  				mpagos:=mpagos + tmdpago_act
         else
				madeudodoc:=madeudodoc + tmdpago_act
			endif
		endif
		Next
	EndIf
	/*select pag_doc
   set order to 1
   seek conspag.text_3.value
   if found()
      do while pag_doc->pagare = conspag.text_3.value
         
			skip
      enddo
   endif*/
   conspag.text_14.value:=mpagos
   *conspag.text_15.value:=conspag.text_13.value + varivapag - conspag.text_14.value
	conspag.text_15.value:=conspag.text_13.value + -conspag.text_14.value
   //select pagares
   conspag.Grid_1.value:=conspag.Grid_1.ItemCount
   conspag.Grid_1.refresh
   conspag.grid_1.SetFocus 
	bQuery:Destroy()
return

function pongetsbon
   declare window conspag
   conspag.text_4.readonly:=.f.
   conspag.text_5.readonly:=.f.
   conspag.text_6.readonly:=.f.
   conspag.text_7.readonly:=.f.
   *conspag.text_9.readonly:=.f.
   conspag.dp1.enabled:=.t.
   *conspag.combo_1.enabled:=.t.
   conspag.text_4.SetFocus 
   conspag.button_1.enabled:=.t.
return

function guardacampag

	cQuery := "Update Pagares set ruta='" + conspag.text_4.Value + "', folio='" + conspag.text_5.Value + "',nombre='";
	+ conspag.text_6.Value + "',domicilio='" + conspag.text_7.Value + "',nva_cita='";
	+ cdate2mysqldate(conspag.dp1.value) + "' where pagare='" + conspag.text_3.Value + "'"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
   Endif
	bQuery:Destroy()
   conspag.text_1.value:=space(3)
   conspag.text_2.value:=space(60)
   conspag.text_3.value:=space(7)
   conspag.text_4.value:=space(3)
   conspag.text_5.value:=space(4)
   conspag.text_6.value:=space(60)
   conspag.text_7.value:=space(60)
   conspag.text_8.value:=ctod('  /  /    ')
   conspag.text_9.value:=ctod('  /  /    ')
   conspag.text_6.value:=space(30)
   conspag.text_7.value:=space(6)
   //conspag.text_12.value:=ctod('  /  /    ')
   conspag.dp1.Value := ctod('01/01/1900')
   conspag.text_13.value:=0
   conspag.text_14.value:=0
   conspag.text_15.value:=0
   conspag.text_4.readonly:=.t.
   conspag.text_5.readonly:=.t.
   conspag.text_6.readonly:=.t.
   conspag.text_7.readonly:=.t.
   conspag.button_1.enabled:=.f.
   conspag.button_3.enabled:=.f.
   if conspag.Grid_1.ItemCount > 0
      conspag.Grid_1.DeleteallItems()
   endif
   conspag.text_3.setfocus
return


function impdatpag
   SELECT PRINTER DEFAULT ;
   ORIENTATION PRINTER_ORIENT_PORTRAIT;
   PAPERSIZE PRINTER_PAPER_LETTER;
   QUALITY PRINTER_RES_MEDIUM 
   SELECT PRINTER DIALOG TO lSuccess PREVIEW
   If lSuccess == .T.
      start printdoc
      start printpage
      lin:=5
      a:=4
      aumento:=0
      @ lin,25 print 'Pagare :' Font "Arial" size 8 bold	right
      @ lin,30 print conspag.text_3.value Font "Arial" size 8 bold	  
      lin:=lin + 4
      @ lin,25 print 'Nombre :' Font "Arial" size 8 bold	right  
      @ lin,30 print conspag.text_6.value Font "Arial" size 8 bold	  
      lin:=lin + 4
      @ lin,25 print 'Domicilio :' Font "Arial" size 8 bold right	  
      @ lin,30 print conspag.text_7.value Font "Arial" size 8 bold	  
      lin:=lin + 4
      @ lin,25 print 'Fecha. Doc. :' Font "Arial" size 8 bold right  
      @ lin,30 print dtoc(conspag.text_8.value) Font "Arial" size 8 bold	  
      lin:=lin + 4
      @ lin,25 print 'Fecha. Ven. :' Font "Arial" size 8 bold right
      @ lin,30 print dtoc(conspag.text_9.value) Font "Arial" size 8 bold	  
      lin:=lin + 4
      @ lin,25 print 'Concepto :' Font "Arial" size 8 bold right
      @ lin,30 print acombopag[conspag.combo_1.value] Font "Arial" size 8 bold	  
      lin:=lin + 4
      @ lin,10 print 'No' Font "Arial" size 8 bold
      @ lin,30 print 'Fecha' Font "Arial" size 8 bold
      @ lin,70 print 'Pago' Font "Arial" size 8 bold
      lin:=lin + 4
      for u =1 to conspag.grid_1.ItemCount
         aValues:=conspag.grid_1.Item(u)
         @ lin,10 print transform(U,'999') Font "Arial" size 8 bold
         @ lin,30 print aValues[1] Font "Arial" size 8 bold
         @ lin,65 print aValues[2] Font "Arial" size 8 bold
         lin:=lin + 4
      next
      end printpage
      end printdoc
   endif   
return Nil



/*    @ 3,2 say 'Pagare   : '+paga
    @ 4,2 say 'Nombre   : '+left(nom,30)
    @ 5,2 say 'Domicilio: '+left(dom,30)
   	@ 6,2 say 'Fec. Doc.: '
   	@ 6,13 say fedoc
   	@ 7,2 say 'Fec. Ven.: '
   	@ 7,13 say feven
   	@ 8,2 say 'Concepto : '
   	@ 8,13 say CONCEP
   	@ 9,2 say 'Localizac: '+rut+'-'+fol
   	@ 13,15 say 'Valor    : '
   	@ 13,26 say valo picture '999,999.99'
   	@ 14,15 say 'Abonos   : ' 
   	@ 14,26 say abos picture '999,999.99' color n/w
   	@ 15,15 say 'Saldo    : ' 
   	@ 15,26 say valo-abos picture '999,999.99' color n/w
    
    @ 17,3 say 'No.'+spac(02)+'Fecha'+spac(02)+'Pago'
    x = 18
    y = 3
    n = 1
    do while .not. eof()
       @ x,y say transf(n,'99')+spac(02)+dtoc(fecha_pag)+spac(02)+transf(pago_act,'999,999.99')
       if eof()
          exit
       endif
       skip
       n = n +1
       x = x+1
       if x = 55
          x = 18
          y = 40
       endif   
    enddo   
    eject
    set print to
    set devi to screen*/
