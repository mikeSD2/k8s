FROM maven:3.8.5-openjdk-17 as maven_build
WORKDIR /application
COPY . /application
RUN mvn -f /application/pom.xml clean package
FROM openjdk:17
EXPOSE 8080
COPY --from=maven_build /application/target/*.jar app.jar
ENTRYPOINT ["java","-jar","app.jar"]