﻿<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:strip-space elements="*"/>
    <!-- Creates the body of the finding aid.-->

    <!-- Variables-->

    <xsl:variable name="language">
        <xsl:value-of select="ead/eadheader/profiledesc/langusage/language/@langcode"/>
    </xsl:variable>

    <xsl:variable name="dscType">
        <xsl:value-of select="ead/archdesc/dsc/@type"/>
    </xsl:variable>

    <xsl:variable name="top">
        <xsl:text>Go to the top of the page</xsl:text>
    </xsl:variable>

    <xsl:variable name="css_url">
        <xsl:text>style.css</xsl:text>
    </xsl:variable>

    <xsl:variable name="file">
        <xsl:value-of select="ead/eadheader/eadid"/>
    </xsl:variable>


    <xsl:template match="ead">



        <html>



            <head>


                <xsl:element name="link">
                    <xsl:attribute name="rel">
                        <xsl:text>stylesheet</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="text">
                        <xsl:text>text/css</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="href">
                        <xsl:value-of select="$css_url"/>
                    </xsl:attribute>
                </xsl:element>

                <title>
                    <xsl:value-of select="eadheader/filedesc/titlestmt/titleproper"/>
                    <xsl:text>  </xsl:text>
                    <xsl:value-of select="eadheader/filedesc/titlestmt/subtitle"/>
                </title>

            </head>
            <body>



                <div class="wrapper">
                    <div class="sidebar">


                        <xsl:call-template name="toc"/>


                    </div>
                    <div class="main">


                        <xsl:call-template name="body"/>

                    </div>
                </div>




            </body>
        </html>
    </xsl:template>

    <xsl:template name="toc">

        <table border="0" cellspacing="0" cellpadding="3" valign="top" width="85%">
            <tr>
                <td colspan="4">
                    <xsl:element name="a">
                        <xsl:attribute name="href">
                            <xsl:text>#ead0</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="class">
                            <xsl:text>nav</xsl:text>
                        </xsl:attribute> Description of the Archive </xsl:element>
                </td>
            </tr>
            <tr>
                <xsl:element name="td">
                    <xsl:attribute name="class">
                        <xsl:text>margin-sidebar</xsl:text>
                    </xsl:attribute>
                </xsl:element>
                <td colspan="3">


                    <ul>
                        <li>
                            <a href="#ead1" class="nav">Descriptive Summary</a>
                        </li>

                        <xsl:if test="archdesc/originalsloc">
                            <li>
                                <a href="#ead2" class="nav">Location of Originals</a>
                            </li>
                        </xsl:if>
                        <xsl:if test="archdesc/custodhist">
                            <li>
                                <a href="#ead8" class="nav">Custodial History</a>
                            </li>
                        </xsl:if>
                        <xsl:if test="archdesc/bioghist">
                            <li>
                                <a href="#ead3" class="nav">History Note</a>
                            </li>
                        </xsl:if>


                        <xsl:if test="archdesc/arrangement">
                            <li>
                                <a href="#ead5" class="nav">Organization and Arrangement</a>
                            </li>
                        </xsl:if>



                        <xsl:if test="archdesc/scopecontent">
                            <li>
                                <a href="#ead4" class="nav">Scope and Content</a>
                            </li>
                        </xsl:if>


                        <xsl:if test="archdesc/controlaccess">
                            <li>
                                <a href="#ead6" class="nav">Selected Search Terms</a>
                            </li>
                        </xsl:if>

                        <xsl:if test="archdesc/relatedmaterial">
                            <li>
                                <a href="#ead7" class="nav">Related Materials</a>
                            </li>
                        </xsl:if>

                        <xsl:if test="archdesc/index">

                            <li>
                                <xsl:choose>
                                    <xsl:when test="archdesc/index/head">
                                        <a href="#ead9" class="nav">
                                            <xsl:value-of select="archdesc/index/head"/>
                                        </a>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:choose>
                                            <xsl:when test="$language = 'eng'">
                                                <a href="#ead8" class="nav">
                                                  <xsl:value-of select="archdesc/index/head"/>
                                                </a>
                                            </xsl:when>
                                        </xsl:choose>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </li>

                        </xsl:if>



                    </ul>

                </td>

            </tr>

        </table>




        <xsl:if test="archdesc/dsc">
            <table border="0" cellspacing="0" cellpadding="3" valign="top" width="85%">
                <tr>
                    <td colspan="4">
                        <xsl:element name="a">
                            <xsl:attribute name="href">
                                <xsl:text>#ead-dsc</xsl:text>
                            </xsl:attribute>
                            <xsl:attribute name="class">
                                <xsl:text>nav</xsl:text>
                            </xsl:attribute>
                            <xsl:choose>
                                <xsl:when test="archdesc/dsc/head">
                                    <xsl:value-of select="archdesc/dsc/head"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:choose>
                                        <xsl:when test="$language = 'eng'"> Inventory </xsl:when>
                                        <xsl:when test="$language = 'dut'"> Inventaris </xsl:when>
                                    </xsl:choose>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:element>
                    </td>
                </tr>
                <xsl:for-each select="archdesc/dsc/c01[@level != 'item' and @level != 'file']">
                    <tr>
                        <xsl:element name="td">
                            <xsl:attribute name="class">
                                <xsl:text>margin-sidebar</xsl:text>
                            </xsl:attribute>
                        </xsl:element>
                        <td colspan="3">
                            <xsl:element name="a">
                                <xsl:attribute name="href">
                                    <xsl:text>#</xsl:text>

                                    <xsl:value-of select="@id"/>


                                </xsl:attribute>

                                <xsl:attribute name="class">
                                    <xsl:text>nav</xsl:text>
                                </xsl:attribute>

                                <xsl:if test="did/unitid/@type = 'EAD'">

                                    <xsl:apply-templates select="did/unitid"/>
                                    <xsl:text> </xsl:text>
                                </xsl:if>
                                <xsl:apply-templates select="did/unittitle"/>
                            </xsl:element>
                        </td>
                    </tr>
                    <xsl:for-each select="c02[@level != 'item' and @level != 'file']">
                        <tr>
                            <td width="10%"/>
                            <td width="10%"/>
                            <td colspan="2">

                                <div class="level2">

                                    <xsl:element name="a">
                                        <xsl:attribute name="href">
                                            <xsl:text>#</xsl:text>
                                            <xsl:value-of select="@id"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="class">
                                            <xsl:text>nav</xsl:text>
                                        </xsl:attribute>
                                        <xsl:if test="did/unitid/@type = 'EAD'">

                                            <xsl:apply-templates select="did/unitid"/>
                                            <xsl:text> </xsl:text>
                                        </xsl:if>
                                        <xsl:apply-templates select="did/unittitle"/>
                                    </xsl:element>

                                </div>


                            </td>
                        </tr>
                        <xsl:for-each select="c03[@level != 'item' and @level != 'file']">
                            <tr>
                                <td width="10%"/>
                                <td width="10%"/>
                                <td width="10%"/>
                                <td>

                                    <div class="level3">

                                        <xsl:element name="a">
                                            <xsl:attribute name="href">
                                                <xsl:text>#</xsl:text>
                                                <xsl:value-of select="@id"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="class">
                                                <xsl:text>nav</xsl:text>
                                            </xsl:attribute>
                                            <xsl:if test="did/unitid/@type = 'EAD'">

                                                <xsl:apply-templates select="did/unitid"/>

                                            </xsl:if>
                                            <xsl:apply-templates select="did/unittitle"/>
                                        </xsl:element>

                                    </div>

                                </td>
                            </tr>
                        </xsl:for-each>
                    </xsl:for-each>
                </xsl:for-each>
            </table>
        </xsl:if>
    </xsl:template>


    <xsl:template name="body">




        <div id="div-main" style="overflow:auto;" class="body">

            <xsl:call-template name="head"/>

            <xsl:apply-templates select="archdesc"/>

            <p>
                <br/>
                <br/>

            </p>

        </div>







    </xsl:template>

    <xsl:template name="head">


        <xsl:element name="a">
            <xsl:attribute name="name">
                <xsl:text>ead0</xsl:text>
            </xsl:attribute>
        </xsl:element>


        <p>
            <br/>
        </p>

        <xsl:element name="div">

            <xsl:attribute name="align">
                <xsl:text>center</xsl:text>

            </xsl:attribute>


            <!--<xsl:element name="img">
                <xsl:attribute name="src">
                    <xsl:text>https://disc.leidenuniv.nl/exlibris/dtl/u3_1/dtle/www_r_eng/icon/beeldmerk_wit.gif</xsl:text>

                </xsl:attribute>

            </xsl:element>-->

            <xsl:element name="h1">
                <xsl:value-of select="archdesc/did/unittitle"/>

            </xsl:element>

            <xsl:element name="h4">


                <xsl:choose>
                    <xsl:when test="$language = 'eng'">

                        <xsl:text>Collection guide written by:</xsl:text>

                    </xsl:when>
                    <xsl:otherwise>


                        <xsl:text>Collectiebeschrijving gemaakt door:</xsl:text>
                    </xsl:otherwise>


                </xsl:choose>
            </xsl:element>

            <xsl:value-of select="eadheader/filedesc/titlestmt/author"/>


            <xsl:element name="br"/>


            <xsl:element name="h4">
                <xsl:choose>
                    <xsl:when test="$language = 'eng'">

                        <xsl:text>Digital version:</xsl:text>

                    </xsl:when>
                    <xsl:otherwise>


                        <xsl:text>Digitale versie:</xsl:text>
                    </xsl:otherwise>


                </xsl:choose>

            </xsl:element>

            <xsl:value-of select="eadheader/profiledesc/creation"/>


            <xsl:element name="br"/>

            <xsl:if test="eadheader/revisiondesc">
                <xsl:element name="h4">
                    <xsl:choose>
                        <xsl:when test="$language = 'eng'">

                            <xsl:text>Version update:</xsl:text>

                        </xsl:when>
                        <xsl:otherwise>


                            <xsl:text>Versie update:</xsl:text>
                        </xsl:otherwise>


                    </xsl:choose>

                </xsl:element>
            </xsl:if>
            <xsl:value-of select="eadheader/revisiondesc/change/date"/>

            <xsl:element name="br"/>
        </xsl:element>




        <xsl:element name="p">
            <xsl:element name="br"/>
        </xsl:element>


        <hr/>
    </xsl:template>



    <xsl:template match="archdesc/did">

        <xsl:element name="a">
            <xsl:attribute name="name">
                <xsl:text>ead1</xsl:text>
            </xsl:attribute>
        </xsl:element>

        <h3>

            <xsl:text>Descriptive Summary</xsl:text>

        </h3>



        <table>
            <tr>
                <td class="did-label"></td>
                <td class="did-text"></td>
            </tr>
            <xsl:if test="unittitle[string-length(text() | *) != 0]">
                <xsl:for-each select="unittitle">
                    <tr>
                        <td valign="top">
                            <b>
                                <xsl:choose>
                                    <xsl:when test="@label">
                                        <xsl:value-of select="@label"/>
                                    </xsl:when>
                                    <xsl:otherwise>

                                        <xsl:choose>
                                            <xsl:when test="$language = 'eng'">
                                                <xsl:text>Title:</xsl:text>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:text>Titel:</xsl:text>
                                            </xsl:otherwise>
                                        </xsl:choose>

                                    </xsl:otherwise>
                                </xsl:choose>
                            </b>
                        </td>
                        <td>
                            <xsl:apply-templates select="."/>
                        </td>
                    </tr>
                </xsl:for-each>
            </xsl:if>
            <xsl:if test="origination[string-length(text() | *) != 0]">
                <xsl:for-each select="origination">
                    <tr>
                        <td valign="top">
                            <b>
                                <xsl:choose>
                                    <xsl:when test="@label">
                                        <xsl:value-of select="@label"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:choose>
                                            <xsl:when test="$language = 'eng'">
                                                <xsl:text>Origination:</xsl:text>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:text>Herkomst:</xsl:text>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </b>
                        </td>
                        <td>
                            <xsl:apply-templates select="."/>
                        </td>
                    </tr>
                </xsl:for-each>
            </xsl:if>
            <xsl:if test="unitdate[string-length(text() | *) != 0]">
                <xsl:for-each select="unitdate">
                    <tr>
                        <td valign="top">
                            <b>
                                <xsl:choose>
                                    <xsl:when test="@label">
                                        <xsl:value-of select="@label"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:choose>
                                            <xsl:when test="@type = 'bulk'">
                                                <xsl:choose>
                                                  <xsl:when test="$language = 'eng'">
                                                  <xsl:text>Date (bulk):</xsl:text>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:text>Datering (merendeel):</xsl:text>
                                                  </xsl:otherwise>
                                                </xsl:choose>
                                            </xsl:when>

                                            <xsl:otherwise>
                                                <xsl:choose>
                                                  <xsl:when test="$language = 'eng'">
                                                  <xsl:text>Date:</xsl:text>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:text>Datering:</xsl:text>
                                                  </xsl:otherwise>
                                                </xsl:choose>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </b>
                        </td>
                        <td>
                            <xsl:apply-templates select="."/>
                        </td>
                    </tr>
                </xsl:for-each>
            </xsl:if>
            <xsl:if test="physdesc[string-length(text() | *) != 0]">
                <xsl:for-each select="physdesc">
                    <tr>
                        <td valign="top">
                            <b>
                                <xsl:choose>
                                    <xsl:when test="@label">
                                        <xsl:value-of select="@label"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:choose>
                                            <xsl:when test="$language = 'eng'">
                                                <xsl:text>Extent:</xsl:text>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:text>Omvang:</xsl:text>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </b>
                        </td>
                        <td>
                            <xsl:apply-templates select="."/>
                        </td>
                    </tr>
                </xsl:for-each>
            </xsl:if>
            <xsl:if test="langmaterial[string-length(text() | *) != 0]">
                <xsl:for-each select="langmaterial">
                    <tr>
                        <td valign="top">
                            <b>
                                <xsl:choose>
                                    <xsl:when test="@label">
                                        <xsl:value-of select="@label"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:choose>
                                            <xsl:when test="$language = 'eng'">
                                                <xsl:text>Language:</xsl:text>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:text>Taal:</xsl:text>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </b>
                        </td>
                        <td>
                            <xsl:apply-templates select="."/>
                        </td>
                    </tr>
                </xsl:for-each>
            </xsl:if>
            <xsl:if test="abstract[string-length(text() | *) != 0]">
                <xsl:for-each select="abstract">
                    <tr>
                        <td valign="top">
                            <b>
                                <xsl:choose>
                                    <xsl:when test="@langcode = 'dut'">
                                        <xsl:text>Korte samenvatting: </xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text>Abstract: </xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </b>
                        </td>
                        <td>
                            <xsl:apply-templates select="."/>
                        </td>
                    </tr>
                </xsl:for-each>
            </xsl:if>
            <xsl:if test="unitid[string-length(text() | *) != 0]">
                <xsl:for-each select="unitid">
                    <tr>
                        <td valign="top">
                            <b>
                                <xsl:choose>
                                    <xsl:when test="@label">
                                        <xsl:value-of select="@label"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:choose>
                                            <xsl:when test="$language = 'eng'">
                                                <xsl:text>Ordernumber:</xsl:text>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:text>Bestellingsnummer:</xsl:text>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </b>
                        </td>
                        <td>
                            <xsl:apply-templates select="."/>
                        </td>
                    </tr>
                </xsl:for-each>
            </xsl:if>
            <xsl:if test="repository[string-length(text() | *) != 0]">
                <xsl:for-each select="repository">
                    <tr>
                        <td valign="top">
                            <b>
                                <xsl:choose>
                                    <xsl:when test="@label">
                                        <xsl:value-of select="@label"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:choose>
                                            <xsl:when test="$language = 'eng'">
                                                <xsl:text>Institution:</xsl:text>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:text>Instelling:</xsl:text>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </b>
                        </td>
                        <td>
                            <xsl:apply-templates select="."/>
                        </td>
                    </tr>
                </xsl:for-each>
            </xsl:if>
            <xsl:if test="physloc[string-length(text() | *) != 0]">
                <xsl:for-each select="physloc">
                    <tr>
                        <td valign="top">
                            <b>
                                <xsl:choose>
                                    <xsl:when test="@label">
                                        <xsl:value-of select="@label"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:choose>
                                            <xsl:when test="$language = 'eng'">
                                                <xsl:text>Location:</xsl:text>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:text>Bewaarplaats:</xsl:text>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </b>
                        </td>
                        <td>
                            <xsl:apply-templates select="."/>
                        </td>
                    </tr>
                </xsl:for-each>
            </xsl:if>
        </table>
        <br/>


    </xsl:template>
    <!-- the descgrp element doens't exist in the xml files
        
        <xsl:template match="archdesc/descgrp">

        <xsl:choose>
            <xsl:when test="@type = 'context'">

                <xsl:element name="a">
                    <xsl:attribute name="name">
                        <xsl:text>ead2</xsl:text>
                    </xsl:attribute>
                </xsl:element>
                <xsl:element name="table">
                    <xsl:attribute name="width">
                        <xsl:text>100%</xsl:text>
                    </xsl:attribute>
                    <xsl:element name="tr">
                        <xsl:element name="td">

                            <p>
                                <br/>
                            </p>

                            <h3>
                                <xsl:choose>
                                    <xsl:when test="$language = 'eng'">
                                        <xsl:text>Origination and acquisition</xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text>Herkomst en verwerving</xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </h3>
                        </xsl:element>
                        <xsl:element name="td">
                            <xsl:attribute name="align">
                                <xsl:text>right</xsl:text>
                            </xsl:attribute>
                            <xsl:element name="a">
                                <xsl:attribute name="href">
                                    <xsl:text>#ead0</xsl:text>
                                </xsl:attribute>
                                <xsl:element name="img">
                                    <xsl:attribute name="src">
                                        <xsl:text>https://socrates.leidenuniv.nl/exlibris/dtl/u3_1/dtle/www_r_eng/icon/top.gif</xsl:text>
                                    </xsl:attribute>
                                    <xsl:attribute name="border">
                                        <xsl:text>0</xsl:text>
                                    </xsl:attribute>
                                    <xsl:attribute name="alt">
                                        <xsl:value-of select="$top"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="title">
                                        <xsl:value-of select="$top"/>
                                    </xsl:attribute>
                                </xsl:element>
                            </xsl:element>
                        </xsl:element>
                    </xsl:element>
                </xsl:element>

                <xsl:call-template name="blockquote"/>

            </xsl:when>
            <xsl:when test="@type = 'content_and_structure'">

                <xsl:element name="a">
                    <xsl:attribute name="name">
                        <xsl:text>ead3</xsl:text>
                    </xsl:attribute>
                </xsl:element>
                <xsl:element name="table">
                    <xsl:attribute name="width">
                        <xsl:text>100%</xsl:text>
                    </xsl:attribute>
                    <xsl:element name="tr">
                        <xsl:element name="td">

                            <p>
                                <br/>
                            </p>

                            <h3>
                                <xsl:choose>
                                    <xsl:when test="$language = 'eng'">
                                        <xsl:text>Contents and structure</xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text>Inhoud en samenstelling</xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </h3>
                        </xsl:element>
                        <xsl:element name="td">
                            <xsl:attribute name="align">
                                <xsl:text>right</xsl:text>
                            </xsl:attribute>
                            <xsl:element name="a">
                                <xsl:attribute name="href">
                                    <xsl:text>#ead0</xsl:text>
                                </xsl:attribute>
                                <xsl:element name="img">
                                    <xsl:attribute name="src">
                                        <xsl:text>https://socrates.leidenuniv.nl/exlibris/dtl/u3_1/dtle/www_r_eng/icon/top.gif</xsl:text>
                                    </xsl:attribute>
                                    <xsl:attribute name="border">
                                        <xsl:text>0</xsl:text>
                                    </xsl:attribute>
                                    <xsl:attribute name="alt">
                                        <xsl:value-of select="$top"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="title">
                                        <xsl:value-of select="$top"/>
                                    </xsl:attribute>
                                </xsl:element>
                            </xsl:element>
                        </xsl:element>
                    </xsl:element>
                </xsl:element>

                <xsl:call-template name="blockquote"/>

            </xsl:when>
            <xsl:when test="@type = 'access_and_use'">

                <xsl:element name="a">
                    <xsl:attribute name="name">
                        <xsl:text>ead4</xsl:text>
                    </xsl:attribute>
                </xsl:element>
                <xsl:element name="table">
                    <xsl:attribute name="width">
                        <xsl:text>100%</xsl:text>
                    </xsl:attribute>
                    <xsl:element name="tr">
                        <xsl:element name="td">

                            <p>
                                <br/>
                            </p>
                            <h3>
                                <xsl:choose>
                                    <xsl:when test="$language = 'eng'">
                                        <xsl:text>User instructions</xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text>Aanwijzingen voor de gebruiker</xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </h3>
                        </xsl:element>
                        <xsl:element name="td">
                            <xsl:attribute name="align">
                                <xsl:text>right</xsl:text>
                            </xsl:attribute>
                            <xsl:element name="a">
                                <xsl:attribute name="href">
                                    <xsl:text>#ead0</xsl:text>
                                </xsl:attribute>
                                <xsl:element name="img">
                                    <xsl:attribute name="src">
                                        <xsl:text>https://socrates.leidenuniv.nl/exlibris/dtl/u3_1/dtle/www_r_eng/icon/top.gif</xsl:text>
                                    </xsl:attribute>
                                    <xsl:attribute name="border">
                                        <xsl:text>0</xsl:text>
                                    </xsl:attribute>
                                    <xsl:attribute name="alt">
                                        <xsl:value-of select="$top"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="title">
                                        <xsl:value-of select="$top"/>
                                    </xsl:attribute>
                                </xsl:element>
                            </xsl:element>
                        </xsl:element>
                    </xsl:element>
                </xsl:element>

                <xsl:call-template name="blockquote"/>

            </xsl:when>
            <xsl:when test="archdesc/relatedmaterial">

                <xsl:element name="a">
                    <xsl:attribute name="name">
                        <xsl:text>ead7</xsl:text>
                    </xsl:attribute>
                </xsl:element>
                <xsl:element name="table">
                    <xsl:attribute name="width">
                        <xsl:text>100%</xsl:text>
                    </xsl:attribute>
                    <xsl:element name="tr">
                        <xsl:element name="td">


                            <p>
                                <br/>
                            </p>
                            <h3>
                                <xsl:choose>
                                    <xsl:when test="$language = 'eng'">
                                        <xsl:text>Related materials</xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text>Verwant materiaal</xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </h3>
                        </xsl:element>
                        <xsl:element name="td">
                            <xsl:attribute name="align">
                                <xsl:text>right</xsl:text>
                            </xsl:attribute>
                            <xsl:element name="a">
                                <xsl:attribute name="href">
                                    <xsl:text>#ead0</xsl:text>
                                </xsl:attribute>
                                <xsl:element name="img">
                                    <xsl:attribute name="src">
                                        <xsl:text>https://socrates.leidenuniv.nl/exlibris/dtl/u3_1/dtle/www_r_eng/icon/top.gif</xsl:text>
                                    </xsl:attribute>
                                    <xsl:attribute name="border">
                                        <xsl:text>0</xsl:text>
                                    </xsl:attribute>
                                    <xsl:attribute name="alt">
                                        <xsl:value-of select="$top"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="title">
                                        <xsl:value-of select="$top"/>
                                    </xsl:attribute>
                                </xsl:element>
                            </xsl:element>
                        </xsl:element>
                    </xsl:element>
                </xsl:element>
                <hr/>
                <xsl:call-template name="blockquote"/>

            </xsl:when>
            <xsl:when test="@type = 'appendices'">

                <xsl:element name="a">
                    <xsl:attribute name="name">
                        <xsl:text>ead6</xsl:text>
                    </xsl:attribute>
                </xsl:element>
                <xsl:element name="table">
                    <xsl:attribute name="width">
                        <xsl:text>100%</xsl:text>
                    </xsl:attribute>
                    <xsl:element name="tr">
                        <xsl:element name="td">

                            <p>
                                <br/>
                            </p>

                            <h3>
                                <xsl:choose>
                                    <xsl:when test="$language = 'eng'">
                                        <xsl:text>Literature</xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text>Literatuur</xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </h3>
                        </xsl:element>
                        <xsl:element name="td">
                            <xsl:attribute name="align">
                                <xsl:text>right</xsl:text>
                            </xsl:attribute>
                            <xsl:element name="a">
                                <xsl:attribute name="href">
                                    <xsl:text>#ead0</xsl:text>
                                </xsl:attribute>
                                <xsl:element name="img">
                                    <xsl:attribute name="src">
                                        <xsl:text>https://socrates.leidenuniv.nl/exlibris/dtl/u3_1/dtle/www_r_eng/icon/top.gif</xsl:text>
                                    </xsl:attribute>
                                    <xsl:attribute name="border">
                                        <xsl:text>0</xsl:text>
                                    </xsl:attribute>
                                    <xsl:attribute name="alt">
                                        <xsl:value-of select="$top"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="title">
                                        <xsl:value-of select="$top"/>
                                    </xsl:attribute>
                                </xsl:element>
                            </xsl:element>
                        </xsl:element>
                    </xsl:element>
                </xsl:element>

                <xsl:call-template name="blockquote"/>

            </xsl:when>
        </xsl:choose>
    </xsl:template> -->

    <xsl:template match="archdesc/dsc">

        <a name="ead-dsc"/>
        <xsl:element name="table">
            <xsl:attribute name="width">
                <xsl:text>100%</xsl:text>
            </xsl:attribute>
            <xsl:element name="tr">
                <xsl:element name="td">
                    <h3>
                        <xsl:choose>
                            <xsl:when test="string-length(head) > 0">
                                <xsl:apply-templates select="head"/>
                            </xsl:when>
                            <xsl:when test="$language = 'eng'">
                                <xsl:text>Contents list</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>Inventaris</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </h3>
                  
                </xsl:element>
                <hr/>
            
            </xsl:element>
        </xsl:element>

        <xsl:if test="p">
    
                <xsl:apply-templates select="."/>
            
        </xsl:if>
        <table width="100%" border="0" cellspacing="0">
            <tr>
               <xsl:element name="td">
                   <xsl:attribute name="class">
                       <xsl:text>margin-dsc</xsl:text>
                   </xsl:attribute>
               </xsl:element>
                <xsl:element name="td">
                    <xsl:attribute name="class">
                        <xsl:text>margin-dsc</xsl:text>
                    </xsl:attribute>
                </xsl:element> 
                <xsl:element name="td">
                    <xsl:attribute name="class">
                        <xsl:text>margin-dsc</xsl:text>
                    </xsl:attribute>
                </xsl:element> 
                <xsl:element name="td">
                    <xsl:attribute name="class">
                        <xsl:text>margin-dsc</xsl:text>
                    </xsl:attribute>
                </xsl:element>
                <xsl:element name="td">
                    <xsl:attribute name="class">
                        <xsl:text>margin-dsc</xsl:text>
                    </xsl:attribute>
                </xsl:element>
                <xsl:element name="td">
                    <xsl:attribute name="class"> <xsl:text>margin-dsc</xsl:text>
                    </xsl:attribute>
                </xsl:element>
                <xsl:element name="td">
                    <xsl:attribute name="class"> <xsl:text>margin-dsc</xsl:text></xsl:attribute>
                </xsl:element>
                <xsl:element name="td">
                    <xsl:attribute name="class"> <xsl:text>margin-dsc</xsl:text></xsl:attribute>
                </xsl:element>
                <xsl:element name="td">
                    <xsl:attribute name="class"> <xsl:text>margin-dsc</xsl:text></xsl:attribute>
                </xsl:element>
                <xsl:element name="td">
                    <xsl:attribute name="class"> <xsl:text>margin-dsc</xsl:text></xsl:attribute>
                </xsl:element>
                <xsl:element name="td">
                    <xsl:attribute name="class"> <xsl:text>margin-dsc</xsl:text></xsl:attribute>
                </xsl:element>
                <xsl:element name="td">
                    <xsl:attribute name="class"> <xsl:text>margin-dsc</xsl:text></xsl:attribute>
                </xsl:element>
               
             
             
              
              
            
            </tr>
            <xsl:apply-templates select="c01"/>
        </table>
    </xsl:template>
    <xsl:template name="blockquote">
        <blockquote>
            <xsl:apply-templates/>
            <xsl:if test="*/p/note">
                <p>
                    <b>
                        <i>
                            <xsl:choose>
                                <xsl:when test="contains($language, 'eng')">
                                    <xsl:text>Notes</xsl:text>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:text>Noten</xsl:text>
                                    <br/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </i>
                    </b>
                </p>
            </xsl:if>
            <xsl:apply-templates select=".//note[normalize-space()]" mode="footnotes"/>
        </blockquote>

    </xsl:template>
    <!-- the below template doesn't match an element in Brill's finding aids
        <xsl:template match="chronlist">
        <table border="1" style="margin: 1em 2em 1em 2em">
            <tr>
                <th style="padding: 0.3em 1em 0.3em 1em">
                    <xsl:value-of select="listhead/head01"/>
                </th>
                <th style="padding: 0.3em 1em 0.3em 1em">
                    <xsl:value-of select="listhead/head02"/>
                </th>
            </tr>
            <xsl:for-each select="chronitem">
                <tr>
                    <td style="padding: 0.3em 1em 0.3em 1em">
                        <xsl:value-of select="date"/>
                    </td>
                    <td style="padding: 0.3em 1em 0.3em 1em">
                        <xsl:value-of select="event"/>
                    </td>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>
    -->

    <xsl:template match="list">
        <xsl:choose>
            <xsl:when test="@type = 'deflist'">
                <ul>
                    <xsl:for-each select="defitem">
                        <li>
                            <xsl:apply-templates/>
                        </li>
                    </xsl:for-each>
                </ul>
            </xsl:when>
            <xsl:otherwise>
                <ul>
                    <xsl:for-each select="item">
                        <li>
                            <xsl:apply-templates/>
                        </li>
                    </xsl:for-each>
                </ul>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="table">
        <table>
            <tr>
                <xsl:for-each select="tgroup/colspec">
                    <td>
                        <xsl:attribute name="width">
                            <xsl:value-of select="@colwidth"/>
                        </xsl:attribute>
                    </td>
                </xsl:for-each>
                <xsl:apply-templates select="tgroup/tbody/row"/>
            </tr>
        </table>
    </xsl:template>
    <xsl:template match="table//row">
        <tr>
            <xsl:for-each select="entry">
                <td>
                    <xsl:value-of select="."/>
                </td>
            </xsl:for-each>
        </tr>
    </xsl:template>
    <xsl:template match="defitem/label">
        <b>
            <xsl:apply-templates/>
        </b>
    </xsl:template>
    <xsl:template match="defitem/item">
        <br/>
        <xsl:apply-templates/>
    </xsl:template>



    <!-- below is specific to LU and thus not relevant for Brill
    <xsl:template match="userestrict//extref">

        <xsl:element name="a">

            <xsl:attribute name="target">

                <xsl:text>_blank</xsl:text>

            </xsl:attribute>



            <xsl:attribute name="href">
                <xsl:text>https://www.bibliotheek.universiteitleiden.nl/bezoek-en-gebruik/praktische-informatie-bijzondere-collecties/toegang</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
-->

    <xsl:template match="extref">
        <xsl:variable name="exthref">
            <xsl:value-of select="@href"/>
        </xsl:variable>
        <xsl:element name="a">

            <xsl:attribute name="target">

                <xsl:text>_blank</xsl:text>

            </xsl:attribute>



            <xsl:attribute name="href">
                <xsl:if test="@role = 'EAD'">
                    <xsl:text>https://socrates.leidenuniv.nl/view/xserver/view.jsp?request=</xsl:text>
                </xsl:if>


                <xsl:value-of select="$exthref"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="extptr">
        <xsl:variable name="exthref">
            <xsl:value-of select="@href"/>
        </xsl:variable>
        <img src="{$exthref}"/>
    </xsl:template>
    <xsl:template match="archref">
        <xsl:variable name="link">
            <xsl:value-of select="@href"/>
        </xsl:variable>
        <xsl:variable name="show">
            <xsl:value-of select="@show"/>
        </xsl:variable>
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:value-of select="$link"/>
            </xsl:attribute>
            <xsl:attribute name="target">
                <xsl:choose>
                    <xsl:when test="$show = 'replace'">
                        <xsl:text>_self</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>_top</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="scopecontent//archref">
        <xsl:variable name="link">
            <xsl:value-of select="@href"/>
        </xsl:variable>
        <xsl:variable name="show">
            <xsl:value-of select="@show"/>
        </xsl:variable>
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:value-of select="$link"/>
            </xsl:attribute>
            <xsl:attribute name="target">
                <xsl:choose>
                    <xsl:when test="$show = 'replace'">
                        <xsl:text>_self</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>_top</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:value-of select="unittitle"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="ref">
        <xsl:variable name="link">
            <xsl:value-of select="@target"/>
        </xsl:variable>
        <xsl:variable name="show">
            <xsl:value-of select="@show"/>
        </xsl:variable>
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:text>#</xsl:text>
                <xsl:value-of select="$link"/>
            </xsl:attribute>
            <xsl:attribute name="target">
                <xsl:choose>
                    <xsl:when test="$show = 'replace'">
                        <xsl:text>_self</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>_top</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="note">
        <xsl:variable name="href">
            <xsl:value-of select="count(preceding::note[normalize-space()]) + 1"/>
        </xsl:variable>
        <a>
            <xsl:attribute name="href">
                <xsl:value-of select="concat('#n', $href)"/>
            </xsl:attribute>
            <xsl:text>[</xsl:text>
            <xsl:value-of select="$href"/>
            <xsl:text>]</xsl:text>
        </a>
    </xsl:template>
    <xsl:template match="note" mode="footnotes">
        <xsl:element name="a">
            <xsl:attribute name="name">
                <xsl:text>n</xsl:text>
                <xsl:value-of select="count(preceding::note[normalize-space()]) + 1"/>
            </xsl:attribute>
        </xsl:element>
        <xsl:value-of select="concat(count(preceding::note[normalize-space()]) + 1, '. ')"/>
        <xsl:apply-templates mode="footnotes"/>
        <xsl:element name="br"/>
    </xsl:template>
    <xsl:template match="descgrp//note/p" mode="footnotes">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="archdesc/bioghist">
        <a name="ead3"/>
        <p>
            <h3>
                <xsl:choose>
                    <xsl:when test="head">
                        <xsl:apply-templates select="head"/>
                    </xsl:when>
                    <xsl:otherwise>

                        <xsl:choose>
                            <xsl:when test="/ead/archdesc/did/origination">
                                <xsl:text>Biography</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>History note</xsl:otherwise>
                        </xsl:choose>

                    </xsl:otherwise>


                
                </xsl:choose>
            </h3>
        </p>
        <xsl:for-each select="*[name() != 'head']">
            <xsl:apply-templates select="."/>
          
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="archdesc/custodhist">
        <a name="ead8"/>
     
            <h3>
                <xsl:choose>
                    <xsl:when test="head">
                        <xsl:apply-templates select="head"/>
                    </xsl:when>

                    <xsl:when test="$language = 'eng'">
                        <xsl:text>Custodial history</xsl:text>
                    </xsl:when>

                    <xsl:otherwise>
                        <xsl:text>Herkomstgeschiedenis</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </h3>
        <xsl:for-each select="*[name() != 'head']">
            <xsl:apply-templates select="."/>
         
        </xsl:for-each>
   
    </xsl:template>
    
    <xsl:template match="archdesc/scopecontent">
        <a name="ead4"/>
        <p>
            <h3>
                <xsl:choose>
                    <xsl:when test="head">
                        <xsl:apply-templates select="head"/>
                    </xsl:when>
                    <xsl:when test="$language = 'eng'">
                        <xsl:text>Contents and organisation </xsl:text>
                    </xsl:when>

                    <xsl:otherwise>
                        <xsl:text>Specificatie inhoud</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </h3>
        </p>

        <xsl:apply-templates select="*[name() != 'head']"/>

        <!-- the above for-each loop creates extra space after the section on scope and content but it's the only way (so far) I've figured out how to create space between the paragraphs -->
    </xsl:template>




    <!-- below template doens't match any elements in Brill's finding aids
    <xsl:template match="descgrp/processinfo">
        <a name="a9"/>
        <p>
            <b>
                <xsl:choose>
                    <xsl:when test="head">
                        <xsl:apply-templates select="head"/>
                    </xsl:when>
                    <xsl:when test="$language = 'eng'">
                        <xsl:text>Processing history</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>Bewerking</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </b>
        </p>
        <xsl:apply-templates select="*[name() != 'head']"/>
    </xsl:template>
    -->
    <xsl:template match="archdesc/arrangement">
        <a name="ead5"/>
        <p>
            <h3>
                <xsl:choose>
                    <xsl:when test="head">
                        <xsl:apply-templates select="head"/>
                    </xsl:when>
                    <xsl:when test="$language = 'eng'">
                        <xsl:text>Arrangement of the collection</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>Ordening van de collectie</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </h3>
        </p>
        <xsl:apply-templates select="*[name() != 'head']"/>
   
    </xsl:template>

    <!-- below templates don't match any elements in Brill's finding aids
    <xsl:template match="descgrp/accessrestrict">
        <a name="a11"/>
        <p>
            <b>
                <xsl:choose>
                    <xsl:when test="head">
                        <xsl:apply-templates select="head"/>
                    </xsl:when>

                    <xsl:when test="$language = 'eng'">
                        <xsl:text>Restrictions on access</xsl:text>
                    </xsl:when>

                    <xsl:otherwise>
                        <xsl:text>Openbaarheidsbeperkingen</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </b>
        </p>
        <xsl:apply-templates select="*[name() != 'head']"/>
    </xsl:template>
    
    <xsl:template match="descgrp/otherfindaid">
        <a name="a12"/>
        <p>
            <b>
                <xsl:choose>
                    <xsl:when test="head">
                        <xsl:apply-templates select="head"/>
                    </xsl:when>

                    <xsl:when test="$language = 'eng'">
                        <xsl:text>Collection access</xsl:text>
                    </xsl:when>

                    <xsl:otherwise>
                        <xsl:text>Toegang tot de collectie</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </b>
        </p>
        <xsl:apply-templates select="*[name() != 'head']"/>
    </xsl:template>
    <xsl:template match="descgrp/altformavail">
        <a name="a13"/>
        <p>
            <b>
                <xsl:choose>
                    <xsl:when test="head">
                        <xsl:apply-templates select="head"/>
                    </xsl:when>
                    <xsl:when test="$language = 'eng'">
                        <xsl:text>Alternative form available </xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>Alternatieve informatiedrager</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </b>
        </p>
        <xsl:apply-templates select="*[name() != 'head']"/>
    </xsl:template>

    <xsl:template match="descgrp/userestrict">
        <a name="a14"/>
        <p>
            <b>
                <xsl:choose>
                    <xsl:when test="head">
                        <xsl:apply-templates select="head"/>
                    </xsl:when>
                    <xsl:when test="$language = 'eng'">
                        <xsl:text>Restrictions on use</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>Beperkingen aan het gebruik</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </b>
        </p>
        <xsl:apply-templates select="*[name() != 'head']"/>
    </xsl:template>

    <xsl:template match="descgrp/phystech">
        <a name="a15"/>
        <p>
            <b>
                <xsl:choose>
                    <xsl:when test="head">
                        <xsl:apply-templates select="head"/>
                    </xsl:when>
                    <xsl:when test="$language = 'eng'">
                        <xsl:text>Physical details</xsl:text>
                    </xsl:when>

                    <xsl:otherwise>
                        <xsl:text>Fysieke kenmerken en technische vereisten</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </b>
        </p>
        <xsl:apply-templates select="*[name() != 'head']"/>
    </xsl:template>
    <xsl:template match="descgrp/prefercite">
        <a name="a16"/>
        <p>
            <b>
                <xsl:choose>
                    <xsl:when test="head">
                        <xsl:apply-templates select="head"/>
                    </xsl:when>
                    <xsl:when test="$language = 'eng'">
                        <xsl:text>Preferred citation</xsl:text>
                    </xsl:when>

                    <xsl:otherwise>
                        <xsl:text>Citeerinstructies</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </b>
        </p>
        <xsl:apply-templates select="*[name() != 'head']"/>
    </xsl:template>
    <xsl:template match="descgrp/odd">
        <a name="a21"/>
        <p>
            <b>
                <xsl:choose>
                    <xsl:when test="head">
                        <xsl:apply-templates select="head"/>
                    </xsl:when>

                    <xsl:when test="$language = 'eng'">
                        <xsl:text>Request instructions</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>Aanvraaginstructies</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </b>
        </p>
        <xsl:apply-templates select="*[name() != 'head']"/>
    </xsl:template>
    -->
    <xsl:template match="archdesc/relatedmaterial">
        <a name="ead7"/>
        <p>
            <h3>
                <xsl:choose>
                    <xsl:when test="head">
                        <xsl:apply-templates select="head"/>
                    </xsl:when>

                    <xsl:when test="$language = 'eng'">
                        <xsl:text>Related materials</xsl:text>
                    </xsl:when>

                    <xsl:otherwise>
                        <xsl:text>Verwante collecties</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </h3>
        </p>
        <xsl:apply-templates select="*[name() != 'head']"/>
     
    </xsl:template>
    <!-- haven't seen below element in Bril finding aids, but seems possible -->
    <xsl:template match="archdesc/separatedmaterial">
        <a name="ead18"/>
        <p>
            <h3>
                <xsl:choose>
                    <xsl:when test="head">
                        <xsl:apply-templates select="head"/>
                    </xsl:when>

                    <xsl:when test="$language = 'eng'">
                        <xsl:text>Separated material </xsl:text>
                    </xsl:when>

                    <xsl:otherwise>
                        <xsl:text>Elders ondergebracht materiaal</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </h3>
        </p>
        <xsl:apply-templates select="*[name() != 'head']"/>
    </xsl:template>
    <xsl:template match="archdesc/originalsloc">
        <a name="ead2"/>
        <p>
            <h3>
                <xsl:choose>
                    <xsl:when test="head">
                        <xsl:apply-templates select="head"/>
                    </xsl:when>
                    <xsl:when test="$language = 'eng'">
                        <xsl:text>Location of originals</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>Bewaarplaats van originelen</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </h3>
        </p>
        <xsl:apply-templates select="*[name() != 'head']"/>
    </xsl:template>

    <xsl:template match="controlaccess">
        <p>

            <a name="ead6"/>

            <h3>
                <xsl:choose>
                    <xsl:when test="head">
                        <xsl:apply-templates select="head"/>
                    </xsl:when>
                    <xsl:when test="$language = 'eng'">
                        <xsl:text>Selected Search Terms</xsl:text>
                    </xsl:when>
                </xsl:choose>
            </h3>
            <xsl:value-of select="p"/>
            <xsl:for-each select="controlaccess">
                <h4>
                    <xsl:value-of select="head"/>
                </h4>
                <xsl:apply-templates select="*[name() != 'head']"/>
                <!-- why does it say 'sources' multiple times in the HTML version? -->
            </xsl:for-each>
        </p>

    </xsl:template>

    <xsl:template match="subject">
        <xsl:apply-templates/>
        <xsl:element name="br"> </xsl:element>

    </xsl:template>

    <xsl:template match="geogname">
        <xsl:apply-templates/>
        <xsl:element name="br"> </xsl:element>

    </xsl:template>


    <!-- beginning of my code -->

    <xsl:template match="index">
        <p>
            <a name="ead9"/>

            <h3>
                <xsl:choose>
                    <xsl:when test="head">
                        <xsl:apply-templates select="head"/>
                    </xsl:when>
                    <xsl:when test="$language = 'eng'">
                        <xsl:text>Index</xsl:text>
                    </xsl:when>
                </xsl:choose>
            </h3>
            <xsl:value-of select="p"/>
        </p>
        <xsl:for-each select="index">
            <h4>
                <xsl:value-of select="head"/>
            </h4>
            <ul>
                <xsl:for-each select="indexentry">
                    <li>
                        <xsl:value-of select="*"/>
                        <xsl:value-of select="*"/>
                    </li>
                </xsl:for-each>
            </ul>
        </xsl:for-each>
    </xsl:template>

    <!-- end of my code -->

    <xsl:template match="bibliography">
        <a name="a20"/>

        <!-- 
        <p>
            <b>
                <xsl:choose>
                    <xsl:when test="head">
                        <xsl:apply-templates select="head"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test="$language = 'eng' ">
                                <xsl:text>Literature</xsl:text>
                            </xsl:when>
                            <xsl:when test="$language = 'dut' ">
                                <xsl:text>Literatuur</xsl:text>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
            </b>
        </p> 
        -->
        <xsl:element name="table">

            <xsl:for-each select="*[name() != 'head']">
                <xsl:apply-templates select="."/>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>
    <xsl:template match="bibref">
        <xsl:element name="tr">
            <xsl:element name="td">
                <xsl:attribute name="width">
                    <xsl:text>2%</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="valign">
                    <xsl:text>top</xsl:text>
                </xsl:attribute>
                <xsl:text>- </xsl:text>
            </xsl:element>
            <xsl:element name="td">
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:element>
        
    
    </xsl:template>
    <xsl:template match="lb">
        <br/>
    </xsl:template>

    <xsl:template match="emph">
        <i>
            <xsl:apply-templates/>
        </i>
    </xsl:template>

    <xsl:template match="emph[@render = 'bold']">
        <b>
            <xsl:apply-templates/>
        </b>
    </xsl:template>
    <xsl:template match="emph[@render = 'italic']">
        <i>
            <xsl:apply-templates/>
        </i>
    </xsl:template>
    <xsl:template match="emph[@render = 'underline']">
        <u>
            <xsl:apply-templates/>
        </u>
    </xsl:template>
    <xsl:template match="emph[@render = 'sub']">
        <sub>
            <xsl:apply-templates/>
        </sub>
    </xsl:template>
    <xsl:template match="emph[@render = 'super']">
        <super>
            <xsl:apply-templates/>
        </super>
    </xsl:template>
    <xsl:template match="emph[@render = 'quoted']">
        <xsl:text>"</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>"</xsl:text>
    </xsl:template>
    <xsl:template match="emph[@render = 'boldquoted']">
        <b>
            <xsl:text>"</xsl:text>
            <xsl:apply-templates/>
            <xsl:text>"</xsl:text>
        </b>
    </xsl:template>
    <xsl:template match="emph[@render = 'boldunderline']">
        <b>
            <u>
                <xsl:apply-templates/>
            </u>
        </b>
    </xsl:template>
    <xsl:template match="emph[@render = 'bolditalic']">
        <b>
            <i>
                <xsl:apply-templates/>
            </i>
        </b>
    </xsl:template>
    <xsl:template match="emph[@render = 'boldsmcaps']">
        <font style="font-variant: small-caps">
            <b>
                <xsl:apply-templates/>
            </b>
        </font>
    </xsl:template>
    <xsl:template match="emph[@render = 'smcaps']">
        <font style="font-variant: small-caps">
            <xsl:apply-templates/>
        </font>
    </xsl:template>
    <xsl:template match="title[@render = 'bold']">
        <b>
            <xsl:apply-templates/>
        </b>
    </xsl:template>
    <xsl:template match="title[@render = 'italic']">
        <i>
            <xsl:apply-templates/>
        </i>
    </xsl:template>
    <xsl:template match="title[@render = 'underline']">
        <u>
            <xsl:apply-templates/>
        </u>
    </xsl:template>
    <xsl:template match="title[@render = 'sub']">
        <sub>
            <xsl:apply-templates/>
        </sub>
    </xsl:template>
    <xsl:template match="title[@render = 'super']">
        <super>
            <xsl:apply-templates/>
        </super>
    </xsl:template>
    <xsl:template match="title[@render = 'quoted']">
        <xsl:text>"</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>"</xsl:text>
    </xsl:template>
    <xsl:template match="title[@render = 'boldquoted']">
        <b>
            <xsl:text>"</xsl:text>
            <xsl:apply-templates/>
            <xsl:text>"</xsl:text>
        </b>
    </xsl:template>
    <xsl:template match="title[@render = 'boldunderline']">
        <b>
            <u>
                <xsl:apply-templates/>
            </u>
        </b>
    </xsl:template>
    <xsl:template match="title[@render = 'singlequote']">
        <xsl:text>&apos;</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>&apos;</xsl:text>
    </xsl:template>
    <xsl:template match="title[@render = 'bolditalic']">
        <b>
            <i>
                <xsl:apply-templates/>
            </i>
        </b>
    </xsl:template>
    <xsl:template match="title[@render = 'boldsmcaps']">
        <font style="font-variant: small-caps">
            <b>
                <xsl:apply-templates/>
            </b>
        </font>
    </xsl:template>
    <xsl:template match="title[@render = 'smcaps']">
        <font style="font-variant: small-caps">
            <xsl:apply-templates/>
        </font>
    </xsl:template>
    <xsl:template match="c01">
        <tr>
        
            <td colspan="11" valign="top">
                <xsl:element name="a">
                    <xsl:attribute name="name">
                        <xsl:value-of select="@id"/>
                    </xsl:attribute>
                </xsl:element>
                <xsl:choose>
                    <xsl:when test="@level = 'item' or @level = 'file'">
                        <xsl:call-template name="item"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="series"/>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
            <td colspan="1" align="right" valign="top">
                <br/>


                    <xsl:element name="a">
                        <xsl:attribute name="href">
                            <xsl:text>#ead0</xsl:text>
                        </xsl:attribute>
                  <xsl:value-of select="$top"/>
                    </xsl:element>

                


            </td>
        </tr>
        <xsl:apply-templates select="c02"/>
    </xsl:template>
    <xsl:template match="c02">
        <tr>
            <td/>
            <td colspan="11" valign="top">
                <xsl:element name="a">
                    <xsl:attribute name="name">
                        <xsl:value-of select="@id"/>
                    </xsl:attribute>
                </xsl:element>
                <xsl:choose>
                    <xsl:when test="@level = 'item' or @level = 'file'">
                        <xsl:call-template name="item"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="series"/>
                    </xsl:otherwise>
                </xsl:choose>
            </td>

        </tr>
        <xsl:apply-templates select="c03"/>
    </xsl:template>

    <xsl:template match="c03">
        <tr>
            <td/>
            <td/>
            <td colspan="10" valign="top">
                <xsl:choose>
                    <xsl:when test="@level = 'item' or @level = 'file'">
                        <xsl:call-template name="item"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="series"/>
                    </xsl:otherwise>
                </xsl:choose>
            </td>

        </tr>
        <xsl:apply-templates select="c04"/>
    </xsl:template>

    <xsl:template match="c04">
        <tr>
            <td/>
            <td/>
            <td/>
            <td colspan="9" valign="top">
                <xsl:choose>
                    <xsl:when test="@level = 'item' or @level = 'file'">
                        <xsl:call-template name="item"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="series"/>
                    </xsl:otherwise>
                </xsl:choose>
            </td>

        </tr>
        <xsl:apply-templates select="c05"/>
    </xsl:template>
    <xsl:template match="c05">
        <tr>
            <td/>
            <td/>
            <td/>
            <td/>
            <td colspan="8" valign="top">
                <xsl:choose>
                    <xsl:when test="@level = 'item' or @level = 'file'">
                        <xsl:call-template name="item"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="series"/>
                    </xsl:otherwise>
                </xsl:choose>
            </td>

        </tr>
        <xsl:apply-templates select="c06"/>
    </xsl:template>
    <xsl:template match="c06">
        <tr>
            <td/>
            <td/>
            <td/>
            <td/>
            <td/>
            <td colspan="7" valign="top">
                <xsl:choose>
                    <xsl:when test="@level = 'item' or @level = 'file'">
                        <xsl:call-template name="item"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="series"/>
                    </xsl:otherwise>
                </xsl:choose>
            </td>

        </tr>
        <xsl:apply-templates select="c07"/>
    </xsl:template>
    <xsl:template match="c07">
        <tr>
            <td/>
            <td/>
            <td/>
            <td/>
            <td/>
            <td/>
            <td colspan="6" valign="top">
                <xsl:choose>
                    <xsl:when test="@level = 'item' or @level = 'file'">
                        <xsl:call-template name="item"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="series"/>
                    </xsl:otherwise>
                </xsl:choose>
            </td>

        </tr>
        <xsl:apply-templates select="c08"/>
    </xsl:template>
    <xsl:template match="c08">
        <tr>
            <td/>
            <td/>
            <td/>
            <td/>
            <td/>
            <td/>
            <td/>
            <td colspan="5" valign="top">
                <xsl:choose>
                    <xsl:when test="@level = 'item' or @level = 'file'">
                        <xsl:call-template name="item"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="series"/>
                    </xsl:otherwise>
                </xsl:choose>
            </td>

        </tr>
        <xsl:apply-templates select="c09"/>
    </xsl:template>
    <xsl:template match="c09">
        <tr>
            <td/>
            <td/>
            <td/>
            <td/>
            <td/>
            <td/>
            <td/>
            <td/>
            <td colspan="4" valign="top">
                <xsl:choose>
                    <xsl:when test="@level = 'item' or @level = 'file'">
                        <xsl:call-template name="item"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="series"/>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
            <td colspan="4" align="right" valign="top">
                <xsl:apply-templates select="did/container[string-length(.) != 0]"/>
            </td>
        </tr>
        <xsl:apply-templates select="c10"/>
    </xsl:template>
    <xsl:template match="c10">
        <tr>
            <td/>
            <td/>
            <td/>
            <td/>
            <td/>
            <td/>
            <td/>
            <td/>
            <td/>
            <td colspan="3" valign="top">
                <xsl:choose>
                    <xsl:when test="@level = 'item' or @level = 'file'">
                        <xsl:call-template name="item"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="series"/>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
            <td colspan="4" align="right" valign="top">
                <xsl:apply-templates select="did/container[string-length(.) != 0]"/>
            </td>
        </tr>
        <xsl:apply-templates select="c11"/>
    </xsl:template>
    <xsl:template match="c11">
        <tr>
            <td/>
            <td/>
            <td/>
            <td/>
            <td/>
            <td/>
            <td/>
            <td/>
            <td/>
            <td/>
            <td colspan="2" valign="top">
                <xsl:choose>
                    <xsl:when test="@level = 'item' or @level = 'file'">
                        <xsl:call-template name="item"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="series"/>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
            <td colspan="4" align="right" valign="top">
                <xsl:apply-templates select="did/container[string-length(.) != 0]"/>
            </td>
        </tr>
        <xsl:apply-templates select="c12"/>
    </xsl:template>
    <xsl:template match="c12">
        <tr>
            <td/>
            <td/>
            <td/>
            <td/>
            <td/>
            <td/>
            <td/>
            <td/>
            <td/>
            <td/>
            <td/>
            <td valign="top">
                <xsl:choose>
                    <xsl:when test="@level = 'item' or @level = 'file'">
                        <xsl:call-template name="item"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="series"/>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
            <td colspan="4" align="right" valign="top">
                <xsl:apply-templates select="did/container[string-length(.) != 0]"/>
            </td>
        </tr>
    </xsl:template>
    <xsl:template match="dao">

        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:value-of select="@href"/>
            </xsl:attribute>
            <xsl:text>View image</xsl:text>
        </xsl:element>
        <p/>
    </xsl:template>


    <xsl:template match="daogrp">
        <xsl:choose>
            <xsl:when test="daoloc[@label = 'thumbnail']">
                <xsl:element name="td">
                    <xsl:attribute name="width">
                        <xsl:text>20%</xsl:text>
                    </xsl:attribute>

                    <xsl:attribute name="valign">
                        <xsl:text>top</xsl:text>
                    </xsl:attribute>

                    <xsl:element name="a">
                        <xsl:attribute name="href">
                            <xsl:value-of select="daoloc[@label = 'reference']/@href"/>
                        </xsl:attribute>

                        <xsl:attribute name="target">
                            <xsl:text>_blank</xsl:text>
                        </xsl:attribute>

                        <xsl:if test="daoloc[@label = 'thumbnail']">
                            <xsl:element name="img">
                                <xsl:attribute name="src">
                                    <xsl:value-of select="daoloc[@label = 'thumbnail']/@href"/>
                                </xsl:attribute>
                                <xsl:attribute name="width">
                                    <xsl:text>75</xsl:text>
                                </xsl:attribute>
                                <xsl:attribute name="border">
                                    <xsl:text>0</xsl:text>
                                </xsl:attribute>
                            </xsl:element>
                        </xsl:if>
                    </xsl:element>
                </xsl:element>
            </xsl:when>
        </xsl:choose>
    </xsl:template>




    <xsl:template name="item">
    

             

<xsl:element name="div">
    <xsl:attribute name="class">
        <xsl:text>dsc-item</xsl:text>
    </xsl:attribute>
    

                <xsl:apply-templates select="did/daogrp"/>
          


                    <xsl:for-each select="@id">
                        <a>
                            <xsl:attribute name="name">
                                <xsl:value-of select="."/>
                            </xsl:attribute>
                        </a>
                    </xsl:for-each>


                    <xsl:for-each select="did">
                        <xsl:if test="unitid[@type != 'PPN']">
                            <xsl:for-each select="unitid">
                                <xsl:choose>
                                    <xsl:when test="@label">
                                        <i>
                                            <b>
                                                <xsl:value-of select="@label"/>
                                            </b>
                                        </i>
                                    </xsl:when>

                                    <xsl:otherwise>
                                        <xsl:if test="@type = 'signatuur'">
                                            <i>
                                                <b>
                                                  <xsl:choose>
                                                  <xsl:when test="$language = 'eng'">
                                                  <xsl:text>Shelfmark: </xsl:text>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:text>Signatuur: </xsl:text>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </b>
                                            </i>
                                        </xsl:if>
                                    </xsl:otherwise>
                                </xsl:choose>



                            </xsl:for-each>



                        </xsl:if>

                        <xsl:choose>
                            <xsl:when test="daogrp/daoloc[@label = 'reference']">

                                <a>
                                    <xsl:attribute name="href">
                                        <xsl:value-of
                                            select="daogrp/daoloc[@label = 'reference']/@href"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="name">
                                        <xsl:value-of select="./@id"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="target">
                                        <xsl:text>_blank</xsl:text>
                                    </xsl:attribute>
                                    <xsl:value-of select="unitid"/>
                                </a>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="unitid"/>
                            </xsl:otherwise>
                        </xsl:choose>
                        <br/>

                        <xsl:if test="unittitle">
                            <xsl:for-each select="unittitle">
                                <xsl:choose>
                                    <xsl:when test="@label">
                                        <i>
                                            <b>
                                                <xsl:value-of select="@label"/>
                                            </b>
                                        </i>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <i>
                                            <b>
                                                <xsl:choose>
                                                  <xsl:when test="$language = 'eng'">
                                                  <xsl:text>Contents: </xsl:text>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:text>Inhoud: </xsl:text>
                                                  </xsl:otherwise>
                                                </xsl:choose>
                                            </b>
                                        </i>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <xsl:apply-templates/>
                                <br/>
                            </xsl:for-each>
                        </xsl:if>



                        <xsl:if test="abstract">
                            <xsl:for-each select="abstract">
                                <xsl:choose>
                                    <xsl:when test="@label">
                                        <i>
                                            <b>
                                                <xsl:value-of select="@label"/>
                                            </b>
                                        </i>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <i>
                                            <b>
                                                <xsl:choose>
                                                  <xsl:when test="$language = 'eng'">
                                                  <xsl:text>Abstract: </xsl:text>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:text>Samenvatting: </xsl:text>
                                                  </xsl:otherwise>
                                                </xsl:choose>
                                            </b>
                                        </i>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <xsl:apply-templates/>
                                <br/>
                            </xsl:for-each>
                        </xsl:if>

                        <xsl:if test="origination">
                            <xsl:for-each select="origination">
                                <xsl:choose>
                                    <xsl:when test="@label">
                                        <i>
                                            <b>
                                                <xsl:value-of select="@label"/>
                                            </b>
                                        </i>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:choose>
                                            <xsl:when test="$language = 'eng'">
                                                <xsl:text>Provenance: </xsl:text>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:text>Herkomst: </xsl:text>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <xsl:apply-templates/>
                                <br/>
                            </xsl:for-each>
                        </xsl:if>
                        <xsl:if test="unitdate">
                            <xsl:for-each select="unitdate">
                                <xsl:choose>
                                    <xsl:when test="@label">
                                        <i>
                                            <b>
                                                <xsl:value-of select="@label"/>
                                            </b>
                                        </i>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <i>
                                            <b>
                                                <xsl:choose>
                                                  <xsl:when test="$language = 'eng'">
                                                  <xsl:text>Dates: </xsl:text>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:text>Datering: </xsl:text>
                                                  </xsl:otherwise>
                                                </xsl:choose>
                                            </b>
                                        </i>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <xsl:apply-templates/>
                                <br/>
                            </xsl:for-each>
                        </xsl:if>
                        <xsl:if test="physdesc">
                            <xsl:for-each select="physdesc">
                                <xsl:choose>
                                    <xsl:when test="@label">
                                        <i>
                                            <b>
                                                <xsl:value-of select="@label"/>
                                            </b>
                                        </i>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <i>
                                            <b>
                                                <xsl:choose>
                                                  <xsl:when test="$language = 'eng'">
                                                  <xsl:text>Form: </xsl:text>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:text>Vorm: </xsl:text>
                                                  </xsl:otherwise>
                                                </xsl:choose>
                                            </b>
                                        </i>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <xsl:apply-templates/>
                                <br/>
                            </xsl:for-each>
                        </xsl:if>
                        <xsl:if test="langmaterial">
                            <xsl:for-each select="langmaterial">
                                <xsl:choose>
                                    <xsl:when test="@label">
                                        <i>
                                            <b>
                                                <xsl:value-of select="@label"/>
                                            </b>
                                        </i>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <i>
                                            <b>
                                                <xsl:choose>
                                                  <xsl:when test="$language = 'eng'">
                                                  <xsl:text>Language: </xsl:text>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:text>Taal: </xsl:text>
                                                  </xsl:otherwise>
                                                </xsl:choose>
                                            </b>
                                        </i>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <xsl:apply-templates/>
                                <br/>
                            </xsl:for-each>
                        </xsl:if>

                        <xsl:if test="container">
                            <xsl:for-each select="container">
                                <xsl:choose>
                                    <xsl:when test="@label">
                                        <i>
                                            <b>
                                                <xsl:value-of select="@label"/>
                                            </b>
                                        </i>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <i>
                                            <b>

                                                <xsl:text>Microfiche number: </xsl:text>

                                            </b>
                                        </i>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <xsl:apply-templates/>
                                <br/>
                            </xsl:for-each>
                        </xsl:if>

                       
                    </xsl:for-each>
    
    <xsl:if test="note">
        
    
        <xsl:for-each select="note">
            <i>
                <b>
                    <xsl:choose>
                        <xsl:when test="@label">
                            
                            <xsl:value-of select="@label"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>Annotation: </xsl:text>
                            
                        </xsl:otherwise>
                    </xsl:choose>
                </b></i>
            
            <xsl:apply-templates />
            <br/>
        </xsl:for-each>
    </xsl:if>
                    
                    <xsl:if test="bioghist">
                        <xsl:for-each select="bioghist">
                            <xsl:choose>
                                <xsl:when test="head">
                                    <i>
                                        <b>
                                            <xsl:value-of select="head"/>
                                        </b>
                                    </i>
                                </xsl:when>
                                <xsl:otherwise>
                                    <i>
                                        <b>
                                            <xsl:choose>
                                                <xsl:when test="$language = 'eng'">
                                                  <xsl:text>Historical context: </xsl:text>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                  <xsl:text>Historische context: </xsl:text>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </b>
                                    </i>
                                </xsl:otherwise>
                            </xsl:choose>
                            <br/>
                            <xsl:for-each select="*[name() != 'head']">
                                <xsl:apply-templates select="."/>
                            </xsl:for-each>
                        </xsl:for-each>
                    </xsl:if>
                    <xsl:if test="scopecontent">
                        <xsl:for-each select="scopecontent">


                            <i>
                                <b>

                                    <xsl:choose>
                                        <xsl:when test="head">
                                            <xsl:value-of select="head"/>
                                            <xsl:if test="string-length(head) &gt; 0">
                                                <xsl:element name="br"/>
                                            </xsl:if>
                                        </xsl:when>
                                        <xsl:when test="$language = 'eng'">
                                            <xsl:text>Specification contents: </xsl:text>
                                            <xsl:element name="br"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text>Specificatie inhoud: </xsl:text>
                                            <xsl:element name="br"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </b>
                            </i>

                            <xsl:for-each select="*[name() != 'head']">
                                <xsl:apply-templates select="."/>
                                <br/>
                            </xsl:for-each>
                        </xsl:for-each>
                    </xsl:if>
                    <xsl:if test="custodhist">
                        <xsl:for-each select="custodhist">
                            <xsl:choose>
                                <xsl:when test="head">
                                    <i>
                                        <b>
                                            <xsl:value-of select="head"/>
                                        </b>
                                    </i>
                                </xsl:when>
                                <xsl:otherwise>
                                    <i>
                                        <b>
                                            <xsl:choose>
                                                <xsl:when test="$language = 'eng'">
                                                  <xsl:text>Custodial history: </xsl:text>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                  <xsl:text>Herkomstgeschiedenis: </xsl:text>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </b>
                                    </i>
                                </xsl:otherwise>
                            </xsl:choose>
                            <br/>
                            <xsl:for-each select="*[name() != 'head']">
                                <xsl:apply-templates select="."/>
                                <br/>
                            </xsl:for-each>
                        </xsl:for-each>
                    </xsl:if>
                    <xsl:if test="bibliography">
                        <xsl:for-each select="bibliography">
                            <xsl:choose>
                                <xsl:when test="head">
                                    <i>
                                        <b>
                                            <xsl:value-of select="head"/>
                                        </b>
                                    </i>
                                </xsl:when>
                                <xsl:otherwise>
                                    <i>
                                        <b>
                                            <xsl:choose>
                                                <xsl:when test="$language = 'eng'">
                                                  <xsl:text>Literature: </xsl:text>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                  <xsl:text>Literatuur: </xsl:text>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </b>
                                    </i>
                                </xsl:otherwise>
                            </xsl:choose>
                            <br/>
                            <xsl:element name="table">
                                <xsl:attribute name="width">
                                    <xsl:text>100%</xsl:text>

                                </xsl:attribute>


                                <xsl:for-each select="*[name() != 'head']">
                                    <xsl:apply-templates select="."/>
                                </xsl:for-each>
                            </xsl:element>
                        </xsl:for-each>
                    </xsl:if>
                    <xsl:apply-templates select="did/dao"/>

      
</xsl:element>
    </xsl:template>


    <xsl:template name="series">
        <xsl:if test="@id">
            <a>
                <xsl:attribute name="name">
                    <xsl:value-of select="@id"/>
                </xsl:attribute>
            </a>
        </xsl:if>
        <xsl:variable name="name">
            <xsl:value-of select="name()"/>
        </xsl:variable>
        <xsl:for-each select="did">
            <xsl:choose>
                <xsl:when test="$name = 'c01'">

                    <br/>
                    <h3>
                        <xsl:if test="unitid">
                            <xsl:apply-templates select="unitid"/>
                            <xsl:text>&#160;&#160;&#160;&#160;&#160;&#160;</xsl:text>
                        </xsl:if>
                        <xsl:apply-templates select="unittitle"/>
                    </h3>
                </xsl:when>
                <xsl:otherwise>
                    <p>
                        <b>
                            <xsl:if test="unitid">
                                <xsl:apply-templates select="unitid"/>
                                <xsl:text>&#160;&#160;&#160;&#160;&#160;&#160;</xsl:text>
                            </xsl:if>
                            <xsl:apply-templates select="unittitle"/>
                        </b>
                    </p>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>

        <xsl:choose>
            <xsl:when test="did/daogrp">

                <xsl:element name="table">

                    <xsl:element name="tr">
                        <xsl:element name="td">
                            <xsl:attribute name="width">
                                <xsl:text>21%</xsl:text>
                            </xsl:attribute>
                            <xsl:attribute name="valign">
                                <xsl:text>top</xsl:text>
                            </xsl:attribute>

                            <xsl:element name="br"/>
                            <xsl:element name="a">
                                <xsl:attribute name="href">
                                    <xsl:value-of
                                        select="did/daogrp/daoloc[@label = 'reference']/@href"/>
                                </xsl:attribute>

                                <xsl:attribute name="target">
                                    <xsl:text>_blank</xsl:text>
                                </xsl:attribute>

                                <xsl:if test="did/daogrp/daoloc[@label = 'thumbnail']">
                                    <xsl:element name="img">
                                        <xsl:attribute name="src">
                                            <xsl:value-of
                                                select="did/daogrp/daoloc[@label = 'thumbnail']/@href"
                                            />
                                        </xsl:attribute>
                                        <xsl:attribute name="width">
                                            <xsl:text>75</xsl:text>
                                        </xsl:attribute>
                                        <xsl:attribute name="border">
                                            <xsl:text>0</xsl:text>
                                        </xsl:attribute>
                                    </xsl:element>
                                </xsl:if>
                            </xsl:element>





                        </xsl:element>
                        <xsl:element name="td">

                            <xsl:call-template name="series-contents"/>
                        </xsl:element>

                    </xsl:element>

                </xsl:element>




            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="series-contents"/>

            </xsl:otherwise>

        </xsl:choose>


    </xsl:template>


    <xsl:template match="p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template name="series-contents">

        <xsl:for-each select="did">
            <xsl:if test="origination">
                <xsl:for-each select="origination">
                    <b>
                        <i>
                            <xsl:choose>
                                <xsl:when test="@label">
                                    <i>
                                        <b>
                                            <xsl:value-of select="@label"/>
                                        </b>
                                    </i>
                                </xsl:when>
                                <xsl:otherwise>

                                    <xsl:text>Provenance: </xsl:text>

                                </xsl:otherwise>
                            </xsl:choose>
                            <br/>
                        </i>
                    </b>
                    <xsl:apply-templates/>
                </xsl:for-each>
            </xsl:if>

            <xsl:if test="abstract">
                <xsl:for-each select="abstract">
                    <b>
                        <i>
                            <xsl:choose>
                                <xsl:when test="@label">
                                    <xsl:value-of select="@label"/>
                                </xsl:when>

                                <xsl:when test="$language = 'eng'">
                                    <xsl:text>Abstract: </xsl:text>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:text>Samenvatting </xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>
                        </i>
                    </b>
                    <xsl:apply-templates/>
                    <xsl:element name="br"/>
                </xsl:for-each>
            </xsl:if>

            <xsl:if test="unitdate">
                <xsl:for-each select="unitdate">
                    <i>
                        <b>
                            <xsl:choose>
                                <xsl:when test="@label">
                                    <xsl:value-of select="@label"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:text>Datering: </xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>
                        </b>
                    </i>
                    <xsl:apply-templates select="."/>
                    <br/>
                </xsl:for-each>
            </xsl:if>
            <xsl:if test="note">
                <xsl:for-each select="note">
                    <i>
                        <b>
                            <xsl:choose>
                                <xsl:when test="@label">
                                    <xsl:value-of select="@label"/>
                                </xsl:when>
                                <xsl:when test="$language = 'eng'">
                                    <xsl:text>Note: </xsl:text>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:text>Annotatie: </xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>
                        </b>
                    </i>
                    <xsl:for-each select="*">
                        <xsl:apply-templates select="."/>
                        <br/>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:if>
            <xsl:if test="physdesc">
                <xsl:for-each select="physdesc">
                    <i>
                        <b>
                            <xsl:choose>
                                <xsl:when test="@label">
                                    <xsl:value-of select="@label"/>
                                </xsl:when>
                                <xsl:when test="$language = 'eng'">
                                    <xsl:text>Form: </xsl:text>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:text>Vorm: </xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>
                        </b>
                    </i>
                    <xsl:apply-templates select="."/>
                    <br/>
                </xsl:for-each>
            </xsl:if>
            <xsl:if test="dao">
                <xsl:element name="div">
                    <xsl:attribute name="id">
                        <xsl:text>dsc</xsl:text>
                    </xsl:attribute>
                </xsl:element>
            </xsl:if>
        </xsl:for-each>
        <xsl:if test="scopecontent">
            <xsl:for-each select="scopecontent">
                <i>
                    <b>
                        <xsl:choose>
                            <xsl:when test="head">
                                <xsl:value-of select="head"/>
                                <xsl:if test="string-length(head) &gt; 1">
                                    <xsl:element name="br"/>
                                </xsl:if>

                            </xsl:when>
                            <xsl:when test="$language = 'eng'">
                                <xsl:text>Specification contents: </xsl:text>
                                <br/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>Specificatie inhoud: </xsl:text>
                                <br/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </b>
                </i>

                <xsl:for-each select="*[name() != 'head']">
                    <xsl:apply-templates select="."/>
                    <br/>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:if>
        <xsl:if test="bioghist">
            <xsl:for-each select="bioghist">
                <xsl:choose>
                    <xsl:when test="head">
                        <i>
                            <b>
                                <xsl:value-of select="head"/>
                            </b>
                        </i>
                    </xsl:when>
                    <xsl:otherwise>
                        <i>
                            <b>Historische context: </b>
                        </i>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:for-each select="*[name() != 'head']">
                    <xsl:apply-templates select="."/>
                    <br/>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:if>
        <xsl:if test="custodhist">
            <xsl:for-each select="custodhist">
                <xsl:choose>
                    <xsl:when test="head">
                        <i>
                            <b>
                                <xsl:value-of select="head"/>
                            </b>
                        </i>
                    </xsl:when>
                    <xsl:otherwise>
                        <i>
                            <b>Herkomstgeschiedenis: </b>
                        </i>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:for-each select="*[name() != 'head']">
                    <xsl:apply-templates select="."/>
                    <br/>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:if>
        <xsl:if test="bibliography">
            <xsl:for-each select="bibliography">
                <xsl:choose>
                    <xsl:when test="head">
                        <i>
                            <b>
                                <xsl:value-of select="head"/>
                            </b>
                        </i>
                    </xsl:when>
                    <xsl:otherwise>
                        <i>
                            <b>Literatuur: </b>
                        </i>
                    </xsl:otherwise>
                </xsl:choose>

                <xsl:element name="table">
                    <xsl:attribute name="width">
                        <xsl:text>100%</xsl:text>

                    </xsl:attribute>


                    <xsl:for-each select="*[name() != 'head']">
                        <xsl:apply-templates select="."/>
                    </xsl:for-each>
                </xsl:element>


            </xsl:for-each>
        </xsl:if>

    </xsl:template>


</xsl:stylesheet>
