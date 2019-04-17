A LaTeX + R set-up to handle abstracts for a conference and produce an abstracts booklet.

This particular concoction has been in use since 2005 (with continuous polishing) to make abstract booklets for the Ialian Mammal Society congresses (http://www.mammiferi.org).

History
-------

I did, at that time (circa 2005), some research on available "abstract booklet" LaTeX packages/toolchains, and I decided to use the `abstbook` class.
Some references here: 
  - the `abstbook` class on CTAN: http://ctan.mirror.garr.it/mirrors/CTAN/macros/latex/contrib/misc/abstbook.cls
  - a thread on Mac OSX TeX thatr gave me some inspiration: http://tug.org/pipermail/macostex-archives/2004-March/005037.html
 
How it works
------------

I decided to start from the `abstbook` class, bit with some kinks, modifying it to use KOMA-script `scrreprt` class, which I personally find more flexible than `article`.

Actually, ot have a _full_ (i.e. printer-ready) booklet, three separate files are needed:
  - the cover
  - the spine
  - the book itself
 
 Most of the material used here is borrowed from another project, that is the LaTeX code base used to typeset a scientific Journal (see: http://www.italian-journal-of-mammalogy.it/), that is a class called `hysarticle`.

Note that the new `hysabstract.cls` class is intended to typeset just the "mainmatter" of an abstract booklet. Actually, one can have just a single LaTeX source for an abstracts booklet, but "the `hysarticle` way" works lihe that:
 - **cover**: is made using `cover.tex` (based on the beautiful `memoir` class) using files in the `frontmatter` directory.
 - **front matter**: is made using `frontmatter.tex` (based as well on `memoir`) using files in the `frontmatter` directory.
 - **spine**: is made using spine.tex, in the 'frontmatter' folder as well.

Tnis means that you'll have an Hystrix abstrsct booklet supplement issue source tree organised like that:
<issue root directory>
     |         +---- main.tex (the master file that includes abstracts and outputs the abstract booklet)
     |         +---- test.tex (a bare-bones version of the master file, used to compile a single abstract)
     +---- frontmatter (all the stuff needed for cover, frontmatter and spine, like an standard Hystrix issue)
     |         +---- cover.tex
     |         +---- frontmatter.tex
     +---- abstracts
     |         +----(single abstracts, each one as a separate .tex file to be included in main.tex)
     |
