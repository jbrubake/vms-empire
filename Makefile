# %W% %G% %U% - (c) Copyright 1987, 1988 Chuck Simmons

#
#    Copyright (C) 1987, 1988 Chuck Simmons
#
# See the file COPYING, distributed with empire, for restriction
# and warranty information.

# Change the line below for your system.  If you are on a Sun or Vax,
# you may want BSD.

#SYS = BSD
SYS = SYSV

# Use -g to compile the program for debugging.

DEBUG = -g -DDEBUG
#DEBUG = -O

# Use -p to profile the program.
#PROFILE = -p -DPROFILE
PROFILE =

# Define all necessary libraries.  'curses' is necessary.  'termcap'
# is needed on BSD systems.
LIBS = -ldcurses
#LIBS = -lcurses -ltermcap

# You shouldn't have to modify anything below this line.

CFLAGS = $(DEBUG) $(PROFILE) -D$(SYS)
INS   = /etc/install

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

SHARFILES = COPYING $(FILES) bugs README makefile empire.6 empire.h extern.h

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

all: empire

empire: $(OFILES)
	$(CC) $(PROFILE) -o empire $(OFILES) $(LIBS)

lint: $(FILES)
	lint -u -D$(SYS) $(FILES) -lcurses

clean:
	rm -f *.o

clobber: clean
	rm -f empire

sharsplit: $(SHARFILES)
	sharsplit -m -r -o empire $(SHARFILES)

install: empire
	$(INS) -o -f /usr/local/games empire

installman: empire.6
	$(INS) -f /usr/local/man/man6 empire.6
