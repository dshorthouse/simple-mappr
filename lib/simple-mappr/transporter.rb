require "rest_client"
require "json"
require "open-uri"
require "simple-mappr/validator"

class SimpleMappr
  class Transporter

    def self.send_data params
      Validator.validate_type(params, 'Hash')
      params.delete_if{ |k,v| v.nil? }
      begin
        RestClient::Request.execute(method: :post, url: API_URL, payload: params, max_redirects: 0)
      rescue RestClient::ExceptionWithResponse => err
        JSON.parse(err.response.body, :symbolize_names => true)
      end
    end

    def self.ping
      send_data({ ping: true })
    end

  end
end