% ==============================================================================
% Science Olympiad exam formatting class
% Written by: Araneesh Pratap
% Intended to be used in-place with the provided files in the repo
% Refer: https://github.com/araneesh-pratap-01/scioly-exam-template-araneesh
% v1.0.0
% ==============================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{scioly-exam-template-araneesh}[2025/08/07 Araneesh Pratap's Science Olympiad exam formatting class v1.0.0]

\LoadClass{exam} % minimal direct usage (it's opinionated in a direction that doesn't match my needs) but not worth the trouble of rebasing onto article and directly handling page layout myself

\RequirePackage[T1]{fontenc} % mlmodern only comes in T1 apparently
\RequirePackage{mlmodern} % lmodern is unreadable in digital

\RequirePackage[letterpaper,lmargin=0.7in,rmargin=0.7in,tmargin=0.5in,bmargin=0.7in,footskip=0.15in]{geometry} % sufficient margins for pretty much any printer or copier
\RequirePackage{multicol} % setting up two columns
\RequirePackage{totcount} % forward-looking counter for section handling
\RequirePackage{gensymb} % if I don't keep this now I'll forget about it when I actually need it

\RequirePackage{graphicx} % simple images
\RequirePackage{tikz} % image sheet (more constrained, overlays)
\RequirePackage{contour} % outlines on image numbers for image sheet

\RequirePackage{readarray} % data ingestion for questions
\RequirePackage{forloop}

\RequirePackage{data/scioly-exam-template-araneesh-data} % load common data (tournament info)

% == Image Sheet tikz formatting ==
\newcommand{\formatimgnum}[1]{%
    \contour{black}{\textcolor{white}{\Huge{\textbf{#1}}}}%
}
\newcommand{\imagenode}[1]{%
    \node[anchor=north west,draw,inner sep=0pt,line width=1pt] at (0,0) {#1};%
}
\newcommand{\labelnode}[3]{%
    \node[anchor=north west] at (#1,#2) {\formatimgnum{#3}};%
}

% == Helper Commands ==
\newcommand{\pts}[2]{(#2)\addtocounter{sec#1}{#2}}
\newcommand{\ans}[1]{\textcolor{red}{#1}}

\newcommand{\breakans}{\item[]} % Internal line break for answer sheet and key, doesn't increment question number
\newcommand{\breakcolumn}{\vfill\null\columnbreak} % column break with padding

\newcommand{\blankLength}[1]{\rule{#1}{0.5pt}}
\newcommand{\blank}{\blankLength{2.5in}}
\newcommand{\blankFull}{\blankLength{3.0in}}
\newcommand{\blankShort}{\blankLength{1in}}

\newcommand{\sectionheaderTestpacket}[3]{
    \vspace*{#2em}
    \section*{Section #1 - \total{sec#1} points}
    \vspace*{#3em}
}
\newcommand{\sectionheaderKey}[3]{
    \vspace*{#2em}
    \section*{Section #1 \ans{\total{sec#1}}/\total{sec#1} points}
    \vspace*{#3em}
}
\newcommand{\sectionheaderAnswersheet}[3]{
    \vspace*{#2em}
    \section*{Section #1 \rule{0.4in}{0.5pt}/\total{sec#1} points}
    \vspace*{#3em}
}

% == General Document Formatting ==
\pagestyle{foot}
\firstpagefooter{
    {\scriptsize {\printtournament} - {\printdate}}
}{
    {\scriptsize p{\thepage} of \pageref{LastPageRef}}
}{
    {\scriptsize {\printevent} - {\printdoctype}}
}
\runningfooter{
    {\scriptsize {\printtournament} - {\printdate}}
}{
    {\scriptsize p{\thepage} of \pageref{LastPageRef}}
}{
    {\scriptsize {\printevent} - {\printdoctype}}
}
\setlength{\columnsep}{0.3in}

% == Array Setup ==
\readarraysepchar{!!}
\readdef{data/exam-content.txt}{\rawsciolydata}
\readarray*\rawsciolydata\sciolydataarray[-,6]

% == Record Formatters ==
\newcommand{\formatQuestionTestpacket}[1]{%
    \item \sciolydataarray[#1,4]~\pts{\sciolydataarray[#1,2]}{\sciolydataarray[#1,3]}%
}
\newcommand{\formatQuestionKey}[1]{%
    \item \sciolydataarray[#1,5]\hfill\pts{\sciolydataarray[#1,2]}{\sciolydataarray[#1,3]}%
}
\newcommand{\formatQuestionAnswersheet}[1]{%
    \item \sciolydataarray[#1,6]\hfill\pts{\sciolydataarray[#1,2]}{\sciolydataarray[#1,3]}%
}

\newcommand{\formatSectionheaderTestpacket}[1]{%
    \sciolydataarray[#1,4]\fullwidth{\sectionheaderTestpacket{\sciolydataarray[#1,2]}{-2}{-1}}%
}
\newcommand{\formatSectionheaderKey}[1]{%
    \sciolydataarray[#1,5]\fullwidth{\sectionheaderKey{\sciolydataarray[#1,2]}{-1}{-0.5}}%
}
\newcommand{\formatSectionheaderAnswersheet}[1]{%
    \sciolydataarray[#1,6]\fullwidth{\sectionheaderAnswersheet{\sciolydataarray[#1,2]}{-1}{-0.5}}%
}

\newcommand{\formatInfolineTestpacket}[1]{%
    \fullwidth{\noindent{\sciolydataarray[#1,4]}}%
}
\newcommand{\formatInfolineKey}[1]{%
    \empty%
}
\newcommand{\formatInfolineAnswersheet}[1]{%
    \empty%
}

% == Record Selectors ==
% silly but not worth complicating this
\newcommand{\formatDataEntryTestpacket}[1]{%
    \ifthenelse{\equal{S}{\sciolydataarray[#1,1]}}{\formatSectionheaderTestpacket{#1}}{}%
    \ifthenelse{\equal{I}{\sciolydataarray[#1,1]}}{\formatInfolineTestpacket{#1}}{}%
    \ifthenelse{\equal{Q}{\sciolydataarray[#1,1]}}{\formatQuestionTestpacket{#1}}{}%
}
\newcommand{\formatDataEntryKey}[1]{%
    \ifthenelse{\equal{S}{\sciolydataarray[#1,1]}}{\formatSectionheaderKey{#1}}{}%
    \ifthenelse{\equal{I}{\sciolydataarray[#1,1]}}{\formatInfolineKey{#1}}{}%
    \ifthenelse{\equal{Q}{\sciolydataarray[#1,1]}}{\formatQuestionKey{#1}}{}%
}
\newcommand{\formatDataEntryAnswersheet}[1]{%
    \ifthenelse{\equal{S}{\sciolydataarray[#1,1]}}{\formatSectionheaderAnswersheet{#1}}{}%
    \ifthenelse{\equal{I}{\sciolydataarray[#1,1]}}{\formatInfolineAnswersheet{#1}}{}%
    \ifthenelse{\equal{Q}{\sciolydataarray[#1,1]}}{\formatQuestionAnswersheet{#1}}{}%
}

