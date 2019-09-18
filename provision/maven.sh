#!/bin/bash
wget --no-verbose 'http://mirrors.supportex.net/apache/maven/maven-3/3.6.2/binaries/apache-maven-3.6.2-bin.tar.gz' -O /tmp/apache-maven-3.6.2-bin.tar.gz
sudo mkdir -p /opt/maven/
sudo tar -xf /tmp/apache-maven-3.6.2-bin.tar.gz -C /opt/maven/
sudo update-alternatives --install /usr/bin/mvn mvn /opt/maven/apache-maven-3.6.2/bin/mvn 2000 --slave /usr/bin/mvnDebug mvnDebug /opt/maven/apache-maven-3.6.2/bin/mvnDebug

sudo CREDENTIAL_CORPORATE_ID="$CREDENTIAL_CORPORATE_ID" su $CREDENTIAL_CORPORATE_ID << 'EOF'
mkdir -p ~/.m2/

echo '<settingsSecurity>
    <master></master>
</settingsSecurity>
' > ~/.m2/settings-security.xml

echo '<?xml version="1.0" encoding="UTF-8"?>
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">
    <localRepository></localRepository>
    <interactiveMode>true</interactiveMode>

    <pluginGroups>
    </pluginGroups>

    <proxies>
    </proxies>

    <servers>
        <server>
            <username></username>
            <password></password>
            <id>artifactory</id>
        </server>
    </servers>
    <mirrors>
        <mirror>
            <id>artifactory</id>
            <name>artifactory maven public</name>
            <url>https://<DEPENDENCIES_REPOSITORY></url>
            <mirrorOf>*</mirrorOf>
        </mirror>
    </mirrors>

    <profiles>
        <profile>
            <id>artifactory</id>
            <activation>
                <activeByDefault>true</activeByDefault>
            </activation>
            <repositories>
                <repository>
                    <id>artifactory</id>
                    <url>https://<DEPENDENCIES_REPOSITORY></url>
                    <snapshots>
                        <enabled>true</enabled>
                    </snapshots>
                    <releases>
                        <enabled>true</enabled>
                    </releases>
                </repository>
            </repositories>
            <pluginRepositories>
                <pluginRepository>
                    <id>artifacory</id>
                    <url>https://<DEPENDENCIES_REPOSITORY></url>
                    <snapshots>
                        <enabled>true</enabled>
                    </snapshots>
                    <releases>
                        <enabled>true</enabled>
                    </releases>
                </pluginRepository>
            </pluginRepositories>
        </profile>
    </profiles>
    <activeProfiles>
        <activeProfile>artifactory</activeProfile>
    </activeProfiles>
</settings>
' > ~/.m2/settings.xml
EOF
