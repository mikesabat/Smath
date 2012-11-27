class Quote < ActiveRecord::Base
    attr_accessible :date, :day_neg1_close, :day_neg1_open, :day_zero_close, :day_zero_open, :prediction, :stock_id, :win
    belongs_to :stock

    #should the stock model accept nested attributes for quotes - trying that instead
    #accepts_nested_attributes_for :stock

    before_save :lookup
    before_save :b_lookup
    before_save :price
    #before_save :correct
    # Can use correct method when need to correct data
    
  
    def correct
      self.gain_or_loss_percent = nil if gain_or_loss_percent != nil and prediction == 'fail'
        puts "T*!*!*!*!*!*"
      
    end
    
    def lookup
      
        YahooFinance::get_historical_quotes( stock.symbol,
                                      date,
                                      date ) do |row|
              
              self.day_zero_open = row[1]
              self.day_zero_close = row[4]        
        end        
        
    end

    def b_lookup
      d = date - 1.day 
      if d.wday.between?(1, 4)     

        YahooFinance::get_historical_quotes( stock.symbol,
                                      d,
                                      d ) do |row|
              
              self.day_neg1_open = row[1]
              self.day_neg1_close = row[4]

        end

      else
        false
      end
    end

    def price
      change = day_neg1_close - day_neg1_open
      percent_change = ((change / day_neg1_open) * 100).round(2).abs
      puts "Price method---Day -1 Open #{day_neg1_open}---Day -1 Close #{day_neg1_close}--Change #{change}-percent: #{percent_change}---"
      
      if percent_change > 1
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
          if prediction == "up" and day_zero_open > day_neg1_close
            self.win = true            
          elsif prediction == "down" and day_zero_open < day_neg1_close
            self.win = true
          else
            
          end
            # elsif prediction == "up" and day_zero_close < day_neg1_close
            #     self.win = false
            # elsif prediction == "down" and day_zero_close > day_neg1_close
            #     self.win = false
            # else
            #     #puts "-----*****-------"
               #self.win = true          
        end

        predict
        track
      else
          self.prediction = "fail" 
          self.win = 'nil'
      end
    end  
end
