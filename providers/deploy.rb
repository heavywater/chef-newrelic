include Opscode::NewRelic

action :notify do
  newrelic = Opscode::NewRelic::Deploy.new
  newrelic.notify(@new_resource.key, @new_resource.app)
end
