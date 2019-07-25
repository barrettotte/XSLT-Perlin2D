<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" 
  xmlns:exsl="http://exslt.org/common" 
  xmlns:math="java.lang.Math" extension-element-prefixes="exsl math">
  
  <xsl:output method="xml" indent="yes"/>

  <xsl:template name="generateSvgFromRTF">
    <xsl:param name="pixels"/>
    <xsl:param name="sizeX"/>
    <xsl:param name="sizeY"/>
    <svg xmlns="http://www.w3.org/2000/svg" width="{$sizeX}" height="{$sizeY}" viewBox="0 0 {$sizeX} {$sizeY}">
      <xsl:for-each select="exsl:node-set($pixels)/perlin-noise/pixel">
        <xsl:variable name="pixel" select="."/>
        <xsl:variable name="color">
          <xsl:copy>
            <xsl:call-template name="floatToColorBW">
              <xsl:with-param name="value">
                <xsl:value-of select="."/>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:copy>
        </xsl:variable>
        <rect x="{@x}" y="{@y}" width="1" height="1" fill="rgb({$color},{$color},{$color})"/>
      </xsl:for-each>
    </svg>
  </xsl:template>

  <xsl:template name="floatToColorBW">
    <xsl:param name="value" select="0.0"/>
    <xsl:call-template name="floatTo255">
      <xsl:with-param name="value" select="$value"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="floatTo255">
    <xsl:param name="value" select="0.0"/>
    <xsl:choose>
      <xsl:when test="($value &gt; 1) or ($value = 1)">
        <xsl:value-of select="255"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="($value &lt; 0) or ($value = 0)">
            <xsl:value-of select="0"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="floor($value * 256.0)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>