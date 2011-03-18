<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="1.0"
  xmlns="http://www.w3.org/TR/xhtml1/transitional"
  exclude-result-prefixes="#default">

  <!-- $Id: latex-suite-chunk.xsl 1036 2008-05-31 16:10:30Z tmaas $ -->

  <xsl:import href="http://docbook.sourceforge.net/release/xsl/current/xhtml/chunk.xsl"/>

  <!-- import common customizations -->
  <xsl:import href="latex-suite-common.xsl"/>

  <!-- insert customization here -->

  <xsl:param name="default.encoding" select="'ISO-8859-1'"/>

  <xsl:param name="use.id.as.filename" select="'1'"/>
  <xsl:param name="section.autolabel"  select="1"/>
  <xsl:param name="html.stylesheet"    select="'../latex-suite.css'"/>

  <!-- Chunk the first top-level section? -->
  <xsl:param name="chunk.first.sections" select="1"/>
  <!-- Depth to which sections should be chunked  -->
  <xsl:param name="chunk.section.depth" select="2"/>

  <!-- How deep should recursive sections appear in the TOC? -->
  <xsl:param name="toc.section.depth">2</xsl:param>
  <!-- Control depth of TOC generation in sections -->
  <xsl:param name="generate.section.toc.level" select="3"/>

  <xsl:param name="chunker.output.method" select="'html'"/>

  <xsl:param name="chunker.output.doctype-public" 
    select="'-//W3C//DTD HTML 4.01 Transitional//EN'"/>
  <xsl:param name="chunker.output.doctype-system" 
    select="'http://www.w3.org/TR/html4/loose.dtd'"/>

  <!-- this enables generation of TOC in appendix -->
  <xsl:param name="generate.toc">
appendix  toc
article/appendix  toc
article   toc
sect1     toc
sect2     toc
sect3     toc
sect4     toc
sect5     toc
section   toc
  </xsl:param>

</xsl:stylesheet>
