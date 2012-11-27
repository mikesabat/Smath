class AddAverageUpsideToStock < ActiveRecord::Migration
  def change
    add_column :stocks, :average_upside, :decimal
    add_column :stocks, :average_dwonside, :decimal
  end
end
