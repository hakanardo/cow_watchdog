\ProvidesClass{IET}[2015/11/07 v1.0]

\NeedsTeXFormat{LaTeX2e}[1995/12/01]

\newif\ifnum@bib\num@bibtrue
\newif\ifnote@end\note@endfalse

\DeclareOption{oneline}{\PassOptionsToPackage{doublespacing}{setspace}}
\DeclareOption{halfline}{\PassOptionsToPackage{onehalfspacing}{setspace}}
\DeclareOption{endnotes}{\ProvidesPackage{endnotes}\note@endtrue}
\DeclareOption{numbib}{\num@bibtrue}
\DeclareOption{nonumbib}{\num@bibfalse}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions

\LoadClass{article}

\RequirePackage{amsmath,amssymb,amsfonts,verbatim,graphicx,setspace,endnotes}%%
\RequirePackage[left=1in,right=1in,top=1in,bottom=1in]{geometry}
\usepackage{xspace,amscd,rotating,latexsym,multicol,array,algorithm,subfigure}
\usepackage[hyphens,obeyspaces]{url}
\usepackage{amsthm}

\let\@abstract\relax
\long\gdef\abstract#1{{\gdef\@abstract{%
   \normalsize%
        {\noindent {\bfseries\abstractname:\ }#1%
}%
\par}}}

\newcommand\keywordsname{Keywords}
\def\keywords#1{\gdef\@keywords{\textbf{\keywordsname:} #1}}\gdef\@keywords{}

\renewcommand\normalsize{%
   \@setfontsize\normalsize\@xiipt{14}%
   \abovedisplayskip 12\p@ \@plus3\p@ \@minus7\p@
   \abovedisplayshortskip \z@ \@plus3\p@
   \belowdisplayshortskip 6.5\p@ \@plus3.5\p@ \@minus3\p@
   \belowdisplayskip \abovedisplayskip
   \let\@listi\@listI}


\if@twoside
  \def\ps@headings{%
      \let\@oddfoot\@empty\let\@evenfoot\@empty
      \def\@evenhead{\thepage\hfil\slshape\leftmark}%
      \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
      \let\@mkboth\markboth
    \def\sectionmark##1{%
      \markboth {\MakeUppercase{%
        \ifnum \c@secnumdepth >\z@
          \thesection\quad
        \fi
        ##1}}{}}%
    \def\subsectionmark##1{%
      \markright {%
        \ifnum \c@secnumdepth >\@ne
          \thesubsection\quad
        \fi
        ##1}}}
\else
  \def\ps@headings{%
    \let\@oddfoot\@empty
    \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
    \let\@mkboth\markboth
    \def\sectionmark##1{%
      \markright {\MakeUppercase{%
        \ifnum \c@secnumdepth >\m@ne
          \thesection\quad
        \fi
        ##1}}}}
\fi
\def\ps@myheadings{%
    \let\@oddfoot\@empty\let\@evenfoot\@empty
    \def\@evenhead{\thepage\hfil\slshape\leftmark}%
    \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
    \let\@mkboth\@gobbletwo
    \let\sectionmark\@gobble
    \let\subsectionmark\@gobble
    }
  \if@titlepage
  \newcommand\maketitle{\begin{titlepage}%
  \let\footnotesize\small
  \let\footnoterule\relax
  \let \footnote \thanks
  \null\vfil
  \vskip 60\p@
    {\LARGE \@title \par}%
    \vskip 3em%
    {\large
     \lineskip .75em%
      \begin{tabular}[t]{c}%
        \@author
      \end{tabular}\par}%
      \vskip 1.5em%
    {\large \@date \par}%      
\par
  \@thanks
  \vfil\null
  \end{titlepage}%
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}
\else
\renewcommand\maketitle{\par
  \begingroup
    \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
    \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
    \long\def\@makefntext##1{\parindent 1em\noindent
            \hb@xt@1.8em{%
                \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
    \if@twocolumn
      \ifnum \col@number=\@ne
        \@maketitle
      \else
        \twocolumn[\@maketitle]%
      \fi
    \else
      \newpage
      \global\@topnum\z@   % Prevents figures from going at top of page.
      \@maketitle
    \fi
    \thispagestyle{plain}\@thanks
  \endgroup
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}
\def\@maketitle{%
  \newpage
  \null
  \vskip 2em%
  { \let \footnote \thanks
        {\fontfamily{\sfdefault}\fontsize{14}{16}\selectfont\bfseries\raggedright \noindent\@title \par}%
    \vskip 1.5em%
        {\normalsize\lineskip .5em\noindent\@author\par}%
    \vskip 1.5em%
        \@abstract%
    \vskip1em%
        \noindent\@keywords
  \par}
  \vskip 1.5em}
\fi

% Reset the default section macros to help with title casing
\def\@sect#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \protected@edef\@svsec{\@seccntformat{#1}\relax}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      #6{%
        \@hangfrom{\hskip #3\relax\@svsec}%
          \interlinepenalty \@M
% Modified to uppercase H1's and titlecase the rest
          \ifnum #2=1\relax
             #8%
          \else
            {#8}%
          \fi
        \@@par}%
    \endgroup
    \csname #1mark\endcsname{#7}%
    \addcontentsline{toc}{#1}{%
      \ifnum #2>\c@secnumdepth \else
        \protect\numberline{\csname the#1\endcsname}%
      \fi
      #7}%
  \else
    \def\@svsechd{%
      #6{\hskip #3\relax
      \@svsec #8:\hskip12pt}%
      \csname #1mark\endcsname{#7}%
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
          \protect\numberline{\csname the#1\endcsname}%
        \fi
        #7}}%
  \fi
  \@xsect{#5}}

\def\section{%
\renewcommand{\@seccntformat}[1]{{{\fontfamily{\sfdefault}\csname the##1\endcsname.\quad}}}
  \@startsection{section}{1}{\z@}
  {-24\p@ plus -3\p@ minus -3\p@}{12\p@}
  {\reset@font\normalsize\fontfamily{\sfdefault}\fontseries{b}\selectfont
    \mathversion{bold}\raggedright%\MakeUppercase%\setcounter{thm}{0}%
}}

% H2
\def\subsection{%
\renewcommand{\@seccntformat}[1]{{{\fontfamily{\sfdefault}\fontseries{m}\fontshape{it}\csname the##1\endcsname.\quad}}}
  \@startsection{subsection}{2}{\z@}
  {-14\p@ plus -1\p@ minus -2\p@}{8\p@}
  {\reset@font\normalsize\fontfamily{\sfdefault}\fontseries{m}\fontshape{it}\selectfont
    \mathversion{bold}\raggedright}}

% H3
\def\subsubsection{%
\renewcommand{\@seccntformat}[1]{{{\fontfamily{\sfdefault}\fontseries{m}\fontshape{it}\csname the##1\endcsname.\ }}}
  \@startsection{subsubsection}{3}{\z@}
  {-14\p@ plus -1\p@ minus -2\p@}{-0.0001pt}
  {\reset@font\normalsize\fontfamily{\sfdefault}\fontseries{m}\fontshape{it}\selectfont
    \raggedright}}

\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
                                    {3.25ex \@plus1ex \@minus.2ex}%
                                    {-1em}%
                                    {\normalfont\normalsize\bfseries}}
\renewcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
                                       {3.25ex \@plus1ex \@minus .2ex}%
                                       {-1em}%
                                      {\normalfont\normalsize\bfseries}}

\renewcommand\figurename{Fig.}

\def\table{\let\@makecaption\@tablecaption\@float{table}}

\newbox\tablecaptionbox
\long\def\@tablecaption#1#2{%\par%
\setbox\tablecaptionbox=\hbox to \textwidth{\hfil\fontsize{10}{12}\selectfont
    \textbf{#1}\enskip #2\par\hfil}%
  \ifdim\wd\tablecaptionbox<\hsize
{\box\tablecaptionbox}
  \else
    \fontsize{10}{12}\selectfont
    \unhbox\tablecaptionbox
    \par
  \fi
  \vspace{4pt}}

\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \textbf{\textit{#1}.} \textit{#2}\par
  \vskip\belowcaptionskip}

\def\subcaption#1#2{{\par\rm #1\ #2}}

\renewcommand\appendix{\@ifstar\@starappendix\@appendix}

\newcommand\@starappendix{\par
  \setcounter{section}{0}%
  \setcounter{subsection}{0}%
  \setcounter{secnumdepth}{0}
  \gdef\thesection{\@Alph\c@section}}
\newcommand\@appendix{\par
  \setcounter{section}{0}%
  \setcounter{subsection}{0}%
  \gdef\thesection{\@Alph\c@section}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% From ifmtarg.sty
% Copyright Peter Wilson and Donald Arseneau, 2000
\begingroup
\catcode`\Q=3
\long\gdef\@ifmtarg#1{\@xifmtarg#1QQ\@secondoftwo\@firstoftwo\@nil}
\long\gdef\@xifmtarg#1#2Q#3#4#5\@nil{#4}
\long\gdef\@ifnotmtarg#1{\@xifmtarg#1QQ\@firstofone\@gobble\@nil}
\endgroup
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%% PostScript Rotation Macros %%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newif\if@rotate \@rotatefalse
\newif\if@rotatecenter \@rotatecenterfalse
\def\rotatecenter{\global\@rotatecentertrue}
\def\rotateendcenter{\global\@rotatecenterfalse}
\def\rotate{\global\@rotatetrue}
\def\endrotate{\global\@rotatefalse}
\newdimen\rotdimen
\def\rotstart#1{\special{ps: gsave currentpoint currentpoint translate
    #1 neg exch neg exch translate}}
\def\rotfinish{\special{ps: currentpoint grestore moveto}}
\def\rotl#1{\rotdimen=\ht#1\advance\rotdimen by \dp#1
    \hbox to \rotdimen{\vbox to\wd#1{\vskip \wd#1
    \rotstart{270 rotate}\box #1\vss}\hss}\rotfinish}
\def\rotr#1{\rotdimen=\ht #1\advance\rotdimen by \dp#1
    \hbox to \rotdimen{\vbox to \wd#1{\vskip \wd#1
    \rotstart{90 rotate}\box #1\vss}\hss}\rotfinish}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newdimen\tempdime
\newbox\temptbox

\def\tablebodyfont{\fontsize{10}{12}\selectfont}
\newenvironment{processtable}[3]{\setbox\temptbox=\hbox{{\tablebodyfont #2}}%
\tempdime\wd\temptbox\@processtable{#1}{#2}{#3}{\tempdime}}%
{\relax}

\newenvironment{@processtable}[4]{%
\if!#1!%
\addtocounter{table}{-1}%%ADDED ON 21/12/05
\def\fnum@table{}%
\else%
\def\fnum@table{{\tablename}\enspace\thetable}%
\fi%
\if@rotate
\setbox4=\vbox to \textwidth{\vss\hbox to \textheight{%
\begin{minipage}{#4}%
\caption{#1}{\tablebodyfont #2}%
\@ifmtarg{#3}{}{\vskip5pt\noindent
\parbox{#4}{\fontsize{8}{10}\selectfont #3\par}}%
\end{minipage}}\vss}
\else
\setbox4=\hbox to \textwidth{{\hss\begin{minipage}[t]{#4}%
\caption{#1}{\tablebodyfont #2}
\@ifmtarg{#3}{}{\vskip3.5pt\noindent
\parbox{#4}{\fontsize{8}{10}\selectfont #3\par}}
\end{minipage}\hss}}
\fi
\if@rotate\rotr{4}\else\box4\fi}
{\relax}

\ifnote@end\let\footnote\endnote\fi%

\newenvironment{notes}[1][Notes]{\par
\section*{#1}%
}{\par}

\renewenvironment{thebibliography}[1]
     {\section{\refname}%
      \@mkboth{\MakeUppercase\refname}{\MakeUppercase\refname}%
      \list{\ifnum@bib\@biblabel{\@arabic\c@enumiv}\fi}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \ifnum@bib
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \else
            \leftmargin\bibindent
            \advance\itemindent-\bibindent
            \fi
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}

\usepackage{authblk-TI}

\renewcommand{\rmdefault}{ptm}
\renewcommand{\sfdefault}{phv}

\setlength\parskip{0\p@}
\setlength\columnsep{12\p@}
\setlength\columnseprule{0\p@}
\pagestyle{plain}
\pagenumbering{arabic}
\if@twoside
\else
  \raggedbottom
\fi
\if@twocolumn
  \twocolumn
  \sloppy
  \flushbottom
\else
  \onecolumn
\fi

\def\th@plain{%
  \rm % body font
}


\endinput
