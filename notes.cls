\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{notes}

% Logical operators
\RequirePackage{ifthen}
\newcommand  \@elif        [3]  {\ifthenelse{#1}{#2}{#3}}
\newcommand  \@elifdef     [3]  {\@elif{\isundefined{#1}}{#3}{#2}}
\newcommand  \@ifdef       [2]  {\@elifdef{#1}{#2}{}}
\newcommand  \@ifbothdef   [3]  {\@ifdef{#1}{\@ifdef{#2}{#3}}}
\newcommand  \@ifnone      [2]  {\@elifdef{#1}{}{#2}}
\newcommand  \@ifbothnone  [3]  {\@ifnone{#1}{\@ifnone{#2}{#3}}}
\newcommand  \@ifnotempty  [2]  {\@elif{\equal{#1}{\@empty}}{}{#2}}



% Datetime
\RequirePackage[nodayofweek]{datetime}
\newdateformat{isodate}{\THEYEAR-\twodigit{\THEMONTH}-\twodigit{\THEDAY}}
\newdateformat{usdateshort}{{\THEMONTH}-{\THEDAY}-{\THEYEAR}}
\newdateformat{eurodate}{{\THEDAY} {\monthname[\THEMONTH]} {\THEYEAR}}
\eurodate



%%% O P T I O N S
% numeral style
\DeclareOption{plainnums}{\def\@plainnums{}}

% date formats
\DeclareOption{isodate}{\isodate}
\DeclareOption{usdate}{\usdate}
\DeclareOption{usdateshort}{\usdateshort}
\DeclareOption{eurodate}{\eurodate}

% page layout
\DeclareOption{twoside}{\def\@twoside{}}
\DeclareOption{titlepage}{\def\@titlepage{}}
\DeclareOption{nomargin}{\def\@nomargin{}}


% process options
\ProcessOptions
\@ifnone\@plainnums{\PassOptionsToPackage{osf}{newpxtext}}
\@ifdef\@twoside{\PassOptionsToPackage{twoside}{article}}
\@elifdef\@nomargin
  {\PassOptionsToPackage{top=1.25in,bottom=1.25in,inner=1.25in,outer=1.25in}{geometry}}
  {\PassOptionsToPackage{top=1in,bottom=1.2in,inner=1in,outer=2.40in,marginparwidth=1in,marginparsep=0.4in}{geometry}}



%%% R E Q U I R E D   P A C K A G E S
\LoadClass{article}
\RequirePackage[heightrounded]{geometry}
\RequirePackage[scaled=0.9]{newpxtext}
\RequirePackage{newpxmath}
\RequirePackage{setspace}
\RequirePackage{microtype}
\RequirePackage{xcolor}
\RequirePackage[colorlinks,linkcolor=black,citecolor=black,urlcolor=black]{hyperref}
\RequirePackage{tikz}
\RequirePackage{caption} % http://www.peteryu.ca/tutorials/publishing/latex_captions_old STYLING CAPTIONS
\RequirePackage{float}
\RequirePackage{fancyhdr}
\RequirePackage{environ}
\RequirePackage[most]{tcolorbox}
\RequirePackage{titlesec}
\RequirePackage{amsmath}
\RequirePackage[titles]{tocloft}
\usepackage{amssymb} %% <- for \square and \blacksuare


%%% E N V I R O N M E N T S
% marginpar
\let\oldmarginpar\marginpar
\renewcommand\marginpar[1]{\oldmarginpar{\raggedright\footnotesize{#1}}}


% marginfig
\newcommand\@marginfig[3]
{%
  \marginpar%
  {%
    \begin{figure}[H]%
    \footnotesize%
    \resizebox{\ifdim\width>\marginparwidth\marginparwidth\else\width\fi}{!}{#2}%
    \@ifnotempty{#1}%%
      {%
        \par%
        \captionsetup{skip=0em,name=fig.,labelfont=bf,textfont=normalfont,justification=raggedright,singlelinecheck=off,font=footnotesize,width=\marginparwidth}%
        \noindent\rule{2.5em}{0.4pt}\par%
        \@elif{\equal{#3}{unstarred}}{\captionbox{#1}{}}{\captionbox*{#1}{}}%
      }%
    \end{figure}%
  }%
}
\NewEnviron{marginfig}[1][\@empty]{\@marginfig{#1}{\BODY}{unstarred}}
\NewEnviron{marginfig*}[1][\@empty]{\@marginfig{#1}{\BODY}{starred}}


% fig
\newcommand\@fig[3]
{%
    \begin{figure}[H]%
    \centering%
    \resizebox{\ifdim\width>\linewidth\linewidth\else\width\fi}{!}{#2}%
    \@ifnotempty{#1}%
    {%
      \par%
      \captionsetup{skip=0.5em,labelfont=bf,textfont=normalfont,width=0.75\textwidth}%
      \noindent\rule{0.2\textwidth}{0.4pt}
      \@elif{\equal{#3}{unstarred}}{\caption{#1}}{\caption*{#1}}%
    }%
    \end{figure}%
}
\NewEnviron{fig}[1][\@empty]{\@fig{#1}{\BODY}{unstarred}}
\NewEnviron{fig*}[1][\@empty]{\@fig{#1}{\BODY}{starred}}


% theorems
\newcounter{notes@theorem}[section]
\newcounter{notes@proposition}[section]
\newcounter{notes@corollary}[section]
\newcounter{notes@lemma}[section]
\newcounter{notes@example}[section]
\NewEnviron{theorem}[1][\@empty]
{%
  \par%
  \begin{tcolorbox}[%
    enhanced,%
    frame hidden,%
    breakable, %
    colback=black!40!cyan!8!white,%
    arc=0.3em, left=0.5em, right=0.5em, top=1em, bottom=1em,leftrule=-1em,rightrule=-1em]%
    \stepcounter{notes@theorem}%
    \noindent%
    {\large\scshape Theorem \arabic{section}.\arabic{notes@theorem}}%
    {\hskip 0.4em\itshape\@ifnotempty{#1}{(#1)}}%
    {.\par\vspace{-0.5em}\rule{4.5em}{0.6pt}\vskip0.75em\itshape\BODY}%
  \end{tcolorbox}%
  \vskip 0.5em%
}
\NewEnviron{proof}
{%
  \par%
  \noindent%
  {\itshape\lsstyle Proof.\hskip0.6em}%
  {\BODY}%
  {\hfill$\square$}
  \vskip 0.5em%
}
% proposition
\NewEnviron{proposition}[1][\@empty]
{%
  \par%
  \begin{tcolorbox}[%
    enhanced,%
    frame hidden,%
    breakable, %
    colback=black!40!orange!8!white,%
    arc=0.3em, left=0.5em, right=0.5em, top=1em, bottom=1em,leftrule=-1em,rightrule=-1em]%
    \stepcounter{notes@proposition}%
    \noindent%
    {\scshape Proposition \arabic{section}.\arabic{notes@proposition}}%
    {\hskip 0.4em\itshape\@ifnotempty{#1}{(#1)}}%
    {.\hskip 0.6em\itshape\BODY}%
  \end{tcolorbox}%
  \vskip 0.5em%
}

% corollary
\NewEnviron{corollary}[1][\@empty]
{%
  \par%
  \begin{tcolorbox}[%
    enhanced,%
    frame hidden,%
    breakable, %
    colback=black!40!orange!8!white,%
    arc=0.3em, left=0.5em, right=0.5em, top=1em, bottom=1em,leftrule=-1em,rightrule=-1em]%
    \stepcounter{notes@corollary}%
    \noindent%
    {\scshape Corollary \arabic{section}.\arabic{notes@corollary}}%
    {\hskip 0.4em\itshape\@ifnotempty{#1}{(#1)}}%
    {.\hskip 0.6em\itshape\BODY}%
  \end{tcolorbox}%
  \vskip 0.5em%
}

% lemma
\NewEnviron{lemma}[1][\@empty]
{%
  \par%
  \begin{tcolorbox}[%
    enhanced,%
    frame hidden,%
    breakable, %
    colback=black!40!orange!8!white,%
    arc=0.3em, left=0.5em, right=0.5em, top=1em, bottom=1em,leftrule=-1em,rightrule=-1em]%
    \stepcounter{notes@lemma}%
    \noindent%
    {\scshape Lemma \arabic{section}.\arabic{notes@lemma}}%
    {\hskip 0.4em\itshape\@ifnotempty{#1}{(#1)}}%
    {.\hskip 0.6em\itshape\BODY}%
  \end{tcolorbox}%
  \vskip 0.5em%
}

% example
\NewEnviron{example}[1][\@empty]
{%
  \par%
  \begin{tcolorbox}[%
    enhanced,%
    frame hidden,%
    breakable, %
    colback=black!40!purple!8!white,%
    arc=0.3em, left=0.5em, right=0.5em, top=1em, bottom=1em,leftrule=-1em,rightrule=-1em]%
    \stepcounter{notes@example}%
    \noindent%
    {\large\scshape Example \arabic{section}.\arabic{notes@example}}%
    {\hskip 0.4em\@ifnotempty{#1}{(#1)}}%
    {.\par\vspace{-0.5em}\rule{4.5em}{0.6pt}\vskip0.75em\BODY}%
  \end{tcolorbox}%
  \vskip 0.5em%
}

% lemma
\NewEnviron{remark}[1][\@empty]
{%
  \par%
  \begin{tcolorbox}[%
    enhanced,%
    frame hidden,%
    breakable, %
    colback=black!60!white!8!white,%
    arc=0.3em, left=0.5em, right=0.5em, top=1em, bottom=1em,leftrule=-1em,rightrule=-1em]%
    \noindent%
    {\scshape Remark}%
    {\hskip 0.4em\@ifnotempty{#1}{(#1)}}%
    {.\hskip 0.6em\BODY}%
  \end{tcolorbox}%
  \vskip 0.5em%
}



%%% P A G E   L A Y O U T
% header and footer
\pagestyle{fancy}
\renewcommand{\sectionmark}[1]{\markboth{#1}{}}
\cfoot{}
\fancyhead[L]{\footnotesize\scshape\thesection{\hskip1em}\leftmark}
\fancyhead[R]{\footnotesize\scshape\@elifdef{\@coursetitle}{\@coursetitle}{\@thetitle}\hskip1em\thepage}
% \@ifnone\@twoside{\fancyheadoffset[R]{1.5in}}


% section headers
\titleformat{\section}{\relax\Large\lsstyle}{\thesection}{1em}{\itshape}
\titleformat{\subsection}{\relax\large\lsstyle}{\thesubsection}{1em}{\itshape}
\titleformat{\subsubsection}{\relax\normalsize\lsstyle}{\thesubsubsection}{1em}{\itshape}


% title information
\def  \title          #1  {\def\@thetitle{#1}}
\def  \authors        #1  {\def\@authors{#1}}
\def  \professor      #1  {\def\@professor{#1}}
\def  \scribe         #1  {\def\@scribe{#1}}
\def  \subtitle       #1  {\def\@subtitle{#1}}
\def  \coursetitle    #1  {\def\@coursetitle{#1}}
\def  \coursecode     #1  {\def\@coursecode{#1}}
\def  \coursecodelong #1  {\def\@coursecodelong{#1}}
\def  \place          #1  {\def\@place{#1}}
\def  \season         #1  {\def\@season{#1}}
\def  \year           #1  {\def\@theyear{#1}}
\def  \date       #1#2#3  {\def\@datedef{}\newdate{@date}{#1}{#2}{#3}}
\def  \and%
  {%
    \@elifdef\@nomargin
      {\end{tabular}\hskip 2em\@plus.17fil\begin{tabular}[t]{@{}l}}
      {\par}%
  }
\def  \authorhref [#1]#2%
  {%
    \@elifdef\@nomargin
      {\\\href{#1}{\color{red!70}\texttt{#2}}}%
      {\footnote{\href{#1}{\color{black}\texttt{#2}}}}%
  }

\renewcommand\maketitle{\par
  \begingroup%
  \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
  \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
  \long\def\@makefntext##1{\noindent%
    \hb@xt@2em{%
      \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
  \thispagestyle{empty}
  \@maketitle
  \@thanks%
  \endgroup%
  \setcounter{footnote}{0}%
}

\renewcommand{\@maketitle}{
  \let \footnote \thanks
  \@elifdef\@titlepage%
  {%
    \newgeometry{margin=1in}%
    \newpage%
    \null%
    \vskip1.5em%
    \itshape%
    \begin{flushleft}%
    \end{flushleft}%
    \restoregeometry%
    \newpage%
  }%
  % \vskip 1.5in%
  {%
    \newpage
    \null
    \begin{center}%
      %%% Course Information
      {%
        \Large%
        \scshape%
        \@elifdef\@coursecodelong%
          {\protect\textls[100]{\protect\MakeLowercase{\@coursecodelong}}}%
          {\@ifdef{\@coursecode}{\protect\textls[100]{\protect\MakeLowercase{\@coursecode}}}}%
        \vskip 0.25em%
      }%
      %%% Title
      {%
        \itshape%
        {\itshape\huge\@thetitle\par}%
        \@ifdef\@subtitle{\itshape\vskip0.1em\Large\@subtitle\par}%
        \vskip 0.75em%  
      }%
      % %%% Authors
      % \@ifdef\@authors{%
      %   % \normalsize%
      %   % \lineskip 0.5em%
      %   % \begin{tabular}[t]{@{}l}%
      %   %   \@authors%
      %   % \end{tabular}%
      %   \marginpar[0em]{asdasdasd}%
      %   \par%
      %   \vskip 0.75em%
      % }%
      \@elifdef\@datedef%
      {\normalsize\itshape\displaydate{@date}}%
      {\normalsize\itshape%
      \@ifdef\@season{\@season}%
      \@ifbothdef\@season\@theyear{\!, }%
      \@ifdef\@theyear{\@theyear}}%
      \vskip 0.75em%
    \end{center}%
    \par%
    %%% Aside
    \@ifnone\@nomargin{%
      \marginpar
      {%
      %%% Authors
      \vspace{3em}%
      \@ifdef\@professor{\textls[100]{\scshape professor:\par}\@professor\vskip 1em}%
      \@ifdef\@scribe{\textls[100]{\scshape scribe:\par}\@scribe\vskip 1em}%
      \@ifdef\@authors{\textls[100]{\scshape authors:\par}\@authors\vskip 1em}%
      \@ifdef\@place{\textls[100]{\scshape place:\par}\@place\vskip 1em}%
      }%
    }%
  }%
}


% table of Contents
\renewcommand{\cftsecfont}{}
\renewcommand{\cftsubsecfont}{}
\renewcommand{\cftsubsubsecfont}{}
\renewcommand{\cftsecpagefont}{}
\renewcommand{\tableofcontents}{%
  % {\large\itshape\contentsname\par}%
  \section*{\contentsname}%
  \vspace{-1em}%
  {\small\setstretch{0.9}\@starttoc{toc}}%
}


% begin document
\AtBeginDocument{%
  \hfuzz=\marginparwidth%
  \newdimen\hfuzz%
  \hbadness=10000%
  \newdimen\hbadness%
  \@ifdef\@coursetitle\@ifnone\@thetitle{\title{\@coursetitle}}
  \maketitle
  % \vskip 1em%
  % \noindent\makebox[\linewidth]{\rule{0.5\linewidth}{0.4pt}}
  \vskip 1em%
  \tableofcontents
  \vskip 2.5em%
}
