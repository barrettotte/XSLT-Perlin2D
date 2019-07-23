<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.1"
	xmlns:date="http://exslt.org/dates-and-times"
	xmlns:dyn="http://exslt.org/dynamic" 
	xmlns:exsl="http://exslt.org/common"
	xmlns:func="http://exslt.org/functions"
	xmlns:math="java.lang.Math"
	xmlns:regexp="http://exslt.org/regular-expressions"
	xmlns:set="http://exslt.org/sets"
	xmlns:str="http://exslt.org/strings"
	xmlns:xalan="http://xml.apache.org/xalan"
	exclude-result-prefixes="xalan"
	extension-element-prefixes="date dyn exsl func math regexp set str xalan"
>
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

  <xsl:template name="boundedRand">
    <xsl:param name="low" select="0"/>
    <xsl:param name="high" select="1"/>
    <xsl:value-of select="(floor(math:random() * $high) mod $high) + (1 + $low)"/>
  </xsl:template>

  <xsl:template name="rand">
    <xsl:value-of select="math:random()"/>
  </xsl:template>

  <xsl:template name="newMap">
    <xsl:param name="sizeX" select="8"/>
    <xsl:param name="sizeY" select="8"/>
    <xsl:param name="currentX" select="1"/>
    <xsl:element name="map">
      <xsl:attribute name="x" select="$sizeX"/>
      <xsl:attribute name="y" select="$sizeY"/>
      <xsl:call-template name="map">
        <xsl:with-param name="sizeX" select="$sizeX"/>
        <xsl:with-param name="sizeY" select="$sizeY"/>
      </xsl:call-template>
    </xsl:element>
  </xsl:template>

  <xsl:template name="map">
    <xsl:param name="sizeX"/>
    <xsl:param name="sizeY"/>
    <xsl:param name="currentY" select="0"/>
    <xsl:if test="not($currentY = $sizeY)">
      <xsl:call-template name="mapRow">
        <xsl:with-param name="currentY" select="$currentY"/>
        <xsl:with-param name="sizeX" select="$sizeX"/>
      </xsl:call-template>
      <xsl:call-template name="map">
        <xsl:with-param name="sizeX" select="$sizeX"/>
        <xsl:with-param name="sizeY" select="$sizeY"/>
        <xsl:with-param name="currentY" select="$currentY + 1"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="mapRow">
    <xsl:param name="currentX" select="0"/>
    <xsl:param name="currentY"/>
    <xsl:param name="sizeX"/>
    <xsl:if test="not($currentX = $sizeX)">
      <xsl:element name="pixel">
        <xsl:attribute name="x">
          <xsl:value-of select="$currentX"/>
        </xsl:attribute>
        <xsl:attribute name="y">
          <xsl:value-of select="$currentY"/>
        </xsl:attribute>
        <xsl:value-of select="0.0"/>
      </xsl:element>
      <xsl:call-template name="mapRow">
        <xsl:with-param name="currentX" select="$currentX + 1"/>
        <xsl:with-param name="currentY" select="$currentY"/>
        <xsl:with-param name="sizeX" select="$sizeX"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>