.PHONY: all cv resume render pdf bib clean distclean

TEX := cv
LATEXMK := latexmk
PDFLATEX := pdflatex
BIBER := biber
LATEXMK_OPTS := -pdf -interaction=nonstopmode -file-line-error

all: cv

# Build CV (cv.tex)
cv: TEX = cv
cv: render pdf

# Build Resume (resume.tex)
resume: TEX = resume
resume: render pdf

# Render LaTeX from Jinja2 + YAML
render: data.yaml $(TEX).tex.j2
	uv run python render.py $(TEX)

# Build PDF using latexmk and biber (auto)
pdf:
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
	rm -f cv.pdf cv.bbl cv.bcf resume.pdf resume.bbl resume.bcf

