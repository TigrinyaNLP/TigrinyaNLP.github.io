---
layout: default
title: Data Collection and Training
parent: Tigrinya Translate
nav_order: 2
---
# Tigrinya Translate : Data Collection and Training
---
* Embedding

* Transformer

Hugging Face is a project with many generic Deep Learning models. One of them is the Seq2Seq based Transformer model. The project is available in
 github. You can clone and prepare the project as follows

```
git clone https://github.com/huggingface/transformers.git
cd transformers/
pip3 install .
cd examples/legacy/seq2seq
pip3 install -r requirements.txt
mkdir cache
mkdir output
```


* Training data

The data we need to train the above neural model is a list of English sentences translated to Tigrinya, sentence by sentence.
Tigrinya Bible is a good example.
you can download it from https://www.geezexperience.com/ai/data.gz and unzip it in the seq2seq direcory above.
 Read hugging face documentation to understand how training data is organized.

 You can run the following command to start the training.
```
python3 finetune_trainer.py \
    --learning_rate=3e-5 \
    --fp16 \
    --do_train --do_eval --do_predict \
    --evaluation_strategy steps \
    --predict_with_generate \
    --n_val 1000 \
    --src_lang "en" \
--tgt_lang "ti" \
--num_train_epochs 400 \
--warmup_steps 20 \
--data_dir "data" \
--output_dir "output" \
--cache_dir "cache" \
--max_source_length 128 \
--max_target_length 128 \
--val_max_target_length 128 \
--test_max_target_length 128 \
--model_name_or_path "Helsinki-NLP/opus-mt-en-ti"
```
Note that training a neural network model like this requires a lot of CPU power. A better computer is, one with a lot of GPU. A best solution
if you do not have such computer is to sign up for AWS account and use P2.xlarge or p2.8xlarge instance. Read https://course.fast.ai/start_aws for more
AWS for AI documentation.

Oce the trainer is done. The final output will be in the 'output' directory
