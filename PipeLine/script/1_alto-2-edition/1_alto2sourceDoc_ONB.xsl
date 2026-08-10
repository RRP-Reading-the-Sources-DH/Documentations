<?xml version="1.0" encoding="UTF-8"?>

<!-- Source XSL : Simon Gabay ; adaptation : Sonia Solfrini -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.loc.gov/standards/alto/ns-v4#" version="2.0"
    exclude-result-prefixes="xs">
    <xsl:output encoding="UTF-8" method="xml" indent="yes"
        xpath-default-namespace="http://www.tei-c.org/release/xml/tei/custom/schema/relaxng/tei_all.rng"/>
    <xsl:strip-space elements="*"/>
    
    <!-- Changer les variables suivantes si nécessaire -->
    
 
    
    <!-- Changer les variables suivantes si nécessaire -->
    <!-- Les variables permettent de reconstituer l'url des documents -->
    
    <!-- for e-rara   -->
    <!--
    <xsl:variable name="document">Hyperius_1-Tim_C1-6</xsl:variable>
    <xsl:variable name="folderName">doc_1</xsl:variable>
    <xsl:variable name="iiif-domain">iiif:</xsl:variable>
    <xsl:variable name="serveur">https://www.e-rara.ch/</xsl:variable>
    <xsl:variable name="iiif-name">i3f/v20/</xsl:variable>
    <xsl:variable name="endfile">/full/0/default.jpg</xsl:variable>-->
   
    
    <!--for mdz-->  
    <!--
    <xsl:variable name="document">Calvin_Rom_C1-16</xsl:variable>
    <xsl:variable name="folderName">doc_1</xsl:variable>
    <xsl:variable name="iiif-domain">iiif:</xsl:variable>
    <xsl:variable name="serveur">https://api.digitale-sammlungen.de/iiif/</xsl:variable>
    <xsl:variable name="iiif-name">image/v2/</xsl:variable>
    <xsl:variable name="endfile">/full/0/default.jpg</xsl:variable>-->
    
    <!-- for ONB -->
    
    <xsl:variable name="document">Bugenhagen_Rom_C1-16</xsl:variable>
    <xsl:variable name="folderName">doc_1</xsl:variable>
    <xsl:variable name="iiif-domain">iiif:</xsl:variable>
    <xsl:variable name="serveur">https://api.onb.ac.at/</xsl:variable>
    <xsl:variable name="iiif-name">iiif/image/v3/</xsl:variable>
    <xsl:variable name="endfile">/full/0/default.jpg</xsl:variable>
    
    
    <!-- Changer le "path" si nécessaire : '/Users/sonia/Desktop/SETAF_ALTO2TEI/pipeline/data_alto/' -->
           
        <!--<xsl:variable name="xmlDocuments" select="collection(concat('/Users/sonia/Desktop/SETAF_ALTO2TEI/pipeline/data_alto/', $folderName, '/?select=?*.xml;recurse=yes'))"/>-->
    <xsl:variable name="xmlDocuments" select="collection(concat('file:/home/floriane/Documents/16thExegesisDH/PipeLine/data/', $folderName, '/?select=?*.xml;recurse=yes'))"/>
        
        
        
        <xsl:template match="/" >
            <xsl:processing-instruction name="xml-model">
                <xsl:text>href="file:/home/floriane/Documents/16thExegesisDH/PipeLineThm/schema/out/odd-exegesis.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0</xsl:text>
            </xsl:processing-instruction>
            <?xml-model href="file:/home/floriane/Documents/16thExegesisDH/PipeLineThm/schema/out/odd-exegesis.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"?>
            <xsl:processing-instruction name="xml-model">
            <xsl:text>href="https://raw.githubusercontent.com/16thExegesisDH/PipeLineThm/refs/heads/main/schema/out/odd-exegesis.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"</xsl:text>
            <!--<xsl:text>href="https://raw.githubusercontent.com/SETAFDH/TEI-SETAF/main/schema/odd-setaf.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"</xsl:text>-->
        </xsl:processing-instruction>
            <xsl:processing-instruction name="xml-model">
            <xsl:text>href="https://raw.githubusercontent.com/16thExegesisDH/PipeLineThm/refs/heads/main/schema/out/odd-exegesis.rng" type="application/xml" schematypens="http://purl.oclc.org/dsdl/schematron" </xsl:text>
            <!--<xsl:text>href="https://raw.githubusercontent.com/SETAFDH/TEI-SETAF/main/schema/odd-setaf.rng" type="application/xml" schematypens="http://purl.oclc.org/dsdl/schematron"</xsl:text>-->
        </xsl:processing-instruction>
        
     
        
        <TEI xmlns="http://www.tei-c.org/ns/1.0" xml:id="{$document}">
        
<!-- teiHeader -->

            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <title>In priorem ad Timotheum epistolam annotationes.Johannes, Bugenhagen. Basel: [Petri Adam], 1524.</title>
                        <respStmt>
                            <resp>FNS Paul exegesis projet.</resp>
                            <persName xml:id="UZ">
                                <forename>Ueli</forename>
                                <surname>Zahnd</surname>
                                <ptr type="orcid" target="0000-0002-6129-1687"/>
                            </persName>
                        </respStmt>
                        <respStmt>
                            <resp>Modelling and document engineering, segmentation and correction of OCR transcription, conversion to TEI, metadata encoding.</resp>
                            <persName xml:id="FG">
                                <forename>Floriane</forename>
                                <surname>Goy</surname>
                                <ptr type="orcid" target="0009-0005-9944-035X"/>
                            </persName>
                        </respStmt>
                        <respStmt>
                            <resp>correction of OCR transcription, conversion to TEI, metadata encoding.</resp>
                            <persName xml:id="BD">
                                <forename>Béatrice</forename>
                                <surname>Dupuis</surname>
                                <ptr type="orcid" target="none"/>
                            </persName>
                        </respStmt>
                    </titleStmt>
                    <extent>
                        <measure unit="total_images_book" n="314"/>
                        <measure unit="total_images_commentary" n="45"/>
                        <measure unit="processed_images_commentary" n="45"/>
                    </extent>
                    <publicationStmt>
                        <publisher>16th Century Exegesis of Paul</publisher>
                        <authority>Institut d'Histoire de la Réformation (IHR), université de Genève</authority>
                        <address>
                            <addrLine>22 boulevard des Philosophes</addrLine>
                            <addrLine>CH-1211 Genève</addrLine>
                        </address>
                        <authority>Theologisches Fakultät, universität Zürich</authority>
                        <address>
                            <addrLine>Kirchgasse 9</addrLine>
                            <addrLine>8001 Zürich</addrLine>
                        </address>
                        <availability>
                            <licence target=" http://rightsstatements.org/vocab/NoC-NC/1.0/"/>
                            <p>Images : Non-commercial use only (MDZ)</p>
                            <licence target="https://creativecommons.org/licenses/by-nc-sa/4.0/"/>
                            <p>Édition : CC BY-NC-SA </p>
                        </availability>
                        <date when="2026-04-29"/>
                    </publicationStmt>
                    <sourceDesc>
                        <msDesc>
                            <msIdentifier xml:id="BSB_Res_Exeg.309_Beibd.3">
                                <country>Deutschland</country>
                                <settlement>München</settlement>
                                <institution>Bayerische Staatsbibliothek</institution>
                                <idno type="shelfmark">Res/Exeg. 309 b#Beibd.3</idno>
                            </msIdentifier>
                            <msContents>
                                <p>
                                    <biblStruct>
                                        <monogr>
                                            <author>
                                                <persName ref="isni:0000000109036374" nymRef="192">
                                                    <surname>Johannes</surname>
                                                    <forename>Bugenhagen</forename>
                                                </persName>
                                            </author>
                                            <title type="book_title">Bugenhagen, Johannes: Annotationes in decem epistolas Pauli scilicet ad [...] Timotheum primam &amp; secundam</title>
                                            <title type="commentary_title">In priorem ad Timotheum epistolam annotationes.</title>
                                            <imprint>
                                                <pubPlace cert="medium" ref="geonames:7285161">Basel</pubPlace>
                                                <respStmt>
                                                    <resp>Imprimeur</resp>
                                                    <persName role="presumed_printer" ref="isni:0000000116244569">
                                                        <surname>Adam</surname>
                                                        <forename>Petri</forename>
                                                    </persName>
                                                    <note><ref target="https://hls-dhs-dss.ch/de/articles/021524/2010-06-03/"></ref>Historische Lexikon der Schweiz (HLS)</note> 
                                                </respStmt>
                                                <date cert="high">1524</date>
                                            </imprint>
                                        </monogr>
                                    </biblStruct>
                                </p>
                            </msContents>
                            <physDesc>
                                <objectDesc>
                                    <supportDesc>
                                        <support>
                                            <dim>In-8°</dim>
                                        </support>
                                    </supportDesc>
                                </objectDesc>
                            </physDesc>
                            <additional>
                                <surrogates>
                                    <bibl>
                                        <ref target="https://mdz-nbn-resolving.de/details:bsb00027764"/>
                                        <ptr target="https://api.digitale-sammlungen.de/iiif/presentation/v2/bsb00027764/manifest"/>
                                        <relatedItem type="original">
                                            <ref target="#BSB_Res_Exeg.309_Beibd.3">MDZ</ref>
                                        </relatedItem>
                                    </bibl>
                                </surrogates>
                                <listBibl>
                                    <bibl>
                                        <ref target=" https://d-nb.info/gnd/118517287">
                                            <orgName>GND</orgName>
                                            <idno>118517287</idno>
                                        </ref>
                                    </bibl>
                                    <bibl>
                                        <ref target="https://ihr-num.unige.ch/rrp/X454">
                                            <orgName>RRP</orgName>
                                            <idno>X454</idno>
                                        </ref>
                                    </bibl>
                                </listBibl>
                            </additional>
                        </msDesc>
                    </sourceDesc>
                </fileDesc>
                <encodingDesc>
                    <projectDesc>
                        <p>This digital corpus is part of the 16th Century Exegesis of Paul project <ref target="https://www.unige.ch/ihr/fr/recherche/projets/exegese-paulinienne/"/>, directed by Prof-Ueli Zahnd (IHR) and funded by the SNSF <ref target="https://data.snf.ch/grants/grant/207696"></ref>.</p>
                    </projectDesc>
                    <editorialDecl>
                        <correction>
                            <p>The segmentation was corrected manually, and the OCR transcription was fully or partially corrected depending on the dataset.</p>
                        </correction>
                        <normalization>
                            <p>For regularisation purposes, this transcription has been standardised using a Python script.</p>
                        </normalization>
                    </editorialDecl>
                    <appInfo>
                        <application ident="Kraken" version="5.3.0">
                            <label>Kraken</label>
                            <ptr target="https://github.com/mittagessen/kraken"/>
                        </application>
                    </appInfo>
                    <appInfo>
                        <application ident="FoNDUE" version="0.1">
                            <label>FoNDUE</label>
                            <ptr target="https://fondue.unige.ch/"/>
                        </application>
                    </appInfo>
                    <classDecl>
                        <taxonomy xml:id="SegmOnto">
                            <bibl>
                                <title>SegmOnto</title>
                                <ptr target="https://segmonto.github.io/"/>
                            </bibl>
                            <category xml:id="SegmOntoZones"/>
                            <category xml:id="SegmOntoLines"/>
                        </taxonomy>
                    </classDecl>
                </encodingDesc>
                <profileDesc>
                    <langUsage>
                        <language ident="lat">Latin : 16th century</language>
                    </langUsage>
                    <textClass>
                        <keywords>
                            <term type="form">theological commentaries</term>
                            <term type="segmentation_quality">gold</term>
                            <term type="transcription_quality">gold</term>
                            <term type="intermediary_reg_quality">not applicable</term>
                            <term type="normalized_reg_quality">normalize with a python script<ref target="https://github.com/16thExegesisDH/PipeLineThm/tree/main/PYTHON/normalisation"></ref></term>
                        </keywords>
                    </textClass>
                </profileDesc>
                <revisionDesc>
                    <change when="2026-04-30" who="#FG">Création du fichier TEI P5.</change>
                </revisionDesc>
            </teiHeader>
 
<!-- sourceDoc -->

            <sourceDoc xml:id="transcription">
                <xsl:for-each select="$xmlDocuments">
                    <!-- Tri par numéro de page absolu (3e segment du nom de fichier interne à l'ALTO),
                         pour garantir l'ordre des <surface> dans le fichier de sortie -->
                    <xsl:sort
                        select="number(tokenize(substring-before(//alto/Description/sourceImageInformation/fileName, '.'), '_')[3])"
                        data-type="number"/>

                    <xsl:for-each select="//alto">
                        <!-- Nom de fichier (sans extension) tel qu'enregistré dans l'ALTO lui-même,
                             ex. 109892B3_uk4nGb4kQJ6DuC9P_00005
                             (plus fiable que document-uri(), qui n'est pas toujours conservé
                             par tous les processeurs XSLT lors de l'usage de collection()) -->
                        <xsl:variable name="fileNameNoExt"
                            select="substring-before(Description/sourceImageInformation/fileName, '.')"/>
                        <xsl:variable name="filenameParts" select="tokenize($fileNameNoExt, '_')"/>

                        <!-- Segment 1 : identifiant du volume, ex. 109892B3 -->
                        <xsl:variable name="bookID" select="$filenameParts[1]"/>
                        <!-- Segment 2 : identifiant IIIF de l'image, ex. uk4nGb4kQJ6DuC9P -->
                        <xsl:variable name="iiifID" select="$filenameParts[2]"/>
                        <!-- Segment 3 : numéro absolu de la page dans le volume complet,
                             sans les zéros de padding (ex. "00005" -> "5") -->
                        <xsl:variable name="page" select="format-number(number($filenameParts[3]), '0')"/>

                        <xsl:element name="surface">
                            <!-- ID -->
                            <xsl:attribute name="xml:id">
                                <xsl:text>f</xsl:text>
                                <xsl:value-of select="$page"/>
                            </xsl:attribute>
                            <xsl:attribute name="ulx">
                                <xsl:value-of select="format-number(//Page/PrintSpace/@HPOS, '0')"/>
                            </xsl:attribute>
                            <xsl:attribute name="uly">
                                <xsl:value-of select="format-number(//Page/PrintSpace/@VPOS, '0')"/>
                            </xsl:attribute>
                            <xsl:attribute name="lrx">
                                <xsl:value-of select="format-number(number(//Page/PrintSpace/@HPOS) + number(//Page/PrintSpace/@WIDTH),'0')"/>
                            </xsl:attribute>
                            <xsl:attribute name="lry">
                                <xsl:value-of select="format-number(number(//Page/PrintSpace/@VPOS) + number(//Page/PrintSpace/@HEIGHT), '0')"/>
                            </xsl:attribute>
                            <xsl:element name="graphic">
                                <xsl:attribute name="url">
                                    <xsl:value-of select="concat($iiif-domain, $serveur, $iiif-name, $bookID, '/', $iiifID)"/>
                                </xsl:attribute>
                            </xsl:element>
                            <!-- Régions -->
                            <xsl:for-each select="//TextBlock">
                                <xsl:element name="zone">
                                    <xsl:attribute name="xml:id">
                                        <xsl:text>f</xsl:text><xsl:value-of select="$page"/><xsl:text>_</xsl:text><xsl:value-of select="@ID"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="type">
                                        <!-- Attrapage de la valeur codée -->
                                        <xsl:variable name="type_zone">
                                            <xsl:value-of select="@TAGREFS"/>
                                        </xsl:variable>
                                        <!-- Recherche de la véritable valeur exprimée -->
                                        <xsl:variable name="type_zone_valeur">
                                            <xsl:value-of
                                                select="//OtherTag[@ID = $type_zone]/@LABEL"/>
                                        </xsl:variable>
<!--                                        <xsl:value-of select="$type_zone_valeur"/>-->
                                        <xsl:choose>
                                            <xsl:when test="string($type_zone_valeur)">
                                                <xsl:value-of select="$type_zone_valeur"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="'NumberingZone'"/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:attribute>
                                    <xsl:attribute name="n">
                                        <xsl:number level="single" count="." format="1"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="ulx">
                                        <xsl:value-of select="format-number(@HPOS, '0')"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="uly">
                                        <xsl:value-of select="format-number(@VPOS, '0')"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="lrx">
                                        <xsl:value-of select="format-number(number(@HPOS) + number(@WIDTH), '0')"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="lry">
                                        <xsl:value-of select="format-number(number(@VPOS) + number(@HEIGHT),'0')"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="points">
                                        <xsl:variable name="value" select="./Shape/Polygon/@POINTS"/>
                                        <xsl:analyze-string select="$value"
                                            regex="([0-9]+)\s([0-9]+)">
                                            <xsl:matching-substring>
                                                <xsl:for-each select="$value">
                                                    <xsl:value-of select="regex-group(1)"/>
                                                    <xsl:text>,</xsl:text>
                                                    <xsl:value-of select="regex-group(2)"/>
                                                    <xsl:text> </xsl:text>
                                                </xsl:for-each>
                                            </xsl:matching-substring>
                                        </xsl:analyze-string>
                                    </xsl:attribute>
                                    <xsl:attribute name="source">
                                        <xsl:value-of select="concat($serveur, $iiif-name, $bookID, '/', $iiifID, '/')"/>
                                        <xsl:value-of select="format-number(@HPOS, '0')"/>
                                        <xsl:text>,</xsl:text>
                                        <xsl:value-of select="format-number(@VPOS, '0')"/>
                                        <xsl:text>,</xsl:text>
                                        <xsl:value-of select="format-number(@WIDTH, '0')"/>
                                        <xsl:text>,</xsl:text>
                                        <xsl:value-of select="format-number(@HEIGHT,'0')"/>
                                        <xsl:text>/full/0/default.jpg</xsl:text>
                                    </xsl:attribute>
                                    <!-- Lignes -->
                                    <xsl:for-each select="TextLine">
                                        <xsl:element name="zone">
                                            <xsl:attribute name="xml:id">
                                                <xsl:text>f</xsl:text><xsl:value-of select="$page"/><xsl:text>_</xsl:text><xsl:value-of select="@ID"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="type">
                                                <xsl:text>segmontoLine</xsl:text>
                                            </xsl:attribute>
                                            <xsl:attribute name="type">
                                                <!-- Attrapage de la valeur -->
                                                <xsl:variable name="type_zone">
                                                    <xsl:value-of select="@TAGREFS"/>
                                                </xsl:variable>
                                                <!-- Recherche de la véritable valeur -->
                                                <xsl:variable name="type_zone_valeur">
                                                    <xsl:value-of
                                                        select="//OtherTag[@ID = $type_zone]/@LABEL"/>
                                                </xsl:variable>
                                                <!--<xsl:value-of select="$type_zone_valeur"/>-->
                                                
                                                <xsl:choose>
                                                    <xsl:when test="string($type_zone_valeur)">
                                                        <xsl:value-of select="$type_zone_valeur"/>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:value-of select="'DefaultLine'"/>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                                
                                            </xsl:attribute>
                                            <xsl:attribute name="n">
                                                <xsl:number level="single" count="." format="1"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="ulx">
                                                <xsl:value-of select="format-number(@HPOS, '0')"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="uly">
                                                <xsl:value-of select="format-number(@VPOS, '0')"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="lrx">
                                                <xsl:value-of select="format-number(number(@HPOS) + number(@WIDTH), '0')"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="lry">
                                                <xsl:value-of select="format-number(number(@VPOS) + number(@HEIGHT), '0')"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="points">
                                                <xsl:variable name="value"
                                                    select="./Shape/Polygon/@POINTS"/>
                                                <xsl:analyze-string select="$value"
                                                    regex="([0-9]+)\s([0-9]+)">
                                                    <xsl:matching-substring>
                                                        <xsl:for-each select="$value">
                                                            <xsl:value-of select="regex-group(1)"/>
                                                            <xsl:text>,</xsl:text>
                                                            <xsl:value-of select="regex-group(2)"/>
                                                            <xsl:text> </xsl:text>
                                                        </xsl:for-each>
                                                    </xsl:matching-substring>
                                                </xsl:analyze-string>
                                            </xsl:attribute>
                                            <xsl:attribute name="source">
                                                <xsl:value-of select="concat($serveur, $iiif-name, $bookID, '/', $iiifID, '/')"/>
                                                <xsl:value-of select="format-number(@HPOS, '0')"/>
                                                <xsl:text>,</xsl:text>
                                                <xsl:value-of select="format-number(@VPOS, '0')"/>
                                                <xsl:text>,</xsl:text>
                                                <xsl:value-of select="format-number(@WIDTH, '0')"/>
                                                <xsl:text>,</xsl:text>
                                                <xsl:value-of select="format-number(@HEIGHT, '0')"/>
                                                <xsl:text>/full/0/default.jpg</xsl:text>
                                            </xsl:attribute>
                                            <!-- Baseline -->
                                            <xsl:element name="path">
                                                <xsl:variable name="nbaseline">
                                                    <xsl:number level="single" count="." format="1"/>
                                                </xsl:variable>
                                                <xsl:attribute name="n">
                                                    <xsl:value-of select="$nbaseline"/>
                                                </xsl:attribute>
                                                <xsl:attribute name="xml:id">
                                                    <xsl:value-of
                                                        select="concat('f',$page,'_',@ID, '_baseline_', $nbaseline)"/>
                                                </xsl:attribute>
                                                <xsl:attribute name="type">
                                                    <xsl:text>baseline</xsl:text>
                                                </xsl:attribute>
                                                <xsl:attribute name="points">
                                                    <xsl:variable name="value" select="@BASELINE"/>
                                                    <xsl:analyze-string select="$value"
                                                        regex="([0-9]+)\s([0-9]+)">
                                                        <xsl:matching-substring>
                                                            <xsl:for-each select="$value">
                                                                <xsl:value-of select="regex-group(1)"/>
                                                                <xsl:text>,</xsl:text>
                                                                <xsl:value-of select="regex-group(2)"/>
                                                                <xsl:text> </xsl:text>
                                                            </xsl:for-each>
                                                        </xsl:matching-substring>
                                                    </xsl:analyze-string>
                                                </xsl:attribute>
                                            </xsl:element>
                                            <!-- Transcription -->
                                            <xsl:element name="line">
                                                <xsl:variable name="nline">
                                                    <xsl:number level="single" count="." format="1"/>
                                                </xsl:variable>
                                                <xsl:attribute name="xml:id">
                                                    <xsl:value-of
                                                        select="concat('f',$page,'_',@ID, '_ligne_', $nline)"/>
                                                </xsl:attribute>
                                                <xsl:value-of select="String/@CONTENT"/>
                                            </xsl:element>
                                        </xsl:element>
                                    </xsl:for-each>
                                </xsl:element>
                            </xsl:for-each>
                        </xsl:element>
                    </xsl:for-each>
                </xsl:for-each>
            </sourceDoc>
            
            <xsl:element name="text">
                <xsl:element name="body">
                    <xsl:element name="p"/>
                </xsl:element>
            </xsl:element>
            
        </TEI>
        
    </xsl:template>
    
</xsl:stylesheet>
