/*
 * Harbour 3.2.0dev (r1509031202)
 * MinGW GNU C 4.6.1 (32-bit)
 * Generated C source from "D:\ProgramasCOMAPA\Comercial\ComapaMysql\facturaelectronica.prg"
 */

#include "hbvmpub.h"
#include "hbinit.h"


HB_FUNC( CREAFACTELEC );
HB_FUNC( AGREGACONCEPTOSACADENA );
HB_FUNC( CALCULASELLO );
HB_FUNC( AGREGACONCEPTOSXML );
HB_FUNC( PEGACERTIFICADO );
HB_FUNC( QUITAESPACIOS );
HB_FUNC( TIMBRARC );


HB_INIT_SYMBOLS_BEGIN( hb_vm_SymbolInit_FACTURAELECTRONICA )
{ "CREAFACTELEC", {HB_FS_PUBLIC | HB_FS_FIRST | HB_FS_LOCAL}, {HB_FUNCNAME( CREAFACTELEC )}, NULL },
{ "AGREGACONCEPTOSACADENA", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( AGREGACONCEPTOSACADENA )}, NULL },
{ "CADENACONCEPTOS", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "CALCULASELLO", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( CALCULASELLO )}, NULL },
{ "SELLODIGITAL", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "AGREGACONCEPTOSXML", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( AGREGACONCEPTOSXML )}, NULL },
{ "CONCEPTOSXML", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "PEGACERTIFICADO", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( PEGACERTIFICADO )}, NULL },
{ "QUITAESPACIOS", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( QUITAESPACIOS )}, NULL },
{ "SINESPACIOS", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "TIMBRARC", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( TIMBRARC )}, NULL },
{ "CC1", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL }
HB_INIT_SYMBOLS_EX_END( hb_vm_SymbolInit_FACTURAELECTRONICA, "D:\\ProgramasCOMAPA\\Comercial\\ComapaMysql\\facturaelectronica.prg", 0x0, 0x0003 )

#if defined( HB_PRAGMA_STARTUP )
   #pragma startup hb_vm_SymbolInit_FACTURAELECTRONICA
#elif defined( HB_DATASEG_STARTUP )
   #define HB_DATASEG_BODY    HB_DATASEG_FUNC( hb_vm_SymbolInit_FACTURAELECTRONICA )
   #include "hbiniseg.h"
#endif

HB_FUNC( CREAFACTELEC )
{
	static const HB_BYTE pcode[] =
	{
		13,0,59,36,13,2,120,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( AGREGACONCEPTOSACADENA )
{
	static const HB_BYTE pcode[] =
	{
		13,0,2,36,20,2,109,2,0,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( CALCULASELLO )
{
	static const HB_BYTE pcode[] =
	{
		13,0,1,36,43,2,109,4,0,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( AGREGACONCEPTOSXML )
{
	static const HB_BYTE pcode[] =
	{
		13,0,2,36,50,2,109,6,0,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( PEGACERTIFICADO )
{
	static const HB_BYTE pcode[] =
	{
		13,0,1,36,60,2,95,1,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( QUITAESPACIOS )
{
	static const HB_BYTE pcode[] =
	{
		13,0,1,36,78,2,109,9,0,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( TIMBRARC )
{
	static const HB_BYTE pcode[] =
	{
		13,0,4,36,200,2,109,11,0,110,7
	};

	hb_vmExecute( pcode, symbols );
}

