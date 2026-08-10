<xsl:stylesheet
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="2.0">
    
    <xsl:output method="xml" indent="yes"/>
    
  
    
    
    <!-- identity -->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- remove all NumberingZone except the first after a pb -->
    <xsl:template match="fw[@type='NumberingZone']">
        <xsl:variable name="mon-pb" select="preceding-sibling::pb[1]"/>
        
        <!-- Est-ce le premier fw[NumberingZone] après ce pb ? -->
        <xsl:variable name="premier" select="$mon-pb/following-sibling::fw[@type='NumberingZone'][1]"/>
        
        <xsl:if test="generate-id(.) = generate-id($premier)">
            <xsl:copy>
                <xsl:apply-templates select="@*|node()"/>
            </xsl:copy>
        </xsl:if>
    </xsl:template>
     
    
</xsl:stylesheet>
