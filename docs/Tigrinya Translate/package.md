---
layout: default
title: Packaging
parent: Tigrinya Translate
nav_order: 3
---
# Packaging
---

The trained model need to be packaged in certain ways to be usable. Save the following python command to package.py

```
from transformers import MarianMTModel, MarianTokenizer
import os

import argparse

parser = argparse.ArgumentParser()
parser.add_argument('--checkpoint', type=str, help='latest checkpoint')
args = parser.parse_args()

NEW_DIR = "./Transformer_model"
os.mkdir(NEW_DIR)
model_name = args.checkpoint
tokenizer = MarianTokenizer.from_pretrained(model_name)
model = MarianMTModel.from_pretrained(model_name )
model.eval()
model.save_pretrained(NEW_DIR)
tokenizer.save_pretrained(NEW_DIR)
```

