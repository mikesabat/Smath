class Stock < ActiveRecord::Base
  attr_accessible :symbol, :win_percentage, :quotes_attributes
  has_many :quotes
  accepts_nested_attributes_for :quotes
  validates_uniqueness_of :symbol
  before_save :percent


  def percent
  	win = quotes.where(:win => true).size
  	total = quotes.size
  	if total > 0
  	  self.win_percentage = ((win.to_f / total)*100).round(2)
  	else
  	 self.win_percentage = 0
  	end
  end
end
