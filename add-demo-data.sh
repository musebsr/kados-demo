#!/bin/bash

URL="http://127.0.0.1:3000"

i=0
while true
do
    curl -s $URL/users 2>&1 >> /dev/null && break
    sleep 1
    i=$((i+1))
    if [ $i == 10 ];
    then
        echo "service is not responding, exiting..."
        exit 1
    fi
done

echo ""
echo "-----------------"
echo "Adding users"
echo "-----------------"
echo ""
curl --header "Accept: application/json" --header "Content-type: application/json" --request POST $URL/users --data '{"username":"user1","password":"xxx","log":true}'

# TODO: insert announcements and questions thought the REST API when it's implemented.
echo ""
echo "------------------"
echo "Apply data fixture"
echo "------------------"
echo ""
docker-compose exec postgres psql -U postgres kobra -f fixture.sql
