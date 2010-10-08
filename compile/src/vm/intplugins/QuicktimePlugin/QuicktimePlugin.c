/* Automatically generated from Squeak on 23 September 2010 11:58:59 am 
   by VMMaker 3.11.13
 */

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

/* Default EXPORT macro that does nothing (see comment in sq.h): */
#define EXPORT(returnType) returnType

/* Do not include the entire sq.h file but just those parts needed. */
/*  The virtual machine proxy definition */
#include "sqVirtualMachine.h"
/* Configuration options */
#include "sqConfig.h"
/* Platform specific definitions */
#include "sqPlatformSpecific.h"

#define true 1
#define false 0
#define null 0  /* using 'null' because nil is predefined in Think C */
#ifdef SQUEAK_BUILTIN_PLUGIN
#undef EXPORT
// was #undef EXPORT(returnType) but screws NorCroft cc
#define EXPORT(returnType) static returnType
#endif
#include "QuicktimePlugin.h"

#include "sqMemoryAccess.h"


/*** Constants ***/

/*** Function Prototypes ***/
static VirtualMachine * getInterpreter(void);
#pragma export on
EXPORT(const char*) getModuleName(void);
#pragma export off
static sqInt halt(void);
#pragma export on
EXPORT(sqInt) initialiseModule(void);
EXPORT(sqInt) moduleUnloaded(char * aModuleName);
#pragma export off
static sqInt msg(char * s);
#pragma export on
EXPORT(sqInt) primitiveClearFrameCompletedSemaphore(void);
EXPORT(sqInt) primitiveDestroyHandle(void);
EXPORT(sqInt) primitiveDestroySurface(void);
EXPORT(sqInt) primitiveSetFrameCompletedSemaphore(void);
EXPORT(sqInt) primitiveSetGWorldPtrOntoExistingSurface(void);
EXPORT(sqInt) primitiveSetGWorldPtrOntoSurface(void);
EXPORT(sqInt) setInterpreter(struct VirtualMachine* anInterpreter);
#pragma export off
static sqInt sqAssert(sqInt aBool);
/*** Variables ***/

#ifdef SQUEAK_BUILTIN_PLUGIN
extern
#endif
struct VirtualMachine* interpreterProxy;
static const char *moduleName =
#ifdef SQUEAK_BUILTIN_PLUGIN
	"QuicktimePlugin 23 September 2010 (i)"
#else
	"QuicktimePlugin 23 September 2010 (e)"
#endif
;



/*	Note: This is coded so that plugins can be run from Squeak. */

static VirtualMachine * getInterpreter(void) {
	return interpreterProxy;
}


/*	Note: This is hardcoded so it can be run from Squeak.
	The module name is used for validating a module *after*
	it is loaded to check if it does really contain the module
	we're thinking it contains. This is important! */

EXPORT(const char*) getModuleName(void) {
	return moduleName;
}

static sqInt halt(void) {
	;
}

EXPORT(sqInt) initialiseModule(void) {
	return sqQuicktimeInitialize();
}


/*	The module with the given name was just unloaded. 
	Make sure we have no dangling references. */

EXPORT(sqInt) moduleUnloaded(char * aModuleName) {
	if ((strcmp(aModuleName, "QuicktimePlugin")) == 0) {
		sqQuicktimeShutdown();
	}
}

static sqInt msg(char * s) {
	fprintf(stderr, "\n%s: %s", moduleName, s);
}

EXPORT(sqInt) primitiveClearFrameCompletedSemaphore(void) {
	sqInt data;

	data = interpreterProxy->stackIntegerValue(0);
	if (interpreterProxy->failed()) {
		return null;
	}
	stQuicktimeClearSemaphore(data);
	return null;
}

EXPORT(sqInt) primitiveDestroyHandle(void) {
	sqInt data;

	data = interpreterProxy->stackIntegerValue(0);
	if (interpreterProxy->failed()) {
		return null;
	}
	stQuicktimeDestroy(data);
	return null;
}

EXPORT(sqInt) primitiveDestroySurface(void) {
	sqInt data;

	data = interpreterProxy->stackIntegerValue(0);
	if (interpreterProxy->failed()) {
		return null;
	}
	stQuicktimeDestroySurface(data);
	return null;
}

EXPORT(sqInt) primitiveSetFrameCompletedSemaphore(void) {
	sqInt semaIndex;
	sqInt data;

	semaIndex = interpreterProxy->stackIntegerValue(1);
	data = interpreterProxy->stackIntegerValue(0);
	if (interpreterProxy->failed()) {
		return null;
	}
	stQuicktimeSetSemaphorefor(semaIndex, data);
	return null;
}

EXPORT(sqInt) primitiveSetGWorldPtrOntoExistingSurface(void) {
	sqInt movie;
	sqInt buffer;
	sqInt surfaceID;
	sqInt bitMapPtr;
	sqInt width;
	sqInt height;
	sqInt rowBytes;
	sqInt depth;
	sqInt moviePtr;

	surfaceID = interpreterProxy->stackIntegerValue(6);
	bitMapPtr = interpreterProxy->stackValue(5);
	width = interpreterProxy->stackIntegerValue(4);
	height = interpreterProxy->stackIntegerValue(3);
	rowBytes = interpreterProxy->stackIntegerValue(2);
	depth = interpreterProxy->stackIntegerValue(1);
	moviePtr = interpreterProxy->stackValue(0);
	if (interpreterProxy->failed()) {
		return null;
	}
	buffer = ((char *) (interpreterProxy->positive32BitValueOf(bitMapPtr)));
	movie = ((long) (interpreterProxy->positive32BitValueOf(moviePtr)));
	stQuicktimeSetToExistingSurfacegworldwidthheightrowBytesdepthmovie(surfaceID, buffer, width, height, rowBytes, depth, movie);
	if (interpreterProxy->failed()) {
		return null;
	}
	interpreterProxy->pop(7);
	return null;
}

EXPORT(sqInt) primitiveSetGWorldPtrOntoSurface(void) {
	sqInt results;
	sqInt movie;
	sqInt buffer;
	sqInt bitMapPtr;
	sqInt width;
	sqInt height;
	sqInt rowBytes;
	sqInt depth;
	sqInt moviePtr;
	sqInt _return_value;

	bitMapPtr = interpreterProxy->stackValue(5);
	width = interpreterProxy->stackIntegerValue(4);
	height = interpreterProxy->stackIntegerValue(3);
	rowBytes = interpreterProxy->stackIntegerValue(2);
	depth = interpreterProxy->stackIntegerValue(1);
	moviePtr = interpreterProxy->stackValue(0);
	if (interpreterProxy->failed()) {
		return null;
	}
	buffer = ((char *) (interpreterProxy->positive32BitValueOf(bitMapPtr)));
	movie = ((long) (interpreterProxy->positive32BitValueOf(moviePtr)));
	results = stQuicktimeSetSurfacewidthheightrowBytesdepthmovie(buffer, width, height, rowBytes, depth, movie);
	_return_value = interpreterProxy->integerObjectOf(results);
	if (interpreterProxy->failed()) {
		return null;
	}
	interpreterProxy->popthenPush(7, _return_value);
	return null;
}


/*	Note: This is coded so that is can be run from Squeak. */

EXPORT(sqInt) setInterpreter(struct VirtualMachine* anInterpreter) {
	sqInt ok;

	interpreterProxy = anInterpreter;
	ok = interpreterProxy->majorVersion() == VM_PROXY_MAJOR;
	if (ok == 0) {
		return 0;
	}
	ok = interpreterProxy->minorVersion() >= VM_PROXY_MINOR;
	return ok;
}

static sqInt sqAssert(sqInt aBool) {
	/* missing DebugCode */;
}


#ifdef SQUEAK_BUILTIN_PLUGIN


void* QuicktimePlugin_exports[][3] = {
	{"QuicktimePlugin", "primitiveSetGWorldPtrOntoExistingSurface", (void*)primitiveSetGWorldPtrOntoExistingSurface},
	{"QuicktimePlugin", "primitiveDestroySurface", (void*)primitiveDestroySurface},
	{"QuicktimePlugin", "moduleUnloaded", (void*)moduleUnloaded},
	{"QuicktimePlugin", "initialiseModule", (void*)initialiseModule},
	{"QuicktimePlugin", "setInterpreter", (void*)setInterpreter},
	{"QuicktimePlugin", "getModuleName", (void*)getModuleName},
	{"QuicktimePlugin", "primitiveSetGWorldPtrOntoSurface", (void*)primitiveSetGWorldPtrOntoSurface},
	{"QuicktimePlugin", "primitiveDestroyHandle", (void*)primitiveDestroyHandle},
	{"QuicktimePlugin", "primitiveClearFrameCompletedSemaphore", (void*)primitiveClearFrameCompletedSemaphore},
	{"QuicktimePlugin", "primitiveSetFrameCompletedSemaphore", (void*)primitiveSetFrameCompletedSemaphore},
	{NULL, NULL, NULL}
};


#endif /* ifdef SQ_BUILTIN_PLUGIN */

