---
layout: default
title: Deploying
parent: Tigrinya Spelling Checker
nav_order: 3
---
# Deploying LanguageTool for Tigrinya
---
The deployment of LT for Tigrinya located at [spell.tigrinyadictionary.com/v2/languages](https://spell.tigrinyadictionary.com) is 
deplyed as a docker container with the following parameters. Use this page, 
if you like to deploy similar server yourself. 

Once the build phase is complete. maven will create a zip file called languagetool-standalone/target/LanguageTool-5.9-SNAPSHOT.zip
We need to copy and unzip the file inside the docker. See the complete Dockerfile below

```
FROM openjdk:16-slim-buster

# update and install unzip command line
RUN apt-get update && apt-get install -y  unzip && rm -rf /var/lib/apt/lists/*

#add the package to docker and unzip
ADD languagetool-standalone/target/LanguageTool-5.9-SNAPSHOT.zip /LanguageTool-5.9-SNAPSHOT.zip
RUN unzip LanguageTool-5.9-SNAPSHOT.zip && \
    rm LanguageTool-5.9-SNAPSHOT.zip

WORKDIR /LanguageTool-5.9-SNAPSHOT

#get langauge-detector that supports Tigrinya and Tigre (this does not come with LT by default) get it first from
#https://github.com/TigrinyaNLP/language-detector/releases/download/language-detector-0.7/language-detector-0.7.jar
ADD docker/language-detector.jar /LanguageTool-5.9-SNAPSHOT/libs/language-detector.jar

#optional: load Tigrinya and Tigre for performace reason.
ADD docker/language-module.properties /LanguageTool-5.9-SNAPSHOT/META-INF/org/languagetool/language-module.properties
# set maxTextLength=20000 maximum number of characters we can spell check at the time.
ADD docker/languagetool.config /languagetool.config
# java start command
# java -cp languagetool-server.jar  org.languagetool.server.HTTPServer --port 8010 --public --allow-origin '*'
ADD docker/start.sh /start.sh
CMD [ "sh", "/start.sh" ]
USER nobody
EXPOSE 8010
```

The file META-INF/org/languagetool/language-module.properties comes with all languages, but for our deployment we only
limit it to Tigrinya and Tigre as below. The spanish,Catalan and Portuguese are added since they are referred in LT code.
it will not start without these three languages enabled.


```
languageClasses=org.languagetool.language.Spanish,org.languagetool.language.Catalan,org.languagetool.language.Portuguese
languageClasses=org.languagetool.language.Tigrinya
languageClasses=org.languagetool.language.Tigre

```

## User Management
Optionally, it is possible to attach database connection, if you want to allow personal dictionary based on user name and apikey. To do this create a file languagetool.config with the following properties for MySQL based database and add  '--config languagetool.config' at the end of the java process

```
maxTextLength=20000
dbDriver=org.mariadb.jdbc.Driver
dbUsername=languagetool
dbPassword=xxxxx
dbUrl=jdbc:mysql://localhost:3306/languagetool

```
In the database 'languagetool' there should be atleast to tables. Namely 'users' and 'ignore_words'. The users table would contain at minimum user id,email and api_key. While the ignore_word would contain user_id and ignore_word fields. These list all ignored words by that user. This way users can use their email and api_key when interacting with languagetool. LanguageTool does not have a functionality to create users or create api_key. You can use other applications to populate the users table. 

## Docker image
Docker image can be built and run using these commands

```
#build
sudo docker build -t ti-languagetool .
#stop running container if it exists
sudo docker stop tlt
#remove the running container if it exists
sudo docker rm $(sudo docker ps --filter status=exited -q)
#start and expose http port. 
sudo docker run  -d --restart unless-stopped --network=host  --name tlt -p 8010:8010 ti-languagetool:latest

```

If you want your deployment to run on https (instead of http) you will need apache or nginx in-front of LT and setup 
the certificate and forwarding on it. [ref](https://linuxize.com/post/redirect-http-to-https-in-apache/)
