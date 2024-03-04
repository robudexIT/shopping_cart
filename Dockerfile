# First stage the build_image
FROM openjdk:11 AS BUILD_IMAGE

RUN apt update && apt install maven -y

WORKDIR /app

COPY . . 
RUN mvn install 

FROM tomcat:9-jre11

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=BUILD_IMAGE /app/target/shopping-cart-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8081
CMD ["catalina.sh", "run"]

