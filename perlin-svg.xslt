<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:import href="noise.xslt"/>
  <xsl:import href="svg-utils.xslt"/>
  <xsl:output method="xml" indent="yes"/>
  <xsl:template match="/perlin-noise">
    <xsl:text>&#10;</xsl:text>
    <xsl:call-template name="generateSvgFromRTF">
      <xsl:with-param name="pixels">
        <xsl:call-template name="generatePerlinMap2D">
          <xsl:with-param name="sizeX" select="settings/sizeX"/>
          <xsl:with-param name="sizeY" select="settings/sizeY"/>
          <xsl:with-param name="freq" select="settings/frequency"/>
          <xsl:with-param name="octaves" select="settings/octaves"/>
          <xsl:with-param name="seed" select="settings/seed"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="sizeX" select="settings/sizeX"/>
      <xsl:with-param name="sizeY" select="settings/sizeY"/>
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>