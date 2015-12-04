module StockResearch
  class StockResearch::CLI
    attr_accessor :tickers, :tags

    START_STOCKS = ["AAPL", "GOOG", "MSFT", "NFLX", "TSLA", "IBM", "AMZN", "EBAY", "SBUX", "FB"]
    
    def initialize 
      @tags = %w(N A P O T8 M W V J1)
    end

    def start
      list
      get_tickers
      get_tags
      GetQuote.new(tickers, tags).call
      start_over
     end

    def list
      puts "\n"
      puts "Most Popular Stocks".center(47)
      puts " " + "-" * 45
      puts "\n"
      START_STOCKS.each_with_index{ |stock, i| puts " #{i+1}. #{stock}" }
    end

    def get_tickers 
      puts "\nEnter the stock tickers you want more infomation on." 
      puts "Separate tickers with a space or comma"
      puts "(Enter 'exit' at any time to exit the program)\n\n"
      @tickers = gets.strip.scan(/\S[a-zA-Z]+/).join("+").upcase
      exit if tickers.include?("EXIT")
    end

    def get_tags
      puts "\nWe'll provide you with the basic information but please"
      puts "select any additional information you want to view."
      puts "Separate tags with a space or comma\n\n"
      puts " e  | Earnings per Share"
      puts " d  | Dividend per Share"
      puts " y  | Dividend Yield"
      puts " r  | P/E Ratio (Realtime)"
      puts " m6 | Percent Change From 200 Day Moving Average\n\n"
     
      (@tags << gets.strip.upcase.scan(/\S+/)).flatten!
      exit if @tags.include?("EXIT")
    end

    def start_over
      puts "\n\nWould you like to look up more stocks? ('y' or 'yes')\n"
      input = gets.strip.upcase
      StockResearch::CLI.new.start if input == "Y" || input == "YES"
    end
  end
end