## intersystems-iris-docker-rest-template
This is a template for for a REST API application with  ObjectScript using Docker container for InterSystems IRIS
The template goes also with a few files which let you immedietly compile your ObjecScript files in InterSystems IRIS Community Edition in a docker container

## Prerequisites
This needs to have git and docker installed.

## Installation 

Clone/git pull the repo into any local directory

```
$ git clone https://github.com/your-repository.git
```

Open the terminal in this directory and run:

```
$ docker-compose up -d --build
```

or build the container with web-terminal installed from ZPM:

```
docker-compose -f "docker-compose-zpm-webterminal.yml" up -d --build
```

## How to Work With it

This template creates /person REST web-application on IRIS which implements 4 types of communication: GET, POST, PUT and DELETE aka CRUD operations.
These interface works with a sample persistent class Sample.Person.

# Testing GET requests

To test GET you need to have some data. You can create it with POST request (see below), or you can create some fake testing data. to do that open IRIS terminal or web terminal on /localhost:52773/terminal/  and call:

```
USER>do ##class(Sample.Person).AddTestData(10)
```
This will create 10 random records in Sample.Person class.

This REST API exposes two GET requests: all the data and one record.
To get all the data in JSON call:

```
localhost:52773/person/all
```

To request the data for a particular record provide the id in GET request like 'localhost:52773/person/id' . E.g.:

```
localhost:52773/person/1
```

This will return JSON data for the person with ID=1, something like that:

```
{"Name":"Elon Mask","Title":"CEO","Company":"Tesla","Phone":"123-123-1233","DOB":"1982-01-19"}
```

# Testing POST request

Create a POST request e.g. in Postman with raw data in JSON. e.g.

```
{"Name":"Elon Mask","Title":"CEO","Company":"Tesla","Phone":"123-123-1233","DOB":"1982-01-19"}
```

Adjust the authorisation if needed - it is basic for container with default login and password for IRIR Community edition container

and send the POST request to localhost:52773/person/

This will create a record in Sample.Person class of IRIS.

# Testing PUT request

PUT request could be used to update the records. This needs to send the similar JSON as in POST request above supplying the id of the updated record in URL.
E.g. we want to change the record with id=5. Prepare in Postman the JSON in raw like following:

```
{"Name":"Jeff Besos","Title":"CEO","Company":"Amazon","Phone":"123-123-1233","DOB":"1982-01-19"}
```

and send the put request to:
```
localhost:52773/person/5
```

# Testing DELETE request

For delete request this REST API expects only the id of the record to delete. E.g. if the id=5 the following DELETE call will delete the record:

```
localhost:52773/person/5
```

## How to start coding
This repository is ready to code in VSCode with ObjectScript plugin.
Install [VSCode](https://code.visualstudio.com/) and [ObjectScript](https://marketplace.visualstudio.com/items?itemName=daimor.vscode-objectscript) plugin and open the folder in VSCode.
Open /src/cls/PackageSample/ObjectScript.cls class and try to make changes - it will be compiled in running IRIS docker container.

Feel free to delete PackageSample folder and place your ObjectScript classes in a form
/src/cls/Package/Classname.cls

The script in Installer.cls will import everything you place under /src/cls into IRIS.

## What's insde the repo

# Dockerfile

The simplest dockerfile to start IRIS and load ObjectScript from /src/cls folder
Use the related docker-compose.yml to easily setup additional parametes like port number and where you map keys and host folders.

# Dockerfile-zpm

Dockerfile-zpm builds for you a container which contains ZPM package manager client so you are able to install packages from ZPM in this container

# Dockerfile-zpm-webterminal
Dockerfile-zpm-webterminal helps to have a container with ZPM and some preloaded ZPM packages, like webterminal


# .vscode/settings.json

Settings file to let you immedietly code in VSCode with [VSCode ObjectScript plugin](https://marketplace.visualstudio.com/items?itemName=daimor.vscode-objectscript))

# .vscode/launch.json
Config file if you want to debug with VSCode ObjectScript
