
all: clean 

clean:
	find . -name "*.class" -exec rm -rf {} \;
	rm -rf build/*

compile:
	gradle build

jar: compile
	gradle shadowJar

run: jar
	echo Starting Service at:  http://localhost:9090
	java -cp build/libs/starbucks-all.jar api.StarbucksServer

loadtest: 
	echo Starting Load Test on localhost
	java -cp build/libs/starbucks-all.jar:build/classes/test RunLoadTest 5

place-order:
	curl -X POST http://localhost:9090/v1/starbucks/order \
	-d '{ "location": "take-out", "items": [ {"qty":1,"name":"latte","milk":"whole","size":"large"}]}'

cancel-order:
	curl -X DELETE http://localhost:9090/v1/starbucks/order/$o

update-order:
	curl -X PUT http://localhost:9090/v1/starbucks/order \
	-d '{ "location": "dine-in", "items": [ {"qty":1,"name":"latte","milk":"skim","size":"large"}]}'

order-status:
	curl -X GET http://localhost:9090/v1/starbucks/order/$o

pay-for-order:
	curl -X POST http://localhost:9090/v1/starbucks/order/$o/pay
	
