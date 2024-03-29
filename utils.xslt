<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" 
  xmlns:exsl="http://exslt.org/common" xmlns:math="java.lang.Math" 
  extension-element-prefixes="exsl math">
  
  <xsl:output method="xml" indent="yes"/>

  <xsl:template name="bitwiseAnd">
    <xsl:param name="left"/>
    <xsl:param name="right"/>
    <xsl:param name="bitIter" select="1"/>
    <xsl:param name="tmp" select="0"/>
    <xsl:variable name="leftBit" select="floor($left div 2)"/>
    <xsl:variable name="rightBit" select="floor($right div 2)"/>
    <xsl:variable name="value" select="$tmp + (($left mod 2 and $right mod 2) * $bitIter)"/>
    <xsl:choose>
      <xsl:when test="$leftBit and $rightBit">
        <xsl:call-template name="bitwiseAnd">
          <xsl:with-param name="left" select="$leftBit"/>
          <xsl:with-param name="right" select="$rightBit"/>
          <xsl:with-param name="bitIter" select="2 * $bitIter"/>
          <xsl:with-param name="tmp" select="$value"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$value" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="boundedParam">
    <xsl:param name="param" select="0.0"/>
    <xsl:param name="lower" select="0.0"/>
    <xsl:param name="upper" select="0.0"/>
    <xsl:choose>
      <xsl:when test="$param &gt; $upper">
        <xsl:value-of select="$upper"/>
      </xsl:when>
      <xsl:when test="$param &lt; $lower">
        <xsl:value-of select="$lower"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$param"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="lte">
    <xsl:with-param name="left"/>
    <xsl:with-param name="right"/>
    <xsl:value-of select="($left &lt; $right) or ($left = $right)"/>
  </xsl:template>

  <xsl:template name="gte">
    <xsl:with-param name="left"/>
    <xsl:with-param name="right"/>
    <xsl:value-of select="($left &gt; $right) or ($left = $right)"/>
  </xsl:template>

  <xsl:template name="boundedRand">
    <xsl:param name="low" select="0"/>
    <xsl:param name="high" select="1"/>
    <xsl:value-of select="(floor(math:random() * $high) mod $high) + (1 + $low)"/>
  </xsl:template>

  <xsl:template name="rand">
    <xsl:value-of select="math:random()"/>
  </xsl:template>

</xsl:stylesheet>