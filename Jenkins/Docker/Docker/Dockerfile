FROM jenkins/jenkins

USER root

# Install Ansible
RUN apt update
#RUN apt-get update -qq \
   # && apt-get install -qqy apt-transport-https ca-certificates curl gnupg2 software-properties-common
RUN apt install -y  python3
RUN curl -O https://bootstrap.pypa.io/get-pip.py
RUN apt install -y python3-pip
RUN rm /usr/lib/python3.11/EXTERNALLY-MANAGED
RUN pip install  ansible --upgrade

# Install Docker

RUN apt-get update && \
apt-get -y install apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common && \
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable" && \
apt-get update && \
apt-get -y install docker-ce


# Install Docker Compose

RUN curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose

RUN usermod -aG docker jenkins

# Install AWS CLI
RUN  apt -y install python3-pip && \
    pip3 install --upgrade pip && \
    pip3 install awscli

COPY backend /opt/backend
RUN aws configure set region eu-north-1
RUN chown 1000:1000 /opt/backend
USER jenkins










