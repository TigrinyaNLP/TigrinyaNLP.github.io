---
layout: default
title: Tigrinya Phonemizer
parent: Tigrinya TTS
nav_order: 1
---
# Tigrinya Phonemizer
---

The [eSpeak NG](https://github.com/TigrinyaNLP/espeak-ng) is open source software text-to-speech synthesizer. 
eSpeak NG uses a "formant synthesis" method. This allows many law-resource languages to make use of IPA 
phonemization as a base for text-to-speech synthesizer. 

Combining the eSpeak NG formant synthesis and HuggingFace's AI based synthesis, will create high quality TTS 
output without demanding large human speech recording for training. [Piper](https://github.com/rhasspy/piper)
is an excellent TTS technology to combine both. This is very important for Tigrinya language, as we do not have huge volume
of recording that is required by AI based solutions.

In this section we discuss how Tigrinya language is added to espeak-ng. On the next section we will discuss
Piper.

## Install compiled Tigrinya espeak-ng dictionary
The TigrinyaNLP team has started adding Tigrinya to espeak-ng. The fork is located in https://github.com/TigrinyaNLP/espeak-ng.
The first release of Tigrinya dictionary for espeak-ng available [here](https://github.com/TigrinyaNLP/espeak-ng/releases). 
You can use it by installing espeak-ng and copy it the dictionary where espeak-ng-data is installed.
```
yum install espeak-ng
espeak-ng --version # note the location of espeak-ng-data  (eg /usr/lib/espeak-ng-data)
rm -rf /usr/lib/espeak-ng-data
wget https://github.com/TigrinyaNLP/espeak-ng/releases/download/espeak-ng-data-plus-ti_1.0/espeak-ng-data.zip
unzip espeak-ng-data.zip  -d /usr/lib/
```

## Using espeak-ng
You can run espeak-ng to convert Tigrinya words to their phoneme representation as below
```
# text to phoneme
espeak-ng  -v ti "ዛንትኡ ግና ነዊሕ እዩ።" -qx
 > z,anyt'y?u g'yna n'@wiC ?'yju
```
Run the following command to synthesis an audio wav file for the sentence.
```
# text to audio 
espeak-ng  -v ti "ዛንትኡ ግና ነዊሕ እዩ።" --stdout -w audio.wav
```
You can now listen to the [audio](/audio/espeak-test.wav) file from any audio player. 
The sound is not human, this is just a computerized audio. On the next section we will make use of it and
[improve the audio](/audio/piper.wav) using Piper

## Compile Tigrinya espeak-ng dictionary

The main phonemic rule for Tigrinya is stored in [ti_rules](https://github.com/TigrinyaNLP/espeak-ng/blob/master/dictsource/ti_rules) file.
Here it describes which Tigrinya letter corresponds to which ascii-IPA representation. Sometimes words can sound different, 
depending on if they are at the beginning or in the middle or at the end of a word. 
This difference can be expressed in espeak-ng. See extensive documentation 
[here](https://github.com/TigrinyaNLP/espeak-ng/blob/master/docs/dictionary.md#rules).

You can clone,edit and compile espeak-ng using this commands
```
git clone https://github.com/TigrinyaNLP/espeak-ng.git
cd espeak-ng 
sh autogen.sh
sh configure --prefix=/usr
make
```