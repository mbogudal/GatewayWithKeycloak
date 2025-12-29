# 1. Wybieramy obraz bazowy z Javą
FROM eclipse-temurin:23-jre

# 2. Ustawiamy katalog roboczy w kontenerze
WORKDIR /app

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