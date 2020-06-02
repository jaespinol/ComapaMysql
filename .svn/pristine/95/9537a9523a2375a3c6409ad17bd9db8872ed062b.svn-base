#include <hmg.ch>

Function Main
public flagentramysql:=.f., mysqlsevr:='', mysqlsevr:='', mysqlusu:='', mysqlpass:=''
public mvarpas:=hb_blowfishKey('777pepemaicol777')
Public dimdiam:={}, dimesta:={}, Editar:=.F., dimtra:={}, dimcon:={}, dimcol:={},dimcal:={}, dimFal:={}, dimcor:={}
Public oserver, dimcua:={}, dimdep:={}
	if file("config.dat")
      mvarsxy:=memoread("config.dat")
      mnlines:=mlcount(mvarsxy,100)
      mysqlsevr:=hb_blowfishDecrypt(mvarpas,alltrim(memoline(mvarsxy,100,1)))
      mysqlusu:=hb_blowfishDecrypt(mvarpas,alltrim(memoline(mvarsxy,100,2)))
      mysqlpass:=hb_blowfishDecrypt(mvarpas,alltrim(memoline(mvarsxy,100,3)))
      mysqldata:=hb_blowfishDecrypt(mvarpas,alltrim(memoline(mvarsxy,100,4)))
   endif
If !connect()

EndIf 
        Load Window Main
        Main.Center
        Main.Activate

Return

function connect 
   flagentramysql:=.t.
   oServer := TMySQLServer():New(mysqlsevr, mysqlusu, mysqlpass)
   If oServer:NetErr()
      MsgStop(oServer:Error())
      flagentramysql:=.f.
   else
      if empty(mysqldata)
         mysqldata:='Comapa'
      endif
      oServer:SelectDB( mysqldata )
      If oServer:NetErr()
         MsgStop(oServer:Error())
         flagentramysql:=.f.
			return(flagentramysql)
      endif
      bQuery:=oServer:Query( "SET SESSION wait_timeout = 172800;")  
      If bQuery:NetErr()												
         MsgStop ( bQuery:Error() )
			return Nil
      Endif
      bQuery:Destroy()
   EndIf
  // MsgBox("la bandera"+flagentramysql,"")
return(flagentramysql)

Function jorge()
If flagentramysql=.f.
	configurasql()
EndIf 

Return Nil

function Mostrarserver()
   if file("config.dat")
      mvarsxy:=memoread("config.dat")
      mnlines:=mlcount(mvarsxy,100)
      mysqlsevr:=hb_blowfishDecrypt(mvarpas,alltrim(memoline(mvarsxy,100,1)))
      mysqlusu:=hb_blowfishDecrypt(mvarpas,alltrim(memoline(mvarsxy,100,2)))
      mysqlpass:=hb_blowfishDecrypt(mvarpas,alltrim(memoline(mvarsxy,100,3)))
      mysqldata:=hb_blowfishDecrypt(mvarpas,alltrim(memoline(mvarsxy,100,4)))
   endif
   
      main.text_3.value:=mysqlsevr
      main.text_4.value:=mysqlusu
      main.text_5.value:=mysqlpass
      main.text_1.value:=mysqldata
	  main.text_3.readonly:=.t.
      main.text_4.readonly:=.t.
      main.text_5.readonly:=.t.
      main.text_1.readonly:=.t.
  
return Nil

Function prueba()
If main.tab_1.Value = 1
Diamgrid()
DiamLimpReg()
main.diaSaveButt.enabled := .F.
ElseIf main.tab_1.Value = 2
Estagrid()
main.EstSaveButt.enabled := .F.
ElseIf main.tab_1.Value = 3
Mostrarserver()
ElseIf main.tab_1.Value = 4
TraGrid()
TraLimpReg()
ElseIf main.tab_1.Value = 5
ConGrid()
ConLimpReg()
ElseIf main.tab_1.Value = 6
ColGrid()
ColLimpReg()
ElseIf main.tab_1.Value = 7
CalGrid()
CalLimpReg()
ElseIf main.tab_1.Value = 8
FalGrid()
FalLimpReg()
ElseIf main.tab_1.Value = 9
CorGrid()
CorLimpReg()
ElseIf main.tab_1.Value = 10
CuaGrid()
CuaLimpReg()
ElseIf main.tab_1.Value = 11
DepGrid()
DepLimpReg()
EndIf 
Return Nil