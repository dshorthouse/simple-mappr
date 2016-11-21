require "rest_client"
require "json"
require "open-uri"
require "simple-mappr/validator"

class SimpleMappr
  class Transporter

    def self.send_data params, download = false
      Validator.validate_type(params, 'Hash')
      params.delete_if{ |k,v| !v }
      RestClient.post(API_URL, params) do |response, request, result, &block|
        if response.code == 303 && download
          response.follow_redirection
        else
          JSON.parse(response.body, :symbolize_names => true)
        end
      end
    end

    def self.ping
      send_data({ ping: true })
    end

  end
end