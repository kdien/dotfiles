#!/usr/bin/env bash

rm -rf java-debug
git clone https://github.com/microsoft/java-debug.git
cd java-debug || return
mvn clean install
cd ..

rm -rf vscode-java-test
git clone https://github.com/microsoft/vscode-java-test.git
cd vscode-java-test || return
npm install
npm run build-plugin
cd ..

rm -rf eclipse.jdt.ls
git clone https://github.com/eclipse/eclipse.jdt.ls.git
cd eclipse.jdt.ls || return
version=$(git describe --tags | cut -d '-' -f 1 | cut -d 'v' -f 2)
filename=$(curl -sSL "https://download.eclipse.org/jdtls/milestones/$version/latest.txt")
cd ..
echo "Downloading $filename"
curl -sSL "https://www.eclipse.org/downloads/download.php?file=/jdtls/milestones/$version/$filename" -o "$filename"
rm -rf jdtls
mkdir -p jdtls
echo "Extracting $filename"
tar xf "$filename" -C jdtls
echo 'Cleaning up'
rm -rf eclipse.jdt.ls
rm -f "$filename"
echo 'Done!'

