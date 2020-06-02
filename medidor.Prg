#include <hmg.ch>


function medidor
   public flagop:=1
   IF !IsWindowDefined(medidor) 
       Load Window medidor
       Center Window medidor
       Activate Window medidor
		 //cargamed()
	endIf
return

Function aumentamed()
ahora++
medidor.button_1.enabled:=.f.
medidor.button_2.enabled:=.f.
medidor.grid_2.enabled:=.f.
cargamed()
Return Nil

Function disminuyemed()
ahora--
medidor.button_1.enabled:=.f.
medidor.button_2.enabled:=.f.
medidor.grid_2.enabled:=.F.
cargamed()
Return Nil

Function cargamed()
Local tmptam_med:="", n:=0,hojas:=0, filaini:=0, filafin:=0,tmpautorizo:="", tmpcapturo:="", l:=0
declare Window medidor
	cQuery := "Select ruta, folio, autorizo, capturo, cantidad, tam_med, fecha From Mediinst Order By ruta,folio"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
        return Nil
    EndIf 
	i:=1
		medidor.grid_2.DeleteAllItems()
		hojas:= round(bQuery:LastRec()/1000,0)
		medidor.label_1.Value := "Hoja"+str(ahora)+" / "+str(hojas)
		filafin:=ahora*1000
		filaini:=filafin-1000
//If primer= 1
	For i := filaini To filafin //bQuery:LastRec() //
		If L=500
			doevents()
			L=0
		EndIf 
		L++
	//MsgBox(bQuery:LastRec(),"")
	//For i = 1 To bQuery:LastRec()
	//	medidor.label_1.Value := Str(i) + "," + Str(bQuery:LastRec())
		oRow := bQuery:GetRow(i)
		tmpruta:=oRow:FieldGet("Ruta")
		tmpfolio:=oRow:FieldGet("Folio")
		n:=1
		For n=1 To len(CatAut)
			If CatAut[n,1] = oRow:FieldGet("autorizo")
				tmpautorizo:= CatAut[n,2]
				exit
			EndIf 
		Next
		n:=1
		For n=1 To len(CatCap)
			If CatCap[n,1] = oRow:FieldGet("capturo")
				tmpcapturo:= CatCap[n,2]
				exit
			EndIf 
		Next
		tmpcantidad:=oRow:FieldGet("cantidad")
		n:=1
		For n=1 To len(CatDia)
			If CatDia[n,12] = oRow:FieldGet("tam_med")//tmtToma
				tmptam_med:= CatDia[n,13]
				exit
			EndIf 
		Next
		tmpfecha:=oRow:FieldGet("fecha")
		medidor.grid_2.AddItem({tmpRuta + "-" + tmpFolio,tmptam_med,tmpfecha,transform(tmpcantidad,"999,999,999.99"),tmpautorizo,tmpcapturo})

	Next
	bQuery:Destroy()
	medidor.button_1.enabled:=.t.
	medidor.button_2.enabled:=.t.
	medidor.grid_2.enabled:=.t.
	
	medidor.grid_2.Refresh
	//bQuery:Destroy()
Return Nil

function altamedidor
declare Window medidor
   parameters flagop
   mnommed:=''
   IF !IsWindowDefined(altamedi) 
       Load Window altamedi
       Center Window altamedi
       altamedi.button_1.enabled:=.f.
       altamedi.combo_1.enabled:=.f.
       altamedi.combo_2.enabled:=.f.
	   If flagop = 2
	   buscausumed()
	   mValue := medidor.Grid_2.Item (medidor.Grid_2.Value)
	   altamedi.text_1.Value := left(mValue[1],3)
	   altamedi.text_2.Value := right(mValue[1],4)
	   buskapadmedi()
	   EndIf 
       Activate Window altamedi
   endIf
return

function buscausumed
/*   declare window altapadron
   select capturis
   seek altamedi.text_7.value
   if found()
      if capturis->estatus='A'
         if capturis->clave = 'P' .or. capturis->clave ='S'
            mpermisos:=capturis->nivel
            altamedi.text_8.value:=capturis->nom_captur
         endif 
      else
         MsgInfo('El capturista esta dado de baja','Mensaje del Sistema')
         altamedi.text_7.value:=space(3)
         altamedi.text_7.setfocus
	 return
      endif*/
      altamedi.text_1.readonly:=.f.
      altamedi.text_2.readonly:=.f.
      altamedi.text_3.readonly:=.f.
      altamedi.text_4.readonly:=.f.
      altamedi.text_5.readonly:=.f.
      altamedi.text_6.readonly:=.f.
  /* else   
      MsgInfo('La clave no existe','Mensaje del Sistema')
      altamedi.text_7.value:=space(3)
      altamedi.text_7.setfocus
      return
   endif*/
return

function buskapadmedi
   declare window altamedi
   mnommed:=''
   flagencpm:=.f.
//   select padron 
//   set order to 1
//   seek altamedi.text_1.value +  
	cQuery := "Select Nombre, tipo_usu, toma From Padron where ruta='" + altamedi.text_1.Value + "' and folio='" + altamedi.text_2.Value + "'"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
	if bQuery:LastRec()=0
      MsgInfo('El usuariuo no existe','Mensaje del Sistema')
      altamedi.text_2.value:=space(4)
      altamedi.text_2.setfocus
      return
   endif
  	oRow := bQuery:GetRow(1)
	altamedi.text_3.value:=oRow:FieldGet("nombre")
	
//   select usuarios
//   seek padron->tipo_usu
//   if found()
//      altamedi.text_4.value:=usuarios->des_usu
//   EndIf 
	n:=1
	For n=1 To len(CatUsu)
		If CatUsu[n,3] = oRow:FieldGet("tipo_usu")//tmtToma
			 //tmptam_med:= CatDia[n,13]
			 altamedi.text_4.value:=CatUsu[n,2]
			 exit
		EndIf 
	Next
//   select tomas
//   set order to 1
//   seek padron->toma
	n:=1
	For n=1 To len(CatDia)
		If CatDia[n,12] = oRow:FieldGet("toma")//tmtToma
			 //tmptam_med:= CatDia[n,13]
			 altamedi.combo_1.value:=n
			 exit
		EndIf 
	Next
	bQuery:Destroy()
   mcant:=0
   salmed:=0
//   select mediinst
//   set order to 1
//   seek altamedi.text_1.value + altamedi.text_2.value
	cQuery := "Select Cantidad, autorizo From Mediinst where ruta='" + altamedi.text_1.Value + "' and folio='" + altamedi.text_2.Value + "' and borrado=0"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
	
  	oRow := bQuery:GetRow(1)
   flagencpm:=.t.
   mcant:=oRow:FieldGet("cantidad")
	n:=1
	For n=1 To len(CatAut)
		If CatAut[n,1] = oRow:FieldGet("autorizo")//tmtToma
			 //tmptam_med:= CatDia[n,13]
			 altamedi.combo_2.value:=n
			 exit
		EndIf 
	Next
	bQuery:Destroy()
//      select medis
//      set order to 1
//      seek altamedi.text_1.value + altamedi.text_2.value
	cQuery := "Select pago From Medis where ruta='" + altamedi.text_1.Value + "' and folio='" + altamedi.text_2.Value + "' and borrado=0"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
	MsgBox(bQuery:LastRec(),"")
	if bQuery:LastRec()>0
      salmed=0
			For i=1 To bQuery:LastRec()
			   oRow := bQuery:GetRow(i)
				if oRow:FieldGet("fecha_pag") = ctod("  /  /    ")
   			   salmed=salmed + oRow:FieldGet("pago")
            endif
         Next
	Elseif bQuery:LastRec()=0
		flagencpm:=.f.
   endif
bQuery:Destroy()	
   if flagencpm .and. salmed > 0 
      MsgInfo('El usuario ya tiene un medidor sin pagar','Mensaje del Sistema')
      altamedi.button_1.enabled:=.f.
      pongetmedcero()
      regresamedper(2)
      altamedi.text_1.value:=space(3)
      altamedi.text_2.value:=space(4)
      altamedi.text_1.setfocus
      return
   elseif flagencpm .and. salmed = 0 
      if MsgYesNo('Borrar medidor para dar de alta uno nuevo?')
//	      select mediinst
//         set order to 1
//         seek altamedi.text_1.value + altamedi.text_2.Value 
			cQuery := "Update Mediinst set Borrado=1 where ruta='" + altamedi.text_1.Value + "' and folio='" + altamedi.text_2.Value + "'"
			bQuery := oServer:Query(cQuery)
			If bQuery:NetErr()												
				  MsgStop ( bQuery:Error() )
				  return Nil
			Endif
			bQuery:Destroy()
//			select medis
//         set order to 1
//         seek altamedi.text_1.value + altamedi.text_2.value
         cQuery := "Update Medis set Borrado=1 where ruta='" + altamedi.text_1.Value + "' and folio='" + altamedi.text_2.Value + "'"
			bQuery := oServer:Query(cQuery)
			If bQuery:NetErr()												
				  MsgStop ( bQuery:Error() )
				  return Nil
			Endif
			bQuery:Destroy()
			/*if found()
            do while medis->ruta + medis->folio = altamedi.text_1.value + altamedi.text_2.value
   	       if medis->ruta + medis->folio = altamedi.text_1.value + altamedi.text_2.value
   	          do while .t.
                     if medis->(rlock())
                        delete
                        medis->(dbunlock())
                        exit
                     endif
		  enddo
               endif
   	       skip
            enddo
         endif*/
         altamedi.button_1.enabled:=.t.
         altamedi.combo_1.enabled:=.t.
         altamedi.combo_2.enabled:=.t.
      else
         altamedi.button_1.enabled:=.f.
         regresamedper(2)
         pongetmedcero()
         altamedi.text_1.value:=space(3)
         altamedi.text_2.value:=space(4)
         altamedi.text_1.setfocus
         return
      endif
   elseif !flagencpm .and. (mcant - salmed) = 0 
      altamedi.button_1.enabled:=.t.              
      altamedi.combo_1.enabled:=.t.
      altamedi.combo_2.enabled:=.t.
   endif
return

function ponmedrec
Local tmpcapturo:=""
   if altamedi.text_5.value  = 0 
      MsgInfo('Tiene que ingresar el valor del medidor','Mensaje del Sistema')      
      altamedi.text_5.setfocus
      return
   elseif altamedi.text_6.value = 0
      MsgInfo('Tiene que ingresar los meses a cobrar','Mensaje del Sistema')      
      altamedi.text_5.setfocus
      return
   EndIf
	n:=1
	MsgBox(altamedi.combo_1.Value,"combo 1")
	For n=1 To len(CatDia)
		If CatDia[n,1] = altamedi.combo_1.Value 
			 tmptam_med:= CatDia[n,12]
			 exit
		EndIf 
	Next
	n:=1
	MsgBox(altamedi.combo_2.Value,"combo 2")
	For n=1 To len(CatAut)
		If CatAut[n,6] = altamedi.combo_2.Value 
			 tmpautorizo:= CatAut[n,1]
			 exit
		EndIf 
	Next
	cQuery := "Insert into Mediinst (ruta,folio,autorizo,capturo,cantidad,tam_med,fecha,concepto) values ('";
		+ altamedi.text_1.Value + "','" + altamedi.text_2.Value + "','" + tmpautorizo + "','" + altamedi.text_7.Value;
		+ "'," + Str(altamedi.text_5.Value) + ",'" + tmptam_med + "','" + cdate2mysqldate(altamedi.datepicker_1.Value) + "','" + '41' +"')"
	bQuery := oServer:Query(cQuery)
		If bQuery:NetErr()												
			  MsgStop ( bQuery:Error() )
			  return Nil
		Endif
	bQuery:Destroy()
/*
	select mediinst
   append blank
   mediinst->ruta:=altamedi.text_1.value
   mediinst->folio:=altamedi.text_2.value
   mediinst->autorizo:=altamedi.combo_2.value
   mediinst->capturo:=altamedi.text_7.value 
   mediinst->cantidad:=altamedi.text_5.value
   mediinst->tam_med:=alltrim(mnommed)
   mediinst->fecha:=altamedi.datepicker_1.value
   mediinst->concepto:='41'
   mediinst->(DBCommit())
   mediinst->(dbunlock())

   select medis*/
   mpagosk:=int(altamedi.text_5.value / altamedi.text_6.value)
   ultimopag:= altamedi.text_5.value - (mpagosk * (altamedi.text_6.value - 1))
	n:=1
	for n=1 to altamedi.text_6.value - 1
	cQuery := "Insert into Medis (ruta,folio,pago,concepto) values ('";
		+ altamedi.text_1.Value + "','" + altamedi.text_2.Value + "'," + Str(mpagosk) + ",'"  + '41' +"')"
	bQuery := oServer:Query(cQuery)
		If bQuery:NetErr()												
			  MsgStop ( bQuery:Error() )
			  return Nil
		Endif
	bQuery:Destroy()
     /* append blank    
      medis->ruta:=altamedi.text_1.value
      medis->folio:=altamedi.text_2.value
      medis->pago:=mpagosk
      medis->concepto:='41'
      mediinst->(dbunlock())*/
   next
   cQuery := "Insert into Medis (ruta,folio,pago,concepto) values ('";
		+ altamedi.text_1.Value + "','" + altamedi.text_2.Value + "'," + Str(ultimopag) + ",'"  + '41' +"')"
	bQuery := oServer:Query(cQuery)
		If bQuery:NetErr()												
			  MsgStop ( bQuery:Error() )
			  return Nil
		Endif
	bQuery:Destroy()
	/*append blank    
   medis->ruta:=altamedi.text_1.value
   medis->folio:=altamedi.text_2.value
   medis->pago:=ultimopag
   medis->concepto:='41'
   medis->(dbunlock())
   medis->(DBCommitall())*/
   pongetmedcero()
   regresamedper(1)
   altamedi.text_7.value:=space(3)
   altamedi.text_8.value:=space(50)
   altamedi.text_7.setfocus
return

function pongetmedcero
   altamedi.text_1.value:=space(3)
   altamedi.text_2.value:=space(3)
   altamedi.text_3.value:=space(4)
   altamedi.text_4.value:=space(50)
   altamedi.text_5.value:=0
   altamedi.text_6.value:=0
   altamedi.combo_1.value:=0
   altamedi.combo_2.value:=0
return

function regresamedper
   parameters falgopcr
   if falgopcr = 1
      altamedi.text_1.readonly:=.t.
      altamedi.text_2.readonly:=.t.
   endif
   altamedi.text_3.readonly:=.t.
   altamedi.text_4.readonly:=.t.
   altamedi.text_5.readonly:=.t.
   altamedi.text_6.readonly:=.t.
   altamedi.combo_1.enabled:=.f.
   altamedi.combo_2.enabled:=.f.
   altamedi.button_1.enabled:=.f.
return

function ponvalnomed
   //mnommed:=tomas->des_toma
return