# Short name for documentation (used for PNG documentation file name)
NAME=autostrap

# Destination directory. Defaults to "site/" (must match site_dir in mkdocs.yml
# if set there).
DESTDIR=site

# Documentation source directory. Defaults to "docs/". (must match docs_dir in
# mkdocs.yml if set there).
DOCDIR=docs

.PHONY: all dotclean

MD := $(shell find $(DOCDIR) -name '*.md')                         # All markdown source files (dependency for all target)
DOT := $(shell find $(DOCDIR) -name '*.dot')                       # dot source in docs/
DOTSITE := $(patsubst $(DOCDIR)/%, $(DESTDIR)/%, $(DOT))           # dot source that mkdocs copies to site/ (cleaned after build)
SVG := $(patsubst $(DOCDIR)/%.dot, $(DESTDIR)/%.svg, $(DOT))       # dot generated SVG files in site/
PNG := $(patsubst $(DOCDIR)%.dot, $(DESTDIR)%.png, $(DOT))         # dot generated PNG figures

# Compile dot figures to SVG for web/epub use
$(DESTDIR)/%.svg: $(DOCDIR)/%.dot
	dot -Tsvg -o$@ $< 
	rm -f $(patsubst %.svg, %.dot, $@)

# Compile dot figures to PNG for pandoc PNG generator (since it uses pnglatex)
$(DESTDIR)/%.png: $(DOCDIR)/%.dot $(DOCDIR) 
	dot -Tpng -o$@ $< 

all: $(DESTDIR)/index.html $(SVG) destclean $(DESTDIR)/$(NAME).pdf $(DESTDIR)/$(NAME).epub $(DESTDIR)/$(NAME).mobi

clean:
	rm -rf $(DESTDIR)
	rm -f pandoc-svg.md
	rm -f pandoc-png.md

destclean: $(DESTDIR)/index.html

img:
	mkdir img

pandoc-png.md: $(MD) $(PNG)
	mkdocs2pandoc --exclude macros.md --image-ext png | \
	  cat - $(DOCDIR)/macros.md > $@

pandoc-svg.md: $(MD) $(SVG)
	mkdocs2pandoc --exclude macros.md --image-ext svg | \
	  cat - $(DOCDIR)/macros.md > $@

$(DESTDIR)/index.html: $(MD) mkdocs.yml
	mkdocs build -c -d $(DESTDIR)
	echo $(DOTPNG)

$(DESTDIR)/$(NAME).pdf: pandoc-png.md
	pandoc --toc -f markdown+grid_tables+table_captions -o $@ $<

$(DESTDIR)/$(NAME).epub: pandoc-svg.md
	pandoc --toc -f markdown+grid_tables -t epub -o $@ $<

$(DESTDIR)/$(NAME).mobi: $(DESTDIR)/$(NAME).epub
	ebook-convert $< $@
