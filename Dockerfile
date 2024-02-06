FROM efabless/openlane:2022.07.02_01.38.08 AS efabless

FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y curl wget build-essential git python3-pip  python3.8-venv ca-certificates curl gnupg lsb-release expect libnuma-dev

RUN mkdir -p /opt

# install openlane
RUN cd /opt && git clone https://github.com/The-OpenROAD-Project/OpenLane openlane

# install openroad
# RUN cd /opt && git clone --recursive https://github.com/The-OpenROAD-Project/OpenROAD.git openroad

ENV PDK=sky130B
ENV OPENROAD=/opt/openroad
ENV OPENLANE_ROOT=/opt/openlane
ENV PDK_ROOT=/opt/pdk
ENV PATH="${PATH}:/opt/oss-cad-suite/bin/"

# patch
# ADD DependencyInstaller.sh /opt/openroad/etc/DependencyInstaller.sh

# run
ADD openlane.exp /opt/openlane/openlane.exp
ADD install.sh /install.sh

ARG TARGETOS
ARG TARGETARCH

RUN echo $TARGETOS $TARGETARCH

RUN bash install.sh

ADD install_sv2v.sh /install_sv2v.sh
RUN bash install_sv2v.sh

COPY --from=efabless /build /opt/openroad
