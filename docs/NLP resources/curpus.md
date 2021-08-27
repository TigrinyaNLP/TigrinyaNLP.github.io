---
layout: default
title: Tigrinya Corpus
parent: NLP resources
nav_order: 1
---
# Tigrinya Corpus
---
## Corpus Building

[Corpus](https://en.wikipedia.org/wiki/Corpus_linguistics) may have a broader meaning in Linguists study. For the purpose of
this document, Corpus is a complete list of words/phrases of a language that adheres to the morphological structure
(grammatical syntax) of that language.  Most Language technologies are based on machine learning algorithms.
Knowing the spelling of the words and their derivation helps navigating the learning algorithms to the right learning path.

For example when running OCR the word ስምካ could be seen by the OCR application as ስምካ ሰምካ ከምካ or ክምካ, because all these
texts are visually very similar. But only one word is a valid corpus entry. With the help of the corpus,
the application can produce a correct output. Corpus can also be used in part of speech tagging, germination
and other analysis that could improve the accuracy of character recognition applications, spell checkers, voice recognition, translation services and other NLP applications.

There are few Tigrinya related works on this regard. Few years ago Biniam Gebremichael collected all Tigrinya webpages from
internet and extracted [400,000 Tigrinya words](http://www.cs.ru.nl/~biniam/geez/crawl.php) along with
their frequency of occurrence. The list give a good overview of the commonly used Tigrinya words.
It can be used as a starting point. However this is far from what a corpus is, for several reasons.

* No guarantee that all words are correctly spelled
* There is no word derivation rule
* The list does not contain all words, There are words that are valid entry, but not in the list

Following this work, M. Geiser worked on [morphological analysis of Tigrinya](http://homes.sice.indiana.edu/gasser/L3/horn2.2.pdf) (alongside of Amharic and Oromo). The work was translated to a python code called [HornMorpho](https://github.com/fgaim/HornMorpho). Geiser uses Finite State Transition to represent word patens and their attributes. This helps construct and dissect a complex word from/to simple verb and attributes.

For example the word ኣይፈለጠን is analyzed by HornMorpho as follows: grammatical transformation of the root word ፈለጠ, with linguistic features – third person masculine subject, and perfective and negative grammatically.

```
import l3
l3.anal('ti', 'ኣይፈለጠን')
POS: verb, root: <flT>, citation: ፈለጠ
subject: 3, sing, masc
grammar: perfective, negative
```

HornMorpho can also work backwards, meaning giving a root word and grammatical features, it can derive the compound Tigrinya words. This is a good work that could enrich the corpus with correct grammatical derivation, but HornMorpho lucks completeness. The work only covers Tigrinya Verbs. Tigrinya Nouns, adjectives are not covered. Also there are some patterns of Tigrinya verbs that are not covered.
