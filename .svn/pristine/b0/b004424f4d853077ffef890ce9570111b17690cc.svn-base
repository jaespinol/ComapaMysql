/*#include <hbcurl.ch>*/
/*#include <common.ch>
#include <hmg.ch>
#include <hbssl.ch>
/*#include <UnicodeConvert.prg>*/
/*#include <Fileio.ch>
/*#include <hbxml.ch>*/

function creafactelec(tipo,nfactura,seriefac,foliofac,msubtotal,totalfac,descuento,motivodescuento,tipocambio,moneda,tipodecomprobante,formadepago,nconceptos,arrayconceptos,totalimpuestostrasladados,totalimpuestosretenidos,traslados,retenciones,mpago,nscuenta,lugarexpedicion,rfcemisor,nombreemisor,calleemisor,noexterioremisor,nointerioremisor,coloniaemisor,localidademisor,municipioemisor,estadoemisor,paisemisor,cpemisor,calleexpedido,noexteriorexpedido,nointeriorexpedido,coloniaexpedido,localidadexpedido,municipioexpedido,estadoexpedido,paisexpedido,cpexpedido,nocertificado,certificado,condicionesdepago,regimenfac,fincertificado,horafincer,rfcreceptor,nombrereceptor,callereceptor,noexteriorreceptor,nointeriorreceptor,coloniareceptor,municipioreceptor,estadoreceptor,paisreceptor,cpreceptor,uspac,passpac)
/*	declare window altadiverso
	if empty(nfactura)
		Msginfo("No se recibió el numero de factura, no se puede crear CFD","Mensaje del sistema") // Validacion interna del sistema de contructora
		return .f.
	endif
	
	//validar vigencia del certificado y mandar mensaje si le faltan menos de 15 dias para vencerse
	if (date() > fincertificado)
		Msginfo("El certificado esta vencido, imposible generar el CFD","Mensaje del sistema")
		return .f.
	endif
	if (date()+15 >= fincertificado .and. empresas->certificanot==.f.)
		//enviacorreo(alltrim(empresas->notifica),'Notificación de timbrado',"El certificado vence el: "+dtoc(fincertificado)+" a las "+horafincer)
	endif
	if tipo<>'' .and. tipo<>'cfdi:'
		Msginfo('El tipo de factura es invalido deber ser cfdi: o estar en blanco el cfd no se ha generado','Mensaje del sistema')
		return .f.
	endif
   
	/* Crea nuevo xml*/
/*	obXml := Createobject('MSXML.DOMDocument')
	root := obXml:createProcessingInstruction("xml","version='1.0' encoding='UTF-8'")
	obXml:insertBefore(root,obXml:documentElement)
	xComprobante := obXml:createElement(tipo+"Comprobante")
	if empty(alltrim(tipo))
		xComprobante:setAttribute("xmlns",'http://www.sat.gob.mx/cfd/2')
	else
		xComprobante:setAttribute("xmlns:cfdi",'http://www.sat.gob.mx/cfd/3')
	endif
	xComprobante:setAttribute("xmlns:xsi","http://www.w3.org/2001/XMLSchema-instance")
	if empty(alltrim(tipo))
		xComprobante:setAttribute("xsi:schemaLocation","http://www.sat.gob.mx/cfd/2 http://www.sat.gob.mx/sitio_internet/cfd/2/cfdv22.xsd")
	else
		xComprobante:setAttribute("xsi:schemaLocation","http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv32.xsd")
	endif
	if empty(alltrim(tipo))
		xComprobante:setAttribute("version","2.2" )
	else
		xComprobante:setAttribute("version","3.2" )
	endif
	if !empty(seriefac)
		xComprobante:setAttribute("serie",alltrim(seriefac) )
	endif
	if empty(foliofac)
		Msginfo("No se recibió el folio de la factura, no se puede crear CFD","Mensaje del sistema")
		return .f.
	else
		xComprobante:setAttribute("folio",alltrim(foliofac) )
	endif
	mfechae:=substr(dtoc(date()),7,4)+'-'+substr(dtoc(date()),4,2)+'-'+substr(dtoc(date()),1,2)
	mtiempom:=time()
	fecfac:=mfechae+'T'+mtiempom
	xComprobante:setAttribute("fecha",fecfac )
	if tipo!="cfdi:"
		if empty(noaprobacion)
			Msginfo("No se recibió el numero de aprobación, no se puede crear CFD","Mensaje del sistema")
			return .f.
		else
			xComprobante:setAttribute("noAprobacion",noaprobacion )
		endif
		if empty(anioaprobacion)
			Msginfo("No se recibió el año de aprobación, no se puede crear CFD","Mensaje del sistema")
			return .f.
		else
			xComprobante:setAttribute("anoAprobacion",anioaprobacion )
		endif
	endif
	if empty(formadepago)
		Msginfo("No se recibió la forma de pago, no se puede crear CFD","Mensaje del sistema")
		return .f.
	else
		xComprobante:setAttribute("formaDePago",unitou8(formadepago) )
	endif
	if empty(nocertificado)
		Msginfo("No se recibió el numero de certificado, no se puede crear CFD","Mensaje del sistema")
		return .f.
	else
		xComprobante:setAttribute("noCertificado",nocertificado )
	endif
	if !empty(certificado)
		xComprobante:setAttribute("certificado",pegacertificado(certificado) )
	endif
	if !empty(condicionesdepago)
		xComprobante:setAttribute("condicionesDePago",alltrim(condicionesdepago) )
	endif
	if empty(msubtotal)
		Msginfo("No se recibió el subtotal de la factura, no se puede crear CFD","Mensaje del sistema")
		return .f.
	else
		xComprobante:setAttribute("subTotal",alltrim(msubtotal) )
	endif
	if !empty(descuento)
		xComprobante:setAttribute("descuento",alltrim(descuento) )
	endif
	if !empty(motivodescuento)
		xComprobante:setAttribute("motivoDescuento",alltrim(motivodescuento) )
	endif
	if !empty(tipocambio)
		xComprobante:setAttribute("TipoCambio",alltrim(tipocambio) )
	endif
	if !empty(moneda)
		xComprobante:setAttribute("Moneda",alltrim(moneda) )
	endif
	if empty(totalfac)
		Msginfo("No se recibió el total de la factura, no se puede crear CFD","Mensaje del sistema")
		return .f.
	else
		xComprobante:setAttribute("total",alltrim(totalfac) )
	endif
	if empty(tipodecomprobante)
		Msginfo("No se recibió el tipodecomprobante de la factura, no se puede crear CFD","Mensaje del sistema")
		return .f.
	else
		xComprobante:setAttribute("tipoDeComprobante",alltrim(tipodecomprobante) )
	endif
	if empty(mpago)
		Msginfo("No se recibió el método de pago de la factura, no se puede crear CFD","Mensaje del sistema")
		return .f.
	else
		xComprobante:setAttribute("metodoDePago",alltrim(mpago) )
	endif
	if empty(lugarexpedicion)
		Msginfo("No se recibió el lugar de expedición de la factura, no se puede crear CFD","Mensaje del sistema")
		return .f.
	else
		xComprobante:setAttribute("LugarExpedicion",alltrim(lugarexpedicion) )
	endif
	if !empty(nscuenta)
		xComprobante:setAttribute("NumCtaPago",alltrim(nscuenta) )
	endif
	/*if !empty(foliofiscalorig)
		xComprobante:setAttribute("FolioFiscalOrig",alltrim(foliofiscalorig) )
	endif
	if !empty(seriefoliofiscalorig)
		xComprobante:setAttribute("SerieFolioFiscalOrig",alltrim(seriefoliofiscalorig) )
	endif
	if !empty(fechafoliofiscalorig)
		xComprobante:setAttribute("FechaFolioFiscalOrig",fechafoliofiscalorig )
	endif
	if !empty(montofoliofiscalorig)
		xComprobante:setAttribute("MontoFolioFiscalOrig",alltrim(montofoliofiscalorig) )
	endif*/
/*	obXml:AppendChild(xComprobante)
	xEmisor := obXml:createElement(tipo+"Emisor")
	if empty(rfcemisor)
		Msginfo("El rfc del emisor esta vacio, imposible generar CFD","Mensaje del sistema")
		return .f.
	else
		xEmisor:setAttribute("rfc",quitaespacios(alltrim(rfcemisor)))
	endif
	if !empty(nombreemisor)
		xEmisor:setAttribute("nombre",quitaespacios(alltrim(nombreemisor)))
	endif
	xDomicilioFiscal := obXml:createElement(tipo+"DomicilioFiscal")
	if empty(calleemisor)
		Msginfo("La calle del emisor esta vacia, imposible generar CFD","Mensaje del sistema")
		return .f.
	else
		xDomicilioFiscal:setAttribute("calle",quitaespacios(alltrim(calleemisor)))
	endif
	if !empty(noexterioremisor) 
		xDomicilioFiscal:setAttribute("noExterior",quitaespacios(alltrim(noexterioremisor)))
	endif
	if !empty(nointerioremisor)
		xDomicilioFiscal:setAttribute("noInterior",quitaespacios(alltrim(nointerioremisor)))
	endif
	if !empty(coloniaemisor)
		xDomicilioFiscal:setAttribute("colonia",quitaespacios(alltrim(coloniaemisor)))
	endif
	if !empty(localidademisor)
		xDomicilioFiscal:setAttribute("localidad",quitaespacios(alltrim(localidademisor)))
	endif
	/*if !empty(referenciaemisor)
		xDomicilioFiscal:setAttribute("referencia",quitaespacios(alltrim(referenciaemisor)))
	endif*/
/*	if empty(municipioemisor)
		Msginfo("El municipio del emisor esta vacio, imposible generar CFD","Mensaje del sistema")
		return .f.
	else
		xDomicilioFiscal:setAttribute("municipio",quitaespacios(alltrim(municipioemisor)))
	endif
	if empty(estadoemisor)
		Msginfo("El estado del emisor esta vacio, imposible generar CFD","Mensaje del sistema")
		return .f.
	else
		xDomicilioFiscal:setAttribute("estado",quitaespacios(alltrim(estadoemisor)))
	endif
	if empty(paisemisor)
		Msginfo("El pais del emisor esta vacio, imposible generar CFD","Mensaje del sistema")
		return .f.
	else
		xDomicilioFiscal:setAttribute("pais",quitaespacios(alltrim(paisemisor)))
	endif
	if empty(cpemisor)
		Msginfo("El cp del emisor esta vacio, imposible generar CFD","Mensaje del sistema")
		return .f.
	else
		xDomicilioFiscal:setAttribute("codigoPostal",quitaespacios(alltrim(cpemisor)))
	endif
	xEmisor:AppendChild(xDomicilioFiscal)
	if !empty(paisexpedido)
		xExpedidoEn := obXml:createElement(tipo+"ExpedidoEn")
		if !empty(calleexpedido)
			xExpedidoEn:setAttribute("calle",quitaespacios(alltrim(calleexpedido)))
		endif
		if !empty(noexteriorexpedido) 
			xExpedidoEn:setAttribute("noExterior",quitaespacios(alltrim(noexteriorexpedido)))
		endif
		if !empty(nointeriorexpedido)
			xExpedidoEn:setAttribute("noInterior",quitaespacios(alltrim(nointeriorexpedido)))
		endif
		if !empty(coloniaexpedido)
			xExpedidoEn:setAttribute("colonia",quitaespacios(alltrim(coloniaexpedido)))
		endif
		if !empty(localidadexpedido)
			xExpedidoEn:setAttribute("localidad",quitaespacios(alltrim(localidadexpedido)))
		endif
		/*if !empty(referenciaexpedido)
			xExpedidoEn:setAttribute("referencia",quitaespacios(alltrim(referenciaexpedido)))
		endif*/
/*		if !empty(municipioexpedido)
			xExpedidoEn:setAttribute("municipio",quitaespacios(alltrim(municipioexpedido)))
		endif
		if !empty(estadoexpedido)
			xExpedidoEn:setAttribute("estado",quitaespacios(alltrim(estadoemisor)))
		endif
		if empty(paisexpedido)
			Msginfo("El pais de Expedido En esta vacio, imposible generar CFD","Mensaje del sistema")
			return .f.
		else
			xExpedidoEn:setAttribute("pais",quitaespacios(alltrim(paisexpedido)))
		endif
		if !empty(cpexpedido)
			xExpedidoEn:setAttribute("codigoPostal",quitaespacios(alltrim(cpexpedido)))
		endif
		xEmisor:AppendChild(xExpedidoEn)
	endif
	if len(regimenfac)<1
		Msginfo("No se recibio ningún regimen fiscal, imposible generar CFD","Mensaje del sistema")
		return .f.
	else
		for x:=1 to len(regimenfac)
			xRegimenFiscal := obXml:createElement(tipo+"RegimenFiscal")
			xRegimenFiscal:setAttribute("Regimen",quitaespacios(alltrim(regimenfac[x])))
			xEmisor:AppendChild(xRegimenFiscal)
		next
	endif
	xComprobante:AppendChild(xEmisor)
	xReceptor := obXml:createElement(tipo+"Receptor")
	if empty(rfcreceptor)
		Msginfo("El rfc del receptor esta vacio, imposible generar CFDI","Mensaje del sistema")
		return .f.
	else
		xReceptor:setAttribute("rfc",quitaespacios(alltrim(rfcreceptor)))
	endif
	if !empty(nombrereceptor)
		xReceptor:setAttribute("nombre",quitaespacios(alltrim(nombrereceptor)))
	endif
	if !empty(paisreceptor)
		xDomicilioReceptor := obXml:createElement(tipo+"Domicilio")
		if empty(callereceptor)
			Msginfo("La calle del receptor esta vacia, imposible generar CFD","Mensaje del sistema")
			return .f.
		else
			xDomicilioReceptor:setAttribute("calle",quitaespacios(alltrim(callereceptor)))
		endif
		if !empty(noexteriorreceptor)
			xDomicilioReceptor:setAttribute("noExterior",quitaespacios(alltrim(noexteriorreceptor)))
		endif
		if !empty(nointeriorreceptor)
			xDomicilioReceptor:setAttribute("noInterior",quitaespacios(alltrim(nointeriorreceptor)))
		endif
		if !empty(coloniareceptor)
			xDomicilioReceptor:setAttribute("colonia",quitaespacios(alltrim(coloniareceptor)))
		endif
		if !empty(localidadreceptor)
			xDomicilioReceptor:setAttribute("localidad",quitaespacios(alltrim(localidadreceptor)))
		endif
		if !empty(municipioreceptor)
			xDomicilioReceptor:setAttribute("municipio",quitaespacios(alltrim(municipioreceptor)))
		endif
		if !empty(estadoreceptor)
			xDomicilioReceptor:setAttribute("estado",quitaespacios(alltrim(estadoreceptor)))
		endif
		if empty(paisreceptor)
			Msginfo("El País del receptor esta vacio, imposible generar CFD","Mensaje del sistema")
			return .f.
		else
			xDomicilioReceptor:setAttribute("pais",quitaespacios(alltrim(paisreceptor)))
		endif
		if !empty(cpreceptor) .or. val(cpreceptor)=0
			xDomicilioReceptor:setAttribute("codigoPostal",quitaespacios(alltrim(cpreceptor)))
		endif
		xReceptor:AppendChild(xDomicilioReceptor)
	endif
	xComprobante:AppendChild(xReceptor)
	if empty(nconceptos)
		Msginfo("No se recibió el nummero de conceptos de la factura, no se puede crear CFD","Mensaje del sistema")
		return .f.
	else
		xConceptos := obXml:createElement(tipo+"Conceptos")
		for x:=1 to nconceptos
			xConcepto := obXml:createElement(tipo+"Concepto")
			if empty(arrayconceptos[x,1])
				Msginfo("No se recibió la cantidad en un articulo, no se puede crear CFD","Mensaje del sistema")
				return .f.
			else
				xConcepto:setAttribute("cantidad",quitaespacios(alltrim(arrayconceptos[x,1])))
			endif
			if empty(arrayconceptos[x,2])
				Msginfo("No se recibió la unidad de un articulo, no se puede crear CFD","Mensaje del sistema")
				return .f.
			else
				xConcepto:setAttribute("unidad",quitaespacios(alltrim(arrayconceptos[x,2])))
			endif
			if !empty(arrayconceptos[x,3])
				xConcepto:setAttribute("noIdentificacion",quitaespacios(alltrim(arrayconceptos[x,3])))
			endif
			if empty(arrayconceptos[x,4])
				Msginfo("No se recibió la descripcion de un articulo, no se puede crear CFD","Mensaje del sistema")
				return .f.
			else
				xConcepto:setAttribute("descripcion",quitaespacios(alltrim(arrayconceptos[x,4])))
			endif
			if empty(arrayconceptos[x,5])
				Msginfo("No se recibió el valor unitario de un articulo, no se puede crear CFD","Mensaje del sistema")
				return .f.
			else
				xConcepto:setAttribute("valorUnitario",quitaespacios(alltrim(arrayconceptos[x,5])))
			endif
			if empty(arrayconceptos[x,6])
				Msginfo("No se recibió el importe de un articulo, no se puede crear CFD","Mensaje del sistema")
				return .f.
			else
				xConcepto:setAttribute("importe",quitaespacios(alltrim(arrayconceptos[x,6])))
			endif
			xConceptos:AppendChild(xConcepto)
		next
		xComprobante:AppendChild(xConceptos)
	endif
	xImpuestos := obXml:createElement(tipo+"Impuestos")
	if !empty(totalimpuestosretenidos)
		xImpuestos:setAttribute("totalImpuestosRetenidos",quitaespacios(alltrim(totalimpuestosretenidos)))
	endif
	if !empty(totalimpuestostrasladados)
		xImpuestos:setAttribute("totalImpuestosTrasladados",quitaespacios(alltrim(totalimpuestostrasladados)))
	endif
	if !empty(totalimpuestosretenidos) .or. len(retenciones)>=1
		xRetenciones := obXml:createElement(tipo+"Retenciones")
		if len(retenciones)<1
			Msginfo("No se recibió ningun detalle de retenciones y el comprobante si contiene tal impuesto, no se puede crear CFD","Mensaje del sistema")
			return .f.
		else
			for x:=1 to len(retenciones)
				xRetencion := obXml:createElement(tipo+"Retencion")
				if empty(retenciones[x,1])
					Msginfo("No se recibió el nombre de una retencion, no se puede crear CFD","Mensaje del sistema")
					return .f.
				else
					xRetencion:setAttribute("impuesto",quitaespacios(alltrim(retenciones[x,1])))
				endif
				if empty(retenciones[x,2])
					Msginfo("No se recibió el importe de una retencion, no se puede crear CFD","Mensaje del sistema")
					return .f.
				else
					xRetencion:setAttribute("importe",quitaespacios(alltrim(retenciones[x,2])))
				endif
				xRetenciones:AppendChild(xRetencion)
			next
		endif
		xImpuestos:AppendChild(xRetenciones)
	endif
	if !empty(totalimpuestostrasladados) .or. len(traslados)>=1
		xTraslados := obXml:createElement(tipo+"Traslados")
		if len(traslados)<1
			Msginfo("No se recibió ningun detalle de traslados y el comprobante si contiene tal impuesto, no se puede crear CFD","Mensaje del sistema")
			return .f.
		else
			for x:=1 to len(traslados)
				xTraslado := obXml:createElement(tipo+"Traslado")
				if empty(traslados[x,1])
					Msginfo("No se recibió el nombre de un traslado, no se puede crear CFD","Mensaje del sistema")
					return .f.
				else
					if (alltrim(traslados[x,1]) != 'IVA') .and. (alltrim(traslados[x,1]) != 'IEPS')
						Msginfo("El nombre de un traslado es incorrecto, no se puede crear CFD","Mensaje del sistema")
						return .f.
					else
						xTraslado:setAttribute("impuesto",quitaespacios(alltrim(traslados[x,1])))
					endif
				endif
				if empty(traslados[x,2])
					Msginfo("No se recibió la tasa de un traslado, no se puede crear CFD","Mensaje del sistema")
					return .f.
				else
					xTraslado:setAttribute("tasa",quitaespacios(alltrim(traslados[x,2])))
				endif
				if empty(traslados[x,3])
					Msginfo("No se recibió el importe de un traslado, no se puede crear CFD","Mensaje del sistema")
					return .f.
				else
					if alltrim(traslados[x,1]) == 'IVA'
						totaliva:=traslados[x,3]
					endif
					xTraslado:setAttribute("importe",quitaespacios(alltrim(traslados[x,3])))
				endif
				xTraslados:AppendChild(xTraslado)
			next
		endif
		xImpuestos:AppendChild(xTraslados)
	endif
	xComprobante:AppendChild(xImpuestos)
	
	// Load the two DOMDocuments with the XML document and the XSLT style sheet.
    // Use the transformNode method to apply the XSLT to the XML.
	//memowrit("d:\desarrollo\prueba2.xml",obxml:xml)
	BEGIN SEQUENCE
		objSrcTree := CreateObject( "MSXML2.DOMDocument" )
		objXSLT    := CreateObject( "MSXML2.DOMDocument" )
		objSrcTree:load(obXml)
		if empty(alltrim(tipo))
			objXSLT:load(rutaxslt2)
		else
			rutaxslt:=empresas->rutaxslt
			objXSLT:load(rutaxslt)
		endif
		strResult := objSrcTree:transformNode(objXSLT)
	RECOVER
		oError :=  objXSLT:ParseError()
         if oError:errorCode != 0
              Msginfo( "Error al crear la cadena, "+alltrim(str(oError:errorCode))+", "+oError:reason+", "+alltrim(str(oError:line))+", "+alltrim(str(oError:linepos)),"Errores")
			  return .f.
         endif
	END SEQUENCE
	

	co:=strResult
	sellodigital:=calculasello(co)
	xComprobante:setAttribute("sello",sellodigital )
	// Declare two new MSXML DOMDocument objects.
	oSC := Createobject("Msxml2.XMLSchemaCache.6.0")
	if empty(alltrim(tipo))
		oSC:add("http://www.sat.gob.mx/cfd/2",rutaxsd2)
	else
		rutaxds:=empresas->rutaxsd
		oSC:add("http://www.sat.gob.mx/cfd/3",rutaxsd)
	endif
	oXD := Createobject("MSXML2.DOMDocument.6.0")
	oXD:schemas = oSC
	oXD:Async = 'false'
	BEGIN SEQUENCE
		oXD:Load(obXml)
	RECOVER
		oError :=  oXD:ParseError()
        if oError:errorCode != 0
            Msginfo( "Error al validar XML, "+alltrim(str(oError:errorCode))+", "+oError:reason+", "+alltrim(str(oError:line))+", "+alltrim(str(oError:linepos)),"Errores")
			return .f.
        endif
	END SEQUENCE
	If oXD:parseError:errorCode <> 0 
		Msginfo(oXD:parseError:reason + oXD:parseError:srcText,"Error al validar XML")
		return .f.
	endif
	
	nomfile:="F:\FactElec\XML\DIVERSOS\CMA930425IZ2_DIV-" + strzero(val(foliofac),7) + ".xml"
	//nomfile:="./XML/CMA930425IZ2_DIV-" + strzero(val(foliofac),7) + ".xml"
	lnSuccess := obXml:Save(nomfile)
	if tipo=='cfdi:'
		cStr := MemoRead( nomfile )
		xmltimbrado:=timbrarc(cStr,uspac,passpac,nfactura)
		if xmltimbrado=="Error"
			return .f.
		endif
		oDocXML := TXmlDocument():New( xmltimbrado, HBXML_STYLE_NOESCAPE )
		if (nHandle := FCREATE(nomfile))<0
			Msginfo("No se pudo crear el XML ya timbrado contacte a sistemas")
			return .f.
		endif
		oNode := oDocXML:FindFirst( "tfd:TimbreFiscalDigital" )
		vUUID:=oNode:GetAttribute("UUID")
		vversion:=oNode:GetAttribute("version")
		vsellosat:=oNode:GetAttribute("selloSAT")
		vFechaTimbrado:=oNode:GetAttribute("FechaTimbrado")
		vnoCertificadoSAT:=oNode:GetAttribute("noCertificadoSAT")
		oDocXML:Write( nHandle, HBXML_STYLE_INDENT + HBXML_STYLE_THREESPACES )
		FClose( nHandle )
	endif
	
	//nomfile:="./"+alltrim(empresas->clave)+"/XML/" + rfcemisor+'_'+seriefac+'-'+foliofac + ".xml"
	//lnSuccess := obXml:Save(nomfile)
	
/*	select ediverso
    set order to 1
    seek altadiverso.text_3.value
    if !found()
		append blank
		ediverso->serie:='DIV'
		ediverso->folio:=diverso->numero
		ediverso->fecha:=mfechae+' '+mtiempom
		ediverso->certifica:=empresas->nocertific
		ediverso->cadena:=co
        ediverso->sello:=sellodigital
        ediverso->rfc:=mrfc
        ediverso->mes:=month(date())
	    ediverso->anio:=year(date())
	    ediverso->total:=altadiverso.text_16.value
	    ediverso->iva:=altadiverso.text_15.value
		ediverso->UUID:=vUUID
		ediverso->versat:=vversion
		ediverso->sellosat:=vsellosat
		ediverso->FechaTimbr:=vFechaTimbrado
		ediverso->noCertific:=vnoCertificadoSAT
        ediverso->(dbcommitall())
        ediverso->(dbunlock())
    endif*/
return .t.

function agregaconceptosacadena(nconceptos,aconceptos)
/*   cadenaconceptos:=""
   for x:=1 to nconceptos
     cadenaconceptos:=cadenaconceptos+"|"+alltrim(aconceptos[x,1])+"|"+alltrim(aconceptos[x,2])+"|"+alltrim(aconceptos[x,3])+"|"+alltrim(aconceptos[x,4])+"|"+alltrim(aconceptos[x,5])
   next*/
return(cadenaconceptos)

function calculasello(co)
/*   //Agregar validacion de fecha de certificado
   select empresas
   if empty(empresas->key) .or. empty(empresas->certificad)
      Msginfo("Debe cargar primero los archivo .cer y .key en la configuracion de su empresa","Mensaje del sistema")
      return
   endif
   stringkey:=alltrim(empresas->key)//llave privada en pem
   co:=alltrim(co)//cadena original
   coutf8:=unitou8(co)//cadena original en utf8
   PrivateKey := EVP_PKEY_NEW() //Creamos varibale llave privada
   keyPtr := PEM_READ_BIO_RSAPRIVATEKEY(bio :=BIO_new_mem_buf( stringkey ),  alltrim(empresas->keypass)  )//cargamos la llave privada con su contraseña 
   EVP_PKEY_ASSIGN_RSA(PrivateKey,keyPtr)//la asignamos para su evaluacion
   ctx := EVP_MD_CTX_create() //creamos variable de evaluacion
   EVP_MD_CTX_init( ctx ) //incializamos varibale de evaluacion
   signed := "" //inicializamos variable del resultado de evaluacion
   EVP_SignInit_ex(ctx, HB_EVP_MD_SHA1) //Establecemos el metodo de encriptacion
   EVP_SignUpdate(ctx, coutf8) //Le mandamos el mensaje a encriptar
   EVP_SignFinal(ctx, @signed, PrivateKey)//Evaluamos mensaje a encriptar,resultado,llaveprivada
   sellodigital := HB_BASE64ENCODE(signed)//Codificamos el resultado en base 64
   EVP_cleanup()//limpiamos variable*/
return(sellodigital)

function agregaconceptosxml(nconceptos,aconceptos)
/*   conceptosxml:=""
   for x:=1 to nconceptos
     conceptosxml:=conceptosxml+'<Concepto cantidad="'+alltrim(aconceptos[x,1])+'" unidad="'+alltrim(aconceptos[x,2])+'" descripcion="'+alltrim(aconceptos[x,3])+'" valorUnitario="'+alltrim(aconceptos[x,4])+'" importe="'+alltrim(aconceptos[x,5])+'"></Concepto>'
   next*/
return(conceptosxml)

function pegacertificado(certificado)
/*   certificado:=strtran(certificado, Chr(10), "")
   certificado:=strtran(certificado, Chr(13), "")
   certificado:=strtran(certificado," ", "")
   certificado:=strtran(certificado,"-", "")
   certificado:=strtran(certificado,"END", "")
   certificado:=strtran(certificado,"BEGIN", "")
   certificado:=strtran(certificado,"CERTIFICATE", "")*/
return(certificado)

function quitaespacios(original)
/*   sinespacios:=original
   espacioant:=0
   for clargo:=1 to len(sinespacios)
      if substr(sinespacios,clargo,1)=chr(32)
         if espacioant==0
            espacioant:=1
         else
            sinespacios:=substr(sinespacios,1,clargo-1)+substr(sinespacios,clargo+1,len(sinespacios)-clargo)
            espacioant:=0
         endif
      else
         espacioant:=0
      endif
   next
   *Msginfo(original+' '+sinespacios,"Mensaje del sistema")*/
return sinespacios

function timbrarc (xml,usuario,pass,nfactura)
/*	setimbro:="Error"
	xmltimbrado:=''
	//Usuario y password del PAC
	xml := STRTRAN( xml, "<", "&lt;" )
	xml := STRTRAN( xml, ">", "&gt;" )
	xml := STRTRAN( xml, '"', "&quot;" )
	//Armamos xml de peticion
	cxml :=      '<?xml version="1.0" encoding="UTF-8" standalone="no"?>'+chr(13)+chr(10)
	cxml :=cxml+ '<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:tm="http://microsoft.com/wsdl/mime/textMatching/" xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:mime="http://schemas.xmlsoap.org/wsdl/mime/" xmlns:tns="https://www.fel.mx/WS-TFD" xmlns:s="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://schemas.xmlsoap.org/wsdl/soap12/" xmlns:http="http://schemas.xmlsoap.org/wsdl/http/" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" >'
	cxml :=cxml+ '<SOAP-ENV:Body>'
	cxml :=cxml+ '<tns:TimbrarCFD xmlns:tns="https://www.fel.mx/WS-TFD">'
	//cxml :=cxml+ '<tns:TimbrarCFDPrueba xmlns:tns="https://www.fel.mx/WS-TFD">'
	cxml :=cxml+ '<tns:usuario>'+alltrim(usuario)+'</tns:usuario>'
	cxml :=cxml+ '<tns:password>'+alltrim(pass)+'</tns:password>'
	cxml :=cxml+ '<tns:cadenaXML>'+xml+'</tns:cadenaXML>'
	//cxml :=cxml+ '<tns:cadena>'+xml+'</tns:cadena>'
	cxml :=cxml+ '<tns:referencia>'+nfactura+'</tns:referencia>'
	cxml :=cxml+ '</tns:TimbrarCFD>'
	//cxml :=cxml+ '</tns:TimbrarCFDPrueba>'
	cxml :=cxml+ '</SOAP-ENV:Body>'
	cxml :=cxml+ '</SOAP-ENV:Envelope>'
	//Ejecutamos la pericion y leemos el xml de respuesta si contiene respuesta en los campos de error lo mostramos si no retornamos el xml timbrado
	//memowrit("peticion.xml",cxml)
	canswer := fHttpExecute(cxml)
	canswer := strtran(canswer,"><",">"+chr(10)+"<")
	//memowrit("respuesta.xml",cxml)
	oXml := TXmlDocument():New( canswer )   
	if oXml:nStatus != HBXML_STATUS_OK
		switch oXml:nStatus
			case HBXML_STATUS_ERROR
				MsgInfo("Error al leer el XML",'Mensaje del Sistema') 
				return
			case HBXML_STATUS_MALFORMED
				MsgInfo("La estructura del XML es incorrecta",'Mensaje del Sistema') 
				return
		end
		return
	endif
	oNodo := oXml:FindFirst( "string" )
	cerror:=oNodo:CData
	oNodo:=oNodo:NextInTree()
	merror:=oNodo:CData
	oNodo:=oNodo:NextInTree()
	merror2:=oNodo:CData
	oNodo:=oNodo:NextInTree()
	xmltimbrado:=oNodo:CData
	if empty(cerror) .and. empty(merror) .and. empty(merror2)
		setimbro:=xmltimbrado
		return setimbro
	else
		Msginfo("Codigo de error: "+iif(!empty(cerror),cerror,'')+" "+iif(!empty(merror),merror,'')+" "+iif(!empty(merror2),merror2,''),"Error al procesar XML")
		return setimbro
	endif
return

function fHttpExecute(cxml)
	local endpointUrl,curlHandle,curlErr
	local aHeader,cc1

	cc1 := ""

	endpointUrl = "http://www.fel.mx/WS-TFD/WS-TFD.asmx?WSDL"

	aHeader := {}
	AADD(aHeader,"POST /WS-TFD/WS-TFD.asmx HTTP/1.1" )
	AADD(aHeader,"Host:www.fel.mx" )
	AADD(aHeader,"Content-Type: text/xml; charset=utf-8" )
	AADD(aHeader,'SOAPAction: "https://www.fel.mx/WS-TFD/TimbrarCFD"' )
	//AADD(aHeader,'SOAPAction: "https://www.fel.mx/WS-TFD/TimbrarCFDPrueba"' )

	curlHandle := curl_easy_init()

	if !empty(curlHandle)

	   /* Set the endpoint to send the POST to */
/*		curl_easy_setopt(curlHandle, HB_CURLOPT_URL, endpointUrl)
	
		/* Specify the Header  data */
		
/*		proxy:=alltrim(empresas->proxy)
		if !empty(proxy)
			curl_easy_setopt(curlHandle, HB_CURLOPT_PROXY , proxy )
			curl_easy_setopt(curlHandle, HB_CURLOPT_FOLLOWLOCATION, 1)
		endif
		curl_easy_setopt(curlHandle,HB_CURLOPT_HTTPHEADER,aHeader)

		/* Setup response data */
/*		curl_easy_setopt( curlHandle, HB_CURLOPT_DOWNLOAD )
		curl_easy_setopt( curlHandle, HB_CURLOPT_DL_BUFF_SETUP )

		/* Specify the POST data */
/*		curl_easy_setopt(curlHandle, HB_CURLOPT_POST, 1)
		curl_easy_setopt(curlHandle, HB_CURLOPT_POSTFIELDS, cxml)

		/* Do everything */
/*		curlErr := curl_easy_perform(curlHandle)

		/* Report any errors */
/*		if empty(curlErr)
			/* store response in variable */
/*			cc1 := curl_easy_dl_buff_get( curlHandle )
		else
			Msginfo( curl_easy_strerror(curlErr))
		endif
	else
		Msginfo( "No handle")
	endif

	if !empty(curlHandle)
		/* Clean-up libcurl */
/*		curl_global_cleanup( curlHandle )
	else
		Msginfo( "Error 1")
	endif

	if empty(cc1)
		Msginfo("Error 2")
	endif
*/
return cc1
