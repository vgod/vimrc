<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="1.0"
  xmlns="http://www.w3.org/TR/xhtml1/transitional"
  exclude-result-prefixes="#default">

  <!-- Common customizations for all stylesheets -->

  <!-- this omits the trailing '.' in numbered sections -->
  <xsl:param name="autotoc.label.separator" select="' '"/>
  <xsl:param name="local.l10n.xml" select="document('')"/>

  <l:i18n xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0">
    <l:l10n language="en">
      <l:context name="title-numbered">
        <l:template name="section" text="%n %t"/>
      </l:context>
    </l:l10n>
  </l:i18n>

  <!-- override template for revhistory table -->
  <xsl:template match="revhistory" mode="titlepage.mode">
    <xsl:variable name="numcols">
      <xsl:choose>
        <xsl:when test="//authorinitials">3</xsl:when>
        <xsl:otherwise>2</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <div xmlns="http://www.w3.org/1999/xhtml" class="{name(.)}">
      <table border="2" cellspacing="4" width="100%" summary="Revision history">
        <tr>
          <th align="left" valign="top" colspan="{$numcols}">
            <b>
              <xsl:call-template name="gentext">
                <xsl:with-param name="key" select="'RevHistory'"/>
              </xsl:call-template>
            </b>
          </th>
        </tr>
        <xsl:apply-templates mode="titlepage.mode">
          <xsl:with-param name="numcols" select="$numcols"/>
        </xsl:apply-templates>
      </table>
    </div>
  </xsl:template>

  <!--
  <xsl:template name="user.header.content">
    <div id="customheader">
    <span class="logo">TeX Refs</span>
    </div>                             
  </xsl:template>
  
  <xsl:template name="user.footer.content">
    <div id="customfooter">                
      Copyright &#169; 2002 P. Karp, M. Wiedmann
    </div>                             
  </xsl:template>
  -->

</xsl:stylesheet>
