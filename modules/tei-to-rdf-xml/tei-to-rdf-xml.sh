mkdir -p ./output/02-tei-to-rdf-xml

time saxonb-xslt -s:"./output/01-move-tei-files" -o:"./output/02-tei-to-rdf-xml" -xsl:"./modules/tei-to-rdf-xml/data2rdf.xsl"
