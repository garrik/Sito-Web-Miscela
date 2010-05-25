<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
  <xsl:output method="xml" encoding="utf-8" indent="yes" omit-xml-declaration="yes"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />
  <xsl:param name="partialPath" />
  <xsl:param name="includeScripts" />
  <xsl:param name="username" select="''"/>
  <xsl:param name="mainClass" select="''"/>

  <xsl:template match="@date">
    <xsl:variable name="date" select="substring-before(., ' ')" />
    <xsl:variable name="monthAndDay" select="substring-after($date, '-')" />
    <xsl:value-of select="concat(' il ', substring-after($monthAndDay, '-'), '/',
                    substring-before($monthAndDay, '-'), '/', substring-before($date, '-'))"/>
  </xsl:template>
  <xsl:template match="@author">
    <xsl:value-of select="concat(' da ', .)" />
  </xsl:template>
  <xsl:template match="@draft">
    <xsl:text> - </xsl:text>
    <em xmlns="http://www.w3.org/1999/xhtml">
      <strong>Bozza</strong>
    </em>
  </xsl:template>
  <xsl:template match="title">
    <h3 xmlns="http://www.w3.org/1999/xhtml">
      <xsl:apply-templates />
    </h3>
  </xsl:template>
  <xsl:template match="preview">
    <p class="intro" xmlns="http://www.w3.org/1999/xhtml">
      <xsl:apply-templates />
    </p>
  </xsl:template>
  <xsl:template match="content">
    <p xmlns="http://www.w3.org/1999/xhtml">
      <xsl:value-of disable-output-escaping="yes" select="."/>
    </p>
  </xsl:template>

  <xsl:template name="aside">
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
  <xsl:template name="main" />

  <xsl:template name="navigation">
    <ul xmlns="http://www.w3.org/1999/xhtml" class="nav">
      <li>
        <a href="{$partialPath}news.aspx">News</a>
      </li>
      <li>
        <a href="{$partialPath}events.htm">Eventi</a>
      </li>
      <li>
        <a href="{$partialPath}about.htm">Miscela</a>
      </li>
      <li>
        <a href="{$partialPath}partners.htm">Partner</a>
      </li>
      <li>
        <a href="{$partialPath}community.htm">Community</a>
      </li>
    </ul>
  </xsl:template>

  <xsl:template match="/">
    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <meta http-equiv="Content-Language" content="it" />
        <title>Associazione Miscela</title>
        <meta name="Keywords" content="associazione, miscela, rock, festival, etica, bella, musica, arte, spettacolo, ambiente, giovani" />
        <meta name="Description" content="Il sito ufficiale dell'Associazione Miscela." />
        <link href="{$partialPath}img/miscela.ico" rel="icon" type="image/vnd.microsoft.icon" />
        <link rel="stylesheet" href="{$partialPath}css/blueprint/screen.css" type="text/css" media="screen, projection" />
        <link rel="stylesheet" href="{$partialPath}css/blueprint/print.css" type="text/css" media="print" />
        <link rel="stylesheet" href="{$partialPath}css/miscela.css" type="text/css" />
        <xsl:value-of disable-output-escaping="yes" select="$includeScripts"/>
      </head>
      <body class="{$mainClass}">
        <div class="container">
          <div class="header span-24 last">
            <div class="aside span-6">
              <h1>
                <a href="http://www.associazionemiscela.it/home.htm">
                  <img alt="Associazione Miscela" src="{$partialPath}img/MiscelaLogo.png" />
                </a>
              </h1>
            </div>
            <div class="span-18 last">
              <xsl:call-template name="navigation" />
            </div>
          </div>
          <div class="aside span-6">
            <xsl:call-template name="aside" />
          </div>
          <div class="main span-18 last">
            <xsl:call-template name="main" />
          </div>
          <div class="footer span-24 last">
            <address class="vcard">
              <a href="http://www.associazionemiscela.it" class="fn org url">Associazione Miscela</a>
              <span class="adr">
                <span class="street-address">Piazza Ruggia c/o Gianni Rodari</span>,
                <span class="locality">Romano Canavese</span>
                (<abbr class="region" title="Torino">TO</abbr>)
                <span class="postal-code">10090</span>
                <span class="country-name">Italia</span>
              </span>
              <span>PI 10046370010</span>
            </address>
            <ul class="info">
              <li>
                <a rel="license" href="http://creativecommons.org/licenses/by-nc/2.5/it/">Copyright</a>
              </li>
              <li>
                <a href="{$partialPath}contacts.htm">Contatti</a>
              </li>
              <li>
                  <a href="/credits.htm">Crediti</a>
              </li>
            </ul>
          </div>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
