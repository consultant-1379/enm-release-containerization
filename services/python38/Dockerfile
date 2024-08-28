# Please be aware that this local image will not have passwordless connection to environments.
# To verify it, please run python scripts that do not require passwordless connection to environments.
FROM armdocker.rnd.ericsson.se/dockerhub-ericsson-remote/python:3.8.6-slim-buster

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

# hadolint ignore=DL3015
RUN apt-get update && \
    apt-get install -y --no-install-recommends openssh-server=1:7.9p1-10+deb10u2 && \
    apt-get install -y gcc=4:8.3.0-1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /var/run/sshd

RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN echo "root:shroot" | chpasswd

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

RUN useradd -u 1001 lciadm100

RUN chown lciadm100:lciadm100 /etc/ssh/*

ENV PYTHONPATH=/usr/src/app
RUN echo PYTHONPATH=/usr/src/app >> /etc/environment

EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]
