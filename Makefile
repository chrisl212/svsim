TARGET			= ./svsim

SRCDIR			= src
BUILDDIR		= build
TESTDIR			= tests

LEX				= flex
YACC			= bison
CC				= gcc
CFLAGS			= -g -I/usr/local/opt/flex/include -I$(SRCDIR) -I$(BUILDDIR)
LDFLAGS			= -L/usr/local/opt/flex/lib -lfl

CSRC			= $(shell find $(SRCDIR) -iname \*.c)
COBJ			= $(patsubst $(SRCDIR)/%.c, $(BUILDDIR)/%.o, $(CSRC))
LSRC			= $(shell find $(SRCDIR) -iname \*.l)
LOBJ			= $(patsubst $(SRCDIR)/%.l, $(BUILDDIR)/%.yy.c, $(LSRC))
YSRC			= $(shell find $(SRCDIR) -iname \*.y)
YOBJ			= $(patsubst $(SRCDIR)/%.y, $(BUILDDIR)/%.tab.c, $(YSRC))
TESTIN			= $(shell find $(TESTDIR) -iname \*.sv)
TESTOUT			= $(patsubst $(TESTDIR)/%.sv, $(TESTDIR)/%.out, $(TESTIN))

.PHONY				: all clean

all					: $(TARGET)
$(TARGET)			: $(COBJ)
	$(CC) $(CFLAGS) $(COBJ) $(LOBJ) $(YOBJ) $(LDFLAGS) -o $@
$(BUILDDIR)/%.o		: $(SRCDIR)/%.c $(LOBJ)
	mkdir -p $(@D)
	$(CC) -c $(CFLAGS) $< -o $@
$(BUILDDIR)/%.yy.c	: $(SRCDIR)/%.l $(YOBJ)
	mkdir -p $(@D)
	$(LEX) -o $@ $<
$(BUILDDIR)/%.tab.c	: $(SRCDIR)/%.y
	mkdir -p $(@D)
	$(YACC) --color=always -v -d $< -o $@
test				: $(TESTOUT)
$(TESTDIR)/%.out	: $(TESTDIR)/%.sv $(TARGET)
	@cat $< | $(TARGET) > $@ 2>&1 && echo "\033[0;32mTest $< passed\033[0m" || echo "\033[0;31mTest $< failed\033[0m"
clean				:
	rm -rf $(TARGET) $(BUILDDIR) $(TESTOUT) *.dSYM
