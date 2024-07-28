# FROM nginx

# COPY index.html /usr/share/nginx/html/index.html

# EXPOSE 80

FROM openjdk:11
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
RUN javac App.java
CMD ["java", "App"]