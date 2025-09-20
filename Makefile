.PHONY: all render pdf bib clean distclean

TEX := main
LATEXMK := latexmk
PDFLATEX := pdflatex
BIBER := biber
LATEXMK_OPTS := -pdf -interaction=nonstopmode -file-line-error

all: pdf

# Render LaTeX from Jinja2 + YAML
render: cv.yaml main.tex.j2
	uv run python render.py

# Build PDF using latexmk and biber (auto)
pdf: render
	$(LATEXMK) $(LATEXMK_OPTS) -e '$$bibtex=q/biber %O %S/' $(TEX).tex

# Explicit biber pipeline: pdflatex -> biber -> pdflatex x2
bib: render
	$(PDFLATEX) -interaction=nonstopmode -file-line-error $(TEX).tex
	$(BIBER) $(TEX)
	$(PDFLATEX) -interaction=nonstopmode -file-line-error $(TEX).tex
	$(PDFLATEX) -interaction=nonstopmode -file-line-error $(TEX).tex

clean:
	$(LATEXMK) -c

distclean: clean
	rm -f $(TEX).pdf $(TEX).bbl $(TEX).bcf

