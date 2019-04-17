@ECHO OFF
ECHO Making cover
cd frontmatter
pdflatex -synctex=1 -interaction=nonstopmode GIRC2015_cover.tex
pdftk GIRC2015_cover.pdf cat 1-2 output cover_front.pdf dont_ask
pdftk GIRC2015_cover.pdf cat 3-4 output cover_back.pdf dont_ask
ECHO Making spine
pdflatex -synctex=1 -interaction=nonstopmode spine_A4.tex
ECHO Making front matter
pdflatex -synctex=1 -interaction=nonstopmode GIRC2015_frontmatter.tex
pdflatex -synctex=1 -interaction=nonstopmode GIRC2015_frontmatter.tex
cd ..\abstbook
CALL make_abstbook.bat
cd ..
ECHO Assembling book
pdftk frontmatter/GIRC2015_frontmatter.pdf abstbook/main.pdf cat output GIRC2015_nocover.pdf dont_ask
pdftk frontmatter/cover_front.pdf GIRC2015_nocover.pdf frontmatter/cover_back.pdf cat output GIRC2015_complete.pdf dont_ask
ECHO Book is ready.
