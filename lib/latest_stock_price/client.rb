require_relative "version"
require_relative "endpoints"

module LatestStockPrice
  class Client
    def initialize(api_key:)
      @api_key = api_key
    end

    def price(symbol)
      Endpoints.price(symbol, @api_key)
    end

    def prices(symbols)
      Endpoints.prices(symbols, @api_key)
    end

    def price_all
      Endpoints.price_all(@api_key)
    end

    def any
      Endpoints.any(@api_key)
    end
  end
end
