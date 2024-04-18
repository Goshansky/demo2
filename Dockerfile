FROM maven AS builder

WORKDIR /build
COPY pom.xml .
COPY src ./src
RUN mvn clean package

FROM openjdk:21

COPY --from=builder /build/target/*.tar app.jar
EXPOSE 8080
CMD["java", "-jar", "app.jar"]