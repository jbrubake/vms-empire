#
#    Copyright (C) 1987, 1988 Chuck Simmons
#
# See the file COPYING, distributed with empire, for restriction
# and warranty information.

VERS=1.12

# Use -g to compile the program for debugging.
#DEBUG = -g -DDEBUG
DEBUG = -O2

# Use -p to profile the program.
#PROFILE = -p -DPROFILE
PROFILE =

LIBS = -lncurses

# You shouldn't have to modify anything below this line.

# There's a dynamic format in the object-display routines; suppress the warning
CFLAGS = $(DEBUG) $(PROFILE) -Wall -Wno-format-security

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

attack.o:: extern.h empire.h
compmove.o:: extern.h empire.h
data.o:: empire.h
display.o:: extern.h empire.h
edit.o:: extern.h empire.h
empire.o:: extern.h empire.h
game.o:: extern.h empire.h
main.o:: extern.h empire.h
map.o:: extern.h empire.h
math.o:: extern.h empire.h
object.o:: extern.h empire.h
term.o:: extern.h empire.h
usermove.o:: extern.h empire.h
util.o:: extern.h empire.h

empire.6: vms-empire.xml
	xmlto man vms-empire.xml

vms-empire.html: vms-empire.xml
	xmlto html-nochunks vms-empire.xml

TAGS: $(HEADERS) $(FILES)
	etags $(HEADERS) $(FILES)

lint: $(FILES)
	lint -u -D$(SYS) $(FILES) -lcurses

# cppcheck should run clean
cppcheck:
	cppcheck --inline-suppr --suppress=unusedStructMember --suppress=unusedFunction  --template gcc --enable=all --force *.[ch]

clean:
	rm -f *.o TAGS vms-empire
	rm -f *.6 *.html

clobber: clean
	rm -f vms-empire vms-empire-*.tar*

SOURCES = README HACKING NEWS control empire.6 vms-empire.xml COPYING Makefile BUGS AUTHORS $(FILES) $(HEADERS) empire-logo.png empire.desktop

vms-empire-$(VERS).tar.gz: $(SOURCES)
	@ls $(SOURCES) | sed s:^:vms-empire-$(VERS)/: >MANIFEST
	@(cd ..; ln -s vms-empire vms-empire-$(VERS))
	(cd ..; tar -czf vms-empire/vms-empire-$(VERS).tar.gz `cat vms-empire/MANIFEST`)
	@(cd ..; rm vms-empire-$(VERS))

dist: vms-empire-$(VERS).tar.gz

release: vms-empire-$(VERS).tar.gz vms-empire.html
	shipper version=$(VERS) | sh -e -x
