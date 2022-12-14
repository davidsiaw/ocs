FROM ubuntu

RUN apt-get update && apt-get install -y curl wget build-essential git python3-pip  python3.10-venv ca-certificates curl gnupg lsb-release

ADD install.sh /install.sh

ARG TARGETOS
ARG TARGETARCH

RUN echo $TARGETOS $TARGETARCH

ENV PDK_ROOT=/opt/pdk

RUN bash install.sh

ENV PATH="${PATH}:/opt/oss-cad-suite/bin/"
