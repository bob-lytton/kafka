# Start zookeeper service
if [ $1 == "zookeeper" ] 
then
	echo bin/zookeeper-server-start.sh config/zookeeper.properties
	bin/zookeeper-server-start.sh config/zookeeper.properties
fi

# Start kafka broker service
if [ $1 == "server-start" ] 
then
	echo bin/kafka-server-start.sh config/server.properties
	bin/kafka-server-start.sh config/server.properties
fi

# Create a topic
BOOTSTRAP_SERVER=localhost:9092
TOPIC_NAME=quickstart-events
if [ $1 == "topic" ] 
then
	echo Creating topics
	echo bin/kafka-topics.sh --create --topic ${TOPIC_NAME} --bootstrap-server ${BOOTSTRAP_SERVER}
	bin/kafka-topics.sh --create --topic ${TOPIC_NAME} --bootstrap-server ${BOOTSTRAP_SERVER}
fi

# Run producer performace
if [ $1 == "perf" ] 
then
	echo bin/kafka-run-class.sh org.apache.kafka.tools.ProducerPerformance ${TOPIC_NAME} 50000000 100 -1 acks=1 bootstrap.servers=esv4-hcl198.grid.linkedin.com:9092 buffer.memory=67108864 batch.size=8196
	bin/kafka-run-class.sh org.apache.kafka.tools.ProducerPerformance --topic ${TOPIC_NAME} --num-records 50000000 --record-size 100 --throughput -1 --producer-props acks=1 bootstrap.servers=${BOOTSTRAP_SERVER} buffer.memory=67108864 batch.size=8196
fi

