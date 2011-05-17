# Makefile.plg.in -- default rules for plugins		-*- makefile -*-
# 
#   Copyright (C) 1996-2004 by Ian Piumarta and other authors/contributors
#                              listed elsewhere in this file.
#   All rights reserved.
#   
#   This file is part of Unix Squeak.
# 
#   Permission is hereby granted, free of charge, to any person obtaining a copy
#   of this software and associated documentation files (the "Software"), to deal
#   in the Software without restriction, including without limitation the rights
#   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#   copies of the Software, and to permit persons to whom the Software is
#   furnished to do so, subject to the following conditions:
# 
#   The above copyright notice and this permission notice shall be included in
#   all copies or substantial portions of the Software.
# 
#   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#   SOFTWARE.
# 
# Author: ian.piumarta@inria.fr
# 
# Last edited: 2006-10-18 10:13:37 by piumarta on emilia.local


# make.cfg.in -- mf fragment for configured variables		-*- makefile -*-
# 
#   Copyright (C) 1996-2004 by Ian Piumarta and other authors/contributors
#                              listed elsewhere in this file.
#   All rights reserved.
#   
#   This file is part of Unix Squeak.
# 
#   Permission is hereby granted, free of charge, to any person obtaining a copy
#   of this software and associated documentation files (the "Software"), to deal
#   in the Software without restriction, including without limitation the rights
#   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#   copies of the Software, and to permit persons to whom the Software is
#   furnished to do so, subject to the following conditions:
# 
#   The above copyright notice and this permission notice shall be included in
#   all copies or substantial portions of the Software.
# 
#   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#   SOFTWARE.

# Author: Ian.Piumarta@inria.fr
# 
# Last edited: 2009-08-01 15:18:41 by piumarta on margaux.piumarta.com

MAKEFLAGS=	--no-print-directory



VM_MAJOR=	3
VM_MINOR=	10
VM_RELEASE=	6
VM_VERSION=	3.10-6

SQ_MAJOR=	3
SQ_MINOR=	10
SQ_UPDATE=	7159
SQ_VERSION=	3.10-7159

DEVEL=		@DEVEL@

host=		i386-apple-darwin10.6.0
host_cpu=	i386
host_vendor=	apple
host_os=	darwin10.6.0

topdir=		/Users/arnaudj/Desktop/GIT/Handle
cfgdir=		/Users/arnaudj/Desktop/GIT/Handle/platforms/unix/config
srcdir=		/Users/arnaudj/Desktop/GIT/Handle/src
blddir=		/Users/arnaudj/Desktop/GIT/Handle/platforms/unix

top_builddir=	/Users/arnaudj/Desktop/GIT/Handle/platforms/unix

prefix=		/usr/local
exec_prefix=	${prefix}

bindir=		${exec_prefix}/bin
libdir=		${exec_prefix}/lib
datarootdir=	${prefix}/share
datadir=	${datarootdir}
mandir=		${datarootdir}/man
imgdir=		${prefix}/lib/squeak
plgdir=		/usr/local/lib/squeak/3.10-6
docdir=		$(prefix)/doc/squeak

SHELL=		/bin/sh
MKINSTALLDIRS=	$(SHELL) $(cfgdir)/mkinstalldirs
INSTALL=	/usr/bin/install -c
INSTALL_PROG=	${INSTALL} $(INSTALL_ARGS)
INSTALL_DATA=	${INSTALL} -m 644 $(INSTALL_ARGS)
UNINSTALL=	$(SHELL) $(cfgdir)/uninstall
AS=		as
AWK=		awk
RANLIB=		ranlib
LIBTOOL=	$(SHELL) $(top_builddir)/libtool
NM=		/usr/bin/nm
LN=		ln
LN_S=		ln -s

CC=		gcc
DEFS=		-DHAVE_CONFIG_H
INCLUDES=	-I/Users/arnaudj/Desktop/GIT/Handle/platforms/unix -I/Users/arnaudj/Desktop/GIT/Handle/platforms/unix/vm -I/Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/vm -I/Users/arnaudj/Desktop/GIT/Handle/src/vm
CPPFLAGS=	
CFLAGS=		 -g -O2 -fomit-frame-pointer -DLSB_FIRST=1
WFLAGS=		-Wall -Wno-unknown-pragmas
LDFLAGS=	
SOFLAGS=	@SOFLAGS@
LIBM_CFLAGS=	-O -fomit-frame-pointer

LIBS=		-lm  -framework CoreFoundation -framework CoreServices

X_CFLAGS=	 -g -O2 -fomit-frame-pointer -DLSB_FIRST=1
X_INCLUDES=	-I/Users/arnaudj/Desktop/GIT/Handle/platforms/unix -I/Users/arnaudj/Desktop/GIT/Handle/platforms/unix/vm -I/Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/vm -I/Users/arnaudj/Desktop/GIT/Handle/src/vm
X_LIBS=		-lXrender -lXext  -lSM -lICE  -L/usr/X11/lib -R/usr/X11/lib  -lm  -lX11

LIB_UUID=	

FFI_DIR=	/Users/arnaudj/Desktop/GIT/Handle/platforms/unix/plugins/SqueakFFIPrims
FFI_C=		any-libffi
FFI_S=		any-libffi-asm
FFI_O=		any-libffi$o any-libffi-asm$o

INTERP=		gnu-interp

VM_APP_ICONS=	${prefix}/lib/squeak/SqueakVM.icns

npsqueak=	
install_nps=	
uninstall_nps=	

# make.int.in -- mf fragment for internal plugins		-*- makefile -*-
# 
# Author: Ian.Piumarta@inria.fr
# 
# Last edited: 2002-07-08 20:31:51 by piumarta on emilia.inria.fr

o		= .o
a		= .a
COMPILE		= $(CC) $(CFLAGS) $(XCFLAGS) $(DEFS) $(XDEFS) -DSQUEAK_BUILTIN_PLUGIN \
		  $(INCLUDES) $(XINCLUDES) $(CPPFLAGS) $(XCPPFLAGS) -c -o
LINK		= $(AR) -rc
RANLIB		= ranlib

XINCLUDES	=  -I/Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin 
OBJS		=  JPEGReadWriter2Plugin$o Error$o jcapimin$o jcapistd$o jccoefct$o jccolor$o jcdctmgr$o jchuff$o jcinit$o jcmainct$o jcmarker$o jcmaster$o jcomapi$o jcparam$o jcphuff$o jcprepct$o jcsample$o jctrans$o jdapimin$o jdapistd$o jdatadst$o jdatasrc$o jdcoefct$o jdcolor$o jddctmgr$o jdhuff$o jdinput$o jdmainct$o jdmarker$o jdmaster$o jdmerge$o jdphuff$o jdpostct$o jdsample$o jdtrans$o jerror$o jfdctflt$o jfdctfst$o jfdctint$o jidctflt$o jidctfst$o jidctint$o jidctred$o jmemdatadst$o jmemdatasrc$o jmemmgr$o jmemnobs$o jquant1$o jquant2$o jutils$o
TARGET		= JPEGReadWriter2Plugin$a
PLIBS		= 


# this Makefile.inc intentionally left blank
# 
# (to persuade VMMaker to generate the plugin)

$(TARGET) : $(OBJS) Makefile
	$(LINK) $(TARGET) $(OBJS) $(PLIBS)
	$(RANLIB) $(TARGET)




JPEGReadWriter2Plugin$o : /Users/arnaudj/Desktop/GIT/Handle/src/vm/intplugins/JPEGReadWriter2Plugin/JPEGReadWriter2Plugin.c
	$(COMPILE) JPEGReadWriter2Plugin$o /Users/arnaudj/Desktop/GIT/Handle/src/vm/intplugins/JPEGReadWriter2Plugin/JPEGReadWriter2Plugin.c

Error$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/Error.c
	$(COMPILE) Error$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/Error.c

jcapimin$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jcapimin.c
	$(COMPILE) jcapimin$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jcapimin.c

jcapistd$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jcapistd.c
	$(COMPILE) jcapistd$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jcapistd.c

jccoefct$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jccoefct.c
	$(COMPILE) jccoefct$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jccoefct.c

jccolor$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jccolor.c
	$(COMPILE) jccolor$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jccolor.c

jcdctmgr$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jcdctmgr.c
	$(COMPILE) jcdctmgr$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jcdctmgr.c

jchuff$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jchuff.c
	$(COMPILE) jchuff$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jchuff.c

jcinit$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jcinit.c
	$(COMPILE) jcinit$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jcinit.c

jcmainct$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jcmainct.c
	$(COMPILE) jcmainct$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jcmainct.c

jcmarker$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jcmarker.c
	$(COMPILE) jcmarker$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jcmarker.c

jcmaster$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jcmaster.c
	$(COMPILE) jcmaster$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jcmaster.c

jcomapi$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jcomapi.c
	$(COMPILE) jcomapi$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jcomapi.c

jcparam$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jcparam.c
	$(COMPILE) jcparam$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jcparam.c

jcphuff$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jcphuff.c
	$(COMPILE) jcphuff$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jcphuff.c

jcprepct$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jcprepct.c
	$(COMPILE) jcprepct$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jcprepct.c

jcsample$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jcsample.c
	$(COMPILE) jcsample$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jcsample.c

jctrans$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jctrans.c
	$(COMPILE) jctrans$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jctrans.c

jdapimin$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jdapimin.c
	$(COMPILE) jdapimin$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jdapimin.c

jdapistd$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jdapistd.c
	$(COMPILE) jdapistd$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jdapistd.c

jdatadst$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jdatadst.c
	$(COMPILE) jdatadst$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jdatadst.c

jdatasrc$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jdatasrc.c
	$(COMPILE) jdatasrc$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jdatasrc.c

jdcoefct$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jdcoefct.c
	$(COMPILE) jdcoefct$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jdcoefct.c

jdcolor$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jdcolor.c
	$(COMPILE) jdcolor$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jdcolor.c

jddctmgr$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jddctmgr.c
	$(COMPILE) jddctmgr$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jddctmgr.c

jdhuff$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jdhuff.c
	$(COMPILE) jdhuff$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jdhuff.c

jdinput$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jdinput.c
	$(COMPILE) jdinput$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jdinput.c

jdmainct$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jdmainct.c
	$(COMPILE) jdmainct$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jdmainct.c

jdmarker$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jdmarker.c
	$(COMPILE) jdmarker$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jdmarker.c

jdmaster$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jdmaster.c
	$(COMPILE) jdmaster$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jdmaster.c

jdmerge$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jdmerge.c
	$(COMPILE) jdmerge$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jdmerge.c

jdphuff$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jdphuff.c
	$(COMPILE) jdphuff$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jdphuff.c

jdpostct$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jdpostct.c
	$(COMPILE) jdpostct$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jdpostct.c

jdsample$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jdsample.c
	$(COMPILE) jdsample$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jdsample.c

jdtrans$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jdtrans.c
	$(COMPILE) jdtrans$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jdtrans.c

jerror$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jerror.c
	$(COMPILE) jerror$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jerror.c

jfdctflt$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jfdctflt.c
	$(COMPILE) jfdctflt$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jfdctflt.c

jfdctfst$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jfdctfst.c
	$(COMPILE) jfdctfst$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jfdctfst.c

jfdctint$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jfdctint.c
	$(COMPILE) jfdctint$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jfdctint.c

jidctflt$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jidctflt.c
	$(COMPILE) jidctflt$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jidctflt.c

jidctfst$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jidctfst.c
	$(COMPILE) jidctfst$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jidctfst.c

jidctint$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jidctint.c
	$(COMPILE) jidctint$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jidctint.c

jidctred$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jidctred.c
	$(COMPILE) jidctred$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jidctred.c

jmemdatadst$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jmemdatadst.c
	$(COMPILE) jmemdatadst$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jmemdatadst.c

jmemdatasrc$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jmemdatasrc.c
	$(COMPILE) jmemdatasrc$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jmemdatasrc.c

jmemmgr$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jmemmgr.c
	$(COMPILE) jmemmgr$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jmemmgr.c

jmemnobs$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jmemnobs.c
	$(COMPILE) jmemnobs$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jmemnobs.c

jquant1$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jquant1.c
	$(COMPILE) jquant1$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jquant1.c

jquant2$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jquant2.c
	$(COMPILE) jquant2$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jquant2.c

jutils$o : /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jutils.c
	$(COMPILE) jutils$o /Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/plugins/JPEGReadWriter2Plugin/jutils.c

.force :
