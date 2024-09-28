#!/bin/bash

# This script cracks the hash from the task https://www.root-me.org/en/Challenges/Cryptanalysis/Hash-DCC

DICTIONARY=rockyou.txt
FILE=ch50.txt
POTFILE=~/.local/share/hashcat/hashcat.potfile
PACKAGE_NAME="hashcat"

function checkHashcat()
  # Check if hashcat is installed.
  if [[ ! $(pacman -Ss $PACKAGE_NAME) ]]; then
    echo -e "$PACKAGE_NAME isn't installed\nInstall it with 'pacman -Sy $PACKAGE_NAME'"
    exit 1
  fi

function removePotFile() {
  # Clears potfile with previously cracked passwords.
  if [ -f $POTFILE ]; then
    rm $POTFILE
  fi
}

function downloadAndExtractDictionary() {
  # Downloads the archive with the rockyou.txt dictionary and unpacks it.
  if [ ! -f $DICTIONARY ]; then
    wget https://raw.githubusercontent.com/zacheller/rockyou/master/rockyou.txt.tar.gz
    tar -xf rockyou.txt.tar.gz
#    wget https://raw.githubusercontent.com/josuamarcelc/common-password-list/main/rockyou.txt/rockyou.txt.zip
#    unzip rockyou.txt.zip
  fi
}

function downloadTaskFile() {
  # Downloads the task file.
  if [ ! -f $FILE ]; then
    wget https://static.root-me.org/cryptanalyse/ch50/$FILE
  fi
}

function decryptHash() {
  # Cracks the hash from the task file by dictionary.
  HASH=$(grep 'ROOTME.LOCAL/Administrator' $FILE | cut -d ':' -f 2,3)
  hashcat -m 1100 -a 0 $HASH $DICTIONARY
  cat $POTFILE | cut -d : -f 3
}

checkHashcat
removePotFile
downloadAndExtractDictionary
downloadTaskFile
decryptHash
