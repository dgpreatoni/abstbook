@ECHO OFF
REM ECHO Making session summaries
REM CALL R CMD BATCH --vanilla scripts\make_summary.R
ECHO calling PDFLaTeX
pdflatex -synctex=1 -interaction=nonstopmode main.tex
pdflatex -synctex=1 -interaction=nonstopmode main.tex
pdflatex -synctex=1 -interaction=nonstopmode main.tex
pdflatex -synctex=1 -interaction=nonstopmode main.tex
makeindex main.idx
pdflatex -synctex=1 -interaction=nonstopmode main.tex
pdflatex -synctex=1 -interaction=nonstopmode main.tex