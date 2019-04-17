pdftk ../../frontmatter/GIRC2015_cover.pdf cat 1-2 output ../../frontmatter/GIRC2015_cover_front.pdf
pdftk ../../frontmatter/GIRC2015_cover.pdf cat 4 output ../../frontmatter/GIRC2015_cover_back.pdf
pdftk ../../frontmatter/GIRC2015_cover_front.pdf ../../frontmatter/GIRC2015_frontmatter.pdf ../main.pdf ../../frontmatter/GIRC2015_cover_back.pdf cat output ../GIRC2015_abstract_book.pdf