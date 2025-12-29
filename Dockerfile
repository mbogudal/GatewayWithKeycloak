# 1. Wybieramy obraz bazowy z Javą
FROM eclipse-temurin:23-jdk

# 2. Ustawiamy katalog roboczy w kontenerze
WORKDIR /app

# 3. Kopiujemy pliki Maven
COPY . .

RUN chmod +x ./mvnw
RUN ./mvnw clean compile package

RUN apt-get update && apt-get install -y curl

COPY waitForKeycloak.sh ./waitForKeycloak.sh
RUN chmod +x ./waitForKeycloak.sh
ENTRYPOINT ["./waitForKeycloak.sh"]

#budowanie
# docker build -t gateway:latest .
#sprawdzanie obrazu
# docker images
#uruchamianie
# docker run -e "SPRING_PROFILES_ACTIVE=dev" gateway:latest