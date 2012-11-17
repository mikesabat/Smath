class Stock < ActiveRecord::Base
  attr_accessible :symbol, :win_percentage, :Quarter_1_date, :quotes_attributes
  has_many :quotes, :dependent => :destroy
  accepts_nested_attributes_for :quotes
  validates_uniqueness_of :symbol
  before_save :percent
  before_save :calculate
  #before_save :sort



  def percent
  	win = quotes.where(:win => true).size
    failed_quotes = quotes.where(:prediction => 'fail').size
  	total = quotes.size - failed_quotes
  	if total > 0
  	  self.win_percentage = ((win.to_f / total)*100).round(2)
  	else
  	 self.win_percentage = 0
  	end
  end

  def calculate
    n = 5000
    d = quotes.sort_by {|q| q.date}
    d.each do |q|
      if q.prediction == "up"
        quantity = (n / q.day_neg1_close).to_i
        buy = quantity * q.day_neg1_close
        sell = quantity * q.day_zero_open
        pl = sell - buy        
        puts "UP ---Date: #{q.date} -- Bank: #{n} -- Day -1 Close: #{q.day_neg1_close} -- Quantity: #{quantity} -- Total Buy: #{buy} -- Day 0 Open: #{q.day_zero_open} -- Sell: #{sell} -- P/L: #{pl}" 
        n += pl                     
      elsif q.prediction == "down"
        quantity = (n / q.day_neg1_close).to_i
        sell = quantity * q.day_neg1_close
        buy = quantity * q.day_zero_open
        pl = sell - buy
        puts "DOWN ---Date: #{q.date} -- Bank: #{n} -- Day -1 Close: #{q.day_neg1_close} -- Quantity: #{quantity} -- Total Buy: #{buy} -- Day 0 Open: #{q.day_zero_open} -- Sell: #{sell} -- P/L: #{pl}" 
        n += pl
      else
      end
    end  
    puts "Our ending bank = #{n}"
    self.bank = n    
  end  

  def sort
    d = quotes.sort_by {|q| q.date}
    d.each do |q|
      puts "-------------------------#{q.date}"
    end
  end
  
end
