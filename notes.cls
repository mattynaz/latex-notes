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
\newcommand  \@elifempty   [3]  {\@elif{\equal{#1}{\@empty}}{#2}{#3}}
\newcommand  \@ifnotempty  [2]  {\@elif{\equal{#1}{\@empty}}{}{#2}}

% Datetime
\RequirePackage[nodayofweek]{datetime}
\newdateformat{isodate}{\THEYEAR-\twodigit{\THEMONTH}-\twodigit{\THEDAY}}
\newdateformat{usdateshort}{{\THEMONTH}-{\THEDAY}-{\THEYEAR}}
\newdateformat{eurodate}{{\THEDAY} {\monthname[\THEMONTH]} {\THEYEAR}}
\eurodate



%%% O P T I O N S
% numeral style
\DeclareOption{plainnums}{\def\notes@opt@plainnums{}}

% date formats
\DeclareOption{isodate}{\isodate}
\DeclareOption{usdate}{\usdate}
\DeclareOption{usdateshort}{\usdateshort}
\DeclareOption{eurodate}{\eurodate}

% page layout
\DeclareOption{twoside}{\def\notes@opt@twoside{}}
\DeclareOption{titlepage}{\def\notes@opt@titlepage{}}
\DeclareOption{centertitle}{\def\notes@opt@centertitle{}}
\DeclareOption{notablecontents}{\def\notes@opt@notoc{}}
\DeclareOption{nomargin}{\def\notes@opt@nomargin{}}
\DeclareOption{notitle}{\def\notes@opt@notitle{}}
\DeclareOption{noheader}{\def\notes@opt@noheader{}}

% environment styles
\DeclareOption{notheorems}{\def\notes@opt@nothms{}}
\DeclareOption{plain}{\def\notes@opt@plainthms{}}
\DeclareOption{colorbox}{\def\notes@opt@colorboxthms{}}
\DeclareOption{graybox}{\def\notes@opt@graythms{}}
\DeclareOption{greybox}{\def\notes@opt@graythms{}}
\DeclareOption{boxed}{\def\notes@opt@boxedthms{}}
\DeclareOption{flashcard}{\def\notes@opt@flashcardthms{}}


% process options
\ProcessOptions
\@ifnone\notes@opt@plainnums{\PassOptionsToPackage{osf}{newpxtext}}
\@ifdef\notes@opt@twoside{\PassOptionsToPackage{twoside}{article}}
\@elifdef\notes@opt@nomargin{\PassOptionsToPackage{top=1.25in,bottom=1.25in,inner=1.25in,outer=1.25in}{geometry}}
                            {\PassOptionsToPackage{top=1in,bottom=1.2in,inner=1in,outer=2.25in,marginparwidth=1in,marginparsep=0.25in}{geometry}}



%%% R E Q U I R E D   P A C K A G E S
\LoadClass{article}
\RequirePackage[heightrounded]{geometry}
\RequirePackage{newpxtext}
\RequirePackage{newpxmath}
\RequirePackage{setspace}
\RequirePackage{microtype}
\RequirePackage{xcolor}
\RequirePackage[colorlinks,linkcolor=black,citecolor=black,urlcolor=black]{hyperref}
\RequirePackage{tikz}
\RequirePackage{caption} % http://www.peteryu.ca/tutorials/publishing/latex_captions_old STYLING CAPTIONS
\RequirePackage{float}
\RequirePackage{changepage}
\RequirePackage{fancyhdr}
\RequirePackage{keyval}
\RequirePackage{xparse}
\RequirePackage{environ}
\RequirePackage[most]{tcolorbox}
\RequirePackage{titlesec}
\RequirePackage[titles]{tocloft}
\RequirePackage{amsmath}
\usepackage{amssymb} %% <- for \square and \blacksuare



%%% S H O R T C U T S
% fonts
\let\italics\itshape
\let\bold\bfseries
\let\smallcaps\scshape
\let\spacedletters\lsstyle
\renewcommand \it[1]{{\italics#1}}
\renewcommand \bf[1]{{\bold#1}}
\renewcommand \sc[1]{{\smallcaps#1}}
\newcommand   \spaced[1]{{\spacedletters#1}}

% math
\newcommand   \N   {\mathcal N}    % N shortcut
\newcommand   \I   {\mathcal I}    % I shortcut
\newcommand   \R   {\vmathbb R}     % reals shortcut
\renewcommand \t   {\text}       % text shortcut
\newcommand   \bm  [1]{\mathbf{#1}}       % text shortcut
\renewcommand \mid {\,|\,}      % less whitespace around \mid
\newcommand   \iid {\overset{\t{\tiny i.i.d.}}{\sim}} % ~i.i.d. shorcut
\newcommand   \pto {\overset{p}{\to}}
\newcommand   \dto {\overset{d}{\to}}
\newcommand   \der [2]{\frac{\partial #1}{\partial #2}}

\DeclareMathOperator* \argmin {argmin}
\DeclareMathOperator* \argmax {argmax}
\DeclareMathOperator  \bias   {bias}
\DeclareMathOperator  \corr   {Corr}
\DeclareMathOperator  \E      {E}
\DeclareMathOperator  \Var    {Var}
\DeclareMathOperator  \SD     {SD}
\DeclareMathOperator  \SE     {SE}
\DeclareMathOperator  \MSE    {MSE}
\DeclareMathOperator  \MAE    {MAE}
\DeclareMathOperator  \Bin    {Bin}



%%% E N V I R O N M E N T S
% marginpar
\let\oldmarginpar\marginpar
\renewcommand\marginpar[2][0em]{\oldmarginpar{\raggedright\footnotesize{\vspace{#1}#2}}}

% marginfig
\newcommand\notes@marginfig[3]{%
  \marginpar{%
    \begin{figure}[H]%
    \footnotesize%
    \resizebox{\ifdim\width>\marginparwidth\marginparwidth\else\width\fi}{!}{#2}%
    \@ifnotempty{#1}{%
      \par%
      \captionsetup{skip=0em,name=fig.,labelfont=bf,textfont=normalfont,justification=raggedright,singlelinecheck=off,font=footnotesize,width=\marginparwidth}%
      \noindent\rule{2.5em}{\notes@rulewidth}\par%
      \vspace{-0.6em}\@elif{\equal{#3}{unstarred}}{\captionbox{#1}{}}{\captionbox*{#1}{}}%
    }%
    \end{figure}%
  }%
}
\NewEnviron{marginfig}[1][\@empty]{\notes@marginfig{#1}{\BODY}{unstarred}}
\NewEnviron{marginfig*}[1][\@empty]{\notes@marginfig{#1}{\BODY}{starred}}

% fig
\newcommand\notes@fig[3]{%
  \begin{figure}[H]%
  \centering%
  \resizebox{\ifdim\width>\linewidth\linewidth\else\width\fi}{!}{#2}%
  \@ifnotempty{#1}{%
    \par%
    \captionsetup{skip=0.5em,labelfont=bf,textfont=normalfont,justification=raggedright,format=hang,width=0.75\textwidth}%
    \noindent\rule{0.2\textwidth}{\notes@rulewidth}
    \@elif{\equal{#3}{unstarred}}{\caption[sadasd]{#1}}{\caption*{#1}}%
  }%
  \end{figure}%
}
\NewEnviron{fig}[1][\@empty]{\notes@fig{#1}{\BODY}{unstarred}}
\NewEnviron{fig*}[1][\@empty]{\notes@fig{#1}{\BODY}{starred}}


% theorems
\define@key{notes@maketheorem}{style}{\def\notes@makethm@style{#1}}
\define@key{notes@maketheorem}{nocounter}{\def\notes@makethm@nocounter{#1}}
\define@key{notes@maketheorem}{big}{\def\notes@makethm@big{#1}}
\define@key{notes@maketheorem}{titlefont}{\def\notes@makethm@titlefont{#1}}
\define@key{notes@maketheorem}{termfont}{\def\notes@makethm@termfont{#1}}
\define@key{notes@maketheorem}{bodyfont}{\def\notes@makethm@bodyfont{#1}}
\define@key{notes@maketheorem}{backcolor}{\def\notes@makethm@backcolor{#1}}
\define@key{notes@maketheorem}{framecolor}{\def\notes@makethm@framecolor{#1}}
\DeclareDocumentCommand{\notes@maketheorem}{m m m m m m}{%
  \begingroup%
  \setkeys{notes@maketheorem}{style=plain,nocounter=false,big=false,%
                              titlefont={\bold},termfont={\italics},bodyfont={\italics},%
                              backcolor=black!6,framecolor=black,#6}%
  \@elif{\equal{\notes@makethm@nocounter}{false}}{\stepcounter{notes@#2}}{}%
  % plain style
  \@elif{\equal{\notes@makethm@style}{plain}}{%
    \@elif{\equal{\notes@makethm@big}{false}}%
    {% small
      \vskip 0.5em%
      {\par\noindent\notes@makethm@titlefont#3 \@elif{\equal{\notes@makethm@nocounter}{false}}{\@elifempty{#4}{}{\@elif{\equal{#4}{subsection}}{\arabic{section}.}{}\arabic{#4}.}\arabic{notes@#2}}{}}%
      {\@elifempty{#5}{\hskip0.4em}{\hskip0.4em{\notes@makethm@termfont(#5)}.\hskip0.6em}}%
      {\noindent\notes@makethm@bodyfont#1}%
      \vskip 0.75em%
    }%
    {% big
      \vskip 0.15em%
      {\noindent\rule{0.9\linewidth}{1.2\notes@rulewidth}\vskip0.15em}%
      {\noindent\notes@makethm@titlefont#3 \@elif{\equal{\notes@makethm@nocounter}{false}}{\@elifempty{#4}{}{\@elif{\equal{#4}{subsection}}{\arabic{section}.}{}\arabic{#4}.}\arabic{notes@#2}}{}}%
      {\@elifempty{#5}{\hskip0.4em}{\hskip0.4em{\notes@makethm@termfont(#5)}.\hskip0.6em}}%
      {\vskip0.3em\noindent\notes@makethm@bodyfont#1}%
      {\par\vspace{-0.25em}\noindent\rule{0.9\linewidth}{1.2\notes@rulewidth}}%
      \vskip 0.75em%
    }%
  }{}%
  % boxed style
  \@elif{\equal{\notes@makethm@style}{boxed}}{%
    \begin{tcolorbox}[enhanced,breakable,colback=\notes@makethm@backcolor,colframe=\notes@makethm@framecolor,boxrule=0.05em,%
                      arc=0.15em,left=0.6em,right=0.6em,top=0.85em,bottom=0.85em,]%
    \@elif{\equal{\notes@makethm@big}{false}}%
    {% small
      {\par\noindent\notes@makethm@titlefont#3 \@elif{\equal{\notes@makethm@nocounter}{false}}{\@elifempty{#4}{}{\@elif{\equal{#4}{subsection}}{\arabic{section}.}{}\arabic{#4}.}\arabic{notes@#2}}{}}%
      {\@elifempty{#5}{\hskip0.4em}{\hskip0.4em{\notes@makethm@termfont(#5)}.\hskip0.6em}}%
      {\noindent\notes@makethm@bodyfont#1}%
    }%
    {% big
      {\par\noindent\notes@makethm@titlefont#3 \@elif{\equal{\notes@makethm@nocounter}{false}}{\@elifempty{#4}{}{\@elif{\equal{#4}{subsection}}{\arabic{section}.}{}\arabic{#4}.}\arabic{notes@#2}}{}}%
      {\@elifempty{#5}{\hskip0.4em}{\hskip0.4em{\notes@makethm@termfont(#5)}.\hskip0.6em}}%
      {\par\vspace{-0.8em}\noindent\rule{4.5em}{\notes@rulewidth}\vskip0.2em\noindent\notes@makethm@bodyfont#1}%
    }%
    \end{tcolorbox}%
    \vskip 0.20em%
  }{}%
  % colorbox style
  \@elif{\equal{\notes@makethm@style}{colorbox}}{%
    \begin{tcolorbox}[enhanced,breakable,frame hidden,colback=\notes@makethm@backcolor,%
                      arc=0.15em,left=0.70em,right=0.70em,top=0.85em,bottom=0.85em,leftrule=-0.8em,rightrule=-0.8em]%
    \@elif{\equal{\notes@makethm@big}{false}}%
    {% small
      {\par\noindent\notes@makethm@titlefont#3 \@elif{\equal{\notes@makethm@nocounter}{false}}{\@elifempty{#4}{}{\@elif{\equal{#4}{subsection}}{\arabic{section}.}{}\arabic{#4}.}\arabic{notes@#2}}{}}%
      {\@elifempty{#5}{\hskip0.4em}{\hskip0.4em{\notes@makethm@termfont(#5)}.\hskip0.6em}}%
      {\noindent\notes@makethm@bodyfont#1}%
    }%
    {% big
      {\par\noindent\notes@makethm@titlefont#3 \@elif{\equal{\notes@makethm@nocounter}{false}}{\@elifempty{#4}{}{\@elif{\equal{#4}{subsection}}{\arabic{section}.}{}\arabic{#4}.}\arabic{notes@#2}}{}}%
      {\@elifempty{#5}{\hskip0.4em}{\hskip0.4em{\notes@makethm@termfont(#5)}.\hskip0.6em}}%
      {\par\vspace{-0.5em}\noindent\rule{2.5em}{\notes@rulewidth}\vskip0.2em\noindent\notes@makethm@bodyfont#1}%
    }%
    \end{tcolorbox}%
    \vskip 0.20em%
  }{}%
  % flashcard style
  \@elif{\equal{\notes@makethm@style}{flashcard}}{%
    \begin{tcolorbox}[enhanced,breakable,colback=\notes@makethm@backcolor,colframe=\notes@makethm@framecolor,boxrule=0.1em,%
                      title={\vspace{0.3em}{\notes@makethm@titlefont#3 \@elif{\equal{\notes@makethm@nocounter}{false}}{\@elifempty{#4}{}{\@elif{\equal{#4}{subsection}}{\arabic{section}.}{}\arabic{#4}.}\arabic{notes@#2}}{}}%
                             {\@elifempty{#5}{}{\hskip0.4em{\notes@makethm@termfont(#5)}.\hskip0.6em}}\vspace{0.15em}},%
                      arc=0.15em,left=0.55em,right=0.55em,top=0.7em,bottom=0.7em]%
      {\noindent\notes@makethm@bodyfont#1}%
    \end{tcolorbox}%
    \vskip 0.20em%
  }{}%
  \endgroup%
}

\DeclareDocumentCommand{\newtheorem}{mmO{}O{section}}{%
  \@elifempty{#4}{\newcounter{notes@#1}}{\newcounter{notes@#1}[#4]}%
  \NewEnviron{#1}[1][\@empty]{%
    \@elif{\equal{#1}{definition}}{\marginpar[1.5em]{{\bold def.} {\italics ##1}}}{}%
    \notes@maketheorem{\BODY}{#1}{#2}{#4}{##1}{#3}%
  }%
}


%%% P A G E   L A Y O U T
% default theorems
\@elifdef{\notes@opt@nothms}{
}{\@elifdef{\notes@opt@colorboxthms}{
  \newtheorem{theorem}{Theorem}[style=colorbox,big=true,backcolor=black!10!cyan!8]
  \newtheorem{lemma}{Lemma}[style=colorbox,big=false,backcolor=black!40!blue!8]
  \newtheorem{corollary}{Corollary}[style=colorbox,big=false,backcolor=black!40!blue!8]
  \newtheorem{proposition}{Proposition}[style=colorbox,big=false,backcolor=black!40!blue!8]
  \newtheorem{example}{Example}[style=colorbox,big=true,bodyfont={\normalfont},termfont={\bold\italics},backcolor=black!25!red!9]
  \newtheorem{remark}{Remark.}[style=colorbox,big=false,backcolor=black!20!orange!10,nocounter=true,bodyfont={\normalfont}]
  \newtheorem{note}{Note.}[style=colorbox,big=false,backcolor=black!20!orange!10,nocounter=true,bodyfont={\normalfont}]
  \newtheorem{definition}{Definition}[style=colorbox,big=false,backcolor=black!20!purple!8,bodyfont={\normalfont},termfont={\bold\italics}]
}{\@elifdef{\notes@opt@plainthms}{
  \newtheorem{theorem}{Theorem}[style=plain,big=false,termfont={\bold\italics}]
  \newtheorem{lemma}{Lemma}[style=plain,big=false,termfont={\bold\italics}]
  \newtheorem{corollary}{Corollary}[style=plain,big=false,termfont={\bold\italics}]
  \newtheorem{proposition}{Proposition}[style=plain,big=false,termfont={\bold\italics}]
  \newtheorem{example}{Example}[style=plain,big=false,bodyfont={\normalfont},termfont={\bold\italics}]
  \newtheorem{remark}{Remark.}[style=plain,big=false,nocounter=true,bodyfont={\normalfont}]
  \newtheorem{note}{Note.}[style=plain,big=false,nocounter=true,bodyfont={\normalfont}]
  \newtheorem{definition}{Definition}[style=plain,big=false,bodyfont={\normalfont},termfont={\bold\italics}]
}{\@elifdef{\notes@opt@boxedthms}{
  \newtheorem{theorem}{Theorem}[style=boxed,big=true,backcolor=white]
  \newtheorem{lemma}{Lemma}[style=boxed,big=false,backcolor=white]
  \newtheorem{corollary}{Corollary}[style=boxed,big=false,backcolor=white]
  \newtheorem{proposition}{Proposition}[style=boxed,big=false,backcolor=white]
  \newtheorem{example}{Example}[style=boxed,big=true,backcolor=white,bodyfont={\normalfont},termfont={\bold\italics}]
  \newtheorem{remark}{Remark.}[style=boxed,big=false,backcolor=white,nocounter=true,bodyfont={\normalfont}]
  \newtheorem{note}{Note.}[style=boxed,big=false,backcolor=white,nocounter=true,bodyfont={\normalfont}]
  \newtheorem{definition}{Definition}[style=boxed,big=false,backcolor=white,bodyfont={\normalfont},termfont={\bold\italics}]
}{\@elifdef{\notes@opt@flashcardthms}{
  \newtheorem{theorem}{Theorem}[style=flashcard,big=true,framecolor=cyan!80!black!65,backcolor=white,termfont={\bold\italics}]
  \newtheorem{lemma}{Lemma}[style=flashcard,big=false,framecolor=blue!55!black!60,backcolor=white,termfont={\bold\italics}]
  \newtheorem{corollary}{Corollary}[style=flashcard,big=false,framecolor=blue!55!black!60,backcolor=white,termfont={\bold\italics}]
  \newtheorem{proposition}{Proposition}[style=flashcard,big=false,framecolor=blue!55!black!60,backcolor=white,termfont={\bold\italics}]
  \newtheorem{example}{Example}[style=flashcard,big=true,framecolor=red!90!black!60,backcolor=white,bodyfont={\normalfont},termfont={\bold\italics}]
  \newtheorem{remark}{Remark.}[style=flashcard,big=false,framecolor=black!45,backcolor=white,nocounter=true,bodyfont={\normalfont}]
  \newtheorem{note}{Note.}[style=flashcard,big=false,framecolor=black!45,backcolor=white,nocounter=true,bodyfont={\normalfont}]
  \newtheorem{definition}{Definition}[style=flashcard,big=false,framecolor=black!45,backcolor=white,bodyfont={\normalfont},termfont={\bold\italics}]
}{
  \newtheorem{theorem}{Theorem}[style=colorbox,big=true,termfont={\bold\italics},backcolor=black!5]
  \newtheorem{lemma}{Lemma}[style=colorbox,big=false,termfont={\bold\italics},backcolor=black!5]
  \newtheorem{corollary}{Corollary}[style=colorbox,big=false,termfont={\bold\italics},backcolor=black!5]
  \newtheorem{proposition}{Proposition}[style=colorbox,big=false,termfont={\bold\italics},backcolor=black!5]
  \newtheorem{example}{Example}[style=colorbox,big=true,bodyfont={\normalfont},termfont={\bold\italics},backcolor=black!5]
  \newtheorem{remark}{Remark.}[style=colorbox,big=false,backcolor=black!5,nocounter=true,termfont={\bold\italics},bodyfont={\normalfont}]
  \newtheorem{note}{Note.}[style=colorbox,big=false,backcolor=black!5,nocounter=true,termfont={\bold\italics},bodyfont={\normalfont}]
  \newtheorem{definition}{Definition}[style=colorbox,big=false,backcolor=black!5,bodyfont={\normalfont},termfont={\bold\italics}]
}}}}}

\NewEnviron{proof}{\vskip0.25em\noindent{\italics\spacedletters Proof.\hskip0.5em}\BODY\hfill$\square$\vskip0.5em}


% title information
\renewcommand \title          [1] {\newcommand\notes@title{#1}}
\newcommand   \authors        [1] {\newcommand\notes@authors{#1}}
\newcommand   \professor      [1] {\newcommand\notes@prof{#1}}
\newcommand   \scribe         [1] {\newcommand\notes@scribe{#1}}
\newcommand   \subtitle       [1] {\newcommand\notes@subtitle{#1}}
\newcommand   \coursetitle    [1] {\newcommand\notes@ctitle{#1}}
\newcommand   \coursecode     [1] {\newcommand\notes@ccode{#1}}
\newcommand   \coursecodelong [1] {\newcommand\notes@ccodelong{#1}}
\newcommand   \place          [1] {\newcommand\notes@place{#1}}
\newcommand   \season         [1] {\newcommand\notes@season{#1}}
\renewcommand \year           [1] {\newcommand\notes@year{#1}}
\renewcommand \date           [3] {\newcommand\notes@datedef{}\newdate{@date}{#1}{#2}{#3}}
\newcommand   \flag           [1] {\newcommand\notes@flag{#1}}
\renewcommand \and%
{%
  \@elifdef\notes@opt@titlepage%
    {\end{tabular}\hskip 1em\@plus.1fil\begin{tabular}[t]{@{}c}}
    {\par}%
}

\NewDocumentCommand{\titlehref}{omo}{%
  \@elifdef\notes@opt@titlepage%
    {\vspace{-0.25em}\\\href{\IfNoValueTF{#1}{#2}{#1}}{\color{black}\texttt{#2}}}%
    {\footnote{\href{\IfNoValueTF{#1}{#2}{#1}}{\color{black}\texttt{#2}}\IfNoValueTF{#3}{}{\hskip0.5em(#3)}}}%
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
  \let \footnote \thanks%
  \@elifdef\notes@opt@titlepage
  {% title page
    \newgeometry{margin=1in}%
    \null%
    \vfill%
    \begin{center}%
      %%% Course Information
      {%
        \LARGE%
        \smallcaps%
        \@elifdef\notes@ccodelong%
          {\protect\textls[100]{\protect\MakeLowercase{\notes@ccodelong}}}%
          {\@ifdef{\notes@ccode}{\protect\textls[100]{\protect\MakeLowercase{\notes@ccode}}}}%
        \vskip 0.35em%
      }%
      %%% Title
      {%
        \italics%
        {\italics\Huge\notes@title\par}%
        \@ifdef\notes@subtitle{\italics\vskip0.3em\LARGE\notes@subtitle\par}%
      }%
      %%% Date
      {%
        \@elifdef\notes@datedef%
        {\vskip1.2em\large\italics\displaydate{@date}\vskip1em}%
        {\vskip1.2em\large\italics%
         \@ifdef\notes@season{\notes@season}%
         \@ifbothdef\notes@season\notes@year{\!, }%
         \@ifdef\notes@year{\notes@year}
         \vskip1em}%
      }%
      %%% Flag
      {%
        \@ifdef\notes@flag{%
          \vskip2em%
          \italics\normalsize%
          \begin{adjustwidth}{0.3\linewidth}{0.3\linewidth}%
            \centering%
            \notes@flag\par%
          \end{adjustwidth}%
        }%
      }%
      %%% Authors
      {%
      \normalsize%
      \vskip3em%
      \begin{tabular}[t]{@{}c}%
        \@ifdef\notes@authors{\notes@authors\and}%
        \@ifdef\notes@prof{\notes@prof\and}
        \@ifdef\notes@scribe\notes@scribe
      \end{tabular}%
      \par%
      }%
    \end{center}%
    \par%
    \vskip2in%
    \vfill%
    \restoregeometry%
  }%
  {% normal title
    \@ifdef\notes@opt@centertitle{%
      \begingroup%
      \newgeometry{margin=1in}%
    }%
    \begin{center}%
      %%% Course Information
      {%
        \Large%
        \smallcaps%
        \@elifdef\notes@ccodelong%
          {\protect\textls[100]{\protect\MakeLowercase{\notes@ccodelong}}}%
          {\@ifdef{\notes@ccode}{\protect\textls[100]{\protect\MakeLowercase{\notes@ccode}}}}%
        \vskip0.25em%
      }%
      %%% Title
      {%
        \italics%
        {\italics\huge\notes@title\par}%
        \@ifdef\notes@subtitle{\italics\vskip0.1em\Large\notes@subtitle\par}%
      }%
      %%% Date
      {%
        \@elifdef\notes@datedef%
          {\vskip0.8em\normalsize\italics\displaydate{@date}\vskip1em}%
          {\vskip0.8em\normalsize\italics%
           \@ifdef\notes@season{\notes@season}%
           \@ifbothdef\notes@season\notes@year{\!, }%
           \@ifdef\notes@year{\notes@year}
           \vskip1em}%
      }%
      %%% Flag
      {%
        \@ifdef\notes@flag{%
          \italics\small%
          \begin{adjustwidth}{0.3\linewidth}{0.3\linewidth}%
            \centering%
            \noindent\rule[1em]{0.5\linewidth}{0.9\notes@rulewidth}\par%
            \notes@flag\par%
          \end{adjustwidth}%
        }%
      }%
      \vskip0.75em%
    \end{center}%
    \@ifdef\notes@opt@centertitle{\endgroup}%
    \par%
    %%% Aside
    \@ifnone\notes@opt@nomargin{%
      \marginpar
      {%
      %%% Authors
      \vspace{3em}%
      \@ifdef\notes@authors{\textls[100]{\smallcaps authors:\par}\notes@authors\vskip 1em}%
      \@ifdef\notes@prof{\textls[100]{\smallcaps professor:\par}\notes@prof\vskip 1em}%
      \@ifdef\notes@scribe{\textls[100]{\smallcaps scribe:\par}\notes@scribe\vskip 1em}%
      \@ifdef\notes@place{\textls[100]{\smallcaps place:\par}\notes@place\vskip 1em}%
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
  \section*{\contentsname}%
  \vspace{-1em}%
  {\small\setstretch{0.9}\@starttoc{toc}}%
}


% header and footer
\@ifnone\notes@opt@noheader{
  \pagestyle{fancy}
  \fancyhf{}
  \renewcommand{\sectionmark}[1]{\markboth{#1}{}}
  \fancyhead[L]{\footnotesize\smallcaps\thesection{\hskip1em}\leftmark}
  \fancyhead[R]{\footnotesize\smallcaps\@elifdef{\notes@ctitle}{\notes@ctitle}{\notes@title}\hskip1em\thepage}
  \renewcommand\headrulewidth\notes@rulewidth
}

% section headers
\titleformat{\section}{\relax\Large\spacedletters}{\thesection}{1em}{\italics}
\titleformat{\subsection}{\relax\large\spacedletters}{\thesubsection}{1em}{\italics}
\titleformat{\subsubsection}{\relax\normalsize\spacedletters}{\thesubsubsection}{1em}{\italics}


% begin document
\AtBeginDocument{
  % hide overflow / underflow warnings
  \hfuzz=\marginparwidth%
  \hbadness=10000%
  \newdimen\hfuzz%
  \newdimen\hbadness%
  %
  % rule with
  \newdimen\notes@rulewidth
  \setlength{\notes@rulewidth}{0.05em}%
  %
  % line spacing
  \setstretch{1}
  %
  % spacing for the equation environment
  \let\oldequation=\equation%
  \let\endoldequation=\endequation%
  \renewenvironment{equation}{\vspace{0em}\begin{oldequation}}{\vspace{0.5em}\end{oldequation}}%
  %
  % spacing for $$___$$ and align* environments
  \setlength{\abovedisplayskip}{0.5em}%
  \setlength{\abovedisplayshortskip}{0em}%
  \setlength{\belowdisplayskip}{0.5em}%
  \setlength{\belowdisplayshortskip}{0.5em}%
  %
  % default title values
  \@ifdef\notes@ctitle{\@ifnone\notes@title{\title{\notes@ctitle}}}%
  %
  % document begin
  \@ifnone\notes@opt@notitle{\maketitle}%
  \@ifnone\notes@opt@notoc{%
    \vskip 1em%
    \tableofcontents%  
  }%
  \vskip 2.5em%
}
