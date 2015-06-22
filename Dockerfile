# This file creates a container that runs SSH services and XiVO (by Avencall)
# Author: Florian Dufour
# Date: 22/06/2015


FROM debian:8.0
MAINTAINER Florian Dufour "flodelo69@gmail.com"

RUN while ! apt-get update ; do echo "Erreur on recommence" ; done
RUN while ! apt-get install zsh ncurses-term git -y ; do echo "Erreur on recommence" ; done
RUN while ! apt-get upgrade -y ; do echo "Erreur on recommence" ; done
RUN while ! apt-get dist-upgrade -y ; do echo "Erreur on recommence" ; done

RUN apt-get update -y
RUN apt-get upgrade -y

# Installing the environment required
RUN apt-get install -y openssh-server vim nano tar sudo cron wget screen locales  --fix-missing

# Set the env variable DEBIAN_FRONTEND to noninteractive
ENV DEBIAN_FRONTEND noninteractive

# Installing XiVO
RUN wget http://mirror.xivo.io/fai/xivo-migration/xivo_install_current.sh
RUN bash xivo_install_current.sh

RUN echo superpass|passwd root –stdin
EXPOSE 22
