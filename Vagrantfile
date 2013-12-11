# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box     = "centos6.3"
  config.vm.box_url = "https://dl.dropbox.com/u/7225008/Vagrant/CentOS-6.3-x86_64-minimal.box"

$script = <<SCRIPT
yum -y install git perl-CPAN
curl -L http://cpanmin.us | perl - App::cpanminus
cpanm Test::More Test::Exception Moose Time::ParseDate Date::Format
SCRIPT

  config.vm.provision "shell", inline: $script
end
