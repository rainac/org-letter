<?xml version="1.0"?>
<!-- 
Copryright (C) 2014 Johannes Willkomm
-->
<xsl:stylesheet version="1.0"
                
     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
     xmlns:xhtml="http://www.w3.org/1999/XHTML"
     xmlns="http://www.w3.org/1999/XHTML"

  >

  <xsl:include href="copy.xsl"/>

  <xsl:output method="xml" indent="yes"/>

  <xsl:param name="data-uri" select="''"/>
  <xsl:param name="data" select="document($data-uri, /)"/>

  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="xhtml:*">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="xhtml:*[@org-keyword]">
    <xsl:value-of select="$data//keyword[@key = current()/@org-keyword]/@value"/>
  </xsl:template>

  <xsl:template match="xhtml:*[@org-drawer]">
    <xsl:apply-templates select="$data//drawer[@drawer-name = current()/@org-drawer]" mode="get-drawer"/>
  </xsl:template>

  <xsl:template match="xhtml:*[@org-drawer-pre]">
    <xsl:apply-templates select="$data//drawer[@drawer-name = current()/@org-drawer-pre]" mode="get-drawer-pre"/>
  </xsl:template>

  <xsl:template match="xhtml:*[@org = 'date-german']">
    <xsl:variable name="tstamp" select="($data//timestamp)[1]"/>
    <xsl:value-of select="$tstamp/@day-start"/>. <xsl:value-of select="$tstamp/@month-start"/>. <xsl:value-of select="$tstamp/@year-start"/>
  </xsl:template>

  <xsl:template match="xhtml:div[@id='content']">
    <xsl:apply-templates select="$data"/>
  </xsl:template>

  <xsl:template match="org-data">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="headline">
    <xsl:element name="h{@level}"><xsl:value-of select="@raw-value"/></xsl:element>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="section">
    <div>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="paragraph">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <xsl:template match="plain-list">
    <ul>
      <xsl:apply-templates/>
    </ul>
  </xsl:template>

  <xsl:template match="item">
    <li>
      <xsl:apply-templates/>
    </li>
  </xsl:template>

  <xsl:template match="drawer"/>
  
  <xsl:template match="drawer" mode="get-drawer">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="drawer" mode="get-drawer-pre">
    <pre>
      <xsl:apply-templates mode="pre"/>
    </pre>
  </xsl:template>

  <xsl:template match="link">
    <a href="{@raw-link}">
      <xsl:choose>
        <xsl:when test="normalize-space()">
          <xsl:apply-templates/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@raw-link"/>
        </xsl:otherwise>
      </xsl:choose>
    </a>
  </xsl:template>

  <xsl:template match="text()" mode="pre"/>
  <xsl:template match="paragraph" mode="pre">
    <xsl:value-of select="substring-after(., '&#xa;')"/>
  </xsl:template>

</xsl:stylesheet>
