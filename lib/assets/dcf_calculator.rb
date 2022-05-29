require_relative 'fundamental_scraper.rb'

include Scrape
include CashFlow
include BalanceSheet
include Income
include Price

# puts Scrape.cash_flow_information("CSCO")