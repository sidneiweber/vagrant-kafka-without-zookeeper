#!/bin/bash

sudo apt-get update
sudo apt-get install default-jre -y
sudo apt-get install default-jdk unzip -y
sudo apt-get clean

sudo mkdir -p /opt/kafka
cd /opt/kafka
sudo wget https://dlcdn.apache.org/kafka/3.0.0/kafka_2.12-3.0.0.tgz
sudo tar xvzf kafka_2.12-3.0.0.tgz --strip 1
sudo rm -rf kafka_2.12-3.0.0.tgz

sudo mkdir -p /kafka/logs

sudo chown -R root:root /opt/kafka

sudo cp -r /vagrant/files/kafka.service /etc/systemd/system/kafka.service
sudo cp -r /vagrant/files/server.properties /opt/kafka/config/kraft/server.properties

sudo sed "s/^node.id=1/node.id=$2/g" -i /opt/kafka/config/kraft/server.properties
sudo sed "s/^advertised.listeners=.*/#advertised.listeners=PLAINTEXT:\/\/$1:9092/g" -i /opt/kafka/config/kraft/server.properties
sudo sed "s/^listeners=.*/listeners=PLAINTEXT:\/\/$1:9092,CONTROLLER:\/\/$1:9093/g" -i /opt/kafka/config/kraft/server.properties

uuid=`xxd -u -p /dev/urandom | head --bytes 16 | base64`
sudo /opt/kafka/bin/kafka-storage.sh format -c /opt/kafka/config/kraft/server.properties -t $uuid &> /dev/null
# Sleep format command
sleep 30

sudo sed "s/^cluster.id=.*/cluster.id=kafka-cluster/g" -i /kafka/logs/meta.properties

sudo systemctl daemon-reload

sudo systemctl enable --now kafka

echo "Finish instalation"