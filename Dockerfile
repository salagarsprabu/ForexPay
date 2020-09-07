FROM openjdk:8u232-stretch
WORKDIR /opt
RUN apt-get update && apt-get install tar -y
COPY demo_forexpay.tar.gz /opt/
RUN tar -xvzf demo_forexpay.tar.gz
RUN rm -rf demo_forexpay.tar.gz
WORKDIR /opt/demo_forexpay/target
ENTRYPOINT ["java", "-jar"]
CMD ["parking-0.0.1-SNAPSHOT.jar"]
#CMD ["/bin/bash"]
