#!/bin/bash
set -xe

# Ensure the 'tomcat' user and group exist
if ! grep -q "^tomcat:" /etc/group; then
    groupadd tomcat
fi

if ! id -u tomcat &>/dev/null; then
    useradd -r -g tomcat tomcat
fi

# Copy war file from S3 bucket to tomcat webapp folder
aws s3 cp s3://githubactions1-webappdeploymentbucket-gujcgvsvm8hh/SpringBootHelloWorldExampleApplication.war /usr/local/tomcat9/webapps/SpringBootHelloWorldExampleApplication.war

# Ensure the ownership permissions are correct
chown -R tomcat:tomcat /usr/local/tomcat9/webapps
