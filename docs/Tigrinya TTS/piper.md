---
layout: default
title: Tigrinya TTS with Piper
parent: Tigrinya TTS
nav_order: 2
---
# Tigrinya TTS with Piper
---
[Piper](https://github.com/rhasspy/piper) is open source Text-to-Speech synthesizer that supports many languages.
Piper is particularly interesting because it produces good quality sound with smaller training data. This possible,
because piper make use of espeak-ng phonomizer. In addition it can also train any language using any other language
as a base. If you have good definition of the language in espeak-ng.

Piper has a [training guide](https://github.com/rhasspy/piper/blob/master/TRAINING.md) you can follow to train for Tigrinya
or any other language. Here is a Dockerfile we use.

```
FROM nvidia/cuda:12.1.0-runtime-ubuntu20.04
ENV DEBIAN_FRONTEND noninteractive
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apt-get update && apt-get install -y apt-transport-https   git   python3.9 python3.9-venv     espeak-ng 
RUN  apt-get install -y python3-pip  

WORKDIR ".."
RUN git clone https://github.com/rhasspy/piper.git
WORKDIR "../piper/src/python" 
RUN python3.9 -m venv .venv
RUN source .venv/bin/activate
RUN sleep 2
RUN .venv/bin/pip3.9  install --upgrade pip
RUN .venv/bin/pip3.9  install --upgrade wheel setuptools 
RUN .venv/bin/pip3.9  install -e .

RUN chmod +x build_monotonic_align.sh

RUN ./build_monotonic_align.sh

#RUN pip install piper_phonomizer

#RUN cp -r ~/espeak-ng ~/piper/src/python/.venv/lib/python3.9/site-packages/piper_phonemize/

RUN echo $'python  -m piper_train.preprocess \
	--language ti  \
	--input-dir ~/data/low/ \
	--output-dir ~/data/train/ \
	--dataset-format ljspeech  \
	--single-speaker \
	--debug \
	--sample-rate 16000' >pre_train.sh

RUN chmod +x pre_train.sh

RUN echo $'python  -m piper_train \
    --dataset-dir ~/data/train/ \
    --accelerator 'gpu' \
    --devices 1 \
    --batch-size 32 \
    --validation-split 0.0 \
    --num-test-examples 0 \
    --max_epochs 10000 \
    --resume_from_checkpoint ~/data/model/english.ckpt \
    --checkpoint-epochs 1 \
    --precision 32 \
    --quality low' > train.sh

RUN chmod +x train.sh
RUN echo $'./pre_train.sh;sleep 5;./train.sh' > start.sh

CMD ["start.sh"]
```

Store your training data in ~/data/ directory. You will need your a [base model]((https://huggingface.co/datasets/rhasspy/piper-checkpoints/resolve/main/en/en_US/lessac/low/epoch%3D2307-step%3D558536.ckpt)),
[espeak-ng-data](https://github.com/TigrinyaNLP/espeak-ng/releases/download/espeak-ng-data-plus-ti_1.0/espeak-ng-data.zip) and training data.

We trained on AWS G5.xlarge the training for 10000 ephos, it took 3 days (about $150). On a gaming machine with RTX3080 and 12GB ram GPU, it takes 6 weeks.

# Testing model
First install piper phonemizer command line
```
wget https://github.com/rhasspy/piper-phonemize/releases/download/2023.11.14-4/piper-phonemize_linux_x86_64.tar.gz 
tar -xvf piper-phonemize_linux_x86_64.tar.gz
export LD_LIBRARY_PATH=/usr/share/piper_phonemize/lib::$LD_LIBRARY_PATH
```

Use these commands to generate audio while the model is being trained
```
echo "ናብ ውሽጢ ቤት መደቀሲኣ ተቓላጢፋ።" | piper_phonemize -l ti \ 
    --espeak-data $ESPEAK_NG_DATA --allow_missing_phonemes | python3.9 \
    -m piper_train.infer \ 
    --sample-rate 22050 --checkpoint $TRAIN/lightning_logs/version_0/checkpoints/*.ckpt \
    --output-dir $OUTPUT
```

TODO (piper_train.infer requires piper python environment outside docker). Work around convert to onnx 

# Export
```
python3.9 -m piper_train.export_onnx \
            train-ti/lightning_logs/version_0/checkpoints/epoch=3015-step=875444.ckpt \
            train-ti/tiPiper.onnx
```
