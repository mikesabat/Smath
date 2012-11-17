class AddQuarter1DateToStock < ActiveRecord::Migration
  def change
    add_column :stocks, :Quarter_1_date, :date
  end
end
