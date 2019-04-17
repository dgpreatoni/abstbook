THIS README HAS TO BE COMPLETELY REWRITTEN




Some pointers on abstrat booklets...

http://ctan.mirror.garr.it/mirrors/CTAN/macros/latex/contrib/misc/abstbook.cls

http://tug.org/pipermail/macostex-archives/2004-March/005037.html
http://www.iciam07.ch/ICIAM07-AbstractBook1.pdf


I decided to start from the abstbook class, modifying it to use KOMA-script scrreprt (since articles already rely on scrartcl)

Note that the new hysabstract.cls class is intended to typeset just the "mainmatter" of an abstract booklet. Actually, one can have just a single LaTeX source for an abstracts booklet, but "the Hystrix way" works lihe that:
- cover: is made using cover.tex (based on memoir) using files in the 'frontmatter' directory of an issue.
- front matter: is made using frontmatter.tex (based on memoir) using files in the 'frontmatter' directory of an issue.
- spine: is made using spine.tex, in the 'frontmatter' folder as well.

This means that you'll have an Hystrix abstract booklet (supplement issue) source tree organised like that:
<issue root directory>
     |         +---- main.tex (the master file that includes abstracts and outputs the abstract booklet)
     |         +---- test.tex (a bare-bones version of the master file, used to compile a single abstract)
     +---- frontmatter (all the stuff needed for cover, frontmatter and spine, like any standard Hystrix issue)
     |         +---- cover.tex
     |         +---- frontmatter.tex
     +---- abstracts
     |         +----(single abstracts, each one as a separate .tex file to be included in main.tex)
     |
     
     
How to compile the abstract booklet

Cover: compile cover.tex in the frontmatter directory. Copy cover.pdf in the root directory.

Frontmatter: compile frontmatter.tex in the frontmatter directory. Copy frontmatter.pdf in the root directory.

Spine: fix spine width, then compile spine.tex. Copy spine.pdf in the root direcroty.

Main matter:
Open the abstracts_list_driver.xls file, make sure that all authors, titles, session name and source file name are OK.
Run the R script make_summary.R, is in the scripts directory.
