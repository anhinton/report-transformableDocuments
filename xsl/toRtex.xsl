<?xml version="1.0"?>
<!-- Time-stamp: "2016-07-13 12:25:52 ahin017"-->
<!DOCTYPE document [
<!ENTITY nl "&#xA;">
]>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output encoding="UTF-8" indent="yes" method="text"
	      omit-xml-declaration="yes"/>

  <xsl:template match="/document">
    <!-- setup -->
    <xsl:text>\documentclass[11pt,a4paper]{article}&nl;</xsl:text>
    <xsl:text>\usepackage{hyperref}</xsl:text>
    <xsl:text>\usepackage{graphicx}&nl;</xsl:text>
    <xsl:text>&nl;</xsl:text>

    <!-- knitr setup -->
    <xsl:text>%% begin.rcode setup, include=FALSE&nl;</xsl:text>
    <xsl:text>% library(knitr)&nl;</xsl:text>
    <xsl:text>% opts_chunk$set(cache = TRUE, size='small', background='#FFFFFF')&nl;</xsl:text>
    <xsl:text>%% end.rcode&nl;</xsl:text>
    <xsl:text>&nl;</xsl:text>

    <!-- produce document -->
    <xsl:text>\begin{document}&nl;</xsl:text>
    <!-- process metadata -->
    <xsl:apply-templates select="metadata"/>
    <xsl:text>&nl;</xsl:text>
    <!-- process body -->
    <xsl:apply-templates select="body"/>
    <xsl:text>\end{document}&nl;</xsl:text>
  </xsl:template>

  <xsl:template match="/document/metadata">
    <!-- title -->
    <xsl:text>\title{</xsl:text>
    <xsl:value-of select="title"/>
    <xsl:text>}&nl;</xsl:text>

    <!-- author -->
    <xsl:text>\author{</xsl:text>
    <xsl:for-each select = "author">
      <xsl:value-of select="name"/>
      <xsl:if test = "email">
	<xsl:text>\\&nl;</xsl:text>
	<xsl:text>\href{mailto:</xsl:text>
	<xsl:value-of select="email"/>
	<xsl:text>}{</xsl:text>
	<xsl:value-of select="email"/>
	<xsl:text>}</xsl:text>
      </xsl:if>
      <xsl:if test = "affiliation">
	<xsl:text>\\&nl;</xsl:text>
	<xsl:value-of select = "affiliation"/>
      </xsl:if>
      <xsl:text>\\&nl;</xsl:text>
      <xsl:text>\\&nl;</xsl:text>
    </xsl:for-each>    
    <xsl:if test = "affiliation">
      <xsl:value-of select = "affiliation"/>
    </xsl:if>
    <xsl:text>}&nl;</xsl:text>

    <!-- date -->
    <xsl:text>\date{</xsl:text>
    <xsl:value-of select="date"/>
    <xsl:text>}&nl;</xsl:text>
    
    <xsl:text>\maketitle</xsl:text>
  </xsl:template>

  <xsl:template match="/document/body">
    <xsl:apply-templates select="section"/>
  </xsl:template>

  <xsl:template match="a">
    <xsl:text>\href{</xsl:text>
    <xsl:value-of select="@href"/>
    <xsl:text>}{</xsl:text>
    <xsl:value-of select="node()"/>
    <xsl:text>}</xsl:text>		  
  </xsl:template>

  <xsl:template match="code">
    <xsl:text>\texttt{</xsl:text>
    <xsl:apply-templates select="node()"/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="code[@class='knitr']">
    <xsl:text>%% begin.rcode </xsl:text>
    <xsl:value-of select="@name"/>
    <xsl:if test="@options">
      <xsl:text>, </xsl:text>
      <xsl:value-of select="@options"/>
    </xsl:if>
    <xsl:text>&nl;</xsl:text>
    <xsl:value-of select="node()"/>
    <xsl:text>&nl;%% end.rcode</xsl:text>
  </xsl:template>

  <xsl:template match="em">
    <xsl:text>\emph{</xsl:text>
    <xsl:apply-templates select="node()"/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="figure">
    <xsl:text>\begin{figure}&nl;</xsl:text>
    <xsl:text>\centering&nl;</xsl:text>
    <xsl:text>\includegraphics[width=0.8\textwidth]{</xsl:text>
    <xsl:value-of select="img/@src"/>
    <xsl:text>}&nl;</xsl:text>
    <xsl:text>\caption{</xsl:text>
    <xsl:value-of select="figcaption"/>
    <xsl:text>}&nl;</xsl:text>
    <xsl:text>\end{figure}&nl;</xsl:text>
  </xsl:template>    

  <xsl:template match="h1">
    <xsl:text>\section{</xsl:text>
    <xsl:apply-templates select="node()"/>
    <xsl:text>}&nl;</xsl:text>
  </xsl:template>

  <xsl:template match="h2">
    <xsl:text>\subsection{</xsl:text>
    <xsl:apply-templates select="node()"/>
    <xsl:text>}&nl;</xsl:text>
  </xsl:template>
  
  <xsl:template match="h3">
    <xsl:text>\subsubsection{</xsl:text>
    <xsl:apply-templates select="node()"/>
    <xsl:text>}&nl;</xsl:text>
  </xsl:template>
  
  <xsl:template match="li"> 
    <xsl:text>\item </xsl:text>
    <xsl:apply-templates select="node()"/>
  </xsl:template>

  <xsl:template match="p">
    <xsl:apply-templates select="node()"/>
    <xsl:text>&nl;</xsl:text>
  </xsl:template>

  <xsl:template match="pre">
    <xsl:text>\begin{verbatim}</xsl:text>
    <xsl:choose>
      <xsl:when test="code">
	<xsl:value-of select="code"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="node()"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>\end{verbatim}&nl;</xsl:text>
  </xsl:template>

  <xsl:template match="section">    
    <xsl:apply-templates select="node()"/>
  </xsl:template>

  <xsl:template match="ul">
    <xsl:text>\begin{itemize}</xsl:text>
    <xsl:apply-templates select="node()"/>
    <xsl:text>\end{itemize}&nl;</xsl:text>
  </xsl:template>

  <xsl:template match="url">
    <xsl:text>\url{</xsl:text>
    <xsl:value-of select="node()"/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <!-- copy everything into new doc -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
