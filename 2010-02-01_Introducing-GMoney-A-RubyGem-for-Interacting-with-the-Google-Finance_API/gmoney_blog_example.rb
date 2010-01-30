require 'rubygems'
require 'gmoney'

GMoney::GFSession.login('<YOUR GOOGLE USER ID>', '<YOUR GOOGLE PASSWORD>')

##
# Create a new portfolio
##

portfolio = GMoney::Portfolio.new
portfolio.title = "My New Ruby Portfolio"
portfolio.save

##
# Buy some stocks
##
stocks = {"NASDAQ:GOOG" => 529.00, 
          "NASDAQ:AAPL" => 192.00, 
          "NYSE:RHT" => 27.00, 
          "NASDAQ:MSFT" => 28.00}

stocks.each do |symbol, price| 
  transaction = GMoney::Transaction.new
  #pid is the human readable id of the portfolio created above
  transaction.portfolio = portfolio.pid
  transaction.type = GMoney::BUY
  transaction.shares = 50
  transaction.ticker = symbol
  transaction.price = price  
  transaction.save
end

##
# Update the Google transaction to buy more shares
##

#I know the transaction id is '4'
transaction = GMoney::Transaction.find "#{portfolio.pid}/NASDAQ:GOOG/4"
transaction.shares = 100
transaction.save

##
# Delete the MSFT position
##

GMoney::Position.find("#{portfolio.pid}/NASDAQ:MSFT").delete

##
# Print out the remaning position titles
##

portfolio.positions.each do |position| 
  puts position.title
end
