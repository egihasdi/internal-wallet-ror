require "minitest/autorun"

require_relative "latest_stock_price/client"

class LatestStockPriceTest < Minitest::Test
  def setup
    @client = LatestStockPrice::Client.new(
      api_key: "c609f6bd46mshb735106ebfd8376p183c99jsn8b65974a87bf"
    )
  end

  def test_any_endpoint
    response = @client.any
    assert(response.is_a?(Array), "Expected response to be an array")
    refute(response.empty?, "Expected response not to be empty")
  end

  def test_price_endpoint
    response = @client.price("BAJFINANCEEQN")
    assert(response.is_a?(Hash), "Expected response to be a hash")
    assert(response.key?("symbol"), "Expected response to include 'symbol'")
  end

  def test_prices_endpoint
    response = @client.prices(["BAJFINANCEEQN", "JSWSTEELEQN", "GRASIMEQN"])
    assert(response.is_a?(Array), "Expected response to be an array")
    assert(response.size > 1, "Expected response to include multiple stocks")
  end

  def test_price_all_endpoint
    response = @client.price_all
    assert(response.is_a?(Array), "Expected response to be an array")
    assert(response.any? { |stock| stock.key?("symbol") }, "Expected stocks to have 'symbol'")
  end
end
