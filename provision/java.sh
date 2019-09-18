#!/bin/bash
wget --no-verbose --no-check-certificate --no-cookies --header 'Cookie: oraclelicense=accept-securebackup-cookie' 'http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz' -O /tmp/jdk-8u131-linux-x64.tar.gz
sudo mkdir -p /opt/jdk/
sudo tar -xf /tmp/jdk-8u131-linux-x64.tar.gz -C /opt/jdk/
sudo update-alternatives --install /usr/bin/java java /opt/jdk/jdk1.8.0_131/bin/java 2000
sudo update-alternatives --install /usr/bin/javac javac /opt/jdk/jdk1.8.0_131/bin/javac 2000

echo Importing JAVA certificates...
sudo /opt/jdk/jdk1.8.0_131/jre/bin/keytool -import -trustcacerts -keystore /opt/jdk/jdk1.8.0_131/jre/lib/security/cacerts -alias "<ALIAS_FOR_CORPORATE_CERTIFICATE_FILE>" -file /home/$CREDENTIAL_CORPORATE_ID/ca-certificates/<CORPORATE_CERTIFICATE_FILE> -storepass changeit -noprompt
sudo /opt/jdk/jdk1.8.0_131/jre/bin/keytool -import -trustcacerts -keystore /opt/jdk/jdk1.8.0_131/jre/lib/security/cacerts -alias "<ALIAS_FOR_ANOTHER_CORPORATE_CERTIFICATE_FILE>" -file /home/$CREDENTIAL_CORPORATE_ID/ca-certificates/<ANOTHER_CORPORATE_CERTIFICATE_FILE> -storepass changeit -noprompt
echo Finished importing JAVA certificates

cd /tmp
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" -O jce_policy-8.zip http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip
unzip jce_policy-8.zip
cd UnlimitedJCEPolicyJDK8
sudo cp local_policy.jar /opt/jdk/jdk1.8.0_131/jre/lib/security/
sudo cp US_export_policy.jar /opt/jdk/jdk1.8.0_131/jre/lib/security/

exit 0
