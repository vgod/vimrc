<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="1.0"
  xmlns="http://www.w3.org/TR/xhtml1/transitional"
  exclude-result-prefixes="#default">

  <xsl:import href="http://docbook.sourceforge.net/release/xsl/current/xhtml/docbook.xsl"/>

  <!-- import common customizations -->
  <xsl:import href="latex-suite-common.xsl"/>

  <xsl:output method="html"
    encoding="ISO-8859-1"
    indent="no"/>

  <!-- insert customization here -->

  <xsl:param name="section.autolabel" select="1"/>
  <xsl:param name="html.stylesheet" select="'latex-suite.css'"/>


</xsl:stylesheet>
