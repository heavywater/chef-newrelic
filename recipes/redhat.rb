if node[:kernel][:machine] == "x86_64"
  machine = "x86_64"
else
  machine = "i386"
end

execute "yum -q makecache" do
  action :nothing
end

execute "add newrelic repository" do
  command "rpm -Uvh http://yum.newrelic.com/pub/newrelic/el5/#{machine}/newrelic-repo-5-3.noarch.rpm"
  creates "/etc/yum.repos.d/newrelic.repo"
  notifies :run, "execute[yum -q makecache]", :immediately
end

package "newrelic-sysmond" do
  action :upgrade
end
