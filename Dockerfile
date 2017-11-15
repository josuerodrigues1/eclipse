FROM ubuntu:14.04

ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$M2_HOME/bin:$PATH

RUN sudo apt-get update && apt-get install -y firefox

RUN sudo apt-get install -y software-properties-common 

RUN sudo add-apt-repository ppa:ubuntu-desktop/ubuntu-make -y 
RUN sudo apt update 
RUN sudo apt install -y ubuntu-make
RUN sudo umake ide eclipse-jee /opt/eclipse

RUN sudo add-apt-repository ppa:openjdk-r/ppa -y 
RUN sudo apt-get update
RUN sudo apt-get install -y openjdk-8-jdk

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer

USER developer
ENV HOME /home/developer
#CMD /usr/bin/firefox
CMD /opt/eclipse/eclipse

