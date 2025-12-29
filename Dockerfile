# 1. Wybieramy obraz bazowy z Javą
FROM maven:3.9.3-eclipse-temurin-23 AS build

# 2. Ustawiamy katalog roboczy w kontenerze
WORKDIR /app

# 3. Kopiujemy pliki Maven
COPY pom.xml .
COPY src ./src

RUN mvn clean compile packages

FROM eclipse-temurin:23-jre

RUN apt-get update && apt-get install -y curl

# 3. Kopiujemy jar do kontenera
COPY target/GatewayWithKeycloak-0.0.1-SNAPSHOT.jar app.jar

COPY waitForKeycloak.sh ./waitForKeycloak.sh
RUN chmod +x ./waitForKeycloak.sh
ENTRYPOINT ["./waitForKeycloak.sh"]

#budowanie
# docker build -t gateway:latest .
#sprawdzanie obrazu
# docker images
#uruchamianie
# docker run -e "SPRING_PROFILES_ACTIVE=dev" gateway:latest