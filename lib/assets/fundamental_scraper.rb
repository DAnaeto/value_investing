require 'nokogiri'
require 'httparty'

module Scrape
  def parse_html_data(url)
    unparsed_html_data = HTTParty.get(url)
    parsed_html_data = Nokogiri::HTML(unparsed_html_data.body)
    return parsed_html_data
  end

  def to_array(xpath_data)
    arr = []
    xpath_data.each{|amount| arr << amount.text.gsub(',', '').to_f}
    return arr
  end

  module CashFlow
    def parse_cash_flows(ticker)
      url = "https://stockanalysis.com/stocks/#{ticker}/financials/cash-flow-statement/"
      parsed_html_data = parse_html_data(url)
    end

    def calculate_equity(operating_cash_flow, capital_expenditure)
      operating_cash_flow.zip(capital_expenditure).map{|op, cap| op - cap}
    end

    def cash_flow_information(ticker)
      cash_flow = Hash.new
      parsed_html_data = parse_cash_flows(ticker)
      cash_flow[:op_cash_flow] = parse_operating_cash_flow(parsed_html_data, ticker)
      cash_flow[:cap_exp] = parse_capital_expenditures(parsed_html_data, ticker)
      cash_flow[:debt] = parse_debt(parsed_html_data, ticker)
      cash_flow[:income] = parse_income(parsed_html_data, ticker)
      cash_flow[:equity] = calculate_equity(cash_flow[:op_cash_flow], cash_flow[:cap_exp])
      return cash_flow
    end

    def parse_operating_cash_flow(parsed_html_data, ticker)
      op_cash_flow = []
      data = parsed_html_data.xpath('/html/body/div/div[1]/div/div[2]/main/div/div[2]/div[2]/div[2]/table/tbody/tr[5]/td')[1..10]
      op_cash_flow = to_array(data)
      return op_cash_flow
    end
    
    def parse_capital_expenditures(parsed_html_data, ticker)
      cap_exp = []
      data = parsed_html_data.xpath('/html/body/div/div[1]/div/div[2]/main/div/div[2]/div[2]/div[2]/table/tbody/tr[7]/td')[1..10]
      cap_exp = to_array(data)
      return cap_exp
    end

    def parse_debt(parsed_html_data, ticker)
      debt = []
      data = parsed_html_data.xpath('/html/body/div/div[1]/div/div[2]/main/div/div[2]/div[2]/div[2]/table/tbody/tr[14]/td')[1..10]
      debt = to_array(data)
      return debt
    end

    def parse_income(parsed_html_data, ticker)
      income = []
      data = parsed_html_data.xpath('/html/body/div/div[1]/div/div[2]/main/div/div[2]/div[2]/div[2]/table/tbody/tr[1]/td')[1..10]
      income = to_array(data)
      return income
    end
  end

  module BalanceSheet
    def parse_balance_sheet(ticker)
      url = "https://stockanalysis.com/stocks/#{ticker}/financials/balance-sheet/"
      parsed_html_data = parse_html_data(url)
    end

    def balance_sheet_information(ticker)
      parsed_html_data = parse_balance_sheet(ticker)
      return parse_net_cash_debt(parsed_html_data, ticker)
    end

    def parse_net_cash_debt(parsed_html_data, ticker)
      net_cash_debt = []
      data = parsed_html_data.xpath('/html/body/div/div[1]/div/div[2]/main/div/div[2]/div[2]/div[2]/table/tbody/tr[31]/td')[1..10]
      net_cash_debt = to_array(data)
      return net_cash_debt
    end
  end

  module Income
    def parse_income_statement(ticker)
      url = "https://stockanalysis.com/stocks/#{ticker}/financials/"
      parsed_html_data = parse_html_data(url)
    end

    def income_statement_information(ticker)
      parsed_html_data = parse_income_statement(ticker)
      parse_revenue(parsed_html_data, ticker)
    end

    def parse_revenue(parsed_html_data, ticker)
      net_cash_debt = []
      data = parsed_html_data.xpath('/html/body/div/div[1]/div/div[2]/main/div/div[2]/div[2]/div[2]/table/tbody/tr[1]/td')[1..10]
      revenue = to_array(data)
      return revenue
    end
  end
end