class Stock < ActiveRecord::Base
  attr_accessible :symbol, :win_percentage, :Quarter_1_date, :quotes_attributes, :timing
  has_many :quotes, :dependent => :destroy
  accepts_nested_attributes_for :quotes
  validates_uniqueness_of :symbol
  before_save :percent
  before_save :calculate  
  before_save :ratio

  def ratio
    positives = []
    negatives = []
    quotes.all.each do |w|
      if w.gain_or_loss_percent.to_f > 0.0
        positives << w.gain_or_loss_percent
      elsif w.gain_or_loss_percent.to_f < 0.0
        negatives << w.gain_or_loss_percent
      else
      end      
    end
    puts "There are #{positives.size} gainful trades. *** #{positives.join( " || " )}"
    puts "There are #{negatives.size} un-gainful trades. *** #{negatives.join( " || " )}"
    total_plays = positives.size + negatives.size
    puts "------Total Plays for this stock = #{total_plays}--------"
    sum_positives = positives.inject(:+)
    puts "Sum Positive ==== #{sum_positives}"
    sum_negatives = negatives.inject(:+)
    puts "Sum of the negatives ===== #{sum_negatives}"
    if positives.size > 0
      self.average_upside = (sum_positives / positives.size).round(2)
    else
    end
    if negatives.size > 0
      self.average_dwonside = (sum_negatives / negatives.size).round(2)
    end
    self.risk_gain_ratio = average_upside.to_f + average_dwonside.to_f

  end

# percent function calculates the win loss percentage for up/down predictions
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

# calculate function plays on the stock and tracks the financial result of the investment. It goes through the cumulative $ win or loss on a stock, with a bank starting with $n - 5000 right now.
#I'm probably putting too much in this function. There are Quote attributes that never reach the quote model
  def calculate
    n = 5000
    d = quotes.sort_by {|q| q.date}
    d.each do |q|
      
      def quantify(x, q)
        quantity = (x / q.day_neg1_close).to_i
      end

      if q.prediction == "up"
        quantity = quantify(n, q)        
        buy = quantity * q.day_neg1_close
        sell = quantity * q.day_zero_open
        #pl is actually the profit or loss amount of the quote. We never push it to the quote model
        pl = sell - buy        
        puts "UP ---Date: #{q.date} -- Bank: #{n} -- Day -1 Close: #{q.day_neg1_close} -- Quantity: #{quantity} -- Total Buy: #{buy} -- Day 0 Open: #{q.day_zero_open} -- Sell: #{sell} -- P/L: #{pl}"
        q.gain_or_loss_percent = (((q.day_zero_open - q.day_neg1_close) / q.day_neg1_close) * 100).round(2)
        n += pl                     
      elsif q.prediction == "down"
        quantity = quantify(n, q)
        sell = quantity * q.day_neg1_close
        buy = quantity * q.day_zero_open
        pl = sell - buy
        puts "DOWN ---Date: #{q.date} -- Bank: #{n} -- Day -1 Close: #{q.day_neg1_close} -- Quantity: #{quantity} -- Total Buy: #{buy} -- Day 0 Open: #{q.day_zero_open} -- Sell: #{sell} -- P/L: #{pl}" 
        q.gain_or_loss_percent = (((q.day_neg1_close - q.day_zero_open) / q.day_neg1_close) * 100).round(2)
        n += pl
      else
      end
    end  
    puts "Our ending bank = #{n}"
    self.bank = n    
  end  
  def averages
    puts "This worked?"
  end  
end
