include_recipe "apt"

execute "add newrelic key to gpg" do
  command "gpg --keyserver pgp.mit.edu --homedir /root " +
    "--recv-keys #{node[:newrelic][:key_id]}"
  not_if "gpg --list-keys #{node[:newrelic][:key_id]}"
end

execute "add newrelic key to apt" do
  command "gpg --homedir /root --armor " +
    "--export #{node[:newrelic][:key_id]} | apt-key add -"
  not_if "apt-get key list #{node[:newrelic][:key_id]}"
end

apt_repository "newrelic" do
  uri "http://apt.newrelic.com/debian/"
  distribution "newrelic"
  components [ "non-free" ]
  key node[:newrelic][:key_id]
  action :add
end

package "newrelic-sysmond" do
  options "--allow-unauthenticated"
  action :upgrade
end
