FROM ubuntu:18.04
LABEL maintainer="karol@chlasta.pl, psochaczewski@wp.pl"
ENTRYPOINT ["/bin/bash"]
SHELL ["/bin/bash", "-c"]
ARG DEBIAN_FRONTEND=noninteractive

# To do - zmiana 'nsp-ser' na 'nsp-server'
COPY . /usr/local/nsp-server
RUN echo "Start "
RUN ls -ltr /usr/local/nsp-server
RUN ls -ltr /usr/local/nsp-server/genesis-2.4
RUN startTime=`date`
RUN ls -ltr 
RUN mv /usr/local/nsp-server/genesis-2.4 /usr/local/genesis-2.4
RUN ls -ltr /usr/local/nsp-server
RUN ls -ltr /usr/local/genesis-2.4
WORKDIR "/usr/local/nsp-server/"
RUN echo "IMAGE_VER=2.0" > image_version.txt
RUN rm -fr ./node_modules
RUN apt update
RUN apt-get --yes install apt-utils
RUN apt-get --yes install vim
RUN apt install make
RUN apt --yes install gcc
RUN apt --yes install bison flex libncurses5-dev libxt-dev
# System Info tools 
RUN export DEBIAN_FRONTEND=noninteractive
RUN  apt-get --yes install lshw
RUN  apt-get --yes install inetutils-ping
RUN apt-get --yes install smem
# tools
RUN apt-get --yes install htop
RUN apt-get --yes install iproute2
RUN apt-get --yes install curl
RUN apt-get --yes install unzip
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install
# RUN uvicorn --version
# RUN uvicorn example:app --reload
RUN curl -sL https://deb.nodesource.com/setup_10.x
RUN apt-get --yes install npm
RUN apt-get --yes install nodejs
RUN npm install express
RUN npm install hbs
RUN npm install nodemon -g
#RUN npm install aws-sdk
#RUN npm install uuid
# nengo
#RUN apt-get -yes install python3-pip

WORKDIR "/usr/local/genesis-2.4/genesis/src"
RUN pwd
RUN ls -ltr 
#RUN chmod 775 /usr/local/genesis-2.4/pgenesis/lib/Linux/libsh
RUN chmod 775 /usr/local/genesis-2.4/genesis/src/libsh
RUN chmod 775 /usr/local/genesis-2.4/genesis/src/configure
RUN chmod 775 /usr/local/genesis-2.4/genesis/src/startup/configrc
RUN chmod 775  /usr/local/genesis-2.4/genesis/src/configure
RUN chmod 775 /usr/local/genesis-2.4/genesis/src/diskio/interface/netcdf/netcdf-3.4/src/configure
RUN ./configure --prefix=/usr/local/genesis-2.4/genesis
RUN ls -ltr /usr/local/genesis-2.4/genesis/src/diskio/interface/netcdf/
RUN make nxgenesis | tee nxmake.out
RUN make nxinstall | tee nxinstall.out
RUN make nxinstall
WORKDIR "/root"
RUN export PATH=$PATH:/usr/local/genesis-2.4/genesis:/usr/local/genesis-2.4/pgenesis/bin:/usr/local/nsp-server/src/sh
RUN cp /usr/local/genesis-2.4/genesis/startup/.simrc .
RUN echo 'export PATH=$PATH:/usr/local/genesis-2.4/genesis:/usr/local/genesis-2.4/pgenesis/bin:/usr/local/nsp-server/src/sh' >> .bashrc
#PGENESIS
WORKDIR "/usr/local/genesis-2.4/pgenesis"
RUN cp /usr/local/nsp-server/src/Makefile /usr/local/genesis-2.4/pgenesis/Makefile
RUN apt-get --yes install csh g++ libxt-dev libxt6 libxtst6 libxtst-dev libxmu-dev
RUN apt-get --yes install mpich
RUN export LD_LIBRARY_PATH=/usr/lib/mpich/lib
#RUN ./configure --prefix=/usr/local/genesis-2.4/pgenesis
RUN chmod 775 /usr/local/genesis-2.4/pgenesis/src/startup/configrc
RUN make clean > make.out
RUN make nxinstall | tee nxinstall.out
RUN cp /usr/local/genesis-2.4/pgenesis/startup/.nxpsimrc ~/

RUN echo 'StartOfTheProcess:' $startTime
RUN echo 'EndOfTheProcess: '`date`
WORKDIR "/usr/local/nsp-server"

#CMD node index.js
RUN npm ls
RUN npm -v
RUN node -v

EXPOSE 3000
HEALTHCHECK --interval=10s --timeout=3s \
  CMD curl -f -s http://localhost:3000/health/ || exit 1
ENTRYPOINT ["bash","/usr/local/nsp-server/start.sh"]
