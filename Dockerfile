# 1. Wybieramy obraz bazowy z Javą
FROM eclipse-temurin:23-jre

# 2. Ustawiamy katalog roboczy w kontenerze
WORKDIR /app

# 3. Kopiujemy jar do kontenera
COPY target/GatewayWithKeycloak-0.0.1-SNAPSHOT.jar app.jar

# 4. Uruchamiamy aplikację
ENTRYPOINT ["java","-jar","app.jar"]

#budowanie
# docker build -t gateway:latest .
#sprawdzanie obrazu
# docker images
#uruchamianie
# docker run -e "SPRING_PROFILES_ACTIVE=dev" gateway:latest