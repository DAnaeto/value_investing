require 'nokogiri'
require 'httparty'
require 'csv'

class FundamentalScraper
  def parse_stock_list
    stocks = CSV.open('lib/assets/stocks.csv', headers: true).map(&:to_h)
    return stocks
    # return stocks[0]['Name']
    # return stocks[0]['Sector']
  end
  def extract_statement_data(ticker)
    cash_flow = extract_cash_flow_statement(ticker)
    balance_sheet = extract_balance_sheet_data(ticker)
    income_statement = extract_income_statement_data(ticker)
  end

  def extract_cash_flow_statement(ticker)
    parsed_html_data = parse_html_data("https://finance.yahoo.com/quote/#{ticker}/cash-flow?p=#{ticker}")
  end

  def extract_balance_sheet_data(ticker)
    parsed_html_data = parse_html_data("https://finance.yahoo.com/quote/#{ticker}/balance-sheet?p=#{ticker}")
  end

  def extract_income_statement_data(ticker)
    parsed_html_data = parse_html_data("https://finance.yahoo.com/quote/#{ticker}/financials?p=#{ticker}")
  end
end

stock = FundamentalScraper.new

puts stock.parse_stock_list