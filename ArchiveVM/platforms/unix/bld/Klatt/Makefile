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
blddir=		/Users/arnaudj/Desktop/GIT/Handle/platforms/unix/bld

top_builddir=	/Users/arnaudj/Desktop/GIT/Handle/platforms/unix/bld

prefix=		/usr/local
exec_prefix=	${prefix}

bindir=		${exec_prefix}/bin
libdir=		${exec_prefix}/lib
datarootdir=	@datarootdir@
datadir=	${prefix}/share
mandir=		${prefix}/man
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
INCLUDES=	-I/Users/arnaudj/Desktop/GIT/Handle/platforms/unix/bld -I/Users/arnaudj/Desktop/GIT/Handle/platforms/unix/vm -I/Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/vm -I/Users/arnaudj/Desktop/GIT/Handle/src/vm
CPPFLAGS=	
CFLAGS=		 -g -O2 -fomit-frame-pointer -DLSB_FIRST=1
WFLAGS=		-Wall -Wno-unknown-pragmas
LDFLAGS=	
SOFLAGS=	@SOFLAGS@
LIBM_CFLAGS=	-O -fomit-frame-pointer

LIBS=		-lm  -framework CoreFoundation -framework CoreServices

X_CFLAGS=	 -g -O2 -fomit-frame-pointer -DLSB_FIRST=1
X_INCLUDES=	-I/Users/arnaudj/Desktop/GIT/Handle/platforms/unix/bld -I/Users/arnaudj/Desktop/GIT/Handle/platforms/unix/vm -I/Users/arnaudj/Desktop/GIT/Handle/platforms/Cross/vm -I/Users/arnaudj/Desktop/GIT/Handle/src/vm -INONE
X_LIBS=		   -lm 

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

XINCLUDES	= 
OBJS		=  Klatt$o
TARGET		= Klatt$a
PLIBS		= 



$(TARGET) : $(OBJS) Makefile
	$(LINK) $(TARGET) $(OBJS) $(PLIBS)
	$(RANLIB) $(TARGET)




Klatt$o : /Users/arnaudj/Desktop/GIT/Handle/src/vm/intplugins/Klatt/Klatt.c
	$(COMPILE) Klatt$o /Users/arnaudj/Desktop/GIT/Handle/src/vm/intplugins/Klatt/Klatt.c

.force :
