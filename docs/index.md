# LaTeX class for notes and textbooks

[![Open Source Love](https://badges.frapsoft.com/os/mit/mit.svg?v=102)](https://github.com/ellerbrock/open-source-badge/)

[![forthebadge](https://forthebadge.com/images/badges/gluten-free.svg)](http://forthebadge.com)

**Author:** Matthew A. Nazari

**Current release:** v1.1 <a href="https://github.com/mattynaz/latex-notes/releases/latest"><img src="https://img.shields.io/badge/Download-latest%20release-brightgreen.svg" style="vertical-align: text-bottom;margin-left: 1.5em;"></a>

**Description:** A LaTeX document class built lecture notes and textbooks.

**Download**: Simply [download the latest release](https://github.com/mattynaz/latex-notes/releases/latest) and manually extract the required `.cls` file.

## Installing the class
Drag the `.cls` file into your the folder of your current LaTeX project. If you want the class to be available for all projects on your system, drag the `.cls` file into your LaTeX document tree (your `texmf` folder). Note that this might be different depending on different versions of TeX. On Mac, find your `texmf` folder by running `kpsewhich -var-value=TEXMFHOME`. Then, directory `.../texmf/tex/latex/notes` to a `notes` folder which will hold the `.cls` file. 

## Working with the class
Your documents based on this lecture class must adhere to the following blueprint:

```LaTeX
\documentclass[...]{notes}

\begin{document}
  ...
\end{document}
```

There are several optional commands to put in the preamble (before `\begin{document}`) to customize the title of the document:
```LaTeX
\documentclass[...]{notes}

% Title of document.
\title{}

% Subtitle goes under title text.
\subtitle{}

% Title of course will be the document title if title not given.
\coursetitle{}

% Course code to display above title text.
\coursecode{}

% Optional description to display at bottom of title.
\flag{}

\season{}
\year{}
\date{dd}{mm}{yyyy}
\authors{}
\professor{}
\scribe{}
\place{}

\begin{document}
  ...
\end{document}
```

Formatting the person commands, `\authors`, `\professor`, `scribe`, can be done with
- `\and`,
- `\thanks`,
- and `\titlehref`:

```LaTeX
% Seperate people with `\and` and add footnotes with `\thanks`.
\authors{First Person \and Second Person\thanks{a footnote}}

% Add an href with `\titlehref{url}`...
\professor{Jane Doe\titlehref{https://janedoe.com/}}

% ... or specify display text with `\titlehref[url]{display text}[optional display tag]`.
\scirbe{John Doe\titlehref[mailto:john@doe.com]{john@doe}[personal email]}
```

### Examples
Refer to the [example.tex](examples/example.tex) file for an example on how to use some of the environments, commands, and shortcuts available in your document. Take a look at [example.pdf](examples/example.pdf) to see the final product.
I highly encourage looking at [theorems.pdf](examples/theorems.pdf) to see how each of the 5 theorem style presets look compared to one another:

![theorem presets](https://i.imgur.com/tg16Mae.png)

### Options
You can include options for your document by passing them like so: `\documentclass[options, go, here]{notes}`. All of the options available are below:

1. Specify any theorem presets by style:
- `notheorems`
- `plain`
- `boxed`
- `colorbox`
- `graybox` or `greybox` **(default)**
- `flashcard`

2. Tune the formatting of your document:
- `plainnums` for plain numeral styles versus the default old style numerals
- `twoside` for printing
- `centertitle` centers the title text 
- `titlepage` have the title be on its own page
- `nomargin` for symmetric margins
- `noheader` for no header
- `notablecontents` for no table of contents
- `notitle` for no title

3. Date formats
- `isodate` *YYYY-MM-DD*
- `usdate` *Month DD, YYYY*
- `usdateshort` *MM-DD-YYYY*
- `eurodate` *DD Month YYYY* **(default)**

### Environments
There are custom environments already defined which you can use in your document

Create a figure with `\begin{fig}[optional caption]` or `\begin{fig*}[optional caption]`:
```LaTeX
\begin{fig}[an optional caption]
  \includegraphics{graph}
\end{marginfig}
```

Place a figure in the margin with `\begin{marginfig}[optional caption]` or `\begin{marginfig*}[an optional caption]`:
```LaTeX
\begin{marginfig}[the caption]
  \begin{tikzpicture}[main/.style = {draw, circle}]
    \node[main] (1) {$x_1$};
  \end{tikzpicture}
\end{marginfig}
```

Create a custom theorem environment with `\begin{theoremname}[optional term name]`:
```LaTeX
\begin{proposition}[A basic proposition]
  If $x = 10$, then 2 divides $y = \frac{x}{2}$.
\end{proposition}
```

### Commands and Shortcuts
There are some additional commands you can use _inside your document_, i.e. within `\begin{document}` and `\end{document}`, besides those which are already part of the blueprint given above:

Fonts are specified with `\bold`, `\italics`, `\normalfont`, `\smallcaps`, and `\spacedletters`. These also have command forms that won't override eachother. Note that `\normalfont` overrides any font styling:
```LaTeX
\bf{This text is bold.}
{\bold That is equivalent to this.}

\it{This text is bold.}
{\italics That is \bf{exactly} equivalent to this.}

\sc{This text is in smallcaps.}
{\smallcaps That is \bf{exactly} equivalent to this.}

\spaced{This text is spaced out.}
{\spacedletters That is \bf{exactly} equivalent to this.}

\bf{\normalfont This text is normal since it was normalized.}
```

There are also many math shortcuts. Not all are specified here, so taking a peak inside the `.cls` file might be useful.

Place somethin in the margin with `\marginpar[optional vspace]{...}`:
```LaTeX
This is a paragraph.
\marginpar[1in]{\italics This is a side note placed 1in above the end the paragraph.}
```

Create a new theorem with `\newtheorem{name}{Display name}[options][counter]`:
```LaTeX
\newtheorem{thm}{Theorem}[
  style      = {boxed}, % only one of: plain/boxed/colorbox/flashcard
  nocounter  = {false}, % only either: true/false
  big        = {false}, % only either: true/false
  titlefont  = {\bold},
  termfont   = {\bold\italics},
  bodyfont   = {\normalfont\small},
  backcolor  = black!6,
  framecolor = cyan!80!white,
][section]

\begin{thm}[Example Theorem]
  ...
\end{thm}
```

### Dependencies
`amsmath` &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; `amssymb` &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; `caption` &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; `changepage` &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; `environ` &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; `fancyhdr` &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; `float` &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; `hyperref` &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; `geometry` &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; `keyval` &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; `microtype` &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; `newpxmath` &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; `newpxtext` &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; `setspace` &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; `tcolorbox` &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; `tikz` &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; `tocloft` &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; `titlesec` &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; `xcolor` &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; `xparse` &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;


## Version history
### 1.1
- Added theorem preset examples to `README.MD`.
- Added `notitle` and `noheader` options.

### 1.0
Initial release.

<!-- ## The road ahead
### Contributions -->

## End notes
### License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

### Acknowledgments
Thanks to [V.H. Belvadi](https://vhbelvadi.com/latex-lecture-notes-class/) for inspiration for this `README.md`.
