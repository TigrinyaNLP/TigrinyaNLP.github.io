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

## DEV Environment

During the development phase, we will maintain our DEV API environment
at [spell.tigrinyadictionary.com](https://spell.tigrinyadictionary.com/).  Use the
[API documentation](https://languagetool.org/http-api/swagger-ui/#/default) to properly query the API

## Language Detector

LanguageTool has a dependency to language-detector-0.6.jar. The detector is used to detect the language of a source text (mostly when a user does not specify the language).
However the detector does not support Tigrinya. To fix this we have [forked the source code](https://github.com/TigrinyaNLP/language-detector) and added Tigrinya support.
The compiled language-detector.jar is available [here for download](https://github.com/TigrinyaNLP/language-detector/releases/tag/language-detector-0.6) use this instead of
the default language-detector.jar that comes from the maven repository.

## Tigrinya Files

The main Tigrinya codes and files are available under [languagetool-language-modules](https://github.com/TigrinyaNLP/languagetool/tree/master/languagetool-language-modules/ti). This
directory contains Hunspell files and grammar.xml.



### Important
There are undocumented changes we have to add in ti_ER.info files
1. latinScript=false should be added to tell LanguageTool that Tigrinya is not a latin based language
2. Apparently Geez characters are treated as UpperCase so we should specify 'ignoreUpperCase=false' to allow Geez based languages to be checked by the spell checker
3. fsa.type = NONE should also be added, since we are using plain list of words in our dictionary (not the default SUFFIX type which has extra tagging for case like English)
