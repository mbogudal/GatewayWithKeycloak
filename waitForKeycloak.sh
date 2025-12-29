#!/bin/sh

KEYCLOAK_URL="http://keycloak:8081/realms/master"

until curl -s $KEYCLOAK_URL > /dev/null; do
    echo "$(date) - Keycloak not ready yet, retrying..."
    sleep 5
done

echo "$(date) - Keycloak is up! Starting gateway..."

java -jar /target/GatewayWithKeycloak-0.0.1-SNAPSHOT.jar
