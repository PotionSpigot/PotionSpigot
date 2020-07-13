#!/usr/bin/env bash

cp ./PotionSpigot-Server/target/potionspigot*-SNAPSHOT.jar ./Paperclip/potionspigot-1.8.8.jar
cp ./work/1.8.8/1.8.8.jar ./Paperclip/minecraft_server.1.8.8.jar
cd ./Paperclip
mvn clean package
cd ..
cp ./Paperclip/target/paperclip*-SNAPSHOT.jar ./PotionSpigot.jar

echo ""
echo ""
echo ""
echo "Build success!"
echo "Copied final jar to $(pwd)/Paperclip.jar"