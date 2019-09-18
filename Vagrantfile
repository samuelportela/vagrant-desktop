# -*- mode: ruby -*-
# vi: set ft=ruby :

# Loading Git global variables from host machine
GIT_USER_NAME = "#{`git config --global user.name`}".strip
GIT_USER_EMAIL = "#{`git config --global user.email`}".strip

# Validating Git global variables
if GIT_USER_NAME.empty? || GIT_USER_EMAIL.empty? then
  abort 'Aborting. Please run the following commands to configure Git global variables with your name and e-mail:
    git config --global user.name "Your Name"
    git config --global user.email your@email.com'
end

# Checking if all plugins are installed
required_plugins = %w[vagrant-proxyconf vagrant-ca-certificates vagrant-vbguest vagrant-reload vagrant-disksize]
plugins_to_install = required_plugins.reject { |plugin| Vagrant.has_plugin? plugin }
unless plugins_to_install.empty?
  abort 'Aborting. Please run the following commands to install the required plugins:
    vagrant plugin install vagrant-proxyconf --plugin-version 1.5.2
    vagrant plugin install vagrant-ca-certificates vagrant-vbguest vagrant-reload vagrant-disksize'
end

# Requesting user credential when using "vagrant up" or "vagrant provision" for updating the environment
provision_arguments = ['up', 'provision']
should_provision = ARGV.any? {|argument| provision_arguments.include?(argument)}
if should_provision then
  puts '###########################################################################'
  puts '#  Please inform your your Corporate ID and Password for setting up your  #'
  puts '#  local user and Maven configurations files at ~/.m2/ directory          #'
  puts '###########################################################################'
  print 'Corporate ID: '
  CREDENTIAL_CORPORATE_ID = STDIN.gets.chomp
  # Workaround for hidding the password on Git Bash:
  # 8m is the control code to hide characters
  print "Password: \e[0;8m"
  STDOUT.flush
  CREDENTIAL_PASSWORD = STDIN.gets.chomp
  # 0m is the control code to reset formatting attributes
  puts "\e[0m"
  STDOUT.flush
end

Vagrant.configure('2') do |config|
  config.vm.box = 'debian/stretch64'

  # The disk size only expands, it never shrinks
  DISK_SIZE_IN_GB = 50
  SWAP_SIZE_IN_GB = 4

  config.disksize.size = "#{DISK_SIZE_IN_GB}GB"
  config.vm.host_name = 'bl00030'
  config.vm.network 'forwarded_port', guest: 22, host: 2222, id: 'ssh', auto_correct: true
  config.vm.network 'forwarded_port', guest: 8080, host: 8080, id: 'tomcat', auto_correct: true
  config.vm.box_check_update = false
  
  # After the machine finishes the configuration, "Guest Additions" will be installed. Then you can
  # enable the line below if you want to have a bidirectional directory between host and guest:
  # config.vm.synced_folder './workspace', '/workspace'

  # The configuration below can be used for disabling the default shared folder, which uses "rsync"
  config.vm.synced_folder '.', '/vagrant', disabled: true

  config.vm.provider 'virtualbox' do |vb|
    vb.gui = true
    vb.name = 'vagrant-desktop'
    vb.memory = 4096
    vb.cpus = 2
    vb.customize ['modifyvm', :id, '--vram', '256']
    vb.customize ['modifyvm', :id, '--accelerate2dvideo', 'off']
    vb.customize ['modifyvm', :id, '--accelerate3d', 'on']
    vb.customize ['modifyvm', :id, '--clipboard', 'bidirectional']
    vb.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
    vb.customize ['modifyvm', :id, '--natdnsproxy1', 'on']
  end

  # Configuration for vagrant-proxyconf
  config.proxy.http = 'http://10.0.2.2:3128/'
  config.proxy.https = 'http://10.0.2.2:3128/'
  config.proxy.ftp = 'http://10.0.2.2:3128/'
  config.proxy.no_proxy = 'localhost,127.0.0.1'

  # Configuration for vagrant-ca-certificates
  config.ca_certificates.enabled = true
  config.ca_certificates.certs = [
    'https://<CORPORATE_CERTIFICATE_FILE>',
    'https://<ANOTHER_CORPORATE_CERTIFICATE_FILE>'
  ]

  # Configuration for vagrant-vbguest
  config.vbguest.auto_update = false
  config.vbguest.no_remote = true

  # Installation of additional software
  if should_provision then
    config.vm.provision 'shell', privileged: false, path: 'provision/create-local-user.sh', name: 'create-local-user.sh', env: {CREDENTIAL_CORPORATE_ID: CREDENTIAL_CORPORATE_ID, CREDENTIAL_PASSWORD: CREDENTIAL_PASSWORD}
    config.vm.provision 'shell', privileged: false, path: 'provision/local.sh', name: 'local.sh'
    config.vm.provision 'shell', privileged: false, path: 'provision/base.sh', name: 'base.sh'
    config.vm.provision 'shell', privileged: false, path: 'provision/deb.sh', name: 'deb.sh'
    config.vm.provision 'shell', privileged: false, path: 'provision/git.sh', name: 'git.sh', env: {CREDENTIAL_CORPORATE_ID: CREDENTIAL_CORPORATE_ID, GIT_USER_NAME: GIT_USER_NAME, GIT_USER_EMAIL: GIT_USER_EMAIL}
    config.vm.provision 'shell', privileged: false, path: 'provision/xfce4.sh', name: 'xfce4.sh'
    config.vm.provision 'shell', privileged: false, path: 'provision/apps.sh', name: 'apps.sh'
    config.vm.provision 'shell', privileged: false, path: 'provision/ca-certificates.sh', name: 'ca-certificates.sh', env: {CREDENTIAL_CORPORATE_ID: CREDENTIAL_CORPORATE_ID}
    config.vm.provision 'shell', privileged: false, path: 'provision/google-chrome.sh', name: 'google-chrome.sh'
    config.vm.provision 'shell', privileged: false, path: 'provision/java.sh', name: 'java.sh', env: {CREDENTIAL_CORPORATE_ID: CREDENTIAL_CORPORATE_ID}
    config.vm.provision 'shell', privileged: false, path: 'provision/maven.sh', name: 'maven.sh', env: {CREDENTIAL_CORPORATE_ID: CREDENTIAL_CORPORATE_ID}
    config.vm.provision 'shell', privileged: false, path: 'provision/tomcat.sh', name: 'tomcat.sh', env: {CREDENTIAL_CORPORATE_ID: CREDENTIAL_CORPORATE_ID}
    config.vm.provision 'shell', privileged: false, path: 'provision/idea.sh', name: 'idea.sh', env: {CREDENTIAL_CORPORATE_ID: CREDENTIAL_CORPORATE_ID}
    config.vm.provision 'shell', privileged: false, path: 'provision/postman.sh', name: 'postman.sh'
    config.vm.provision 'shell', privileged: false, path: 'provision/nodejs.sh', name: 'nodejs.sh', env: {CREDENTIAL_CORPORATE_ID: CREDENTIAL_CORPORATE_ID}
    config.vm.provision 'shell', privileged: false, path: 'provision/vscode.sh', name: 'vscode.sh'
    config.vm.provision 'shell', privileged: false, path: 'provision/vim.sh', name: 'vim.sh', env: {CREDENTIAL_CORPORATE_ID: CREDENTIAL_CORPORATE_ID}
    config.vm.provision 'shell', privileged: false, path: 'provision/docker.sh', name: 'docker.sh', env: {CREDENTIAL_CORPORATE_ID: CREDENTIAL_CORPORATE_ID}
    config.vm.provision 'shell', privileged: false, path: 'provision/xfce4-terminal.sh', name: 'xfce4-terminal.sh'
    config.vm.provision 'shell', privileged: false, path: 'provision/xfce4-taskmanager.sh', name: 'xfce4-taskmanager.sh'
    config.vm.provision 'shell', privileged: false, path: 'provision/firefox.sh', name: 'firefox.sh'
    config.vm.provision 'shell', privileged: false, path: 'provision/corkscrew.sh', name: 'corkscrew.sh', env: {CREDENTIAL_CORPORATE_ID: CREDENTIAL_CORPORATE_ID}
    config.vm.provision 'shell', privileged: false, path: 'provision/squirrelsql.sh', name: 'squirrelsql.sh', env: {CREDENTIAL_CORPORATE_ID: CREDENTIAL_CORPORATE_ID}
    config.vm.provision 'shell', privileged: false, path: 'provision/asbru.sh', name: 'asbru.sh'
    config.vm.provision 'shell', privileged: false, path: 'provision/sublime.sh', name: 'sublime.sh'
    config.vm.provision 'shell', privileged: false, path: 'provision/7zip.sh', name: '7zip.sh'
    config.vm.provision 'shell', privileged: false, path: 'provision/meld.sh', name: 'meld.sh'
    config.vm.provision 'shell', privileged: false, path: 'provision/update-local-user.sh', name: 'update-local-user.sh', run: 'always', env: {CREDENTIAL_CORPORATE_ID: CREDENTIAL_CORPORATE_ID, CREDENTIAL_PASSWORD: CREDENTIAL_PASSWORD}
    config.vm.provision 'shell', privileged: false, path: 'provision/update-maven-user.sh', name: 'update-maven-user.sh', run: 'always', env: {CREDENTIAL_CORPORATE_ID: CREDENTIAL_CORPORATE_ID, CREDENTIAL_PASSWORD: CREDENTIAL_PASSWORD}
    config.vm.provision 'shell', privileged: false, path: 'provision/resize-partitions.sh', name: 'resize-partitions.sh', env: {DISK_SIZE_IN_GB: DISK_SIZE_IN_GB, SWAP_SIZE_IN_GB: SWAP_SIZE_IN_GB}
  end

  # Restart the VM after everything is installed
  config.vm.provision :reload
end
