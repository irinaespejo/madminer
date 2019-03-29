#docker image that contains madminer and root
FROM rootproject/root-ubuntu16:6.12

USER root

#user for Binder
ARG NB_USER=theuser
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

#regular software
RUN apt-get update && apt-get install -y python3-pip python python-pip python3-tk python-tk

RUN pip install --upgrade pip

#for Binder
RUN pip install --no-cache-dir notebook==5.*

#madminer
RUN pip install madminer --upgrade  

#permission theuser
# Make sure the contents of our repo are in ${HOME}

RUN chown -R ${NB_UID} ${HOME}

USER ${NB_USER}

WORKDIR $HOME
