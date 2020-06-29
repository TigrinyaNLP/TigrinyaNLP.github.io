---
layout: default
title: Introduction
parent: Tigrinya OCR
nav_order: 1
---
# Tigrinya OCR
---
[OCR](https://en.wikipedia.org/wiki/Optical_character_recognition) technology is the conversion of image (scanned) documents into electronic editable text. OCR technology comes in many formats. For examples some printers can scan a document and save it as a word document ready to be edited. Most of this applications use underlying OCR engine which can be trained to recognize any character.

OCR can be a relevant technology in Tigrinya Language. To name some of the use cases:
* There are a lot of Tigrinya Books written long time ago. Usually the best Tigrinya books that have a lot of cultural and historical relevance are older books. OCR can help in making this books available for wider audience and it will make it possible to search though the text
* At a bigger picture, we can think about all the documents and legal papers stored at government offices, municipalities and other institutes in our country. OCR can be a good asset to digitize these documents and save them from degradation. Make services easy by organizing them digitally
* OCR can also contribute to the development of Tigrinya Corpus. Making more Tigrinya resources available for researchers and Tigrinya scholars will help speed up the process and narrow the technology gap.

### Tesseract
There are several OCR engines. A notable and Unicode freely application we found is called [Tesseract](https://github.com/tesseract-ocr/tesseract) by Google. Google has made their OCR engine available in the open source community for anyone to use and customize.  It is a good candidate we can rely for Tigrinya OCR. Tesseract has basic support for language with Geez script (including Tigrinya), however for accurate recognition, one has to train the application with enough test samples. As said earlier, availability of good corpus can improve the results, but even without one, Tesseract can produce a descent output, especially if it is well trained and uses clear and good scanned document with common Geez fonts.

In our github project [Tigrinya Tasseract OCR](https://github.com/TigrinyaNLP/Tigrinya-tasseract-ocr) we are aiming to provide enough training resources for Tesseract, to improve the recognition accuracy of Tigrinya documents.