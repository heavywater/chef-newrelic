module Opscode
  module NewRelic
    require 'httparty'

    class Deploy
      include HTTParty
      format :xml
      base_uri 'rpm.newrelic.com'

      def initialize
      end

      def notify(key, app)

        @options = {
          :headers => { 'x-license-key' => key },
          :body => "deployment[app_name]=#{app}"
        }
        response = self.class.post('/deployments.xml', @options)

        if response.has_key?('errors')
          Chef::Log.error("New Relic deploy notification error: #{response['errors']['error']}")
          raise
        end

      end
    end
  end
end
