require 'net/http'
require 'csv'

def download_csv_sp500
  url = 'https://datahub.io/core/s-and-p-500-companies/r/constituents.csv'
  File.write("lib/assets/stocks.csv", Net::HTTP.get(URI.parse(url)))
end


download_csv_sp500