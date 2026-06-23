rm -f ./input/*
cp /home/claudius/Downloads/expanded-main.zip ./input/
unzip -j ./input/expanded-main.zip -d ./input/ && rm ./input/expanded-main.zip
rm -rf ./output/01-move-tei-files/

rm -rf ./input/expanded-main/.github/
rm -f ./input/build.xml
rm -f ./input/repo.xml
rm -f ./input/expath-pkg.xml
find ./input -name .\* -type f -delete
find ./input -name \*.yml -type f -delete
find ./input -name \*.xql -type f -delete
find ./input -name \*.md -type f -delete
find ./input -name \*.bats -type f -delete
find ./input -name \*.xconf -type f -delete

mkdir -p ./output/01-move-tei-files

time fdfind . './input' | while read file
do
    mv $file ./output/01-move-tei-files/
done

rm -f ./input/*
