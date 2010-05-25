<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
  <xsl:output method="xml" encoding="utf-8" indent="yes" omit-xml-declaration="yes" />

  <!--<xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>-->

  <xsl:template match="Article">
    <div xmlns="http://www.w3.org/1999/xhtml" class="headline">
      <a href="news.aspx#{@id}">
        <div class="placeholder">
          <xsl:apply-templates select="title"/>
        </div>
      </a>
      <xsl:apply-templates select="content"/>
    </div>
  </xsl:template>
  <!--<xsl:template match="@date">
    <xsl:variable name="date" select="substring-before(., ' ')" />
    <xsl:variable name="monthAndDay" select="substring-after($date, '-')" />
    <div xmlns="http://www.w3.org/1999/xhtml">
      <xsl:value-of select="concat(substring-after($monthAndDay, '-'), '/',
                    substring-before($monthAndDay, '-'), '/', substring-before($date, '-'))"/>
    </div>
  </xsl:template>-->
  <xsl:template match="title">
    <h4 xmlns="http://www.w3.org/1999/xhtml">
      <xsl:apply-templates />
    </h4>
  </xsl:template>
  <xsl:template match="content">
    <p xmlns="http://www.w3.org/1999/xhtml">
      <xsl:variable name="pureText">
        <xsl:call-template name="removeHtmlTags">
          <xsl:with-param name="html" select="string(text())" />
        </xsl:call-template>
      </xsl:variable>
      <xsl:call-template name="truncate_phrase">
        <xsl:with-param name="phrase" select="$pureText" />
        <xsl:with-param name="length" select="200" />
        <xsl:with-param name="truncate_to_word_boundary" select="1" />
      </xsl:call-template>
    </p>
  </xsl:template>

  <xsl:template match="/">
    <xsl:for-each select="ArticlesWarehouse/Articles/Article[@draft = 'false']">
      <xsl:sort select="@date" order="descending" />
      <xsl:if test="position() &lt;= 10">
        <xsl:apply-templates select="."/>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="removeHtmlTags">
    <xsl:param name="html"/>
    <xsl:choose>
      <xsl:when test="contains($html, '&lt;')">
        <xsl:value-of select="substring-before($html, '&lt;')"/>
        <!-- Recurse through HTML -->
        <xsl:call-template name="removeHtmlTags">
          <xsl:with-param name="html" select="substring-after($html, '&gt;')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$html"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="truncate_to_word_boundary">
    <xsl:param name="str" />
    <xsl:variable name="ret" select="substring($str,0,string-length($str))" />

    <xsl:choose>
      <xsl:when test="$str=''" />
      <xsl:when test="substring($str,string-length($str),1)=' '">
        <xsl:value-of select="$ret" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="truncate_to_word_boundary">
          <xsl:with-param name="str">
            <xsl:value-of select="$ret" />
          </xsl:with-param>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="truncate_phrase">
    <xsl:param name="phrase" />
    <xsl:param name="length" />
    <xsl:param name="trailing_string" select="'...'" />
    <xsl:param name="truncate_to_word_boundary" select="0" />

    <xsl:choose>
      <xsl:when test="string-length($phrase)>number($length)">
        <xsl:choose>
          <xsl:when test="$truncate_to_word_boundary">
            <xsl:call-template name="truncate_to_word_boundary">
              <xsl:with-param name="str">
                <xsl:value-of select="substring($phrase,0,number($length))" />
              </xsl:with-param>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="substring($phrase,0,number($length))" />
          </xsl:otherwise>
        </xsl:choose>
        <xsl:value-of select="$trailing_string" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$phrase" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
