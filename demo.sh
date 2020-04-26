#Check the Content
oc exec -it mongodb-0 -- bash -c "mongo -u debezium -p dbz inventory --eval \"db.customers.find().pretty()\""

#Check the messages in the Topic 
oc exec -c kafka my-cluster-kafka-0 -- /opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic dbserver1.inventory.customers --from-beginning --max-messages 4

#Create data
cat >> data
db.customers.insert([{ _id : NumberLong("1006"), first_name : 'Abd', last_name : 'Raz', email : 'Abd.raz@abd.com' }]);

#Insert the Data
oc exec -it mongodb-0 -- bash -c "mongo -u debezium -p dbz inventory" < data

#Check the new messages in the Topic
oc exec -c kafka my-cluster-kafka-0 -- /opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic dbserver1.inventory.customers --from-beginning --max-messages 5
