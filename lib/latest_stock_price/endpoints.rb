require "net/http"
require "uri"
require "json"

module LatestStockPrice
  class Endpoints
    BASE_URL = "https://latest-stock-price.p.rapidapi.com"

    def self.any(api_key)
      url = URI("#{BASE_URL}/any")
      response = make_request(url, api_key)
      JSON.parse(response.body)
    end

    def self.price(symbol, api_key)
      url = URI("#{BASE_URL}/any?Identifier=#{symbol}")
      response = make_request(url, api_key)
      JSON.parse(response.body)
    end

    def self.prices(symbols, api_key)
      query = symbols.map { |symbol| URI.encode_www_form_component(symbol) }.join("%2C")
      url = URI("#{BASE_URL}/any?Identifier=#{query}")
      response = make_request(url, api_key)
      JSON.parse(response.body)
    end

    def self.price_all(api_key)
      url = URI("#{BASE_URL}/any")
      response = make_request(url, api_key)
      JSON.parse(response.body)
    end

    private

    def self.make_request(url, api_key)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["x-rapidapi-key"] = api_key
      request["x-rapidapi-host"] = "latest-stock-price.p.rapidapi.com"

      http.request(request)
    end
  end
end
