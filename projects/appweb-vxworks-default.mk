#
#   appweb-vxworks-default.mk -- Makefile to build Embedthis Appweb for vxworks
#

PRODUCT            := appweb
VERSION            := 4.5.1
PROFILE            := default
ARCH               := $(shell echo $(WIND_HOST_TYPE) | sed 's/-.*//')
CPU                := $(subst X86,PENTIUM,$(shell echo $(ARCH) | tr a-z A-Z))
OS                 := vxworks
CC                 := cc$(subst x86,pentium,$(ARCH))
LD                 := link
CONFIG             := $(OS)-$(ARCH)-$(PROFILE)
LBIN               := $(CONFIG)/bin

BIT_PACK_CGI       := 1
BIT_PACK_EJSCRIPT  := 0
BIT_PACK_ESP       := 1
BIT_PACK_EST       := 0
BIT_PACK_MATRIXSSL := 0
BIT_PACK_MDB       := 1
BIT_PACK_NANOSSL   := 0
BIT_PACK_OPENSSL   := 0
BIT_PACK_PCRE      := 1
BIT_PACK_PHP       := 0
BIT_PACK_SDB       := 0
BIT_PACK_SQLITE    := 0
BIT_PACK_SSL       := 0
BIT_PACK_ZLIB      := 1

ifeq ($(BIT_PACK_EST),1)
    BIT_PACK_SSL := 1
endif
ifeq ($(BIT_PACK_LIB),1)
    BIT_PACK_COMPILER := 1
endif
ifeq ($(BIT_PACK_MATRIXSSL),1)
    BIT_PACK_SSL := 1
endif
ifeq ($(BIT_PACK_MDB),1)
    BIT_PACK_ESP := 1
endif
ifeq ($(BIT_PACK_NANOSSL),1)
    BIT_PACK_SSL := 1
endif
ifeq ($(BIT_PACK_OPENSSL),1)
    BIT_PACK_SSL := 1
endif
ifeq ($(BIT_PACK_SDB),1)
    BIT_PACK_ESP := 1
    BIT_PACK_SQLITE := 1
endif

BIT_PACK_CGI_PATH         := cgi
BIT_PACK_COMPILER_PATH    := cc$(subst x86,pentium,$(ARCH))
BIT_PACK_DIR_PATH         := dir
BIT_PACK_DOXYGEN_PATH     := doxygen
BIT_PACK_DSI_PATH         := dsi
BIT_PACK_EJSCRIPT_PATH    := ejscript
BIT_PACK_ESP_PATH         := esp
BIT_PACK_EST_PATH         := est
BIT_PACK_GZIP_PATH        := gzip
BIT_PACK_HTMLMIN_PATH     := htmlmin
BIT_PACK_LIB_PATH         := ar
BIT_PACK_LINK_PATH        := link
BIT_PACK_MAN_PATH         := man
BIT_PACK_MAN2HTML_PATH    := man2html
BIT_PACK_MATRIXSSL_PATH   := /usr/src/matrixssl
BIT_PACK_MDB_PATH         := mdb
BIT_PACK_NANOSSL_PATH     := /usr/src/nanossl
BIT_PACK_NGMIN_PATH       := ngmin
BIT_PACK_OPENSSL_PATH     := /usr/src/openssl
BIT_PACK_PAK_PATH         := pak
BIT_PACK_PCRE_PATH        := pcre
BIT_PACK_PHP_PATH         := /usr/src/php
BIT_PACK_PMAKER_PATH      := pmaker
BIT_PACK_RECESS_PATH      := recess
BIT_PACK_SDB_PATH         := sdb
BIT_PACK_SQLITE_PATH      := sqlite
BIT_PACK_SSL_PATH         := ssl
BIT_PACK_UGLIFYJS_PATH    := uglifyjs
BIT_PACK_UTEST_PATH       := utest
BIT_PACK_VXWORKS_PATH     := $(WIND_BASE)
BIT_PACK_ZIP_PATH         := zip
BIT_PACK_ZLIB_PATH        := zlib

export WIND_HOME          := $(WIND_BASE)/..
export PATH               := $(WIND_GNU_PATH)/$(WIND_HOST_TYPE)/bin:$(PATH)

CFLAGS             += -fno-builtin -fno-defer-pop -fvolatile -w
DFLAGS             += -DVXWORKS -DRW_MULTI_THREAD -D_GNU_TOOL -DCPU=PENTIUM $(patsubst %,-D%,$(filter BIT_%,$(MAKEFLAGS))) -DBIT_PACK_CGI=$(BIT_PACK_CGI) -DBIT_PACK_EJSCRIPT=$(BIT_PACK_EJSCRIPT) -DBIT_PACK_ESP=$(BIT_PACK_ESP) -DBIT_PACK_EST=$(BIT_PACK_EST) -DBIT_PACK_MATRIXSSL=$(BIT_PACK_MATRIXSSL) -DBIT_PACK_MDB=$(BIT_PACK_MDB) -DBIT_PACK_NANOSSL=$(BIT_PACK_NANOSSL) -DBIT_PACK_OPENSSL=$(BIT_PACK_OPENSSL) -DBIT_PACK_PCRE=$(BIT_PACK_PCRE) -DBIT_PACK_PHP=$(BIT_PACK_PHP) -DBIT_PACK_SDB=$(BIT_PACK_SDB) -DBIT_PACK_SQLITE=$(BIT_PACK_SQLITE) -DBIT_PACK_SSL=$(BIT_PACK_SSL) -DBIT_PACK_ZLIB=$(BIT_PACK_ZLIB) 
IFLAGS             += "-I$(CONFIG)/inc -I$(WIND_BASE)/target/h -I$(WIND_BASE)/target/h/wrn/coreip"
LDFLAGS            += '-Wl,-r'
LIBPATHS           += -L$(CONFIG)/bin
LIBS               += -lgcc

DEBUG              := debug
CFLAGS-debug       := -g
DFLAGS-debug       := -DBIT_DEBUG
LDFLAGS-debug      := -g
DFLAGS-release     := 
CFLAGS-release     := -O2
LDFLAGS-release    := 
CFLAGS             += $(CFLAGS-$(DEBUG))
DFLAGS             += $(DFLAGS-$(DEBUG))
LDFLAGS            += $(LDFLAGS-$(DEBUG))

BIT_ROOT_PREFIX    := deploy
BIT_BASE_PREFIX    := $(BIT_ROOT_PREFIX)
BIT_DATA_PREFIX    := $(BIT_VAPP_PREFIX)
BIT_STATE_PREFIX   := $(BIT_VAPP_PREFIX)
BIT_BIN_PREFIX     := $(BIT_VAPP_PREFIX)
BIT_INC_PREFIX     := $(BIT_VAPP_PREFIX)/inc
BIT_LIB_PREFIX     := $(BIT_VAPP_PREFIX)
BIT_MAN_PREFIX     := $(BIT_VAPP_PREFIX)
BIT_SBIN_PREFIX    := $(BIT_VAPP_PREFIX)
BIT_ETC_PREFIX     := $(BIT_VAPP_PREFIX)
BIT_WEB_PREFIX     := $(BIT_VAPP_PREFIX)/web
BIT_LOG_PREFIX     := $(BIT_VAPP_PREFIX)
BIT_SPOOL_PREFIX   := $(BIT_VAPP_PREFIX)
BIT_CACHE_PREFIX   := $(BIT_VAPP_PREFIX)
BIT_APP_PREFIX     := $(BIT_BASE_PREFIX)
BIT_VAPP_PREFIX    := $(BIT_APP_PREFIX)
BIT_SRC_PREFIX     := $(BIT_ROOT_PREFIX)/usr/src/$(PRODUCT)-$(VERSION)


TARGETS            += $(CONFIG)/bin/libmpr.out
TARGETS            += $(CONFIG)/bin/libmprssl.out
TARGETS            += $(CONFIG)/bin/appman.out
TARGETS            += $(CONFIG)/bin/makerom.out
TARGETS            += $(CONFIG)/bin/ca.crt
ifeq ($(BIT_PACK_PCRE),1)
TARGETS            += $(CONFIG)/bin/libpcre.out
endif
ifeq ($(BIT_PACK_ZLIB),1)
TARGETS            += $(CONFIG)/bin/libzlib.out
endif
TARGETS            += $(CONFIG)/bin/libhttp.out
TARGETS            += $(CONFIG)/bin/http.out
ifeq ($(BIT_PACK_SQLITE),1)
TARGETS            += $(CONFIG)/bin/libsql.out
endif
ifeq ($(BIT_PACK_SQLITE),1)
TARGETS            += $(CONFIG)/bin/sqlite.out
endif
TARGETS            += $(CONFIG)/bin/libappweb.out
ifeq ($(BIT_PACK_ESP),1)
TARGETS            += $(CONFIG)/bin/libmod_esp.out
endif
ifeq ($(BIT_PACK_ESP),1)
TARGETS            += $(CONFIG)/bin/esp.out
endif
ifeq ($(BIT_PACK_ESP),1)
TARGETS            += $(CONFIG)/bin/esp.conf
endif
ifeq ($(BIT_PACK_ESP),1)
TARGETS            += src/server/esp.conf
endif
ifeq ($(BIT_PACK_ESP),1)
TARGETS            += $(CONFIG)/paks
endif
ifeq ($(BIT_PACK_EJSCRIPT),1)
TARGETS            += $(CONFIG)/bin/libejs.out
endif
ifeq ($(BIT_PACK_EJSCRIPT),1)
TARGETS            += $(CONFIG)/bin/ejs.out
endif
ifeq ($(BIT_PACK_EJSCRIPT),1)
TARGETS            += $(CONFIG)/bin/ejsc.out
endif
ifeq ($(BIT_PACK_EJSCRIPT),1)
TARGETS            += $(CONFIG)/bin/ejs.mod
endif
ifeq ($(BIT_PACK_CGI),1)
TARGETS            += $(CONFIG)/bin/libmod_cgi.out
endif
ifeq ($(BIT_PACK_EJSCRIPT),1)
TARGETS            += $(CONFIG)/bin/libmod_ejs.out
endif
ifeq ($(BIT_PACK_PHP),1)
TARGETS            += $(CONFIG)/bin/libmod_php.out
endif
ifeq ($(BIT_PACK_SSL),1)
TARGETS            += $(CONFIG)/bin/libmod_ssl.out
endif
TARGETS            += $(CONFIG)/bin/authpass.out
ifeq ($(BIT_PACK_CGI),1)
TARGETS            += $(CONFIG)/bin/cgiProgram.out
endif
TARGETS            += src/server/slink.c
TARGETS            += $(CONFIG)/bin/libslink.out
TARGETS            += $(CONFIG)/bin/appweb.out
TARGETS            += src/server/cache
TARGETS            += $(CONFIG)/bin/testAppweb.out
ifeq ($(BIT_PACK_CGI),1)
TARGETS            += test/cgi-bin/testScript
endif
ifeq ($(BIT_PACK_CGI),1)
TARGETS            += test/web/caching/cache.cgi
endif
ifeq ($(BIT_PACK_CGI),1)
TARGETS            += test/web/auth/basic/basic.cgi
endif
ifeq ($(BIT_PACK_CGI),1)
TARGETS            += test/cgi-bin/cgiProgram.out
endif

unexport CDPATH

ifndef SHOW
.SILENT:
endif

all build compile: prep $(TARGETS)

.PHONY: prep

prep:
	@echo "      [Info] Use "make SHOW=1" to trace executed commands."
	@if [ "$(CONFIG)" = "" ] ; then echo WARNING: CONFIG not set ; exit 255 ; fi
	@if [ "$(BIT_APP_PREFIX)" = "" ] ; then echo WARNING: BIT_APP_PREFIX not set ; exit 255 ; fi
	@if [ "$(WIND_BASE)" = "" ] ; then echo WARNING: WIND_BASE not set. Run wrenv.sh. ; exit 255 ; fi
	@if [ "$(WIND_HOST_TYPE)" = "" ] ; then echo WARNING: WIND_HOST_TYPE not set. Run wrenv.sh. ; exit 255 ; fi
	@if [ "$(WIND_GNU_PATH)" = "" ] ; then echo WARNING: WIND_GNU_PATH not set. Run wrenv.sh. ; exit 255 ; fi
	@[ ! -x $(CONFIG)/bin ] && mkdir -p $(CONFIG)/bin; true
	@[ ! -x $(CONFIG)/inc ] && mkdir -p $(CONFIG)/inc; true
	@[ ! -x $(CONFIG)/obj ] && mkdir -p $(CONFIG)/obj; true
	@[ ! -f $(CONFIG)/inc/bitos.h ] && cp src/bitos.h $(CONFIG)/inc/bitos.h ; true
	@if ! diff $(CONFIG)/inc/bitos.h src/bitos.h >/dev/null ; then\
		cp src/bitos.h $(CONFIG)/inc/bitos.h  ; \
	fi; true
	@[ ! -f $(CONFIG)/inc/bit.h ] && cp projects/appweb-vxworks-default-bit.h $(CONFIG)/inc/bit.h ; true
	@if ! diff $(CONFIG)/inc/bit.h projects/appweb-vxworks-default-bit.h >/dev/null ; then\
		cp projects/appweb-vxworks-default-bit.h $(CONFIG)/inc/bit.h  ; \
	fi; true
	@if [ -f "$(CONFIG)/.makeflags" ] ; then \
		if [ "$(MAKEFLAGS)" != " ` cat $(CONFIG)/.makeflags`" ] ; then \
			echo "   [Warning] Make flags have changed since the last build: "`cat $(CONFIG)/.makeflags`"" ; \
		fi ; \
	fi
	@echo $(MAKEFLAGS) >$(CONFIG)/.makeflags

clean:
	rm -f "$(CONFIG)/bin/libmpr.out"
	rm -f "$(CONFIG)/bin/libmprssl.out"
	rm -f "$(CONFIG)/bin/appman.out"
	rm -f "$(CONFIG)/bin/makerom.out"
	rm -f "$(CONFIG)/bin/libest.out"
	rm -f "$(CONFIG)/bin/ca.crt"
	rm -f "$(CONFIG)/bin/libpcre.out"
	rm -f "$(CONFIG)/bin/libzlib.out"
	rm -f "$(CONFIG)/bin/libhttp.out"
	rm -f "$(CONFIG)/bin/http.out"
	rm -f "$(CONFIG)/bin/libsql.out"
	rm -f "$(CONFIG)/bin/sqlite.out"
	rm -f "$(CONFIG)/bin/libappweb.out"
	rm -f "$(CONFIG)/bin/libmod_esp.out"
	rm -f "$(CONFIG)/bin/esp.out"
	rm -f "$(CONFIG)/bin/esp.conf"
	rm -f "src/server/esp.conf"
	rm -f "$(CONFIG)/bin/libejs.out"
	rm -f "$(CONFIG)/bin/ejs.out"
	rm -f "$(CONFIG)/bin/ejsc.out"
	rm -f "$(CONFIG)/bin/libmod_cgi.out"
	rm -f "$(CONFIG)/bin/libmod_ejs.out"
	rm -f "$(CONFIG)/bin/libmod_php.out"
	rm -f "$(CONFIG)/bin/libmod_ssl.out"
	rm -f "$(CONFIG)/bin/authpass.out"
	rm -f "$(CONFIG)/bin/cgiProgram.out"
	rm -f "$(CONFIG)/bin/libslink.out"
	rm -f "$(CONFIG)/bin/appweb.out"
	rm -f "$(CONFIG)/bin/testAppweb.out"
	rm -f "$(CONFIG)/obj/mprLib.o"
	rm -f "$(CONFIG)/obj/mprSsl.o"
	rm -f "$(CONFIG)/obj/manager.o"
	rm -f "$(CONFIG)/obj/makerom.o"
	rm -f "$(CONFIG)/obj/estLib.o"
	rm -f "$(CONFIG)/obj/pcre.o"
	rm -f "$(CONFIG)/obj/zlib.o"
	rm -f "$(CONFIG)/obj/httpLib.o"
	rm -f "$(CONFIG)/obj/http.o"
	rm -f "$(CONFIG)/obj/sqlite3.o"
	rm -f "$(CONFIG)/obj/sqlite.o"
	rm -f "$(CONFIG)/obj/config.o"
	rm -f "$(CONFIG)/obj/convenience.o"
	rm -f "$(CONFIG)/obj/dirHandler.o"
	rm -f "$(CONFIG)/obj/fileHandler.o"
	rm -f "$(CONFIG)/obj/log.o"
	rm -f "$(CONFIG)/obj/server.o"
	rm -f "$(CONFIG)/obj/edi.o"
	rm -f "$(CONFIG)/obj/espAbbrev.o"
	rm -f "$(CONFIG)/obj/espDeprecated.o"
	rm -f "$(CONFIG)/obj/espFramework.o"
	rm -f "$(CONFIG)/obj/espHandler.o"
	rm -f "$(CONFIG)/obj/espHtml.o"
	rm -f "$(CONFIG)/obj/espTemplate.o"
	rm -f "$(CONFIG)/obj/mdb.o"
	rm -f "$(CONFIG)/obj/sdb.o"
	rm -f "$(CONFIG)/obj/esp.o"
	rm -f "$(CONFIG)/obj/ejsLib.o"
	rm -f "$(CONFIG)/obj/ejs.o"
	rm -f "$(CONFIG)/obj/ejsc.o"
	rm -f "$(CONFIG)/obj/cgiHandler.o"
	rm -f "$(CONFIG)/obj/ejsHandler.o"
	rm -f "$(CONFIG)/obj/phpHandler.o"
	rm -f "$(CONFIG)/obj/sslModule.o"
	rm -f "$(CONFIG)/obj/authpass.o"
	rm -f "$(CONFIG)/obj/cgiProgram.o"
	rm -f "$(CONFIG)/obj/slink.o"
	rm -f "$(CONFIG)/obj/appweb.o"
	rm -f "$(CONFIG)/obj/testAppweb.o"
	rm -f "$(CONFIG)/obj/testHttp.o"

clobber: clean
	rm -fr ./$(CONFIG)



#
#   version
#
version: $(DEPS_1)
	echo 4.5.1

#
#   mpr.h
#
$(CONFIG)/inc/mpr.h: $(DEPS_2)
	@echo '      [Copy] $(CONFIG)/inc/mpr.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/paks/mpr/mpr.h $(CONFIG)/inc/mpr.h

#
#   bit.h
#
$(CONFIG)/inc/bit.h: $(DEPS_3)
	@echo '      [Copy] $(CONFIG)/inc/bit.h'

#
#   bitos.h
#
DEPS_4 += $(CONFIG)/inc/bit.h

$(CONFIG)/inc/bitos.h: $(DEPS_4)
	@echo '      [Copy] $(CONFIG)/inc/bitos.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/bitos.h $(CONFIG)/inc/bitos.h

#
#   mprLib.o
#
DEPS_5 += $(CONFIG)/inc/bit.h
DEPS_5 += $(CONFIG)/inc/mpr.h
DEPS_5 += $(CONFIG)/inc/bitos.h

$(CONFIG)/obj/mprLib.o: \
    src/paks/mpr/mprLib.c $(DEPS_5)
	@echo '   [Compile] $(CONFIG)/obj/mprLib.o'
	$(CC) -c -o $(CONFIG)/obj/mprLib.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/mpr/mprLib.c

#
#   libmpr
#
DEPS_6 += $(CONFIG)/inc/mpr.h
DEPS_6 += $(CONFIG)/inc/bit.h
DEPS_6 += $(CONFIG)/inc/bitos.h
DEPS_6 += $(CONFIG)/obj/mprLib.o

$(CONFIG)/bin/libmpr.out: $(DEPS_6)
	@echo '      [Link] $(CONFIG)/bin/libmpr.out'
	$(CC) -r -o $(CONFIG)/bin/libmpr.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/mprLib.o" $(LIBS) 

#
#   est.h
#
$(CONFIG)/inc/est.h: $(DEPS_7)
	@echo '      [Copy] $(CONFIG)/inc/est.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/paks/est/est.h $(CONFIG)/inc/est.h

#
#   estLib.o
#
DEPS_8 += $(CONFIG)/inc/bit.h
DEPS_8 += $(CONFIG)/inc/est.h
DEPS_8 += $(CONFIG)/inc/bitos.h

$(CONFIG)/obj/estLib.o: \
    src/paks/est/estLib.c $(DEPS_8)
	@echo '   [Compile] $(CONFIG)/obj/estLib.o'
	$(CC) -c -o $(CONFIG)/obj/estLib.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/est/estLib.c

ifeq ($(BIT_PACK_EST),1)
#
#   libest
#
DEPS_9 += $(CONFIG)/inc/est.h
DEPS_9 += $(CONFIG)/inc/bit.h
DEPS_9 += $(CONFIG)/inc/bitos.h
DEPS_9 += $(CONFIG)/obj/estLib.o

$(CONFIG)/bin/libest.out: $(DEPS_9)
	@echo '      [Link] $(CONFIG)/bin/libest.out'
	$(CC) -r -o $(CONFIG)/bin/libest.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/estLib.o" $(LIBS) 
endif

#
#   mprSsl.o
#
DEPS_10 += $(CONFIG)/inc/bit.h
DEPS_10 += $(CONFIG)/inc/mpr.h
DEPS_10 += $(CONFIG)/inc/est.h

$(CONFIG)/obj/mprSsl.o: \
    src/paks/mpr/mprSsl.c $(DEPS_10)
	@echo '   [Compile] $(CONFIG)/obj/mprSsl.o'
	$(CC) -c -o $(CONFIG)/obj/mprSsl.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" "-I$(BIT_PACK_MATRIXSSL_PATH)" "-I$(BIT_PACK_MATRIXSSL_PATH)/matrixssl" "-I$(BIT_PACK_NANOSSL_PATH)/src" "-I$(BIT_PACK_OPENSSL_PATH)/include" src/paks/mpr/mprSsl.c

#
#   libmprssl
#
DEPS_11 += $(CONFIG)/inc/mpr.h
DEPS_11 += $(CONFIG)/inc/bit.h
DEPS_11 += $(CONFIG)/inc/bitos.h
DEPS_11 += $(CONFIG)/obj/mprLib.o
DEPS_11 += $(CONFIG)/bin/libmpr.out
DEPS_11 += $(CONFIG)/inc/est.h
DEPS_11 += $(CONFIG)/obj/estLib.o
ifeq ($(BIT_PACK_EST),1)
    DEPS_11 += $(CONFIG)/bin/libest.out
endif
DEPS_11 += $(CONFIG)/obj/mprSsl.o

ifeq ($(BIT_PACK_MATRIXSSL),1)
    LIBS_11 += -lmatrixssl
    LIBPATHS_11 += -L$(BIT_PACK_MATRIXSSL_PATH)
endif
ifeq ($(BIT_PACK_NANOSSL),1)
    LIBS_11 += -lssls
    LIBPATHS_11 += -L$(BIT_PACK_NANOSSL_PATH)/bin
endif
ifeq ($(BIT_PACK_OPENSSL),1)
    LIBS_11 += -lssl
    LIBPATHS_11 += -L$(BIT_PACK_OPENSSL_PATH)
endif
ifeq ($(BIT_PACK_OPENSSL),1)
    LIBS_11 += -lcrypto
    LIBPATHS_11 += -L$(BIT_PACK_OPENSSL_PATH)
endif

$(CONFIG)/bin/libmprssl.out: $(DEPS_11)
	@echo '      [Link] $(CONFIG)/bin/libmprssl.out'
	$(CC) -r -o $(CONFIG)/bin/libmprssl.out $(LDFLAGS) $(LIBPATHS)    "$(CONFIG)/obj/mprSsl.o" $(LIBPATHS_11) $(LIBS_11) $(LIBS_11) $(LIBS) 

#
#   manager.o
#
DEPS_12 += $(CONFIG)/inc/bit.h
DEPS_12 += $(CONFIG)/inc/mpr.h

$(CONFIG)/obj/manager.o: \
    src/paks/mpr/manager.c $(DEPS_12)
	@echo '   [Compile] $(CONFIG)/obj/manager.o'
	$(CC) -c -o $(CONFIG)/obj/manager.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/mpr/manager.c

#
#   manager
#
DEPS_13 += $(CONFIG)/inc/mpr.h
DEPS_13 += $(CONFIG)/inc/bit.h
DEPS_13 += $(CONFIG)/inc/bitos.h
DEPS_13 += $(CONFIG)/obj/mprLib.o
DEPS_13 += $(CONFIG)/bin/libmpr.out
DEPS_13 += $(CONFIG)/obj/manager.o

$(CONFIG)/bin/appman.out: $(DEPS_13)
	@echo '      [Link] $(CONFIG)/bin/appman.out'
	$(CC) -o $(CONFIG)/bin/appman.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/manager.o" $(LIBS) -Wl,-r 

#
#   makerom.o
#
DEPS_14 += $(CONFIG)/inc/bit.h
DEPS_14 += $(CONFIG)/inc/mpr.h

$(CONFIG)/obj/makerom.o: \
    src/paks/mpr/makerom.c $(DEPS_14)
	@echo '   [Compile] $(CONFIG)/obj/makerom.o'
	$(CC) -c -o $(CONFIG)/obj/makerom.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/mpr/makerom.c

#
#   makerom
#
DEPS_15 += $(CONFIG)/inc/mpr.h
DEPS_15 += $(CONFIG)/inc/bit.h
DEPS_15 += $(CONFIG)/inc/bitos.h
DEPS_15 += $(CONFIG)/obj/mprLib.o
DEPS_15 += $(CONFIG)/bin/libmpr.out
DEPS_15 += $(CONFIG)/obj/makerom.o

$(CONFIG)/bin/makerom.out: $(DEPS_15)
	@echo '      [Link] $(CONFIG)/bin/makerom.out'
	$(CC) -o $(CONFIG)/bin/makerom.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/makerom.o" $(LIBS) -Wl,-r 

#
#   ca-crt
#
DEPS_16 += src/paks/est/ca.crt

$(CONFIG)/bin/ca.crt: $(DEPS_16)
	@echo '      [Copy] $(CONFIG)/bin/ca.crt'
	mkdir -p "$(CONFIG)/bin"
	cp src/paks/est/ca.crt $(CONFIG)/bin/ca.crt

#
#   pcre.h
#
$(CONFIG)/inc/pcre.h: $(DEPS_17)
	@echo '      [Copy] $(CONFIG)/inc/pcre.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/paks/pcre/pcre.h $(CONFIG)/inc/pcre.h

#
#   pcre.o
#
DEPS_18 += $(CONFIG)/inc/bit.h
DEPS_18 += $(CONFIG)/inc/pcre.h

$(CONFIG)/obj/pcre.o: \
    src/paks/pcre/pcre.c $(DEPS_18)
	@echo '   [Compile] $(CONFIG)/obj/pcre.o'
	$(CC) -c -o $(CONFIG)/obj/pcre.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/pcre/pcre.c

ifeq ($(BIT_PACK_PCRE),1)
#
#   libpcre
#
DEPS_19 += $(CONFIG)/inc/pcre.h
DEPS_19 += $(CONFIG)/inc/bit.h
DEPS_19 += $(CONFIG)/obj/pcre.o

$(CONFIG)/bin/libpcre.out: $(DEPS_19)
	@echo '      [Link] $(CONFIG)/bin/libpcre.out'
	$(CC) -r -o $(CONFIG)/bin/libpcre.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/pcre.o" $(LIBS) 
endif

#
#   zlib.h
#
$(CONFIG)/inc/zlib.h: $(DEPS_20)
	@echo '      [Copy] $(CONFIG)/inc/zlib.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/paks/zlib/zlib.h $(CONFIG)/inc/zlib.h

#
#   zlib.o
#
DEPS_21 += $(CONFIG)/inc/bit.h
DEPS_21 += $(CONFIG)/inc/zlib.h
DEPS_21 += $(CONFIG)/inc/bitos.h

$(CONFIG)/obj/zlib.o: \
    src/paks/zlib/zlib.c $(DEPS_21)
	@echo '   [Compile] $(CONFIG)/obj/zlib.o'
	$(CC) -c -o $(CONFIG)/obj/zlib.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/zlib/zlib.c

ifeq ($(BIT_PACK_ZLIB),1)
#
#   libzlib
#
DEPS_22 += $(CONFIG)/inc/zlib.h
DEPS_22 += $(CONFIG)/inc/bit.h
DEPS_22 += $(CONFIG)/inc/bitos.h
DEPS_22 += $(CONFIG)/obj/zlib.o

$(CONFIG)/bin/libzlib.out: $(DEPS_22)
	@echo '      [Link] $(CONFIG)/bin/libzlib.out'
	$(CC) -r -o $(CONFIG)/bin/libzlib.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/zlib.o" $(LIBS) 
endif

#
#   http.h
#
$(CONFIG)/inc/http.h: $(DEPS_23)
	@echo '      [Copy] $(CONFIG)/inc/http.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/paks/http/http.h $(CONFIG)/inc/http.h

#
#   httpLib.o
#
DEPS_24 += $(CONFIG)/inc/bit.h
DEPS_24 += $(CONFIG)/inc/http.h
DEPS_24 += $(CONFIG)/inc/mpr.h

$(CONFIG)/obj/httpLib.o: \
    src/paks/http/httpLib.c $(DEPS_24)
	@echo '   [Compile] $(CONFIG)/obj/httpLib.o'
	$(CC) -c -o $(CONFIG)/obj/httpLib.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/http/httpLib.c

#
#   libhttp
#
DEPS_25 += $(CONFIG)/inc/mpr.h
DEPS_25 += $(CONFIG)/inc/bit.h
DEPS_25 += $(CONFIG)/inc/bitos.h
DEPS_25 += $(CONFIG)/obj/mprLib.o
DEPS_25 += $(CONFIG)/bin/libmpr.out
DEPS_25 += $(CONFIG)/inc/pcre.h
DEPS_25 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_25 += $(CONFIG)/bin/libpcre.out
endif
DEPS_25 += $(CONFIG)/inc/http.h
DEPS_25 += $(CONFIG)/obj/httpLib.o

$(CONFIG)/bin/libhttp.out: $(DEPS_25)
	@echo '      [Link] $(CONFIG)/bin/libhttp.out'
	$(CC) -r -o $(CONFIG)/bin/libhttp.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/httpLib.o" $(LIBS) 

#
#   http.o
#
DEPS_26 += $(CONFIG)/inc/bit.h
DEPS_26 += $(CONFIG)/inc/http.h

$(CONFIG)/obj/http.o: \
    src/paks/http/http.c $(DEPS_26)
	@echo '   [Compile] $(CONFIG)/obj/http.o'
	$(CC) -c -o $(CONFIG)/obj/http.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/http/http.c

#
#   http
#
DEPS_27 += $(CONFIG)/inc/mpr.h
DEPS_27 += $(CONFIG)/inc/bit.h
DEPS_27 += $(CONFIG)/inc/bitos.h
DEPS_27 += $(CONFIG)/obj/mprLib.o
DEPS_27 += $(CONFIG)/bin/libmpr.out
DEPS_27 += $(CONFIG)/inc/pcre.h
DEPS_27 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_27 += $(CONFIG)/bin/libpcre.out
endif
DEPS_27 += $(CONFIG)/inc/http.h
DEPS_27 += $(CONFIG)/obj/httpLib.o
DEPS_27 += $(CONFIG)/bin/libhttp.out
DEPS_27 += $(CONFIG)/obj/http.o

$(CONFIG)/bin/http.out: $(DEPS_27)
	@echo '      [Link] $(CONFIG)/bin/http.out'
	$(CC) -o $(CONFIG)/bin/http.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/http.o" $(LIBS) -Wl,-r 

#
#   sqlite3.h
#
$(CONFIG)/inc/sqlite3.h: $(DEPS_28)
	@echo '      [Copy] $(CONFIG)/inc/sqlite3.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/paks/sqlite/sqlite3.h $(CONFIG)/inc/sqlite3.h

#
#   sqlite3.o
#
DEPS_29 += $(CONFIG)/inc/bit.h
DEPS_29 += $(CONFIG)/inc/sqlite3.h

$(CONFIG)/obj/sqlite3.o: \
    src/paks/sqlite/sqlite3.c $(DEPS_29)
	@echo '   [Compile] $(CONFIG)/obj/sqlite3.o'
	$(CC) -c -o $(CONFIG)/obj/sqlite3.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/sqlite/sqlite3.c

ifeq ($(BIT_PACK_SQLITE),1)
#
#   libsql
#
DEPS_30 += $(CONFIG)/inc/sqlite3.h
DEPS_30 += $(CONFIG)/inc/bit.h
DEPS_30 += $(CONFIG)/obj/sqlite3.o

$(CONFIG)/bin/libsql.out: $(DEPS_30)
	@echo '      [Link] $(CONFIG)/bin/libsql.out'
	$(CC) -r -o $(CONFIG)/bin/libsql.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/sqlite3.o" $(LIBS) 
endif

#
#   sqlite.o
#
DEPS_31 += $(CONFIG)/inc/bit.h
DEPS_31 += $(CONFIG)/inc/sqlite3.h

$(CONFIG)/obj/sqlite.o: \
    src/paks/sqlite/sqlite.c $(DEPS_31)
	@echo '   [Compile] $(CONFIG)/obj/sqlite.o'
	$(CC) -c -o $(CONFIG)/obj/sqlite.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/sqlite/sqlite.c

ifeq ($(BIT_PACK_SQLITE),1)
#
#   sqliteshell
#
DEPS_32 += $(CONFIG)/inc/sqlite3.h
DEPS_32 += $(CONFIG)/inc/bit.h
DEPS_32 += $(CONFIG)/obj/sqlite3.o
DEPS_32 += $(CONFIG)/bin/libsql.out
DEPS_32 += $(CONFIG)/obj/sqlite.o

$(CONFIG)/bin/sqlite.out: $(DEPS_32)
	@echo '      [Link] $(CONFIG)/bin/sqlite.out'
	$(CC) -o $(CONFIG)/bin/sqlite.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/sqlite.o" $(LIBS) -Wl,-r 
endif

#
#   appweb.h
#
$(CONFIG)/inc/appweb.h: $(DEPS_33)
	@echo '      [Copy] $(CONFIG)/inc/appweb.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/appweb.h $(CONFIG)/inc/appweb.h

#
#   customize.h
#
$(CONFIG)/inc/customize.h: $(DEPS_34)
	@echo '      [Copy] $(CONFIG)/inc/customize.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/customize.h $(CONFIG)/inc/customize.h

#
#   config.o
#
DEPS_35 += $(CONFIG)/inc/bit.h
DEPS_35 += $(CONFIG)/inc/appweb.h
DEPS_35 += $(CONFIG)/inc/pcre.h
DEPS_35 += $(CONFIG)/inc/mpr.h
DEPS_35 += $(CONFIG)/inc/http.h
DEPS_35 += $(CONFIG)/inc/customize.h

$(CONFIG)/obj/config.o: \
    src/config.c $(DEPS_35)
	@echo '   [Compile] $(CONFIG)/obj/config.o'
	$(CC) -c -o $(CONFIG)/obj/config.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/config.c

#
#   convenience.o
#
DEPS_36 += $(CONFIG)/inc/bit.h
DEPS_36 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/convenience.o: \
    src/convenience.c $(DEPS_36)
	@echo '   [Compile] $(CONFIG)/obj/convenience.o'
	$(CC) -c -o $(CONFIG)/obj/convenience.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/convenience.c

#
#   dirHandler.o
#
DEPS_37 += $(CONFIG)/inc/bit.h
DEPS_37 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/dirHandler.o: \
    src/dirHandler.c $(DEPS_37)
	@echo '   [Compile] $(CONFIG)/obj/dirHandler.o'
	$(CC) -c -o $(CONFIG)/obj/dirHandler.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/dirHandler.c

#
#   fileHandler.o
#
DEPS_38 += $(CONFIG)/inc/bit.h
DEPS_38 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/fileHandler.o: \
    src/fileHandler.c $(DEPS_38)
	@echo '   [Compile] $(CONFIG)/obj/fileHandler.o'
	$(CC) -c -o $(CONFIG)/obj/fileHandler.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/fileHandler.c

#
#   log.o
#
DEPS_39 += $(CONFIG)/inc/bit.h
DEPS_39 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/log.o: \
    src/log.c $(DEPS_39)
	@echo '   [Compile] $(CONFIG)/obj/log.o'
	$(CC) -c -o $(CONFIG)/obj/log.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/log.c

#
#   server.o
#
DEPS_40 += $(CONFIG)/inc/bit.h
DEPS_40 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/server.o: \
    src/server.c $(DEPS_40)
	@echo '   [Compile] $(CONFIG)/obj/server.o'
	$(CC) -c -o $(CONFIG)/obj/server.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/server.c

#
#   libappweb
#
DEPS_41 += $(CONFIG)/inc/mpr.h
DEPS_41 += $(CONFIG)/inc/bit.h
DEPS_41 += $(CONFIG)/inc/bitos.h
DEPS_41 += $(CONFIG)/obj/mprLib.o
DEPS_41 += $(CONFIG)/bin/libmpr.out
DEPS_41 += $(CONFIG)/inc/pcre.h
DEPS_41 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_41 += $(CONFIG)/bin/libpcre.out
endif
DEPS_41 += $(CONFIG)/inc/http.h
DEPS_41 += $(CONFIG)/obj/httpLib.o
DEPS_41 += $(CONFIG)/bin/libhttp.out
DEPS_41 += $(CONFIG)/inc/appweb.h
DEPS_41 += $(CONFIG)/inc/customize.h
DEPS_41 += $(CONFIG)/obj/config.o
DEPS_41 += $(CONFIG)/obj/convenience.o
DEPS_41 += $(CONFIG)/obj/dirHandler.o
DEPS_41 += $(CONFIG)/obj/fileHandler.o
DEPS_41 += $(CONFIG)/obj/log.o
DEPS_41 += $(CONFIG)/obj/server.o

$(CONFIG)/bin/libappweb.out: $(DEPS_41)
	@echo '      [Link] $(CONFIG)/bin/libappweb.out'
	$(CC) -r -o $(CONFIG)/bin/libappweb.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/config.o" "$(CONFIG)/obj/convenience.o" "$(CONFIG)/obj/dirHandler.o" "$(CONFIG)/obj/fileHandler.o" "$(CONFIG)/obj/log.o" "$(CONFIG)/obj/server.o" $(LIBS) 

#
#   edi.h
#
$(CONFIG)/inc/edi.h: $(DEPS_42)
	@echo '      [Copy] $(CONFIG)/inc/edi.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/esp/edi.h $(CONFIG)/inc/edi.h

#
#   esp.h
#
$(CONFIG)/inc/esp.h: $(DEPS_43)
	@echo '      [Copy] $(CONFIG)/inc/esp.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/esp/esp.h $(CONFIG)/inc/esp.h

#
#   mdb.h
#
$(CONFIG)/inc/mdb.h: $(DEPS_44)
	@echo '      [Copy] $(CONFIG)/inc/mdb.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/esp/mdb.h $(CONFIG)/inc/mdb.h

#
#   edi.o
#
DEPS_45 += $(CONFIG)/inc/bit.h
DEPS_45 += $(CONFIG)/inc/edi.h
DEPS_45 += $(CONFIG)/inc/pcre.h

$(CONFIG)/obj/edi.o: \
    src/esp/edi.c $(DEPS_45)
	@echo '   [Compile] $(CONFIG)/obj/edi.o'
	$(CC) -c -o $(CONFIG)/obj/edi.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/esp/edi.c

#
#   espAbbrev.o
#
DEPS_46 += $(CONFIG)/inc/bit.h
DEPS_46 += $(CONFIG)/inc/esp.h

$(CONFIG)/obj/espAbbrev.o: \
    src/esp/espAbbrev.c $(DEPS_46)
	@echo '   [Compile] $(CONFIG)/obj/espAbbrev.o'
	$(CC) -c -o $(CONFIG)/obj/espAbbrev.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/esp/espAbbrev.c

#
#   espDeprecated.o
#
DEPS_47 += $(CONFIG)/inc/bit.h
DEPS_47 += $(CONFIG)/inc/esp.h
DEPS_47 += $(CONFIG)/inc/edi.h

$(CONFIG)/obj/espDeprecated.o: \
    src/esp/espDeprecated.c $(DEPS_47)
	@echo '   [Compile] $(CONFIG)/obj/espDeprecated.o'
	$(CC) -c -o $(CONFIG)/obj/espDeprecated.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/esp/espDeprecated.c

#
#   espFramework.o
#
DEPS_48 += $(CONFIG)/inc/bit.h
DEPS_48 += $(CONFIG)/inc/esp.h

$(CONFIG)/obj/espFramework.o: \
    src/esp/espFramework.c $(DEPS_48)
	@echo '   [Compile] $(CONFIG)/obj/espFramework.o'
	$(CC) -c -o $(CONFIG)/obj/espFramework.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/esp/espFramework.c

#
#   espHandler.o
#
DEPS_49 += $(CONFIG)/inc/bit.h
DEPS_49 += $(CONFIG)/inc/appweb.h
DEPS_49 += $(CONFIG)/inc/esp.h
DEPS_49 += $(CONFIG)/inc/edi.h

$(CONFIG)/obj/espHandler.o: \
    src/esp/espHandler.c $(DEPS_49)
	@echo '   [Compile] $(CONFIG)/obj/espHandler.o'
	$(CC) -c -o $(CONFIG)/obj/espHandler.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/esp/espHandler.c

#
#   espHtml.o
#
DEPS_50 += $(CONFIG)/inc/bit.h
DEPS_50 += $(CONFIG)/inc/esp.h
DEPS_50 += $(CONFIG)/inc/edi.h

$(CONFIG)/obj/espHtml.o: \
    src/esp/espHtml.c $(DEPS_50)
	@echo '   [Compile] $(CONFIG)/obj/espHtml.o'
	$(CC) -c -o $(CONFIG)/obj/espHtml.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/esp/espHtml.c

#
#   espTemplate.o
#
DEPS_51 += $(CONFIG)/inc/bit.h
DEPS_51 += $(CONFIG)/inc/esp.h

$(CONFIG)/obj/espTemplate.o: \
    src/esp/espTemplate.c $(DEPS_51)
	@echo '   [Compile] $(CONFIG)/obj/espTemplate.o'
	$(CC) -c -o $(CONFIG)/obj/espTemplate.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/esp/espTemplate.c

#
#   mdb.o
#
DEPS_52 += $(CONFIG)/inc/bit.h
DEPS_52 += $(CONFIG)/inc/appweb.h
DEPS_52 += $(CONFIG)/inc/edi.h
DEPS_52 += $(CONFIG)/inc/mdb.h
DEPS_52 += $(CONFIG)/inc/pcre.h

$(CONFIG)/obj/mdb.o: \
    src/esp/mdb.c $(DEPS_52)
	@echo '   [Compile] $(CONFIG)/obj/mdb.o'
	$(CC) -c -o $(CONFIG)/obj/mdb.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/esp/mdb.c

#
#   sdb.o
#
DEPS_53 += $(CONFIG)/inc/bit.h
DEPS_53 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/sdb.o: \
    src/esp/sdb.c $(DEPS_53)
	@echo '   [Compile] $(CONFIG)/obj/sdb.o'
	$(CC) -c -o $(CONFIG)/obj/sdb.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/esp/sdb.c

ifeq ($(BIT_PACK_ESP),1)
#
#   libmod_esp
#
DEPS_54 += $(CONFIG)/inc/mpr.h
DEPS_54 += $(CONFIG)/inc/bit.h
DEPS_54 += $(CONFIG)/inc/bitos.h
DEPS_54 += $(CONFIG)/obj/mprLib.o
DEPS_54 += $(CONFIG)/bin/libmpr.out
DEPS_54 += $(CONFIG)/inc/pcre.h
DEPS_54 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_54 += $(CONFIG)/bin/libpcre.out
endif
DEPS_54 += $(CONFIG)/inc/http.h
DEPS_54 += $(CONFIG)/obj/httpLib.o
DEPS_54 += $(CONFIG)/bin/libhttp.out
DEPS_54 += $(CONFIG)/inc/appweb.h
DEPS_54 += $(CONFIG)/inc/customize.h
DEPS_54 += $(CONFIG)/obj/config.o
DEPS_54 += $(CONFIG)/obj/convenience.o
DEPS_54 += $(CONFIG)/obj/dirHandler.o
DEPS_54 += $(CONFIG)/obj/fileHandler.o
DEPS_54 += $(CONFIG)/obj/log.o
DEPS_54 += $(CONFIG)/obj/server.o
DEPS_54 += $(CONFIG)/bin/libappweb.out
DEPS_54 += $(CONFIG)/inc/edi.h
DEPS_54 += $(CONFIG)/inc/esp.h
DEPS_54 += $(CONFIG)/inc/mdb.h
DEPS_54 += $(CONFIG)/obj/edi.o
DEPS_54 += $(CONFIG)/obj/espAbbrev.o
DEPS_54 += $(CONFIG)/obj/espDeprecated.o
DEPS_54 += $(CONFIG)/obj/espFramework.o
DEPS_54 += $(CONFIG)/obj/espHandler.o
DEPS_54 += $(CONFIG)/obj/espHtml.o
DEPS_54 += $(CONFIG)/obj/espTemplate.o
DEPS_54 += $(CONFIG)/obj/mdb.o
DEPS_54 += $(CONFIG)/obj/sdb.o

$(CONFIG)/bin/libmod_esp.out: $(DEPS_54)
	@echo '      [Link] $(CONFIG)/bin/libmod_esp.out'
	$(CC) -r -o $(CONFIG)/bin/libmod_esp.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/edi.o" "$(CONFIG)/obj/espAbbrev.o" "$(CONFIG)/obj/espDeprecated.o" "$(CONFIG)/obj/espFramework.o" "$(CONFIG)/obj/espHandler.o" "$(CONFIG)/obj/espHtml.o" "$(CONFIG)/obj/espTemplate.o" "$(CONFIG)/obj/mdb.o" "$(CONFIG)/obj/sdb.o" $(LIBS) 
endif

#
#   esp.o
#
DEPS_55 += $(CONFIG)/inc/bit.h
DEPS_55 += $(CONFIG)/inc/esp.h

$(CONFIG)/obj/esp.o: \
    src/esp/esp.c $(DEPS_55)
	@echo '   [Compile] $(CONFIG)/obj/esp.o'
	$(CC) -c -o $(CONFIG)/obj/esp.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/esp/esp.c

ifeq ($(BIT_PACK_ESP),1)
#
#   espcmd
#
DEPS_56 += $(CONFIG)/inc/mpr.h
DEPS_56 += $(CONFIG)/inc/bit.h
DEPS_56 += $(CONFIG)/inc/bitos.h
DEPS_56 += $(CONFIG)/obj/mprLib.o
DEPS_56 += $(CONFIG)/bin/libmpr.out
DEPS_56 += $(CONFIG)/inc/pcre.h
DEPS_56 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_56 += $(CONFIG)/bin/libpcre.out
endif
DEPS_56 += $(CONFIG)/inc/http.h
DEPS_56 += $(CONFIG)/obj/httpLib.o
DEPS_56 += $(CONFIG)/bin/libhttp.out
DEPS_56 += $(CONFIG)/inc/appweb.h
DEPS_56 += $(CONFIG)/inc/customize.h
DEPS_56 += $(CONFIG)/obj/config.o
DEPS_56 += $(CONFIG)/obj/convenience.o
DEPS_56 += $(CONFIG)/obj/dirHandler.o
DEPS_56 += $(CONFIG)/obj/fileHandler.o
DEPS_56 += $(CONFIG)/obj/log.o
DEPS_56 += $(CONFIG)/obj/server.o
DEPS_56 += $(CONFIG)/bin/libappweb.out
DEPS_56 += $(CONFIG)/inc/edi.h
DEPS_56 += $(CONFIG)/inc/esp.h
DEPS_56 += $(CONFIG)/inc/mdb.h
DEPS_56 += $(CONFIG)/obj/edi.o
DEPS_56 += $(CONFIG)/obj/espAbbrev.o
DEPS_56 += $(CONFIG)/obj/espDeprecated.o
DEPS_56 += $(CONFIG)/obj/espFramework.o
DEPS_56 += $(CONFIG)/obj/espHandler.o
DEPS_56 += $(CONFIG)/obj/espHtml.o
DEPS_56 += $(CONFIG)/obj/espTemplate.o
DEPS_56 += $(CONFIG)/obj/mdb.o
DEPS_56 += $(CONFIG)/obj/sdb.o
DEPS_56 += $(CONFIG)/bin/libmod_esp.out
DEPS_56 += $(CONFIG)/obj/esp.o

$(CONFIG)/bin/esp.out: $(DEPS_56)
	@echo '      [Link] $(CONFIG)/bin/esp.out'
	$(CC) -o $(CONFIG)/bin/esp.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/edi.o" "$(CONFIG)/obj/esp.o" "$(CONFIG)/obj/espAbbrev.o" "$(CONFIG)/obj/espDeprecated.o" "$(CONFIG)/obj/espFramework.o" "$(CONFIG)/obj/espHandler.o" "$(CONFIG)/obj/espHtml.o" "$(CONFIG)/obj/espTemplate.o" "$(CONFIG)/obj/mdb.o" "$(CONFIG)/obj/sdb.o" $(LIBS) -Wl,-r 
endif

ifeq ($(BIT_PACK_ESP),1)
#
#   esp.conf
#
DEPS_57 += src/esp/esp.conf

$(CONFIG)/bin/esp.conf: $(DEPS_57)
	@echo '      [Copy] $(CONFIG)/bin/esp.conf'
	mkdir -p "$(CONFIG)/bin"
	cp src/esp/esp.conf $(CONFIG)/bin/esp.conf
endif

ifeq ($(BIT_PACK_ESP),1)
#
#   esp.conf.server
#
DEPS_58 += src/esp/esp.conf

src/server/esp.conf: $(DEPS_58)
	@echo '      [Copy] src/server/esp.conf'
	mkdir -p "src/server"
	cp src/esp/esp.conf src/server/esp.conf
endif

ifeq ($(BIT_PACK_ESP),1)
#
#   paks
#
DEPS_59 += src/esp/paks/angular
DEPS_59 += src/esp/paks/angular/angular-animate.js
DEPS_59 += src/esp/paks/angular/angular-csp.css
DEPS_59 += src/esp/paks/angular/angular-route.js
DEPS_59 += src/esp/paks/angular/angular.js
DEPS_59 += src/esp/paks/angular/package.json
DEPS_59 += src/esp/paks/esp-angular
DEPS_59 += src/esp/paks/esp-angular/esp-click.js
DEPS_59 += src/esp/paks/esp-angular/esp-edit.js
DEPS_59 += src/esp/paks/esp-angular/esp-field-errors.js
DEPS_59 += src/esp/paks/esp-angular/esp-fixnum.js
DEPS_59 += src/esp/paks/esp-angular/esp-format.js
DEPS_59 += src/esp/paks/esp-angular/esp-input-group.js
DEPS_59 += src/esp/paks/esp-angular/esp-input.js
DEPS_59 += src/esp/paks/esp-angular/esp-resource.js
DEPS_59 += src/esp/paks/esp-angular/esp-session.js
DEPS_59 += src/esp/paks/esp-angular/esp-titlecase.js
DEPS_59 += src/esp/paks/esp-angular/esp.js
DEPS_59 += src/esp/paks/esp-angular/package.json
DEPS_59 += src/esp/paks/esp-angular-mvc
DEPS_59 += src/esp/paks/esp-angular-mvc/package.json
DEPS_59 += src/esp/paks/esp-angular-mvc/templates
DEPS_59 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc
DEPS_59 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/appweb.conf
DEPS_59 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/client
DEPS_59 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/client/app
DEPS_59 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/client/app/main.js
DEPS_59 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/client/assets
DEPS_59 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/client/assets/favicon.ico
DEPS_59 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/client/css
DEPS_59 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/client/css/all.css
DEPS_59 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/client/css/all.less
DEPS_59 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/client/css/app.less
DEPS_59 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/client/css/fix.css
DEPS_59 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/client/css/theme.less
DEPS_59 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/client/index.esp
DEPS_59 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/client/pages
DEPS_59 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/client/pages/splash.html
DEPS_59 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/controller-singleton.c
DEPS_59 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/controller.c
DEPS_59 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/controller.js
DEPS_59 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/edit.html
DEPS_59 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/list.html
DEPS_59 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/model.js
DEPS_59 += src/esp/paks/esp-angular-mvc/templates/esp-angular-mvc/start.bit
DEPS_59 += src/esp/paks/esp-html-mvc
DEPS_59 += src/esp/paks/esp-html-mvc/package.json
DEPS_59 += src/esp/paks/esp-html-mvc/templates
DEPS_59 += src/esp/paks/esp-html-mvc/templates/esp-html-mvc
DEPS_59 += src/esp/paks/esp-html-mvc/templates/esp-html-mvc/appweb.conf
DEPS_59 += src/esp/paks/esp-html-mvc/templates/esp-html-mvc/client
DEPS_59 += src/esp/paks/esp-html-mvc/templates/esp-html-mvc/client/assets
DEPS_59 += src/esp/paks/esp-html-mvc/templates/esp-html-mvc/client/assets/favicon.ico
DEPS_59 += src/esp/paks/esp-html-mvc/templates/esp-html-mvc/client/css
DEPS_59 += src/esp/paks/esp-html-mvc/templates/esp-html-mvc/client/css/all.css
DEPS_59 += src/esp/paks/esp-html-mvc/templates/esp-html-mvc/client/css/all.less
DEPS_59 += src/esp/paks/esp-html-mvc/templates/esp-html-mvc/client/css/app.less
DEPS_59 += src/esp/paks/esp-html-mvc/templates/esp-html-mvc/client/css/theme.less
DEPS_59 += src/esp/paks/esp-html-mvc/templates/esp-html-mvc/client/index.esp
DEPS_59 += src/esp/paks/esp-html-mvc/templates/esp-html-mvc/client/layouts
DEPS_59 += src/esp/paks/esp-html-mvc/templates/esp-html-mvc/client/layouts/default.esp
DEPS_59 += src/esp/paks/esp-html-mvc/templates/esp-html-mvc/controller-singleton.c
DEPS_59 += src/esp/paks/esp-html-mvc/templates/esp-html-mvc/controller.c
DEPS_59 += src/esp/paks/esp-html-mvc/templates/esp-html-mvc/edit.esp
DEPS_59 += src/esp/paks/esp-html-mvc/templates/esp-html-mvc/list.esp
DEPS_59 += src/esp/paks/esp-html-mvc/templates/esp-html-mvc/start.bit
DEPS_59 += src/esp/paks/esp-legacy-mvc
DEPS_59 += src/esp/paks/esp-legacy-mvc/package.json
DEPS_59 += src/esp/paks/esp-legacy-mvc/templates
DEPS_59 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc
DEPS_59 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc/appweb.conf
DEPS_59 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc/controller.c
DEPS_59 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc/edit.esp
DEPS_59 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc/layouts
DEPS_59 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc/layouts/default.esp
DEPS_59 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc/list.esp
DEPS_59 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc/migration.c
DEPS_59 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc/src
DEPS_59 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc/src/app.c
DEPS_59 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static
DEPS_59 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/css
DEPS_59 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/css/all.css
DEPS_59 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/images
DEPS_59 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/images/banner.jpg
DEPS_59 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/images/favicon.ico
DEPS_59 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/images/splash.jpg
DEPS_59 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/index.esp
DEPS_59 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/js
DEPS_59 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/js/jquery.esp.js
DEPS_59 += src/esp/paks/esp-legacy-mvc/templates/esp-legacy-mvc/static/js/jquery.js
DEPS_59 += src/esp/paks/esp-server
DEPS_59 += src/esp/paks/esp-server/package.json
DEPS_59 += src/esp/paks/esp-server/templates
DEPS_59 += src/esp/paks/esp-server/templates/esp-server
DEPS_59 += src/esp/paks/esp-server/templates/esp-server/appweb.conf
DEPS_59 += src/esp/paks/esp-server/templates/esp-server/controller.c
DEPS_59 += src/esp/paks/esp-server/templates/esp-server/migration.c
DEPS_59 += src/esp/paks/esp-server/templates/esp-server/src
DEPS_59 += src/esp/paks/esp-server/templates/esp-server/src/app.c

$(CONFIG)/paks: $(DEPS_59)
	( \
	cd src/esp/paks; \
	mkdir -p "../../../$(CONFIG)/paks/angular/1.2.6" ; \
	cp angular/angular-animate.js ../../../$(CONFIG)/paks/angular/1.2.6/angular-animate.js ; \
	cp angular/angular-csp.css ../../../$(CONFIG)/paks/angular/1.2.6/angular-csp.css ; \
	cp angular/angular-route.js ../../../$(CONFIG)/paks/angular/1.2.6/angular-route.js ; \
	cp angular/angular.js ../../../$(CONFIG)/paks/angular/1.2.6/angular.js ; \
	cp angular/package.json ../../../$(CONFIG)/paks/angular/1.2.6/package.json ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-angular/4.5.1" ; \
	cp esp-angular/esp-click.js ../../../$(CONFIG)/paks/esp-angular/4.5.1/esp-click.js ; \
	cp esp-angular/esp-edit.js ../../../$(CONFIG)/paks/esp-angular/4.5.1/esp-edit.js ; \
	cp esp-angular/esp-field-errors.js ../../../$(CONFIG)/paks/esp-angular/4.5.1/esp-field-errors.js ; \
	cp esp-angular/esp-fixnum.js ../../../$(CONFIG)/paks/esp-angular/4.5.1/esp-fixnum.js ; \
	cp esp-angular/esp-format.js ../../../$(CONFIG)/paks/esp-angular/4.5.1/esp-format.js ; \
	cp esp-angular/esp-input-group.js ../../../$(CONFIG)/paks/esp-angular/4.5.1/esp-input-group.js ; \
	cp esp-angular/esp-input.js ../../../$(CONFIG)/paks/esp-angular/4.5.1/esp-input.js ; \
	cp esp-angular/esp-resource.js ../../../$(CONFIG)/paks/esp-angular/4.5.1/esp-resource.js ; \
	cp esp-angular/esp-session.js ../../../$(CONFIG)/paks/esp-angular/4.5.1/esp-session.js ; \
	cp esp-angular/esp-titlecase.js ../../../$(CONFIG)/paks/esp-angular/4.5.1/esp-titlecase.js ; \
	cp esp-angular/esp.js ../../../$(CONFIG)/paks/esp-angular/4.5.1/esp.js ; \
	cp esp-angular/package.json ../../../$(CONFIG)/paks/esp-angular/4.5.1/package.json ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-angular-mvc/4.5.1" ; \
	cp esp-angular-mvc/package.json ../../../$(CONFIG)/paks/esp-angular-mvc/4.5.1/package.json ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-angular-mvc/4.5.1/templates" ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-angular-mvc/4.5.1/templates/esp-angular-mvc" ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/appweb.conf ../../../$(CONFIG)/paks/esp-angular-mvc/4.5.1/templates/esp-angular-mvc/appweb.conf ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-angular-mvc/4.5.1/templates/esp-angular-mvc/client" ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-angular-mvc/4.5.1/templates/esp-angular-mvc/client/app" ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/client/app/main.js ../../../$(CONFIG)/paks/esp-angular-mvc/4.5.1/templates/esp-angular-mvc/client/app/main.js ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-angular-mvc/4.5.1/templates/esp-angular-mvc/client/assets" ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/client/assets/favicon.ico ../../../$(CONFIG)/paks/esp-angular-mvc/4.5.1/templates/esp-angular-mvc/client/assets/favicon.ico ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-angular-mvc/4.5.1/templates/esp-angular-mvc/client/css" ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/client/css/all.css ../../../$(CONFIG)/paks/esp-angular-mvc/4.5.1/templates/esp-angular-mvc/client/css/all.css ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/client/css/all.less ../../../$(CONFIG)/paks/esp-angular-mvc/4.5.1/templates/esp-angular-mvc/client/css/all.less ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/client/css/app.less ../../../$(CONFIG)/paks/esp-angular-mvc/4.5.1/templates/esp-angular-mvc/client/css/app.less ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/client/css/fix.css ../../../$(CONFIG)/paks/esp-angular-mvc/4.5.1/templates/esp-angular-mvc/client/css/fix.css ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/client/css/theme.less ../../../$(CONFIG)/paks/esp-angular-mvc/4.5.1/templates/esp-angular-mvc/client/css/theme.less ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/client/index.esp ../../../$(CONFIG)/paks/esp-angular-mvc/4.5.1/templates/esp-angular-mvc/client/index.esp ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-angular-mvc/4.5.1/templates/esp-angular-mvc/client/pages" ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/client/pages/splash.html ../../../$(CONFIG)/paks/esp-angular-mvc/4.5.1/templates/esp-angular-mvc/client/pages/splash.html ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/controller-singleton.c ../../../$(CONFIG)/paks/esp-angular-mvc/4.5.1/templates/esp-angular-mvc/controller-singleton.c ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/controller.c ../../../$(CONFIG)/paks/esp-angular-mvc/4.5.1/templates/esp-angular-mvc/controller.c ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/controller.js ../../../$(CONFIG)/paks/esp-angular-mvc/4.5.1/templates/esp-angular-mvc/controller.js ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/edit.html ../../../$(CONFIG)/paks/esp-angular-mvc/4.5.1/templates/esp-angular-mvc/edit.html ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/list.html ../../../$(CONFIG)/paks/esp-angular-mvc/4.5.1/templates/esp-angular-mvc/list.html ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/model.js ../../../$(CONFIG)/paks/esp-angular-mvc/4.5.1/templates/esp-angular-mvc/model.js ; \
	cp esp-angular-mvc/templates/esp-angular-mvc/start.bit ../../../$(CONFIG)/paks/esp-angular-mvc/4.5.1/templates/esp-angular-mvc/start.bit ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-html-mvc/4.5.1" ; \
	cp esp-html-mvc/package.json ../../../$(CONFIG)/paks/esp-html-mvc/4.5.1/package.json ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-html-mvc/4.5.1/templates" ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-html-mvc/4.5.1/templates/esp-html-mvc" ; \
	cp esp-html-mvc/templates/esp-html-mvc/appweb.conf ../../../$(CONFIG)/paks/esp-html-mvc/4.5.1/templates/esp-html-mvc/appweb.conf ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-html-mvc/4.5.1/templates/esp-html-mvc/client" ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-html-mvc/4.5.1/templates/esp-html-mvc/client/assets" ; \
	cp esp-html-mvc/templates/esp-html-mvc/client/assets/favicon.ico ../../../$(CONFIG)/paks/esp-html-mvc/4.5.1/templates/esp-html-mvc/client/assets/favicon.ico ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-html-mvc/4.5.1/templates/esp-html-mvc/client/css" ; \
	cp esp-html-mvc/templates/esp-html-mvc/client/css/all.css ../../../$(CONFIG)/paks/esp-html-mvc/4.5.1/templates/esp-html-mvc/client/css/all.css ; \
	cp esp-html-mvc/templates/esp-html-mvc/client/css/all.less ../../../$(CONFIG)/paks/esp-html-mvc/4.5.1/templates/esp-html-mvc/client/css/all.less ; \
	cp esp-html-mvc/templates/esp-html-mvc/client/css/app.less ../../../$(CONFIG)/paks/esp-html-mvc/4.5.1/templates/esp-html-mvc/client/css/app.less ; \
	cp esp-html-mvc/templates/esp-html-mvc/client/css/theme.less ../../../$(CONFIG)/paks/esp-html-mvc/4.5.1/templates/esp-html-mvc/client/css/theme.less ; \
	cp esp-html-mvc/templates/esp-html-mvc/client/index.esp ../../../$(CONFIG)/paks/esp-html-mvc/4.5.1/templates/esp-html-mvc/client/index.esp ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-html-mvc/4.5.1/templates/esp-html-mvc/client/layouts" ; \
	cp esp-html-mvc/templates/esp-html-mvc/client/layouts/default.esp ../../../$(CONFIG)/paks/esp-html-mvc/4.5.1/templates/esp-html-mvc/client/layouts/default.esp ; \
	cp esp-html-mvc/templates/esp-html-mvc/controller-singleton.c ../../../$(CONFIG)/paks/esp-html-mvc/4.5.1/templates/esp-html-mvc/controller-singleton.c ; \
	cp esp-html-mvc/templates/esp-html-mvc/controller.c ../../../$(CONFIG)/paks/esp-html-mvc/4.5.1/templates/esp-html-mvc/controller.c ; \
	cp esp-html-mvc/templates/esp-html-mvc/edit.esp ../../../$(CONFIG)/paks/esp-html-mvc/4.5.1/templates/esp-html-mvc/edit.esp ; \
	cp esp-html-mvc/templates/esp-html-mvc/list.esp ../../../$(CONFIG)/paks/esp-html-mvc/4.5.1/templates/esp-html-mvc/list.esp ; \
	cp esp-html-mvc/templates/esp-html-mvc/start.bit ../../../$(CONFIG)/paks/esp-html-mvc/4.5.1/templates/esp-html-mvc/start.bit ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.1" ; \
	cp esp-legacy-mvc/package.json ../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.1/package.json ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.1/templates" ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.1/templates/esp-legacy-mvc" ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/appweb.conf ../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.1/templates/esp-legacy-mvc/appweb.conf ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/controller.c ../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.1/templates/esp-legacy-mvc/controller.c ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/edit.esp ../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.1/templates/esp-legacy-mvc/edit.esp ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.1/templates/esp-legacy-mvc/layouts" ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/layouts/default.esp ../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.1/templates/esp-legacy-mvc/layouts/default.esp ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/list.esp ../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.1/templates/esp-legacy-mvc/list.esp ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/migration.c ../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.1/templates/esp-legacy-mvc/migration.c ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.1/templates/esp-legacy-mvc/src" ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/src/app.c ../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.1/templates/esp-legacy-mvc/src/app.c ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.1/templates/esp-legacy-mvc/static" ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.1/templates/esp-legacy-mvc/static/css" ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/static/css/all.css ../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.1/templates/esp-legacy-mvc/static/css/all.css ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.1/templates/esp-legacy-mvc/static/images" ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/static/images/banner.jpg ../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.1/templates/esp-legacy-mvc/static/images/banner.jpg ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/static/images/favicon.ico ../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.1/templates/esp-legacy-mvc/static/images/favicon.ico ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/static/images/splash.jpg ../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.1/templates/esp-legacy-mvc/static/images/splash.jpg ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/static/index.esp ../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.1/templates/esp-legacy-mvc/static/index.esp ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.1/templates/esp-legacy-mvc/static/js" ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/static/js/jquery.esp.js ../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.1/templates/esp-legacy-mvc/static/js/jquery.esp.js ; \
	cp esp-legacy-mvc/templates/esp-legacy-mvc/static/js/jquery.js ../../../$(CONFIG)/paks/esp-legacy-mvc/4.5.1/templates/esp-legacy-mvc/static/js/jquery.js ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-server/4.5.1" ; \
	cp esp-server/package.json ../../../$(CONFIG)/paks/esp-server/4.5.1/package.json ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-server/4.5.1/templates" ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-server/4.5.1/templates/esp-server" ; \
	cp esp-server/templates/esp-server/appweb.conf ../../../$(CONFIG)/paks/esp-server/4.5.1/templates/esp-server/appweb.conf ; \
	cp esp-server/templates/esp-server/controller.c ../../../$(CONFIG)/paks/esp-server/4.5.1/templates/esp-server/controller.c ; \
	cp esp-server/templates/esp-server/migration.c ../../../$(CONFIG)/paks/esp-server/4.5.1/templates/esp-server/migration.c ; \
	mkdir -p "../../../$(CONFIG)/paks/esp-server/4.5.1/templates/esp-server/src" ; \
	cp esp-server/templates/esp-server/src/app.c ../../../$(CONFIG)/paks/esp-server/4.5.1/templates/esp-server/src/app.c ; \
	)
endif


#
#   ejs.h
#
$(CONFIG)/inc/ejs.h: $(DEPS_60)
	@echo '      [Copy] $(CONFIG)/inc/ejs.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/paks/ejs/ejs.h $(CONFIG)/inc/ejs.h

#
#   ejs.slots.h
#
$(CONFIG)/inc/ejs.slots.h: $(DEPS_61)
	@echo '      [Copy] $(CONFIG)/inc/ejs.slots.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/paks/ejs/ejs.slots.h $(CONFIG)/inc/ejs.slots.h

#
#   ejsByteGoto.h
#
$(CONFIG)/inc/ejsByteGoto.h: $(DEPS_62)
	@echo '      [Copy] $(CONFIG)/inc/ejsByteGoto.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/paks/ejs/ejsByteGoto.h $(CONFIG)/inc/ejsByteGoto.h

#
#   ejsLib.o
#
DEPS_63 += $(CONFIG)/inc/bit.h
DEPS_63 += $(CONFIG)/inc/ejs.h
DEPS_63 += $(CONFIG)/inc/mpr.h
DEPS_63 += $(CONFIG)/inc/pcre.h
DEPS_63 += $(CONFIG)/inc/bitos.h
DEPS_63 += $(CONFIG)/inc/http.h
DEPS_63 += $(CONFIG)/inc/ejs.slots.h

$(CONFIG)/obj/ejsLib.o: \
    src/paks/ejs/ejsLib.c $(DEPS_63)
	@echo '   [Compile] $(CONFIG)/obj/ejsLib.o'
	$(CC) -c -o $(CONFIG)/obj/ejsLib.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/ejs/ejsLib.c

ifeq ($(BIT_PACK_EJSCRIPT),1)
#
#   libejs
#
DEPS_64 += $(CONFIG)/inc/mpr.h
DEPS_64 += $(CONFIG)/inc/bit.h
DEPS_64 += $(CONFIG)/inc/bitos.h
DEPS_64 += $(CONFIG)/obj/mprLib.o
DEPS_64 += $(CONFIG)/bin/libmpr.out
DEPS_64 += $(CONFIG)/inc/pcre.h
DEPS_64 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_64 += $(CONFIG)/bin/libpcre.out
endif
DEPS_64 += $(CONFIG)/inc/http.h
DEPS_64 += $(CONFIG)/obj/httpLib.o
DEPS_64 += $(CONFIG)/bin/libhttp.out
DEPS_64 += $(CONFIG)/inc/zlib.h
DEPS_64 += $(CONFIG)/obj/zlib.o
ifeq ($(BIT_PACK_ZLIB),1)
    DEPS_64 += $(CONFIG)/bin/libzlib.out
endif
DEPS_64 += $(CONFIG)/inc/ejs.h
DEPS_64 += $(CONFIG)/inc/ejs.slots.h
DEPS_64 += $(CONFIG)/inc/ejsByteGoto.h
DEPS_64 += $(CONFIG)/obj/ejsLib.o

$(CONFIG)/bin/libejs.out: $(DEPS_64)
	@echo '      [Link] $(CONFIG)/bin/libejs.out'
	$(CC) -r -o $(CONFIG)/bin/libejs.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/ejsLib.o" $(LIBS) 
endif

#
#   ejs.o
#
DEPS_65 += $(CONFIG)/inc/bit.h
DEPS_65 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejs.o: \
    src/paks/ejs/ejs.c $(DEPS_65)
	@echo '   [Compile] $(CONFIG)/obj/ejs.o'
	$(CC) -c -o $(CONFIG)/obj/ejs.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/ejs/ejs.c

ifeq ($(BIT_PACK_EJSCRIPT),1)
#
#   ejs
#
DEPS_66 += $(CONFIG)/inc/mpr.h
DEPS_66 += $(CONFIG)/inc/bit.h
DEPS_66 += $(CONFIG)/inc/bitos.h
DEPS_66 += $(CONFIG)/obj/mprLib.o
DEPS_66 += $(CONFIG)/bin/libmpr.out
DEPS_66 += $(CONFIG)/inc/pcre.h
DEPS_66 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_66 += $(CONFIG)/bin/libpcre.out
endif
DEPS_66 += $(CONFIG)/inc/http.h
DEPS_66 += $(CONFIG)/obj/httpLib.o
DEPS_66 += $(CONFIG)/bin/libhttp.out
DEPS_66 += $(CONFIG)/inc/zlib.h
DEPS_66 += $(CONFIG)/obj/zlib.o
ifeq ($(BIT_PACK_ZLIB),1)
    DEPS_66 += $(CONFIG)/bin/libzlib.out
endif
DEPS_66 += $(CONFIG)/inc/ejs.h
DEPS_66 += $(CONFIG)/inc/ejs.slots.h
DEPS_66 += $(CONFIG)/inc/ejsByteGoto.h
DEPS_66 += $(CONFIG)/obj/ejsLib.o
DEPS_66 += $(CONFIG)/bin/libejs.out
DEPS_66 += $(CONFIG)/obj/ejs.o

$(CONFIG)/bin/ejs.out: $(DEPS_66)
	@echo '      [Link] $(CONFIG)/bin/ejs.out'
	$(CC) -o $(CONFIG)/bin/ejs.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/ejs.o" $(LIBS) -Wl,-r 
endif

#
#   ejsc.o
#
DEPS_67 += $(CONFIG)/inc/bit.h
DEPS_67 += $(CONFIG)/inc/ejs.h

$(CONFIG)/obj/ejsc.o: \
    src/paks/ejs/ejsc.c $(DEPS_67)
	@echo '   [Compile] $(CONFIG)/obj/ejsc.o'
	$(CC) -c -o $(CONFIG)/obj/ejsc.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/paks/ejs/ejsc.c

ifeq ($(BIT_PACK_EJSCRIPT),1)
#
#   ejsc
#
DEPS_68 += $(CONFIG)/inc/mpr.h
DEPS_68 += $(CONFIG)/inc/bit.h
DEPS_68 += $(CONFIG)/inc/bitos.h
DEPS_68 += $(CONFIG)/obj/mprLib.o
DEPS_68 += $(CONFIG)/bin/libmpr.out
DEPS_68 += $(CONFIG)/inc/pcre.h
DEPS_68 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_68 += $(CONFIG)/bin/libpcre.out
endif
DEPS_68 += $(CONFIG)/inc/http.h
DEPS_68 += $(CONFIG)/obj/httpLib.o
DEPS_68 += $(CONFIG)/bin/libhttp.out
DEPS_68 += $(CONFIG)/inc/zlib.h
DEPS_68 += $(CONFIG)/obj/zlib.o
ifeq ($(BIT_PACK_ZLIB),1)
    DEPS_68 += $(CONFIG)/bin/libzlib.out
endif
DEPS_68 += $(CONFIG)/inc/ejs.h
DEPS_68 += $(CONFIG)/inc/ejs.slots.h
DEPS_68 += $(CONFIG)/inc/ejsByteGoto.h
DEPS_68 += $(CONFIG)/obj/ejsLib.o
DEPS_68 += $(CONFIG)/bin/libejs.out
DEPS_68 += $(CONFIG)/obj/ejsc.o

$(CONFIG)/bin/ejsc.out: $(DEPS_68)
	@echo '      [Link] $(CONFIG)/bin/ejsc.out'
	$(CC) -o $(CONFIG)/bin/ejsc.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/ejsc.o" $(LIBS) -Wl,-r 
endif

ifeq ($(BIT_PACK_EJSCRIPT),1)
#
#   ejs.mod
#
DEPS_69 += src/paks/ejs/ejs.es
DEPS_69 += $(CONFIG)/inc/mpr.h
DEPS_69 += $(CONFIG)/inc/bit.h
DEPS_69 += $(CONFIG)/inc/bitos.h
DEPS_69 += $(CONFIG)/obj/mprLib.o
DEPS_69 += $(CONFIG)/bin/libmpr.out
DEPS_69 += $(CONFIG)/inc/pcre.h
DEPS_69 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_69 += $(CONFIG)/bin/libpcre.out
endif
DEPS_69 += $(CONFIG)/inc/http.h
DEPS_69 += $(CONFIG)/obj/httpLib.o
DEPS_69 += $(CONFIG)/bin/libhttp.out
DEPS_69 += $(CONFIG)/inc/zlib.h
DEPS_69 += $(CONFIG)/obj/zlib.o
ifeq ($(BIT_PACK_ZLIB),1)
    DEPS_69 += $(CONFIG)/bin/libzlib.out
endif
DEPS_69 += $(CONFIG)/inc/ejs.h
DEPS_69 += $(CONFIG)/inc/ejs.slots.h
DEPS_69 += $(CONFIG)/inc/ejsByteGoto.h
DEPS_69 += $(CONFIG)/obj/ejsLib.o
DEPS_69 += $(CONFIG)/bin/libejs.out
DEPS_69 += $(CONFIG)/obj/ejsc.o
DEPS_69 += $(CONFIG)/bin/ejsc.out

$(CONFIG)/bin/ejs.mod: $(DEPS_69)
	( \
	cd src/paks/ejs; \
	../../../$(CONFIG)/bin/ejsc --out ../../../$(CONFIG)/bin/ejs.mod --optimize 9 --bind --require null ejs.es ; \
	)
endif

#
#   cgiHandler.o
#
DEPS_70 += $(CONFIG)/inc/bit.h
DEPS_70 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/cgiHandler.o: \
    src/modules/cgiHandler.c $(DEPS_70)
	@echo '   [Compile] $(CONFIG)/obj/cgiHandler.o'
	$(CC) -c -o $(CONFIG)/obj/cgiHandler.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/modules/cgiHandler.c

ifeq ($(BIT_PACK_CGI),1)
#
#   libmod_cgi
#
DEPS_71 += $(CONFIG)/inc/mpr.h
DEPS_71 += $(CONFIG)/inc/bit.h
DEPS_71 += $(CONFIG)/inc/bitos.h
DEPS_71 += $(CONFIG)/obj/mprLib.o
DEPS_71 += $(CONFIG)/bin/libmpr.out
DEPS_71 += $(CONFIG)/inc/pcre.h
DEPS_71 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_71 += $(CONFIG)/bin/libpcre.out
endif
DEPS_71 += $(CONFIG)/inc/http.h
DEPS_71 += $(CONFIG)/obj/httpLib.o
DEPS_71 += $(CONFIG)/bin/libhttp.out
DEPS_71 += $(CONFIG)/inc/appweb.h
DEPS_71 += $(CONFIG)/inc/customize.h
DEPS_71 += $(CONFIG)/obj/config.o
DEPS_71 += $(CONFIG)/obj/convenience.o
DEPS_71 += $(CONFIG)/obj/dirHandler.o
DEPS_71 += $(CONFIG)/obj/fileHandler.o
DEPS_71 += $(CONFIG)/obj/log.o
DEPS_71 += $(CONFIG)/obj/server.o
DEPS_71 += $(CONFIG)/bin/libappweb.out
DEPS_71 += $(CONFIG)/obj/cgiHandler.o

$(CONFIG)/bin/libmod_cgi.out: $(DEPS_71)
	@echo '      [Link] $(CONFIG)/bin/libmod_cgi.out'
	$(CC) -r -o $(CONFIG)/bin/libmod_cgi.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/cgiHandler.o" $(LIBS) 
endif

#
#   ejsHandler.o
#
DEPS_72 += $(CONFIG)/inc/bit.h
DEPS_72 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/ejsHandler.o: \
    src/modules/ejsHandler.c $(DEPS_72)
	@echo '   [Compile] $(CONFIG)/obj/ejsHandler.o'
	$(CC) -c -o $(CONFIG)/obj/ejsHandler.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/modules/ejsHandler.c

ifeq ($(BIT_PACK_EJSCRIPT),1)
#
#   libmod_ejs
#
DEPS_73 += $(CONFIG)/inc/mpr.h
DEPS_73 += $(CONFIG)/inc/bit.h
DEPS_73 += $(CONFIG)/inc/bitos.h
DEPS_73 += $(CONFIG)/obj/mprLib.o
DEPS_73 += $(CONFIG)/bin/libmpr.out
DEPS_73 += $(CONFIG)/inc/pcre.h
DEPS_73 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_73 += $(CONFIG)/bin/libpcre.out
endif
DEPS_73 += $(CONFIG)/inc/http.h
DEPS_73 += $(CONFIG)/obj/httpLib.o
DEPS_73 += $(CONFIG)/bin/libhttp.out
DEPS_73 += $(CONFIG)/inc/appweb.h
DEPS_73 += $(CONFIG)/inc/customize.h
DEPS_73 += $(CONFIG)/obj/config.o
DEPS_73 += $(CONFIG)/obj/convenience.o
DEPS_73 += $(CONFIG)/obj/dirHandler.o
DEPS_73 += $(CONFIG)/obj/fileHandler.o
DEPS_73 += $(CONFIG)/obj/log.o
DEPS_73 += $(CONFIG)/obj/server.o
DEPS_73 += $(CONFIG)/bin/libappweb.out
DEPS_73 += $(CONFIG)/inc/zlib.h
DEPS_73 += $(CONFIG)/obj/zlib.o
ifeq ($(BIT_PACK_ZLIB),1)
    DEPS_73 += $(CONFIG)/bin/libzlib.out
endif
DEPS_73 += $(CONFIG)/inc/ejs.h
DEPS_73 += $(CONFIG)/inc/ejs.slots.h
DEPS_73 += $(CONFIG)/inc/ejsByteGoto.h
DEPS_73 += $(CONFIG)/obj/ejsLib.o
DEPS_73 += $(CONFIG)/bin/libejs.out
DEPS_73 += $(CONFIG)/obj/ejsHandler.o

$(CONFIG)/bin/libmod_ejs.out: $(DEPS_73)
	@echo '      [Link] $(CONFIG)/bin/libmod_ejs.out'
	$(CC) -r -o $(CONFIG)/bin/libmod_ejs.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/ejsHandler.o" $(LIBS) 
endif

#
#   phpHandler.o
#
DEPS_74 += $(CONFIG)/inc/bit.h
DEPS_74 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/phpHandler.o: \
    src/modules/phpHandler.c $(DEPS_74)
	@echo '   [Compile] $(CONFIG)/obj/phpHandler.o'
	$(CC) -c -o $(CONFIG)/obj/phpHandler.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" "-I$(BIT_PACK_PHP_PATH)" "-I$(BIT_PACK_PHP_PATH)/main" "-I$(BIT_PACK_PHP_PATH)/Zend" "-I$(BIT_PACK_PHP_PATH)/TSRM" src/modules/phpHandler.c

ifeq ($(BIT_PACK_PHP),1)
#
#   libmod_php
#
DEPS_75 += $(CONFIG)/inc/mpr.h
DEPS_75 += $(CONFIG)/inc/bit.h
DEPS_75 += $(CONFIG)/inc/bitos.h
DEPS_75 += $(CONFIG)/obj/mprLib.o
DEPS_75 += $(CONFIG)/bin/libmpr.out
DEPS_75 += $(CONFIG)/inc/pcre.h
DEPS_75 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_75 += $(CONFIG)/bin/libpcre.out
endif
DEPS_75 += $(CONFIG)/inc/http.h
DEPS_75 += $(CONFIG)/obj/httpLib.o
DEPS_75 += $(CONFIG)/bin/libhttp.out
DEPS_75 += $(CONFIG)/inc/appweb.h
DEPS_75 += $(CONFIG)/inc/customize.h
DEPS_75 += $(CONFIG)/obj/config.o
DEPS_75 += $(CONFIG)/obj/convenience.o
DEPS_75 += $(CONFIG)/obj/dirHandler.o
DEPS_75 += $(CONFIG)/obj/fileHandler.o
DEPS_75 += $(CONFIG)/obj/log.o
DEPS_75 += $(CONFIG)/obj/server.o
DEPS_75 += $(CONFIG)/bin/libappweb.out
DEPS_75 += $(CONFIG)/obj/phpHandler.o

LIBS_75 += -lphp5
LIBPATHS_75 += -L$(BIT_PACK_PHP_PATH)/libs

$(CONFIG)/bin/libmod_php.out: $(DEPS_75)
	@echo '      [Link] $(CONFIG)/bin/libmod_php.out'
	$(CC) -r -o $(CONFIG)/bin/libmod_php.out $(LDFLAGS) $(LIBPATHS)  "$(CONFIG)/obj/phpHandler.o" $(LIBPATHS_75) $(LIBS_75) $(LIBS_75) $(LIBS) 
endif

#
#   sslModule.o
#
DEPS_76 += $(CONFIG)/inc/bit.h
DEPS_76 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/sslModule.o: \
    src/modules/sslModule.c $(DEPS_76)
	@echo '   [Compile] $(CONFIG)/obj/sslModule.o'
	$(CC) -c -o $(CONFIG)/obj/sslModule.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" "-I$(BIT_PACK_MATRIXSSL_PATH)" "-I$(BIT_PACK_MATRIXSSL_PATH)/matrixssl" "-I$(BIT_PACK_NANOSSL_PATH)/src" "-I$(BIT_PACK_OPENSSL_PATH)/include" src/modules/sslModule.c

ifeq ($(BIT_PACK_SSL),1)
#
#   libmod_ssl
#
DEPS_77 += $(CONFIG)/inc/mpr.h
DEPS_77 += $(CONFIG)/inc/bit.h
DEPS_77 += $(CONFIG)/inc/bitos.h
DEPS_77 += $(CONFIG)/obj/mprLib.o
DEPS_77 += $(CONFIG)/bin/libmpr.out
DEPS_77 += $(CONFIG)/inc/pcre.h
DEPS_77 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_77 += $(CONFIG)/bin/libpcre.out
endif
DEPS_77 += $(CONFIG)/inc/http.h
DEPS_77 += $(CONFIG)/obj/httpLib.o
DEPS_77 += $(CONFIG)/bin/libhttp.out
DEPS_77 += $(CONFIG)/inc/appweb.h
DEPS_77 += $(CONFIG)/inc/customize.h
DEPS_77 += $(CONFIG)/obj/config.o
DEPS_77 += $(CONFIG)/obj/convenience.o
DEPS_77 += $(CONFIG)/obj/dirHandler.o
DEPS_77 += $(CONFIG)/obj/fileHandler.o
DEPS_77 += $(CONFIG)/obj/log.o
DEPS_77 += $(CONFIG)/obj/server.o
DEPS_77 += $(CONFIG)/bin/libappweb.out
DEPS_77 += $(CONFIG)/inc/est.h
DEPS_77 += $(CONFIG)/obj/estLib.o
ifeq ($(BIT_PACK_EST),1)
    DEPS_77 += $(CONFIG)/bin/libest.out
endif
DEPS_77 += $(CONFIG)/obj/mprSsl.o
DEPS_77 += $(CONFIG)/bin/libmprssl.out
DEPS_77 += $(CONFIG)/obj/sslModule.o

ifeq ($(BIT_PACK_MATRIXSSL),1)
    LIBS_77 += -lmatrixssl
    LIBPATHS_77 += -L$(BIT_PACK_MATRIXSSL_PATH)
endif
ifeq ($(BIT_PACK_NANOSSL),1)
    LIBS_77 += -lssls
    LIBPATHS_77 += -L$(BIT_PACK_NANOSSL_PATH)/bin
endif
ifeq ($(BIT_PACK_OPENSSL),1)
    LIBS_77 += -lssl
    LIBPATHS_77 += -L$(BIT_PACK_OPENSSL_PATH)
endif
ifeq ($(BIT_PACK_OPENSSL),1)
    LIBS_77 += -lcrypto
    LIBPATHS_77 += -L$(BIT_PACK_OPENSSL_PATH)
endif

$(CONFIG)/bin/libmod_ssl.out: $(DEPS_77)
	@echo '      [Link] $(CONFIG)/bin/libmod_ssl.out'
	$(CC) -r -o $(CONFIG)/bin/libmod_ssl.out $(LDFLAGS) $(LIBPATHS)    "$(CONFIG)/obj/sslModule.o" $(LIBPATHS_77) $(LIBS_77) $(LIBS_77) $(LIBS) 
endif

#
#   authpass.o
#
DEPS_78 += $(CONFIG)/inc/bit.h
DEPS_78 += $(CONFIG)/inc/appweb.h

$(CONFIG)/obj/authpass.o: \
    src/utils/authpass.c $(DEPS_78)
	@echo '   [Compile] $(CONFIG)/obj/authpass.o'
	$(CC) -c -o $(CONFIG)/obj/authpass.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/utils/authpass.c

#
#   authpass
#
DEPS_79 += $(CONFIG)/inc/mpr.h
DEPS_79 += $(CONFIG)/inc/bit.h
DEPS_79 += $(CONFIG)/inc/bitos.h
DEPS_79 += $(CONFIG)/obj/mprLib.o
DEPS_79 += $(CONFIG)/bin/libmpr.out
DEPS_79 += $(CONFIG)/inc/pcre.h
DEPS_79 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_79 += $(CONFIG)/bin/libpcre.out
endif
DEPS_79 += $(CONFIG)/inc/http.h
DEPS_79 += $(CONFIG)/obj/httpLib.o
DEPS_79 += $(CONFIG)/bin/libhttp.out
DEPS_79 += $(CONFIG)/inc/appweb.h
DEPS_79 += $(CONFIG)/inc/customize.h
DEPS_79 += $(CONFIG)/obj/config.o
DEPS_79 += $(CONFIG)/obj/convenience.o
DEPS_79 += $(CONFIG)/obj/dirHandler.o
DEPS_79 += $(CONFIG)/obj/fileHandler.o
DEPS_79 += $(CONFIG)/obj/log.o
DEPS_79 += $(CONFIG)/obj/server.o
DEPS_79 += $(CONFIG)/bin/libappweb.out
DEPS_79 += $(CONFIG)/obj/authpass.o

$(CONFIG)/bin/authpass.out: $(DEPS_79)
	@echo '      [Link] $(CONFIG)/bin/authpass.out'
	$(CC) -o $(CONFIG)/bin/authpass.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/authpass.o" $(LIBS) -Wl,-r 

#
#   cgiProgram.o
#
DEPS_80 += $(CONFIG)/inc/bit.h

$(CONFIG)/obj/cgiProgram.o: \
    src/utils/cgiProgram.c $(DEPS_80)
	@echo '   [Compile] $(CONFIG)/obj/cgiProgram.o'
	$(CC) -c -o $(CONFIG)/obj/cgiProgram.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/utils/cgiProgram.c

ifeq ($(BIT_PACK_CGI),1)
#
#   cgiProgram
#
DEPS_81 += $(CONFIG)/inc/bit.h
DEPS_81 += $(CONFIG)/obj/cgiProgram.o

$(CONFIG)/bin/cgiProgram.out: $(DEPS_81)
	@echo '      [Link] $(CONFIG)/bin/cgiProgram.out'
	$(CC) -o $(CONFIG)/bin/cgiProgram.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/cgiProgram.o" $(LIBS) -Wl,-r 
endif

#
#   slink.c
#
src/server/slink.c: $(DEPS_82)
	( \
	cd src/server; \
	[ ! -f slink.c ] && cp slink.empty slink.c ; true ; \
	)

#
#   slink.o
#
DEPS_83 += $(CONFIG)/inc/bit.h
DEPS_83 += $(CONFIG)/inc/esp.h

$(CONFIG)/obj/slink.o: \
    src/server/slink.c $(DEPS_83)
	@echo '   [Compile] $(CONFIG)/obj/slink.o'
	$(CC) -c -o $(CONFIG)/obj/slink.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/server/slink.c

#
#   libslink
#
DEPS_84 += src/server/slink.c
DEPS_84 += $(CONFIG)/inc/bit.h
DEPS_84 += $(CONFIG)/inc/esp.h
DEPS_84 += $(CONFIG)/obj/slink.o

$(CONFIG)/bin/libslink.out: $(DEPS_84)
	@echo '      [Link] $(CONFIG)/bin/libslink.out'
	$(CC) -r -o $(CONFIG)/bin/libslink.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/slink.o" $(LIBS) 

#
#   appweb.o
#
DEPS_85 += $(CONFIG)/inc/bit.h
DEPS_85 += $(CONFIG)/inc/appweb.h
DEPS_85 += $(CONFIG)/inc/esp.h

$(CONFIG)/obj/appweb.o: \
    src/server/appweb.c $(DEPS_85)
	@echo '   [Compile] $(CONFIG)/obj/appweb.o'
	$(CC) -c -o $(CONFIG)/obj/appweb.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" src/server/appweb.c

#
#   appweb
#
DEPS_86 += $(CONFIG)/inc/mpr.h
DEPS_86 += $(CONFIG)/inc/bit.h
DEPS_86 += $(CONFIG)/inc/bitos.h
DEPS_86 += $(CONFIG)/obj/mprLib.o
DEPS_86 += $(CONFIG)/bin/libmpr.out
DEPS_86 += $(CONFIG)/inc/pcre.h
DEPS_86 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_86 += $(CONFIG)/bin/libpcre.out
endif
DEPS_86 += $(CONFIG)/inc/http.h
DEPS_86 += $(CONFIG)/obj/httpLib.o
DEPS_86 += $(CONFIG)/bin/libhttp.out
DEPS_86 += $(CONFIG)/inc/appweb.h
DEPS_86 += $(CONFIG)/inc/customize.h
DEPS_86 += $(CONFIG)/obj/config.o
DEPS_86 += $(CONFIG)/obj/convenience.o
DEPS_86 += $(CONFIG)/obj/dirHandler.o
DEPS_86 += $(CONFIG)/obj/fileHandler.o
DEPS_86 += $(CONFIG)/obj/log.o
DEPS_86 += $(CONFIG)/obj/server.o
DEPS_86 += $(CONFIG)/bin/libappweb.out
DEPS_86 += src/server/slink.c
DEPS_86 += $(CONFIG)/inc/esp.h
DEPS_86 += $(CONFIG)/obj/slink.o
DEPS_86 += $(CONFIG)/bin/libslink.out
DEPS_86 += $(CONFIG)/obj/appweb.o

$(CONFIG)/bin/appweb.out: $(DEPS_86)
	@echo '      [Link] $(CONFIG)/bin/appweb.out'
	$(CC) -o $(CONFIG)/bin/appweb.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/appweb.o" $(LIBS) -Wl,-r 

#
#   server-cache
#
src/server/cache: $(DEPS_87)
	( \
	cd src/server; \
	mkdir -p cache ; \
	)

#
#   testAppweb.h
#
$(CONFIG)/inc/testAppweb.h: $(DEPS_88)
	@echo '      [Copy] $(CONFIG)/inc/testAppweb.h'
	mkdir -p "$(CONFIG)/inc"
	cp test/src/testAppweb.h $(CONFIG)/inc/testAppweb.h

#
#   testAppweb.o
#
DEPS_89 += $(CONFIG)/inc/bit.h
DEPS_89 += $(CONFIG)/inc/testAppweb.h
DEPS_89 += $(CONFIG)/inc/mpr.h
DEPS_89 += $(CONFIG)/inc/http.h

$(CONFIG)/obj/testAppweb.o: \
    test/src/testAppweb.c $(DEPS_89)
	@echo '   [Compile] $(CONFIG)/obj/testAppweb.o'
	$(CC) -c -o $(CONFIG)/obj/testAppweb.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" test/src/testAppweb.c

#
#   testHttp.o
#
DEPS_90 += $(CONFIG)/inc/bit.h
DEPS_90 += $(CONFIG)/inc/testAppweb.h

$(CONFIG)/obj/testHttp.o: \
    test/src/testHttp.c $(DEPS_90)
	@echo '   [Compile] $(CONFIG)/obj/testHttp.o'
	$(CC) -c -o $(CONFIG)/obj/testHttp.o $(CFLAGS) $(DFLAGS) "-I$(CONFIG)/inc" "-I$(WIND_BASE)/target/h" "-I$(WIND_BASE)/target/h/wrn/coreip" test/src/testHttp.c

#
#   testAppweb
#
DEPS_91 += $(CONFIG)/inc/mpr.h
DEPS_91 += $(CONFIG)/inc/bit.h
DEPS_91 += $(CONFIG)/inc/bitos.h
DEPS_91 += $(CONFIG)/obj/mprLib.o
DEPS_91 += $(CONFIG)/bin/libmpr.out
DEPS_91 += $(CONFIG)/inc/pcre.h
DEPS_91 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_91 += $(CONFIG)/bin/libpcre.out
endif
DEPS_91 += $(CONFIG)/inc/http.h
DEPS_91 += $(CONFIG)/obj/httpLib.o
DEPS_91 += $(CONFIG)/bin/libhttp.out
DEPS_91 += $(CONFIG)/inc/appweb.h
DEPS_91 += $(CONFIG)/inc/customize.h
DEPS_91 += $(CONFIG)/obj/config.o
DEPS_91 += $(CONFIG)/obj/convenience.o
DEPS_91 += $(CONFIG)/obj/dirHandler.o
DEPS_91 += $(CONFIG)/obj/fileHandler.o
DEPS_91 += $(CONFIG)/obj/log.o
DEPS_91 += $(CONFIG)/obj/server.o
DEPS_91 += $(CONFIG)/bin/libappweb.out
DEPS_91 += $(CONFIG)/inc/testAppweb.h
DEPS_91 += $(CONFIG)/obj/testAppweb.o
DEPS_91 += $(CONFIG)/obj/testHttp.o

$(CONFIG)/bin/testAppweb.out: $(DEPS_91)
	@echo '      [Link] $(CONFIG)/bin/testAppweb.out'
	$(CC) -o $(CONFIG)/bin/testAppweb.out $(LDFLAGS) $(LIBPATHS) "$(CONFIG)/obj/testAppweb.o" "$(CONFIG)/obj/testHttp.o" $(LIBS) -Wl,-r 

ifeq ($(BIT_PACK_CGI),1)
#
#   test-testScript
#
DEPS_92 += $(CONFIG)/inc/mpr.h
DEPS_92 += $(CONFIG)/inc/bit.h
DEPS_92 += $(CONFIG)/inc/bitos.h
DEPS_92 += $(CONFIG)/obj/mprLib.o
DEPS_92 += $(CONFIG)/bin/libmpr.out
DEPS_92 += $(CONFIG)/inc/pcre.h
DEPS_92 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_92 += $(CONFIG)/bin/libpcre.out
endif
DEPS_92 += $(CONFIG)/inc/http.h
DEPS_92 += $(CONFIG)/obj/httpLib.o
DEPS_92 += $(CONFIG)/bin/libhttp.out
DEPS_92 += $(CONFIG)/inc/appweb.h
DEPS_92 += $(CONFIG)/inc/customize.h
DEPS_92 += $(CONFIG)/obj/config.o
DEPS_92 += $(CONFIG)/obj/convenience.o
DEPS_92 += $(CONFIG)/obj/dirHandler.o
DEPS_92 += $(CONFIG)/obj/fileHandler.o
DEPS_92 += $(CONFIG)/obj/log.o
DEPS_92 += $(CONFIG)/obj/server.o
DEPS_92 += $(CONFIG)/bin/libappweb.out
DEPS_92 += $(CONFIG)/inc/testAppweb.h
DEPS_92 += $(CONFIG)/obj/testAppweb.o
DEPS_92 += $(CONFIG)/obj/testHttp.o
DEPS_92 += $(CONFIG)/bin/testAppweb.out

test/cgi-bin/testScript: $(DEPS_92)
	( \
	cd test; \
	echo '#!../$(CONFIG)/bin/cgiProgram.out' >cgi-bin/testScript ; chmod +x cgi-bin/testScript ; \
	)
endif

ifeq ($(BIT_PACK_CGI),1)
#
#   test-cache.cgi
#
DEPS_93 += $(CONFIG)/inc/mpr.h
DEPS_93 += $(CONFIG)/inc/bit.h
DEPS_93 += $(CONFIG)/inc/bitos.h
DEPS_93 += $(CONFIG)/obj/mprLib.o
DEPS_93 += $(CONFIG)/bin/libmpr.out
DEPS_93 += $(CONFIG)/inc/pcre.h
DEPS_93 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_93 += $(CONFIG)/bin/libpcre.out
endif
DEPS_93 += $(CONFIG)/inc/http.h
DEPS_93 += $(CONFIG)/obj/httpLib.o
DEPS_93 += $(CONFIG)/bin/libhttp.out
DEPS_93 += $(CONFIG)/inc/appweb.h
DEPS_93 += $(CONFIG)/inc/customize.h
DEPS_93 += $(CONFIG)/obj/config.o
DEPS_93 += $(CONFIG)/obj/convenience.o
DEPS_93 += $(CONFIG)/obj/dirHandler.o
DEPS_93 += $(CONFIG)/obj/fileHandler.o
DEPS_93 += $(CONFIG)/obj/log.o
DEPS_93 += $(CONFIG)/obj/server.o
DEPS_93 += $(CONFIG)/bin/libappweb.out
DEPS_93 += $(CONFIG)/inc/testAppweb.h
DEPS_93 += $(CONFIG)/obj/testAppweb.o
DEPS_93 += $(CONFIG)/obj/testHttp.o
DEPS_93 += $(CONFIG)/bin/testAppweb.out

test/web/caching/cache.cgi: $(DEPS_93)
	( \
	cd test; \
	echo "#!`type -p ejs`" >web/caching/cache.cgi ; \
	echo 'print("HTTP/1.0 200 OK\nContent-Type: text/plain\n\n{number:" + Date().now() + "}\n")' >>web/caching/cache.cgi ; \
	chmod +x web/caching/cache.cgi ; \
	)
endif

ifeq ($(BIT_PACK_CGI),1)
#
#   test-basic.cgi
#
DEPS_94 += $(CONFIG)/inc/mpr.h
DEPS_94 += $(CONFIG)/inc/bit.h
DEPS_94 += $(CONFIG)/inc/bitos.h
DEPS_94 += $(CONFIG)/obj/mprLib.o
DEPS_94 += $(CONFIG)/bin/libmpr.out
DEPS_94 += $(CONFIG)/inc/pcre.h
DEPS_94 += $(CONFIG)/obj/pcre.o
ifeq ($(BIT_PACK_PCRE),1)
    DEPS_94 += $(CONFIG)/bin/libpcre.out
endif
DEPS_94 += $(CONFIG)/inc/http.h
DEPS_94 += $(CONFIG)/obj/httpLib.o
DEPS_94 += $(CONFIG)/bin/libhttp.out
DEPS_94 += $(CONFIG)/inc/appweb.h
DEPS_94 += $(CONFIG)/inc/customize.h
DEPS_94 += $(CONFIG)/obj/config.o
DEPS_94 += $(CONFIG)/obj/convenience.o
DEPS_94 += $(CONFIG)/obj/dirHandler.o
DEPS_94 += $(CONFIG)/obj/fileHandler.o
DEPS_94 += $(CONFIG)/obj/log.o
DEPS_94 += $(CONFIG)/obj/server.o
DEPS_94 += $(CONFIG)/bin/libappweb.out
DEPS_94 += $(CONFIG)/inc/testAppweb.h
DEPS_94 += $(CONFIG)/obj/testAppweb.o
DEPS_94 += $(CONFIG)/obj/testHttp.o
DEPS_94 += $(CONFIG)/bin/testAppweb.out

test/web/auth/basic/basic.cgi: $(DEPS_94)
	( \
	cd test; \
	echo "#!`type -p ejs`" >web/auth/basic/basic.cgi ; \
	echo 'print("HTTP/1.0 200 OK\nContent-Type: text/plain\n\n" + serialize(App.env, {pretty: true}) + "\n")' >>web/auth/basic/basic.cgi ; \
	chmod +x web/auth/basic/basic.cgi ; \
	)
endif

ifeq ($(BIT_PACK_CGI),1)
#
#   test-cgiProgram
#
DEPS_95 += $(CONFIG)/inc/bit.h
DEPS_95 += $(CONFIG)/obj/cgiProgram.o
DEPS_95 += $(CONFIG)/bin/cgiProgram.out

test/cgi-bin/cgiProgram.out: $(DEPS_95)
	( \
	cd test; \
	cp ../$(CONFIG)/bin/cgiProgram.out cgi-bin/cgiProgram.out ; \
	cp ../$(CONFIG)/bin/cgiProgram.out cgi-bin/nph-cgiProgram.out ; \
	cp ../$(CONFIG)/bin/cgiProgram.out 'cgi-bin/cgi Program.out' ; \
	cp ../$(CONFIG)/bin/cgiProgram.out web/cgiProgram.cgi ; \
	chmod +x cgi-bin/* web/cgiProgram.cgi ; \
	)
endif

#
#   installBinary
#
installBinary: $(DEPS_96)

#
#   install
#
DEPS_97 += compile
DEPS_97 += installBinary

install: $(DEPS_97)


#
#   uninstall
#
DEPS_98 += build
DEPS_98 += compile

uninstall: $(DEPS_98)
	( \
	cd package; \
	rm -f "$(BIT_VAPP_PREFIX)/appweb.conf" ; \
	rm -f "$(BIT_VAPP_PREFIX)/esp.conf" ; \
	rm -f "$(BIT_VAPP_PREFIX)/mine.types" ; \
	rm -f "$(BIT_VAPP_PREFIX)/install.conf" ; \
	rm -fr "$(BIT_VAPP_PREFIX)/inc/appweb" ; \
	)

#
#   genslink
#
genslink: $(DEPS_99)
	( \
	cd src/server; \
	esp --static --genlink slink.c compile ; \
	)


#
#   run
#
DEPS_100 += compile

run: $(DEPS_100)
	( \
	cd src/server; \
	sudo ../../$(CONFIG)/bin/appweb -v ; \
	)

