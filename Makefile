TARGET			= svsim

SRCDIR			= src
BUILDDIR		= build

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
	$(YACC) --color=always -Wcounterexamples -v -d $< -o $@
clean				:
	rm -rf $(TARGET) $(BUILDDIR) *.dSYM
