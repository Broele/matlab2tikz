# ./Makefile

ECHOCMD:=/bin/echo -e
LATEX:=lualatex --shell-escape

TARGET:=acid

main:
	cd ../data/reference/; make
	cd ../data/converted/; make
	@$(LATEX) $(TARGET)

.PHONY: clean

clean:
	@rm -f $(TARGET).aux \
	$(TARGET).log \
	$(TARGET).nav \
	$(TARGET).out \
	$(TARGET).snm \
	$(TARGET).toc \
	$(TARGET).vrb \
	$(TARGET).pdf \
	$(TARGET).dvi \
	$(TARGET).ps \
	missfont.log
	@rm -f *~
	cd ../data/reference/; make clean
	cd ../data/converted/; make clean

distclean: clean
	@rm -f $(TARGET).tex
	cd ../data/reference/; make distclean
	cd ../data/converted/; make distclean
