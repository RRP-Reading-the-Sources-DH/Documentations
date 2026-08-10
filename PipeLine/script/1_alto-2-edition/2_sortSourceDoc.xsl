<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    
    <xsl:output encoding="UTF-8" method="xml" indent="yes"/>
    
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>

       <!-- le classement des fichiers dont chacun équivaut à une page du document dépend de leur système de nommage.
    /!\ N'oubliez pas de commenter/ dec0mmenter en fonction de la provenance de vos données :  e-rara ; mdz ou SBB (Berlin),
     les documents de la ONB ont une structure différent qui requiert un autre script =>  2-3_creatbody_ONB.xsl
     -->

    
    <!-- for e-rara -->
    
   <!-- <xsl:template match="//sourceDoc">
        <sourceDoc xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:for-each select="surface">
                <xsl:sort select="substring-after(@xml:id, 'f')" data-type="number"/>
                <xsl:copy-of select="."/>
            </xsl:for-each>
        </sourceDoc>
    </xsl:template>
-->
    
    
    <!-- for mdz    -->
    <xsl:template match="//sourceDoc"> 
        <!-- Create the output element -->
        <sourceDoc xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:for-each select="surface">
                <!-- Sort based on the numeric part after the underscore '_' -->
                <xsl:sort select="substring-after(@xml:id, '_')" data-type="number"/>                
                <!-- Copy the entire surface element to the output -->
                <xsl:copy-of select="."/>
            </xsl:for-each>
        </sourceDoc>
    </xsl:template>
    
    
    <!-- for Staatsbibliothek zu Berlin (SBB) : xml:id de type f773861106-0162, pas d'underscore, on trie sur la partie après le tiret '-' -->
   <!-- <xsl:template match="//sourceDoc"> 
        <!-\- Create the output element -\->
        <sourceDoc xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:for-each select="surface">
                <!-\- Sort based on the numeric part after the hyphen '-' -\->
                <xsl:sort select="substring-after(@xml:id, '-')" data-type="number"/>                
                <!-\- Copy the entire surface element to the output -\->
                <xsl:copy-of select="."/>
            </xsl:for-each>
        </sourceDoc>
    </xsl:template>
-->
    
    
    <xsl:template match="//body">
        <body xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:copy-of select="//sourceDoc/node()|@*"/>
        </body>
    </xsl:template>
    
        
    <xsl:template match="//body">
        <body xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:copy-of select="//sourceDoc/node()|@*"/>
        </body>
    </xsl:template>
    
   
    
</xsl:stylesheet>