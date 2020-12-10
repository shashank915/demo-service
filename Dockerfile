FROM maven:3.5-jdk-8-alpine as builder
WORKDIR /app
COPY ./pom.xml /app/pom.xml
RUN mvn dependency:go-offline -B
COPY . /app
RUN mvn clean package
FROM openjdk:8-jre-alpine
COPY --from=builder /app/07804ce4ea088929c3dbf27d6f94fc25.der 07804ce4ea088929c3dbf27d6f94fc25.der
COPY --from=builder /app/target/demo-service.jar app.jar
ENTRYPOINT ["java","-jar","app.jar"]