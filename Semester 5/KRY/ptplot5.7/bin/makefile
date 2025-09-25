ME =		bin
ROOT =		..
CONFIG =	$(ROOT)/mk/ptII.mk
include $(CONFIG)
SHELL_FILES = \
	histogram \
	ptplot \
	pxgraph
# DOS batch files
BAT_FILES = \
	histogram.bat \
	ptplot.bat \
	pxgraph.bat 

EXTRA_SRCS = \
	ptinvoke.in \
	$(BAT_FILES)

all: ptinvoke $(BAT_FILES)
	-chmod a+x ptinvoke
	rm -f histogram
	ln -s ptinvoke histogram
	rm -f ptplot
	ln -s ptinvoke ptplot
	rm -f pxgraph
	ln -s ptinvoke pxgraph

install: all
	-chmod a+x $(SHELL_FILES) $(BAT_FILES)

ptinvoke: ptinvoke.in ../config.status
	(cd ..; ./config.status)
# zip might not get the permissions of configure right, so we run /bin/sh
../config.status: ../configure
	(cd ..; /bin/sh ./configure)

makebat: ptinvoke
	rm -f makebat
	ln -s ptinvoke makebat

$(BAT_FILES): makebat
	rm -f "fixtmpdist"
	./makebat -q "`basename fixtmpdist .bat`"

# Get the rest of the rules
include $(ROOT)/mk/ptcommon.mk
