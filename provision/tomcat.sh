#!/bin/bash
wget --no-verbose 'https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.34/bin/apache-tomcat-8.5.34.tar.gz' -O /tmp/apache-tomcat-8.5.34.tar.gz
sudo mkdir -p /opt/tomcat/
sudo tar -xf /tmp/apache-tomcat-8.5.34.tar.gz -C /opt/tomcat/
sudo chown "$CREDENTIAL_CORPORATE_ID:$CREDENTIAL_CORPORATE_ID" -R /opt/tomcat/apache-tomcat-8.5.34/
