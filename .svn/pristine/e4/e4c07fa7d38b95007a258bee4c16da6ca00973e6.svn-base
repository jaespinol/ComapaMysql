#include <hmg.ch>

Function Main
Public CatUsu:={}, CatDia:={}, CatCpt:={}, CatEst:={}, CatCol:={}, CatCll:={}, CatFll:={}, CatCua:={}, CatDep:={}, CatGir:={}, CatCap:={}, CatAut:={}, CatTbo:={}, CatTpg:={}, CatVen:={}, CatTco:={}, CatAre:={}, CatTtr:={}, CatFte:={}
Public CmbUsu:={}, CmbDia:={}, CmbCpt:={}, CmbEst:={}, CmbCol:={}, CmbCll:={}, CmbFll:={}, CmbCua:={}, CmbDep:={}, CmbGir:={}, CmbCap:={}, CmbAut:={}, CmbTbo:={}, CmbTpg:={}, CmbVen:={}, CmbTco:={}, CmbAre:={}, CmbTtr:={}, CmbFte:={}
public flagentramysql:=.f., mysqlsevr:='', mysqlsevr:='', mysqlusu:='', mysqlpass:=''
Public ames:={'Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'}
public mvarpas:=hb_blowfishKey('777pepemaicol777')
Public flagentramysql:=.f., mysqlsevr
Public oServer, mvaloriva:=0
Public mactual:="",manterior:="",mfecante:="",mfecact:="",mfalla:="",flagop:=.f.,guardamed:=.f., gridbusgir:={},colLinea:=0,colValue:={}
Public listapad:={},ahora:=0,flagoppad:=0, nLinea:=0, aValue:={}, VarCombo1:={}, VarCombo2:={}, VarCombo3:={}, VarCombo4:={},editar:=.f.
Public buscapad:={}, acons:={},medgrid:={}, contgrid:={}, cahora:=0, contratoar:={},dato:="", tmpcol:="", tmptxtcol:="",gridbuscol:={}, gridcall:={}, gridpagares:={}, pahora:=0, phojas:=0
Public gridbuspag:={}, inicont:=.t., cn:=0,chojas:=0, cfilaini:=0, cfilafin:=0, gridbusord:={}, oahora:=0, ohojas:=0, ofilafin:=0, ofilaini:=0, iniord:=.t., co:=0
Public dahora:=0, dhojas:=0, dfilaini:=0, dfilafin:=0, griddiv:={}, dlinea:=0, dvalue:={},tmpdivnom:=0
Public mValue:={}, cValue:={}
Set navigation extended
Set date To french
Set century on
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
   cargacat()
   Main.Center
	//main.maximize
   Main.Activate
Return


function ponbotones
  main.label_1.row:=3
   main.label_2.row:=3
   main.label_3.row:=3
   comax:=main.width
   main.label_1.col:=comax - 30
   main.label_2.col:=comax - 50
   main.label_3.col:=comax - 70
return Nil

function menufact
   IF !IsWindowDefined(menufact) 
       Load Window menufact
       Center Window menufact
       //on key ALT+F8 of menufact action Nil //duplicados()
       menufact.Maximize
       Activate Window menufact
   endIf
return

function menucontratos
   IF !IsWindowDefined(contratos) 
       Load Window contratos
       Center Window contratos
       //on key ALT+F8 of menufact action Nil //duplicados()
       contratos.Maximize
       Activate Window contratos
   endIf
return

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
return(flagentramysql)

Function cargacat()
//carga de los catalogos en variables para no hacerlo despues
	//Usuarios
	cQuery := "Select Id, Nombre, Clave From Usuarios Order By Clave"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
        return Nil
    EndIf 
	For i := 1 To bQuery:LastRec()
		oRow := bQuery:GetRow(i)
		aadd(CatUsu,{oRow:FieldGet("Id"),oRow:FieldGet("Nombre"),oRow:FieldGet("Clave")})
		aadd(CmbUsu,oRow:FieldGet("Nombre"))
	Next
	bQuery:Destroy()
	//Diametros
	cQuery := "Select Id, Nombre, Medida, PrecDom, PrecCom, PrecInd, PrecPub, Minimo1, Minimo2, Minimo3, Minimo4, clavetoma, Tamano From Diametros Order By Medida"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
        return Nil
    EndIf 
	For i := 1 To bQuery:LastRec()
		oRow := bQuery:GetRow(i)
		aadd(CatDia,{oRow:FieldGet("Id"),oRow:FieldGet("Nombre"),oRow:FieldGet("Medida"),oRow:FieldGet("PrecDom"),oRow:FieldGet("PrecCom"),;
		oRow:FieldGet("PrecInd"),oRow:FieldGet("PrecPub"),oRow:FieldGet("Minimo1"),oRow:FieldGet("Minimo2"),oRow:FieldGet("Minimo3"),;
		oRow:FieldGet("Minimo4"),oRow:FieldGet("clavetoma"),oRow:FieldGet("Tamano")})
		aadd(CmbDia,oRow:FieldGet("Nombre"))
	Next
	bQuery:Destroy()
	//Concepto=CatCpt
	cQuery := "Select Id, Nombre, No_cta, Cve_cta, Imp_Cpto, IvaXc From Concepto Order By Nombre"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
        return Nil
    EndIf 
	For i := 1 To bQuery:LastRec()
			oRow := bQuery:GetRow(i)
	aadd(CatCpt,{oRow:FieldGet("Id"),oRow:FieldGet("Nombre"),oRow:FieldGet("No_cta"),oRow:FieldGet("cve_cta"),oRow:FieldGet("Imp_cpto");
	,oRow:FieldGet("IvaXc")})
	aadd(CmbCpt,oRow:FieldGet("Nombre"))
	Next
	bQuery:Destroy()
	//Estatus=CatEst
	cQuery := "Select Id, Nombre, Clave From Estatus Order By Id"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
        return Nil
    EndIf 
	For i := 1 To bQuery:LastRec()
			oRow := bQuery:GetRow(i)
	aadd(CatEst,{oRow:FieldGet("Id"),oRow:FieldGet("Nombre"),oRow:FieldGet("Clave")})
	aadd(CmbEst,oRow:FieldGet("Nombre"))
	Next
	bQuery:Destroy()
	//Colonia=CatCol
	cQuery := "Select Id, Nombre, Sect_no, Sub_sector, Total_col From Colonias Order By Id"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
        return Nil
    EndIf 
	For i := 1 To bQuery:LastRec()
			oRow := bQuery:GetRow(i)
	aadd(CatCol,{oRow:FieldGet("Id"),oRow:FieldGet("Nombre"),oRow:FieldGet("Sector_no"),oRow:FieldGet("Sub_Sector"),oRow:FieldGet("Total_col")})
	aadd(CmbCol,oRow:FieldGet("Nombre"))
	Next
	bQuery:Destroy()
	//Calles=CatCll
	cQuery := "Select Id, Nombre From Calles Order By nombre"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
        return Nil
    EndIf 
	For i := 1 To bQuery:LastRec()
			oRow := bQuery:GetRow(i)
				aadd(CatCll,{oRow:FieldGet("Id"),oRow:FieldGet("Nombre")})
				aadd(CmbCll,oRow:FieldGet("Nombre"))
	Next
	bQuery:Destroy()
	//Fallas:=CatFll
	cQuery := "Select Id, Nombre, Letra From Falla Order By Letra"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
        return Nil
    EndIf 
	For i := 1 To bQuery:LastRec()
			oRow := bQuery:GetRow(i)
	aadd(CatFll,{oRow:FieldGet("Id"),oRow:FieldGet("Nombre"),oRow:FieldGet("Letra")})
	aadd(CmbFll,oRow:FieldGet("Nombre"))
	Next
	bQuery:Destroy()
	//Cuadrillas=CatCua
	cQuery := "Select Id, Nombre, area, Encargado, Vehiculo From Cuadrillas Order By Id"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
        return Nil
    EndIf 
	For i := 1 To bQuery:LastRec()
			oRow := bQuery:GetRow(i)
	aadd(CatCua,{oRow:FieldGet("Id"),oRow:FieldGet("Nombre"),oRow:FieldGet("Area"),oRow:FieldGet("Encargado"),oRow:FieldGet("Vehiculo")})
	aadd(CmbCua,oRow:FieldGet("Nombre"))
	Next
	bQuery:Destroy()
	//Departamentos=CatDep
	cQuery := "Select Id, Nombre, Dependencia, Jefe From Departamentos Order By Id"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
        return Nil
    EndIf 
	For i := 1 To bQuery:LastRec()
			oRow := bQuery:GetRow(i)
	aadd(CatDep,{oRow:FieldGet("Id"),oRow:FieldGet("Nombre"),oRow:FieldGet("Dependencia"),oRow:FieldGet("Jefe")})
	aadd(CmbDep,oRow:FieldGet("Nombre"))
	Next
	bQuery:Destroy()
	//Giros=CatGir
	cQuery := "Select Clave, Nombre, Total, Adeudo From Giros Order By Clave"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
        return Nil
    EndIf 
	For i := 1 To bQuery:LastRec()
			oRow := bQuery:GetRow(i)
	aadd(CatGir,{oRow:FieldGet("Clave"),oRow:FieldGet("Nombre"),oRow:FieldGet("Total"),oRow:FieldGet("Adeudo")})
	aadd(CmbGir,oRow:FieldGet("Nombre"))
	Next
	bQuery:Destroy()
		//Capturis=CatCap
	cQuery := "Select cve_captur, nom_captur, pas_captur, clave, Estatus, Cve_lect, nivel, Fte_pago, impresion, archivo From Capturis Order By cve_captur"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
        return Nil
    EndIf 
	For i := 1 To bQuery:LastRec()
			oRow := bQuery:GetRow(i)
	aadd(CatCap,{oRow:FieldGet("cve_captur"),oRow:FieldGet("nom_captur"),oRow:FieldGet("pas_captur"),oRow:FieldGet("clave"),;
					 oRow:FieldGet("Estatus"),oRow:FieldGet("Cve_lect"),oRow:FieldGet("nivel"),oRow:FieldGet("Fte_pago"),;
					 oRow:FieldGet("impresion"),oRow:FieldGet("archivo")})
	aadd(CmbCap,oRow:FieldGet("nom_captur"))
	Next
	bQuery:Destroy()
		//Nomaut=CatAut
	cQuery := "Select clave, nombre, cantmax, depto, estatus From Nomaut Order By nombre"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
        return Nil
    EndIf 
	For i := 1 To bQuery:LastRec()
			oRow := bQuery:GetRow(i)
	aadd(CatAut,{oRow:FieldGet("clave"),oRow:FieldGet("nombre"),oRow:FieldGet("cantmax"),oRow:FieldGet("depto"),;
					 oRow:FieldGet("estatus"),i})
	aadd(CmbAut,oRow:FieldGet("nombre"))
	Next
	bQuery:Destroy()
		//Tipbon=CatTbo
	cQuery := "Select cve_bonif, des_bonif From Tipbon Order By cve_bonif"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
        return Nil
    EndIf 
	For i := 1 To bQuery:LastRec()
			oRow := bQuery:GetRow(i)
	aadd(CatTbo,{oRow:FieldGet("cve_bonif"),oRow:FieldGet("des_bonif")})
	aadd(CmbTbo,oRow:FieldGet("des_bonif"))
	Next
	bQuery:Destroy()
	//TipPag=CatTpg
	cQuery := "Select id, clave, nombre From Pagtip Order By clave"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
        return Nil
    EndIf 
	For i := 1 To bQuery:LastRec()
			oRow := bQuery:GetRow(i)
	aadd(CatTpg,{oRow:FieldGet("clave"),oRow:FieldGet("nombre"),oRow:FieldGet("id")})
	aadd(CmbTpg,oRow:FieldGet("nombre"))
	Next
	bQuery:Destroy()
	//Vencimientos=CatVen
	cQuery := "Select cve_venc, des_venc From Vencimie Order By cve_venc"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
        return Nil
    EndIf 
	For i := 1 To bQuery:LastRec()
			oRow := bQuery:GetRow(i)
	aadd(CatVen,{oRow:FieldGet("cve_venc"),oRow:FieldGet("des_venc")})
	aadd(CmbVen,oRow:FieldGet("cve_des"))
	Next
	bQuery:Destroy()
	//tipo de contrato=CatTco
	cQuery := "Select * From Tipocon Order By clave"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
        return Nil
    EndIf 
	For i := 1 To bQuery:LastRec()
			oRow := bQuery:GetRow(i)
	aadd(CatTco,{oRow:FieldGet("clave"),oRow:FieldGet("Nombre")})
	aadd(CmbTco,oRow:FieldGet("nombre"))
	Next
	bQuery:Destroy()
	//Areas=CatAre
	cQuery := "Select * From Areas Order By clave"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
        return Nil
    EndIf 
	For i := 1 To bQuery:LastRec()
			oRow := bQuery:GetRow(i)
	aadd(CatAre,{oRow:FieldGet("clave"),oRow:FieldGet("Nombre"),oRow:FieldGet("Encargado")})
	aadd(CmbAre,oRow:FieldGet("nombre"))
	Next
	bQuery:Destroy()
	//tipo de trabajo=CatTtr
	cQuery := "Select * From Tipotrab Order By clave"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
        return Nil
    EndIf 
	For i := 1 To bQuery:LastRec()
			oRow := bQuery:GetRow(i)
	aadd(CatTtr,{oRow:FieldGet("clave"),oRow:FieldGet("Nombre"),oRow:FieldGet("area")})
	aadd(CmbTtr,oRow:FieldGet("nombre"))
	Next
	bQuery:Destroy()
	//iva aplicado variable ValorIva
	cQuery := "Select iva From Utilerias"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
        return Nil
    EndIf 
			oRow := bQuery:GetRow(1)
	mvalorIva := oRow:FieldGet("iva")
	bQuery:Destroy()
	//fuente de pago=CatFte
	cQuery := "Select * From Ftepago Order By clave"
	bQuery := oServer:Query(cQuery)
	If bQuery:NetErr()												
        MsgStop ( bQuery:Error() )
        return Nil
    Endif
    if bQuery:LastRec() = 0
        return Nil
    EndIf 
	For i := 1 To bQuery:LastRec()
			oRow := bQuery:GetRow(i)
	aadd(CatFte,{oRow:FieldGet("clave"),oRow:FieldGet("Nombre"),oRow:FieldGet("Impresion")})
	aadd(CmbFte,oRow:FieldGet("nombre"))
	Next
	bQuery:Destroy()
Return Nil
