#
# Cookbook Name:: newrelic
# Recipe:: default
#
# Copyright 2011, Heavy Water Software Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

case node[:platform]
when "ubuntu", "debian"
  include_recipe "newrelic::debian"
when "redhat", "centos"
  include_recipe "newrelic::redhat"
end

directory "/var/run/newrelic" do
  owner "newrelic"
  group "newrelic"
end

template "/etc/newrelic/nrsysmond.cfg" do
  source "nrsysmond.cfg.erb"
  owner "root"
  group "newrelic"
  mode "644"
  variables( :license_key => node[:newrelic][:license_key],
             :hostname => node[:fqdn] )
  notifies( :restart, "service[newrelic-sysmond]" ) if node[:newrelic][:enabled]
end

service "newrelic-sysmond" do
  supports :status => true, :restart => true, :reload => true
  if node[:newrelic][:enabled]
    action [ :enable, :start ]
  else
    action [ :disable, :stop ]
  end
end
