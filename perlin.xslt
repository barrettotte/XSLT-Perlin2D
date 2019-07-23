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
  <xsl:import href="utils.xslt"/>
  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="/perlin-noise">
    <xsl:variable name="sizeX" select="settings/size/@x"/>
    <xsl:variable name="sizeY" select="settings/size/@y"/>
    <xsl:text>&#10;</xsl:text>
    <xsl:element name="perlin-noise">
      <xsl:element name="settings">
        <xsl:element name="title">
          <xsl:value-of select="settings/title"/>
        </xsl:element>
        <xsl:element name="size">
          <xsl:attribute name="x">
            <xsl:value-of select="$sizeX"/>
          </xsl:attribute>
          <xsl:attribute name="y">
            <xsl:value-of select="$sizeY"/>
          </xsl:attribute>
        </xsl:element>
        <xsl:element name="test">
          <xsl:call-template name="bitwiseAnd">
            <xsl:with-param name="left" select="51"/>
            <xsl:with-param name="right" select="15"/>
          </xsl:call-template>
        </xsl:element>
      </xsl:element>
      <xsl:call-template name="generateNoiseMap">
        <xsl:with-param name="sizeX">
          <xsl:call-template name="boundedParam">
            <xsl:with-param name="param" select="$sizeX"/>
            <xsl:with-param name="lower" select="8"/>
            <xsl:with-param name="upper" select="1024"/>
          </xsl:call-template>
        </xsl:with-param>
        <xsl:with-param name="sizeY">
          <xsl:call-template name="boundedParam">
            <xsl:with-param name="param" select="$sizeY"/>
            <xsl:with-param name="lower" select="8"/>
            <xsl:with-param name="upper" select="1024"/>
          </xsl:call-template>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:element>
  </xsl:template>

  <xsl:template name="generateNoiseMap">
    <xsl:param name="sizeX"/>
    <xsl:param name="sizeY"/>
    <xsl:element name="noise-map">
      <xsl:attribute name="x">
        <xsl:value-of select="$sizeX"/>
      </xsl:attribute>
      <xsl:attribute name="y">
        <xsl:value-of select="$sizeY"/>
      </xsl:attribute>
      <xsl:variable name="map">
        <xsl:call-template name="newMap">
          <xsl:with-param name="sizeX" select="$sizeX"/>
          <xsl:with-param name="sizeY" select="$sizeY"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:for-each select="exsl:node-set($map)/map/pixel">
        <xsl:copy>
          <xsl:attribute name="x">
            <xsl:apply-templates select="@x"/>
          </xsl:attribute>
          <xsl:attribute name="y">
            <xsl:apply-templates select="@y"/>
          </xsl:attribute>
          <xsl:call-template name="calcPixel">
            <xsl:with-param name="x" select="@x"/>
            <xsl:with-param name="y" select="@y"/>
            <xsl:with-param name="sizeX" select="$sizeX"/>
            <xsl:with-param name="sizeY" select="$sizeY"/>
          </xsl:call-template>
        </xsl:copy>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>

  <xsl:template name="calcPixel">
    <xsl:param name="x"/>
    <xsl:param name="y"/>
    <xsl:param name="sizeX"/>
    <xsl:param name="sizeY"/>
    <xsl:call-template name="rand"/>
  </xsl:template>

  <xsl:template name="gradient2D">
    <xsl:param name="hash"/>
    <xsl:param name="x"/>
    <xsl:param name="y"/>
    <xsl:variable name="hashAnd1">
      <xsl:call-template name="bitwiseAnd">
        <xsl:with-param name="left" select="$hash"/>
        <xsl:with-param name="right" select="1"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="hashAnd2">
      <xsl:call-template name="bitwiseAnd">
        <xsl:with-param name="left" select="$hash"/>
        <xsl:with-param name="right" select="1"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="left">
      <xsl:choose>
        <xsl:when test="$hashAnd1 = 0">
          <xsl:value-of select="x"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="-x"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="right">
      <xsl:choose>
        <xsl:when test="$hashAnd2 = 0">
          <xsl:value-of select="y"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="-y"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:value-of select="$left + $right"/>
  </xsl:template>

  <xsl:template name="lerp">
    <xsl:param name="t"/>
    <xsl:param name="a"/>
    <xsl:param name="b"/>
    <xsl:value-of select="$a + $t * ($b - $a)"/>
  </xsl:template>

  <xsl:template name="fade">
    <xsl:param name="t"/>
    <xsl:value-of select="$t * $t * $t * ($t * ($t * 6 - 15) + 10)"/>
  </xsl:template>

  <xsl:template match="perlin-noise/noise-map/pixel/@x">
    <xsl:attribute name="x" select="."/>
  </xsl:template>

  <xsl:template match="perlin-noise/noise-map/pixel/@y">
    <xsl:attribute name="y" select="."/>
  </xsl:template>

</xsl:stylesheet>