<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
  <xsl:import href="../Layout.xsl" />
  <xsl:param name="partialPath" />
  <xsl:param name="id" />
  <xsl:param name="previewid" />
  <xsl:param name="message" />
  <xsl:param name="positiveFeedback" />
  <xsl:param name="title" />
  <xsl:param name="content" />
  <xsl:param name="mainClass" select="'admin'"/>

  <xsl:template match="navigation">
    <ul class="nav">
      <xsl:apply-templates />
    </ul>
  </xsl:template>
  <xsl:template match="section">
    <li>
      <a href="{$partialPath}{@href}">
        <xsl:apply-templates select="@name"/>
      </a>
    </li>
  </xsl:template>
  <xsl:template match="@area">
    <div class="area">
      <div>
        <xsl:value-of select="."/>
      </div>
    </div>
  </xsl:template>
  <xsl:template name="navigation">
    <xsl:apply-templates select="/root/navigation"/>
  </xsl:template>

  <xsl:template match="main">
    <xsl:variable name="formAction">
      <xsl:choose>
        <xsl:when test="string-length($id) > 0">
          <xsl:value-of select="concat('Admin.aspx?aid=', $id)"/>
        </xsl:when>
        <xsl:otherwise>Admin.aspx</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="messageClass">
      <xsl:choose>
        <xsl:when test="$positiveFeedback">success</xsl:when>
        <xsl:otherwise>error</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:apply-templates select="@area"/>
    <h2>
      <xsl:choose>
        <xsl:when test="string-length($id) > 0">Modifica notizia</xsl:when>
        <xsl:otherwise>Nuova notizia</xsl:otherwise>
      </xsl:choose>
    </h2>
    <xsl:if test="string-length($message) > 0">
      <p id="message" class="{$messageClass}">
        <xsl:value-of disable-output-escaping="yes" select="$message"/>
      </p>
    </xsl:if>
    <form id="article" action="{$formAction}" method="post">
      <input type="hidden" name="ispostback" value="true" />
      <p>
        <label for="title">Titolo*</label><br/>
        <input type="text" name="title" maxlength="60" value="{$title}"/>
      </p>
      <p>
        <label for="article">Articolo*</label><br/>
        <textarea id="markitup" type="text" name="content" rows="20" cols="80"><xsl:value-of select="$content"/>&#160;</textarea>
      </p>
      <p>
        <button type="submit">Invia</button>
      </p>
      <p>I campi contrassegnati dall'asterisco (*) sono obbligatori.</p>
    </form>
    <script type="text/javascript">
      // remove &#160;nbsp; from textarea
      $().ready(function(){
        $("textarea").each(function(){
          if (this.value == String.fromCharCode(160))
            this.value = "";
        });
      });
    </script>
  </xsl:template>
  <xsl:template name="main">
    <div>
      <xsl:apply-templates select="/root/main"/>
    </div>
  </xsl:template>
</xsl:stylesheet>
