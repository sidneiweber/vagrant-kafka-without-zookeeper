Vagrant.configure("2") do |config|

  config.vm.box = "hashicorp/bionic64"

  (1..3).each do |i|
    config.vm.define "kafka#{i}" do |s|
      s.vm.hostname = "kafka#{i}"
      s.vm.network "private_network", ip: "192.168.56.1#{i}"
      s.vm.provision :shell, path: "install.sh", :args => ["192.168.56.1#{i}", "#{i}"]
    end
  end
end
