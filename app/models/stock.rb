class Stock < ActiveRecord::Base
  attr_accessible :symbol, :win_percentage, :quotes_attributes
  has_many :quotes
  accepts_nested_attributes_for :quotes
  validates_uniqueness_of :symbol
end
