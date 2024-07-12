#!/bin/bash

# https://www.root-me.org/en/Challenges/Cryptanalysis/Hash-SHA-2

DICTIONARY=InsidePro_Full_6.dic
FILE=ch13.txt
POTFILE=~/.local/share/hashcat/hashcat.potfile

function removePotFile() {
  if [ -f $POTFILE ]; then
    rm $POTFILE
  fi
}

function downloadAndExtractDictionary() {
  if [ ! -f $DICTIONARY ]; then
    wget "https://web.archive.org/web/20120207113205/http://www.insidepro.com/dictionaries/InsidePro%20(Full)%20-%206.rar" -O $DICTIONARY.rar

    # Use p7zip to unpack rar
    7z e $DICTIONARY.rar

    # Rename dictionary
    mv InsidePro\ \(Full\)\ -\ 6.dic $DICTIONARY
  fi
}

function downloadTaskFile() {
  if [ ! -f $FILE ]; then
    wget https://static.root-me.org/cryptanalyse/ch13/ch13.txt
  fi
}

function sanitizeHash() {
  # The hash contains an extra character 'k'.
  echo $(sed 's/k//' $FILE) > $FILE
}

function decryptHash() {
  hashcat -m 1400 -a 0 $FILE $DICTIONARY
}

function checkSHA1sum() {
  echo -n $(cat $POTFILE | cut -d : -f 2) | sha1sum
}

removePotFile
downloadAndExtractDictionary
downloadTaskFile
sanitizeHash
decryptHash
checkSHA1sum
