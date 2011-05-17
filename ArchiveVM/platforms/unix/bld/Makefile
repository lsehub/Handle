# Makefile.in for Unix Squeak using VMMaker		-*- makefile -*-
# 
#   Copyright (C) 1996-2005 by Ian Piumarta and other authors/contributors
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
# Last edited: 2006-10-18 10:13:50 by piumarta on emilia.local


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

# make.prg.in -- mf fragment for programs		-*- makefile -*-
# 
# Author: Ian.Piumarta@inria.fr
# 
# Last edited: 2002-12-01 09:28:43 by piumarta on calvin.inria.fr

o		= .o
a		= .a
x		=
COMPILE		= $(CC) $(CFLAGS) $(XCFLAGS) \
		  $(LDFLAGS) $(XLDFLAGS) -export-dynamic -c -o
LINK		= $(LIBTOOL) --mode=link \
		  $(CC) $(CFLAGS) $(XCFLAGS) \
		  $(LDFLAGS) $(XLDFLAGS) -export-dynamic -R$(libdir) -o
RANLIB		= :

la		= .la

SQLIBS		=  vm/vm$a ADPCMCodecPlugin/ADPCMCodecPlugin$a AsynchFilePlugin/AsynchFilePlugin$a B3DAcceleratorPlugin/B3DAcceleratorPlugin$a Squeak3D/Squeak3D$a BMPReadWriterPlugin/BMPReadWriterPlugin$a B2DPlugin/B2DPlugin$a BitBltPlugin/BitBltPlugin$a DSAPrims/DSAPrims$a ZipPlugin/ZipPlugin$a DropPlugin/DropPlugin$a FFTPlugin/FFTPlugin$a FT2Plugin/FT2Plugin$a FilePlugin/FilePlugin$a FloatArrayPlugin/FloatArrayPlugin$a GeniePlugin/GeniePlugin$a HostWindowPlugin/HostWindowPlugin$a JPEGReadWriter2Plugin/JPEGReadWriter2Plugin$a JPEGReaderPlugin/JPEGReaderPlugin$a JoystickTabletPlugin/JoystickTabletPlugin$a Klatt/Klatt$a LargeIntegers/LargeIntegers$a LocalePlugin/LocalePlugin$a Matrix2x3Plugin/Matrix2x3Plugin$a MiscPrimitivePlugin/MiscPrimitivePlugin$a QuicktimePlugin/QuicktimePlugin$a RePlugin/RePlugin$a SecurityPlugin/SecurityPlugin$a SerialPlugin/SerialPlugin$a SocketPlugin/SocketPlugin$a SoundCodecPrims/SoundCodecPrims$a SoundGenerationPlugin/SoundGenerationPlugin$a SoundPlugin/SoundPlugin$a StarSqueakPlugin/StarSqueakPlugin$a SurfacePlugin/SurfacePlugin$a UUIDPlugin/UUIDPlugin$a disabledPlugins$o
PLUGINS_LA	=  vm-display-Quartz${la} vm-display-null${la} vm-sound-MacOSX${la} vm-sound-null${la} vm-sound-pulse${la}

squeak		= squeak

all : $(squeak) plugins squeak.1 $(npsqueak)

# VM

$(squeak) : config.sh $(SQLIBS) version.o
	$(LINK) $(squeak) $(SQLIBS) version.o $(LIBS)  vm/vm.a
	@echo
	@size $(squeak)
	@echo
	@./$(squeak) -version
	@echo

version.o : version.c
	$(COMPILE) version.o version.c

version.c : $(SQLIBS)
	${cfgdir}/verstamp version.c $(CC)

plugins : config.sh $(PLUGINS_LA)

# npsqueak

npsqueak : nps/npsqueak.so

nps :
	mkdir nps
	$(SHELL) -ec 'cd nps; ln -s $(topdir)/platforms/unix/npsqueak/* .'

nps/npsqueak.so : nps
	$(SHELL) -ec 'cd nps; $(MAKE) plgdir=$(plgdir) bindir=$(bindir) imgdir=$(imgdir)'

# OSX app bundle

osxdir=$(topdir)/platforms/unix/vm-display-Quartz
app=Squeak-$(VM_MAJOR).$(VM_MINOR)-$(VM_RELEASE).app
appdir=$(app)/Contents

Squeak.app : squeak plugins Info.plist
	/bin/rm -rf $(app)
	mkdir -p			$(appdir)/MacOS
	cp -p  squeak			$(appdir)/MacOS/.
	cp -p  */.libs/*		$(appdir)/MacOS/.
	rm -f				$(appdir)/MacOS/*.la
	rm -f				$(appdir)/MacOS/*.lai
	cp -p  Info.plist		$(appdir)/.
	cp -p  $(osxdir)/PkgInfo	$(appdir)/.
	cp -pr $(osxdir)/Resources	$(appdir)/.
	-find $(app) -name '*~' | xargs rm -f

bndl_version=${VM_VERSION} (${SQ_VERSION})

Info.plist : $(osxdir)/Info.plist.in $(osxdir)/mkinfo
	$(osxdir)/mkinfo $(osxdir)/Info.plist.in Info.plist.tmp "${bndl_version}"
	mv Info.plist.tmp Info.plist

# OSX plugin bundle

nposxdir=$(topdir)/platforms/unix/vm-display-Quartz
npapp=NPSqueak.bundle
npappdir=$(npapp)/Contents

NPSqueak.bundle : NPSqueak plugins
	/bin/rm -rf $(npapp)
	mkdir -p			$(npappdir)/MacOS
	cp -p  squeak			$(npappdir)/MacOS/.
	cp -p  */.libs/*.so		$(npappdir)/MacOS/.
	cp -p  Info.plist		$(npappdir)/.
	cp -p  $(nposxdir)/PkgInfo	$(npappdir)/.
	cp -pr $(nposxdir)/Resources	$(npappdir)/.
	-find $(npapp) -name '*~' | xargs rm -f

NPOBJS		= vm-display-Quartz/sqUnixSafari.o vm-sound-MacOSX/sqUnixSoundMacOSX.o vm-display-Quartz/sqUnixQuartz.o
NPLIBS		= $(NPOBJS) -framework CoreAudio -framework AudioToolbox

NPSqueak : config.sh $(SQLIBS) version.o $(NPOBJS)
	gcc -bundle -flat_namespace -undefined suppress -o NPSqueak \
	  $(NPLIBS) $(SQLIBS) version.o $(LIBS)  vm/vm.a

# manual page

squeak.1 : $(topdir)/platforms/unix/doc/squeak.1
	$(cfgdir)/mkman $(VM_MAJOR) $(VM_VERSION) \
	  $(bindir) $(imgdir) $(plgdir) $(mandir) $(docdir) \
	  < $(topdir)/platforms/unix/doc/squeak.1 > $@

# install/distrib (these just get in the way -- suck 'em in from elsewhere)


# Makefile.install for Unix Squeak using VMMaker		-*- makefile -*-
# 
# Author: ian.piumarta@inria.fr
# 
# Last edited: 2006-09-18 12:35:20 by piumarta on wireless-58.media.mit.edu

DOCFILES	= COPYING COPYRIGHT LICENSE \
		  README.Contributing README.Keyboard README.Sound

ICONS		= $(topdir)/platforms/unix/vm-display-Quartz/Resources/SqueakVM.icns

install : install-squeak install-plugins install-doc $(install_nps)

uninstall : uninstall-squeak uninstall-plugins uninstall-doc $(uninstall_nps)

# squeak

install-squeak : $(squeak)
	$(MKINSTALLDIRS) $(ROOT)$(plgdir)
	$(INSTALL_PROG) $(squeak) $(ROOT)$(plgdir)
	$(MKINSTALLDIRS) $(ROOT)$(bindir)
	if test -n "$(VM_APP_ICONS)"; then \
	  $(INSTALL_DATA) $(ICONS) $(ROOT)$(VM_APP_ICONS); \
	fi
	( path=`$(cfgdir)/relpath $(bindir) $(plgdir)`; \
	  cd $(ROOT)$(bindir); \
	  rm -f $(squeak); \
	  $(LN_S) $$path/$(squeak) .; )

uninstall-squeak : .force
	if test -n "$(VM_APP_ICONS)"; then \
	  $(UNINSTALL) $(ROOT)$(VM_APP_ICONS); \
	fi
	@$(UNINSTALL) $(ROOT)$(plgdir) $(squeak)
	@$(UNINSTALL) $(ROOT)$(bindir) $(squeak)

# plugins

install-plugins : plugins
	$(MKINSTALLDIRS) $(ROOT)$(plgdir)
	@list='$(PLUGINS_LA)'; for p in $$list; do \
	  if test -f */$$p; then \
	    echo "$(LIBTOOL) --mode=install $(INSTALL_PROG) $$p $(ROOT)$(plgdir)/$$p"; \
	    $(LIBTOOL) --mode=install $(INSTALL_PROG) */$$p $(ROOT)$(plgdir)/$$p; \
	  else :; fi; \
	done
	-rm $(ROOT)$(plgdir)/*.la

uninstall-plugins : .force
	@list='$(PLUGINS_LA)'; for p in $$list; do \
	  filename=$(ROOT)/$(plgdir)/`basename $$p .la`;\
	  if test -f $$filename; then \
	    echo "$(LIBTOOL) --mode=uninstall rm -f $$filename"; \
	    $(LIBTOOL) --mode=uninstall rm -f $$filename; \
	  else
	    echo "$$filename does not exist"; fi; \
	done
	@$(UNINSTALL) $(ROOT)$(plgdir)

# doc

install-doc : squeak.1
	$(MKINSTALLDIRS) $(ROOT)$(docdir)
	@list='$(DOCFILES)'; for f in $$list; do \
	  echo $(INSTALL_DATA) $(topdir)/platforms/unix/doc/$$f $(ROOT)$(docdir); \
	  $(INSTALL_DATA) $(topdir)/platforms/unix/doc/$$f $(ROOT)$(docdir); \
	done
	-gzip -f9 $(ROOT)$(docdir)/*
	$(MKINSTALLDIRS) $(ROOT)$(mandir)/man1
	$(INSTALL_DATA) squeak.1 $(ROOT)$(mandir)/man1
	rm -f $(ROOT)$(mandir)/man1/inisqueak.1 $(ROOT)$(mandir)/man1/inisqueak.1.gz
	if test -f $(ROOT)$(mandir)/man1/squeak.1; then $(LN) $(ROOT)$(mandir)/man1/squeak.1 $(ROOT)$(mandir)/man1/inisqueak.1; fi
	if test -f $(ROOT)$(mandir)/man1/squeak.1.gz; then $(LN) $(ROOT)$(mandir)/man1/squeak.1.gz $(ROOT)$(mandir)/man1/inisqueak.1.gz; fi

uninstall-doc :
	@list='$(DOCFILES)'; for f in $$list; do \
	  rm -fv $(ROOT)$(docdir)/$$f.gz; \
	done
	@$(UNINSTALL) $(ROOT)$(docdir) $(DOCFILES)
	@$(UNINSTALL) $(ROOT)$(mandir)/man1 squeak.1 inisqueak.1

# image

install-image : inisqueak $(topdir)/Squeak$(SQ_VERSION).image.gz $(topdir)/Squeak$(SQ_VERSION).changes.gz
	$(MKINSTALLDIRS) $(ROOT)$(imgdir)
	$(INSTALL_PROG) inisqueak $(ROOT)$(imgdir)
	$(INSTALL_DATA) $(topdir)/Squeak$(SQ_VERSION).image.gz $(ROOT)$(imgdir)
	$(INSTALL_DATA) $(topdir)/Squeak$(SQ_VERSION).changes.gz $(ROOT)$(imgdir)
	$(LN_S) Squeak$(SQ_VERSION).image.gz $(ROOT)$(imgdir)/squeak.image.gz
	$(LN_S) Squeak$(SQ_VERSION).changes.gz $(ROOT)$(imgdir)/squeak.changes.gz
	$(MKINSTALLDIRS) $(ROOT)$(bindir)
	( path=`$(cfgdir)/relpath $(bindir) $(imgdir)`; \
	  cd $(ROOT)$(bindir); \
	  rm -f inisqueak; \
	  $(LN_S) $$path/inisqueak .; )

uninstall-image :
	@$(UNINSTALL) $(ROOT)$(plgdir) Squeak$(SQ_VERSION).image.gz
	@$(UNINSTALL) $(ROOT)$(plgdir) Squeak$(SQ_VERSION).changes.gz
	@$(UNINSTALL) $(ROOT)$(plgdir) inisqueak

# sources

install-sources :
	$(MKINSTALLDIRS) $(ROOT)$(imgdir)
	$(INSTALL_DATA) $(topdir)/SqueakV$(SQ_MAJOR).sources $(ROOT)$(imgdir)

uninstall-sources :
	@$(UNINSTALL) $(ROOT)$(imgdir) SqueakV$(SQ_MAJOR).sources

# npsqueak

install-npsqueak : npsqueak .force
	$(SHELL) -ec 'cd nps; $(MAKE) install ROOT=$(ROOT) VM_VERSION=$(VM_VERSION) plgdir=$(plgdir) bindir=$(bindir) imgdir=$(imgdir)'

uninstall-npsqueak : npsqueak .force
	$(SHELL) -ec 'cd nps; $(MAKE) uninstall ROOT=$(ROOT) VM_VERSION=$(VM_VERSION) plgdir=$(plgdir) bindir=$(bindir) imgdir=$(imgdir)'




# VMM configuration changes

config.sh : $(srcdir)/plugins.int $(srcdir)/plugins.ext $(srcdir)/vm/sqNamedPrims.h
	./config.status
	@echo
	@echo "configuration changed: please run make again"
	@echo
	@exit 1




vm/vm$a : .force
	@$(SHELL) -ec 'cd vm; $(MAKE) vm$a'

ADPCMCodecPlugin/ADPCMCodecPlugin$a : .force
	@$(SHELL) -ec 'cd ADPCMCodecPlugin; $(MAKE) ADPCMCodecPlugin$a'

AsynchFilePlugin/AsynchFilePlugin$a : .force
	@$(SHELL) -ec 'cd AsynchFilePlugin; $(MAKE) AsynchFilePlugin$a'

B3DAcceleratorPlugin/B3DAcceleratorPlugin$a : .force
	@$(SHELL) -ec 'cd B3DAcceleratorPlugin; $(MAKE) B3DAcceleratorPlugin$a'

Squeak3D/Squeak3D$a : .force
	@$(SHELL) -ec 'cd Squeak3D; $(MAKE) Squeak3D$a'

BMPReadWriterPlugin/BMPReadWriterPlugin$a : .force
	@$(SHELL) -ec 'cd BMPReadWriterPlugin; $(MAKE) BMPReadWriterPlugin$a'

B2DPlugin/B2DPlugin$a : .force
	@$(SHELL) -ec 'cd B2DPlugin; $(MAKE) B2DPlugin$a'

BitBltPlugin/BitBltPlugin$a : .force
	@$(SHELL) -ec 'cd BitBltPlugin; $(MAKE) BitBltPlugin$a'

DSAPrims/DSAPrims$a : .force
	@$(SHELL) -ec 'cd DSAPrims; $(MAKE) DSAPrims$a'

ZipPlugin/ZipPlugin$a : .force
	@$(SHELL) -ec 'cd ZipPlugin; $(MAKE) ZipPlugin$a'

DropPlugin/DropPlugin$a : .force
	@$(SHELL) -ec 'cd DropPlugin; $(MAKE) DropPlugin$a'

FFTPlugin/FFTPlugin$a : .force
	@$(SHELL) -ec 'cd FFTPlugin; $(MAKE) FFTPlugin$a'

FT2Plugin/FT2Plugin$a : .force
	@$(SHELL) -ec 'cd FT2Plugin; $(MAKE) FT2Plugin$a'

FilePlugin/FilePlugin$a : .force
	@$(SHELL) -ec 'cd FilePlugin; $(MAKE) FilePlugin$a'

FloatArrayPlugin/FloatArrayPlugin$a : .force
	@$(SHELL) -ec 'cd FloatArrayPlugin; $(MAKE) FloatArrayPlugin$a'

GeniePlugin/GeniePlugin$a : .force
	@$(SHELL) -ec 'cd GeniePlugin; $(MAKE) GeniePlugin$a'

HostWindowPlugin/HostWindowPlugin$a : .force
	@$(SHELL) -ec 'cd HostWindowPlugin; $(MAKE) HostWindowPlugin$a'

JPEGReadWriter2Plugin/JPEGReadWriter2Plugin$a : .force
	@$(SHELL) -ec 'cd JPEGReadWriter2Plugin; $(MAKE) JPEGReadWriter2Plugin$a'

JPEGReaderPlugin/JPEGReaderPlugin$a : .force
	@$(SHELL) -ec 'cd JPEGReaderPlugin; $(MAKE) JPEGReaderPlugin$a'

JoystickTabletPlugin/JoystickTabletPlugin$a : .force
	@$(SHELL) -ec 'cd JoystickTabletPlugin; $(MAKE) JoystickTabletPlugin$a'

Klatt/Klatt$a : .force
	@$(SHELL) -ec 'cd Klatt; $(MAKE) Klatt$a'

LargeIntegers/LargeIntegers$a : .force
	@$(SHELL) -ec 'cd LargeIntegers; $(MAKE) LargeIntegers$a'

LocalePlugin/LocalePlugin$a : .force
	@$(SHELL) -ec 'cd LocalePlugin; $(MAKE) LocalePlugin$a'

Matrix2x3Plugin/Matrix2x3Plugin$a : .force
	@$(SHELL) -ec 'cd Matrix2x3Plugin; $(MAKE) Matrix2x3Plugin$a'

MiscPrimitivePlugin/MiscPrimitivePlugin$a : .force
	@$(SHELL) -ec 'cd MiscPrimitivePlugin; $(MAKE) MiscPrimitivePlugin$a'

QuicktimePlugin/QuicktimePlugin$a : .force
	@$(SHELL) -ec 'cd QuicktimePlugin; $(MAKE) QuicktimePlugin$a'

RePlugin/RePlugin$a : .force
	@$(SHELL) -ec 'cd RePlugin; $(MAKE) RePlugin$a'

SecurityPlugin/SecurityPlugin$a : .force
	@$(SHELL) -ec 'cd SecurityPlugin; $(MAKE) SecurityPlugin$a'

SerialPlugin/SerialPlugin$a : .force
	@$(SHELL) -ec 'cd SerialPlugin; $(MAKE) SerialPlugin$a'

SocketPlugin/SocketPlugin$a : .force
	@$(SHELL) -ec 'cd SocketPlugin; $(MAKE) SocketPlugin$a'

SoundCodecPrims/SoundCodecPrims$a : .force
	@$(SHELL) -ec 'cd SoundCodecPrims; $(MAKE) SoundCodecPrims$a'

SoundGenerationPlugin/SoundGenerationPlugin$a : .force
	@$(SHELL) -ec 'cd SoundGenerationPlugin; $(MAKE) SoundGenerationPlugin$a'

SoundPlugin/SoundPlugin$a : .force
	@$(SHELL) -ec 'cd SoundPlugin; $(MAKE) SoundPlugin$a'

StarSqueakPlugin/StarSqueakPlugin$a : .force
	@$(SHELL) -ec 'cd StarSqueakPlugin; $(MAKE) StarSqueakPlugin$a'

SurfacePlugin/SurfacePlugin$a : .force
	@$(SHELL) -ec 'cd SurfacePlugin; $(MAKE) SurfacePlugin$a'

UUIDPlugin/UUIDPlugin$a : .force
	@$(SHELL) -ec 'cd UUIDPlugin; $(MAKE) UUIDPlugin$a'

vm-display-Quartz${la} :
	@$(SHELL) -ec 'cd vm-display-Quartz; $(MAKE) vm-display-Quartz${la}'

vm-display-null${la} :
	@$(SHELL) -ec 'cd vm-display-null; $(MAKE) vm-display-null${la}'

vm-sound-MacOSX${la} :
	@$(SHELL) -ec 'cd vm-sound-MacOSX; $(MAKE) vm-sound-MacOSX${la}'

vm-sound-null${la} :
	@$(SHELL) -ec 'cd vm-sound-null; $(MAKE) vm-sound-null${la}'

vm-sound-pulse${la} :
	@$(SHELL) -ec 'cd vm-sound-pulse; $(MAKE) vm-sound-pulse${la}'

disabledPlugins$o : disabledPlugins.c
	$(COMPILE) disabledPlugins$o disabledPlugins.c

.force :
