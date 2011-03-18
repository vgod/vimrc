projects = latex-suite latex-suite-quickstart
htmlfiles = $(addsuffix .html, $(projects))
txtfiles = $(addsuffix .txt, $(projects))
cssfiles = $(addsuffix .css, $(projects))
all = $(projects) $(htmlfiles) $(cssfiles) $(txtfiles) 


xsltproc=xsltproc
db2vim=../../db2vim/db2vim

# Use for debugging:
#xsltproc=strace -e trace=file xsltproc --nonet --load-trace 
# export XML_DEBUG_CATALOG = 1

# Specify local catalog to not use system installed dtd/xsl files
# export XML_CATALOG_FILES=catalog.xml

# User configuration of this Makefile goes into Makefile.local
# E.g. to use a catalog file installed by the user.
-include Makefile.local

# Default Target is to create all documentation files
all: $(all)

# create multi page html (chunk xhtml)
$(projects): %: %.xml latex-suite-chunk.xsl latex-suite-common.xsl
	$(xsltproc) -o $@/ latex-suite-chunk.xsl $<

# create single html files
$(htmlfiles): %.html: %.xml latex-suite.xsl latex-suite-common.xsl
	$(xsltproc) -o $@ latex-suite.xsl $<

# create vim flat files
latex-suite.txt: %.txt: %.xml
	$(db2vim) --prefix=ls_ $< > $@

latex-suite-quickstart.txt: %.txt: %.xml
	$(db2vim) --prefix=lq_ $< > $@

# validate xml
validate:
	for file in *.xml; do \
		xmllint --valid --noout $$file; \
	done

clean:
	rm -f $(htmlfiles)
	rm -rf $(projects)

# $(txtfiles) are currently in revision control, therefore they are not
# removed in the clean target
mr-proper: clean
	rm -f $(txtfiles)

upload: $(all)
# vim-latex-web is configured in ~/.ssh/config
#Host vim-latex-web
#    Hostname  web.sourceforge.net
#    User SOURCEFORGE_USERNAME,vim-latex
	rsync --perms --chmod g+w,o-w --delete -lrtvz  $(all) vim-latex-web:/home/groups/v/vi/vim-latex/htdocs/documentation/

# vim:nowrap
