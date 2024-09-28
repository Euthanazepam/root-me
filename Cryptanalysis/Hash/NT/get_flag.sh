#!/bin/bash

# This script cracks the hash from the task https://www.root-me.org/en/Challenges/Cryptanalysis/Hash-NT

FILE=ch48.txt
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

function downloadTaskFile() {
  # Downloads the task file.
  if [ ! -f $FILE ]; then
    wget https://static.root-me.org/cryptanalyse/ch48/$FILE
  fi
}

function decryptHash() {
  # Cracks the hash from the task file by dictionary.
  # Useful resource — https://ntlm.pw

  # hashcat -m 1000 -a 3 $FILE
  hashcat -m 1000 -a 3 -1 ! $FILE ?l?l?l?l?l?l?l?l?d?d?1
  cat $POTFILE | cut -d : -f 2
}

checkHashcat
removePotFile
downloadTaskFile
decryptHash
