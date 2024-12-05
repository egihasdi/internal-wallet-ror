require_relative "./client"

client = LatestStockPrice::Client.new(
  api_key: "c609f6bd46mshb735106ebfd8376p183c99jsn8b65974a87bf"
)

puts("Fetching stock price for JSWSTEELEQN:")
puts(client.price("JSWSTEELEQN"))

puts("Fetching prices for multiple stocks:")
puts(client.prices(["BAJFINANCEEQN", "JSWSTEELEQN", "GRASIMEQN"]))
