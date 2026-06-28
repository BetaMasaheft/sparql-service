input_dir=./data/01-unzip-tei-files/
output_dir=./data/02-tei-to-rdf-xml

find $input_dir -name .\* -type f -delete
find $input_dir -name \*.yml -type f -delete
find $input_dir -name \*.xql -type f -delete
find $input_dir -name \*.md -type f -delete
find $input_dir -name \*.bats -type f -delete
find $input_dir -name \*.xconf -type f -delete  
rm -f $input_dir/build.xml
rm -f $input_dir/expath-pkg.xml
rm -f $input_dir/repo.xml

mkdir -p $output_dir

saxonb-xslt -s:"$input_dir" -o:"$output_dir" -xsl:"./modules/tei-to-rdf-xml/data2rdf.xsl"
