include Opscode::NewRelic

action :notify do

  app = @new_resource.app || @new_resource.name
  newrelic = Opscode::NewRelic::Deploy.new
  newrelic.notify(@new_resource.key, app, @new_resource.failure_ok)
end
