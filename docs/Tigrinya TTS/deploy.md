---
layout: default
title: Tigrinya TTS Deployment
parent: Tigrinya TTS
nav_order: 3
---
# Tigrinya TTS with Piper
---
Once we have the onnx model exported we can use it locally on a command line as follows
```
cat test.txt | piper -m train-ti/tigrinya.onnx --output output/b.wav
```
Save your Tigrinya text document in test.txt and run piper as above. 

# Web based inferer

Piper is mainly made for an offline application to be installed on local device. Usually Audio synthesis takes from few seconds to minutes, 
depending on the size of the text. Nevertheless, it can also run as a webserver on a remote server, using the builtin httpserver.

use this Dockerfile to create an inferer image and deploy it on a host that can be accessible via http.

```
FROM pytorch/torchserve:latest-cpu

RUN apt-get update && apt-get install -y apt-transport-https git python3.9 python3.9-venv espeak-ng 
RUN  apt-get install -y python3-pip  

RUN pip install --upgrade pip

RUN git clone https://github.com/rhasspy/piper.git

# copy model artifacts, custom handler and other dependencies
COPY ./model/tiPiper.onnx /home/model-server/
COPY ./model/config.json /home/model-server/config.json
COPY ./model/config.json /home/model-server/tiPiper.onnx.json
RUN rm -rf /home/venv/lib/python3.9/site-packages/piper_phonemize/espeak-ng-data
COPY ./model/espeak-ng-data.tgz /home/model-server/ 
RUN tar -xf /home/model-server/espeak-ng-data.tgz -C /home/venv/lib/python3.9/site-packages/piper_phonemize/ 
RUN rm -rf  /home/model-server/espeak-ng-data.tgz 
WORKDIR "/home/model-server/piper/src/python_run"
RUN pip3 install -r requirements.txt
RUN pip3 install -r requirements_http.txt


# expose health and prediction listener ports from the image
EXPOSE 5000 

CMD ["python3", \
"-m", \
"piper.http_server", \
"--model", \
"/home/model-server/tiPiper.onnx"]
```
# Test web server

[Lomitec TTS](https://www.lomitec.com/audio.php)