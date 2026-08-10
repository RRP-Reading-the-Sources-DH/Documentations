<?xml version="1.0" encoding="UTF-8"?>    
<xsl:stylesheet
    version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs">
    
    <xsl:output encoding="UTF-8" method="xml" indent="yes"/>
    <!-- Decoupage du xml tei en vue d'un fichier pour une table des matières de Tei-publisher -->
    <!-- le 1.07.2026 ça fonctionne parfaitement -->
    <!-- ne pas oublié de changer les noms de chapitre e.g.C_PRIMVM pour C_I si besoin manuellement chercher _PRIMVM -->
    <xsl:strip-space elements="*"/>
    
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

    
    <xsl:template match="body">
        
        <xsl:copy>
            
            <!-- preserve body attributes -->
            <xsl:apply-templates select="@*"/>
            
                
                <!-- group all body children -->
                <xsl:for-each-group
                    select="node()"
                    group-starting-with="
                    ab[
                    @type='MainZone-Head'
                    and (
                    choice/reg[matches(normalize-space(.), '^cap', 'i')]
                    or hi/choice/reg[matches(normalize-space(.), '^cap', 'i')]
                    )
                    ]">
                    
                    <xsl:variable name="chapterHead"
                        select="
                        current-group()[1]
                        [self::ab[@type='MainZone-Head']]
                        "/>
                    
                    <xsl:choose>
                        
                        <!-- real chapter -->
                        <xsl:when test="$chapterHead">
                            
                            <xsl:variable name="chapter-id"
                                select="
                                concat(
                                'C_',
                                translate(
                                replace(
                                replace(
                                tokenize(
                                normalize-space(
                                string-join(
                                $chapterHead//reg,
                                ' '
                                )
                                ),
                                '\s+'
                                )[last()],
                                '^cap\\.?\\s*',
                                '',
                                'i'
                                ),
                                '\.$',
                                ''
                                ),
                                ' ',
                                '_'
                                )
                                )"/>
                            
                            <xsl:variable name="chapter-title"
                                select="
                                concat(
                                'Cap. ',
                                translate(
                                replace(
                                replace(
                                tokenize(
                                normalize-space(
                                string-join(
                                $chapterHead//reg,
                                ' '
                                )
                                ),
                                '\s+'
                                )[last()],
                                '^cap\\.?\\s*',
                                '',
                                'i'
                                ),
                                '\.$',
                                ''
                                ),
                                ' ',
                                ' '
                                )
                                )"/>
                            
                            <div type="chapter-title"
                                xml:id="{$chapter-id}">
                                <ab>
                                    <xsl:copy-of select="$chapterHead/@*"/>
                                    
                                    <title>
                                        <xsl:attribute name="ref"><xsl:value-of select="concat('#', $chapter-id)"/></xsl:attribute>
                                        <xsl:apply-templates select="$chapterHead/node()"/>
                                    </title>
                                </ab>
                                <div type="all-chapter-text">
                                    <xsl:attribute name="corresp"><xsl:value-of select="concat('#',$chapter-id)"/></xsl:attribute>
                                    
                                    <!-- group content by verse -->
                                    <xsl:for-each-group
                                        select="current-group()[position() gt 1]"
                                        group-starting-with="
                                        ab[
                                        @type='MainZone-Head'
                                        and not(
                                        choice/reg[matches(normalize-space(.), '^cap', 'i')]
                                        or hi/choice/reg[matches(normalize-space(.), '^cap', 'i')]
                                        )
                                        ]">
                                        
                                        <xsl:variable name="verseHead"
                                            select="
                                            current-group()[1]
                                            [self::ab[@type='MainZone-Head']]
                                            "/>
                                        
                                        <xsl:choose>
                                            
                                            <!-- real verse -->
                                            
                                            <xsl:when test="$verseHead">
                                                
                                                <!-- Chapter wrapper -->
                                                <div type="verse+commentary-text">
                                                    
                                                    
                                                    <!-- build verse id using xsl:number logic -->
                                                  <xsl:variable name="verse-num">
                                                      <xsl:number
                                                          level="any"
                                                          count="ab[@type='MainZone-Head'
                                                          and not(choice/reg[matches(normalize-space(.), '^cap', 'i')])
                                                          and not(hi/choice/reg[matches(normalize-space(.), '^cap', 'i')])]"
                                                          from="ab[@type='MainZone-Head'
                                                          and (choice/reg[matches(normalize-space(.), '^cap', 'i')]
                                                          or hi/choice/reg[matches(normalize-space(.), '^cap', 'i')])]"/>
                                                    </xsl:variable>
                                                  
                                                  
                                                    <xsl:variable name="verse-id"
                                                        select="concat($chapter-id, '_sec_', $verse-num)"/>
                                                    
                                                    <!-- build verse title number -->
                                                    <xsl:variable name="verse-title-num" select="$verse-num"/>
                                                    
                                                    <xsl:attribute name="xml:id"><xsl:value-of select="concat($verse-id,'_full')"/></xsl:attribute>
                                                    
                                                    <div type="verse" xml:id="{$verse-id}">
                                                        
                                                        <!-- MAIN TEXT BLOCK -->
                                                        <ab corresp="#{$verse-id}" type="MainZone-Head">
                                                            
                                                            <!-- TITLE INSIDE AB -->
                                                            <title ref="#{$verse-id}">
                                                                <xsl:value-of
                                                                    select="concat('[', $chapter-title,',',' § ', $verse-title-num, ']')"/>
                                                            </title>
                                                            
                                                            <!-- drop-cap + content -->
                                                            <xsl:apply-templates select="$verseHead/node()"/>
                                                            
                                                        </ab>
                                                        
                                                    </div>
                                                    
                                                    <!-- commentary wrapper -->
                                                    <div type="commentary" corresp="#{$verse-id}">
                                                        <xsl:apply-templates select="current-group()[position() gt 1]"/>
                                                    </div>
                                                    
                                                </div>
                                                
                                            </xsl:when>
                                         
                                            
                                            <!-- material before first verse -->
                                            <xsl:otherwise>
                                                                                                
                                                <xsl:apply-templates select="current-group()"/>
                                            </xsl:otherwise>
                                            
                                        </xsl:choose>
                                        
                                    </xsl:for-each-group>
                                    
                                </div>
                            </div>
                            
                        </xsl:when>
                        
                        <!-- content before first chapter -->
                        <xsl:otherwise>
                            <div type="book-introduction"
                                xml:id="Introduction">
                                
                                <xsl:for-each-group
                                    select="current-group()"
                                    group-starting-with="ab[@type='MainZone-Head']">
                                    
                                    <xsl:choose>
                                        
                                        <!-- group begins with a title -->
                                  
                                        <xsl:when test="current-group()[1][self::ab[@type='MainZone-Head']]">
                                            <div type ="introduction-title">
                                            <ab>
                                                <!-- copy attributes of original ab -->
                                                <xsl:copy-of select="current-group()[1]/@*"/>
                                                
                                                <!-- NEW title INSIDE ab -->
                                                <title type="default-title">
                                                    <xsl:apply-templates select="current-group()[1]/node()"/>
                                                </title>
                                                
                                            </ab>
                                            </div>
                                            <!-- following material -->
                                            <xsl:if test="count(current-group()) gt 1">
                                                <div type="introduction-text">
                                                    <xsl:apply-templates select="current-group()[position() gt 1]"/>
                                                </div>
                                            </xsl:if>
                                            
                                        </xsl:when>
                                        
                                        <!-- material before first MainZone-Head -->
                                        <xsl:otherwise>
                                            <div type="introduction-text">
                                                <xsl:apply-templates
                                                    select="current-group()"/>
                                            </div>
                                        </xsl:otherwise>
                                        
                                    </xsl:choose>
                                    
                                </xsl:for-each-group>
                                
                            </div>
                        </xsl:otherwise>
                      <!--  <xsl:otherwise>
                            <div type="book-introduction"
                                xml:id="Introduction">
                                
                                <xsl:apply-templates
                                    select="current-group()"/>
                                
                            </div>
                        
                        </xsl:otherwise>-->
                        
                    </xsl:choose>
                    
                </xsl:for-each-group>
                
            <!--</div>-->
            
        </xsl:copy>
        
    </xsl:template>
    
    
    
</xsl:stylesheet>