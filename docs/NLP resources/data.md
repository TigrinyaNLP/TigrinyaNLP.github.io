---
layout: default
title: Data Directory
parent: NLP resources
nav_order: 2
---
# Data Directory
---
## Tigrinya data resources for NLP training

### Tigrinya Sentences
1. Tigrinya sentences collected on internet. Mostly from 4 years of Haddas Ertra news letter. [Download](https://github.com/TigrinyaNLP/corpus/blob/main/crawler/tigrinya_sentences.zip)


### Tigrinya Translation
1. Sentence to Sentence translation from English to Tigrinya from the Bible. The English verses is taken from the
bible version closest to Tigrinya Bible. Which is World English Bible (WEB) version. This gives better translation accuracy than other versions such as KJV.
[Download](https://github.com/TigrinyaNLP/corpus/blob/main/translation/en-ti-bible.zip)
- used in Hugging Face translation model [en-ti-translate](https://huggingface.co/Biniam/en_ti_translate)
- Data is organized as follows, ready to be used for fine-tuning Pytorch models
```
test.source
test.target
val.source
val.target
train.source
train.target
```
2. Short 1000 English-Tigrinya translation for testing (adopted from UNHCR intro document). [Download](https://github.com/TigrinyaNLP/corpus/blob/main/translation/en-ti-short-UNHCR.zip)