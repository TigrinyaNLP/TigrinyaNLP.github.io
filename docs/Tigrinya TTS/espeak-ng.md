---
layout: default
title: Tigrinya Phonemize
parent: Tigrinya TTS
nav_order: 1
---
# Tigrinya TTS
---

The [eSpeak NG](https://github.com/TigrinyaNLP/espeak-ng) is open source software text-to-speech synthesizer. 
eSpeak NG uses a "formant synthesis" method. This allows many law-resource languages to make use of IPA 
phonemization as a base for text-to-speech synthesizer. 

Combining the eSpeak NG formant synthesis and HuggingFace's AI based synthesis will create high quality TTS 
synthesis without demanding large human speech recording as a training data. [Piper](https://github.com/rhasspy/piper)
is an excellent TTS technology to combine both.

In this section we discuss how Tigrinya language is added to espeak-ng. On the next section we will discuss
Piper.

##Using compiled Tigrinya espeak-ng dictionary

The dictionary for espeak-ng is already compiled in https://github.com/TigrinyaNLP/espeak-ng/releases. 
You can use it by installing espeak-ng and copy the dictionary to the lib/espeak-ng-data
```
yum install espeak-ng
espeak-ng --version #note the location of espeak-ng-data 
wget https://github.com/TigrinyaNLP/espeak-ng/releases/download/tigrinya1.0/ti_dict
cp ti_dict   /usr/lib/x86_64-linux-gnu/espeak-ng-data
```
##Compile Tigrinya espeak-ng dictionary

The main phonemizer rule for Tigrinya is stored in [ti_rules](https://github.com/TigrinyaNLP/espeak-ng/blob/master/dictsource/ti_rules) file.
Here it discribes which Tigrinya letter corresponds to which ascii-IPA representation. Sometimes words can sound different, 
depending on if they are at the beginning or in the middle or at the end of a word. This difference can be expressed in espeak-ng.
See extensive documentation at https://github.com/TigrinyaNLP/espeak-ng/blob/master/docs/dictionary.md#rules.
