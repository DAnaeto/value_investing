require 'nokogiri'
require 'httparty'

class YahooFinancePriceScraper
  
  def get_price(ticker)
    url = "https://finance.yahoo.com/quote/#{ticker}"
    parsed_html_data = parse_html_data(url)
    price = extract_price(parsed_html_data)
    return price
  end

  def parse_html_data(url)
    unparsed_html_data = HTTParty.get(url)
    parsed_html_data = Nokogiri::HTML(unparsed_html_data.body)
    return parsed_html_data
  end

  def extract_price(parsed_html_data)
    price_element = parsed_html_data.xpath('/html/body/div[1]/div/div/div[1]/div/div[2]/div/div/div[5]/div/div/div/div[3]/div[1]/div[1]/fin-streamer[1]')
    return price_element.text
  end
end

stock = YahooFinancePriceScraper.new

puts stock.get_price('GOOGL')