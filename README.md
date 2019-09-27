# vagrant-desktop

Automated desktop. Easy to use and to maintain.

## What is the purpose?

This project aims to facilitate the creation of a reproducible desktop environment through the automation of installation and configuration steps.

## What are the requirements?

For using this automated desktop, you should first install the following softwares on your host machine:

- [Git BASH](https://gitforwindows.org)
- [Vagrant](https://www.vagrantup.com) (Please use version 2.2.3 instead of 2.2.4, since version 2.2.4 has issues while configuring environment)
- [VirtualBox](https://www.virtualbox.org)

## How to enable VirtualBox on Windows 10?

In case you are using Windows 10, please follow the steps described in one of the options bellow to have VirtualBox working properly:

### Option 1 - Using Registry Editor

1. Run the following command in Windows PowerShell as Administrator:

```bash
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v EnableVirtualizationBasedSecurity /t REG_DWORD /d 0 /f
```

2. Reboot your machine

### Option 2 - Using Device Guard and Credential Guard hardware readiness tool

In case the Option 1 described above does not work for you, please follow the steps below:

1. Create a "C:\development" directory and give "Full control" to your user to that directory (right-click > Properties > Security)
2. Download the [Device Guard and Credential Guard hardware readiness tool](https://www.microsoft.com/en-us/download/details.aspx?id=53337)
3. Decompress "Device Guard and Credential Guard hardware readiness tool" inside "C:\development"
4. Run the following commands in Windows PowerShell as Administrator:

```bash
cd c:\development\dgreadiness_v3.6
.\DG_Readiness_Tool_v3.6.ps1 -Disable
```

5. Now you will have to reboot your machine, but please have in mind that while rebooting it, you will see a first black dialog asking about **Password Guard** (you can press **ESC** to leave it Enabled) and a second black dialog asking about **Virtualization Based Security** (press **F3** to Disable it).

**Regardless of which option above you have followed, in case you need to reboot Windows 10, those steps need to be executed again in order to have VirtualBox working properly.**

## How to connect using a proxy?

To setup your host machine to send the requests through a proxy that requires authentication, first add the following "User variables" to the list of your host environment variables (on Windows 7, go to Start > Control Panel > System > Advanced system settings > Environment Variables... > User variables):

```
https_proxy=http://localhost:3128
http_proxy=http://localhost:3128
ftp_proxy=http://localhost:3128
no_proxy=localhost,127.0.0.1
```

Now, please follow the steps described in one of the options bellow:

### Option 1 - Using Px

1. Make sure no other tool is using 3128 port. For isntance, if you are already using Cntlm, please uninstall it.
2. Download the ZIP package available for [Px](https://github.com/genotrance/px/releases/latest)
3. Run the following commands to setup Px on your host machine:

```
./px --workers=10 --threads=500 --save
./px --install
```

4. Next time you reboot the host machine, Px will be started automatically.

**Next time you change network password, a simple "vagrant up" command will be enough to make all tools inside vagrant-desktop connect through the proxy.**

### Option 2 - Using Cntlm

1. Make sure no other tool is using 3128 port. For isntance, if you are already using Px, please uninstall it.
2. Download [Cntlm](http://cntlm.sourceforge.net)
3. Open some text editor **as Administrator** and paste the content below into "C:\Program Files (x86)\Cntlm\cntlm.ini" **remembering to replace <YOUR_CORPORATE_ID> with your own Corporate ID**:

```
Username        <YOUR_CORPORATE_ID>
Domain          <NETWORK_DOMAIN>
Auth            NTLMv2
PassNTLMv2      <YOUR_NTLMV2_PASSWORD>
Proxy           <PROXY_DNS>:<PROXY_PORT>
NoProxy         localhost, 127.0.0.*, 10.*, <OTHER_ADDRESSES_NOT_REQUIRING_PROXY>
Listen          0.0.0.0:3128
```

4. Open Git Bash (all the commands described in this documentation should be executed using Git Bash). Run the command below to generate the NTLMv2 password (ATTENTION: you will have to type your network password **and the password may be displayed on your screen as it is**):

```bash
/c/Program\ Files\ \(x86\)/Cntlm/cntlm.exe -c /c/Program\ Files\ \(x86\)/Cntlm/cntlm.ini -H
```

5. Copy the output of the command above to the "PassNTLMv2" line of "C:\Program Files (x86)\Cntlm\cntlm.ini" file. Save the file and then restart the service called "Cntlm Authentication Proxy".
6. Next time you reboot the host machine, Cntlm will be started automatically.

**In case you decided to use Cntlm, if you change your network password, please redo the process above to update the password used for authenticating to the proxy.**

## How to prepare?

Run the commands below to create a working directory and convert the combined certificate file:

```bash
cd c:
mkdir -p development
cd development
curl -kL '<CORPORATE_COMBINED_CERTIFICATES_P7B_FILE>' -o combined.p7b
openssl pkcs7 -in combined.p7b -inform DER -print_certs -out cert.pem
```

Using a good text editor (like Sublime or Notepad++) **as Administrator**, copy the content of the converted file (cert.pem) and paste it at the end of the file below (do not use Notepad):

```
C:\HashiCorp\Vagrant\embedded\cacert.pem
```

**ATTENTION: if you uninstall and install again or upgrade Vagrant, this file will be replaced. So you would need to do this again.**

Configure Git global variables with your name and e-mail (**replace the values below**):
```bash
git config --global user.name "Your Name"
git config --global user.email your@email.com
```

If you want to use HTTPS protocol to clone this project, it is possible to avoid SSL checks running the following command:
```bash
git config --global http.sslVerify false
```

If you want to use SSH protocol to clone this project, please generate your SSH private key. See an example below on how to do that with an empty passphrase:
```bash
mkdir -p ~/.ssh/
ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa
```

For using the generated SSH key, copy the content of the public key file and add it to your source code management service (for GitLab, the configuration should be at "Settings > SSH Keys").

```bash
cat ~/.ssh/id_rsa.pub
```

Clone this project and go to the cloned directory:
```bash
cd c:
cd development
git clone git@github.com:samuelportela/vagrant-desktop.git
cd vagrant-desktop
```

Install the required Vagrant plugins:
```bash
vagrant plugin install vagrant-proxyconf --plugin-version 1.5.2
vagrant plugin install vagrant-ca-certificates vagrant-vbguest vagrant-reload vagrant-disksize
```

## How to run?

```bash
vagrant up
```

The first time the automated desktop is created, it will take a few minutes to provision all the softwares.

## How to stop?

```bash
vagrant halt
```

## What if the automated desktop is not working anymore?

Simply destroy it and create it again:

```bash
vagrant destroy
vagrant up
```

## How do I update the vagrant-desktop with the latest changes?

In case you want to keep your environment up with the latest changes made, you can synchronize your vagrant-desktop following the steps below:

1. Pull the latest changes from vagrant-dektop master branch
2. Shut down the vagran-desktop
3. Run the following command on Git Bash:

```bash
vagrant up --provision
```

## What if I use some application that need Proxy or Certificate configuration?

- For **proxy** setup, configure your application to use the proxy application that has already been configured in your host machine by pointing it to host **10.0.2.2** and port **3128**.
- For **certificates** setup, import the ca-certificates (Authorities) located under the **~/ca-certificates** directory.

## How to setup IntelliJ?

When running IntelliJ for the first time, you have to configure the proxy, activate it and setup Maven path. For the activation method, choose the option "License server" and set the following "License server address":

```
http://<CORPORATE_LICENSE_SERVER_ADDRESS>
```

Configure the Maven path on IntelliJ through "Configure > Settings" (or "File > Settings") and then "Build, Execution, Deployment > Build Tools > Maven", setting the "Maven home directory" field to:

```
/opt/maven/apache-maven-3.6.0
```

## Additional notes

- When this automated desktop is created, it generates its own SSH key (different from the host machine). So, if you want to clone other Git projects inside this environment, please remember to copy the content of the public key file **located in your automated desktop** and add it to your source code management service:

```bash
cat ~/.ssh/id_rsa.pub
```
