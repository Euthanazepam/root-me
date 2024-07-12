#!/bin/bash

# https://www.root-me.org/en/Challenges/Cryptanalysis/Hash-Message-Digest-5

function downloadAndExtractDictionary() {
  if [ ! -f rockyou.txt ]; then
    wget https://raw.githubusercontent.com/zacheller/rockyou/master/rockyou.txt.tar.gz
    tar -xf rockyou.txt.tar.gz
#    wget https://raw.githubusercontent.com/josuamarcelc/common-password-list/main/rockyou.txt/rockyou.txt.zip
#    unzip rockyou.txt.zip
  fi
}

function downloadTaskFile() {
  if [ ! -f ch2.txt ]; then
    wget https://static.root-me.org/cryptanalyse/ch2/ch2.txt
  fi
}

function decryptHash() {
  hashcat -m 0 -a 0 ch2.txt rockyou.txt
}

downloadAndExtractDictionary
downloadTaskFile
decryptHash
