# %W% %G% %U% - (c) Copyright 1987, 1988 Chuck Simmons

#
#    Copyright (C) 1987, 1988 Chuck Simmons
#
# See the file COPYING, distributed with empire, for restriction
# and warranty information.

VERS=$(shell sed <vms-empire.spec -n -e '/Version: \(.*\)/s//\1/p')

# Change the line below for your system.  If you are on a Sun or Vax,
# you may want BSD.

SYS = LINUX
#SYS = BSD
#SYS = SYSV

# Use -g to compile the program for debugging.

#DEBUG = -g -DDEBUG -Wall
DEBUG = -O2

# Use -p to profile the program.
#PROFILE = -p -DPROFILE
PROFILE =

LIBS = -lncurses

# You shouldn't have to modify anything below this line.

CFLAGS = $(DEBUG) $(PROFILE) -D$(SYS)

FILES = \
	attack.c \
	compmove.c \
	data.c \
	display.c \
	edit.c \
	empire.c \
	game.c \
	main.c \
	map.c \
	math.c \
	object.c \
	term.c \
	usermove.c \
	util.c

HEADERS = empire.h extern.h

OFILES = \
	attack.o \
	compmove.o \
	data.o \
	display.o \
	edit.o \
	empire.o \
	game.o \
	main.o \
	map.o \
	math.o \
	object.o \
	term.o \
	usermove.o \
	util.o

all: vms-empire

vms-empire: $(OFILES)
	$(CC) $(PROFILE) -o vms-empire $(OFILES) $(LIBS)

TAGS: $(HEADERS) $(FILES)
	etags $(HEADERS) $(FILES)

lint: $(FILES)
	lint -u -D$(SYS) $(FILES) -lcurses

clean:
	rm -f *.o TAGS vms-empire

clobber: clean
	rm -f vms-empire vms-empire-*.tar*

SOURCES = README NEWS vms-empire.6 COPYING Makefile BUGS AUTHORS $(FILES) $(HEADERS) MANIFEST vms-empire.spec

vms-empire-$(VERS).tar.gz: $(SOURCES) vms-empire.6
	@ls $(SOURCES) | sed s:^:vms-empire-$(VERS)/: >MANIFEST
	@(cd ..; ln -s vms-empire vms-empire-$(VERS))
	(cd ..; tar -czvf vms-empire/vms-empire-$(VERS).tar.gz `cat vms-empire/MANIFEST`)
	@(cd ..; rm vms-empire-$(VERS))

dist: vms-empire-$(VERS).tar.gz

release: vms-empire-$(VERS).tar.gz
	shipper -f; rm -f CHANGES ANNOUNCE* *.6 *.html *.rpm *.lsm MANIFEST
