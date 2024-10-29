# Builder
FROM maven:3.8.6-openjdk-11 AS builder  
COPY . /root/app/
WORKDIR /root/app


RUN chmod +x mvnw

# Executa o Maven para compilar o projeto
RUN ./mvnw clean install -DskipTests


FROM openlegacy/graalvm-ce:latest AS application
COPY --from=builder /root/app/target/*.jar /home/app/app.jar  # Copia o JAR gerado
WORKDIR /home/app
RUN chmod +x /home/app/app.jar  
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]  