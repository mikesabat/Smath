class AddBankToStock < ActiveRecord::Migration
  def change
    add_column :stocks, :bank, :decimal
  end
end
