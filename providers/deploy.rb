action :notify do

  require 'httparty'

  class Deploy
    include HTTParty
    format :xml
    base_uri 'rpm.newrelic.com'

    def initialize
    end

    def notify(key, app, failure_ok)

      @options = {
        :headers => { 'x-license-key' => key },
        :body => "deployment[app_name]=#{app}"
      }
      response = self.class.post('/deployments.xml', @options)

      if response.has_key?('errors')
        if failure_ok
          Chef::Log.error("New Relic deploy notification error: #{response['errors']['error']}")
        else
          Chef::Log.error("New Relic deploy notification error: #{response['errors']['error']}")
          raise
        end
      end
    end
  end

  app = @new_resource.app || @new_resource.name
  newrelic = Deploy.new
  newrelic.notify(@new_resource.key, app, @new_resource.failure_ok)
end
