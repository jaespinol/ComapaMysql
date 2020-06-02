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
   BT_DrawGradientFillVertical(hDCv, 0, 0, BT_ClientAreaWidth(nomventg), BT_ClientAreaHeight(nomventg), WHITE, BLUEL )
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

