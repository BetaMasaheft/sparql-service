<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0">
    <xsl:include href="./data2rdf.xsl"/>

    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" />

    <xsl:param name="input-path" />
    <xsl:param name="output-path" />

    <xsl:template name="main">
        <xsl:variable name="input-documents"
            select="collection(concat($input-path, '?select=*.xml;recurse=yes'))" as="document-node()*" />

            <xsl:for-each
            select="$input-documents">
            <xsl:variable name="document-relative-path" select="substring-after(base-uri(.), $input-path)" />
            <xsl:variable name="document-relative-path-tokenized" select="tokenize($document-relative-path, '/')" />
            <xsl:variable name="document-relative-path-1" select="string-join($document-relative-path-tokenized[position() &lt; last()], '/')" />
            <xsl:variable name="document-relative-path-2" select="$document-relative-path-tokenized[last()]" />
            <xsl:variable name="new-document-relative-path" select="concat($document-relative-path-1, '/', generate-id(), '-', $document-relative-path-2)" />

            <xsl:result-document href="{concat($output-path, $new-document-relative-path)}">
                <xsl:message><xsl:value-of select="document-uri(.)" /></xsl:message>
                <xsl:apply-templates select="document(/*)" />
                <!-- <xsl:copy-of select="."/>           -->
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>

<!-- saxonb-xslt -it:main -ext:on -xi:on -xsl:"./modules/xml-to-rdf-xml/xml-to-rdf-xml.xsl" input-path=/home/claudius/workspace/repositories/git/github.com/BetaMasaheft/Authority-Files/ output-path=/home/claudius/workspace/repositories/git/github.com/BetaMasaheft/sparql-service/output2/ -->

<!-- saxonb-xslt -ext:on -xi:on -xsl:"./modules/xml-to-rdf-xml/data2rdf.xsl" -s:"/home/claudius/workspace/repositories/git/github.com/BetaMasaheft/Authority-Files/ArtKeywords/gesturecrossed.xml" -->

<!-- saxonb-xslt -ext:on -xi:on -xsl:"./modules/xml-to-rdf-xml/data2rdf.xsl" -s:"/home/claudius/workspace/repositories/git/github.com/BetaMasaheft/sparql-service/input2/" -o:"/home/claudius/workspace/repositories/git/github.com/BetaMasaheft/sparql-service/output2/" -->