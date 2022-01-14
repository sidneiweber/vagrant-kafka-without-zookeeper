# Vagrant Kafka Without Zookeeper

As some of you know, the Kafka project is working to stop using Zookeeper ([KIP-500](https://cwiki.apache.org/confluence/display/KAFKA/KIP-500%3A+Replace+ZooKeeper+with+a+Self-Managed+Metadata+Quorum)). And in current versions we already have a preview of this feature with Apache Kafka Raft. 

## Requisites
- Vagrant

## Running Kafka
```shell
vagrant up
```

Wait for the whole process until you receive the message: `kafka3: Finish instalation`

O cluster Kafka estará disponível com os seguintes endereços:
- 192.168.56.11:9092 (kafka1)
- 192.168.56.12:9092 (kafka2)
- 192.168.56.13:9092 (kafka3)

## Testing
With the kafka cli installed on the host we can issue some commands to the cluster:

```shell
kafka-topics.sh --create --topic topic_test --partitions 5 --replication-factor 1 --bootstrap-server 192.168.56.11:9092,192.168.56.12:9092,192.168.56.13:9092
Created topic topic_test.
```

```shell
kafka-topics.sh --list --bootstrap-server 192.168.56.11:9092,192.168.56.12:9092,192.168.56.13:9092
topic_test
```