%
%	This is second version of the class. It redefines Chapters 
%	sections and subsections, in order to use the minitoc style!
%
%
% DESCRIPTION:
%
%	-``Quick and dirty'' class file for ``book of abstracts''
%	 (used for IWEPNM - Kirchberg 1997)
%
%	- It's getting less Quick and dirty, but it's far from beeing 
%	what i want, should be much more flexible for that.
%
%	-Written by Havlik Denis (havlik@pap.univie.ac.at) 02/1997.
%	-Based on the report class. 
% 
%	This .cls file has been written for the conference in Kirchberg.
%	It has been designed to produce a4-size pages,
%	which are later converted into a5. Output is double-sided.
%
%	Abstracts are suposed to be in separate files, with simple
%	formating (title, name, adress, text).
%
%	As i have a feeling that many conferences need something
%	like this booklet, i will try to document this file as good as 
%	i can. In the case anybody is interesting to use this class,
%	but neads more flexibility or new features, i would be pleased 
%	to help. This is a first time ever that i write a Latex class,
%	but i'm learning.   
%
%	Features: 
%	-Conferences consist of days and sessions.
%	-In every day there can be one or more sessions, in every
%	 session there can be several abstracts. Abstracts appear
%	 two on a page, with short name of the session, the number
%	 of the abstract and an additional entry WRITTEN ON THE MARGIN. 
%	-In the headings, day appears on the even, and session on the odd
%	 pages. 
%	-For every day, a table of abstracts is printed
%	-names of the authors are automatically added to index of authors
%	 (don't forget to run the ``makeindex''!!!) 
%	
% I would like to thank the ``\"Osterreichischen Fonds zur F\"orderung 
% der wissenschaftlichen Forschung'' for financing my work 
% under project Nr. +P10924-PHY. Furthermore, a Linux, and \TeX/\LaTeX 
% comunity, for providing wonderfull free software, that i use for all my 
% work. Special thanks to Jean-Pierre Drucbert 
%					Havlik Denis 
%
% TODO: 
%	1. redefine \titl, \name and \adr, so i can get automatic: 
%	indexing of authors and automatic referencing of authors to adress
%	2. automatic resizing of abstracts to fit other page-sizes, 
%	(not only a4) and other margines etc.
%	3. add formatting stuff like:
%		 \newcommand{\titlstyle}{\bf \Large \MakeUppercase}
%	with some logical names and use it consequently for all the macros
%	in the whole class
%	4. ?%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% FOLLOWING OPTIONS ARE RECOGNISED BY "ABSTBOOK" CLASS:
%%
%% ''twocolumn'' : cannot be used with the ``abstbook`` class.
%% ''program''   : print only program entries.
%% ''compact''   : no "claerpage" after program!
%% ``noabstracts'': disable printing of abstracts.
%% ``noads''    : disable printing of advertisements.
%% ''noindex''   : do not print the index at the end of the booklet

\def\RCSfile{gircabstract}
\def\RCSversion{1.0}
\def\RCSdate{2015/05/21}
\def\@baseclass{scrreprt} % hysarticle uses scrartcl, frontmatter + cover uses memoir, use scrreprt here (would use scrbook, but there's trouble with section redefinitions)
\def\@baseoptions{a4paper,fontsize=9pt,authoryear,onecolumn,twoside}
\def\@shortjnl{Hystrix, It. J. Mamm.}
\def\@journal{Hystrix, the Italian Journal of Mammalogy}
\def\@volume{xx}
\def\@issue{x}
\def\@volyear{\the\year}
\def\@doibase{10.4404/hystrix-} % 10.4404/hystrix-xx.x-xxxx
\def\@msid{xxxx}
\def\@doi{\@doibase\@volume.\@issue-\@msid}
\def\@company{Associazione Teriologica Italiana}
\def\@shortcmp{ATIt}
\def\@issn{1825-5272} % electronic version ISSN
\def\@shortjid{hysabstract}
\def\@journalurl{http://www.italian-journal-of-mammalogy.it}
\def\@journalpath{\@journalurl/article/view/\@msid/pdf} % this is OJS URL grammar
\def\@journallogo{logotipo_girc_300dpi_10cm.png}
\def\@journalding{logo_black.pdf}
%
\def\@conferencename{}
\def\@absauthor{An Author}
\def\@abstitle{A Title}
\def\@absadr{An Address}
%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{\RCSfile}[\RCSdate, \RCSversion: class to typeset books of abstracts]
\typeout{Class: `hysabstract' \RCSversion\space <\RCSdate>}

%% define and set options here
\newif\if@abstracts\@abstractstrue
\newif\if@advertise\@advertisetrue
\newif\if@compact\@compactfalse
\newif\if@program\@programfalse
\newif\if@index\@indextrue

%\DeclareOption{twocolumn}{%
%    \ClassWarning{hysabstract}{No 'twocolumn' layout for hysabstract.}}

\DeclareOption{noabstracts}{%
  \typeout{Text enclosed in "abstract" enviroment will not be printed!}
  \@abstractsfalse}

\DeclareOption{noads}{%
  \typeout{Advertisements will not be printed!}
  \@advertisefalse}

\DeclareOption{compact}{%
  \typeout{No "claerpage" after program!}
  \@compacttrue}

\DeclareOption{program}{%
  \typeout{Only program will be produced, no abstracts, no titles, no advertisements, no index!}
  \@programtrue \@indexfalse \@advertisefalse}

\DeclareOption{noindex}{%
  \typeout{Index will not be printed!}
  \@indexfalse}

\ExecuteOptions{\@baseoptions}

%% All other options go to base class.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\@baseclass}}
\ProcessOptions
\LoadClass[\@baseoptions]{\@baseclass}
\RequirePackage{eurosym} % 
\RequirePackage{scrpage2} % to have page stylea
\RequirePackage{makeidx} % neaded to make index
\RequirePackage{graphicx} % neaded to input graphics into booklet.
\RequirePackage{multicol}
\RequirePackage{multirow}
\RequirePackage{gensymb} % \degree
\RequirePackage{tabularx}
\RequirePackage{paralist} % compactitem, compactenum & co.
\RequirePackage{rotating} % rotatebox, turnbox
\RequirePackage{array}
\RequirePackage{color}
\RequirePackage{colortbl}
\definecolor{HeaderGray}{gray}{0.95}


%% use TeX Gyre fonts as default
\IfFileExists{tgtermes.sty}{
  \typeout{defaulting to TeX Gyre Termes (tgtermes) font}
  %\RequirePackage[T1]{fontenc}%
  \RequirePackage{lmodern} % family name is ulg
  \RequirePackage[lf]{venturis} % lf for lining figures glyphs, family name is yv1
  \RequirePackage{tgtermes} % family name is qtm
  \fontfamily{qtm}\selectfont
  \gdef\rmdefault{qtm} % set tgtermes as roman default font
  \gdef\sfdefault{yv1} % set venturis sans as sans serif default font
  }
  {\typeout{*****************************************************}
  \typeout{    tgtermes font missing, defaulting to times}
  \typeout{*****************************************************}
  \RequirePackage{times}}

%% as from hysarticle class, same stock page sizing
\RequirePackage{geometry}
 \geometry{twoside,
  paperwidth=210mm,
  paperheight=297mm,
  top=18mm,
  bottom=18mm,
  %textheight=682pt,
  textwidth=500pt, % was 522
  centering,
  headheight=70pt,
  headsep=12pt,
  footskip=18pt,
  footnotesep=24pt plus 2pt minus 12pt,
  columnsep=18pt
 }%

%% leave these two values as they are. TeX needs them to proprely fill in a page
\hyphenpenalty=500
\tolerance=500

%% page - size related stuff.
%\setlength{\unitlength}{1cm}
%%\setlength{\topmargin}{1.5cm}
%\setlength{\hoffset}{-0.8in}
%%\setlength{\voffset}{-1in} 
%\setlength{\textwidth}{16.5cm}
%\setlength{\textheight}{24.8cm}
%\setlength{\topskip}{0cm}
%\setlength{\footskip}{0cm}
%\setlength{\oddsidemargin}{1.5cm}
%\setlength{\evensidemargin}{1.5cm}
%\setlength{\marginparsep}{0.3cm}
%\setlength{\marginparwidth}{1.0 cm}
%\setlength{\parindent}{0cm}


\pagestyle{myheadings} 		% to get the day - session in headings!

%% I had to redefine chapter  because of mini-tables-of-contents and
%% pagenumbering. Therefore command chapter should not be used in the
%% ''abstbook''.
%% The "minitoc" package is needed to produce the daily schedule.
\renewcommand\chapter{%
  \if@compact \vfill
  \else \if@openright\cleardoublepage\else\clearpage\fi
  \fi
    \global\@topnum\z@
    \@afterindentfalse
    \secdef\@chapter\@schapter}

\def\@makechapterhead#1{\relax}  %write nothing...
\RequirePackage{minitoc}

\AtBeginDocument{% this comes after \begin{document}
  \makeindex 
	\dominitoc\cleardoublepage 
	%\faketableofcontents
	% this is to have the index on 3 columns, see http://latex-community.org/forum/viewtopic.php?f=4&t=1735
  \makeatletter
  \renewenvironment{theindex}
    {\if@twocolumn
        \@restonecolfalse
     \else
        \@restonecoltrue
     \fi
     \setlength{\columnseprule}{0pt}
     \setlength{\columnsep}{35pt}
     \begin{multicols}{3}[\section*{\indexname}]
     \markboth{\MakeUppercase\indexname}%
              {\MakeUppercase\indexname}%
     \thispagestyle{plain}
     \setlength{\parindent}{0pt}
     \setlength{\parskip}{0pt plus 0.3pt}
     \relax
     \let\item\@idxitem}%
    {\end{multicols}\if@restonecol\onecolumn\else\clearpage\fi}
  \makeatother	
\if@program
  \pagestyle{empty}
  \nomtcpagenumbers
\else
  \pagestyle{myheadings}
\fi
}

\AtEndDocument{\if@index \printindex \else \relax \fi} % dont forget to run the ``makeindex'' program!


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%	COMMANDS
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newlength{\abstwidth}
\newlength{\abstheight}
\newlength{\abstmarkskip}

\setlength{\abstwidth}{.9\textwidth}%{15cm}
\setlength{\abstheight}{12cm}
\setlength{\abstmarkskip}{-6cm}

\newcommand{\titlesize}{\large}
\newcommand{\authorsize}{\normalsize}
\newcommand{\addressize}{\normalsize}
\newcommand{\abstractsize}{\normalsize}
\newcommand{\marginmarksize}{\large}

%% Counter and Saveboxes

\newcounter{Cabstract}[section]% counter for abstracts==section-counter!

\newsavebox{\ConferenceDay} % hier comes the name of the day
\newsavebox{\SessionName}   % name of the session
\newsavebox{\ShortSessionName} % short name of the session
\newsavebox{\AbstractTitle} % Title of the abstract goes here

\sbox{\ConferenceDay}{}
\sbox{\SessionName}{}
%\markboth{\usebox{\ConferenceDay}}{\usebox{\SessionName}}

\def\mtctitle{\relax}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Command: \conferencename
%  Usage:   \conferencename{23$^{th} International Conference on Irreproducible Results}
%  Provides: sets conference name for abstracts and page headers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\conferencename}[1]{%
  \def\@conferencename{#1}
  }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Command: 	\conferenceday
%  Usage: 	  \conferenceday{some day}
%  Provides:	advances day-counter, adds the day-name to TOC 
%		and clears the page		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\conferenceday}[1]{%
	\chapter{#1}
	{\Large \textbf #1}%\par 
	%\minitoc % we don't want the monitoc
	\sbox{\ConferenceDay}{#1} 
	\if@compact \relax \else \clearpage \fi
	}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Command:	\sessionname
%  Usage: 	\sessionname{shortname}{longname}
%  Provides:    advances session-counter, adds the session-name to TOC
%		and clears the page
%  Important:	I'm not using \section here. Instead, i try to emulate 
%		the part that i nead. It worked with my version 
%		of minitoc, but didn't work with an older version 
%		we had at the university. Bad. Redefining \section 
%		would be better, but i can't figure it out.
%		Well, Jean-Pierre Drucbert <Jean-Pierre.Drucbert@onecert.fr>
%		said it should be O.K., so be it. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\sessionname}[2][\relax]{%
	\refstepcounter{section}
	\sbox{\ShortSessionName}{#1}
	\def\@shortsessionname{#1}
	\sbox{\SessionName}{#2}
	\def\@sessionname{#1}
	\clearpage
	\noindent\colorbox{HeaderGray}{\begin{minipage}{\textwidth}\LARGE\textbf{#2}\end{minipage}}\medskip
	\addcontentsline{toc}{section}{\large\textsc{#2}\hfill} %% perhaps work on that \MakeUppercase...
	}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Command: \advertisement
%%  Usage: \advertisement{TEXT}
%%  Provides: Empty side with text ``TEXT'' on it.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\advertisement}[1]{%
  \if@advertise
    \clearpage
    \par\rule[-12cm]{0cm}{24cm} % well, you might nead to change this
    {\Large #1}
    \par \clearpage
  \fi
  }
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Command: \pause
%%  Usage: \pause{TEXT}
%%  Provides: ``TEXT'' appears in table of contents
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\pause}[1]{%
  \addcontentsline{toc}{subsection}{%
  #1
 }
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Following definitions determine how to deal with the abstracts     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ABSTRACTS SHOULD BE IN SEPARATE FILES, FORMATTED LIKE THIS:
%
% Abstract example: 
%	\index{Name1} \index{Name2}... for author names to appear in index!!!  
%	\abstitle{Title of the abstract}
%	\absauthor{A. First$^a$, A. Second$^a$, A. Third$^b$}
%	\absaddress{a~First address\break b~Second address}
%	\abstext{
%	Abstracts text (in Latex notation). Most of the Latex commands 
%	can be used here...
%	} % closes \abstext
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% the idea is 'just store', then \loadabstr does it all

\newcommand{\abstitle}[1]{%
  \def\@abstitle{#1}
  %\sbox{\AbstractTitle}{#1}
  %\titlesize \textbf{#1}
  %\par\smallskip
} 
   
\newcommand{\absauthors}[1]{%
  \def\@absauthors{#1}
  %\rm \authorsize #1 \par\smallskip
}
  
\newcommand{\absaddress}[1]{%
  \def\@absaddress{#1}
  % \it \addressize #1 \par\smallskip
}

\newcommand{\abstext}[1]{%
  \def\@abstext{#1}
}
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	COMMANDS TO BE USED IN THE MAIN DOCUMENT
 
% Command: 	\loadabstr
% Usage: 	\loadabstr[additional]{TOC-entry}{filename.tex}
% Provides:	loads the abstract from the file ``filename.tex'',
%    writes the ``TOC-entry'' to table of contents,
%   advances the abstracts-counter,
%		writes the short name of the session, abstract-number
%		and an additional entry to the margin. 

\newlength{\logowidth}\setlength{\logowidth}{18mm}
\newlength{\barwidth}\setlength{\barwidth}{2mm}
\newlength{\titlewidth}\setlength{\titlewidth}{\dimexpr\titlewidth-\logowidth-\barwidth\relax} 

\newcommand{\loadabstr}[3][\relax]{%
  \stepcounter{Cabstract}
	%\par
	\IfFileExists{#3}{%
    \input{#3}
    \raggedbottom
    \setlength{\fboxsep}{0pt}
    \begin{center}
    \colorbox{HeaderGray}{
    \begin{tabularx}{\textwidth}{p{\barwidth}X>{\raggedleft\arraybackslash}p{\logowidth}}
    \multicolumn{2}{l}{\scriptsize\@conferencename} & \multirow{5}{*}{\includegraphics[width=.95\logowidth]{\@journallogo}}\\
    \multicolumn{2}{p{\dimexpr (\linewidth-(\logowidth+\barwidth+5mm))\relax}}{\sffamily\Large\textbf\@abstitle} & \\
    \multicolumn{2}{p{\dimexpr (\linewidth-(\logowidth+\barwidth+5mm))\relax}}{\raggedright\rmfamily\normalsize\@absauthors} & \\
    \multicolumn{2}{p{\dimexpr (\linewidth-(\logowidth+\barwidth+5mm))\relax}}{\raggedright\sffamily\footnotesize\@absaddress} & \\
    & & \\
    %\rotatebox{90}{\@shortsessionname~#1\quad} % this has to be fixed to align bottom!!!
    \rotatebox{90}{#1\quad} & \multicolumn{2}{p{\dimexpr\linewidth-(\barwidth+2mm)\relax}}{\cellcolor{white}{\parbox{\dimexpr\linewidth-(\barwidth+3mm)\relax}{\abstractsize \rmfamily \begin{multicols}{2}\@abstext \end{multicols}}}} \\
    \end{tabularx}
    } % colorbox
    \end{center}     
	  }
	{File #3 not found}
	\addcontentsline{toc}{subsection}{#2}
}





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% end of the hysabstract.cls
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
