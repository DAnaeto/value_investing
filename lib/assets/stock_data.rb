require_relative 'price_scraper'
require_relative 'fundamental_scraper'

stock = YahooFinancePriceScraper.new

puts stock.get_price('GOOGL')