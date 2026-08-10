<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    
    <xsl:param name="base-number" select="92"/>
    
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
        <xsl:variable name="new-number" select="$base-number + number($pos) - 1"/>
        
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
    </xsl:template>
    
</xsl:stylesheet>