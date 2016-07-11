<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output
      method = "html"
      encoding = "UTF-8"
      omit-xml-declaration = "yes"
      doctype-system = "about:legacy-compat"
      indent = "yes" />

  <!-- complete html document template -->
  <xsl:template match="document">
    <html>
      <head>
	<!-- process head tags -->
	<xsl:apply-templates select="/document/metadata"/>
	<meta name="viewport" content ="width=device-width, initial-scale=1.0"/>
	<link rel="stylesheet" href="stylesheet.css"/>
      </head>
      <body>
	<xsl:apply-templates select="/document/body"/>
      </body>
    </html>
  </xsl:template>

  <!-- html head template -->
  <xsl:template match="/document/metadata">
    <title><xsl:value-of select="title"/></title>
    <xsl:element name="meta">
      <xsl:attribute name="name">author</xsl:attribute>
      <xsl:attribute name="content">
	<xsl:value-of select="author/name"/>
      </xsl:attribute>
    </xsl:element>
  </xsl:template>

  <!-- html body template -->
  <xsl:template match="/document/body">
    <!-- title -->
    <h1><xsl:value-of select="/document/metadata/title"/></h1>
    <!-- author -->
    <p>
      <xsl:value-of select="//author/name"/>
      <br/>
      <xsl:element name="a"><xsl:attribute name="href">mailto:<xsl:value-of select="//author/email"/></xsl:attribute><xsl:value-of select="//author/email"/></xsl:element>
    </p>

    <!-- date -->
    <p>
      <xsl:value-of select="//date"/>
    </p>

    <!-- body -->
    <xsl:apply-templates select="@*|node()"/>
  </xsl:template>

  <!-- url items -->
  <xsl:template match="url">
    <xsl:element name="a">      
      <xsl:attribute name="href">
	<xsl:value-of select="node()"/>
      </xsl:attribute>
      <xsl:value-of select="node()"/>
    </xsl:element>
  </xsl:template>

  <!-- copy everything else -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
