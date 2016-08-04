require "rest_client"
require "json"
require "open-uri"
require "simple-mappr/validator"

class SimpleMappr
  class Transporter

    def self.send_data params
      Validator.validate_type(params, 'Hash')
      params.delete_if{ |k,v| !v }
      RestClient.post(API_URL, params) do |response, request, result, &block|
        JSON.parse(response.body, :symbolize_names => true)
      end
    end

    def self.ping
      send_data({ ping: true })
    end

  end
end