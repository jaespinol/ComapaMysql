#include <hmg.ch>

function cambryf
   public flagop:=.f.,mfecante,flagentra:=0
   IF !IsWindowDefined(asigryf) 
       Load Window asigryf
       Center Window asigryf
       asigryf.tab_1.enabled:=.f.
       asigryf.grid_1.enabled:=.f.
       asigryf.grid_1.refresh
       Activate Window asigryf
   endIf
return

function bscapascrf
   declare window asigryf
   /*select capturis
   seek asigryf.text_1.value
   if !found()
      MsgInfo('No existe la clave','Mensaje del Sistema')
      asigryf.text_1.value:=space(3)
      asigryf.text_1.setfocus
      return
   endif*/
   //asigryf.text_2.value:=capturis->nom_captur
   asigryf.tab_1.enabled:=.t.
   asigryf.grid_1.refresh
   asigryf.text_3.setfocus
return

function llenarr()
   local arrows [17] [2]
   arrows[1]:={0 ,'Facturacion'}
   arrows[2]:={0 ,'Historicos Facturacion'}
   arrows[3]:={0 ,'Lecturas'}
   arrows[4]:={0 ,'Pagos'}
   arrows[5]:={0 ,'Bonificaciones'}
   arrows[6]:={0 ,'Documentos'}
   arrows[7]:={0 ,'Inspecciones'}
   arrows[8]:={0 ,'Ordenes de Trabajo'}
   arrows[9]:={0 ,'R.F.C.(s)'}
   arrows[10]:={0 ,'Padron'}
   arrows[11]:={0 ,'Cambios Padron'}
   arrows[12]:={0 ,'Reporte de Cambios'}
   arrows[13]:={0 ,'Pensionados'}
   arrows[14]:={0 ,'Cortes'}
   arrows[15]:={0 ,'Recibos Diversos'}
   arrows[16]:={0 ,'Historico de Recibos Diversos'}
   arrows[17]:={0 ,'Medidores'}
return arrows

function buscapadrc1
Local tmpcve:=""
   declare window asigryf+
	cQuery := "Select Nombre, Domicilio From Padron Where Ruta='" + asigryf.text_3.value  + "' and Folio = '" + asigryf.text_4.value + "'"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
		//MsgBox(bQuery)
    if bQuery:LastRec() = 0
	 	MsgInfo('No se encontro al usuario','Mensaje del Sistema')
      asigryf.text_3.value:=space(3)
      asigryf.text_4.value:=space(4)
      asigryf.text_3.setfocus
        return Nil
    EndIf
	oRow := bQuery:GetRow(1)
	asigryf.text_5.Value := oRow:FieldGet("Nombre")
	asigryf.text_6.Value := oRow:FieldGet("Domicilio")
	bQuery:Destroy()
	cQuery := "Select cve_venc From Rutas Where cve_Ruta='" +	asigryf.text_3.value  + "'"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
		//MsgBox(bQuery)
    if bQuery:LastRec() = 0
        return Nil
    EndIf
	oRow := bQuery:GetRow(1)
	tmpcve := oRow:FieldGet("cve_venc")
	bQuery:Destroy()
	cQuery := "Select periodo, fecha_fact From Fechafa Where Venc='" +	tmpcve + "' Order By fecha_fact"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
		//MsgBox(bQuery)
    if bQuery:LastRec() = 0
        return Nil
    EndIf
	oRow := bQuery:GetRow(bQuery:LastRec()) //bQuery:GetRow(1)
	//tmpcve := oRow:FieldGet("Periodo")
	//tmpcve := oRow:FieldGet("fecha_fact")
   asigryf.text_7.value:=oRow:FieldGet("Periodo") + ' | ' + dtoc(oRow:FieldGet("fecha_fact"))
	bQuery:Destroy()
return

function buscapadrc2
Local cv_nva:=""
   declare window asigryf
    cQuery := "Select cve_venc From Rutas Where cve_Ruta='" +	asigryf.text_3.value  + "'"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
		//MsgBox(bQuery)
    if bQuery:LastRec() = 0
			MsgInfo('No se encontro la Ruta','Mensaje del Sistema')
			asigryf.text_3.value:=space(3)
			asigryf.text_4.value:=space(4)
			asigryf.text_3.setfocus
         return Nil
    EndIf
	oRow := bQuery:GetRow(1)
	cv_nva := oRow:FieldGet("cve_venc")
	bQuery:Destroy()
	cQuery := "Select Nombre From Padron Where Ruta='" + asigryf.text_8.value  + "' and Folio = '" + asigryf.text_9.value + "'"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
		//MsgBox(bQuery)
    if bQuery:LastRec() > 0
	 	MsgInfo('El usuario ya existe','Mensaje del Sistema')
      asigryf.text_8.value:=space(3)
      asigryf.text_9.value:=space(4)
      asigryf.text_8.setfocus
        return Nil
    EndIf
	bQuery:Destroy()
	cQuery := "Select periodo, fecha_fact From Fechafa Where Venc='" +	cv_nva + "' Order By fecha_fact"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
		//MsgBox(bQuery)
    if bQuery:LastRec() = 0
        return Nil
    EndIf
	oRow := bQuery:GetRow(bQuery:LastRec()) //bQuery:GetRow(1)
	//tmpcve := oRow:FieldGet("Periodo")
	//tmpcve := oRow:FieldGet("fecha_fact")
   asigryf.text_10.value:=oRow:FieldGet("Periodo") + ' | ' + dtoc(oRow:FieldGet("fecha_fact"))
	bQuery:Destroy()

return

/*function buscarutcam
   declare window asigryf
   select rutas
   if !empty(asigryf.text_11.value)
       set order to 1
       seek asigryf.text_11.value
       if !found()
          MsgInfo('La ruta no existe','Mensaje del Sistema')
          asigryf.text_11.value:=space(3)
          asigryf.text_11.setfocus
          return
       endif
    endif
return*/



function iniuno
   declare window asigryf
   if empty(asigryf.text_3.value)
      asigryf.text_3.setfocus
      return
   endif
   if empty(asigryf.text_4.value)
      asigryf.text_4.setfocus
      return
   endif
   if empty(asigryf.text_8.value)
      asigryf.text_8.setfocus
      return
   endif
   if empty(asigryf.text_9.value)
      asigryf.text_9.setfocus
      return
   endif
   cambialoc(asigryf.text_3.value,asigryf.text_4.value,asigryf.text_8.value,asigryf.text_9.value)
   MsgInfo('Proceso Terminado','Mensaje del Sistema')
   /*ponbardnvo()
   asigryf.text_3.value:=space(3)
   asigryf.text_4.value:=space(4)
   asigryf.text_5.value:=space(60)
   asigryf.text_6.value:=space(60)
   asigryf.text_7.value:=space(30)
   asigryf.text_8.value:=space(8)
   asigryf.text_9.value:=space(9)
   asigryf.text_10.value:=space(30)
   asigryf.text_3.setfocus*/
return

/*
function divideruta
   local rutold,folold,rutnva,folnvo
   declare window asigryf
   if empty(asigryf.text_11.value)
      asigryf.text_11.setfocus
      return
   endif
   if empty(asigryf.text_12.value)
      asigryf.text_12.setfocus
      return
   endif
   select refolio
   zap
   numini:=asigryf.text_12.value
   numpos:=0
   select padron
   seek asigryf.text_11.value
   do while padron->ruta = asigryf.text_11.value
      select refolio
      rutnvaini:=strzero(numini,4)
      append blank
      refolio->folio1:=padron->folio
      refolio->folio2:=rutnvaini
      select padron
      skip
      if eof()
         exit
      endif
      numini:=numini+asigryf.text_12.value
      if numini > 9999
         MsgInfo('No se puede Refoliar con ese incremento','Mensaje del Sistema')
         asigryf.text_12.value:=0
         asigryf.text_12.setfocus
         return
      endif
   enddo
   select refolio
   go bott
   do while .not. refolio->(bof())
      if refolio->folio1 > refolio->folio2
         MsgInfo('No se puede Refoliar con ese incremento','Mensaje del Sistema')
         asigryf.text_12.value:=0
         asigryf.text_12.setfocus
         return
      endif	
      skip -1
      if refolio->(bof())
 	 exit
      endif
   enddo
   select refolio
   go bott
   do while .not. bof()
      rutold:=asigryf.text_11.value
      rutnva:=asigryf.text_11.value
      folold:=folio1
      folnvo:=folio2
      asigryf.text_13.value:=asigryf.text_11.value+'-'+folold
      select padron
      seek rutold+folold
      if found()
         asigryf.text_14.value:=padron->nombre
	 asigryf.text_15.value:=padron->Domicilio
      endif
      asigryf.text_16.value:=asigryf.text_11.value+'-'+folnvo
      cambialoc(rutold,folold,rutnva,folnvo)
      ponbardnvo()
      select refolio
      if bof()
         exit
      endif
      skip -1
   enddo
   MsgInfo('Proceso Terminado','Mensaje del Sistema')
return*/


function cambialoc
local:=basesdd:={}
   parameters rutant,folant,rutnva,folnva
   declare window asigryf
	//aadd(basesdd,"Abonos")
	aadd(basesdd,"Medis")
	aadd(basesdd,"Mediinst")
	aadd(basesdd,"Histotr")
	//aadd(basesdd,"Otro_ser")
	//aadd(basesdd,"Cortenvo") no aplica
	//aadd(basesdd,"Pension")
	aadd(basesdd,"Padrmov")
	//aadd(basesdd,"Rfc")
	aadd(basesdd,"Varios")
	//aadd(basesdd,"Ordenes")
	aadd(basesdd,"Pagares")
	aadd(basesdd,"Bonifica")
	aadd(basesdd,"Histbon")
	aadd(basesdd,"Dia_pag")
	aadd(basesdd,"Histpag")
	aadd(basesdd,"Histpap")
	aadd(basesdd,"Lecturas")
	aadd(basesdd,"Facthis")
	//aadd(basesdd,"Fact_h93")
	//aadd(basesdd,"Fact_h94")
	//aadd(basesdd,"Fact_h95")
	//aadd(basesdd,"Fact_h96")
	//aadd(basesdd,"Fact_h97")
	//aadd(basesdd,"Fact_h98")
	//aadd(basesdd,"Fact_h99")
	aadd(basesdd,"Facth00")
	aadd(basesdd,"Facth01")
	//aadd(basesdd,"Fact_h02")
	aadd(basesdd,"Factant")
	aadd(basesdd,"Padron")

cQuery := "Update Padron set Ruta_ant=ruta,folio_ant=folio where ruta='" + rutant + "' and folio='" + folant + "'"
		bQuery:=oServer:Query(cQuery)
				If bQuery:NetErr()												
					MsgStop(bQuery:Error())
					return Nil
				EndIf 
			bQuery:Destroy()

For i=1 To len(basesdd)

		cQuery := "Update " + basesdd[i] + " set Ruta='" + rutnva + "',folio='" + folnva + "' where ruta='" + rutant + "' and folio='" + folant + "'"
		MsgBox(cQuery,"")
		bQuery:=oServer:Query(cQuery)
				If bQuery:NetErr()												
					MsgStop(bQuery:Error())
					return Nil
				EndIf 
			bQuery:Destroy()
Next
	
//-------------
 /*  
	select fact_ant
   seek rutant+folant
   if found()
      
   endif
   aTemp := asigryf.Grid_1.Item(1)
   asigryf.Grid_1.Item (1) := { 1 ,atemp[2]}
   asigryf.Grid_1.refresh
   do events
   ardbf:={"fact_h93","fact_h94","fact_h95","fact_h96","fact_h97","fact_h98","fact_h99","fact_h00","fact_h01","fact_h02"} 
   noabrio:=''
   for anio=1 to 10
      dbfopen:=ardbf[anio]
      if !abrearch('50',dbfopen,dbfopen,{dbfopen},1)
         MsgInfo('La base de datos '+"fecha_fac"+' esta en uso exclusivo','Mensaje del Sistema')
      endif
      select 50
      do while .t.
         seek rutant+folant
         if !found()
            exit
        endif
	exit
      enddo
      exit
   next
//-------------
   select fact_his
   seek rutant+folant
   if found()

   endif
   aTemp := asigryf.Grid_1.Item(2)
   asigryf.Grid_1.Item (2) := { 1 ,atemp[2]}
//-------------
   select lecturas
   seek rutant+folant
   if found()

   endif
   aTemp := asigryf.Grid_1.Item(3)
   asigryf.Grid_1.Item (3) := { 1 ,atemp[2]}
//-------------
   select hist_pap
   do while .t.
      seek rutant+folant
      if !found()
         exit
      endif
      exit
   enddo
//-------------
   select hist_pag
   do while .t.
      seek rutant+folant
      if !found()
         exit
      endif
      exit
   enddo
//-------------
   select dia_pag
   set order to 2
   do while .t.
      seek rutant+folant
      if !found()
         exit
      endif
      exit
   enddo
   aTemp := asigryf.Grid_1.Item(4)
   asigryf.Grid_1.Item (4) := { 1 ,atemp[2]}
//-------------
   set order to 1
   select hist_bon
   do while .t.
      seek rutant+folant
      if !found()
         exit
      endif
      exit
   enddo
//-------------
   select bonifica
   set order to 2
   do while .t.
      seek rutant+folant
      if !found()
         exit
      endif
      exit
   enddo
   aTemp := asigryf.Grid_1.Item(5)
   asigryf.Grid_1.Item (5) := { 1 ,atemp[2]}
   set order to 1
//-------------
   select pagares
   set order to 5
   do while .t.
      seek rutant+folant
      if !found()
         exit
      endif
      exit
   enddo
   aTemp := asigryf.Grid_1.Item(6)
   asigryf.Grid_1.Item (6) := { 1 ,atemp[2]}
   set order to 1
   ** falta inspecc
//-------------
   *select ordenes
   *do while .t.
   *   seek asigryf.text_3.value+asigryf.text_4.value
   *   if !found()
   *      exit
   *   endif
   *enddo
   aTemp := asigryf.Grid_1.Item(7)
   asigryf.Grid_1.Item (7) := { 1 ,atemp[2]}
//-------------
   select varios
   do while .t.
      seek rutant+folant
      if !found()
         exit
      endif
      exit
   enddo
   aTemp := asigryf.Grid_1.Item(8)
   asigryf.Grid_1.Item (8) := { 1 ,atemp[2]}
//-------------
   select rfc
   seek rutant+folant
   if found()

   endif
   aTemp := asigryf.Grid_1.Item(9)
   asigryf.Grid_1.Item (9) := { 1 ,atemp[2]}
//-------------
   select padron
   seek rutant+folant
   if found()

   endif
   aTemp := asigryf.Grid_1.Item(10)
   asigryf.Grid_1.Item (10) := { 1 ,atemp[2]}
//-------------
   select padrmov
   do while .t.
      seek rutant+folant
      if !found()
         exit
      endif
      exit
   enddo
   **alta en padrmov

   aTemp := asigryf.Grid_1.Item(11)
   asigryf.Grid_1.Item (11) := { 1 ,atemp[2]}
   select n_rutfol
   aTemp := asigryf.Grid_1.Item(12)
   asigryf.Grid_1.Item (12) := { 1 ,atemp[2]}
//-------------
   select pension
   set order to 3
   seek rutant+folant
   if found()

   endif
   set order to 1
   aTemp := asigryf.Grid_1.Item(13)
   asigryf.Grid_1.Item (13) := { 1 ,atemp[2]}
//-------------
   select cortenvo
   do while .t.
      seek rutant+folant
      if !found()
         exit
      endif
      exit
   enddo
   aTemp := asigryf.Grid_1.Item(14)
   asigryf.Grid_1.Item (14) := { 1 ,atemp[2]}
//-------------
   select otro_ser
   do while .t.
      seek rutant+folant
      if !found()
         exit
      endif
      exit
   enddo
   aTemp := asigryf.Grid_1.Item(15)
   asigryf.Grid_1.Item (15) := { 1 ,atemp[2]}
//-------------
   select hist_otr
   do while .t.
      seek rutant+folant
      if !found()
         exit
      endif
      exit
   enddo
   aTemp := asigryf.Grid_1.Item(16)
   asigryf.Grid_1.Item (16) := { 1 ,atemp[2]}
//-------------
   select mediinst
   do while .t.
      seek rutant+folant
      if !found()
         exit
      endif
      exit
   enddo
//-------------
   select medis
   do while .t.
      seek rutant+folant
      if !found()
         exit
      endif
      exit
   enddo
//-------------
	select abonos
   do while .t.
      seek rutant+folant
      if !found()
         exit
      endif
      exit
   enddo
   aTemp := asigryf.Grid_1.Item(17)
   asigryf.Grid_1.Item (17) := { 1 ,atemp[2]}*/
return

/*
function ponbardnvo
   declare window asigryf
   for y=1 to 17
      aTemp := asigryf.Grid_1.Item(y)
      asigryf.Grid_1.Item (y) := { 0 ,atemp[2]}
   next
return
*/