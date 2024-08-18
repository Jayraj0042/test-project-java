FROM openjdk:17
ADD jarstaging/com/example/test-project/0.0.4/test-project-0.0.4.jar test-project.jar
ENTRYPOINT ["java", "-jar", "test-project.jar"]