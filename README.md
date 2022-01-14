# Vagrant Kafka Without Zookeeper

As some of you know, the Kafka project is working to stop using Zookeeper ([KIP-500](https://cwiki.apache.org/confluence/display/KAFKA/KIP-500%3A+Replace+ZooKeeper+with+a+Self-Managed+Metadata+Quorum)). And in current versions we already have a preview of this feature with Apache Kafka Raft. 

![Kafka Kraft](https://images.contentful.com/gt6dp23g0g38/5ssqb8kUN6Lq5lR1EZdCX1/2a28415f8718dfec9edc345d9914dfec/new-quorum-controller-1536x817.png)

## Requisites
- Vagrant

## Running Kafka
```shell
vagrant up
```

Wait for the whole process until you receive the message: `kafka3: Finish instalation`

The Kafka cluster will be available with the following addresses:
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