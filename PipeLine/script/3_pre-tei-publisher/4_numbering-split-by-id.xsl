<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    
    <!-- xml:id du choice (ou de tout descendant : on remonte à l'ancêtre choice) 
         à partir duquel on veut redémarrer -->
    <xsl:param name="split-id" select="'reprise1'"/>
    
    <!-- Nouveau numéro de départ à cet endroit -->
    <xsl:param name="restart-number" select="455"/>
    
    <!-- Tous les choice ciblés, dans l'ordre du document -->
    <xsl:variable name="numbering-choices"
        select="//*[local-name()='choice']
        [local-name(..)='fw']
        [../@type='NumberingZone']"/>
    
    <!-- Le choice de reprise (on remonte depuis n'importe quel élément portant l'id) -->
    <xsl:variable name="split-choice" as="node()?"
        select="if ($split-id != '')
        then (//*[@xml:id = $split-id])[1]
        /ancestor-or-self::*[local-name()='choice'][1]
        else ()"/>
    
    <!-- Son rang parmi les choice numérotés (1 = premier) -->
    <xsl:variable name="split-rank" as="xs:integer?"
        select="if ($split-choice)
        then count($split-choice/preceding::*[local-name()='choice']
        [local-name(..)='fw']
        [../@type='NumberingZone']) + 1
        else ()"/>
    
    <!-- Copie identité par défaut -->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Cible chaque choice dans une NumberingZone, namespace-agnostique -->
    <xsl:template match="*[local-name()='choice']
        [local-name(..)='fw']
        [../@type='NumberingZone']">
        
        <xsl:variable name="pos">
            <xsl:number level="any"
                count="*[local-name()='choice']
                [local-name(..)='fw']
                [../@type='NumberingZone']"/>
        </xsl:variable>
        
        <xsl:choose>
            <!-- Avant le point de reprise (ou pas de split défini) : ne rien changer -->
            <xsl:when test="not($split-rank) or number($pos) &lt; $split-rank">
                <xsl:copy>
                    <xsl:apply-templates select="@*|node()"/>
                </xsl:copy>
            </xsl:when>
            
            <!-- À partir du point de reprise (inclus) : renumérote -->
            <xsl:otherwise>
                <xsl:variable name="new-number" as="xs:integer"
                    select="xs:integer($restart-number + (number($pos) - $split-rank))"/>
                
                <!-- Sélection namespace-agnostique de orig et reg -->
                <xsl:variable name="origEl" select="*[local-name()='orig']"/>
                <xsl:variable name="regEl" select="*[local-name()='reg']"/>
                
                <xsl:element name="{name()}" namespace="{namespace-uri()}">
                    <xsl:copy-of select="@*"/>
                    
                    <xsl:element name="{name($origEl)}" namespace="{namespace-uri($origEl)}">
                        <xsl:copy-of select="$origEl/@*"/>
                        <xsl:value-of select="$new-number"/>
                    </xsl:element>
                    
                    <xsl:element name="{name($regEl)}" namespace="{namespace-uri($regEl)}">
                        <xsl:copy-of select="$regEl/@*"/>
                        <xsl:value-of select="$new-number"/>
                    </xsl:element>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>
