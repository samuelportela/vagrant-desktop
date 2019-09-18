#!/bin/bash
sudo CREDENTIAL_CORPORATE_ID="$CREDENTIAL_CORPORATE_ID" CREDENTIAL_PASSWORD="$CREDENTIAL_PASSWORD" su $CREDENTIAL_CORPORATE_ID << 'EOF'
sed -i -e "s#\(<master>\).*\(<\/master>\)#<master>$(mvn --encrypt-master-password $CREDENTIAL_PASSWORD)<\/master>#g" ~/.m2/settings-security.xml
sed -i -e "s#\(<localRepository>\).*\(<\/localRepository>\)#<localRepository>\/home\/$CREDENTIAL_CORPORATE_ID\/.m2\/repository\/<\/localRepository>#g" ~/.m2/settings.xml
sed -i -e "s#\(<username>\).*\(<\/username>\)#<username>$CREDENTIAL_CORPORATE_ID<\/username>#g" ~/.m2/settings.xml
sed -i -e "s#\(<password>\).*\(<\/password>\)#<password>$(mvn --encrypt-password $CREDENTIAL_PASSWORD)<\/password>#g" ~/.m2/settings.xml
EOF
