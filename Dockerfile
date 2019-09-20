FROM ubuntu:bionic
LABEL maintainer "tw1nh3ad"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        tzdata \
        curl \
	libavcodec57 \
	libavdevice57 \
	libavformat57 \
	libavutil55 \
	libc6 \
	libjpeg8 \ 
	libmicrohttpd12 \
	libmysqlclient20 \
	libpq5 \
	libsqlite3-0 \
	libswscale4 \
	libwebp6 \
	libwebpmux3 \
	debconf \
	adduser \
	wget \
	ffmpeg \ 
	v4l-utils \
	python-pip \
	python-dev \
	libssl-dev \
	libcurl4-openssl-dev \
	libjpeg-dev \
	software-properties-common \
	vim \
	net-tools \
	python-setuptools \
	gcc

RUN pip install wheel
RUN pip install motioneye
RUN mkdir -p /etc/motioneye
RUN mkdir -p /var/lib/motioneye
RUN pip install --upgrade motioneye

WORKDIR /tmp

# motion 4.2.2
RUN wget --no-check-certificate https://github.com/Motion-Project/motion/releases/download/release-4.2.2/bionic_motion_4.2.2-1_amd64.deb
RUN dpkg -i /tmp/bionic_motion_4.2.2-1_amd64.deb


# motion 4.1.1
#RUN wget --no-check-certificate https://github.com/Motion-Project/motion/releases/download/release-4.1.1/bionic_motion_4.1.1-1_amd64.deb
#RUN dpkg -i /tmp/bionic_motion_4.1.1-1_amd64.deb

RUN apt-get -y remove gcc && \
        apt-get -y autoremove
#        apt-get -y clean


#RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# 20 camera feeds max (by default Motion will use port 8080 and +1 for each camera feed)
EXPOSE 9100-9110


ADD ./start_motion.sh /start_motion.sh
RUN chmod +x /start_motion.sh
CMD [ "/bin/bash", "/start_motion.sh" ]

