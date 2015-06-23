# This file creates a container that runs SSH services and XiVO (by Avencall)
# Author: Florian Dufour
# Date: 22/06/2015


FROM debian:7.8
MAINTAINER Florian Dufour "flodelo69@gmail.com"

RUN while ! apt-get update ; do echo "Erreur on recommence" ; done
RUN while ! apt-get upgrade -y ; do echo "Erreur on recommence" ; done

# Installing the environment required
RUN apt-get install -y openssh-server vim nano tar sudo cron wget screen locales  --fix-missing

# Set the env variable DEBIAN_FRONTEND to noninteractive
ENV DEBIAN_FRONTEND noninteractive
ENV LANG fr_FR.UTF-8
ENV HOME /root

# Set password
RUN echo "root:superxivo" | chpasswd

# Installing XiVO
RUN wget http://mirror.xivo.io/fai/xivo-migration/xivo_install_current.sh
RUN bash xivo_install_current.sh

#XiVO Start
RUN xivo-service status
RUN xivo-service start
RUN xivo-service status

#Open Ports
EXPOSE 22 443 5003 5060

