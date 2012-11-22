class AddRiskGainRatioToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :risk_gain_ratio, :decimal
  end
end
