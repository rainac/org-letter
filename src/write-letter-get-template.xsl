<?xml version="1.0"?>
<!-- 
Copryright (C) 2014 Johannes Willkomm
-->
<xsl:stylesheet version="1.0"
                
     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
     xmlns:xhtml="http://www.w3.org/1999/XHTML"
     xmlns="http://www.w3.org/1999/XHTML"

  >

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:value-of select="//keyword[@key = 'TEMPLATE'][last()]/value"/>
  </xsl:template>

</xsl:stylesheet>
