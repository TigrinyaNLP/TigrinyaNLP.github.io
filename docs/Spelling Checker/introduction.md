---
layout: default
title: Introduction
parent: Tigrinya Spelling Checker
nav_order: 1
---
# Tigrinya Spelling Checker
---
[LanguageTool](https://languagetool.org/) is an open-source spelling and grammar checker. Very much similar to Grammarly.
The tool already supports many languages but not yet Tigrinya. This page is dedicated to Tigrinya support in LanguageTool

LanguageTool has two parts. 1) the spelling checker based on OpenOffice spell checker called Hunspell. 2)Grammar checker based on grammatical rules. For example, replacing
አስምዐ with ኣስምዐ is a spelling check correction. However replacing ቤት ክርስትያን to ቤተ ክርስትያን is a grammatical correction, because it not a one word rule, plus both ቤት and ክርስትያን are correct
words by themselves. It only becomes incorrect when they are used one after the other.


| ![LanguageTool in Word](/img/spelling_word.PNG) |
|:--:|
| *Tigrinya LanguageTool in Microsoft Word* |


## Spelling Checker

The Hunspell dictionary is based on the words crawled from internet by [Biniam](https://www.cs.ru.nl/~biniam/geez/) and [Fitsum](https://github.com/fgaim/Tigrinya-WordCount)
The dictionary has over half a million unique words that appeared on Internet more than once on different document. This list does have errors, but the incorrect words have low
frequency, which means if they are suggested, they will be ranked low on the suggestion list.

Language Tool also supports POS taggers and word2vec embedding which can farther improve the quality of the spelling checker.


## Grammar Checker
Grammar rules can be specified in an xml format file named 'grammar.xml'. For example the above rule for 'ቤት ክርስትያን' can be specified as following

```
            <rule>
                <pattern>
                    <marker>
                        <token regexp="yes">ቤት|በት</token>
                    </marker>
                    <token regexp="yes">መቕደስ|ክርስትያን</token>
                </pattern>
                <message>Did you mean <suggestion>ቤተ</suggestion>?</message>
            </rule>
```
In a simple word this means 'if ቤት or በት is followed by መቕደስ or ክርስትያን suggest to change the first word to ቤተ'.  LanguageTool rule
creation is defined [here](https://dev.languagetool.org/development-overview). For example for English there are about 500 rules defined this
way. We are looking for help in adding similar rules for Tigrinya. Let us know if you help.

## Development Environment



## Source Code
  The LanguageTool github repository is forked in the [TigrinyaNLP repo](https://github.com/TigrinyaNLP/languagetool) and all the required Tigrinya materials are committed here.
  After we put enough rules and styles, we will request a pull to merge it to the main repository.

### Things than needs explanation TBD
1. separate language-detector.jar is built to support Tigrinya language detection
2. latinScript=false
3. ignoreUpperCase=false
4. fsa.type = NONE