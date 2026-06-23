rm -rf ./input/expanded-main/.github/ &&\
rm -f ./input/expanded-main/build.xml && rm -f ./input/expanded-main/repo.xml &&\
find ./input/expanded-main -name .\* -type f -delete &&\
find ./input/expanded-main -name \*.md -type f -delete &&\
find ./input/expanded-main -name \*.xql -type f -delete &&\
find ./input/expanded-main -name \*.bats -type f -delete

time find ./input -type d | while read dir
do
    saxonb-xslt -s:"$dir" -o:"./output-rdf-xml" -xsl:"./modules/tei-to-rdf-xml/data2rdf.xsl"
done
