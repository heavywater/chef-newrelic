include_recipe "apt"

apt_repository "newrelic" do
  uri "http://apt.newrelic.com/debian/"
  distribution "newrelic"
  components [ "non-free" ]
  action :add
end

package "newrelic-sysmond" do
  options "--allow-unauthenticated"
end
