class GetQuote
  attr_accessor :tickers, :tags, :tag_caption, :url

  def initialize(tickers, tags)
    @tickers, @tags, @tag_caption = tickers, tags, []
  end

  def call
    tag_translate
    create_url
    print_stocks
  end

  def create_url
    @url = "http://finance.yahoo.com/d/quotes.csv?s=#{tickers}&f=#{tags.join}"
  end

  def currency?(value)
    "#{value.include?('%') || !value.include?('.') ? '' : '$'}"
  end

  def print_stocks
    counter = 1
    open(url) do |csv|
      CSV.parse(csv) do |row|
        puts "\n\n"
        puts "#{row[0]}".center(45)
        puts " " + "-" * 42
        while counter < tag_caption.count 
          puts " #{tag_caption[counter]}: #{currency?(row[counter])}#{row[counter]}"
          counter += 1
         end
        counter = 1
      end
    end
  end

  def tag_translate
    tags.each do |tag|
      case tag
      when "N"
        tag_caption << "Name"
      when"A"
        tag_caption << "Asking price"
      when"P"
        tag_caption << "Previous close"
      when"O"
        tag_caption << "Open"
      when"T8"
        tag_caption << "1y Target price"
      when"M"
        tag_caption << "Days Range"
      when"W"
        tag_caption << "52 Week Range"
      when"V"
        tag_caption << "Volume"
      when"J1"
        tag_caption << "Market Cap"
      when "E"
        tag_caption << "Earnings per Share"
      when "D"
        tag_caption << "Dividend per Share"
      when "Y"
        tag_caption << "Dividend Yield"
      when "R"
        tag_caption << "P/E Ratio (Realtime)"
      when "M6"
        tag_caption << "Percent Change From 200 Day Moving Average"
      end
    end
  end
end 