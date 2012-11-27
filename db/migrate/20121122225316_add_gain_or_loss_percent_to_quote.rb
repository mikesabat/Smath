class AddGainOrLossPercentToQuote < ActiveRecord::Migration
  def change
    add_column :quotes, :gain_or_loss_percent, :decimal
  end
end
