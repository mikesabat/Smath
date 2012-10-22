class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.text :symbol
      t.decimal :win_percentage

      t.timestamps
    end
  end
end
