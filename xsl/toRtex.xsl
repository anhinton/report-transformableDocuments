<?xml version="1.0"?>
<!-- Time-stamp: "2015-11-07 15:44:10 ashley"-->
<!DOCTYPE document [
  <!ENTITY nl "&#xA;">
]>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output encoding="UTF-8" indent="yes" method="text"
	      omit-xml-declaration="yes"/>

  <xsl:template match="document">
    <xsl:text>\documentclass[11pt,a4paper]{report}&nl;</xsl:text>
    <xsl:text>\setcounter{tocdepth}{2}&nl;</xsl:text>
    <xsl:text>\renewcommand \thesection {\arabic{section}}&nl;</xsl:text>
    <xsl:text>\setcounter{secnumdepth}{1}&nl;</xsl:text>
    <xsl:text>\usepackage[hidelinks]{hyperref}&nl;</xsl:text>
    <xsl:text>\usepackage{breakurl}&nl;</xsl:text>
    <xsl:text>\usepackage{graphicx}&nl;</xsl:text>
    <xsl:text>\usepackage{setspace}&nl;</xsl:text>
    <xsl:text>\usepackage{listings}&nl;</xsl:text>
    <xsl:text>\lstset{&nl;</xsl:text>
    <xsl:text>basicstyle=\small\ttfamily,&nl;</xsl:text>
    <xsl:text>columns=flexible,&nl;</xsl:text>
    <xsl:text>breaklines=true&nl;</xsl:text>
    <xsl:text>}&nl;</xsl:text>
    <xsl:text>\usepackage{titling}&nl;</xsl:text>
    <xsl:text>\newcommand{\subtitle}[1]{%&nl;</xsl:text>
    <xsl:text>  \posttitle{%&nl;</xsl:text>
    <xsl:text>    \par\end{center}&nl;</xsl:text>
    <xsl:text>    \begin{center}\large#1\end{center}&nl;</xsl:text>
    <xsl:text>    \vskip0.5em}%&nl;</xsl:text>
    <xsl:text>}&nl;</xsl:text>
    <xsl:text>%% begin.rcode setup, include=FALSE&nl;</xsl:text>
    <xsl:text>% library(knitr)&nl;</xsl:text>
    <xsl:text>% opts_chunk$set(cache=TRUE, size='small', background='#FFFFFF')&nl;</xsl:text>
    <xsl:text>%% end.rcode&nl;</xsl:text>
    <xsl:text>\begin{document}&nl;</xsl:text>
    <xsl:apply-templates select="head"/>
    <xsl:apply-templates select="body"/>
    <xsl:text>\end{document}&nl;</xsl:text>
  </xsl:template>

  <xsl:template match="head">
    <xsl:text>\title{</xsl:text>
    <xsl:value-of select="/document/head/title"/>
    <xsl:text>}&nl;</xsl:text>
    <xsl:text>\subtitle{</xsl:text>
    <xsl:for-each select="/document/head/subtitle">
      <xsl:value-of select="node()"/>
      <xsl:text>\\&nl;</xsl:text>
    </xsl:for-each>
    <xsl:text>}&nl;</xsl:text>
    <xsl:text>\author{</xsl:text>
    <xsl:value-of select="/document/head/author/name"/>
    <xsl:text>\\&nl;</xsl:text>
    <xsl:text>\href{mailto:</xsl:text>
    <xsl:value-of select="/document/head/author/email"/>
    <xsl:text>}{</xsl:text>
    <xsl:value-of select="/document/head/author/email"/>
    <xsl:text>}</xsl:text>
    <xsl:text>\\&nl;</xsl:text>
    <xsl:value-of select="/document/head/author/affiliation"/>
    <xsl:text>\\&nl;\\&nl;Supervisor: </xsl:text>
    <xsl:value-of select="/document/head/author/supervisor"/>
    <xsl:text>}&nl;</xsl:text>
    <xsl:text>\date{</xsl:text>
    <xsl:value-of select="/document/head/date"/>
    <xsl:text>}&nl;</xsl:text>
    <xsl:text>\maketitle&nl;</xsl:text>
    <xsl:text>\tableofcontents&nl;</xsl:text>
  </xsl:template>

  <xsl:template match="body">
    <xsl:apply-templates select="section"/>
    <xsl:text>\newpage&nl;</xsl:text>
    <xsl:text>\appendix&nl;</xsl:text>
    <xsl:text>\section*{Appendices}&nl;</xsl:text>
    <xsl:text>\addcontentsline{toc}{section}{Appendices}&nl;</xsl:text>
    <xsl:text>\renewcommand \thesection {\Alph{section}}&nl;</xsl:text>
    <xsl:apply-templates select="/document/body/appendix"/>
  </xsl:template>

  <xsl:template match="section">
    <xsl:text>\newpage&nl;</xsl:text>
    <xsl:apply-templates select="node()"/>
  </xsl:template>

  <xsl:template match="section[@class='references']">
    <xsl:text>\newpage&nl;</xsl:text>
    <xsl:text>\onehalfspacing&nl;</xsl:text>
    <xsl:apply-templates select="node()"/>
    <xsl:text>\singlespacing&nl;</xsl:text>
  </xsl:template>

  <xsl:template match="subsection[@class='thanks']">
    <xsl:text>\newpage&nl;</xsl:text>
    <xsl:text>\subsection*{}&nl;&nl;</xsl:text>
    <xsl:apply-templates select="node()"/>    
  </xsl:template>

  <xsl:template match="h1">
    <xsl:text>\section{</xsl:text>
    <xsl:apply-templates select="node()"/>
    <xsl:text>}&nl;&nl;</xsl:text>
  </xsl:template>

  <xsl:template match="h1[@class='unnumbered']">
    <xsl:text>\section*{</xsl:text>
    <xsl:apply-templates select="node()"/>
    <xsl:text>}&nl;</xsl:text>
    <xsl:text>\addcontentsline{toc}{section}{</xsl:text>
    <xsl:apply-templates select="node()"/>
    <xsl:text>}&nl;&nl;</xsl:text>
  </xsl:template>

  <xsl:template match="h2">
    <xsl:text>\subsection{</xsl:text>
    <xsl:apply-templates select="node()"/>
    <xsl:text>}&nl;&nl;</xsl:text>
  </xsl:template>
  
  <xsl:template match="h3">
    <xsl:text>\subsubsection{</xsl:text>
    <xsl:apply-templates select="node()"/>
    <xsl:text>}&nl;&nl;</xsl:text>
  </xsl:template>
  
  <xsl:template match="code">
    <xsl:text>\texttt{</xsl:text>
    <xsl:apply-templates select="node()"/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="p">
    <xsl:apply-templates select="node()"/>
    <xsl:text>&nl;&nl;</xsl:text>
  </xsl:template>

  <xsl:template match="p[@class='references']">
    <xsl:text>\noindent&nl;</xsl:text>
    <xsl:text>\hangindent=0.7cm&nl;</xsl:text>
    <xsl:apply-templates select="node()"/>
    <xsl:text>&nl;&nl;</xsl:text>
  </xsl:template>

  <xsl:template match="em">
    <xsl:text>\emph{</xsl:text>
    <xsl:apply-templates select="node()"/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="a">
    <xsl:text>\href{</xsl:text>
    <xsl:value-of select="@href"/>
    <xsl:text>}{</xsl:text>
    <xsl:value-of select="node()"/>
    <xsl:text>}</xsl:text>		  
  </xsl:template>

  <xsl:template match="url">
    <xsl:text>\burl{</xsl:text>
    <xsl:value-of select="node()"/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="a[@class='references']">
    <xsl:text>\burl{</xsl:text>
    <xsl:value-of select="node()"/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="cite"/>

  <xsl:template match="ul">
    <xsl:text>\begin{itemize}&nl;</xsl:text>
    <xsl:apply-templates select="node()"/>
    <xsl:text>\end{itemize}&nl;&nl;</xsl:text>
  </xsl:template>

  <xsl:template match="li">
    <xsl:text>\item </xsl:text>
    <xsl:apply-templates select="node()"/>
    <xsl:text>&nl;</xsl:text>
  </xsl:template>

  <xsl:template match="figure">
    <xsl:text>\begin{figure}&nl;</xsl:text>
    <xsl:text>\centering&nl;</xsl:text>
    <xsl:text>\includegraphics[width=0.8\textwidth]{</xsl:text>
    <xsl:value-of select="translate(img/@src, '\', '')"/>
    <xsl:text>}&nl;</xsl:text>
    <xsl:text>\caption{</xsl:text>
    <xsl:apply-templates select="node()"/>
    <xsl:text>}&nl;</xsl:text>
    <xsl:text>\end{figure}</xsl:text>
  </xsl:template>    

  <xsl:template match="pre">
    <xsl:text>\begin{lstlisting}&nl;</xsl:text>
    <xsl:value-of select="node()"/>
    <xsl:text>&nl;\end{lstlisting}&nl;&nl;</xsl:text>
  </xsl:template>

  <xsl:template match="pre[@class='knitr']">
    <xsl:text>%% begin.rcode </xsl:text>
    <xsl:value-of select="@name"/>
    <xsl:if test="@options">
      <xsl:text>, </xsl:text>
      <xsl:value-of select="@options"/>
    </xsl:if>
    <xsl:text>&nl;</xsl:text>
    <xsl:value-of select="node()"/>
    <xsl:text>&nl;%% end.rcode&nl;&nl;</xsl:text>
  </xsl:template>

  <xsl:template match="appendix">
    <xsl:apply-templates select="node()"/>
    <xsl:text>\newpage&nl;</xsl:text>
  </xsl:template>

  <!-- copy everything into new doc -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
