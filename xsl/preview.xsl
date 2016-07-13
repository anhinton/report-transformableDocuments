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

    <!-- author meta tag -->

    <!-- author meta tag -->
    <xsl:choose>
      
      <!-- multiple authors -->
      <xsl:when test="count(author) &gt; 1">
	<xsl:element name="meta">
	  <xsl:attribute name="name">author</xsl:attribute>
	  <xsl:attribute name="content">
	    <!-- all authors but last -->
	    <xsl:for-each select = "author[position()&lt;last()]">
	      <xsl:value-of select="name"/><xml:text>, </xml:text>
	    </xsl:for-each>
	    <!-- last author -->
	    <xsl:value-of select="author[last()]/name"/>
	  </xsl:attribute>
	</xsl:element>
      </xsl:when>
      
      <!-- single author -->
      <xsl:otherwise>
	<xsl:element name="meta">
	  <xsl:attribute name="name">author</xsl:attribute>
	  <xsl:attribute name="content">
	    <xsl:value-of select="name"/>
	  </xsl:attribute>
	</xsl:element>
      </xsl:otherwise>
    </xsl:choose>
    
    <!-- date meta tag -->
    <xsl:if test="date != ''">
      <xsl:element name="meta">
	<xsl:attribute name="name">date</xsl:attribute>
	<xsl:attribute name="content">
	  <xsl:value-of select="date"/>
	</xsl:attribute>
      </xsl:element>
    </xsl:if>

    <!-- description meta tag -->
    <xsl:if test="description != ''">
      <xsl:element name="meta">
	<xsl:attribute name="name">description</xsl:attribute>
	<xsl:attribute name="content">
	  <xsl:value-of select="description"/>
	</xsl:attribute>
      </xsl:element>
    </xsl:if>
  </xsl:template>

  <!-- html body template -->
  <xsl:template match="/document/body">
    <div class="main">
      <!-- produce document title section -->
      <div class="title">
	<h1 class="title"><xsl:value-of select="/document/metadata/title"/></h1>

	<!-- subtitle -->
	<xsl:for-each select="/document/metadata/subtitle">
	  <xsl:if test="/document/metadata/subtitle != ''">
	    <h2 class="subtitle"><xsl:value-of select="node()"/></h2>
	  </xsl:if>
	</xsl:for-each>

	<!-- author -->
	<xsl:for-each select="/document/metadata/author">
	  <p class="author">
	    <xsl:value-of select="name"/>
	    <!-- email -->
	    <xsl:if test="email">
	    <br/><xsl:element name="a"><xsl:attribute name="href"><xsl:value-of select="email"/></xsl:attribute><xsl:value-of select="email"/></xsl:element></xsl:if>
	    <!-- affiliation -->
	    <xsl:if test="affiliation"><br/><xsl:value-of select="affiliation"/></xsl:if>
	  </p>
	</xsl:for-each>

	<!-- group affiliation -->
	<xsl:if test="/document/metadata/affiliation">
	  <p class="author">
	    <xsl:value-of select="/document/metadata/affiliation"/>
	  </p>
	</xsl:if>
	  
	  <!-- date -->
	<p class="date"><xsl:value-of select="/document/metadata/date"/></p>
      </div>

      <!-- process rest of body -->
      <xsl:apply-templates select="@*|node()"/>
    </div>
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

  <!-- knitr chunks -->
  <xsl:template match="code[@class='knitr']">
    <p><strong>TODO: EXECUTE R CODE:</strong></p>
    <xsl:element name="pre"><xsl:element name="code"><xsl:value-of select="."/></xsl:element></xsl:element>
  </xsl:template>

  <!-- todo items -->
  <xsl:template match="todo">
    <strong>TODO: <xsl:value-of select="."/></strong>
  </xsl:template>

  <!-- ann items -->
  <xsl:template match="ann">
    <span class="ann"><xsl:value-of select="."/></span>
  </xsl:template>

  <!-- mod items -->
  <xsl:template match="mod">
    <span class="mod"><xsl:value-of select="."/></span>
  </xsl:template>

  <!-- copy everything into new doc -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
