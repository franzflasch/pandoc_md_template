BASEDIR=$(CURDIR)
INPUTDIR=$(BASEDIR)/source
OUTPUTDIR=$(BASEDIR)/output
STYLEDIR=$(INPUTDIR)/style

help:
	@echo ' 																	  '
	@echo 'Makefile for the Markdown Pandoc                                       '
	@echo '                                                                       '
	@echo 'Usage:                                                                 '
	@echo '   make html                    (re)generate the web site              '
	@echo '   make pdf                     generate a PDF file  			      '
	@echo '   make docx	                   generate a Docx file 			      '
	@echo '   make tex	                   generate a tex file 			          '
	@echo '                                                                       '
	@echo 'Set the DEBUG variable to 1 to enable debugging, e.g. make DEBUG=1 html'
	@echo ' 																	  '
	@echo 'pandoc test.md -o test.pdf --bibliography=test_ref.bib --csl=plos.csl  '
	@echo ' 																	  '
	@echo 'get templates from: https://github.com/jgm/pandoc-templates			  '

prepare:
	mkdir -p $(OUTPUTDIR)

pdf: prepare
	pandoc -s -f markdown-auto_identifiers \
	"$(INPUTDIR)"/*.md \
	-o "$(OUTPUTDIR)/output_doc.pdf" \
	--template="$(STYLEDIR)/template.tex" \
	--latex-engine=xelatex

tex: prepare
	pandoc -s \
	"$(INPUTDIR)"/*.md \
	-o "$(OUTPUTDIR)/output_doc.tex" \
	--template="$(STYLEDIR)/template.tex" \
	--latex-engine=xelatex

docx: prepare
	pandoc "$(INPUTDIR)"/*.md \
	-o "$(OUTPUTDIR)/output_doc.docx" \

html: prepare
	pandoc "$(INPUTDIR)"/*.md \
	-o "$(OUTPUTDIR)/output_doc.html"

.PHONY: help pdf docx html tex prepare
