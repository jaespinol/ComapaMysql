#include <hmg.ch>

function loadLecturas
   IF !IsWindowDefined(Lecturas) 
       Load Window Lecturas
       Center Window Lecturas
//       on key ALT+F8 of Lecturas action duplicados()
      // Lecturas.Maximize
	   buscaulec()
       Activate Window Lecturas
   endIf
return

//Pendiente contraseña
function buscaulec
/*	Local nLinea:=0, aValue:={}
	 declare window lecturas
//	 If main.Grid_6.Value =0
		aValue := hb_blowfishencrypt(mvarpas,alltrim(lecturas.text_1.value))
//	Else
//		nLinea := main.Grid_6.Value 
//		aValue := main.Grid_6.Item (nLinea)
//	EndIf 
	cQuery := "Select Id, Nombre From Trabajadores Where Contrasena = " + aValue[1]
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
        return Nil
    EndIf 
	oRow := bQuery:GetRow(1)
//	main.text_32.Value := oRow:FieldGet("Id")
	Lecturas.text_2.Value := oRow:FieldGet("Nombre")
	
	bQuery:Destroy()

  
   select capturis
   seek lecturas.text_1.value
   if !found()
      MsgInfo('No existe la clave','Mensaje del Sistema')
      lecturas.text_1.value:=space(3)
      lecturas.text_1.setfocus
      return
   endif*/
   //lecturas.text_2.value:=capturis->nom_captur
   lecturas.text_1.readonly:=.t.
   lecturas.text_3.readonly:=.f.
   lecturas.text_4.readonly:=.f.
   lecturas.edit_1.readonly:=.f.  
   lecturas.combo_1.setfocus
return
//****************************************************************
function buscapadlec
Local nLinea:=0, aValue:="", tmpfalla:=""
declare window lecturas
   if lecturas.text_4.value = 0
      MsgInfo('Tiene que dar el folio','Mensaje del Sistema')     
      lecturas.text_4.value:=0
      lecturas.text_4.setfocus
      flagop:=.f.
      return
   EndIf 
   		aValue := strzero(lecturas.text_3.value,3)+strzero(lecturas.text_4.value,4)
	//MsgBox(avalue)
	  mactual:='lec'+strzero(MOD(lecturas.combo_1.value+10,12)+1,2)
      manterior:='lec'+strzero(MOD(lecturas.combo_1.value+9,12)+1,2)
      mfecante:='fec'+strzero(mod(lecturas.combo_1.value+9,12)+1,2)
      mfecact:='FEC'+strzero(mod(lecturas.combo_1.value+10,12)+1,2)
      mFalla:='NOLEC'+strzero(MOD(lecturas.combo_1.value+10,12)+1,2)
	cQuery := "Select Nombre, Domicilio, Medidor, Meses_Rez, Tarifa From Padron Where Ruta='" +;
	strzero(lecturas.text_3.value,3)  + "' and Folio = '" + strzero(lecturas.text_4.value,4) + "'"
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
	
	Lecturas.text_5.Value := oRow:FieldGet("Medidor")
    Lecturas.text_6.Value := oRow:FieldGet("Meses_rez")
	Lecturas.text_7.Value := oRow:FieldGet("Nombre")
	Lecturas.text_8.Value := oRow:FieldGet("Domicilio")
	 
	bQuery:Destroy()
	 cQuery ="Select " + mactual + ", " + manterior + ", " + mfecante + ", " + mfecact + ", " + mfalla + ", informa " +;
	"from Lecturas where Ruta = '" + strzero(lecturas.text_3.value,3) + "' and Folio = '" + strzero(lecturas.text_4.value,4) + "'" 
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
		tmpfalla := oRow:FieldGet(mfalla)
	If  tmpfalla = 'M'
		MsgBox('El usuario tiene cuota fija','Mensaje del Sistema')
//	 	lecturas.text_3.value:=0
		lecturas.text_4.value:=0
        lecturas.text_4.SetFocus 
		Lecturas.text_5.Value := ""
		Lecturas.text_6.Value := 0
		Lecturas.text_7.Value := ""
		Lecturas.text_8.Value := ""
        flagop:=.f.
        return
	EndIf 
	  lecturas.text_9.value:=oRow:FieldGet(mactual)
	  lecturas.text_10.value:=oRow:FieldGet(mfecact)
	  lecturas.text_11.value:=oRow:FieldGet(mfalla)
      lecturas.text_12.value:=oRow:FieldGet(manterior)
      lecturas.edit_1.value:=oRow:FieldGet("informa")

	flagop:=.t.
    lecturas.text_5.ReadOnly := .T.
	lecturas.text_12.ReadOnly := .T.

   on key F10 of lecturas action ponfechant()
   on key F5  of lecturas action ponmedil()
   on key ESCAPE of lecturas action limpialec()

Return

function ponbanlec
   flagop:=.t.
return


function sinoescerolec
   declare window lecturas
   if lecturas.text_4.value = 0
      MsgInfo('Tiene que dar el folio','Mensaje del Sistema')     
      lecturas.text_4.value:=0
      lecturas.text_4.setfocus
      flagop:=.f.
      return
   endif
return

function grabalectus
Local tmpfalla := ""
   declare window lecturas
	   if flagop=.t.
		   If lecturas.text_11.Value = ""
				tmpfalla := " "
		   Else
				tmpfalla := lecturas.text_11.Value
		   EndIf 
			cQuery := "Update Lecturas set " + mactual + "=" + str(Lecturas.Text_9.Value) +;
					  ", " + mfecact + "='" + cdate2mysqldate(Lecturas.Text_10.Value) + "', " + mfalla + "='" + tmpfalla + "', informa ='" +;
					  lecturas.edit_1.Value + "' where Ruta = '" + strzero(lecturas.text_3.value,3) +;
					  "' and Folio = '" + strzero(lecturas.text_4.value,4) + "'"
					  //msgbox(cQuery)
		    bQuery:=oServer:Query(cQuery)
				If bQuery:NetErr()												
					MsgStop(bQuery:Error())
					return Nil
				Endif
			bQuery:Destroy()
					If guardamed:=.t.
						cQuery := "Update Padron set medidor ='" + Lecturas.Text_5.Value +;
						"' where Ruta = '" + strzero(lecturas.text_3.value,3) + "' and Folio = '" + strzero(lecturas.text_4.value,4) + "'"
						//msgbox(cQuery)
						bQuery:=oServer:Query(cQuery)
							If bQuery:NetErr()												
								MsgStop(bQuery:Error())
								return Nil
							Endif
						bQuery:Destroy()
					EndIf 
          limpialec()
	   endif
return

Function limpialec()
		  lecturas.text_5.value:=""
		  lecturas.text_6.value:=0
		  lecturas.text_7.value:=""
		  lecturas.text_8.value:=""
		  lecturas.text_9.value:=0
		  lecturas.text_11.value:=""
		  lecturas.text_12.value:=0
		  lecturas.edit_1.value:=""
		  lecturas.edit_1.Value := ""
		  lecturas.text_4.value:=0
		  lecturas.text_4.SetFocus 
		  guardamed:=.f.
Return Nil

function validafechal
    declare window lecturas
	cQuery ="Select " + mfecante + " from Lecturas where Ruta = '" + strzero(lecturas.text_3.value,3) +;
			"' and Folio = '" + strzero(lecturas.text_4.value,4) + "'" 
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

    if lecturas.text_10.value < oRow:FieldGet(mfecante)
       MsgInfo('Error! Mes Actual < Mes Anterior','Mensaje del Sistema')     
       lecturas.text_10.setfocus
       return
    else
       if lecturas.text_10.value - oRow:FieldGet(mfecante) > 45
          MsgInfo('Error! Mes Actual Muy Alto','Mensaje del Sistema')     
          lecturas.text_10.setfocus
	  return
       else
          if month(lecturas.text_10.value)=month(oRow:FieldGet(mfecante))
             MsgInfo('Error! Mes Actual = Mes Anterior','Mensaje del Sistema')     
             lecturas.text_10.setfocus
   	     return
	  endif
       endif
    EndIf 
	 bQuery:Destroy()
return

function ponfechant
   declare window lecturas
   lecturas.text_12.readonly:=.f.
   lecturas.text_12.setfocus
return

function ponmedil
   declare window lecturas
   lecturas.text_5.readonly:=.f.
   lecturas.text_5.SetFocus 
guardamed:=.t.
return

function ponfallal
   declare window lecturas
   if empty(lecturas.text_9.value)
       lecturas.text_11.readonly:=.f.
       lecturas.text_11.setfocus
   endif
return


function validafallal
   declare window lecturas
   If lecturas.text_11.value=[A] .Or. lecturas.text_11.value=[B] .Or. lecturas.text_11.value=[C] .Or. lecturas.text_11.value=[D] .Or. lecturas.text_11.value=[E] .Or. lecturas.text_11.value=[F] .Or. lecturas.text_11.value=[G] .Or. lecturas.text_11.value=[H] .Or. lecturas.text_11.value=[I] .Or. lecturas.text_11.value=[J] .Or. lecturas.text_11.value=[O] .Or. lecturas.text_11.value=[L] .Or. lecturas.text_11.value=[M] .Or. lecturas.text_11.value=[ ]
      lecturas.text_10.setfocus
   else
      MsgInfo('No existe esta falla','Mensaje del Sistema')     
      lecturas.text_11.setfocus
   EndIf
   lecturas.text_11.readonly:=.t.
return