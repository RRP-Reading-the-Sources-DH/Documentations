<xsl:stylesheet
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <xsl:output method="xml" indent="yes"/>
    
    <!-- remmettre en place la déclaration effacée dans le script python -->
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
   <xsl:apply-templates/>
    </xsl:template>
    
    
   <!-- version 1 du code, il fonctionne pourrait être automatié d'avanatage, puis insérerd dans le pipeline d'Edition, mais à voir
    * ajouter  après la fonction count () + [le numéro de la premire page] le document commencera a décompter les pages à partir de là -->
    <xsl:template match="@*|node()"> 
        <xsl:copy> <xsl:apply-templates select="@*|node()"/> </xsl:copy>
    </xsl:template>


     <!--   <!-\- Identity transform (copies everything by default) -\-> 
    <xsl:template match="fw[@type='NumberingZone']">
        <!-\- mettre à jour le numéro de page en fonction du document : ici la pagination commence à la page 2, donc + 2 (count commence par défaut de 0) -\->
        <xsl:variable name="num"
            select="count(preceding::fw[@type='NumberingZone']) + 1"/>  
        
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates select="lb"/>    
            <choice>
                <orig>
                    <xsl:value-of select="$num"/>
                </orig>
                <reg type="normalized">
                    <xsl:value-of select="$num"/>
                </reg>
            </choice>
        </xsl:copy>
    </xsl:template>-->
    
    <xsl:template match="ab[@type='MainZone-P' or @type='MainZone-Head']">
        
        <!-- copy the MainZone -->
        <ab>
            <xsl:copy-of select="@*"/>
            
            <!-- pull DropCapitalZone if it is immediate previous sibling -->
            <xsl:if test="preceding-sibling::ab[1][@type='DropCapitalZone']">
                <xsl:copy-of select="preceding-sibling::ab[1]/node()"/>
            </xsl:if>
            
            <!-- then copy current content -->
            <xsl:apply-templates/>
        </ab>
        
    </xsl:template>
    
    <!-- remove DropCapitalZone when consumed -->
    <xsl:template match="ab[@type='DropCapitalZone']"/>
        
        
    
</xsl:stylesheet>