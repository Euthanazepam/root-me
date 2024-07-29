#!/bin/bash

# https://www.root-me.org/en/Challenges/Cryptanalysis/Hash-Message-Digest-5

DICTIONARY=rockyou.txt
FILE=ch2.txt
POTFILE=~/.local/share/hashcat/hashcat.potfile

function removePotFile() {
  if [ -f $POTFILE ]; then
    rm $POTFILE
  fi
}

function downloadAndExtractDictionary() {
  if [ ! -f $DICTIONARY ]; then
    wget https://raw.githubusercontent.com/zacheller/rockyou/master/rockyou.txt.tar.gz
    tar -xf rockyou.txt.tar.gz
#    wget https://raw.githubusercontent.com/josuamarcelc/common-password-list/main/rockyou.txt/rockyou.txt.zip
#    unzip rockyou.txt.zip
  fi
}

function downloadTaskFile() {
  if [ ! -f $FILE ]; then
    wget https://static.root-me.org/cryptanalyse/ch2/ch2.txt
  fi
}

function decryptHash() {
  hashcat -m 0 -a 0 $FILE $DICTIONARY
  cat $POTFILE | cut -d : -f 2
}

removePotFile
downloadAndExtractDictionary
downloadTaskFile
decryptHash
