<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
  <xsl:import href="../Layout.xsl" />
  <xsl:param name="id" />
  <xsl:param name="previewid" />

  <xsl:template match="Article">
    <div xmlns="http://www.w3.org/1999/xhtml" class="article" id="{@id}">
      <xsl:apply-templates select="title"/>
      <div class="meta">
        <xsl:text>Scritto</xsl:text>
        <xsl:apply-templates select="@author"/>
        <xsl:apply-templates select="@date"/>
      </div>
      <xsl:apply-templates select="content"/>
    </div>
  </xsl:template>
  <xsl:template mode="preview" match="Article">
    <!--<xsl:variable name="formAction">
      <xsl:choose>
        <xsl:when test="string-length($id) > 0">
          <xsl:value-of select="concat('Admin.aspx?a=', $id)"/>
        </xsl:when>
        <xsl:otherwise>Admin.aspx</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>-->
    <div class="area">
      <div>Pubblicazione</div>
    </div>
    <h2>Anteprima</h2>
    <xsl:apply-templates select="." />    
    <form id="articlePreview" action="Admin.aspx" method="post">
      <input type="hidden" name="previewid" value="{$previewid}"/>
      <input type="hidden" name="ispostback" value="true" />
      <p>
        <button type="submit">Pubblica</button>
        <a href="Admin.aspx?aid={$id}">Indietro</a>
      </p>
    </form>
  </xsl:template>
  <xsl:template name="main">
    <xsl:apply-templates mode="preview" select="/ArticlesWarehouse/Articles/Article[@id = $id]" />
  </xsl:template>
</xsl:stylesheet>
