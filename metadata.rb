maintainer       "Heavy Water Software Inc."
maintainer_email "ops@heavywater.ca"
license          "Apache 2.0"
name             "chef-newrelic"
description      "Installs/Configures newrelic"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.2.6"

supports "ubuntu"
supports "debian"
supports "centos"
supports "redhat"
supports "fedora"

depends "apt"
