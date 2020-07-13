#!/bin/bash

MINECRAFT_VERSION=$(cat BuildData/info.json | grep minecraftVersion | cut -d '"' -f 4)
VANILLA_JAR=work/$MINECRAFT_VERSION/$MINECRAFT_VERSION.jar

VANILLA_URL="https://s3.amazonaws.com/Minecraft.Download/versions/$MINECRAFT_VERSION/minecraft_server.$MINECRAFT_VERSION.jar"

# OS X grep does not support -P option
if [[ "$OSTYPE" == "darwin"* ]]; then
  # check if gnu grep is installed and available to us through home brew
  if [ ! -d "/usr/local/Cellar/grep" ]; then
    echo "grep is not available, please install gnu grep via home brew with brew install grep."
    exit 1;
  fi

  SERVER_JAR=PotionSpigot-Server/target/$(ls PotionSpigot-Server/target | ggrep -P "^potionspigot-[\d\.]+-[\w\.]+(-SNAPSHOT)?.jar")
else
  SERVER_JAR=PotionSpigot-Server/target/$(ls PotionSpigot-Server/target | grep -P "^potionspigot-[\d\.]+-[\w\.]+(-SNAPSHOT)?.jar")
fi

if [ ! -f "$SERVER_JAR" ]; then
    echo "Server Jar: $SERVER_JAR not found"
    exit 1;
fi;

./generateJar.sh "$SERVER_JAR" "$VANILLA_JAR" "$VANILLA_URL" "PotionSpigot"

if [ $? != 0 ]; then
    echo "Failed to generate jar"
    exit 1
fi;

mkdir -p build

cp work/Paperclip/PotionSpigot.jar build/PotionSpigot.jar