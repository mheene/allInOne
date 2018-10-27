# allInOne - BufrValidationDashboard with 3 decoders on board

![Build Status](https://api.travis-ci.org/mheene/allInOne.svg?branch=master)

The following Docker Container provides you the BufrValidationDashboard with the 3 BUFR Decoder libECBUFR, Geo::BUFR and BUFRDC on board.

With the help of the BUFR validation dashboard users could now easily check a BUFR with different decoders and receive warnings/errors of each decoder. An online demonstrator is available here

[Online Demonstrator, openshift cloud](http://bufr-allinone.7e14.starter-us-west-2.openshiftapps.com/dashboard/)

![Dashboard](https://raw.githubusercontent.com/mheene/bufrValidationDashboard/master/Servlet-Version/docs/gui.png)

Docker
======
If you have docker installed simply type

`docker run --rm -v "$PWD":/usr/local/bufr: -w /usr/local/bufr --name allinone -p 8080:8080 mheene/allinone`

Now open in a browser the [dashboard](http://localhost:8080)

That's it. The dashboard and decoders run in a tomcat container on your computer on port 8080. Simply klick on the landing page the link for the dashboard or one of the 3 decoders.

If you want to use on the 3 decoders directly, please access the container by

`docker exec -it allinone bash`

You are now inside of the container in the directory /usr/local/bufr which is your working directory where you started the container. So put all your BUFRs into this directory which is accessible from inside of the container.


BUFRDC

`bufr_decode_all -i myBufr.bin | more`

Geo::BUFR

`bufrread.pl --strict_checking 6 --verbose 99 myBufr.bin | more`

libECBUFR

`bufr_decoder -strict -inbufr myBufr.bin  | more`




Perhaps you don't have docker and you simply want to get a glimpse into it. Just try this (Docker account needed - you can create your Docker ID [here](https://hub.docker.com/) ):

[![Try in PWD](https://raw.githubusercontent.com/play-with-docker/stacks/master/assets/images/button.png)](https://labs.play-with-docker.com/?stack=https://raw.githubusercontent.com/mheene/allInOne/master/stack.yml)

It runs docker in your browser and pulls the images and runs the dashboard.


The image is as automated build on [Docker Hub](https://hub.docker.com/)
You can find the image [here](https://hub.docker.com/r/mheene/allinone)

![Docker Build](https://img.shields.io/docker/build/mheene/allinone.svg)
![Docker Pulls](https://img.shields.io/docker/pulls/mheene/allinone.svg)


For details of the dashboard please refer to [bufrValidationDashboard](https://github.com/mheene/bufrValidationDashboard)

Supported Decoders
==================
Currently the following decoders are included into the dashboard:

 * BUFR Tools (DWD) [Online version provided by DWD](https://kunden.dwd.de/bufrviewer)
 * ecCodes (ECMWF) [Online version provided by ECMWF](http://apps.ecmwf.int/codes/bufr/validator/)
 * PyBufrKit (Yang Wang) [Online version provided by Yang](http://aws-bufr-webapp.s3-website-ap-southeast-2.amazonaws.com)
 * TrollBufr (Alex Maul) [Online version provided by Alex](http://flask-bufr-flasked-bufr.193b.starter-ca-central-1.openshiftapps.com) 
 * libECBUFR (Meteorological Service of Canada) [Self created online version](http://bufr-allinone.7e14.starter-us-west-2.openshiftapps.com/libecBufrX)
 * Geo::BUFR (Pål Sannes) [Self created online version](http://bufr-allinone.7e14.starter-us-west-2.openshiftapps.com/geobufr)
 * BUFRDC (ECMWF) [Self created online version](http://bufr-allinone.7e14.starter-us-west-2.openshiftapps.com/bufrdc)



Notes:
======

If you want to run the image on a hosting platform like openshift.com you can set the environment variable

DECODER_URL http://bufr-allinone.7e14.starter-us-west-2.openshiftapps.com

In that case the links of the result page point to your local decoders.

Your feedback is highly welcomed.