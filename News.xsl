<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
  <xsl:import href="Layout.xsl" />
  <xsl:output method="xml" encoding="utf-8" indent="yes" omit-xml-declaration="yes"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />
  <xsl:param name="id" />
  <xsl:param name="partialPath" />
  <xsl:param name="includeScripts" />
  <xsl:param name="username" select="''"/>
  <xsl:param name="mainClass" select="''"/>
  <xsl:param name="pageNumber" select="1"/>
  <xsl:param name="itemsPerPage" select="10"/>

  <xsl:template match="Article">
    <div xmlns="http://www.w3.org/1999/xhtml" class="article" id="{@id}">
      <xsl:if test="string-length($username) > 0">
        <ul class="tools">
          <li>
            <a href="/admin/admin.aspx?aid={@id}">Modifica</a>
          </li>
          <li>
            <a href="/admin/deletenews.aspx?aid={@id}">Elimina</a>
          </li>
        </ul>
      </xsl:if>
      <xsl:apply-templates select="title"/>
      <div class="meta">
        <xsl:text>Scritto</xsl:text>
        <xsl:apply-templates select="@author"/>
        <xsl:apply-templates select="@date"/>
        <xsl:apply-templates select="@draft[. = 'true']"/>
      </div>
      <xsl:apply-templates select="content"/>
    </div>
  </xsl:template>

  <xsl:template name="aside">
    <xsl:if test="string-length($username) > 0">
      <div class="area">
        <div>Strumenti</div>
      </div>
      <div class="headline">
        <a href="/admin/admin.aspx">
          <div class="placeholder">
            <h4>Scrivi una nuova notizia</h4>
          </div>
        </a>
      </div>
    </xsl:if>
    <div class="area">
      <div>Eventi</div>
    </div>
    <div class="headline mrf">
      <a href="{$partialPath}mrf.htm">
        <div class="placeholder">
          <h4>Miscela Rock Festival</h4>
        </div>
      </a>
    </div>
    <div class="headline jmc">
      <a href="{$partialPath}events.htm">
        <div class="placeholder">
          <h4>JMC</h4>
        </div>
      </a>
    </div>
    <div class="{$partialPath}headline pd">
      <a href="pd.htm">
        <div class="placeholder">
          <h4>Portami il diario!</h4>
        </div>
      </a>
    </div>
  </xsl:template>
  <xsl:template name="main">
    <xsl:variable name="firstItemPosition" select="($pageNumber - 1) * $itemsPerPage"/>
    <xsl:variable name="lastItemPosition" select="$pageNumber * $itemsPerPage"/>
    <xsl:variable name="totItems" select="count(/ArticlesWarehouse/Articles/Article)" />
    <xsl:variable name="lastPage" select="ceiling($totItems div $itemsPerPage)" />
    <div xmlns="http://www.w3.org/1999/xhtml">
      <div class="area">
        <div>News</div>
      </div>
      <h2 class="hidden">News</h2>
      <!--<xsl:for-each select="/ArticlesWarehouse/Articles/Article">
        <xsl:sort select="@date" order="descending" />
        <xsl:apply-templates select="self::node()[position() > 0 and position() &lt;= 1]"/>
      </xsl:for-each>-->
      <!--<xsl:apply-templates select="/ArticlesWarehouse/Articles/Article[position() > $firstItemPosition and position() &lt;= $lastItemPosition]">
        <xsl:sort select="@date" order="descending" />
      </xsl:apply-templates>-->
      <xsl:choose>
        <xsl:when test="string-length($username) > 0">
          <xsl:for-each select="/ArticlesWarehouse/Articles/Article">
            <xsl:sort select="@date" order="descending" />
            <xsl:if test="position() > $firstItemPosition and position() &lt;= $lastItemPosition">
              <xsl:apply-templates select="."/>
            </xsl:if>
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
          <xsl:for-each select="/ArticlesWarehouse/Articles/Article[@draft = 'false']">
            <xsl:sort select="@date" order="descending" />
            <xsl:if test="position() > $firstItemPosition and position() &lt;= $lastItemPosition">
              <xsl:apply-templates select="."/>
            </xsl:if>
          </xsl:for-each>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="$totItems > $itemsPerPage">
        <div xmlns="http://www.w3.org/1999/xhtml" class="pager">
          <xsl:if test="$pageNumber > 1">
            <a href="News.aspx?p={$pageNumber - 1}">Indietro</a>
          </xsl:if>
          <xsl:if test="$pageNumber &lt; $lastPage">
            <a href="News.aspx?p={$pageNumber + 1}">Avanti</a>
          </xsl:if>
        </div>
      </xsl:if>
    </div>
  </xsl:template>
  
  <xsl:template name="navigation">
    <ul xmlns="http://www.w3.org/1999/xhtml" class="nav">
      <li class="selected">
        <a href="news.aspx">News</a>
      </li>
      <li>
        <a href="events.htm">Eventi</a>
      </li>
      <li>
        <a href="about.htm">Miscela</a>
      </li>
      <li>
        <a href="partners.htm">Partner</a>
      </li>
      <li>
        <a href="community.htm">Community</a>
      </li>
    </ul>
  </xsl:template>
</xsl:stylesheet>
