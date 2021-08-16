---
layout: default
title: Data Collection and Training
parent: Tigrinya Translate
nav_order: 2
---
# Data Collection and Training
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
you can download [en_ti-bible](https://www.tigrinyatranslate.com/en_ti-bible.zip), which is formatted for the seq2seq training above.
unzip it examples/legacy/seq2seq directory.   Read hugging face documentation to understand how training data is organized.

 You can run the following command to start the training on transformer version 4.3. Have a look at [Transformer Training documentation](https://huggingface.co/transformers/v4.3.0/main_classes/trainer.html#seq2seqtrainer)
 for upto date commands.
```
python3 finetune_trainer.py
--model_name_or_path "Helsinki-NLP/opus-mt-en-ti"
--data_dir data
--output_dir output
--overwrite_output_dir
--do_train --n_train 500
--num_train_epochs 1
--per_device_train_batch_size 1
--freeze_embeds
--src_lang en
--tgt_lang ti
--task translation
```
Note that training a neural network model like this requires a lot of GPU/CPU power. A better computer is, a one with a lot of GPU.
If you do not have fast computer you can sign up for AWS account and use P2.xlarge or p2.8xlarge instance.
Read [running in AWS](https://course.fast.ai/start_aws) for more documentation.

Once the trainer is done. The final output will be in the 'output' directory. The trainer will store intermidate results called check-point in the 'output' directory.
 If the process got interrupted, you can continue by
changing --model_name_or_path parameter to one of the check-points in the output directory.

