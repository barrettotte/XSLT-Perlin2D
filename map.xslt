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
    <xsl:param name="currentY" select="1"/>
    <xsl:if test="not($currentY = $sizeY+1)">
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
    <xsl:param name="currentX" select="1"/>
    <xsl:param name="currentY"/>
    <xsl:param name="sizeX"/>
    <xsl:if test="not($currentX = $sizeX+1)">
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