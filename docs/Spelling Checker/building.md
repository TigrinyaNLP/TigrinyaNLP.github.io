---
layout: default
title: Building
parent: Tigrinya Spelling Checker
nav_order: 2
---
# Building LanguageTool for Tigrinya
---
[LanguageTool Tigrinya Github](https://github.com/TigrinyaNLP/languagetool) is the forked source of LanguageTool. Tigrinya support
is built on a separate repository. Once the support is fully implemented, we will do a 'pull request' for LanguageTool
developers to merge our repository to the main source.

## Build from Source

There are 2 things to build
1. Build LanguageTool source code
2. Build HunSpell dictionary into LanguageTool compatible (Morfologik) dictionary. This is done when ever we add or remove a word from the main dictionary

### 1. Build LanguageTool source code
To build Tigrinya Language Tool from source you will need maven and git installed in your system.
An easier approach is to build it in Ubuntu, either on a Linux machine or on WSL 2 in Windows.

```cli
sudo apt install maven
sudo apt install git
git clone https://github.com/TigrinyaNLP/languagetool.git
cd languagetool
./build.sh languagetool-standalone package -DskipTests
```

### 2. Build Tigriya HunSpell dictionary

If you change any of the following files: ti_ER.dic,ti_ER_wordlist.xml and ti_ER.info you can compile a new ti_ER.dict using the following command

```cli
[languagetool]$ sh languagetool-language-modules/ti/src/main/resources/org/languagetool/resource/ti/hunspell/create_dict.sh ti ER
```
You can test the compiled version by running (uncomment) the last two lines in create_dict.sh

## Language Detector

LanguageTool has a dependency to language-detector-0.6.jar. The detector is used to detect the language of a source text (mostly when a user does not specify the language).
However the detector does not support Tigrinya. To fix this we have [forked the source code](https://github.com/TigrinyaNLP/language-detector) and added Tigrinya support.
The compiled language-detector.jar is available [here for download](https://github.com/TigrinyaNLP/language-detector/releases/tag/language-detector-0.6) use this instead of
the default language-detector.jar that comes from the maven repository.

## Tigrinya Files

The main Tigrinya codes and files are available under [languagetool-language-modules](https://github.com/TigrinyaNLP/languagetool/tree/master/languagetool-language-modules/ti). This
directory contains Hunspell files and grammar.xml.


## DEV Environment

During the development phase, we will maintain our DEV API environment
at [spell.tigrinyadictionary.com](https://spell.tigrinyadictionary.com/).  Use the
[API documentation](https://languagetool.org/http-api/swagger-ui/#/default) to properly query the API


### Important
There are undocumented changes we have to add in ti_ER.info files
1. latinScript=false should be added to tell LanguageTool that Tigrinya is not a latin based language
2. Apparently Geez characters are treated as UpperCase so we should specify 'ignoreUpperCase=false' to allow Geez based languages to be checked by the spell checker
3. fsa.type = NONE should also be added, since we are using plain list of words in our dictionary (not the default SUFFIX type which has extra tagging for case like English)
