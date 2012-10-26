class Quote < ActiveRecord::Base
    attr_accessible :date, :day_neg1_close, :day_neg1_open, :day_zero_close, :day_zero_open, :prediction, :stock_id, :win
    belongs_to :stock
    #should the stock model accept nested attributes for quotes - trying that instead
    #accepts_nested_attributes_for :stock

    before_save :lookup
    before_save :b_lookup
    before_save :predict
    before_save :track
    #before_save :ttt

    def ttt
      #@stock = Stock.find(params[:stock_id])
      self.prediction = stock.symbol
    end

    def lookup
        YahooFinance::get_historical_quotes( stock.symbol,
                                      date,
                                      date ) do |row|
              #puts "#{symbol},#{row.join(',')}"
              #puts "#{row[4]}"
              puts date
              puts "-----looking up day 0---------"
              self.day_zero_open = row[1]
              self.day_zero_close = row[4]

        end
    end

    def b_lookup
        #puts "----**-----"
        #puts date
        d = date - 1.day
        #puts d

        YahooFinance::get_historical_quotes( stock.symbol,
                                      d,
                                      d ) do |row|
              #puts "#{symbol},#{row.join(',')}"
              #puts "#{row[4]}"
              puts d
              puts "------looking up day neg 1--------"
              self.day_neg1_open = row[1]
              self.day_neg1_close = row[4]

        end
    end
  
    def predict 
        if day_neg1_close > day_neg1_open
            self.prediction = "up"
        elsif day_neg1_open > day_neg1_close
            self.prediction = "down"
        else
            self.prediction = "unknown"
        end
    end   

    def track
      if prediction == "up" and day_zero_close > day_neg1_close
        self.win = true
      elsif prediction == "down" and day_zero_close < day_neg1_close
        self.win = true
      else
        true
      end
        # elsif prediction == "up" and day_zero_close < day_neg1_close
        #     self.win = false
        # elsif prediction == "down" and day_zero_close > day_neg1_close
        #     self.win = false
        # else
        #     #puts "-----*****-------"
           #self.win = true
        
    end

end
