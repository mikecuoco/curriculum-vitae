# Mike's Curriculum Vitae and Resume

![Build](https://github.com/mikecuoco/curriculum-vitae/actions/workflows/build-cv.yaml/badge.svg)

This repository contains my academic CV and industry resume, built from YAML data and Jinja2 templates.

## Building

### Prerequisites
- [uv](https://docs.astral.sh/uv/) (Python package manager)
- LaTeX distribution (TeX Live, MacTeX, etc.)
- `latexmk`, `biber`, and standard LaTeX packages

### Quick Start

Build the full academic CV:
```bash
make cv
```

Build the one-page resume:
```bash
make resume
```

Build both:
```bash
make cv resume
```

### How it works

1. **Data** is stored in `cv.yaml`
2. **Templates** are written in Jinja2: `cv.tex.j2` (full CV) and `resume.tex.j2` (one-page resume)
3. **Rendering** happens via `render.py`, which generates `.tex` files from templates
4. **Building** uses `latexmk` with `biber` for bibliography management

### Makefile targets

- `make cv` - Render and build `cv.pdf` from `cv.tex.j2`
- `make resume` - Render and build `resume.pdf` from `resume.tex.j2`
- `make clean` - Remove auxiliary build files
- `make distclean` - Remove all generated PDFs and build artifacts

### Manual build

If you need to build manually:
```bash
# Render template
uv run python render.py cv

# Build PDF
latexmk -pdf -interaction=nonstopmode cv.tex
```

## Testing locally with act

Test the GitHub Actions workflow locally:
```bash
act -j build-cv -P ubuntu-latest=catthehacker/ubuntu:act-latest --env ACT=true
```

## TODO

- [ ] Add conference talks and posters
