# Makefile for csvtable
#
# (c) 2024 Wolfgang Friebel

VERSION=$(shell grep "VERSION=" csvtable | sed 's/.*=//;s/;//')

.PHONY: help clean install

PREFIX ?= $(DESTDIR)/usr/local
BINDIR = $(PREFIX)/bin
MANDIR = $(PREFIX)/man/man1

help:
	@echo Usage:
	@echo "make install	- install binaries into the official directories"
	@echo "make uninstall	- uninstall binaries from the official directories"
	@echo "make help	- prints this help"
	@echo "make dist	- makes a distribution tarball"
	@echo "make test	- shows test output
	@echo

test: csvtable
	./csvtable test/num.csv
	./csvtable test/utf8.csv

install:
	install -m 755 -d $(BINDIR) $(MANDIR)
	install -m 755 csvtable $(BINDIR)
	install -m 644 csvtable.1 $(MANDIR)

uninstall:
	rm $(BINDIR)/csvtable
	rm $(MANDIR)/csvtable.1

clean:
	rm -f *.tar.gz

dist: clean
	@git archive --format=tar.gz --prefix=csvtable-$(VERSION)/ \
	-o csvtable-$(VERSION).tar.gz HEAD
	@echo "Done."

