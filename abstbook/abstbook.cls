%%
%% This is file `abstbook.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% abstbook.dtx  (with options: `package')
%% ********************************************************************
%% Copyright (C) 1996-1999 Denis Havlik
%% 
%% This program is part of the AbstBook package.
%% It is provided under the GNU licence.
%% 
%% Questions, comments or suggestions concerning this program can be
%% sent to:
%% DENIS HAVLIK
%% INST. FOR EXP. PHYS., UNIV. VIENNA
%% A-1090 WIEN, AUSTRIA
%% E-mail: havlik@pap.univie.ac.at
%% 
%% E-mail is prefered.
%% ********************************************************************
\def\fileversion{0.5c}
\def\filedate{1999/06/26}
%% File 'abstbook.dtx'
%% Copyright (C) 1996--1999 Denis Havlik.  All rights reserved.
%% Licencing: GNU-licence

%% \CharacterTable
%%  {Upper-case    \A\B\C\D\E\F\G\H\I\J\K\L\M\N\O\P\Q\R\S\T\U\V\W\X\Y\Z
%%   Lower-case    \a\b\c\d\e\f\g\h\i\j\k\l\m\n\o\p\q\r\s\t\u\v\w\x\y\z
%%   Digits        \0\1\2\3\4\5\6\7\8\9
%%   Exclamation   \!     Double quote  \"     Hash (number) \#
%%   Dollar        \$     Percent       \%     Ampersand     \&
%%   Acute accent  \'     Left paren    \(     Right paren   \)
%%   Asterisk      \*     Plus          \+     Comma         \,
%%   Minus         \-     Point         \.     Solidus       \/
%%   Colon         \:     Semicolon     \;     Less than     \<
%%   Equals        \=     Greater than  \>     Question mark \?
%%   Commercial at \@     Left bracket  \[     Backslash     \\
%%   Right bracket \]     Circumflex    \^     Underscore    \_
%%   Grave accent  \`     Left brace    \{     Vertical bar  \|
%%   Right brace   \}     Tilde         \~}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{abstbook}[\filedate\space\fileversion]
\typeout{Class: `abstbook' \fileversion\space <\filedate>}
\RequirePackage{anysize}
\RequirePackage{color}
%% FOLLOWING OPTIONS ARE RECOGNISED BY "ABSTBOOK" CLASS:
%%
%% ''twocolumn'' : cannot be used with the ``abstbook`` class.
%% ''program''   : print only program entries.
%% ''compact''   : no "claerpage" after program!
%% ``noabstracts'': disable printing of abstracts.
%% ``noads''    : disable printing of advertisements.
%% ''noindex''   : do not print the index at the end of the booklet
%%
%% All other class options are simply passed to ''report'' class,
%% The "makeidx" package is needed to produce index of participants.
\newif\if@abstracts\@abstractstrue
\newif\if@advertise\@advertisetrue
\newif\if@compact\@compactfalse
\newif\if@program\@programfalse
\newif\if@index\@indextrue

\DeclareOption{twocolumn}{%
    \ClassWarning{abstbook}{No 'twocolumn' layout for abstbook.}}

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

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions
\LoadClass{report}
\RequirePackage{makeidx}

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
\dominitoc
\faketableofcontents
\if@program
  \pagestyle{empty}
  \nomtcpagenumbers
\else
  \pagestyle{myheadings}
\fi
}

\AtEndDocument{\if@index \printindex \else \ \fi} % dont forget to run the ``makeindex'' program!
%% Following commands affect formating of abstracts:

\newlength{\abstwidth}
\newlength{\abstheight}
\newlength{\abstmarkskip}

\setlength{\abstwidth}{15cm}
\setlength{\abstheight}{12cm}
\setlength{\abstmarkskip}{-6cm}

\newcommand{\titlesize}{\large}
\newcommand{\authorsize}{\normalsize}
\newcommand{\addressize}{\normalsize}
\newcommand{\abstractsize}{\normalsize}
\newcommand{\marginmarksize}{\large}

%% "Counters" and "Saveboxes"

\newcounter{Cabstract}[section]% counter for abstracts==section-counter!

\newsavebox{\ConferenceDay}  % hier comes the name of the day
\newsavebox{\SessionName}    % name of the session
\newsavebox{\ShortSessionName} % short name of the session
\newsavebox{\AbstractTitle} % Title of the abstract goes here

\sbox{\ConferenceDay}{}
\sbox{\SessionName}{}
\markboth{\usebox{\ConferenceDay}}{\usebox{\SessionName}}

\def\mtctitle{\relax}%

%%  Command:  \conferenceday
%%  Usage:  \conferenceday{some day}
%%  Provides: advances day-counter, adds the day-name to TOC
%% and clears the page
\newcommand{\conferenceday}[1]{%
\chapter{#1}
{\Large \bf #1}
\minitoc
\sbox{\ConferenceDay}{#1}
\sbox{\SessionName}{#1}
\if@compact \relax \else \clearpage \fi
}
%%  Command: \sessionname
%%  Usage:  \sessionname{shortname}{longname}
%%  Provides:    advances session-counter, adds the session-name to TOC
%%               and clears the page
\newcommand{\sessionname}[2][\relax]{%
\refstepcounter{section}
\sbox{\ShortSessionName}{#1}
\sbox{\SessionName}{#2}
\addcontentsline{toc}{section}{\MakeUppercase{#2}\hfill}
}
%% Abstract example:
%% \index{Name1} \index{Name2}... - this is nessesary for authornames
%% to appear in index!!!
%% \title{Title of the abstract}
%% \author{A. First$^1$, A. Second$^1$, A. Third$^2$}
%% \address{1~First address\\
%%      2~Second addrass}
%%
%% \begin{abstract}
%% Abstracts text (in Latex notation). Most of the Latex commands
%% can be used here...
%% \end{abstract}
%% !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
%% TO DO:
%% I would like to change \author and \address in such a way that
%%
%% \author[mark1]{name1}
%% \author[mark2]{name2}
%% \author[mark1]{name3}
%% \address[adr1]{adress1}
%% \address[adr2]{adress2}
%%
%% produces the same result as one obtained in the previous example
%% and automaticaly includes the names into index list...
%% Unfortunately, i don't know how to do it.
%% !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
%% Title of the abstract: \title{TITLE}
%% author(s) name(s):    \author{NAME}
%% author(s) addres(es): \address{ADDRESS}
%% enviroment ``abstract'': \begin{abstract} ... \end{abstract}
\renewcommand{\title}[1]{%
\sbox{\AbstractTitle}{#1}
\titlesize \bf
#1
\par\smallskip}
\renewcommand{\author}[1]{\rm \authorsize
#1
\par\smallskip}
\newcommand{\address}[1]{\it \addressize
#1
\par\smallskip}
\renewenvironment{abstract}{%
\par\smallskip
\if@abstracts \abstractsize \rm
\else \color[rgb]{1.0,1.0,1.0} \nullfont \fi}{\par\medskip}
%% Command:  \loadabstr or \loadposter
%% Usage:  \loadabstr[additional]{TOC-entry}{filename.tex}
%% Provides: reserves 1/2 page for the abstract, loads the abstract
%% from the file ``filename.tex'', writes the ``TOC-entry''
%% to table of contents, advances the abstracts-counter
%% and writes the short name of the session, abstract-number
%% and an additional entry to the margin.
%%  (We have used the additional entry for the time..)
%% additional: \loadposter does not put an entry in TOC!
%% "\loadwork" is the template for both "\loadabstr" and "\loadposter"

\newcommand{\loadwork}[3][\relax]{%
\begin{samepage}
  \stepcounter{Cabstract}
  \if@program \relax \else
    \if@abstracts
    \rule[\abstmarkskip]{0cm}{\abstheight}
        \marginpar{%
        \marginmarksize
        \centering
        #1
        \par\smallskip
        \usebox{\ShortSessionName}\par\smallskip
        \arabic{Cabstract}}
    \fi
    %\fbox{
    \begin{minipage}{\textwidth}
      \label{#3}
      \ifodd \pageref{#3} \hfill \fi
      \IfFileExists{#3}{%
        \if@abstracts
  \begin{minipage}{\abstwidth}
            \input{#3}
          \end{minipage}
\else
  \begin{minipage}{\textwidth}
            \input{#3}
          \end{minipage}
\fi
      }{{\bf #2}  not found}
    \end{minipage}
    %}
  \fi
\end{samepage}
\vfill
}
\newcommand{\loadabstr}[3][\relax]{%
\loadwork[#1]{#2}{#3}
\addcontentsline{toc}{subsection}{#2}
}
\newcommand{\loadposter}[2][\relax]{%
\loadwork[#1]{#2}{#2}
}

%%
%%  Command: \advertisement
%%  Usage: \advertisement{TEXT}
%%  Provides: Empty side with text ``TEXT'' on it.
%%
\newcommand{\advertisement}[1]{%
  \if@advertise
    \clearpage
    \par\rule[-12cm]{0cm}{24cm} % well, you might nead to change this
    {\Large #1}
    \par \clearpage
  \fi
}
%%
%%  Command: \pause
%%  Usage: \pause{TEXT}
%%  Provides: ``TEXT'' appears in table of contents
%%
\newcommand{\pause}[1]{%
\addcontentsline{toc}{subsection}{%
#1
}
}
\endinput
%%
%% End of file `abstbook.cls'.
