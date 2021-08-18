---
layout: default
title: Running (Inference)
parent: Tigrinya Translate
nav_order: 3
---
# Running the model for Inference
---
Running a trained model for inference is also CPU intensive process. Specially if it is supposed to work for multiple users at the same time.
A best solution is to run it in Google Cloud as a docker container with auto scaling. 

Signing up for Google Cloud does require payment information, but it is free for the first $300. You can do a lot without a payment.
More information on this is available at
https://cloud.google.com/ai-platform/training/docs/getting-started-pytorch

Google Cloud Platform has built in cloudshell in a browser. run the following commands to build GCP model and deploy the docker image
```
gcloud beta artifacts repositories create en-ti-repo  --repository-format=docker --location=europe-west1
docker build  --tag=europe-west1-docker.pkg.dev/my-translate/en-ti-repo/serve-en-ti .
docker push europe-west1-docker.pkg.dev/my-translate/en-ti-repo/serve-en-ti
#login
#gcloud auth configure-docker europe-west1-docker.pkg.dev
#create model
gcloud beta ai-platform models create enTiModel --region=europe-west1 --enable-logging  --enable-console-logging
#create version
gcloud beta ai-platform versions create v1   --region=europe-west1   --model=enTiModel   --machine-type=n1-highcpu-8   --image=europe-west1-docker.pkg.dev/my-translate/en-ti-repo/serve-en-ti   --ports=8080   --health-route=/ping   --predict-route=/predictions/en-ti
gcloud beta ai-platform versions create v1   --region=europe-west1   --model=enTiModel   --machine-type=n1-highcpu-8   --image=europe-west1-docker.pkg.dev/my-translate/en-ti-repo/serve-en-ti   --ports=8080   --health-route=/ping   --predict-route=/predictions/en-ti --accelerator=1,nvidia-tesla-k80
#test
#curl -X POST   -H "Authorization: Bearer $(gcloud auth print-access-token)"   -H "Content-Type: application/json; charset=utf-8"   -d @instances.json   https://europe-west1-ml.googleapis.com/v1/projects/my-translate/models/enTiModel/versions/v1:predict
```