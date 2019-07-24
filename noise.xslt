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
	<xsl:import href="hash.xslt"/>
	<xsl:import href="map.xslt"/>

	<xsl:template name="generatePerlinMap2D">
		<xsl:param name="sizeX"/>
		<xsl:param name="sizeY"/>
		<xsl:param name="freq"/>
		<xsl:param name="octaves"/>
		<xsl:param name="seed"/>
		<xsl:element name="perlin-noise">
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
          <xsl:call-template name="perlin2D">
            <xsl:with-param name="x" select="@x"/>
            <xsl:with-param name="y" select="@y"/>
						<xsl:with-param name="freq" select="$freq"/>
						<xsl:with-param name="octaves" select="$octaves"/>
						<xsl:with-param name="seed" select="$seed"/>
          </xsl:call-template>
        </xsl:copy>
      </xsl:for-each>
			
    </xsl:element>
	</xsl:template>

	<xsl:template name="perlin2D-loop">
		<xsl:param name="xAmp"/>
		<xsl:param name="yAmp"/>
		<xsl:param name="amp"/>
		<xsl:param name="fin"/>
		<xsl:param name="seed"/>
		<xsl:param name="dv"/>
		<xsl:param name="octaves"/>
		<xsl:param name="octaveIter"/>
		<xsl:if test="not($octaveIter = $octaves)">
			<xsl:variable name="noise">
				<xsl:call-template name="noise2D">
						<xsl:with-param name="x" select="$xAmp"/>
						<xsl:with-param name="y" select="$yAmp"/>
						<xsl:with-param name="s" select="$seed"/>
					</xsl:call-template>
			</xsl:variable>
			<xsl:call-template name="perlin2D-loop">
				<xsl:with-param name="xAmp" select="$xAmp * 2"/>
				<xsl:with-param name="yAmp" select="$yAmp * 2"/>
				<xsl:with-param name="amp" select="$amp div 2"/>
				<xsl:with-param name="fin" select="$noise * $amp"/>
				<xsl:with-param name="seed" select="$seed"/>
				<xsl:with-param name="dv" select="$dv + 256 * $amp"/>
				<xsl:with-param name="octaves" select="$octaves"/>
				<xsl:with-param name="octaveIter" select="$octaveIter + 1"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:value-of select="$fin div $dv"/>
	</xsl:template>

	<xsl:template name="perlin2D">
		<xsl:param name="x"/>
		<xsl:param name="y"/>
		<xsl:param name="freq"/>
		<xsl:param name="octaves"/>
		<xsl:param name="seed"/>
		<xsl:call-template name="perlin2D-loop">
			<xsl:with-param name="xAmp" select="$x * $freq"/>
			<xsl:with-param name="yAmp" select="$y * $freq"/>
			<xsl:with-param name="amp" select="1.0"/>
			<xsl:with-param name="fin" select="0"/>
			<xsl:with-param name="seed" select="$seed"/>
			<xsl:with-param name="dv" select="0.0"/>
			<xsl:with-param name="octaves" select="$octaves"/>
			<xsl:with-param name="octaveIter" select="0"/>
		</xsl:call-template>
  </xsl:template>

  <xsl:template name="noise2D">
    <xsl:param name="x"/>
    <xsl:param name="y"/>
    <xsl:param name="seed"/>
    <xsl:variable name="xInt" select="floor($x)"/>
    <xsl:variable name="yInt" select="floor($y)"/>
    <xsl:variable name="xFrac" select="$x - $xInt"/>
    <xsl:variable name="yFrac" select="$y - $yInt"/>
		<xsl:variable name="s">
			<xsl:call-template name="noise2">
				<xsl:with-param name="x" select="xInt"/>
				<xsl:with-param name="y" select="yInt"/>
				<xsl:with-param name="seed" select="seed"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="t">
			<xsl:call-template name="noise2">
				<xsl:with-param name="x" select="xInt + 1"/>
				<xsl:with-param name="y" select="yInt"/>
				<xsl:with-param name="seed" select="seed"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="u">
			<xsl:call-template name="noise2">
				<xsl:with-param name="x" select="xInt"/>
				<xsl:with-param name="y" select="yInt + 1"/>
				<xsl:with-param name="seed" select="seed"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="v">
			<xsl:call-template name="noise2">
				<xsl:with-param name="x" select="xInt + 1"/>
				<xsl:with-param name="y" select="yInt + 1"/>
				<xsl:with-param name="seed" select="seed"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="low">
			<xsl:call-template name="slerp">
				<xsl:with-param name="x" select="$s"/>
				<xsl:with-param name="y" select="$t"/>
				<xsl:with-param name="s" select="$xFrac"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="high">
			<xsl:call-template name="slerp">
				<xsl:with-param name="x" select="$u"/>
				<xsl:with-param name="y" select="$v"/>
				<xsl:with-param name="s" select="$xFrac"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:call-template name="slerp">
			<xsl:with-param name="x" select="$low"/>
			<xsl:with-param name="y" select="$high"/>
			<xsl:with-param name="s" select="$yFrac"/>
		</xsl:call-template>
  </xsl:template>

	<xsl:template name="slerp">
		<xsl:param name="x"/>
		<xsl:param name="y"/>
		<xsl:param name="s"/>
		<xsl:call-template name="lerp">
			<xsl:with-param name="x" select="$x"/>
			<xsl:with-param name="y" select="$y"/>
			<xsl:with-param name="s" select="$s * $s * (3 - 2 * $s)"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="lerp">
		<xsl:param name="x"/>
		<xsl:param name="y"/>
		<xsl:param name="s"/>
		<xsl:value-of select="$x + $s * ($y - $x)"/>
	</xsl:template>

	<xsl:template name="noise2">
		<xsl:param name="x"/>
		<xsl:param name="y"/>
		<xsl:param name="seed"/>
		<xsl:variable name="yIdx" select="($y + $seed) mod 256"/>
		<xsl:variable name="yHash">
			<xsl:call-template name="getHash">
				<xsl:with-param name="i">
					<xsl:choose>
						<xsl:when test="$yIdx &lt; 0">
							<xsl:value-of select="$yIdx + 256"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$yIdx"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="xIdx" select="($yHash + $x) mod 256"/>
		<xsl:variable name="xHash">
			<xsl:call-template name="getHash">
				<xsl:with-param name="i">
					<xsl:choose>
						<xsl:when test="$xIdx &lt; 0">
							<xsl:value-of select="$xIdx + 256"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$xIdx"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
		<xsl:value-of select="floor($xHash)"/>
	</xsl:template>

  <xsl:template match="//noise-map/pixel/@x">
    <xsl:attribute name="x" select="."/>
  </xsl:template>

  <xsl:template match="//noise-map/pixel/@y">
    <xsl:attribute name="y" select="."/>
  </xsl:template>

</xsl:stylesheet>