#include <hmg.ch>
#include <hmg.ch>
#include "hfcl.ch"
#include "fileio.ch"
#include "inkey.ch"
#include "directry.ch"
#define CRLF HB_OSNewLine()


function cdate2mysqldate
   parameters mfdate
   local mfecreturn:="	-  -  "
   if valtype(mfdate) = 'D'
      mfecreturn:=str(year(mfdate),4,0) + '-' + strzero(month(mfdate),2) + '-' + strzero(day(mfdate),2)
   else
      if valtype(mfdate) = 'C'
         mfdate:=ctod(mfdate)
         mfecreturn:=str(year(mfdate),4,0) + '-' + strzero(month(mfdate),2) + '-' + strzero(day(mfdate),2)
      endif
   endif
return(mfecreturn)


function configurasql
   if file("config.dat")
      mvarsxy:=memoread("config.dat")
      mnlines:=mlcount(mvarsxy,100)
      mysqlsevr:=hb_blowfishDecrypt(mvarpas,alltrim(memoline(mvarsxy,100,1)))
      mysqlusu:=hb_blowfishDecrypt(mvarpas,alltrim(memoline(mvarsxy,100,2)))
      mysqlpass:=hb_blowfishDecrypt(mvarpas,alltrim(memoline(mvarsxy,100,3)))
      mysqldata:=hb_blowfishDecrypt(mvarpas,alltrim(memoline(mvarsxy,100,4)))
   endif
   IF !IsWindowDefined(utilerias) 
      Load Window utilerias
      Center Window utilerias
      utilerias.text_3.value:=mysqlsevr
      utilerias.text_4.value:=mysqlusu
      utilerias.text_5.value:=mysqlpass
      utilerias.text_1.value:=mysqldata
      Activate Window utilerias
   EndIf
return Nil


function coenctarmysql
   mysqlsevr:=utilerias.text_3.value
   mysqlusu:=utilerias.text_4.value
   mysqlpass:=utilerias.text_5.value
   mysqldata:=utilerias.text_1.value
   if !connect()
      Msginfo('Imposible establecer contacto con el Servidor',"Mensaje del sistema")
   else
      Msginfo("Conección Establecida","Mensaje del sistema")
   endif
return Nil


function guardainfoservmysql
   mysqlsevr:=utilerias.text_3.value
   mysqlusu:=utilerias.text_4.value
   mysqlpass:=utilerias.text_5.value
   mysqldata:=utilerias.text_1.value
   if empty(mysqlsevr)
      Msginfo("Tiene que dar el nombre o la "+ "" + CHR(13) + "" + " direccion IP del Servdor","Mensaje del sistema")
      utilerias.text_3.setfocus
      return
   endif
   if empty(mysqlusu)
      Msginfo("Tiene que indicar el usuario de la "+ "" + CHR(13) + "" + " base de datos","Mensaje del sistema")
      utilerias.text_4.setfocus
      return
   endif
   if empty(mysqlpass)
      Msginfo("Tiene que indicar el password de la "+ "" + CHR(13) + "" + " base de datos","Mensaje del sistema")
      utilerias.text_5.setfocus
      return
   endif
   nomfile:='config.dat'
   IF (nManejador := FCREATE(nomfile, FC_NORMAL)) == -1
      ? "No se puede crear el fichero:", FERROR()
      return
   else
      fwrite(nManejador,hb_blowfishEncrypt(mvarpas,mysqlsevr) + CRLF )
      fwrite(nManejador,hb_blowfishEncrypt(mvarpas,mysqlusu) + CRLF )
      fwrite(nManejador,hb_blowfishEncrypt(mvarpas,mysqlpass) + CRLF )
      fwrite(nManejador,hb_blowfishEncrypt(mvarpas,mysqldata) + CRLF )
      FCLOSE(nManejador)
      FCLOSE(nManejador)
   endif    
return


function poncolortodo
   LOCAL hDCv, BTstructv
   nomventg:=thiswindow.name
   hDCv:= BT_CreateDC(nomventg, BT_HDC_INVALIDCLIENTAREA, @BTstructv)
   BT_DrawGradientFillVertical(hDCv, 0, 0, BT_ClientAreaWidth(nomventg), BT_ClientAreaHeight(nomventg), BLUEW, BLUEL )
   BT_DeleteDC(BTstructv)
   release hDCv
   release BTstructv
return Nil


function poncolorconfig
   LOCAL hDCv, BTstructv
   nomventg:=thiswindow.name
   hDCv:= BT_CreateDC(nomventg, BT_HDC_INVALIDCLIENTAREA, @BTstructv)
   BT_DrawGradientFillVertical(hDCv, 0, 0, BT_ClientAreaWidth(nomventg), BT_ClientAreaHeight(nomventg), WHITE, GREENL )
   BT_DeleteDC(BTstructv)
   release hDCv
   release BTstructv
return Nil


function poncolorabout
   LOCAL hDCv, BTstructv
   nomventg:=thiswindow.name
   hDCv:= BT_CreateDC(nomventg, BT_HDC_INVALIDCLIENTAREA, @BTstructv)
   BT_DrawGradientFillVertical(hDCv, 0, 0, BT_ClientAreaWidth(nomventg), BT_ClientAreaHeight(nomventg), WHITE, YELLOWL )
   BT_DeleteDC(BTstructv)
   release hDCv
   release BTstructv
return Nil


Function File_To_Buff(cFile)
   local cBuff:="", fh, nLen
   local lRetVal:=.f.
   local cFile_in := cFile
   fh:=fopen(cFile_in,0)
   if fh > -1
      nLen:= fseek(fh, 0, 2)
      if nLen > 0
         fseek(fh, 0, 0)
         cBuff:=space(nLen)
         fread(fh, @cBuff, nLen)
         cBuff:=strtran(cBuff, chr(92), "\\")
         cBuff:=strtran(cBuff, chr(0), "\0")
         cBuff:=strtran(cBuff, chr(39), "\'")
        cBuff:=strtran(cBuff, chr(34), '\"')
     endif 
   else
      cBuff := ""       
   endif
   fclose(fh)
Return(cBuff)


Function Buff_To_File(cBuff)
   local fh, nLen
   local lRetVal:=.f.
   Local cFile_out := ""
   cFile_out := "Foto1.tmp"
   cDir_Temp := GetCurrentFolder()+'\temporal\'
   if !File(cDir_Temp + cFile_out)
      fh:=fcreate(cDir_Temp + cFile_out,0)
      if fh > -1
         nLen:=fwrite(fh, cBuff)
         fclose(fh)
         if nLen==len(cBuff)
            //MsgInfo("File written back to "+cDir_Temp + cFile_out)
         endif
      endif
   endif
return(cDir_Temp+cFile_out)



function my_file2blob( cFile )
   local cBuff:="", fh, nLen
   local lRetVal:=.f.
   local cFile_in := cFile
   fh:=fopen(cFile_in,0)
   if fh > -1
      nLen:= fseek(fh, 0, 2)
      if nLen > 0
         fseek(fh, 0, 0)
         cBuff:=space(nLen)
         fread(fh, @cBuff, nLen)
         cbuff:=hb_base64encode(cbuff)
     endif 
   else
      cBuff := ""       
   endif
   fclose(fh)
return( cBuff )


function my_blob2file( cFileName, cFieldName )
   local nHandle, lReturn := .f., bFieldBlock
   bFieldBlock := fieldblock( cFieldName )
   nHandle := fcreate( cFileName )
   if nHandle = -1
      Alert("Cannot create file " + cFileName + ", export failed!")
   else
      if fwrite( nHandle, eval( bFieldBlock ) ) > 0
         lReturn := fclose( nHandle )
      else
         fclose( nHandle )
      endif
   endif
return( lReturn )


function my_fileblob( cFile )
   local cBuff:="", fh, nLen
   local lRetVal:=.f.
   local cFile_in := cFile
   fh:=fopen(cFile_in,0)
   if fh > -1
      nLen:= fseek(fh, 0, 2)
      if nLen > 0
         fseek(fh, 0, 0)
         cBuff:=space(nLen)
         fread(fh, @cBuff, nLen)
     endif 
   else
      cBuff := ""       
   endif
   fclose(fh)
return( cBuff )


Function CapsFirst( cTxt )
   Local nFor, cRet := ''
   lCaps := .t.
   For nFor := 1 to Len( cTxt )
      if lCaps
         cChar := Upper( SubStr( cTxt,nFor,1 ) )
         lCaps := .f.
      Else
         cChar := Lower( SubStr( cTxt,nFor,1 ) )
      Endif
      cRet += cChar
      if SubStr( cTxt,nFor,1 ) = ' '
         lCaps := .t.
      Endif
   Next
Return(cRet)



function busquedageneral
   parameters mvarbskagen,mvarnomgen,cuebanertexto,arcombo
   private mresultado
   if mvarbskagen = 'C'
      bskawidth:=600
      bskaheight:=100
      mresultado:=''
   elseif mvarbskagen = 'N'
      bskawidth:=300
      bskaheight:=100
      mresultado:=''
   elseif mvarbskagen = 'B'
      bskawidth:=500
      bskaheight:=200
      mresultado:=0
   endif
   if !IsWindowDefined(windowmemo) 
      DEFINE WINDOW windowmemo AT 186 , 456 WIDTH bskawidth HEIGHT bskaheight title "Busqueda X " + alltrim(mvarnomgen) MODAL nosize
         if mvarbskagen = 'C' .or. mvarbskagen = 'N' 
				DEFINE TEXTBOX Text_1
					ROW    10
					COL    20
					WIDTH  bskawidth-40
					HEIGHT 25
 					PASSWORD .F.
               FONTNAME "Arial"
               FONTSIZE 10
               TOOLTIP ""
               ONCHANGE Nil
               ONGOTFOCUS Nil
               ONLOSTFOCUS Nil
               FONTBOLD .T.
               FONTITALIC .F.
               FONTUNDERLINE .F.
               FONTSTRIKEOUT .F.
               ONENTER memocanok(mvarbskagen)
               HELPID Nil
               TABSTOP .F.
               VISIBLE .T.
               READONLY .F.
               RIGHTALIGN .F.
               DISABLEDBACKCOLOR Nil
               DISABLEDFONTCOLOR Nil
               CASECONVERT UPPER
               MAXLENGTH 40
               BACKCOLOR NIL
               FONTCOLOR NIL
               INPUTMASK Nil
               FORMAT Nil
               VALUE ""
				END TEXTBOX
			endif
			if mvarbskagen = 'B'
            DEFINE COMBOBOX Combo_1
					ROW 10
   				COL 20
  					WIDTH bskawidth-60
					HEIGHT bskaheight
					ITEMS arcombo
   				VALUE 0
					FONTNAME "Arial"
               FONTSIZE 10
               TOOLTIP ""
               ONCHANGE Nil
               ONGOTFOCUS Nil
               ONLOSTFOCUS Nil
               FONTBOLD .T.
               FONTITALIC .F.
               FONTUNDERLINE .F.
               FONTSTRIKEOUT .F.
               HELPID Nil
               TABSTOP .T.
               VISIBLE .T.
               SORT .F.
               ONENTER Nil
               ONDISPLAYCHANGE Nil
               DISPLAYEDIT .F.
               IMAGE Nil
               DROPPEDWIDTH Nil
               ONCLOSEUP memocanok()		
					DROPPEDWIDTH Nil
				END COMBOBOX
         endif
      end window
   endif
   center window windowmemo
   if  mvarbskagen = 'C' .or. mvarbskagen = 'N' 
      settextboxcuebanner("windowmemo","text_1",cuebanertexto)
      windowmemo.text_1.setfocus
   endif
   activate window windowmemo
return(iif(mvarbskagen = 'N',val(mresultado),mresultado))


function memocanok
   parameters mvarbskagen
   if mvarbskagen = 'C' .or. mvarbskagen = 'N'
      mresultado:=windowmemo.text_1.value
   else
      mresultado:=windowmemo.combo_1.value
   endif
   release window windowmemo
return nil


function repoaimpoexc
   Local aImages:={ 'MINIPR' ,'EXCEL'}
   mresultado:=0
   if !IsWindowDefined(windowmemo) 
      DEFINE WINDOW windowmemo AT 186 , 456 WIDTH 300 HEIGHT 140 title "Imprimir a" MODAL nosize
			DEFINE COMBOBOX Combo_1
				ROW 10
   			COL 20
  				WIDTH 240
				HEIGHT 200
				ITEMS {{0,'IMPRESORA'},{1,'EXCEL'}}
       	   VALUE 1
            IMAGE aImages
            DISPLAYEDIT .t.
            ONCLOSEUP combook()		
			END COMBOBOX
         DEFINE BUTTON Button_1
            ROW    60
            COL    70
            WIDTH  140
            HEIGHT 40
            ACTION thiswindow.release
            CAPTION "Salir"
            FONTNAME "Arial"
            FONTSIZE 9
            TOOLTIP ""
            FONTBOLD .T.
            FONTITALIC .F.
            FONTUNDERLINE .F.
            FONTSTRIKEOUT .F.
            ONGOTFOCUS Nil
            ONLOSTFOCUS Nil
            HELPID Nil
            FLAT .F.
            TABSTOP .T.
            VISIBLE .T.
            TRANSPARENT .F.
            MULTILINE .F.
            PICTURE Nil
            PICTALIGNMENT TOP
         END BUTTON
      end window
   endif
   center window windowmemo
   activate window windowmemo
return(mresultado)


function combook
   mresultado:=windowmemo.combo_1.value
   release window windowmemo
return nil


function letras(cant)
   local let1:={'UN ','DOS ','TRES ','CUATRO ','CINCO ','SEIS ','SIETE ','OCHO ','NUEVE ','DIEZ ','ONCE ','DOCE ','TRECE ','CATORCE ','QUINCE ','DIECISEIS ','DIECISIETE ','DIECIOCHO ','DIECINUEVE '}
   local let2:= {'DIEZ ','VEINTE ','TREINTA ','CUARENTA ','CINCUENTA ','SESENTA ','SETENTA ','OCHENTA ','NOVENTA '}
   local let5:= {'DIECI','VEINTI','TREINTA Y ','CUARENTA Y ','CINCUENTA Y ','SESENTA Y ','SETENTA Y ','OCHENTA Y ','NOVENTA Y '}
   local let3:= {'CIENTO ','DOSCIENTOS ','TRESCIENTOS ','CUATROCIENTOS ','QUINIENTOS ','SEISCIENTOS ','SETECIENTOS ','OCHOCIENTOS ','NOVECIENTOS '}
   local let4:= {'MIL ','CIEN ','PESOS ','PESO '},LETRAS1[10],NUMERO:=0
   local let6:={'MILLONES ','MILLON '}
   local mlls,rmlls,cdm:=rcdm:=dmd:=rdmd:=umd:=rumd:=cd:=rcd:=dd:=rdd:=ud:=rr:=nrr1:=nrr2:=0
   public cambioal:=space(200)

   mlls:=int(cant/1000000)
   rmlls:=cant-(mlls*1000000)

   cdm:=int(rmlls/100000)
   rcdm:=rmlls-(cdm*100000)

   dmd:=int(rcdm/10000)
   rdmd:=rcdm-(dmd*10000)

   umd:=int(rdmd/1000)
   rumd:=rdmd-(umd*1000)

   cd:= int(rumd/100)
   rcd:=rumd-(cd*100)

   dd:=int(rcd/10)
   rdd:=rcd-(dd*10)

   ud:=int(rdd/1)
   rr:=rdd-(ud*1)

   nrr1:=iif(rr > 0,int(rr*100),0)

   if rcd >= 1 .and. rcd <= 19
      letras1[1]:=let1[rcd]
   elseif dd >= 2 .and. ud = 0
      letras1[1]:=let2[dd]
   elseif dd >= 2 .and. ud >= 1
      letras1[1]:=let5[dd]+let1[ud]
   endif
   if cd >= 1 .and. rcd = 0
      if cd = 1
         letras1[2]:=let4[2]
      else
         letras1[2]:=let3[cd]
      endif
   elseif cd >= 1 .and. rcd >= 1
      letras1[2] := let3[cd]
   endif
   if umd = 1 .and. dmd = 0
      letras1[3]:=let4[1]
   elseif dmd = 0 .and. umd >= 2
      letras1[3] :=let1[umd]+let4[1]
   elseif dmd = 1 .and. umd >= 1
      letras1[3] :=let1[umd+10]+let4[1]
   elseif dmd >= 1 .and. umd = 0
      letras1[3] := let2[dmd] + let4[1]
   elseif dmd >= 1 .and. umd >= 1
      letras1[3] := let5[dmd]+let1[umd]+let4[1]
   endif
   if cdm >= 1 .and.  dmd = 0 .AND. umd = 0
      if cdm = 1
         letras1[4]:=let4[2]+let4[1]
      else
         letras1[4]:=let3[cdm]+let4[1]
      endif
   elseif CDM >= 1  .AND.  ( DMD > 0 .OR. UMD > 0 )
      letras1[4] :=let3[cdm]
   endif
   if mlls >= 1 
      if mlls = 1   
         letras1[5]:=let1[1]+let6[2]
      else
         letras1[5]:=let1[mlls]+let6[1]
      endif
   endif
   if cant != 1
      cambioal:=iif(letras1[5]=NIL,'',letras1[5] )+iif(letras1[4]=NIL,'',letras1[4] )+iif(letras1[3]=NIL,'',letras1[3] )+iif(letras1[2]=NIL,'',letras1[2] )+iif(letras1[1]=NIL,'',letras1[1] )+LET4[3]+RIGHT(ALLTRIM(STR(cant)),2)+'/100 M.N.'
   else
      cambioal:=iif(letras1[5]=NIL,'',letras1[5] )+iif(letras1[4]=NIL,'',letras1[4] )+iif(letras1[3]=NIL,'',letras1[3] )+iif(letras1[2]=NIL,'',letras1[2] )+iif(letras1[1]=NIL,'',letras1[1] )+LET4[4]+RIGHT(ALLTRIM(STR(cant)),2)+'/100 M.N.'
   endif
return cambioal


Function numaletr(nnum,lmasc)
   local cnum,c100,crtn := ""
   local nlnm,nori,ngrp,nltr,ctrio
   local lgen,lm1 := .f.
   local nn
   default lmasc := .t.
   if valtype( nnum ) == "c"
      cnum := alltrim(strtran(nnum,".",""))
      nn   := val(cnum)
   else
      nn   := nnum
      cnum := ltrim(str(nn))
   endif
   nlnm := len(cnum)
   nori := nlnm
   ngrp := int((nlnm+2)/3)
   nltr := 3-((ngrp*3)-nlnm)
	do while ngrp > 0 .and. nn > 0
      ctrio := left(cnum,nltr)
      if nltr = 1
         ctrio := "00"+ctrio
      elseif nltr = 2
         ctrio := "0"+ctrio
      endif
      nlnm -= nltr
		cnum := right(cnum,nlnm)
      nltr := 3
      lgen := if(ngrp > 2 , .t. , lmasc )
      c100 := centenas(ctrio,lgen,ngrp)
      if c100 = "ún " .or. right( c100,4) = " ún "
         c100 := left(c100,len(c100)-3) + "un "
      endif
		do case
			case ngrp = 5
				crtn += c100+if( ctrio = "001" .and. nori = 13 , "billón " , "billones " )
            if left( cnum,6) = "000000"
               cnum := right(cnum,6)
               nlnm := 6
               ngrp := 3
            endif
			case ngrp = 3 .or. ngrp = 7
				crtn += c100+if(ctrio = "001" .and. ( nori = 7 .or. nori = 19 ) ,"millón ","millones ")
            if left(cnum,6) = "000000" .and. ngrp = 7
					crtn += "de "
            endif
         case ngrp = 2 .or. ngrp = 4 .or. ngrp = 6
            crtn += if( ctrio = "001" , "" , c100 ) + if( empty(c100) , "" , "mil " )
         otherwise
            crtn += c100
		endcase
      --ngrp
	enddo
   if empty(crtn) .or. nn = 0
      crtn := "cero"
   endif
   crtn := crtn + 'pesos'
return rtrim(crtn)


function centenas(ctr,lg,ng)
   local cc1,cd1,cret := ""
   cc1 := ltrim(str(val(left(ctr,1))))
   cd1 := right(ctr,2)
   do case
      case ctr = "100"
         return ("cién ")
      case cc1 = "1"
         cret := "ciento "
      case cc1 = "5"
			cret := "quinient"+if(lg,"os ","as ")
      case cc1 # "0"
         cret := unidades(cc1,ng,lg,.t.)
         cret := left(cret,len(cret)-1)+"cient"+if(lg,"os ","as ")
   endcase
	cret += decenas(cd1,lg,ng)
return cret


function decenas(cdn,lg,ng)
   local cd1,cu1,cret := ""
   cd1 := ltrim(str(val( left(cdn,1))))
   cu1 := ltrim(str(val(right(cdn,1))))
   do case
      case cd1 = "9"
         cret := "noventa "
      case cd1 = "8"
			cret := "ochenta "
      case cd1 = "7"
			cret := "setenta "
      case cd1 = "6"
         cret := "sesenta "
      case cd1 = "5"
         cret := "cincuenta "
      case cd1 = "4"
         cret := "cuarenta "
      case cd1 = "3"
         cret := "treinta "
      case cd1 = "2"
			if cu1 > "0"
            cret := "veinti"
         else
            return ("veinte ")
         endif
      case cdn = "15"
         return ("quince ")
      case cdn = "14"
         return ("catorce ")
      case cdn = "13"
         return ("trece ")
      case cdn = "12"
         return ("doce ")
      case cdn = "11"
         return ("once ")
      case cdn = "10"
         return ("diez ")
      case val(cdn) > 10
         cret := "dieci"
	endcase
   if cu1 # "0" .and. cd1 > "2"
      cret += "y "
   endif
   cret += unidades(cu1,ng,lg,.f.)
return cret

	
function unidades(cun,ng,lg,lm)
   local cret := ""
   do case
		case cun = "1"
			cret := if(lg,if(ng > 1,"ún ","uno "),"una ")
      case cun = "2"
         cret := "dos "
      case cun = "3"
			cret := "tres "
		case cun = "4"
         cret := "cuatro "
      case cun = "5"
         cret := "cinco "
      case cun = "6"
			cret := "seis "
      case cun = "7"
         cret := if(lm,"sete ","siete ")
      case cun = "8"
         cret := "ocho "
      case cun = "9"
         cret := if(lm,"nove ","nueve ")
   endcase
return cret

function ValidEmailAddress( cMailAddress )
   local cRegEx 
	cRegEx:=HB_RegexComp("([_\.0-9a-zA-Z-]+@([0-9a-zA-Z][0-9a-zA-Z-]+\.)+[a-zA-Z]{2,6})")
	aMatch:=HB_Regex( cRegex,cMailAddress)
   lIsValid:=.t.
   if empty(aMatch)
      lIsValid:=.f.
   endif
return(lIsValid)


********************************* Algoritmo de Luhn ************************************************
Function lAlgLuhn( cImei )
   Local cDigCk := Val( Right( cImei, 1 ) )
   Local nAt := 0
   Local nSum := 0
   Local c := ""
   For nAt := 1 to ( Len( cImei ) - 1 )
      If Mod( nAt, 2 ) == 0
         c:= AllTrim( cStr( Val( SubStr( cImei, nAt,1) ) * 2 ) )
         cNum:= If( ( Len(c) >= 2 ), AllTrim( cStr( Val( substr(c,1,1) ) + Val( substr(c,2,1) ) ) ), c )
      Else
         cNum := SubStr( cImei, nAt,1 )
      EndIf
      nSum += Val( cNum )
   Next nAt
Return( Val( substr( AllTrim( cStr( nSum * 9 ) ), -1, 1 ) ) == cDigCk )

function printopoe
   
return nil


function sacacomilla
   parameters mxvarchar
return(strtran(mxvarchar,"'","\'"))

function about
   xvar:=memoread("local.dat")
   versionlocal:=alltrim(xvar)
   IF !IsWindowDefined(about) 
      Load Window about
      about.center
      about.label_2.value:='Version : ' + versionlocal
      Activate Window about
   endif
return Nil


function settextboxcuebanner(cParent,cControl,cText)
   local nHandle := GetControlHandle (cControl,cParent)
   _settextboxcuebanner(nHandle,cText)
return nil

#pragma BEGINDUMP

#define COMPILE_HMG_UNICODE

#define _WIN32_IE      0x0500
#define _WIN32_WINNT   0x501

#include <HMG_UNICODE.h>
#include <windows.h>
#include <commctrl.h>
#include "hbapi.h"
#include <tchar.h>
#include <wingdi.h>

#define ECM_FIRST               0x1500      // Edit control messages
#define   EM_SETCUEBANNER       (ECM_FIRST + 1)      // Set the cue banner with the lParm = LPCWSTR
#define Edit_SetCueBannerText(hwnd, lpcwText) \
   (BOOL)SNDMSG((hwnd), EM_SETCUEBANNER, 0, (LPARAM)(lpcwText))
#define   EM_GETCUEBANNER       (ECM_FIRST + 2)      // Set the cue banner with the lParm = LPCWSTR
#define Edit_GetCueBannerText(hwnd, lpwText, cchText) \
   (BOOL)SNDMSG((hwnd), EM_GETCUEBANNER, (WPARAM)(lpwText), (LPARAM)(cchText))

HB_FUNC ( _SETTEXTBOXCUEBANNER )
{
   HWND hWnd1;
   hWnd1 = (HWND) hb_parnl (1);
   SendMessage((HWND) hWnd1,EM_SETCUEBANNER, (WPARAM)(int) 1,(LPARAM) HMG_parc(2) );
}

#pragma ENDDUMP