# Please be aware that this local image will not have passwordless connection to environments.
# To verify it, please run python/ansible scripts that do not require passwordless connection to environments.
FROM armdocker.rnd.ericsson.se/dockerhub-ericsson-remote/python:2.7.18-slim-buster

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

RUN apt-get update && \
    apt-get install -y --no-install-recommends openssh-server=1:7.9p1-10+deb10u2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /var/run/sshd

COPY services/ansible/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

RUN /usr/bin/ssh-keygen -A
COPY root_rsa_files/* /root/.ssh/
RUN chmod 600 /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa.pub

RUN useradd lciadm100
COPY lciadm100_rsa_files/* /home/lciadm100/.ssh/
RUN chown lciadm100:lciadm100 /home/lciadm100/.ssh/*
RUN chmod 600 /home/lciadm100/.ssh/id_rsa
RUN chmod 600 /home/lciadm100/.ssh/id_rsa.pub
RUN chown -R lciadm100 /home/lciadm100

RUN mkdir /etc/ansible/ \
  && touch /etc/ansible/hosts \
  && echo "[defaults]" >> /etc/ansible/ansible.cfg \
  && echo "host_key_checking = False" >> /etc/ansible/ansible.cfg

ENV PYTHONPATH=/usr/src/app
RUN echo PYTHONPATH=/usr/src/app >> /etc/environment

EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]

